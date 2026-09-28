#!/usr/bin/env python3
"""Trazador recursivo Z80: separa codigo de datos siguiendo el flujo de control.

Desensamblar linealmente 40 KB de un juego no funciona: los graficos y las
tablas se decodifican como instrucciones y a partir de ahi todo queda
desalineado. Este trazador parte de unos puntos de entrada conocidos, sigue
saltos y llamadas, y marca que bytes son alcanzables como codigo. Lo que no se
alcanza se trata como datos.

Salida: un fichero de bloques para z80dasm (-b) y un informe de cobertura.

Limitacion conocida y deliberada: los saltos indirectos (JP (HL), tablas de
saltos, direcciones metidas en la pila) no se pueden seguir estaticamente. El
trazador los marca como PUNTO CIEGO y hay que darle esos destinos a mano por el
fichero de entradas. Por eso el informe lista cada punto ciego con su direccion.
"""
import json
import os
import sys

# ---------------------------------------------------------------- tablas Z80

# Longitud en bytes de cada opcode sin prefijo.
BASE_LEN = [1] * 256
for _op, _n in {
    0x01: 3, 0x11: 3, 0x21: 3, 0x31: 3,          # LD rr,nn
    0x22: 3, 0x2A: 3, 0x32: 3, 0x3A: 3,          # LD (nn),HL / A ...
    0x06: 2, 0x0E: 2, 0x16: 2, 0x1E: 2,          # LD r,n
    0x26: 2, 0x2E: 2, 0x36: 2, 0x3E: 2,
    0x10: 2, 0x18: 2, 0x20: 2, 0x28: 2,          # DJNZ / JR
    0x30: 2, 0x38: 2,
    0xC6: 2, 0xCE: 2, 0xD6: 2, 0xDE: 2,          # ALU A,n
    0xE6: 2, 0xEE: 2, 0xF6: 2, 0xFE: 2,
    0xD3: 2, 0xDB: 2,                            # OUT (n),A / IN A,(n)
    0xC2: 3, 0xC3: 3, 0xC4: 3, 0xCA: 3, 0xCC: 3, 0xCD: 3,
    0xD2: 3, 0xD4: 3, 0xDA: 3, 0xDC: 3,
    0xE2: 3, 0xE4: 3, 0xEA: 3, 0xEC: 3,
    0xF2: 3, 0xF4: 3, 0xFA: 3, 0xFC: 3,
}.items():
    BASE_LEN[_op] = _n

# ED xx: 2 bytes salvo los LD (nn),rr / LD rr,(nn) que son 4.
ED_LEN4 = {0x43, 0x53, 0x63, 0x73, 0x4B, 0x5B, 0x6B, 0x7B}

# Opcodes que referencian (HL) y que con prefijo DD/FD pasan a (IX+d)/(IY+d),
# ganando un byte de desplazamiento.
IDX_DISP = ({0x34, 0x35, 0x36}
            | {0x46, 0x4E, 0x56, 0x5E, 0x66, 0x6E, 0x7E}
            | {0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x77}
            | {0x86, 0x8E, 0x96, 0x9E, 0xA6, 0xAE, 0xB6, 0xBE})

JP_CC = {0xC2, 0xCA, 0xD2, 0xDA, 0xE2, 0xEA, 0xF2, 0xFA}
CALL_CC = {0xC4, 0xCC, 0xD4, 0xDC, 0xE4, 0xEC, 0xF4, 0xFC}
JR_CC = {0x20, 0x28, 0x30, 0x38}
RET_CC = {0xC0, 0xC8, 0xD0, 0xD8, 0xE0, 0xE8, 0xF0, 0xF8}
RST = {0xC7: 0x00, 0xCF: 0x08, 0xD7: 0x10, 0xDF: 0x18,
       0xE7: 0x20, 0xEF: 0x28, 0xF7: 0x30, 0xFF: 0x38}

CODE, DATA = 1, 0


