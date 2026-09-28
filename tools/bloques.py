#!/usr/bin/env python3
"""Declara los bloques de datos que el codigo LEE, recorriendolos como el cartucho.

Un rango de datos no se declara porque sobre: se declara porque hay una
instruccion que lo lee. Casi siempre es una llamada a uno de los lectores del
banco 0, y el trazador de cartucho entero (tools/bancos.py) sabe, para cada
llamada, que valen HL y DE y que bancos hay en cada ranura. Con eso:

  1. se coge el puntero que el lector va a leer;
  2. el banco al que cae sale del reparto de ese momento, no de suponerlo;
  3. el final sale de RECORRER el formato como lo recorre el lector, o de la
     cuenta que le pasa quien llama (B, BC), leida en el listado.

Los lectores del banco 0 (todos escriben en la VRAM del V9938, SCREEN 5):

  dibujos  0x4A66  HL fuente, B dibujos de 8x8 a 4 bits: 32 bytes cada uno.
                   0x4A51 sube uno: ocho filas de 4 bytes, saltando 128 en
                   la VRAM, que es lo que mide una linea en SCREEN 5.
  letras   0x4A27  HL fuente, B caracteres de 8x8 a 1 bit (8 bytes cada uno);
                   0x4AA5 los pinta de color al vuelo. 0x4A30 hace uno solo.
  rle      0x46F1  DE fuente (HL ya trae el destino): 0x00 acaba; 0x80 da
                   otro destino (dos bytes, por 0x46EB); bit 7 puesto, van tal
                   cual los siete de abajo; bit 7 claro, se repite el byte
                   que viene esas veces.
           0x46EB  lo mismo, pero el destino va delante.
  guion    0x4714  HL fuente, mandos: 0xFF acaba; 0x00 [fuente][destino] es
                   un rle aparte (0x472E: DE la fuente, HL el destino); 0x01 [origen][n][destino] da la vuelta a n
                   dibujos que YA estan en la VRAM (no lee cartucho); lo demas
                   es [fuente][largo][destino], copia en crudo por 0x4675.
  crudo    0x4675  HL fuente, BC bytes tal cual (DE es el destino en VRAM).

Lo que sale se escribe, banco a banco, en una seccion delimitada de
src/pNN.notes que esta herramienta reescribe entera; lo de fuera no lo toca.
Un bloque que pise codigo trazado o una D escrita a mano NO se escribe: se
avisa, porque algo esta mal y hay que mirarlo.

Uso: bloques.py              informa de lo que encontraria
     bloques.py --escribe    y lo escribe en las notas
"""
import json
import os
import re
import sys
from collections import defaultdict

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from bancos import traza_completa, Cartucho                  # noqa: E402
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre        # noqa: E402

ROM = os.path.join(RAIZ, "vampirekiller.rom")
SRC = os.path.join(RAIZ, "src")
WORK = os.path.join(RAIZ, "work")

INI = "# --- BLOQUES QUE LEE EL CODIGO (seccion que reescribe tools/bloques.py; no editar a mano) ---"
FIN = "# --- fin de los bloques de bloques.py ---"


class FueraDelBanco(Exception):
    pass


def banco_de(a, s):
    b = Cartucho.banco(a, s)
    if b is None or b >= N_PAGINAS:
        raise FueraDelBanco("0x%04X no cae en el cartucho con %s" % (a, s))
    return b


def byte(rom, s, a):
    return rom[banco_de(a, s) * TAM_PAGINA + (a & 0x1FFF)]


def palabra(rom, s, a):
    return byte(rom, s, a) | (byte(rom, s, a + 1) << 8)


def trozos(s, a, f):
    """[a, f) de la ventana del Z80, partido por bancos: [(banco, ini, fin)]."""
    fuera = []
    while a < f:
        corte = min(f, (a & 0xE000) + TAM_PAGINA)
        fuera.append((banco_de(a, s), a, corte))
        a = corte
    return fuera


