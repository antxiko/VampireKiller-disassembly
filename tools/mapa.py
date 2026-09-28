#!/usr/bin/env python3
"""El mapa de cada fase: sus habitaciones en la rejilla de 6 x 5 del propio
juego, montadas desde las tablas con lo que esconden, y sus salidas.

  p02:967A  la casilla de cada habitacion (0x9695, un byte por habitacion) en
            una rejilla de 6 columnas por 5 filas; la tabla de 0x9757 la pasa
            a la posicion del mapa que el juego pinta.
  p13:B99A  las salidas: dos bytes por habitacion, cuatro nibbles (arriba,
            abajo, izquierda, derecha) con la habitacion vecina, 0xF si no se
            sale por ahi. No siempre es la de al lado en la rejilla: las de
            los bordes se enlazan con la del otro lado.
  Cada habitacion se monta con tools/graficos.py y tools/secretos.py: las
  velas, los bloques que se rompen, los cofres, los objetos a la vista, las
  puertas cerradas y la puerta de salida de la fase.

Uso:  mapa.py [fase ...]      docs/imagenes/fase_NN.png (todas si no se dice)
      mapa.py lista <fase>    las habitaciones, sus casillas, salidas y secretos
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from graficos import (Cartucho, IMAGENES, B123, B111213, CASILLA_DE_CADA_HABITACION,  # noqa: E402
                      SALIDAS_DE_CADA_FASE, cuantas_habitaciones, habitacion, foto,
                      guarda_png)
from secretos import pinta_secretos, secretos  # noqa: E402

COLUMNAS, FILAS = 6, 5
ANCHO, ALTO = 256, 176
HUECO = 12
FONDO = (24, 24, 24)
SALIDA = (255, 220, 0)
SALIDA_LEJOS = (0, 200, 255)
LADOS = ("arriba", "abajo", "izquierda", "derecha")


def casillas(cart, fase):
    t = cart.palabra(CASILLA_DE_CADA_HABITACION + 2 * fase, B123)
    return [cart.leer(t + h, B123) for h in range(cuantas_habitaciones(cart, fase))]


def salidas(cart, fase):
    """[(arriba, abajo, izquierda, derecha)] por habitacion, None si no hay."""
    t = cart.palabra(SALIDAS_DE_CADA_FASE + 2 * fase, B111213)
    fuera = []
    for h in range(cuantas_habitaciones(cart, fase)):
        b0, b1 = cart.leer(t + 2 * h, B111213), cart.leer(t + 2 * h + 1, B111213)
        fuera.append(tuple(None if n == 0xF else n for n in (b0 >> 4, b0 & 0xF, b1 >> 4, b1 & 0xF)))
    return fuera


def _vecina_en_la_rejilla(cas, h, lado):
    c, f = cas[h] % COLUMNAS, cas[h] // COLUMNAS
    dc, df = ((0, -1), (0, 1), (-1, 0), (1, 0))[lado]
    return (c + dc, f + df)


def _marca(img, x, y, ancho, alto, color):
    for j in range(alto):
        for i in range(ancho):
            if 0 <= y + j < len(img) and 0 <= x + i < len(img[0]):
                img[y + j][x + i] = color


def lamina_de_la_fase(cart, fase):
    cas, sal = casillas(cart, fase), salidas(cart, fase)
    usadas_c = sorted({k % COLUMNAS for k in cas})
    usadas_f = sorted({k // COLUMNAS for k in cas})
    c0, f0 = usadas_c[0], usadas_f[0]
    nc, nf = usadas_c[-1] - c0 + 1, usadas_f[-1] - f0 + 1
    w, h = nc * (ANCHO + HUECO) + HUECO, nf * (ALTO + HUECO) + HUECO
    img = [[FONDO] * w for _ in range(h)]
    for hab, k in enumerate(cas):
        c, f = k % COLUMNAS - c0, k // COLUMNAS - f0
        x0, y0 = HUECO + c * (ANCHO + HUECO), HUECO + f * (ALTO + HUECO)
        v = habitacion(cart, fase, hab)
        pinta_secretos(cart, v, fase, hab)
        fo = foto(v)
        for y in range(ALTO):
            img[y0 + y][x0:x0 + ANCHO] = fo[y]
        # las salidas: una marca en el borde, amarilla si la vecina esta al
        # lado en la rejilla y azul si esta en otro sitio
        for lado, vecina in enumerate(sal[hab]):
            if vecina is None:
                continue
            lejos = vecina >= len(cas) or (cas[vecina] % COLUMNAS, cas[vecina] // COLUMNAS) != _vecina_en_la_rejilla(cas, hab, lado)
            color = SALIDA_LEJOS if lejos else SALIDA
            if lado == 0:
                _marca(img, x0 + ANCHO // 2 - 16, y0 - HUECO // 2 - 2, 32, 4, color)
            elif lado == 1:
                _marca(img, x0 + ANCHO // 2 - 16, y0 + ALTO + HUECO // 2 - 2, 32, 4, color)
            elif lado == 2:
                _marca(img, x0 - HUECO // 2 - 2, y0 + ALTO // 2 - 16, 4, 32, color)
            else:
                _marca(img, x0 + ANCHO + HUECO // 2 - 2, y0 + ALTO // 2 - 16, 4, 32, color)
    return img


def lista(cart, fase):
    cas, sal = casillas(cart, fase), salidas(cart, fase)
    for h in range(len(cas)):
        print("habitacion %d: casilla %d (columna %d, fila %d), salidas %s"
              % (h, cas[h], cas[h] % COLUMNAS, cas[h] // COLUMNAS,
                 ", ".join("%s a la %d" % (LADOS[l], v) for l, v in enumerate(sal[h]) if v is not None) or "ninguna"))
        for e in secretos(cart, fase, h):
            print("    ", {k: v for k, v in e.items() if k != "bytes"})


def main():
    cart = Cartucho()
    if sys.argv[1:2] == ["lista"]:
        lista(cart, int(sys.argv[2]))
        return
    fases = [int(a) for a in sys.argv[1:]] or list(range(19))
    for fase in fases:
        print(guarda_png(lamina_de_la_fase(cart, fase), os.path.join(IMAGENES, "fase_%02d.png" % fase)))


if __name__ == "__main__":
    main()
