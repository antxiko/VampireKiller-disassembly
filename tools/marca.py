#!/usr/bin/env python3
"""Un tramo del listado con las instrucciones SIN comentar marcadas con '>'.

Es lo que hace rentable comentar: se ve de un vistazo que falta y no se
reescribe lo que ya esta (valida_c tiraria el repetido).

Uso: marca.py <banco> <desde> <hasta>      (direcciones en hexadecimal)
     marca.py <banco> --flojas [n]         las n rutinas con mas instrucciones sin comentar
"""
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def filas(b):
    fuera = []
    for ln in open(os.path.join(RAIZ, "src", "vampirekiller_p%02d.asm" % b), encoding="utf-8"):
        ln = ln.rstrip("\n")
        if re.match(r"^[A-Za-z_][A-Za-z0-9_]*:$", ln):
            fuera.append(("L", None, ln[:-1], ""))
            continue
        m = re.match(r"\t([a-z][^\t;]*?)\s*;([0-9a-f]{4})(.*)$", ln)
        if m and not ln.startswith("\tdefb"):
            resto = m.group(3).strip()
            com = resto.split(";", 1)[1].strip() if resto.startswith(";") else ""
            if not com and resto:
                com = resto
            fuera.append(("I", int(m.group(2), 16), m.group(1).strip(), com))
    return fuera


def main(argv):
    b = int(argv[1])
    fl = filas(b)
    if argv[2] == "--flojas":
        n = int(argv[3]) if len(argv) > 3 else 20
        rutinas, cur = [], None
        for k, a, t, c in fl:
            if k == "L":
                cur = [t, None, 0, 0]
                rutinas.append(cur)
            elif cur is not None:
                if cur[1] is None:
                    cur[1] = a
                cur[2] += 1
                cur[3] += 0 if c else 1
        for nom, a, tot, sin in sorted(rutinas, key=lambda r: -r[3])[:n]:
            if a is not None:
                print("%04X %-28s %3d sin comentar de %3d" % (a, nom, sin, tot))
        return
    ini, fin = int(argv[2], 16), int(argv[3], 16)
    dentro = False
    for k, a, t, c in fl:
        if k == "I":
            dentro = ini <= a < fin
            if dentro:
                print("%s%04X %-22s %s" % (" " if c else ">", a, t, c[:70]))
        elif dentro:
            print("   %s:" % t)


if __name__ == "__main__":
    main(sys.argv)