# ------------------------------------------------------------------ registro
class Bloques:
    """{banco: {(ini, fin): {"nom", "que", "desde": set, "ancho"}}}"""

    def __init__(self):
        self.d = defaultdict(dict)
        self.avisos = []

    def anota(self, s, a, f, nom, que, quien, ancho=16):
        if a < 0xC000 < f:
            # p00:54E4: el ultimo dibujo se sale del cartucho y lo que falta
            # lo lee de la RAM de 0xC000 en adelante
            que += "; se sale de la ventana del cartucho: los ultimos %d bytes los lee "                    "de la RAM, de 0xC000 a 0x%04X" % (f - 0xC000, f - 1)
            f = 0xC000
        for b, i, j in trozos(s, a, f):
            e = self.d[b].setdefault((i, j), {"nom": nom if i == a else "%s_cola" % nom,
                                              "que": que, "desde": set(), "ancho": ancho})
            e["desde"].add(quien)
            if i != a:
                e["que"] = "%s (sigue del banco anterior, 0x%04X)" % (que, a)


# ------------------------------------------------------------------ listado
_LISTADO = {}


def listado(p):
    """[(dir, texto)] de las instrucciones del listado del banco p."""
    if p not in _LISTADO:
        ruta = os.path.join(SRC, "vampirekiller_p%02d.asm" % p)
        filas = []
        for ln in open(ruta, encoding="utf-8"):
            m = re.match(r"\t([a-z][^\t;]*)\t+;([0-9a-f]{4})", ln)
            if m:
                filas.append((int(m.group(2), 16), m.group(1).strip()))
        _LISTADO[p] = filas
    return _LISTADO[p]


def num(txt):
    txt = txt.strip()
    if txt.endswith("h"):
        return int(txt[:-1], 16)
    return int(txt, 0)


def registro_antes(p, pc, reg, hasta=10):
    """El valor constante de B, C o BC cargado justo antes de pc, o None.

    Se miran hacia atras las instrucciones del listado; si alguna otra toca el
    registro antes de encontrar su `ld`, no se sabe.
    """
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    for a, t in reversed(filas[max(0, idx - hasta):idx]):
        if t.startswith(("call", "jp", "jr", "ret", "djnz")):
            return None
        m = re.match(r"ld (bc|b|c),([0-9a-f]+h|\d+)$", t)
        if m:
            r, v = m.group(1), num(m.group(2))
            if r == reg:
                return v
            if r == "bc":
                return {"b": v >> 8, "c": v & 0xFF}.get(reg)
            continue
        if re.match(r"(ld|inc|dec|pop|ex|exx|add|sub|and|or|xor)\b.*\b%s\b" % reg[0], t) and reg != "bc":
            if re.match(r"ld [^,]+,%s$" % reg, t):
                continue            # solo lo lee
            return None
    return None


def tabla_antes(p, pc):
    """Si pc lee su puntero de una tabla indexada, la base de esa tabla.

    El patron es el de siempre en este cartucho: `ld hl,TABLA / call 0x4061
    (hl += a) / ld e,(hl) / inc hl / ld d,(hl)` y, a lo sumo, un `ld hl,nn`
    o `ex de,hl` antes del lector.
    """
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    txt = [t for _, t in filas[max(0, idx - 8):idx]]
    for k in range(len(txt) - 4):
        m = re.match(r"ld hl,([0-9a-f]+h)$", txt[k])
        if m and txt[k + 1] in ("call L_4061", "call 04061h") and txt[k + 2] == "ld e,(hl)"                 and txt[k + 3] == "inc hl" and txt[k + 4] == "ld d,(hl)":
            return num(m.group(1))
    return None


def punteros_de_tabla(rom, s, base, limite=None):
    """Las palabras de una tabla de punteros: hasta el primer destino, hasta una
    palabra que no apunte a la ventana del cartucho, o hasta `limite`."""
    ptrs, a = [], base
    tope = limite or base + 512
    while a < tope:
        w = palabra(rom, s, a)
        if not 0x4000 <= w < 0xC000:
            break
        ptrs.append(w)
        a += 2
        if base < min(ptrs) <= a + 1:
            break
        tope = min(tope, min(p for p in ptrs if p > base) if any(p > base for p in ptrs) else tope)
    return ptrs


# ------------------------------------------------------------------ formatos
def fin_rle(rom, s, a, con_destino):
    """Recorre un rle como 0x46EB/0x46F1 y devuelve el primer byte de fuera."""
    if con_destino:
        a += 2
    for _ in range(20000):
        n = byte(rom, s, a)
        a += 1
        if n == 0:
            return a
        if n & 0x80:
            k = n & 0x7F
            a += 2 if k == 0 else k
        else:
            a += 1
    raise FueraDelBanco("rle sin fin desde 0x%04X" % a)


