#!/usr/bin/env python3
"""La tienda de los vendedores, pintada como la pinta el cartucho.

  p02:9387  al abrirse: lo que vende (0xC708, de su hueco en 0xDE00) y su
            precio (0xC707), y la ventana.
  p02:9418  el precio, de la tabla de 0x9428 (nueve objetos x sin libro,
            libro blanco -bit 7 de 0xC702- y libro rojo -bit 6-), en BCD.
  p02:9397  la ventana: 0x50 x 0x20 puntos, 0x18 por encima del vendedor y
            0x10 a su izquierda (0x20 si esta en la mitad derecha); borrada a
            color 0 y con un marco del color 0x0E (p00:5D0E); dentro, en
            (0x38, 6), otro marco de 0x13 x 0x14 para el objeto; los rotulos
            de 0x9485 en (8, 4) y 0x948A en (8, 0x10), letras de la fuente de
            la pagina 1 (p00:4AE7); el precio en (0x18, 0x10), dos cifras
            (p00:4578, la letra 0x20 + cifra), y el dibujo del objeto en
            (0x39, 8) con transparencia (p02:8CC1).
  p02:9249  el vendedor, al acabar de parpadear, se queda con el dibujo del
            desenlace (0x9320): el 1 para la tienda, el viejo rojo.

  python tools/tienda.py            docs/imagenes/tienda.png (el baston de
                                    la fase 4, sin libro, con el blanco y con
                                    el rojo) y vendedores.png
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from graficos import (Cartucho, B123, IMAGENES, FILA_DE_LA_HABITACION,  # noqa: E402
                      habitacion, foto, guarda_png, rgb)
from titulo import sube_letras, rellena, copia, _celda, B78  # noqa: E402
from graficos import sube_dibujos  # noqa: E402
from secretos import pinta_secretos, secretos, pinta_objeto  # noqa: E402

LO_QUE_VENDEN = 0x9428               # banco 2: [objeto][sin libro][blanco][rojo]
ROTULOS = ((0x9485, 8, 4), (0x948A, 8, 0x10))
DIBUJO_DE_CADA_DESENLACE = 0x9320    # banco 2
FILA_DEL_VENDEDOR = 0xA0             # pagina 1: el dibujo A en (A * 32, 0xA0)
LIBROS = {0: 0, "blanco": 0x80, "rojo": 0x40}
MARCO = 0x0E


def precio(cart, objeto, c702):
    """p02:9409 y p02:9418."""
    for k in range(9):
        a = LO_QUE_VENDEN + 4 * k
        if cart.leer(a, B123) == objeto:
            if c702 & 0x80:
                return cart.leer(a + 2, B123)
            if c702 & 0x40:
                return cart.leer(a + 3, B123)
            return cart.leer(a + 1, B123)
    return None


def sube_la_fuente(cart, vram):
    """p00:53B6: el caracter 0 en (0, 0), 0x30 letras del color 0x0E desde
    (0, 0x40) y un dibujo en (0x80, 0x48) de la pagina 1."""
    sube_letras(cart, B78, 0xBED8, 0, 0, 1, 0, vram)
    sube_letras(cart, B78, 0xBD80, 0, 0x40, 0x30, 0x0E, vram)
    sube_dibujos(cart, B78, 0xBF00, 0xA440, 1, vram)


def letra(vram, k, x, y):
    """p00:4AE7: el caracter k (el 0 es el de (0, 0)), copiado tal cual."""
    sx, sy = (0, 0) if k == 0 else (_celda(k)[0], _celda(k)[1] + 0x38)
    copia(vram, sx, sy, x, y, 8, 8, 1, 0)


def raya(vram, x, y, largo, vertical, color):
    """p00:48A8 / p00:4888: LINE de `largo` puntos (NX = largo - 1)."""
    for i in range(largo):
        vram.pon_punto(0, x if vertical else x + i, y + i if vertical else y, color)


def marco(vram, x, y, ancho, alto, color):
    """p00:48DC."""
    raya(vram, x, y, alto, True, color)
    raya(vram, x, y, ancho, False, color)
    raya(vram, x, y + alto - 1, ancho, False, color)
    raya(vram, x + ancho - 1, y, alto, True, color)


def pinta_vendedor(vram, dibujo, x, y):
    """p02:925E: 32 x 32 de la fila 0xA0 de la pagina 1, con TIMP."""
    copia(vram, dibujo * 32, FILA_DEL_VENDEDOR, x, y, 32, 32, 1, 0, transparente=True)


def sitio_de_la_ventana(vx, vy):
    """p02:93A8."""
    return ((vx - 0x20) if vx >= 0x80 else (vx - 0x10)) & 0xFF, (vy - 0x18) & 0xFF


def pinta_la_ventana(cart, vram, vx, vy, objeto, c702):
    x, y = sitio_de_la_ventana(vx, vy)
    rellena(vram, x, y, 0x50, 0x20, 0)
    marco(vram, x, y, 0x50, 0x20, MARCO)
    marco(vram, x + 0x38, y + 6, 0x13, 0x14, MARCO)
    for hl, dx, dy in ROTULOS:
        px = x + dx
        while True:
            k = cart.leer(hl, B123)
            if k == 0xFF:
                break
            letra(vram, k, px, y + dy)
            px = (px + 8) & 0xFF
            hl += 1
    p = precio(cart, objeto, c702)
    letra(vram, 0x20 + (p >> 4), x + 0x18, y + 0x10)
    letra(vram, 0x20 + (p & 0x0F), x + 0x20, y + 0x10)
    pinta_objeto(vram, objeto, x + 0x39, y + 8)
    return (x, y), p


def la_tienda(cart, fase, hab, c702):
    """La pantalla con la tienda abierta: la habitacion, sus secretos, el
    vendedor en rojo y la ventana."""
    vram = habitacion(cart, fase, hab)
    sube_la_fuente(cart, vram)
    lista = pinta_secretos(cart, vram, fase, hab)
    v = [e for e in lista if e["que"] == "vendedor" or "clase" in e][0]
    tienda = cart.leer(DIBUJO_DE_CADA_DESENLACE + 0, B123)
    pinta_vendedor(vram, tienda, v["x"], v["y"])
    ventana, p = pinta_la_ventana(cart, vram, v["x"], v["y"], v["vende"], c702)
    return vram, v, ventana, p


def main():
    cart = Cartucho()
    fase, hab = 4, 1
    filas = []
    for libro in (0, 0x80, 0x40):
        vram, v, (x, y), p = la_tienda(cart, fase, hab, libro)
        img = foto(vram)
        # la ventana y el vendedor, con ocho puntos de margen
        x0 = min(x, v["x"]) - 8
        x1 = max(x + 0x50, v["x"] + 32) + 8
        y0 = y - FILA_DE_LA_HABITACION - 8
        y1 = v["y"] + 32 - FILA_DE_LA_HABITACION + 8
        filas.append([fila[x0:x1] for fila in img[y0:y1]])
        print("libro %02X: precio %X" % (libro, p))
    hueco = [(0, 0, 0)] * 8
    img = [a + hueco + b + hueco + c for a, b, c in zip(*filas)]
    print(guarda_png(img, os.path.join(IMAGENES, "tienda.png"), escala=3))
    # los cinco dibujos del vendedor, con la paleta de esta fase
    vram = habitacion(cart, fase, hab)
    img = [[rgb(vram.paleta, vram.punto(1, x, y)) for x in range(160)]
           for y in range(FILA_DEL_VENDEDOR, FILA_DEL_VENDEDOR + 32)]
    print(guarda_png(img, os.path.join(IMAGENES, "vendedores.png"), escala=3))


if __name__ == "__main__":
    main()
