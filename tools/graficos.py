#!/usr/bin/env python3
"""Las habitaciones del castillo, montadas desde las tablas como las monta el
cartucho, sin ejecutar ni una instruccion suya.

El juego corre en SCREEN 5 (p00:4B61) y guarda en la pagina 1 de la VRAM
(0x8000-0xFFFF) un almacen de DIBUJOS de 8x8 puntos a 4 bits: el dibujo k
esta en x = (k % 32) * 8, y = (k / 32) * 8 (p00:4B41). Cada fase carga los
suyos y cada habitacion se monta con ellos:

  p00:564C  los 191 dibujos del decorado de la fase (0x5742 apunta a ellos,
            en los bancos 4-5-6 o 7-8): 32 bytes cada uno, ocho filas de
            cuatro bytes, subidos de uno en uno desde 0x8004 (p00:4A51/4A66).
  p00:570D  la paleta: la base de 0xBF88 y encima la de la fase (0xBEA7),
            listas de [color][RB][G] hasta 0xFF (p00:483E).
  p00:5783  la carga de la habitacion: la entrada [guion][paleta] de su fase
            (0x9AB0, banco 9). El guion (p00:4714) trae tramos: 0x00 un RLE a
            la VRAM (p00:46F1: 0 acaba, 1-0x7F repite el byte que sigue,
            0x80 cambia de destino, 0x81-0xFF copia esos bytes), 0x01 voltea
            sprites ya subidos (p00:473E), otro valor copia bytes tal cual.
            Despues, la paleta de la habitacion.
  p00:4FB6  el montaje: la habitacion son 8 x 6 bloques de 32x32 (48 bytes,
            0x6013 del banco 11) y cada bloque 4 x 4 dibujos (16 bytes, el
            juego de bloques de la fase, 0x7EBB). Sale un bufer de 32 celdas
            por fila.
  p00:4F91  y la pintada: 22 filas de 32 celdas, cada una un HMMM de 8x8 de
            la pagina 1 a la 0, desde la fila 32 de la pantalla (p00:4B0B).

Uso:  graficos.py <fase> <habitacion> [salida.png]
"""
import os
import struct
import sys
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from paginas import ORG, TAM_PAGINA, N_PAGINAS  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ROM = os.path.join(RAIZ, "vampirekiller.rom")
IMAGENES = os.path.join(RAIZ, "docs", "imagenes")

B123, B456, B78, B910, B111213 = (1, 2, 3), (4, 5, 6), (4, 7, 8), (1, 9, 10), (11, 12, 13)
DIBUJOS_DE_CADA_FASE = 0x5742        # banco 0
PRIMER_DIBUJO = 0x8004               # VRAM: el dibujo 1 (el 0 queda en negro)
N_DIBUJOS = 0xBF
PALETA_BASE = 0xBF88                 # banco 10
PALETA_DE_LA_ESCENA = 0xBFA1         # banco 10, p00:5733
PALETA_DE_CADA_FASE = 0xBEA7         # banco 10
HABITACIONES_DE_CADA_FASE = 0x9AB0   # banco 9
PRIMERA_HABITACION = 0x6000          # banco 11
HABITACIONES = 0x6013                # banco 11
BLOQUES_DE_CADA_FASE = 0x7EBB        # banco 11
SALIDAS_DE_CADA_FASE = 0xB9D3        # banco 13
CASILLA_DE_CADA_HABITACION = 0x9695  # banco 2
POSICION_DE_CADA_CASILLA = 0x9757    # banco 2
PAGINA_1 = 0x8000
ANCHO_DE_LINEA = 128                 # bytes por linea en SCREEN 5
FILA_DE_LA_HABITACION = 32           # p00:4F94: la pintada empieza en y = 0x20
FILAS_PINTADAS = 22                  # p00:4F97
PRIMERA_FILA_PINTADA = 2             # el bufer es 0xD100 (p00:4F83) y se pinta desde 0xD140 (p00:4F91)