def recorre_guion(rom, s, a, bl, quien, nom):
    """El guion de 0x4714: anota el guion y lo que manda leer."""
    ini = a
    for _ in range(500):
        m = byte(rom, s, a)
        a += 1
        if m == 0xFF:
            break
        if m == 0x00:
            fuente, dest = palabra(rom, s, a), palabra(rom, s, a + 2)
            a += 4
            f = fin_rle(rom, s, fuente, False)
            bl.anota(s, fuente, f, "rle_%04X" % fuente,
                     "rle a la VRAM 0x%04X, mandado por el guion de 0x%04X" % (dest, ini),
                     "guion 0x%04X" % ini)
        elif m == 0x01:
            a += 5
        else:
            fuente, largo, dest = palabra(rom, s, a), palabra(rom, s, a + 2), palabra(rom, s, a + 4)
            a += 6
            bl.anota(s, fuente, fuente + largo, "crudo_%04X" % fuente,
                     "%d bytes tal cual a la VRAM 0x%04X, mandados por el guion de 0x%04X"
                     % (largo, dest, ini), "guion 0x%04X" % ini)
    bl.anota(s, ini, a, nom, "guion de carga de la VRAM que interpreta 0x4714 (0xFF acaba)", quien)


# ------------------------------------------------------------------ recorridos
def dibujos_de_cada_fase(rom, t, bl):
    """p00:5657: la tabla de 0x5742 da, por fase, de donde salen sus 191 dibujos.

    0x564C pone los bancos 4-5-6 y, desde la fase 13 (`cp 0x0D / call nc`), el
    7 y el 8 en 0x8000 y 0xA000. Luego `ld de,0x8004 / ld b,0xBF / call 0x4A66`.
    """
    base = 0x5742
    s0 = (1, 2, 3)
    ptrs = [palabra(rom, s0, base + 2 * i) for i in range(19)]
    bl.anota(s0, base, base + 38, "dibujos_de_cada_fase",
             "19 punteros, uno por fase (0 el patio, 1-18): de donde salen los 191 dibujos "
             "de 8x8 de su decorado; los lee p00:565B con la fase de 0xD000", "p00:565B")
    for fase, w in enumerate(ptrs):
        s = (4, 5, 6) if fase < 13 else (4, 7, 8)
        bl.anota(s, w, w + 191 * 32, "dibujos_%04X" % w,
                 "191 dibujos de 8x8 a 4 bits (32 bytes cada uno) del decorado",
                 "fase %d" % fase, ancho=32)
    # p00:5670 entra en la misma subida con los bancos 9 y 10 y HL=0x8000
    # (`call 0x537A / ld hl,0x8000 / jr 0x5665`)
    bl.anota((1, 9, 10), 0x8000, 0x8000 + 191 * 32, "dibujos_8000",
             "191 dibujos de 8x8 a 4 bits (32 bytes cada uno) que sube p00:5670 por el "
             "mismo camino que los de las fases", "p00:5670", ancho=32)


LECTORES = {
    0x4A66: ("dibujos", "hl"),
    0x4A27: ("letras", "hl"),
    0x4A30: ("letra", "hl"),
    0x46F1: ("rle", "de"),
    0x46EB: ("rle_dest", "de"),
    0x4714: ("guion", "hl"),
    0x4675: ("crudo", "hl"),
    0x4A90: ("dibujos16", "hl"),
    0x498A: ("hmmc", "hl"),
}
# Los lectores se llaman entre ellos: esas llamadas no traen un puntero nuevo.
DENTRO_DE_LOS_LECTORES = (0x4600, 0x4800)
DENTRO_2 = (0x4A00, 0x4AD0)


