#!/usr/bin/env python3
"""Dracula entero, montado como lo monta el cartucho: la cosa del tipo 0x11
(banco 3) lleva ocho sprites -la cabeza arriba y los pies abajo, a pares con
CC- y el cuerpo, un dibujo de 32x32 que se copia al fondo.

  p03:AB22  nace con el dibujo 0x56 y sube; p03:AB86 lo baja 0x30 y lo deja
            de pie en el dibujo 0x5B.
  p03:AD37  los dibujos de pie, de 0xACAA: 0x5B y 0x5C mirando a la izquierda
            (Simon a su izquierda), 0x5D y 0x5E a la derecha.
  p03:AD45  los colores de los ocho sprites (0xAD53): 0x02 y 0x48 a pares.
  p03:AD80  antes de pintar el cuerpo guarda el fondo que pisa: HMMM de
            (x - 16, 0x91) de la pagina 0 a (0x80, 0x80) de la 1, 32x32.
  p03:AD93  cada cuadro, si 0xCE0E vale 1-4 (el dibujo menos 0x5A, p03:ADD2),
            copia con LMMM y TIMP (el 0 no pinta) el cuerpo de 0xADBC:
            (0, 0x80), (32, 0x80), (64, 0x80) o (96, 0x80) de la pagina 1 a
            (x - 16, 0x91) de la 0; con 5, el fondo guardado de vuelta.
            Esos cuatro son los dos dibujos de 32x32 de 0xB5A1 y 0xB719 (banco
            13), tal cual y del reves, que sube p00:57DF al entrar en la sala
            (graficos.carga_la_sala_de_dracula).
  p03:AC40  reaparece en una de las ocho x de 0xAC76, con la y de siempre.

Uso:  dracula.py      docs/imagenes/dracula.png (la sala, con Dracula de pie
                      en sus cuatro dibujos)
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from graficos import (Cartucho, Vram, B123, IMAGENES, habitacion, guarda_png, foto,  # noqa: E402
                      FILA_DE_LA_HABITACION)
from secretos import pinta_secretos  # noqa: E402
from simon import pinta_sprites, ATRIBUTOS, COLORES  # noqa: E402
from enemigos import compone  # noqa: E402

TIPO = 0x11
FASE, SALA = 18, 9
DE_PIE = (0x5B, 0x5C, 0x5D, 0x5E)    # 0xACAA
Y_DE_PIE = 0xC0                      # p03:AB92: la y al quedarse de pie
FILA_DEL_CUERPO = 0x91               # p03:AD86
CUERPOS = 0xADBC                     # banco 3: (x, y) de la pagina 1
FONDO_GUARDADO = (0x80, 0x80)        # p03:AD88
COLORES_DE_PIE = 0xAD53              # banco 3, ocho bytes
B3 = (1, 2, 3)
X_DE_LAS_APARICIONES = 0xAC76        # banco 3, ocho x


def cuerpo(cart, dibujo):
    """(x, y) en la pagina 1 del cuerpo de un dibujo de pie (p03:ADD2)."""
    k = dibujo - 0x5A - 1
    return cart.leer(CUERPOS + 2 * k + 1, B3), cart.leer(CUERPOS + 2 * k, B3)


def pasos_del_cuerpo(dibujo):
    """Los cuerpos que se pintan, uno encima de otro, hasta el de `dibujo`:
    p03:ABD4 pasa de 0x5B a 0x5C (o de 0x5D a 0x5E) sin devolver el fondo, y
    con TIMP quedan puntos del primero."""
    return (dibujo - 1, dibujo) if dibujo in (0x5C, 0x5E) else (dibujo,)


def pinta_el_cuerpo(cart, vram, dibujo, x):
    """p03:AD80 y p03:AD93 sobre la pagina 0 ya pintada."""
    x0 = (x - 16) & 0xFF
    fx, fy = FONDO_GUARDADO
    for j in range(32):
        for i in range(32):
            vram.pon_punto(1, fx + i, fy + j, vram.punto(0, x0 + i, FILA_DEL_CUERPO + j))
    for paso in pasos_del_cuerpo(dibujo):
        sx, sy = cuerpo(cart, paso)
        for j in range(32):
            for i in range(32):
                c = vram.punto(1, sx + i, sy + j)
                if c:                                # TIMP
                    vram.pon_punto(0, x0 + i, FILA_DEL_CUERPO + j, c)


def colores_de_pie(cart):
    return [cart.leer(COLORES_DE_PIE + k, B3) for k in range(8)]


def sprites(cart, dibujo, x, y=Y_DE_PIE):
    """[(y, x, patron, color)] de los ocho sprites de pie."""
    return [a[:3] + (c,) for a, c in zip(compone(cart, TIPO, dibujo, x, y, 8), colores_de_pie(cart))]


def la_sala(cart, dibujo, x, pasos_de_las_velas=(0,)):
    """La VRAM de la sala con Dracula de pie en (x, Y_DE_PIE)."""
    v = habitacion(cart, FASE, SALA)
    pinta_secretos(cart, v, FASE, SALA, pasos_de_las_velas)
    pinta_el_cuerpo(cart, v, dibujo, x)
    for s, (yy, xx, patron, color) in enumerate(sprites(cart, dibujo, x)):
        v.escribe(ATRIBUTOS + 4 * s, yy)
        v.escribe(ATRIBUTOS + 4 * s + 1, xx)
        v.escribe(ATRIBUTOS + 4 * s + 2, patron)
        for j in range(16):
            v.escribe(COLORES + 16 * s + j, color)
    v.escribe(ATRIBUTOS + 4 * 8, 0xD8)
    return v


def xs_de_las_apariciones(cart):
    return [cart.leer(X_DE_LAS_APARICIONES + k, B3) for k in range(8)]


def lamina(cart):
    """La sala cuatro veces, una por dibujo de pie, en dos filas."""
    fotos = []
    for dibujo in DE_PIE:
        x = 0xB0 if dibujo < 0x5D else 0x50           # Simon a un lado o al otro
        v = la_sala(cart, dibujo, x)
        img = foto(v)
        pinta_sprites(v, img, 9, dy=FILA_DE_LA_HABITACION)
        fotos.append(img)
    hueco = [(24, 24, 24)] * 8
    filas = []
    for a, b in ((0, 1), (2, 3)):
        for la, lb in zip(fotos[a], fotos[b]):
            filas.append(la + hueco + lb)
        filas.append([(24, 24, 24)] * len(filas[-1]))
    return filas[:-1]


def main():
    cart = Cartucho()
    print("x de las apariciones:", " ".join("0x%02X" % x for x in xs_de_las_apariciones(cart)))
    for d in DE_PIE:
        print("dibujo 0x%02X: cuerpo en (%d, 0x%02X) de la pagina 1" % ((d,) + cuerpo(cart, d)))
    print(guarda_png(lamina(cart), os.path.join(IMAGENES, "dracula.png"), 2))


if __name__ == "__main__":
    main()