class Cartucho:
    """Los 128 KB con el mapper puesto: `bancos` es (b6000, b8000, bA000)."""

    def __init__(self, ruta=ROM):
        with open(ruta, "rb") as f:
            self.rom = f.read()
        if len(self.rom) != TAM_PAGINA * N_PAGINAS:
            raise SystemExit("la ROM mide %d bytes y no %d" % (len(self.rom), TAM_PAGINA * N_PAGINAS))

    def leer(self, addr, bancos):
        if 0x4000 <= addr < 0x6000:
            b = 0
        elif 0x6000 <= addr < 0xC000:
            b = bancos[(addr - 0x6000) >> 13]
        elif 0xC000 <= addr < 0x10000:
            # p00:54E4 lee 640 bytes desde 0xBDC8 y se pasa 0x48 al otro lado
            # del cartucho: eso es RAM, y aqui vale cero
            return 0
        else:
            raise ValueError("%#06x no cae en el cartucho" % addr)
        return self.rom[b * TAM_PAGINA + (addr & 0x1FFF)]

    def palabra(self, addr, bancos):
        return self.leer(addr, bancos) | (self.leer(addr + 1, bancos) << 8)


def bancos_de_los_dibujos(fase):
    """p00:564C: el trio 4-5-6, y de la fase 13 en adelante el 7 y el 8."""
    return B78 if fase >= 13 else B456


class Vram:
    """Los 128 KB del V9938 y la paleta, con la cuenta de lo tocado."""

    def __init__(self):
        self.v = bytearray(0x20000)
        self.tocado = bytearray(0x20000)
        self.paleta = [(0, 0, 0)] * 16

    def escribe(self, a, valor):
        a &= 0x1FFFF
        self.v[a] = valor
        self.tocado[a] = 1

    def punto(self, pagina, x, y):
        b = self.v[pagina * 0x8000 + y * ANCHO_DE_LINEA + (x >> 1)]
        return b >> 4 if x & 1 == 0 else b & 0x0F

    def pon_punto(self, pagina, x, y, c):
        a = pagina * 0x8000 + y * ANCHO_DE_LINEA + (x >> 1)
        b = self.v[a]
        self.escribe(a, (c << 4) | (b & 0x0F) if x & 1 == 0 else (b & 0xF0) | c)


# ------------------------------------------------------------ los lectores
def rle_a_la_vram(cart, bancos, dest, de, vram):
    """p00:46F1. Devuelve donde se quedo el guion."""
    while True:
        b = cart.leer(de, bancos)
        de += 1
        if b == 0:
            return de
        n = b & 0x7F
        if n == b:                            # bit 7 claro: repetir
            v = cart.leer(de, bancos)
            de += 1
            for _ in range(n):
                vram.escribe(dest, v)
                dest += 1
        elif n == 0:                          # 0x80: otro destino
            dest = cart.palabra(de, bancos)
            de += 2
        else:                                 # bit 7 puesto: tal cual
            for _ in range(n):
                vram.escribe(dest, cart.leer(de, bancos))
                de += 1
                dest += 1


def copia_a_la_vram(cart, bancos, dest, de, n, vram):
    for k in range(n):
        vram.escribe(dest + k, cart.leer(de + k, bancos))


def _bits_del_reves(b):
    r = 0
    for _ in range(8):
        r = (r << 1) | (b & 1)
        b >>= 1
    return r


def voltea_sprites(vram, de, n, dest):
    """p00:473E: n bloques de 32 bytes leidos de la VRAM en `de`, cada uno con
    sus dos mitades cambiadas y los bits de cada byte del reves -un sprite de
    16x16 mirando al otro lado-, escritos en `dest`."""
    fuera = bytearray()
    for k in range(n):
        b = vram.v[de + 32 * k:de + 32 * k + 32]
        fuera += bytes(_bits_del_reves(x) for x in b[16:]) + bytes(_bits_del_reves(x) for x in b[:16])
    for k, x in enumerate(fuera):
        vram.escribe(dest + k, x)