def llamadas_a_lectores(rom, t, bl):
    # primero las bases de todas las tablas indexadas: una acaba donde empieza
    # la siguiente (0xA281 y 0xA2D1 van pegadas)
    bases = sorted({tabla_antes(b, pc) for dest, b, pc, s, hl, de in t.llamadas
                    if dest in LECTORES} - {None})
    for dest, b, pc, s, hl, de in t.llamadas:
        if dest not in LECTORES or b != 0 and False:
            continue
        if b == 0 and (DENTRO_DE_LOS_LECTORES[0] <= pc < DENTRO_DE_LOS_LECTORES[1]
                       or DENTRO_2[0] <= pc < DENTRO_2[1]):
            continue
        fmt, reg = LECTORES[dest]
        quien = "%s:%04X" % (nombre(b), pc)
        ptr = hl if reg == "hl" else de
        if ptr is not None and ptr >= 0xC000:
            continue                # la fuente esta en RAM: no es del cartucho
        if ptr is None:
            base = tabla_antes(b, pc)
            if base is None or fmt not in ("rle", "rle_dest", "guion"):
                if (b, pc) not in DE_LOS_RECORRIDOS:
                    bl.avisos.append("%s -> %s: puntero sin saber" % (quien, fmt))
                continue
            try:
                sig = [x for x in bases if x > base and (x & 0xE000) == (base & 0xE000)]
                ptrs = punteros_de_tabla(rom, s, base, sig[0] if sig else None)
                bl.anota(s, base, base + 2 * len(ptrs), "tabla_%04X" % base,
                         "%d punteros a %s que lee %s" % (len(ptrs), fmt, quien), quien, ancho=2)
                for w in sorted(set(ptrs)):
                    if fmt == "guion":
                        recorre_guion(rom, s, w, bl, quien, "guion_%04X" % w)
                    else:
                        bl.anota(s, w, fin_rle(rom, s, w, fmt == "rle_dest"), "rle_%04X" % w,
                                 "rle a la VRAM, de la tabla de 0x%04X" % base, quien)
            except FueraDelBanco as e:
                bl.avisos.append("%s -> %s tabla 0x%04X: %s" % (quien, fmt, base, e))
            continue
        try:
            if fmt == "dibujos":
                n = registro_antes(b, pc, "b")
                if n is None:
                    bl.avisos.append("%s -> dibujos 0x%04X: B sin saber" % (quien, ptr))
                    continue
                bl.anota(s, ptr, ptr + 32 * n, "dibujos_%04X" % ptr,
                         "%d dibujos de 8x8 a 4 bits (32 bytes cada uno)" % n, quien, ancho=32)
            elif fmt == "dibujos16":
                n = registro_antes(b, pc, "b")
                if n is None:
                    bl.avisos.append("%s -> dibujos16 0x%04X: B sin saber" % (quien, ptr))
                    continue
                bl.anota(s, ptr, ptr + 128 * n, "dibujos16_%04X" % ptr,
                         "%d dibujos de 16x16 a 4 bits (128 bytes cada uno, 0x4A7B los sube "
                         "en dieciseis filas de 8)" % n, quien, ancho=8)
            elif fmt == "hmmc":
                bc = registro_antes(b, pc, "bc")
                if bc is None:
                    bl.avisos.append("%s -> hmmc 0x%04X: BC sin saber" % (quien, ptr))
                    continue
                n = (bc >> 8) * (bc & 0xFF) // 2
                bl.anota(s, ptr, ptr + n, "hmmc_%04X" % ptr,
                         "%dx%d puntos a 4 bits (%d bytes) que 0x498A manda al V9938 con una "
                         "orden HMMC" % (bc >> 8, bc & 0xFF, n), quien, ancho=8)
            elif fmt == "letras":
                n = registro_antes(b, pc, "b")
                if n is None:
                    bl.avisos.append("%s -> letras 0x%04X: B sin saber" % (quien, ptr))
                    continue
                bl.anota(s, ptr, ptr + 8 * n, "letras_%04X" % ptr,
                         "%d caracteres de 8x8 a 1 bit (8 bytes cada uno) que 0x4AA5 pinta "
                         "de color al subirlos" % n, quien, ancho=8)
            elif fmt == "letra":
                bl.anota(s, ptr, ptr + 8, "letra_%04X" % ptr,
                         "un caracter de 8x8 a 1 bit", quien, ancho=8)
            elif fmt in ("rle", "rle_dest"):
                f = fin_rle(rom, s, ptr, fmt == "rle_dest")
                bl.anota(s, ptr, f, "rle_%04X" % ptr,
                         "rle a la VRAM (0x00 acaba, 0x80 otro destino, 1nnnnnnn van tal cual, "
                         "0nnnnnnn repite el que viene)%s" % (", con el destino delante"
                                                               if fmt == "rle_dest" else ""),
                         quien)
            elif fmt == "guion":
                recorre_guion(rom, s, ptr, bl, quien, "guion_%04X" % ptr)
            elif fmt == "crudo":
                n = registro_antes(b, pc, "bc")
                if n is None:
                    bl.avisos.append("%s -> crudo 0x%04X: BC sin saber" % (quien, ptr))
                    continue
                bl.anota(s, ptr, ptr + n, "crudo_%04X" % ptr,
                         "%d bytes tal cual a la VRAM" % n, quien)
        except FueraDelBanco as e:
            bl.avisos.append("%s -> %s 0x%04X: %s" % (quien, fmt, ptr, e))


