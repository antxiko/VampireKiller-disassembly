#!/usr/bin/env python3
"""Los objetos, en el orden de su tipo, tal como los guarda la pagina 1.

  p00:548D  al empezar la partida sube los dibujos de 16 x 16 a las filas
            0x50 y 0x60 de la pagina 1 (tools/graficos.py,
            carga_los_dibujos_de_los_objetos).
  p02:8CC1  el objeto del tipo t es el dibujo t - 1: los dieciseis primeros
            en la fila 0x50 y los demas en la 0x60, columna (t - 1) * 16.
            El tipo 0x15 no tiene dibujo: al romper lo que lo esconde sale un
            enemigo (p02:8AD0).

  python tools/objetos.py [fase]     docs/imagenes/objetos.png, con la paleta
                                     de la fase (la 1 si no se dice)
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from graficos import Cartucho, IMAGENES, habitacion, guarda_png, rgb  # noqa: E402
from secretos import FILA_DE_LOS_OBJETOS, BICHO, NOMBRES  # noqa: E402

POR_FILA = 10
HUECO = 8


def tipos():
    """Los tipos con dibujo, del 1 al 0x1E."""
    return [t for t in range(1, 0x1F) if t != BICHO]


def dibujo(vram, t):
    a = t - 1
    x0, y0 = (a % 16) * 16, FILA_DE_LOS_OBJETOS[a // 16]
    return [[vram.punto(1, x0 + i, y0 + j) for i in range(16)] for j in range(16)]


def lamina(cart, fase=1):
    vram = habitacion(cart, fase, 0)
    ts = tipos()
    filas = (len(ts) + POR_FILA - 1) // POR_FILA
    ancho, alto = POR_FILA * (16 + HUECO) + HUECO, filas * (16 + HUECO) + HUECO
    img = [[(0, 0, 0)] * ancho for _ in range(alto)]
    for k, t in enumerate(ts):
        x, y = HUECO + (k % POR_FILA) * (16 + HUECO), HUECO + (k // POR_FILA) * (16 + HUECO)
        for j, fila in enumerate(dibujo(vram, t)):
            for i, c in enumerate(fila):
                img[y + j][x + i] = rgb(vram.paleta, c)
    return img, ts


def main():
    fase = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    img, ts = lamina(Cartucho(), fase)
    for k, t in enumerate(ts):
        print("%2d  0x%02X  %s" % (k + 1, t, NOMBRES.get(t, "")))
    print(guarda_png(img, os.path.join(IMAGENES, "objetos.png"), escala=3))


if __name__ == "__main__":
    main()