def guion_de_carga(cart, bancos, hl, vram):
    """p00:4714."""
    while True:
        mando = cart.leer(hl, bancos)
        hl += 1
        if mando == 0xFF:
            return
        if mando == 0x00:
            de = cart.palabra(hl, bancos)
            dest = cart.palabra(hl + 2, bancos)
            hl += 4
            rle_a_la_vram(cart, bancos, dest, de, vram)
        elif mando == 0x01:
            de = cart.palabra(hl, bancos)
            n = cart.leer(hl + 2, bancos)
            dest = cart.palabra(hl + 3, bancos)
            hl += 5
            voltea_sprites(vram, de, n, dest)
        else:
            de = cart.palabra(hl, bancos)
            n = cart.palabra(hl + 2, bancos)
            dest = cart.palabra(hl + 4, bancos)
            hl += 6
            copia_a_la_vram(cart, bancos, dest, de, n, vram)


def pon_paleta(cart, bancos, hl, vram):
    """p00:483E: [color][RB][G] hasta 0xFF; tres bits por componente."""
    while True:
        c = cart.leer(hl, bancos)
        if c == 0xFF:
            return
        rb, g = cart.leer(hl + 1, bancos), cart.leer(hl + 2, bancos)
        vram.paleta[c & 0x0F] = ((rb >> 4) & 7, g & 7, rb & 7)
        hl += 3


def sube_dibujos(cart, bancos, hl, dest, n, vram):
    """p00:4A66: n dibujos de 32 bytes, cada uno ocho filas de cuatro bytes
    (128 por linea), de cuatro en cuatro bytes a la derecha y, al llegar al
    borde, ocho lineas mas abajo."""
    for _ in range(n):
        for fila in range(8):
            for k in range(4):
                vram.escribe(dest + fila * ANCHO_DE_LINEA + k, cart.leer(hl, bancos))
                hl += 1
        e = (dest & 0xFF) + 4
        if e == 0x80:
            dest = ((dest >> 8) + 4) << 8
        else:
            dest = (dest & 0xFF00) | e


def sube_dibujos_de_16(cart, bancos, hl, dest, n, vram):
    """p00:4A90: n dibujos de 16x16 (128 bytes: dieciseis filas de ocho), de
    ocho en ocho bytes a la derecha y, al borde, dieciseis lineas mas abajo."""
    for _ in range(n):
        for fila in range(16):
            for k in range(8):
                vram.escribe(dest + fila * ANCHO_DE_LINEA + k, cart.leer(hl, bancos))
                hl += 1
        e = (dest & 0xFF) + 8
        if e == 0x80:
            dest = ((dest >> 8) + 8) << 8
        else:
            dest = (dest & 0xFF00) | e


