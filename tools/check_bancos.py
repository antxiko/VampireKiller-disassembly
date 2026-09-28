#!/usr/bin/env python3
"""Los dos trazados tienen que decir lo mismo.

En este proyecto hay dos trazadores, y a proposito:

  - tools/bancos.py recorre el CARTUCHO ENTERO llevando la cuenta de que banco
    hay en cada ranura. Es el que sabe de verdad por donde va el flujo, pero su
    resultado no se publica: lo que se publica son ficheros escritos a mano.
  - tools/z80trace.py traza CADA BANCO por separado, partiendo de las entradas
    ya escritas en src/pNN.entries. Es el que genera el listado.

Si los .entries estan completos, los dos tienen que marcar EXACTAMENTE los
mismos bytes como codigo. Cuando no coinciden, una de dos:

  - hay bytes que solo ve el de cartucho entero: falta una entrada en el
    .entries, y el listado publica como datos algo que es codigo;
  - hay bytes que solo ve el de banco: una entrada del .entries lleva a donde
    no debe, o una tabla del despachador se ha quedado corta, y el listado
    publica como codigo algo que nadie ejecuta.

Las dos cosas son errores, y ninguna la caza el reensamblado byte a byte.

Uso: check_bancos.py <rom> <dir_work> <dir_src>
"""
import json
import os
import sys

from bancos import traza_completa
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre


def rangos(mapa, org):
    """Agrupa un bytearray de marcas en rangos [ini, fin)."""
    fuera, ini = [], None
    for i in range(TAM_PAGINA + 1):
        v = mapa[i] if i < TAM_PAGINA else 0
        if v and ini is None:
            ini = i
        elif not v and ini is not None:
            fuera.append((org + ini, org + i))
            ini = None
    return fuera


def main(rom_path, work, src):
    rom = open(rom_path, "rb").read()
    t, _tam = traza_completa(rom, src)
    fallos = 0
    print("  %-5s %9s %9s %9s %9s" % ("banco", "bancos.py", "z80trace",
                                      "solo B", "solo Z"))
    print("  " + "-" * 48)
    detalle = []
    for p in range(N_PAGINAS):
        ruta = os.path.join(work, nombre(p) + ".trace.json")
        z = bytearray(TAM_PAGINA)
        if os.path.exists(ruta):
            for k, a, b in json.load(open(ruta))["blocks"]:
                if k == "c":
                    for i in range(max(0, a - ORG[p]),
                                   min(TAM_PAGINA, b - ORG[p])):
                        z[i] = 1
        b_ = t.marcado[p]
        solo_b = bytearray((x and not y) for x, y in zip(b_, z))
        solo_z = bytearray((y and not x) for x, y in zip(b_, z))
        nb, nz = sum(solo_b), sum(solo_z)
        print("  %-5s %9d %9d %9d %9d" % (nombre(p), sum(b_), sum(z), nb, nz))
        if nb or nz:
            fallos += 1
            detalle.append((p, rangos(solo_b, ORG[p]), rangos(solo_z, ORG[p])))

    if not fallos:
        print("\n  OK: los dos trazados marcan los mismos bytes como codigo")
        return 0

    print()
    for p, rb, rz in detalle:
        if rb:
            print("  %s: SOLO el trazado de cartucho entero (falta entrada):" % nombre(p))
            for a, b in rb[:12]:
                print("      %04X..%04X  (%d bytes)" % (a, b - 1, b - a))
            if len(rb) > 12:
                print("      ... y %d rangos mas" % (len(rb) - 12))
        if rz:
            print("  %s: SOLO el trazado del banco (entrada de mas o tabla corta):"
                  % nombre(p))
            for a, b in rz[:12]:
                print("      %04X..%04X  (%d bytes)" % (a, b - 1, b - a))
            if len(rz) > 12:
                print("      ... y %d rangos mas" % (len(rz) - 12))
    print("\n  FALLO: %d bancos en los que los dos trazados no coinciden" % fallos)
    return 1


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:4]))
