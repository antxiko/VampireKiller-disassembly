#!/usr/bin/env python3
"""Cuenta, rutina a rutina, cuantas instrucciones llevan comentario de linea.

La segunda pasada de comentarios no se hace a ojo: primero se mide donde estan
los huecos. Una rutina con nombre pero con cero comentarios esta bautizada, no
explicada.

Uso: densidad.py <asm> [minimo_instrucciones]
"""
import re
import sys


def main():
    lineas = open(sys.argv[1], encoding="utf-8").read().splitlines()
    minimo = int(sys.argv[2]) if len(sys.argv) > 2 else 6
    bloques, nombre, ini, n, c = [], "(cabecera)", 0, 0, 0
    for ln in lineas:
        m = re.match(r"^([A-Za-z_][A-Za-z_0-9]*):\s*(;.*)?$", ln)
        if m:
            if n:
                bloques.append((nombre, ini, n, c))
            nombre, ini, n, c = m.group(1), 0, 0, 0
            continue
        m = re.match(r"^\t.*;([0-9a-f]{4})(.*)$", ln)
        if not m:
            continue
        if not ini:
            ini = int(m.group(1), 16)
        n += 1
        if ";" in m.group(2):
            c += 1
    if n:
        bloques.append((nombre, ini, n, c))
    tot_n = sum(b[2] for b in bloques)
    tot_c = sum(b[3] for b in bloques)
    flojos = [b for b in bloques if b[2] >= minimo and b[3] * 100 // b[2] < 10]
    for nom, a, n, c in sorted(flojos, key=lambda b: -b[2]):
        print("  %-32s 0x%04X  %3d instr  %2d comentarios  %2d %%"
              % (nom, a, n, c, c * 100 // n))
    if not tot_n:
        # Diez de los dieciseis bancos son datos de punta a punta: no tienen ni
        # una instruccion que contar, y eso no es un error.
        print("  ---- este banco no lleva codigo: nada que medir")
        return
    print("  ---- %d rutinas por debajo del 10 %%, de %d" % (len(flojos), len(bloques)))
    print("  ---- en total: %d instrucciones, %d comentarios, %.1f %%"
          % (tot_n, tot_c, 100.0 * tot_c / tot_n))


main()
