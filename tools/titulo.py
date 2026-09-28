#!/usr/bin/env python3
"""Las dos pantallas del principio, montadas desde las tablas como las monta el
cartucho: el logotipo de Konami y la pantalla del titulo, que cambia con el
byte 0x002B de la BIOS (cero en Japon).

  p01:6202  EL LOGOTIPO DE KONAMI: la paleta base (0xBF88) con la de 0x623C,
            52 letras de 1 bit coloreadas (p00:530F: 13 de color 1, 13 de color
            2 y 26 de color 3, del banco 13) en la pagina 1 desde (8, 0), y el
            guion de 0x628F las coloca en (0x40, 0x40) de la misma pagina
            (p01:626F, HMMM de 8x8). El telon (p01:624C) lo copia a la pagina 0
            de linea en linea hasta 0x30 lineas de 0xA8 puntos desde (0x28, 0x40).
  p00:4D47  EL TITULO: la pagina 0 en negro, la paleta base con el color 15 en
            azul (p00:4D74), las letras de 0xBD80 (p00:53B6), los dibujos del
            titulo (p00:59FB: 0x11 de 0xAC80 y, detras, 0x59 de 0xB260 o, en
            Japon, 0x1E de 0xAEA0 y los patrones de sprite del RLE de 0xBBF6),
            la banda azul (0, 0x10) de 256 x 0x68 y dos filas de dieciseis
            muescas (p01:7ACF). El nombre va por filas de dibujos (p01:7B32,
            LMMM con transparencia): 0x4C99 y 0x4C38 fuera de Japon, 0x4C38 y
            0x4C53 en Japon, y alli ademas once pares de sprites (p01:7AEF:
            0x7B52, rojo el primero de cada par y negro el segundo, porque el
            color 2 pasa a negro). Debajo, el rotulo de 0x4D08.

Uso:  titulo.py            docs/imagenes/konami.png, titulo.png y titulo_japon.png
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from graficos import (Cartucho, Vram, B123, B910, B111213, IMAGENES, ANCHO_DE_LINEA,  # noqa: E402
                      PALETA_BASE, pon_paleta, sube_dibujos, rle_a_la_vram, rgb, guarda_png)

B78 = (1, 7, 8)
PALETA_DE_KONAMI = 0x623C            # banco 1
LOGOTIPO_DE_KONAMI = 0x628F          # banco 1
SPRITES_DEL_TITULO = 0x7B52          # banco 1
ATRIBUTOS, COLORES, PATRONES = 0xF600, 0xF400, 0xF800   # R#5/R#11, R#6


# ------------------------------------------------------------ las piezas
def sube_letras(cart, bancos, hl, x, y, n, color, vram):
    """p00:4A27: n caracteres de 1 bit (8 bytes) a 4 bits del color dado
    (p00:4AA5), en la pagina 1 desde (x, y), de ocho en ocho puntos; al pasar
    del borde, ocho lineas mas abajo (p00:4B4F)."""
    for _ in range(n):
        for fila in range(8):
            b = cart.leer(hl + fila, bancos)
            for k in range(4):
                izq = color if b & (0x80 >> (2 * k)) else 0
                der = color if b & (0x40 >> (2 * k)) else 0
                vram.escribe(0x8000 + (y + fila) * ANCHO_DE_LINEA + (x >> 1) + k, (izq << 4) | der)
        hl += 8
        x = (x + 8) & 0xFF
        if x == 0:
            y += 8


def rellena(vram, x, y, ancho, alto, byte, pagina=0):
    """p00:490A, HMMV: de byte en byte (la x y el ancho, pares); 0 es 256."""
    ancho, alto = ancho or 256, alto or 256
    for j in range(alto):
        for i in range(ancho >> 1):
            vram.escribe(pagina * 0x8000 + ((y + j) & 0xFF) * ANCHO_DE_LINEA + (x >> 1) + i, byte)


def copia(vram, sx, sy, dx, dy, ancho, alto, origen, destino, transparente=False):
    """p00:4946 (HMMM) y p00:49DB con TIMP (el color 0 no se copia)."""
    for j in range(alto):
        for i in range(ancho):
            c = vram.punto(origen, sx + i, sy + j)
            if c or not transparente:
                vram.pon_punto(destino, dx + i, dy + j, c)


def _celda(k):
    """p00:4B41: el dibujo k de la pagina 1."""
    return (k & 0x1F) * 8, (k >> 5) * 8


def por_filas(cart, hl, x, y, vram, pinta):
    """p01:626F y p01:7B32: dibujos de izquierda a derecha; 0xFE [dx] vuelve
    al principio de la fila, corre dx y baja ocho; 0xFF acaba."""
    x0 = x
    while True:
        k = cart.leer(hl, B123)
        hl += 1
        if k == 0xFF:
            return
        if k == 0xFE:
            x0 = (x0 + cart.leer(hl, B123)) & 0xFF
            hl += 1
            x, y = x0, y + 8
            continue
        pinta(k, x, y)
        x = (x + 8) & 0xFF


def rotulo(cart, hl, vram):
    """p00:4ACB: [x][y] y caracteres, 0xFE otra posicion, 0xFF acaba; el
    caracter k sale de la fuente de la pagina 1, que empieza en la linea
    0x38; el 0, del (0, 0)."""
    x, y = cart.leer(hl, B123), cart.leer(hl + 1, B123)
    hl += 2
    while True:
        k = cart.leer(hl, B123)
        hl += 1
        if k == 0xFF:
            return
        if k == 0xFE:
            x, y = cart.leer(hl, B123), cart.leer(hl + 1, B123)
            hl += 2
            continue
        sx, sy = (0, 0) if k == 0 else (_celda(k)[0], _celda(k)[1] + 0x38)
        copia(vram, sx, sy, x, y, 8, 8, 1, 0)
        x = (x + 8) & 0xFF


def pon_un_color(vram, c, rb, g):
    """p00:4814."""
    vram.paleta[c] = ((rb >> 4) & 7, g & 7, rb & 7)


# ------------------------------------------------------------ las pantallas
def konami(cart):
    vram = Vram()
    pon_paleta(cart, B910, PALETA_BASE, vram)
    pon_paleta(cart, B123, PALETA_DE_KONAMI, vram)
    rellena(vram, 0x28, 0x40, 0xA8, 0x48, 0, pagina=1)
    sube_letras(cart, B111213, 0xBE59, 0x08, 0, 0x0D, 1, vram)
    sube_letras(cart, B111213, 0xBEC1, 0x70, 0, 0x0D, 2, vram)
    sube_letras(cart, B111213, 0xBF29, 0xD8, 0, 0x1A, 3, vram)
    por_filas(cart, LOGOTIPO_DE_KONAMI, 0x40, 0x40, vram,
              lambda k, x, y: copia(vram, *_celda(k), x, y, 8, 8, 1, 1))
    copia(vram, 0x28, 0x40, 0x28, 0x40, 0xA8, 0x30, 1, 0)    # el telon, acabado
    return vram


def titulo(cart, japon=False):
    vram = Vram()
    rellena(vram, 0, 0, 0, 0, 0)                               # p00:4DDB
    pon_paleta(cart, B910, PALETA_BASE, vram)
    pon_un_color(vram, 15, 0x07, 0x00)                         # p00:4D74: azul
    # p00:53B6
    sube_letras(cart, B78, 0xBED8, 0, 0, 1, 0, vram)
    sube_letras(cart, B78, 0xBD80, 0, 0x40, 0x30, 0x0E, vram)
    sube_dibujos(cart, B78, 0xBF00, 0xA440, 1, vram)
    # p00:59FB
    sube_dibujos(cart, B78, 0xAC80, 0x8004, 0x11, vram)
    if japon:
        sube_dibujos(cart, B78, 0xAEA0, 0x8048, 0x1E, vram)
        rle_a_la_vram(cart, B111213, cart.palabra(0xBBF6, B111213), 0xBBF8, vram)
    else:
        sube_dibujos(cart, B78, 0xB260, 0x8048, 0x59, vram)
    rellena(vram, 0, 0x10, 0, 0x68, 0xFF)
    for y in (0x16, 0x69):                                      # p01:7ACF
        for k in range(16):
            rellena(vram, 5 + 16 * k, y, 7, 9, 0x02)
    pinta = lambda k, x, y: copia(vram, *_celda(k), x, y, 8, 8, 1, 0, transparente=True)  # noqa: E731
    if japon:
        por_filas(cart, 0x4C38, 0xA8, 0x18, vram, pinta)
        por_filas(cart, 0x4C53, 0xA0, 0x38, vram, pinta)
        sprites_del_titulo(cart, vram)
        pon_un_color(vram, 2, 0x00, 0x00)                      # p01:7B27
    else:
        por_filas(cart, 0x4C99, 0x38, 0x28, vram, pinta)
        por_filas(cart, 0x4C38, 0xB8, 0x30, vram, pinta)
    rotulo(cart, 0x4D08, vram)
    return vram


def sprites_del_titulo(cart, vram):
    """p01:7AEF y p01:65A4: once pares (y, x) de 0x7B52, cada uno dos sprites
    de 16x16 con los patrones 4n y 4n + 4; colores de linea 8 y 2."""
    n = 0
    for k in range(11):
        y, x = cart.leer(SPRITES_DEL_TITULO + 2 * k, B123), cart.leer(SPRITES_DEL_TITULO + 2 * k + 1, B123)
        for color in (8, 2):
            for i, v in enumerate((y, x, 4 * n, 0)):
                if i < 3:
                    vram.escribe(ATRIBUTOS + 4 * n + i, v & 0xFF)
            for j in range(16):
                vram.escribe(COLORES + 16 * n + j, color)
            n += 1
    return n


def pinta_sprites(vram, img, n):
    """Los n primeros sprites (modo 2, 16x16, color por linea), el de numero
    mas bajo encima; la y en pantalla es la del atributo mas uno."""
    for s in reversed(range(n)):
        y, x, p = (vram.v[ATRIBUTOS + 4 * s + i] for i in range(3))
        for j in range(16):
            color = vram.v[COLORES + 16 * s + j] & 0x0F
            if not color:
                continue
            for mitad in range(2):
                b = vram.v[PATRONES + 8 * (p & 0xFC) + 16 * mitad + j]
                for i in range(8):
                    if b & (0x80 >> i):
                        px, py = x + 8 * mitad + i, y + 1 + j
                        if 0 <= px < 256 and 0 <= py < len(img):
                            img[py][px] = rgb(vram.paleta, color)


def pantalla(vram, sprites=0):
    img = [[rgb(vram.paleta, vram.punto(0, x, y)) for x in range(256)] for y in range(212)]
    pinta_sprites(vram, img, sprites)
    return img


def main():
    cart = Cartucho()
    print(guarda_png(pantalla(konami(cart)), os.path.join(IMAGENES, "konami.png"), 2))
    print(guarda_png(pantalla(titulo(cart)), os.path.join(IMAGENES, "titulo.png"), 2))
    print(guarda_png(pantalla(titulo(cart, True), 22), os.path.join(IMAGENES, "titulo_japon.png"), 2))


if __name__ == "__main__":
    main()
