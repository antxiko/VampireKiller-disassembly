#!/usr/bin/env python3
"""Lo que falta por explicar de un banco, y quien lo lee en openMSX.

Cruza el presupuesto (codigo trazado + directivas D de las notas) con las
lecturas medidas por tools/omsx_lecturas.tcl: para cada tramo sin explicar
dice que rutinas leen sus bytes, que es por donde hay que empezar a mirar.

Uso: pendiente.py <banco> [minimo_de_bytes]
"""
import json
import os
import sys
from collections import Counter

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from lecturas import carga, PILAS                             # noqa: E402
from paginas import ORG, TAM_PAGINA, nombre                   # noqa: E402
from presupuesto import rangos_de_notas                       # noqa: E402


def explicado(p):
    o = ORG[p]
    m = bytearray(TAM_PAGINA)
    for k, a, b in json.load(open(os.path.join(RAIZ, "work", nombre(p) + ".trace.json")))["blocks"]:
        if k == "c":
            for i in range(a - o, b - o):
                m[i] = 1
    for r in rangos_de_notas(os.path.join(RAIZ, "src", nombre(p) + ".notes")):
        a, b = r[0], r[1]
        for i in range(max(0, a - o), min(TAM_PAGINA, b - o)):
            m[i] = 1
    return m


# La libreria de VRAM del banco 0 y el despachador: quien de verdad pide un
# dato es la primera vuelta de la pila que cae FUERA de aqui.
LIBRERIA = ((0x4040, 0x4080), (0x4600, 0x4B00))


ROM = open(os.path.join(RAIZ, "vampirekiller.rom"), "rb").read()
LLAMADAS = {0xCD, 0xC4, 0xCC, 0xD4, 0xDC, 0xE4, 0xEC, 0xF4, 0xFC}


def es_vuelta(b, a):
    """Si a es una direccion de vuelta: detras hay un `call` en ese banco."""
    if b < 0 or b >= 16:
        return False
    o = b * TAM_PAGINA + (a - ORG[b])
    return 0 <= a - ORG[b] < TAM_PAGINA and o >= 3 and ROM[o - 3] in LLAMADAS


def quien_pide(pila):
    """La llamada (su instruccion, no su vuelta) que pidio el dato."""
    for x in pila:
        b, a = x.split(":")
        b, a = int(b), int(a, 16)
        if not es_vuelta(b, a):
            continue
        if b == 0 and any(i <= a < f for i, f in LIBRERIA):
            continue
        return "p%02d:%04X" % (b, a - 3)
    return None


def main(argv):
    p = int(argv[1])
    minimo = int(argv[2]) if len(argv) > 2 else 1
    lect = carga()
    m = explicado(p)
    o = ORG[p]
    rom = open(os.path.join(RAIZ, "vampirekiller.rom"), "rb").read()
    i = 0
    while i < TAM_PAGINA:
        if m[i]:
            i += 1
            continue
        j = i
        while j < TAM_PAGINA and not m[j]:
            j += 1
        if j - i >= minimo:
            c = Counter()
            for a in range(o + i, o + j):
                for pb, pc in lect.get((p, a), ()):
                    c["p%02d:%04X" % (pb, pc)] += 1
                q = quien_pide(PILAS.get((p, a), []))
                if q:
                    c["<-" + q] += 1
            leido = sum(1 for a in range(o + i, o + j) if (p, a) in lect)
            print("%04X..%04X %5d B  leidos %5d  %s  | %s" % (
                o + i, o + j - 1, j - i, leido,
                " ".join("%s(%d)" % kv for kv in c.most_common(6)),
                rom[p * TAM_PAGINA + i:p * TAM_PAGINA + min(j, i + 10)].hex(" ")))
        i = j


if __name__ == "__main__":
    main(sys.argv)
