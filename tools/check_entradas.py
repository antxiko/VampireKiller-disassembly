#!/usr/bin/env python3
"""Ningun punto de entrada puede caer dentro de un rango declarado como datos.

Por que existe esto. La contaminacion mas cara de este proyecto no la cazo
ninguna de las comprobaciones que habia: 41 de los 114 puntos de entrada del
bloque del juego caian dentro de los tiles y los sprites. El trazador entraba a
desensamblar dibujos, la cobertura subia de 24,6% a 61,6%, y todo lo demas
seguia en verde:

  - el reensamblado, porque los bytes no cambian: solo cambia como se leen;
  - el presupuesto, porque un byte mal leido como codigo tambien tiene dueno;
  - check_trace.py, porque solo vigila los rangos del fichero .nocode, y los
    graficos no estaban declarados alli.

Es decir: el proyecto se contradecia a si mismo -el mismo binario declarado como
graficos en un fichero y como codigo en otro- y ninguna herramienta lo miraba.
Esto lo mira.

Uso: check_entradas.py <src/X.entries> <src/X.notes> [src/X.nocode]
"""
import re
import sys

RANGO = re.compile(r"^D\s+0x([0-9A-Fa-f]+)\s+0x([0-9A-Fa-f]+)\s+(.*)$")
NOCODE = re.compile(r"^0x([0-9A-Fa-f]+)\s+0x([0-9A-Fa-f]+)\s+(.*)$")
ENTRADA = re.compile(r"^0x([0-9A-Fa-f]{4})\s+(\S+)")


def rangos(ruta, rx):
    out = []
    try:
        f = open(ruta, encoding="utf-8")
    except OSError:
        return out
    for ln in f:
        if ln.lstrip().startswith("#"):
            continue
        m = rx.match(ln.strip())
        if m:
            out.append((int(m.group(1), 16), int(m.group(2), 16), m.group(3).strip()))
    return out


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    entradas_p, notas_p = argv[1], argv[2]
    zonas = rangos(notas_p, RANGO)
    if len(argv) > 3:
        zonas += rangos(argv[3], NOCODE)

    entradas = []
    for ln in open(entradas_p, encoding="utf-8"):
        if ln.lstrip().startswith("#"):
            continue
        m = ENTRADA.match(ln.strip())
        if m:
            entradas.append((int(m.group(1), 16), m.group(2)))

    malas = []
    for a, nombre in entradas:
        for ini, fin, texto in zonas:
            if ini <= a < fin:
                malas.append((a, nombre, ini, fin, texto))
                break

    print("  %d puntos de entrada contra %d rangos de datos declarados"
          % (len(entradas), len(zonas)))
    if not malas:
        print("  OK: ningun punto de entrada cae dentro de una zona de datos")
        return 0

    print()
    print("  CONTRADICCION: %d puntos de entrada caen dentro de datos declarados."
          % len(malas))
    print("  O el punto de entrada esta mal, o el rango lo esta. Las dos cosas no")
    print("  pueden ser ciertas, y mientras lo sean el listado publicado miente.")
    print()
    for a, nombre, ini, fin, texto in malas:
        print("    0x%04X %-24s dentro de 0x%04X-0x%04X  %s"
              % (a, nombre, ini, fin, texto[:44]))
    return 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