def fin_paleta(rom, s, a):
    """0x483E: [color][RB][G] hasta un 0xFF."""
    for _ in range(17):
        if byte(rom, s, a) == 0xFF:
            return a + 1
        a += 3
    raise FueraDelBanco("paleta sin 0xFF en 0x%04X" % a)


def habitaciones(rom, t, bl):
    """p00:5783: lo que se carga al entrar en cada habitacion.

    Con los bancos 9 y 10 puestos, 0x9AB0 tiene un puntero por fase (1-18) a
    una subtabla con una entrada de cuatro bytes por habitacion (0xD001):
    [guion de 0x4714][paleta de 0x483E]. Las subtablas van seguidas, asi que
    cada una acaba donde empieza la siguiente, y la ultima donde empieza el
    primer guion. La fase 0 no pasa por aqui: p00:57B7 carga el guion de
    0x9FED y nada mas.
    """
    s = (1, 9, 10)
    base = 0x9AB0
    ptrs = [palabra(rom, s, base + 2 * i) for i in range(18)]
    bl.anota(s, base, base + 36, "habitaciones_de_cada_fase",
             "18 punteros, uno por fase (1-18), a su tabla de habitaciones; los lee p00:5790",
             "p00:5786")
    guiones = set()
    paletas = set()
    # la ultima subtabla acaba donde empieza el primer guion de las de antes
    primer_guion = min(palabra(rom, s, a) for a in range(ptrs[0], ptrs[-1], 4))
    for i, w in enumerate(ptrs):
        fin = ptrs[i + 1] if i + 1 < len(ptrs) else primer_guion
        n = (fin - w) // 4
        bl.anota(s, w, fin, "habitaciones_fase_%d" % (i + 1),
                 "las %d habitaciones de la fase %d: [guion de 0x4714][paleta de 0x483E] "
                 "por habitacion (0xD001)" % (n, i + 1), "p00:5794", ancho=4)
        for k in range(n):
            guiones.add(palabra(rom, s, w + 4 * k))
            paletas.add(palabra(rom, s, w + 4 * k + 2))
    for g in sorted(guiones):
        recorre_guion(rom, s, g, bl, "p00:57A5 (habitacion)", "guion_%04X" % g)
    for pa in sorted(paletas):
        bl.anota(s, pa, fin_paleta(rom, s, pa), "paleta_%04X" % pa,
                 "cambios de paleta ([color][RB][G], 0xFF acaba) que pone 0x483E al entrar "
                 "en la habitacion", "p00:57AE", ancho=3)


def tabla_5421(rom, t, bl):
    """p00:53FC: seis dibujos de 8x8 por HMMC, sus punteros en 0x5421.

    `ld hl,0x5421 / ld b,6` y en el bucle `ld a,(hl) / inc hl / ld h,(hl) /
    ld l,a / ld bc,0x0808 / call 0x498A`: 32 bytes cada uno.
    """
    s = (1, 2, 3)
    ptrs = [palabra(rom, s, 0x5421 + 2 * i) for i in range(6)]
    bl.anota(s, 0x5421, 0x542D, "tabla_5421",
             "6 punteros a dibujos de 8x8 que pinta p00:5412 por HMMC", "p00:5402", ancho=2)
    for w in sorted(set(ptrs)):
        bl.anota(s, w, w + 32, "hmmc_%04X" % w,
                 "8x8 puntos a 4 bits (32 bytes) para la orden HMMC de 0x498A", "p00:5412", ancho=8)


# Llamadas cuyo puntero ya lo pone un recorrido de arriba.
DE_LOS_RECORRIDOS = {(0, 0x566A), (0, 0x57A5), (0, 0x5412)}

RECORRIDOS = [dibujos_de_cada_fase, llamadas_a_lectores, habitaciones, tabla_5421]


