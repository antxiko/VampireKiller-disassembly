#!/usr/bin/env python3
"""Para cada trozo sin explicar de un banco, las instrucciones que lo nombran.

Busca en los listados de los bancos de codigo (p00-p03, p13, p14) los
operandos inmediatos de 16 bits que caen dentro del trozo o justo delante (una
tabla se suele leer con `ld hl,base-1` o con un indice que empieza en 1), y
ensena la instruccion con las dos de antes y las tres de despues.

Uso: quien_apunta.py <banco> [minimo_de_bytes]
"""
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)

from paginas import ORG, TAM_PAGINA              # noqa: E402
from pendiente import explicado                  # noqa: E402
from bloques import listado                      # noqa: E402

CODIGO = (0, 1, 2, 3, 13, 14)


def main(argv):
    p = int(argv[1])
    minimo = int(argv[2]) if len(argv) > 2 else 1
    m = explicado(p)
    o = ORG[p]
    trozos, i = [], 0
    while i < TAM_PAGINA:
        if m[i]:
            i += 1
            continue
        j = i
        while j < TAM_PAGINA and not m[j]:
            j += 1
        if j - i >= minimo:
            trozos.append((o + i, o + j))
        i = j
    filas = {b: listado(b) for b in CODIGO}
    for a, f in trozos:
        print("=== %04X..%04X (%d B)" % (a, f - 1, f - a))
        for b in CODIGO:
            fl = filas[b]
            for k, (d, t) in enumerate(fl):
                for x in re.findall(r"\b0([0-9a-f]{4})h\b|\bL_([0-9A-F]{4})\b|DATA_([0-9A-F]{4})|\bl([0-9a-f]{4})h\b", t):
                    v = int(next(y for y in x if y), 16)
                    if a - 2 <= v < f:
                        ctx = "; ".join("%04x %s" % z for z in fl[max(0, k - 2):k + 4])
                        print("   p%02d: %s" % (b, ctx))


if __name__ == "__main__":
    main(sys.argv)
