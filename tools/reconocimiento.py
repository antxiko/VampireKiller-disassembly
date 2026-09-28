#!/usr/bin/env python3
"""Reconocimiento de la ROM: cabecera, mapper, y la regla banco -> org.

Lo que mide, sobre los bytes de la ROM y sin ejecutar nada:

  1. La cabecera "AB" y el INIT del banco 0 (y si algun otro banco la lleva).
  2. Todas las escrituras `ld (nn),a` a los registros del mapper. Se miran los
     SIETE candidatos: los cuatro del Konami CON SCC (0x5000, 0x7000, 0x9000,
     0xB000) y los tres del Konami SIN SCC (0x6000, 0x8000, 0xA000). Que los
     primeros salgan a cero es lo que decide que este cartucho es Konami4.
  3. El valor que lleva cada escritura -el `ld a,N` inmediato de antes, o el
     `inc a` encadenado del reparto de tres- y si ese banco puede ir a esa
     ranura segun tools/paginas.py. Aqui es donde la regla se comprueba, no se
     supone.
  4. Los bancos que no toca ningun registro, y los que son 0xFF de punta a
     punta.

Codigo de salida 1 si alguna escritura contradice la regla, si aparece una
escritura a un registro del SCC, o si la cabecera no es la esperada.

Uso: reconocimiento.py <rom>
"""
import sys

from bancos import BASE_LEN, ED_LEN4, IDX_DISP, NO_TOCA_A, ED_TOCA_A
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre

SCC = (0x5000, 0x7000, 0x9000, 0xB000)
K4 = (0x6000, 0x8000, 0xA000)


def direccion(i):
    """(banco, direccion de ejecucion) del offset i de la ROM."""
    p = i // TAM_PAGINA
    return p, ORG[p] + (i % TAM_PAGINA)


def escrituras(d, reg):
    """Offsets de cada `ld (reg),a` (32 lo hi) del cartucho."""
    lo, hi = reg & 0xFF, reg >> 8
    return [i for i in range(len(d) - 2)
            if d[i] == 0x32 and d[i + 1] == lo and d[i + 2] == hi]


def toca_a(d, pc):
    """Si la instruccion de pc escribe en el acumulador."""
    op = d[pc]
    if op == 0xCB:
        o2 = d[pc + 1]
        return False if 0x40 <= o2 < 0x80 else (o2 & 7) == 7
    if op == 0xED:
        return d[pc + 1] in ED_TOCA_A
    if op in (0xDD, 0xFD):
        o2 = d[pc + 1]
        return False if o2 == 0xCB else o2 not in NO_TOCA_A
    return op not in NO_TOCA_A


def valor(d, i):
    """Que banco lleva la escritura de offset i, si se puede saber leyendo.

    Dos formas, las dos vistas en este cartucho:
      - `ld a,N` justo delante;
      - el reparto de tres, que encadena `inc a` entre escritura y escritura:
        `ld a,N / ld (0x6000),a / ld (hl),a / inc a / ld (0x8000),a /
        inc hl / ld (hl),a / inc a / ld (0xA000),a`.

    Se busca el `ld a,N` MAS CERCANO por detras desde el que se llegue
    DECODIFICANDO HACIA DELANTE justo a la escritura, y se cuentan los `inc a`
    del camino. Ir hacia atras byte a byte no vale: el 0x3E de un `ld a,N`
    tambien aparece como operando de otra instruccion.

    Devuelve (banco, como) o (None, motivo).
    """
    for ini in range(i - 1, max(-1, i - 21), -1):
        if d[ini] != 0x3E:
            continue
        pc, incs, roto = ini, 0, False
        while pc < i:
            op = d[pc]
            if pc > ini and op == 0x3C:
                incs += 1
            elif pc > ini and toca_a(d, pc):
                roto = True                # alguien pisa A por el camino
                break
            n = BASE_LEN[op]
            if op == 0xCB:
                n = 2
            elif op == 0xED:
                n = 4 if d[pc + 1] in ED_LEN4 else 2
            elif op in (0xDD, 0xFD):
                o2 = d[pc + 1]
                n = 1 if o2 in (0xDD, 0xFD, 0xED) else (
                    4 if o2 == 0xCB else
                    1 + BASE_LEN[o2] + (1 if o2 in IDX_DISP else 0))
            pc += n
        if not roto and pc == i:
            return (d[ini + 1] + incs) & 0xFF, (
                "ld a,%d" % d[ini + 1] if not incs
                else "ld a,%d y %d inc a" % (d[ini + 1], incs))
    if i >= 3 and d[i - 3] == 0x3A:
        return None, "ld a,(%#06x): devuelve la copia en RAM" % (
            d[i - 2] | (d[i - 1] << 8))
    return None, "A calculado (%s)" % d[max(0, i - 5):i].hex(" ")


def main(rom):
    d = open(rom, "rb").read()
    fallos = 0
    print("ROM: %d bytes, %d bancos de %d" % (len(d), len(d) // TAM_PAGINA,
                                              TAM_PAGINA))

    init = d[2] | (d[3] << 8)
    print("cabecera: %s INIT=%#06x STATEMENT=%#06x DEVICE=%#06x TEXT=%#06x" % (
        d[0:2], init, d[4] | (d[5] << 8), d[6] | (d[7] << 8), d[8] | (d[9] << 8)))
    if d[0:2] != b"AB":
        print("  FALLO: el banco 0 no empieza por AB")
        fallos += 1
    for p in range(1, N_PAGINAS):
        if d[p * TAM_PAGINA:p * TAM_PAGINA + 2] == b"AB":
            print("  (el banco %d tambien lleva AB)" % p)

    print("\nregistros del mapper CON SCC (Konami5): tienen que estar a cero")
    for reg in SCC:
        n = len(escrituras(d, reg))
        print("  %#06x: %d escrituras" % (reg, n))
        if n:
            print("  FALLO: alguien escribe en %#06x; esto no es un Konami4"
                  % reg)
            fallos += 1

    print("\nregistros del mapper SIN SCC (Konami4)")
    usados = set()
    for reg in K4:
        sitios = escrituras(d, reg)
        print("  %#06x: %d escrituras" % (reg, len(sitios)))
        for i in sitios:
            p, a = direccion(i)
            banco, como = valor(d, i)
            if banco is None:
                print("      %s:%04X  banco ?  (%s)" % (nombre(p), a, como))
                continue
            usados.add(banco)
            ok = banco < N_PAGINAS and ORG[banco] == reg
            print("      %s:%04X  banco %-2d (%s)  %s" % (
                nombre(p), a, banco, como,
                "ok" if ok else "CONTRADICE la regla: %s va a %#06x"
                % (nombre(banco), ORG.get(banco, 0))))
            if not ok:
                fallos += 1

    print("\nbancos que NINGUNA escritura selecciona: %s"
          % " ".join(nombre(p) for p in range(1, N_PAGINAS) if p not in usados))
    vacios = [p for p in range(N_PAGINAS)
              if set(d[p * TAM_PAGINA:(p + 1) * TAM_PAGINA]) == {0xFF}]
    print("bancos que son 0xFF de punta a punta: %s"
          % " ".join(nombre(p) for p in vacios))

    print()
    if fallos:
        print("FALLO: %d contradicciones con la regla banco -> org" % fallos)
        return 1
    print("OK: la regla banco -> org de tools/paginas.py la cumplen todas "
          "las escrituras")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1]))