# ------------------------------------------------------------------ escritura
def ocupado(p):
    """bytearray del banco: 1 = codigo trazado, 2 = D escrita fuera de la seccion."""
    o = ORG[p]
    m = bytearray(TAM_PAGINA)
    ruta = os.path.join(WORK, nombre(p) + ".trace.json")
    if os.path.exists(ruta):
        for k, a, b in json.load(open(ruta))["blocks"]:
            if k == "c":
                for i in range(a - o, b - o):
                    m[i] = 1
    notas = os.path.join(SRC, nombre(p) + ".notes")
    dentro = False
    if os.path.exists(notas):
        for ln in open(notas, encoding="utf-8"):
            if ln.startswith(INI):
                dentro = True
            elif ln.startswith(FIN):
                dentro = False
            elif not dentro and ln.startswith("D "):
                q = ln.split(None, 3)
                for i in range(max(0, int(q[1], 0) - o), min(TAM_PAGINA, int(q[2], 0) - o)):
                    m[i] = 2
    return m


def une(bloques_banco):
    """Los que se solapan se juntan en uno: dos juegos que comparten dibujos."""
    fuera = []
    for (a, f), e in sorted(bloques_banco.items()):
        if fuera and a < fuera[-1][1]:
            pa, pf, pe = fuera[-1]
            fuera[-1] = (pa, max(pf, f), pe + [(a, f, e)])
        else:
            fuera.append((a, f, [(a, f, e)]))
    return fuera


def linea_d(a, f, partes):
    e0 = partes[0][2]
    desde = sorted({d for _, _, e in partes for d in e["desde"]})
    if len(partes) == 1:
        txt = e0["que"]
    else:
        txt = "%s; se solapan %d bloques (%s)" % (
            e0["que"], len(partes),
            ", ".join("0x%04X-0x%04X" % (x, y) for x, y, _ in partes[:6]))
    txt += "; lo leen %s" % ", ".join(desde[:8])
    if len(desde) > 8:
        txt += " y %d mas" % (len(desde) - 8)
    txt += " (%d bytes)" % (f - a)
    return ["D 0x%04X 0x%04X %s  %s" % (a, f, e0["nom"], txt), "F 0x%04X %d" % (a, e0["ancho"])]


def escribe(p, lineas):
    ruta = os.path.join(SRC, nombre(p) + ".notes")
    viejas = open(ruta, encoding="utf-8").read().split("\n") if os.path.exists(ruta) else []
    nuevas, dentro, puesto = [], False, False
    for ln in viejas:
        if ln.startswith(INI):
            dentro = True
            if lineas:
                nuevas += [INI] + lineas + [FIN]
            puesto = True
            continue
        if ln.startswith(FIN):
            dentro = False
            continue
        if not dentro:
            nuevas.append(ln)
    if not puesto and lineas:
        while nuevas and not nuevas[-1].strip():
            nuevas.pop()
        nuevas += ["", INI] + lineas + [FIN, ""]
    open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas).rstrip("\n") + "\n")


def main(argv):
    rom = open(ROM, "rb").read()
    t, _ = traza_completa(rom, SRC)
    bl = Bloques()
    for r in RECORRIDOS:
        try:
            r(rom, t, bl)
        except FueraDelBanco as e:
            bl.avisos.append("%s: %s" % (r.__name__, e))
    total = 0
    for p in range(N_PAGINAS):
        m = ocupado(p)
        buenas, conflictos = [], []
        for a, f, partes in une(bl.d.get(p, {})):
            marcas = set(m[i - ORG[p]] for i in range(a, f))
            if marcas == {2}:
                continue
            pisa = marcas - {0}
            if pisa:
                conflictos.append("  %s 0x%04X-0x%04X (%s) pisa %s" % (
                    nombre(p), a, f, partes[0][2]["nom"],
                    " y ".join({1: "codigo trazado", 2: "una D escrita a mano"}[x] for x in sorted(pisa))))
                continue
            buenas.append((a, f, partes))
        n = sum(f - a for a, f, _ in buenas)
        total += n
        if buenas or conflictos:
            print("%s: %d bloques, %d bytes%s" % (nombre(p), len(buenas), n,
                                                  ", %d en conflicto" % len(conflictos) if conflictos else ""))
            for c in conflictos:
                print(c)
        if "--escribe" in argv:
            lineas = []
            for a, f, partes in buenas:
                lineas += linea_d(a, f, partes)
            escribe(p, lineas)
    print("en total: %d bytes en bloques que lee el codigo" % total)
    if bl.avisos:
        print("%d avisos:" % len(bl.avisos))
        for x in sorted(set(bl.avisos))[:80]:
            print("  " + x)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
