#!/usr/bin/env python3
"""Simon, montado desde las tablas como lo monta el cartucho: dos poses, la de
0xC42E (las piernas, abajo) y la de 0xC42F (el cuerpo y el latigo, encima).

  p00:56E1  los patrones: el RLE de 0xA281[piernas] a 0xF800 (sprites 0 y 1)
            y el de 0xA2D1[cuerpo] a 0xF840 (del 2 en adelante), banco 13.
  p01:7858  los atributos: la lista de 0x7985[piernas] o 0x79D5[cuerpo] es
            [cuantos] y, por sprite, lo que se suma a la Y y a la X de Simon
            (0xC425, 0xC427); la Y se guarda menos 2 y el patron es 4 por el
            numero de sprite. Con las piernas 6, 0x10, 0x1A o 0x24 (agachado)
            el cuerpo baja 6, o las piernas suben 6 si 0xC420 vale 1. Antes,
            p01:7841 esconde los sprites 4 a 7 (4 y 5 si lleva un arma desde la
            2, que usa los otros).
  p01:790C  los colores por linea: los sprites van a pares, el primero del
            color 1 y el segundo del 2 con CC (bit 6): donde se pisan salen del
            3. Parpadean con la invencibilidad (0x0E) y con la cuenta de
            0xC434 (8).
  El juego mira a la izquierda con otras poses: p01:765F suma 10 a las
  piernas y 15 al cuerpo.

Uso:  simon.py            docs/imagenes/simon.png (los pares que pone el codigo)
                          y simon_poses.png (todas las poses, cada mitad aparte)
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from graficos import (Cartucho, Vram, B123, B111213, IMAGENES,  # noqa: E402
                      rle_a_la_vram, rgb, guarda_png, habitacion)

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PATRONES_DE_LAS_PIERNAS = 0xA281     # banco 13, 40 punteros a RLE
PATRONES_DEL_CUERPO = 0xA2D1         # banco 13, 36 punteros
SPRITES_DE_LAS_PIERNAS = 0x7985      # banco 1, 40 punteros
SPRITES_DEL_CUERPO = 0x79D5          # banco 1, 36 punteros
AGACHADO = (6, 0x10, 0x1A, 0x24)
ATRIBUTOS, COLORES, PATRONES = 0xF600, 0xF400, 0xF800
N_PIERNAS, N_CUERPO = 40, 36


def carga_la_pose(cart, vram, piernas, cuerpo):
    """p00:56E1."""
    for tabla, pose, dest in ((PATRONES_DE_LAS_PIERNAS, piernas, 0xF800),
                              (PATRONES_DEL_CUERPO, cuerpo, 0xF840)):
        rle_a_la_vram(cart, B111213, dest, cart.palabra(tabla + 2 * pose, B111213), vram)


def coloca(cart, vram, piernas, cuerpo, x, y, arma=0, puerta=0, c420=0, escondido=False):
    """p01:7837: atributos y colores de Simon en la VRAM (la copia de 0xD400
    que p01:65A4 sube a 0xF400). `escondido` es el parpadeo de p01:78CC
    (0xC42D puesto y el bit 1 del contador de cuadros): la Y vale 0xE0.
    Devuelve cuantos sprites usa."""
    base = ATRIBUTOS + (0x20 if puerta == 5 else 0)
    if puerta != 5:
        for k in range(4 if arma < 2 else 2):
            vram.escribe(base + 0x10 + 4 * k, 0xE0)
    n = 0
    for tabla, pose, c, dest in ((SPRITES_DE_LAS_PIERNAS, piernas, 0, base),
                                 (SPRITES_DEL_CUERPO, cuerpo, 2, base + 8)):
        hl = cart.palabra(tabla + 2 * pose, B123)
        cuantos = cart.leer(hl, B123)
        hl += 1
        for _ in range(cuantos):
            b = (y + cart.leer(hl, B123)) & 0xFF
            if piernas in AGACHADO:
                if c420 == 1 and c < 2:
                    b = (b - 6) & 0xFF
                elif c420 != 1 and c >= 2:
                    b = (b + 6) & 0xFF
            if escondido:
                b = 0xE0
            yy = (b - 2) & 0xFF
            dx = cart.leer(hl + 1, B123)
            xx = x + dx - (0x100 if dx & 0x80 else 0)
            if not 0 <= xx < 256:
                yy = xx = 0xE0
            vram.escribe(dest, yy)
            vram.escribe(dest + 1, xx & 0xFF)
            vram.escribe(dest + 2, 4 * c)
            dest += 4
            hl += 2
            c += 1
        n = max(n, c)
    colores = COLORES + (0x80 if puerta == 5 else 0)
    for k in range(0x80 if arma < 2 else 0x40):
        vram.escribe(colores + k, 0x01 if (0x7F - k) & 0x10 else 0x42)
    return n


def pinta_sprites(vram, img, n, base=ATRIBUTOS, colores=COLORES, dy=0, dx=0, desde=0):
    """Modo 2, 16x16: por linea, el sprite de numero mas bajo gana; uno con
    CC (bit 6 del color de la linea) se suma (OR) a lo que ya haya puesto el
    anterior sin CC. La Y en pantalla es la del atributo mas uno; 0xD8 acaba."""
    lineas = {}
    for s in range(desde, n):
        y, x, p = (vram.v[base + 4 * s + i] for i in range(3))
        if y == 0xD8:
            break
        for j in range(16):
            cl = vram.v[colores + 16 * s + j]
            cc, color = cl & 0x40, cl & 0x0F
            fila = lineas.setdefault((y + 1 + j) & 0xFF, {})
            for mitad in range(2):
                b = vram.v[PATRONES + 8 * (p & 0xFC) + 16 * mitad + j]
                for i in range(8):
                    if not b & (0x80 >> i):
                        continue
                    px = x + 8 * mitad + i
                    if cc:
                        fila[px] = fila.get(px, 0) | color
                    elif px not in fila:
                        fila[px] = color
    for py, fila in lineas.items():
        for px, color in fila.items():
            if color and 0 <= py - dy < len(img) and 0 <= px - dx < len(img[0]):
                img[py - dy][px - dx] = rgb(vram.paleta, color)


# ------------------------------------------------------------ las poses del codigo
def poses_del_codigo():
    """Los pares (piernas, cuerpo) que el codigo pone con `ld de,XXYYh` y
    `ld (0c42eh),de`: E son las piernas y D el cuerpo."""
    pares = []
    with open(os.path.join(RAIZ, "src", "vampirekiller_p01.asm"), encoding="utf-8") as f:
        lineas = f.readlines()
    for k, linea in enumerate(lineas):
        if "ld (0c42eh),de" in linea:
            for atras in range(1, 6):
                m = re.match(r"\s*ld de,0?([0-9a-f]{2})([0-9a-f]{2})h", lineas[k - atras])
                if m:
                    par = (int(m.group(2), 16), int(m.group(1), 16))
                    if par not in pares:
                        pares.append(par)
                    break
    return pares


def hoja(cart, pares, fase=1):
    """Cada par de poses, mirando a la derecha y (debajo) a la izquierda, en
    casillas de 80 x 56 sobre gris, con la paleta de la primera habitacion de
    la fase (Simon usa los colores 1, 2 y 3)."""
    paleta = habitacion(cart, fase, 0)
    ancho, alto = 80, 56
    img = [[(40, 40, 40)] * (ancho * len(pares)) for _ in range(2 * alto)]
    for k, (piernas, cuerpo) in enumerate(pares):
        for fila, (p, c) in enumerate(((piernas, cuerpo),
                                       (piernas + 10 if piernas < 10 else piernas,
                                        cuerpo + 15 if cuerpo < 15 else cuerpo))):
            v = Vram()
            v.paleta = paleta.paleta
            carga_la_pose(cart, v, p, c)
            n = coloca(cart, v, p, c, 0x80, 0x80)
            pinta_sprites(v, img, n, dy=0x80 - 50 - fila * alto, dx=0x80 - 40 - k * ancho)
    return img


def hoja_de_poses(cart, fase=1):
    """Todas las poses que guarda el cartucho, cada mitad por su lado: arriba
    las 40 de las piernas (dos filas de 20) y debajo las 36 del cuerpo (dos
    de 18), en casillas de 80 x 48."""
    paleta = habitacion(cart, fase, 0)
    ancho, alto = 80, 48
    img = [[(40, 40, 40)] * (ancho * 20) for _ in range(4 * alto)]
    for k in range(N_PIERNAS + N_CUERPO):
        piernas = k if k < N_PIERNAS else 0
        cuerpo = k - N_PIERNAS if k >= N_PIERNAS else 0
        fila, col = (k // 20, k % 20) if k < N_PIERNAS else (2 + (k - N_PIERNAS) // 18, (k - N_PIERNAS) % 18)
        v = Vram()
        v.paleta = paleta.paleta
        carga_la_pose(cart, v, piernas, cuerpo)
        n = coloca(cart, v, piernas, cuerpo, 0x80, 0x80)
        if k < N_PIERNAS:
            pinta_sprites(v, img, 2, dy=0x80 - 40 - fila * alto, dx=0x80 - 40 - col * ancho)
        else:
            pinta_sprites(v, img, n, dy=0x80 - 56 - fila * alto, dx=0x80 - 40 - col * ancho, desde=2)
    return img


def main():
    cart = Cartucho()
    pares = poses_del_codigo()
    print(pares)
    print(guarda_png(hoja(cart, pares), os.path.join(IMAGENES, "simon.png"), 3))
    print(guarda_png(hoja_de_poses(cart), os.path.join(IMAGENES, "simon_poses.png"), 2))


if __name__ == "__main__":
    main()
