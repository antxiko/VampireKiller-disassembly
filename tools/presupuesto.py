#!/usr/bin/env python3
"""Presupuesto del cartucho: ni un byte sin explicar, sumado sobre las 16 paginas.

Por que este control y no el porcentaje de codigo trazado: buena parte de estos
128 KB son datos (circuitos, graficos, musica), asi que un porcentaje de codigo
bajo suena a trabajo a medias cuando puede estar entero. Lo que mide el avance
de verdad es que cada byte sea una de estas dos cosas:

  - codigo que el trazador alcanza de verdad siguiendo el flujo desde los
    puntos de entrada, o
  - un byte dentro de un rango de datos IDENTIFICADO con una directiva D del
    fichero de notas de su pagina, o sea con nombre y explicacion.

Y ES UN CONTROL DISTINTO DEL DE REPRODUCIBILIDAD. Un byte puede reensamblar
perfecto y estar sin explicar; o peor, estar mal explicado: si unos graficos se
marcan como codigo, el binario reensamblado sigue saliendo identico -los bytes
no cambian, solo su lectura- y el listado miente igual.

LO QUE CAMBIA RESPECTO A UN CARTUCHO DE 16 KB: aqui hay 16 paginas de 8 KB y
cada una tiene su propio org (tools/paginas.py), su trazado y sus notas. El
presupuesto se hace pagina a pagina y se suma. Las direcciones se repiten
entre paginas -0x6000 es el principio de la 1, de la 4, de la 7...-, asi que
un rango D solo vale para la pagina en cuyas notas esta.

Uso: presupuesto.py <directorio_work> <directorio_src> [--por-pagina]
"""
import json
import os
import sys

from paginas import org, nombre, TAM_PAGINA, N_PAGINAS

SIN_EXPLICAR, CODIGO, DATOS = 0, 1, 2


def rangos_de_notas(path):
    """Los rangos de datos declarados con la directiva D del fichero .notes."""
    out = []
    if not os.path.exists(path):
        return out
    for ln in open(path, encoding="utf-8"):
        ln = ln.strip()
        if not ln.startswith("D "):
            continue
        p = ln.split(None, 3)
        out.append((int(p[1], 0), int(p[2], 0)))
    return out


def reparte(work, src, p):
    """Marca cada byte de la pagina p como codigo, datos con nombre, o nada."""
    estado = bytearray(TAM_PAGINA)
    ORG = org(p)
    traza = os.path.join(work, nombre(p) + ".trace.json")
    if os.path.exists(traza):
        for tipo, a, b in json.load(open(traza))["blocks"]:
            if tipo != "c":
                continue
            for i in range(max(0, a - ORG), min(TAM_PAGINA, b - ORG)):
                estado[i] = CODIGO
    for a, b in rangos_de_notas(os.path.join(src, nombre(p) + ".notes")):
        for i in range(max(0, a - ORG), min(TAM_PAGINA, b - ORG)):
            if estado[i] == SIN_EXPLICAR:
                estado[i] = DATOS
    return estado


def huecos(estado, ORG):
    """Agrupa los bytes sin explicar en rangos, para poder ir a mirarlos."""
    out, ini = [], None
    for i, v in enumerate(estado):
        if v == SIN_EXPLICAR and ini is None:
            ini = i
        elif v != SIN_EXPLICAR and ini is not None:
            out.append((ORG + ini, ORG + i))
            ini = None
    if ini is not None:
        out.append((ORG + ini, ORG + TAM_PAGINA))
    return out


def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    work, src = sys.argv[1], sys.argv[2]
    detalle = "--por-pagina" in sys.argv
    TOTAL = TAM_PAGINA * N_PAGINAS

    tc = td = ts = 0
    pendientes = []
    print("  %-7s %-6s %8s %8s %8s" % ("pagina", "org", "codigo", "datos", "sin expl"))
    print("  " + "-" * 42)
    for p in range(N_PAGINAS):
        estado = reparte(work, src, p)
        c, d, s = estado.count(CODIGO), estado.count(DATOS), estado.count(SIN_EXPLICAR)
        tc += c
        td += d
        ts += s
        print("  %-7s %#06x %8d %8d %8d" % (nombre(p), org(p), c, d, s))
        for a, b in huecos(estado, org(p)):
            pendientes.append((p, a, b))
    print("  " + "=" * 42)
    print()
    print("  %-24s %7s %8s" % ("", "bytes", "del total"))
    print("  " + "-" * 42)
    for etiqueta, n in (("codigo trazado", tc),
                        ("datos identificados", td),
                        ("sin explicar", ts)):
        print("  %-24s %7d %7.2f %%" % (etiqueta, n, 100.0 * n / TOTAL))
    print("  " + "=" * 42)
    print("  %-24s %7d %7.2f %%" % ("explicado", tc + td, 100.0 * (tc + td) / TOTAL))

    if pendientes:
        print()
        print("  Sin explicar, por rangos:")
        for p, a, b in pendientes:
            print("    %s 0x%04X..0x%04X  (%d bytes)" % (nombre(p), a, b - 1, b - a))
        print()
        print("  Cada uno de estos rangos tiene que acabar dentro de una")
        print("  directiva D del fichero de notas de SU pagina, con una")
        print("  explicacion de que es y de como se sabe.")
        return 1

    print()
    print("  OK: ni un byte del cartucho sin asignar")
    return 0


if __name__ == "__main__":
    sys.exit(main())
