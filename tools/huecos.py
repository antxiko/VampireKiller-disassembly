#!/usr/bin/env python3
"""Cada hueco sin explicar, y QUIEN lo apunta desde el codigo ya trazado.

Un rango de datos no se declara porque sobre: se declara porque hay una
instruccion identificada que lo lee. Esta herramienta busca esa instruccion.

Recorre los inicios de instruccion del trazado -nunca los bytes a lo bruto,
que es como se inventan punteros donde no los hay-, se queda con los operandos
de 16 bits (`ld hl,nn`, `ld de,nn`, `ld bc,nn`, `ld ix,nn`, `ld a,(nn)`,
`ld hl,(nn)`...) y dice cuales caen dentro de cada hueco.

En un MegaROM hay un paso mas: una instruccion de otro banco que apunte a
0x8123 solo vale como prueba si en ese momento el banco que se mira estaba en
0x8000. Por eso, ademas del apuntador, se dice DESDE QUE BANCO se apunta, y
los que apuntan desde un banco cuya ranura es la misma se marcan aparte: son
punteros dentro del propio banco.

Los huecos que salen SIN NADIE que los apunte son los interesantes: o son
datos encadenados que se consumen uno detras de otro, o son codigo al que el
trazado no llega.

Uso: huecos.py <rom> <dir_work> <dir_src> [pNN ...]
"""
import json
import os
import re
import sys

from bancos import BASE_LEN, ED_LEN4, IDX_DISP
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre

# Instrucciones con un inmediato de 16 bits que puede ser una direccion.
INMEDIATO = {
    0x01: "ld bc,", 0x11: "ld de,", 0x21: "ld hl,", 0x31: "ld sp,",
    0x22: "ld (nn),hl", 0x2A: "ld hl,(nn)", 0x32: "ld (nn),a", 0x3A: "ld a,(nn)",
    0xC3: "jp ", 0xCD: "call ",
    0xC2: "jp nz,", 0xCA: "jp z,", 0xD2: "jp nc,", 0xDA: "jp c,",
    0xE2: "jp po,", 0xEA: "jp pe,", 0xF2: "jp p,", 0xFA: "jp m,",
    0xC4: "call nz,", 0xCC: "call z,", 0xD4: "call nc,", 0xDC: "call c,",
    0xE4: "call po,", 0xEC: "call pe,", 0xF4: "call p,", 0xFC: "call m,",
}
IDX = {0x21: "ld i%s,", 0x22: "ld (nn),i%s", 0x2A: "ld i%s,(nn)"}


def ilen(d, o):
    op = d[o]
    if op == 0xCB:
        return 2
    if op == 0xED:
        return 4 if d[o + 1] in ED_LEN4 else 2
    if op in (0xDD, 0xFD):
        o2 = d[o + 1]
        if o2 == 0xCB:
            return 4
        if o2 in (0xDD, 0xFD, 0xED):
            return 1
        return 1 + BASE_LEN[o2] + (1 if o2 in IDX_DISP else 0)
    return BASE_LEN[op]


def instrucciones(rom, work, p):
    """(direccion, mnemonico, operando de 16 bits) del codigo trazado de p."""
    ruta = os.path.join(work, nombre(p) + ".trace.json")
    if not os.path.exists(ruta):
        return
    base = p * TAM_PAGINA
    for k, a, b in json.load(open(ruta))["blocks"]:
        if k != "c":
            continue
        pc = a
        while pc < b:
            o = base + (pc & 0x1FFF)
            n = ilen(rom, o)
            if n == 0 or pc + n > b:
                break
            op = rom[o]
            if op in INMEDIATO and n == 3:
                yield pc, INMEDIATO[op], rom[o + 1] | (rom[o + 2] << 8)
            elif op in (0xDD, 0xFD) and rom[o + 1] in IDX and n == 4:
                yield (pc, IDX[rom[o + 1]] % ("x" if op == 0xDD else "y"),
                       rom[o + 2] | (rom[o + 3] << 8))
            pc += n


def rangos_de_notas(path):
    fuera = []
    if not os.path.exists(path):
        return fuera
    for ln in open(path, encoding="utf-8"):
        if ln.startswith("D "):
            q = ln.split(None, 3)
            fuera.append((int(q[1], 0), int(q[2], 0)))
    return fuera


def main(rom_path, work, src, *cuales):
    rom = open(rom_path, "rb").read()
    pags = [int(c[1:], 10) for c in cuales] if cuales else list(range(N_PAGINAS))

    # Todos los apuntadores del cartucho, agrupados por valor.
    punteros = {}
    for p in range(N_PAGINAS):
        for pc, mn, w in instrucciones(rom, work, p):
            punteros.setdefault(w, []).append((p, pc, mn))

    for p in pags:
        o = ORG[p]
        marca = bytearray(TAM_PAGINA)
        ruta = os.path.join(work, nombre(p) + ".trace.json")
        if os.path.exists(ruta):
            for k, a, b in json.load(open(ruta))["blocks"]:
                if k == "c":
                    for i in range(a - o, b - o):
                        marca[i] = 1
        for a, b in rangos_de_notas(os.path.join(src, nombre(p) + ".notes")):
            for i in range(max(0, a - o), min(TAM_PAGINA, b - o)):
                marca[i] = 2
        filas, ini = [], None
        for i in range(TAM_PAGINA + 1):
            v = marca[i] if i < TAM_PAGINA else 1
            if not v and ini is None:
                ini = i
            elif v and ini is not None:
                filas.append((ini, i))
                ini = None
        if not filas:
            continue
        print("# ---- %s (org %#06x): %d huecos, %d bytes sin explicar ----" % (
            nombre(p), o, len(filas), sum(b - a for a, b in filas)))
        for a, b in filas:
            tr = rom[p * TAM_PAGINA + a:p * TAM_PAGINA + b]
            ff = sum(1 for c in tr if c == 0xFF)
            print("  %04X..%04X  %5d B  (0xFF: %d)  %s" % (
                o + a, o + b - 1, b - a, ff,
                " ".join("%02x" % c for c in tr[:10])))
            quien = []
            for w in range(o + a, o + b):
                for pp, pc, mn in punteros.get(w, []):
                    quien.append((w, pp, pc, mn))
            if not quien:
                print("      nadie lo apunta con un inmediato de 16 bits")
            for w, pp, pc, mn in quien[:14]:
                misma = "misma ranura" if ORG[pp] == (w & 0xE000) or (
                    pp == p) else "otra ranura"
                print("      %04X  <- %s:%04X  %s%04X   (%s)" % (
                    w, nombre(pp), pc, mn, w, misma))
            if len(quien) > 14:
                print("      ... y %d apuntadores mas" % (len(quien) - 14))
    return 0


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