class Tracer:
    def __init__(self, data, org, rst_follow=True, nocode=(), saltos=None):
        # saltos: {direccion_llamada: n} -> tras un CALL a esa direccion, los n
        # bytes siguientes son PARAMETROS EN LINEA (la rutina hace `pop hl` y
        # los lee), no codigo: se marcan como datos y el flujo sigue detras.
        # Konami lo usa en varios de sus cartuchos; un trazador que siga de
        # largo se los traga como instrucciones. En este cartucho no aparece: aqui
        # el que hay que declarar es el despachador 0x4067, que lleva la tabla
        # -no unos parametros- pegada detras del call, y eso se resuelve con
        # el fichero .nocode.
        self.saltos = dict(saltos or {})
        self.params = []                       # (ini, fin) de parametros en linea
        self.data = data
        self.org = org
        self.end = org + len(data)
        self.mark = bytearray(len(data))       # 1 = byte de codigo
        self.starts = set()                    # inicios de instruccion
        self.entries = set()                   # destinos de call/jp (etiquetas)
        self.blind = []                        # saltos indirectos no seguibles
        # Saltos y llamadas a direcciones FUERA del binario. En un cartucho de
        # 16 KB son llamadas a la BIOS; en un MegaROM trazado pagina a pagina
        # son las llamadas a OTRA pagina, y hay que saber cual estaba mapeada
        # para sembrarla a mano: por eso se guardan (origen, destino).
        self.externos = []
        self.rst_follow = rst_follow
        self.rechazados = []                   # semillas que caian en datos

        # Zonas que sabemos a ciencia cierta que son datos (graficos, textos,
        # tablas). El trazador no entra en ellas.
        #
        # Hace falta porque un solo destino mal deducido -de una tabla de
        # punteros, por ejemplo- mete al trazador en una zona de graficos, y
        # desde ahi sigue "decodificando" pixeles como instrucciones sin parar.
        # Sin esta barrera el trazado pasaba del 13% al 80%, pero marcando como
        # codigo el 100% de la tabla de colores y de los textos: cobertura falsa.
        self.nocode = bytearray(len(data))
        for a, b in nocode:
            for i in range(max(0, a - org), min(len(data), b - org)):
                self.nocode[i] = 1

    def inside(self, a):
        return self.org <= a < self.end

    def es_datos(self, a):
        return self.inside(a) and self.nocode[a - self.org]

    def byte(self, a):
        return self.data[a - self.org]

    def word(self, a):
        return self.byte(a) | (self.byte(a + 1) << 8)

    def ilen(self, a):
        """Longitud de la instruccion en a. Devuelve 0 si no cabe entera.

        Que devuelva 0 cuando la instruccion se sale del binario importa: si
        devolviera su longitud nominal, quien la use para avanzar leeria bytes
        que no existen. Los llamadores de dentro ya lo comprobaban aparte, pero
        la funcion tiene que ser correcta por si sola.
        """
        n = self._ilen_bruto(a)
        return n if n and self.inside(a + n - 1) else 0

    def _ilen_bruto(self, a):
        """Longitud segun el opcode, sin mirar si cabe."""
        if not self.inside(a):
            return 0
        op = self.byte(a)
        if op == 0xCB:
            return 2
        if op == 0xED:
            if not self.inside(a + 1):
                return 0
            return 4 if self.byte(a + 1) in ED_LEN4 else 2
        if op in (0xDD, 0xFD):
            if not self.inside(a + 1):
                return 0
            op2 = self.byte(a + 1)
            if op2 == 0xCB:
                return 4
            if op2 in (0xDD, 0xFD, 0xED):     # prefijo redundante: 1 byte
                return 1
            return 1 + BASE_LEN[op2] + (1 if op2 in IDX_DISP else 0)
        return BASE_LEN[op]

    def trace(self, entry_list):
        buenas = [a for a in entry_list if not self.es_datos(a)]
        self.rechazados = [a for a in entry_list if self.es_datos(a)]
        work = list(buenas)
        self.entries.update(a for a in buenas if self.inside(a))
        while work:
            pc = work.pop()
            while True:
                if not self.inside(pc) or self.es_datos(pc):
                    break
                off = pc - self.org
                if self.mark[off] and pc in self.starts:
                    break                      # ya trazado desde aqui
                n = self.ilen(pc)
                if n == 0 or pc + n > self.end:
                    break
                self.starts.add(pc)
                for i in range(n):
                    self.mark[off + i] = CODE
                op = self.byte(pc)
                nxt = pc + n
                stop = False

                if op == 0xC3:                             # JP nn
                    t = self.word(pc + 1); self._add(t, work, pc); stop = True
                elif op in JP_CC:
                    self._add(self.word(pc + 1), work, pc)
                elif op == 0xCD:                           # CALL nn
                    t = self.word(pc + 1)
                    self._add(t, work, pc)
                    if t in self.saltos:
                        k = self.saltos[t]
                        self.params.append((nxt, nxt + k))
                        nxt = nxt + k
                elif op in CALL_CC:
                    self._add(self.word(pc + 1), work, pc)
                elif op == 0x18:                           # JR e
                    self._add(nxt + self._s8(self.byte(pc + 1)), work); stop = True
                elif op in JR_CC or op == 0x10:            # JR cc,e / DJNZ
                    self._add(nxt + self._s8(self.byte(pc + 1)), work)
                elif op == 0xC9:                           # RET
                    stop = True
                elif op == 0xE9:                           # JP (HL)
                    self.blind.append((pc, "JP (HL)")); stop = True
                elif op in (0xDD, 0xFD) and self.inside(pc + 1) and self.byte(pc + 1) == 0xE9:
                    self.blind.append((pc, "JP (IX/IY)")); stop = True
                elif op == 0xED and self.inside(pc + 1) and self.byte(pc + 1) in (0x45, 0x4D):
                    stop = True                            # RETN / RETI
                # OJO: HALT (0x76) NO corta el flujo. Espera a la siguiente
                # interrupcion y sigue en la instruccion de despues; los juegos
                # lo usan para sincronizar con el barrido de pantalla. Tratarlo
                # como fin de rutina dejaba el trazado en el 2% de cobertura.
                elif op in RST:
                    if self.rst_follow and self.inside(RST[op]):
                        self._add(RST[op], work)
                # RET cc y los CALL/JP condicionales continuan en nxt

                if stop:
                    break
                pc = nxt

    def _add(self, target, work, pc=None):
        if not self.inside(target):
            if pc is not None:
                self.externos.append((pc, target))
            return
        if not self.es_datos(target):
            self.entries.add(target)
            if not (self.mark[target - self.org] and target in self.starts):
                work.append(target)

    @staticmethod
    def _s8(b):
        return b - 256 if b > 127 else b

    def blocks(self):
        """Regiones contiguas [(tipo, ini, fin)] con tipo 'c' o 'd'."""
        out = []
        cur = self.mark[0]
        start = self.org
        for i in range(1, len(self.mark)):
            if self.mark[i] != cur:
                out.append(("c" if cur else "d", start, self.org + i))
                cur = self.mark[i]
                start = self.org + i
        out.append(("c" if cur else "d", start, self.end))
        return out

    def report(self):
        n = sum(self.mark)
        return dict(code_bytes=n, data_bytes=len(self.mark) - n,
                    coverage=n / len(self.mark),
                    instructions=len(self.starts),
                    labels=len(self.entries),
                    blind_jumps=len(self.blind))


