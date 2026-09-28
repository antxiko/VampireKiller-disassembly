#!/usr/bin/env python3
"""Saca las rutinas SIN BAUTIZAR que son destino de un `call`, para nombrarlas.

Una etiqueta `L_xxxx` a la que solo se llega con `jr` o `jp` es un salto interno
y puede quedarse asi: la convencion de la serie es que lleven nombre las
RUTINAS, y una rutina es lo que alguien llama. Este listado tenia 166 destinos
de `call` sin bautizar, contra los 15 de un cartucho ya cerrado, asi que esa es
la deuda y esta es la lista.

De cada una imprime quien la llama, cuantas instrucciones tiene y sus
comentarios, que es de donde sale el nombre.

Uso: sin_bautizar.py <asm> [desde] [cuantas]
"""
import re
import sys
from collections import Counter, defaultdict


def main():
    lineas = open(sys.argv[1], encoding="utf-8").read().splitlines()
    desde = int(sys.argv[2]) if len(sys.argv) > 2 else 0
    cuantas = int(sys.argv[3]) if len(sys.argv) > 3 else 25

    # Quien llama a quien, y con que instruccion
    calls, saltos = Counter(), Counter()
    quien = defaultdict(list)
    actual = "(cabecera)"
    for ln in lineas:
        m = re.match(r"^([A-Za-z_][A-Za-z_0-9]*):", ln)
        if m:
            actual = m.group(1)
            continue
        m = re.search(r"^\t(call|jp|jr|djnz)\s+(?:[a-z]+,)?"
                      r"(L_[0-9A-F]{4}|[a-z_][a-z_0-9]*)\b", ln)
        if not m:
            continue
        if m.group(1) == "call":
            calls[m.group(2)] += 1
            quien[m.group(2)].append(actual)
        else:
            saltos[m.group(2)] += 1

    # Los bloques, con sus lineas
    bloques, nombre, cuerpo = [], "(cabecera)", []
    for ln in lineas:
        m = re.match(r"^([A-Za-z_][A-Za-z_0-9]*):\s*(;.*)?$", ln)
        if m:
            bloques.append((nombre, cuerpo))
            nombre, cuerpo = m.group(1), []
            continue
        if re.match(r"^\t.*;[0-9a-f]{4}", ln):
            cuerpo.append(ln)
    bloques.append((nombre, cuerpo))

    pendientes = [(n, c) for n, c in bloques
                  if re.match(r"^L_[0-9A-F]{4}$", n) and calls[n]]
    print("%d rutinas sin bautizar que son destino de un call; "
          "mostrando de la %d a la %d\n"
          % (len(pendientes), desde, min(desde + cuantas, len(pendientes))))
    for n, c in pendientes[desde:desde + cuantas]:
        coment = [x for x in c if x.count(";") > 1]
        print("=== %s  (%d call, %d saltos, %d instr)  llamada desde: %s"
              % (n, calls[n], saltos[n], len(c),
                 ", ".join(sorted(set(quien[n]))[:4])))
        for x in c[:16]:
            print("   " + x.rstrip())
        if len(c) > 16:
            print("   ... (%d instrucciones mas, %d comentadas en total)"
                  % (len(c) - 16, len(coment)))
        print()


if __name__ == "__main__":
    main()