def hmmc(cart, bancos, hl, x, y, ancho, alto, pagina, vram):
    """p00:498A: ancho x alto puntos de la ROM a la VRAM en (x, y) de la pagina."""
    for fila in range(alto):
        for k in range(ancho // 2):
            vram.escribe(pagina * 0x8000 + (y + fila) * ANCHO_DE_LINEA + (x >> 1) + k,
                         cart.leer(hl, bancos))
            hl += 1


def carga_los_dibujos_de_los_objetos(cart, vram=None):
    """p00:548D, al empezar la partida: los dibujos de 16x16 de los objetos y
    las armas en las filas 0x50 a 0x7F de la pagina 1 (los 20 de 0x9000 del
    banco 9 desde 0xA800, uno mas en 0xB028, los 8 de 0xB9C8 del banco 6 desde
    0xB030 y los 5 de 0xBDC8 desde 0xB800, entre ellos las velas), y dos
    piezas por HMMC."""
    vram = vram or Vram()
    sube_dibujos_de_16(cart, B910, 0x9000, 0xA800, 0x14, vram)
    sube_dibujos_de_16(cart, B910, 0x9A00, 0xB028, 1, vram)
    hmmc(cart, B910, 0x9A80, 0x8C, 0x70, 8, 4, 1, vram)
    for k in range(4):
        hmmc(cart, B910, 0x9A90, 0x80 + 8 * k, 0x74, 8, 8, 1, vram)
    sube_dibujos_de_16(cart, B456, 0xB9C8, 0xB030, 8, vram)
    sube_dibujos_de_16(cart, B456, 0xBDC8, 0xB800, 5, vram)
    carga_las_puertas(cart, vram)
    return vram


PUERTA_SIN_COLOR = 0xBDA7            # banco 10: 256 bytes, el 0xF es "el color"
COLORES_DE_LAS_PUERTAS = (3, 8, 2, 14, 15)   # p00:558E
PIEZAS_DE_LA_PUERTA_GRANDE = 0x556E  # banco 0: 16 punteros a la RAM de 0xE800
PRIMERA_PUERTA = 0xD000              # VRAM: (0, 0xA0) de la pagina 1


def carga_las_puertas(cart, vram):
    """p00:54F0: la puerta de 32x32 de 0xBDA7 -ocho dibujos de 8x8 con el
    nibble 0xF de comodin- coloreada cinco veces (p00:550D, un color por
    vuelta) y subida como 4 x 4 piezas (p00:5548) en la fila 0xA0 de la
    pagina 1, una puerta cada 32 puntos. La cuarta, la blanca (color 14), es
    la puerta cerrada de las habitaciones (p02:925E con A = 3)."""
    for k, color in enumerate(COLORES_DE_LAS_PUERTAS):
        ram = bytearray(0x120)                        # 0xE800-0xE91F
        for i in range(256):
            b = cart.leer(PUERTA_SIN_COLOR + i, B910)
            hi, lo = b >> 4, b & 0x0F
            ram[i] = ((color if hi == 0xF else hi) << 4) | (color if lo == 0xF else lo)
        base = PRIMERA_PUERTA + 0x10 * k
        for f in range(4):
            for c in range(4):
                src = cart.palabra(PIEZAS_DE_LA_PUERTA_GRANDE + 2 * (4 * f + c), B123) - 0xE800
                dest = base + 0x400 * f + 4 * c
                for fila in range(8):
                    for j in range(4):
                        vram.escribe(dest + fila * ANCHO_DE_LINEA + j, ram[src + 4 * fila + j])


# ------------------------------------------------------------ la fase
def carga_la_fase(cart, fase, vram=None):
    """p00:564C y p00:570D: los dibujos del decorado y la paleta de la fase."""
    vram = vram or carga_los_dibujos_de_los_objetos(cart)
    b = bancos_de_los_dibujos(fase)
    hl = cart.palabra(DIBUJOS_DE_CADA_FASE + 2 * fase, b)
    sube_dibujos(cart, b, hl, PRIMER_DIBUJO, N_DIBUJOS, vram)
    # p01:63E1, la pantalla de escena de antes de cada fase, deja puesta la
    # paleta de 0xBFA1 (p00:5733: la base y esa); luego p00:570D pone otra vez
    # la base y encima la de la fase, que solo cambia los colores que nombra
    pon_paleta(cart, B910, PALETA_DE_LA_ESCENA, vram)
    pon_paleta(cart, B910, PALETA_BASE, vram)
    pon_paleta(cart, B910, cart.palabra(PALETA_DE_CADA_FASE + 2 * fase, B910), vram)
    return vram


def entrada_de_la_habitacion(cart, fase, habitacion):
    """p00:5783: (guion, paleta) de la habitacion; la fase 0 no tiene."""
    if fase == 0:
        return None
    t = cart.palabra(HABITACIONES_DE_CADA_FASE + 2 * (fase - 1), B910)
    return cart.palabra(t + 4 * habitacion, B910), cart.palabra(t + 4 * habitacion + 2, B910)


def carga_la_habitacion(cart, fase, habitacion, vram):
    e = entrada_de_la_habitacion(cart, fase, habitacion)
    if e:
        guion_de_carga(cart, B910, e[0], vram)
        pon_paleta(cart, B910, e[1], vram)


def numero_en_el_castillo(cart, fase, habitacion):
    return cart.leer(PRIMERA_HABITACION + fase, B111213) + habitacion


def cuantas_habitaciones(cart, fase):
    """Las que hay entre la primera de esta fase y la de la siguiente."""
    a = cart.leer(PRIMERA_HABITACION + fase, B111213)
    b = cart.leer(PRIMERA_HABITACION + fase + 1, B111213) if fase < 18 else 156
    return b - a


def bloques_de_la_habitacion(cart, fase, habitacion):
    """Los 48 bytes: seis filas de ocho numeros de bloque."""
    n = numero_en_el_castillo(cart, fase, habitacion)
    t = cart.palabra(HABITACIONES + 2 * n, B111213)
    return [[cart.leer(t + 8 * f + c, B111213) for c in range(8)] for f in range(6)]


def monta_la_habitacion(cart, fase, habitacion):
    """p00:4FB6: las 24 filas de 32 celdas (numeros de dibujo)."""
    juego = cart.palabra(BLOQUES_DE_CADA_FASE + 2 * fase, B111213)
    celdas = [[0] * 32 for _ in range(24)]
    for f, fila in enumerate(bloques_de_la_habitacion(cart, fase, habitacion)):
        for c, bloque in enumerate(fila):
            for r in range(4):
                for k in range(4):
                    celdas[4 * f + r][4 * c + k] = cart.leer(juego + 16 * bloque + 4 * r + k, B111213)
    return celdas


def pinta_la_habitacion(vram, celdas):
    """p00:4F91: 22 filas de celdas -de la tercera del bufer en adelante- a la
    pagina 0 desde la fila 32, por HMMM. Las dos primeras filas de celdas de
    cada habitacion no se ven nunca."""
    for f in range(FILAS_PINTADAS):
        for c in range(32):
            k = celdas[f + PRIMERA_FILA_PINTADA][c]
            x0, y0 = (k & 0x1F) * 8, (k >> 5) * 8
            for y in range(8):
                for x in range(8):
                    vram.pon_punto(0, c * 8 + x, FILA_DE_LA_HABITACION + f * 8 + y,
                                   vram.punto(1, x0 + x, y0 + y))


# ------------------------------------------------------------ la sala de Dracula
HABITACION_ESPECIAL_DE_CADA_FASE = 0x636F   # banco 1: nibble alto la habitacion, bajo la clase
B1415 = (1, 14, 15)
PALETA_DE_DRACULA = 0xBF6F           # banco 10, p00:59EC


def clase_especial(cart, fase, habitacion):
    """p01:6333: la clase de la habitacion especial (0 si no lo es)."""
    b = cart.leer(HABITACION_ESPECIAL_DE_CADA_FASE + fase, B123)
    return b & 0x0F if b >> 4 == habitacion else 0


def _espejo(fila):
    """p00:586C: una fila de puntos a 4 bits vuelta del reves."""
    return bytes(((b << 4) | (b >> 4)) & 0xFF for b in reversed(fila))


def _siguiente_dibujo(dest, paso, alto):
    """p00:595B (paso 4, alto 4) y p00:59AA (paso 8, alto 8): un dibujo a la
    derecha y, al borde, `alto` * 2 lineas mas abajo."""
    e = ((dest & 0xFF) + paso) & 0x7F
    if e:
        return (dest & 0xFF00) | e
    return (((dest >> 8) + alto) & (0x100 - alto)) << 8


def _escribe_dibujo(vram, dest, datos, ancho):
    for fila in range(len(datos) // ancho):
        for k in range(ancho):
            vram.escribe(dest + fila * ANCHO_DE_LINEA + k, datos[fila * ancho + k])


def _lee_de_la_rom(cart, bancos, hl, n):
    return bytes(cart.leer(hl + k, bancos) for k in range(n))


def _dibujo_de_32_filas(cart, hl):
    """p00:582D: 32 filas de 16 bytes; cada una trae cuantos ceros van delante
    y luego los 12 - n bytes del dibujo; cuatro ceros al final."""
    fuera = bytearray()
    for _ in range(32):
        n = cart.leer(hl, B111213)
        hl += 1
        fuera += bytes(n) + _lee_de_la_rom(cart, B111213, hl, 12 - n) + bytes(4)
        hl += 12 - n
    return bytes(fuera)


def carga_la_sala_de_dracula(cart, vram):
    """La habitacion especial de clase 6 (p01:6363), entre el montaje y la
    pintada: otra paleta y otros dibujos en la pagina 1, muchos de ellos
    espejados en RAM antes de subirlos.

      p00:59EC  la paleta base (0xBF88) y encima la de 0xBF6F.
      p00:5880  del banco 15: dibujos de 8x8 tal cual (p00:5895) y del reves
                (p00:58CC), tres pares volteados de arriba abajo desde la
                VRAM (p00:592A), y ocho dibujos de 16x16 (p00:598B) mas cuatro
                del reves (p00:5996) en la fila 0xA0, donde estaban las
                puertas.
      p00:57DF  dos dibujos de 32x32 (0xB5A1 y 0xB719 del banco 13) en la
                fila 0x80, cada uno tal cual y del reves."""
    pon_paleta(cart, B910, PALETA_BASE, vram)
    pon_paleta(cart, B910, PALETA_DE_DRACULA, vram)
    for hl, n, dest in ((0xABFB, 8, 0x8018), (0xACFB, 2, 0x8040), (0xAD3B, 2, 0x8060),
                        (0xAD7B, 1, 0x8070), (0xAD9B, 0x6C, 0x8078)):
        sube_dibujos(cart, B1415, hl, dest, n, vram)
    ram = bytes(32)                   # 0xE800: el ultimo dibujo espejado
    for hl, n, dest in ((0xAD7B, 1, 0x8074), (0xAD9B, 0x6C, 0x9028), (0xACFB, 2, 0x8048)):
        for _ in range(n):
            d = _lee_de_la_rom(cart, B1415, hl, 32)
            ram = b"".join(_espejo(d[4 * f:4 * f + 4]) for f in range(8))
            _escribe_dibujo(vram, dest, ram, 4)
            hl += 32
            dest = _siguiente_dibujo(dest, 4, 4)
    # p00:5969 deja las filas desde 0xE818 hacia atras, de cuatro en cuatro:
    # la 0 en 0xE818 y la 7 en 0xE7FC, fuera del dibujo. Lo que sube son las
    # filas 6 a 0 y, abajo, los cuatro bytes que ya habia en 0xE81C
    for de, dest in ((0x8048, 0x8058), (0x8040, 0x8050), (0x8060, 0x8068)):
        for _ in range(2):
            filas = [bytes(vram.v[de + f * ANCHO_DE_LINEA:de + f * ANCHO_DE_LINEA + 4]) for f in range(8)]
            ram = b"".join(reversed(filas[:7])) + ram[28:32]
            _escribe_dibujo(vram, dest, ram, 4)
            de, dest = _siguiente_dibujo(de, 4, 4), _siguiente_dibujo(dest, 4, 4)
    sube_dibujos_de_16(cart, B1415, 0xBBDB, 0xD000, 8, vram)
    dest = 0xD040
    for k in range(4):
        d = _lee_de_la_rom(cart, B1415, 0xBDDB + 0x80 * k, 0x80)
        _escribe_dibujo(vram, dest, b"".join(_espejo(d[8 * f:8 * f + 8]) for f in range(16)), 8)
        dest = _siguiente_dibujo(dest, 8, 8)
    for hl, dest in ((0xB5A1, 0xC000), (0xB719, 0xC010)):
        d = _dibujo_de_32_filas(cart, hl)
        _escribe_dibujo(vram, dest, d, 16)
        _escribe_dibujo(vram, dest + 0x20, b"".join(_espejo(d[16 * f:16 * f + 16]) for f in range(32)), 16)


def remata_la_sala_de_dracula(vram):
    """p01:632D, con la habitacion ya pintada: cuatro trozos de 16x16 de la
    fila 0xA0 a (0x70, 0x80) (p01:6914) y otros dos a (0x68, 0x58) y
    (0x88, 0x58) (p01:69A0), con HMMM."""
    for (sx, sy), (dx, dy) in (((0x40, 0xA0), (0x70, 0x80)), ((0x80, 0xA0), (0x80, 0x80)),
                               ((0x50, 0xA0), (0x70, 0x90)), ((0x90, 0xA0), (0x80, 0x90)),
                               ((0x20, 0xA0), (0x68, 0x58)), ((0x30, 0xA0), (0x88, 0x58))):
        for j in range(16):
            for i in range(16):
                vram.pon_punto(0, dx + i, dy + j, vram.punto(1, sx + i, sy + j))


def habitacion(cart, fase, habitacion, vram=None):
    """La VRAM con la fase cargada y la habitacion montada y pintada."""
    vram = vram or carga_la_fase(cart, fase)
    carga_la_habitacion(cart, fase, habitacion, vram)
    celdas = monta_la_habitacion(cart, fase, habitacion)
    if clase_especial(cart, fase, habitacion) == 6:
        carga_la_sala_de_dracula(cart, vram)
    pinta_la_habitacion(vram, celdas)
    return vram


# ------------------------------------------------------------ el dibujo
def rgb(paleta, c):
    r, g, b = paleta[c]
    return (r * 255 // 7, g * 255 // 7, b * 255 // 7)


def foto(vram, pagina=0, y0=FILA_DE_LA_HABITACION, alto=FILAS_PINTADAS * 8):
    """Las filas y0..y0+alto de una pagina, en RGB con la paleta de la VRAM."""
    return [[rgb(vram.paleta, vram.punto(pagina, x, y)) for x in range(256)]
            for y in range(y0, y0 + alto)]


def guarda_png(img, ruta, escala=1):
    """Un PNG RGB de una lista de filas de (r, g, b), sin librerias."""
    alto, ancho = len(img), len(img[0])
    filas = bytearray()
    for fila in img:
        cruda = bytearray()
        for p in fila:
            cruda += bytes(p) * escala
        for _ in range(escala):
            filas += b"\x00" + cruda

    def trozo(tipo, datos):
        c = tipo + datos
        return struct.pack(">I", len(datos)) + c + struct.pack(">I", zlib.crc32(c) & 0xFFFFFFFF)
    png = (b"\x89PNG\r\n\x1a\n" + trozo(b"IHDR", struct.pack(">IIBBBBB", ancho * escala, alto * escala, 8, 2, 0, 0, 0))
           + trozo(b"IDAT", zlib.compress(bytes(filas), 9)) + trozo(b"IEND", b""))
    os.makedirs(os.path.dirname(os.path.abspath(ruta)), exist_ok=True)
    with open(ruta, "wb") as f:
        f.write(png)
    return ruta


def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    cart = Cartucho()
    fase, hab = int(sys.argv[1]), int(sys.argv[2])
    v = habitacion(cart, fase, hab)
    salida = sys.argv[3] if len(sys.argv) > 3 else os.path.join(RAIZ, "work", "habitacion_%02d_%02d.png" % (fase, hab))
    print(guarda_png(foto(v), salida, escala=2))


if __name__ == "__main__":
    main()