def write_z80dasm_blocks(blocks, path):
    """Fichero -b de z80dasm. Formato: '<inicio> <tipo> <fin>' por linea."""
    with open(path, "w") as f:
        for kind, a, b in blocks:
            f.write(f"{a:#06x} {'code' if kind=='c' else 'defb'} {b-1:#06x}\n")


def main():
    binpath, org, entries_path, outprefix = sys.argv[1:5]
    org = int(org, 0)
    data = open(binpath, "rb").read()
    entries = []
    saltos = {}
    for ln in open(entries_path):
        ln = ln.split("#")[0].strip()
        if not ln:
            continue
        if ln.lower().startswith("!skip"):
            # !skip 0x5F65 6  -> tras cada CALL 0x5F65, 6 bytes de parametros
            _, a, n = ln.split()[:3]
            saltos[int(a, 0)] = int(n, 0)
            continue
        entries.append(int(ln.split()[0], 0))

    nocode = []
    ncpath = outprefix.replace("work/", "src/") + ".nocode"
    if len(sys.argv) > 5:
        ncpath = sys.argv[5]
    if os.path.exists(ncpath):
        for ln in open(ncpath):
            ln = ln.split("#")[0].strip()
            if ln:
                a, b = ln.split()[:2]
                nocode.append((int(a, 0), int(b, 0)))
        print(f"zonas declaradas como datos: {len(nocode)} (de {ncpath})")

    t = Tracer(data, org, nocode=nocode, saltos=saltos)
    t.trace(entries)
    blocks = t.blocks()
    if t.params:
        print(f"parametros en linea saltados tras CALL: {len(t.params)} sitios, "
              f"{sum(b - a for a, b in t.params)} bytes")
    write_z80dasm_blocks(blocks, outprefix + ".blocks")

    r = t.report()
    with open(outprefix + ".trace.json", "w") as f:
        json.dump(dict(report=r,
                       entries=sorted(t.entries),
                       blind=[[hex(a), k] for a, k in t.blind],
                       params=[[a, b] for a, b in t.params],
                       externos=[[a, b] for a, b in t.externos],
                       blocks=[[k, a, b] for k, a, b in blocks]), f, indent=1)

    print(f"binario {binpath}  org={org:#06x}  {len(data)} bytes")
    print(f"  codigo    : {r['code_bytes']} bytes ({r['coverage']*100:.1f}%)")
    print(f"  datos     : {r['data_bytes']} bytes")
    print(f"  instrucc. : {r['instructions']}")
    print(f"  etiquetas : {r['labels']}")
    print(f"  regiones  : {len(blocks)}")
    if t.rechazados:
        print(f"  semillas RECHAZADAS por caer en zona de datos: {len(t.rechazados)}")
        for a in t.rechazados[:10]:
            print(f"      {a:#06x}")
    print(f"  llamadas/saltos fuera del binario: {len(t.externos)} "
          f"({len(set(b for _, b in t.externos))} destinos distintos)")
    print(f"  PUNTOS CIEGOS (saltos indirectos, hay que resolverlos a mano): "
          f"{r['blind_jumps']}")
    for a, k in t.blind[:20]:
        print(f"      {a:#06x}  {k}")
    if len(t.blind) > 20:
        print(f"      ... y {len(t.blind)-20} mas (ver {outprefix}.trace.json)")


if __name__ == "__main__":
    main()
