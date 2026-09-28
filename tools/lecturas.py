#!/usr/bin/env python3
"""Junta lo que midio tools/omsx_lecturas.tcl: que rutina lee cada byte.

Cada fichero work/omsx/*.txt tiene una linea por byte leido: "banco dir
bancoPC PC" (el lector es el PRIMERO que lo leyo en esa partida). Aqui se
juntan todas y se agrupan los bytes de cada banco en tramos seguidos con el
mismo lector. Es la materia prima para declarar los datos: un tramo que lee
una sola rutina es, casi siempre, UN bloque de un formato.

Uso:
    lecturas.py tramos [banco]        tramos por lector (todos o uno)
    lecturas.py lectores              cuantos bytes lee cada rutina
    lecturas.py sin_leer <banco>      lo que ninguna medida ha leido
"""
import glob
import os
import sys
from collections import defaultdict

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
from paginas import ORG, TAM_PAGINA  # noqa: E402


# {(banco, dir): ["banco:dir", ...]} las palabras de la pila en la primera lectura
PILAS = {}


def carga():
    """{(banco, dir): {(bancoPC, PC), ...}}"""
    lect = defaultdict(set)
    for f in sorted(glob.glob(os.path.join(RAIZ, "work", "omsx", "f[0-9][0-9].txt"))):
        for ln in open(f, encoding="utf-8"):
            p = ln.split()
            if len(p) < 4:
                continue
            if len(p) > 4:
                PILAS.setdefault((int(p[0]), int(p[1], 16)), p[4:])
            try:
                b, a, pb, pc = int(p[0]), int(p[1], 16), int(p[2]), int(p[3], 16)
            except ValueError:
                continue
            lect[(b, a)].add((pb, pc))
    return lect


def tramos(lect, banco):
    """[(ini, fin_exclusivo, lector)] del banco, con un lector por byte."""
    o = ORG[banco]
    fuera, cur = [], None
    for a in range(o, o + TAM_PAGINA):
        ls = lect.get((banco, a))
        k = min(ls) if ls else None
        if cur and cur[2] == k and cur[1] == a:
            cur[1] = a + 1
        else:
            if cur and cur[2] is not None:
                fuera.append(tuple(cur))
            cur = [a, a + 1, k]
    if cur and cur[2] is not None:
        fuera.append(tuple(cur))
    return fuera


def main(argv):
    lect = carga()
    modo = argv[1] if len(argv) > 1 else "tramos"
    if modo == "tramos":
        bancos = [int(argv[2])] if len(argv) > 2 else range(16)
        for b in bancos:
            ts = tramos(lect, b)
            if not ts:
                continue
            print("# banco %d: %d bytes leidos" % (b, sum(f - i for i, f, _ in ts)))
            for i, f, (pb, pc) in ts:
                print("  %04X..%04X %5d B  <- p%02d:%04X" % (i, f - 1, f - i, pb, pc))
    elif modo == "lectores":
        n = defaultdict(int)
        for (b, a), ls in lect.items():
            n[(min(ls), b)] += 1
        for ((pb, pc), b), c in sorted(n.items()):
            print("p%02d:%04X  banco %2d  %6d B" % (pb, pc, b, c))
    elif modo == "sin_leer":
        b = int(argv[2])
        o = ORG[b]
        ini = None
        for a in range(o, o + TAM_PAGINA + 1):
            leido = a == o + TAM_PAGINA or (b, a) in lect
            if not leido and ini is None:
                ini = a
            elif leido and ini is not None:
                print("  %04X..%04X %5d B" % (ini, a - 1, a - ini))
                ini = None
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
