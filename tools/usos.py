#!/usr/bin/env python3
"""Los usos de una direccion (o de un campo (ix+n)) en los listados, con contexto.

Uso: usos.py <0xDIR | ix+N> [maximo] [contexto]
"""
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BANCOS = ("00", "01", "02", "03", "13", "14")


def main(argv):
    que = argv[1].lower()
    maximo = int(argv[2]) if len(argv) > 2 else 8
    ctx = int(argv[3]) if len(argv) > 3 else 1
    if que.startswith("ix+"):
        pat = re.compile(r"\(ix\+0*%sh?\)" % re.escape(que[3:].lstrip("0") or "0"))
    else:
        v = int(que, 16)
        pat = re.compile(r"\b0?%04xh\b" % v)
    n = 0
    for b in BANCOS:
        filas = [l.rstrip("\n") for l in open(os.path.join(RAIZ, "src", "vampirekiller_p%s.asm" % b),
                                               encoding="utf-8") if l.startswith("\t") and not l.startswith("\tdefb")]
        for k, l in enumerate(filas):
            if pat.search(l.split(";")[0]):
                trozo = [re.sub(r"\t+;", " ;", f).strip() for f in filas[max(0, k - ctx):k + ctx + 1]]
                print("p%s  %s" % (b, "  |  ".join(t.split(";")[0].strip() + " @" + t.split(";")[1].strip()[:4]
                                                  if ";" in t else t for t in trozo)))
                n += 1
                if n >= maximo:
                    return


if __name__ == "__main__":
    main(sys.argv)
