#!/usr/bin/env python3
"""Coteja las habitaciones montadas desde las tablas con los volcados de
openMSX (tools/omsx_habitacion.tcl, en work/habitaciones: los 128 KB de VRAM,
la RAM de 0xC000 y la paleta de cada habitacion, medio segundo despues de que
p01:6321 encienda la pantalla).

  habitaciones  por cada volcado: la paleta, los bytes de la pagina 1 que el
                montaje toca (los dibujos del decorado, los de los objetos y lo
                que carga el guion de la habitacion) y la pantalla (la pagina
                0, filas 32 a 207) con lo que esconde la habitacion pintado.
                Las velas se turnan entre dos dibujos: se admiten los dos.

Uso:  coteja.py [habitaciones]
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import (Cartucho, habitacion, FILA_DE_LA_HABITACION, FILAS_PINTADAS,  # noqa: E402
                      ANCHO_DE_LINEA)
from secretos import pinta_secretos, DONDE_ESTAN_LAS_TRAMPAS  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WORK = os.path.join(RAIZ, "work")


def _lee(ruta):
    with open(ruta, "rb") as f:
        return f.read()


def _pantalla(v):
    ini = FILA_DE_LA_HABITACION * ANCHO_DE_LINEA
    return bytes(v[ini:ini + FILAS_PINTADAS * 8 * ANCHO_DE_LINEA])


def habitaciones(cart, detalle=False):
    vistos = malos = 0
    resumen = []
    for ruta in sorted(glob.glob(os.path.join(WORK, "habitaciones", "hab_f*_h*.vram"))):
        base = os.path.basename(ruta)
        fase, hab = int(base[5:7]), int(base[9:11])
        d = _lee(ruta)
        pal = _lee(ruta[:-5] + ".pal")
        paleta = [((pal[2 * k] >> 4) & 7, pal[2 * k + 1] & 7, pal[2 * k] & 7) for k in range(16)]
        # los montajes: las velas en sus dos pasos -solos o uno encima del
        # otro-, con y sin los objetos a la vista (0xCF38 decide si salen);
        # cada byte vale si lo da alguno. Las trampas de (6,1) se mueven: vale
        # el primer cuadro, de 0 a 60 desde que se entra, que da el volcado
        pe = _pantalla(d)
        cuadros = range(61) if (fase, hab) == DONDE_ESTAN_LAS_TRAMPAS else [None]
        for cuadro in cuadros:
            variantes = []
            for pasos in ((0,), (1,), (0, 1), (1, 0)):
                for con_objetos in (True, False):
                    v = habitacion(cart, fase, hab)
                    pinta_secretos(cart, v, fase, hab, pasos, con_objetos, cuadro)
                    variantes.append(v)
            ps = [_pantalla(v.v) for v in variantes]
            malas = [a for a in range(len(pe)) if all(pe[a] != p[a] for p in ps)]
            if not malas:
                break
        v0 = variantes[0]
        dp = sum(1 for k in range(16) if paleta[k] != v0.paleta[k])
        # p00:54E4 lee 0x48 bytes de RAM para el quinto dibujo de 0xB800: ese
        # trozo (x 64-79, filas 0x77-0x7F de la pagina 1) no sale de la ROM
        d1 = sum(1 for a in range(0x8000, 0x10000) if v0.tocado[a] and v0.v[a] != d[a]
                 and not (0x77 <= (a - 0x8000) // ANCHO_DE_LINEA <= 0x7F
                          and 32 <= (a - 0x8000) % ANCHO_DE_LINEA < 40))
        if cuadro is not None and detalle:
            print("  fase %2d hab %2d: las trampas, en el cuadro %d" % (fase, hab, cuadro))
        d0 = len(malas)
        vistos += 1
        if dp or d1 or d0:
            malos += 1
            celdas = sorted({((a // ANCHO_DE_LINEA) // 8, (a % ANCHO_DE_LINEA) // 4) for a in malas})
            print("  fase %2d hab %2d: paleta %d, pagina 1 %d, pantalla %d bytes en %d celdas %s"
                  % (fase, hab, dp, d1, d0, len(celdas),
                     " ".join("(%d,%d)" % c for c in celdas[:6]) if detalle else ""))
        resumen.append((fase, hab, dp, d1, d0))
    print("habitaciones: %d volcados, %d con diferencias" % (vistos, malos))
    return vistos > 0 and malos == 0


PRUEBAS = {"habitaciones": habitaciones}


def main():
    cart = Cartucho()
    cuales = [a for a in sys.argv[1:] if not a.startswith("-")] or list(PRUEBAS)
    detalle = "-v" in sys.argv
    todo = True
    for c in cuales:
        todo &= PRUEBAS[c](cart, detalle) if c == "habitaciones" else PRUEBAS[c](cart)
    print("VERDE" if todo else "ROJO")
    sys.exit(0 if todo else 1)


if __name__ == "__main__":
    main()
