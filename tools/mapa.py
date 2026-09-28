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
  vendedores y la puerta de salida de la fase.

Uso:  mapa.py [fase ...]      docs/imagenes/fase_NN.png (todas si no se dice,
                              y entonces tambien castillo.png)
      mapa.py lista <fase>    las habitaciones, sus casillas, salidas y secretos
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from graficos import (Cartucho, IMAGENES, B123, B111213, CASILLA_DE_CADA_HABITACION,  # noqa: E402
                      SALIDAS_DE_CADA_FASE, FILA_DE_LA_HABITACION, cuantas_habitaciones,
                      habitacion, foto, rgb, guarda_png)
from secretos import (pinta_secretos, secretos, que_sale, describe, BICHO,  # noqa: E402
                      FILA_DE_LOS_OBJETOS, TIPO_DEL_COFRE, VENDEDOR_BLANCO)

COLUMNAS, FILAS = 6, 5
ESCALA = 2                           # la habitacion a 2x; los secretos, a 1x encima
ANCHO, ALTO = 256 * ESCALA, 176 * ESCALA
HUECO = 24
MARCO_BLOQUE = (255, 230, 0)         # un bloque que se rompe
MARCO_VENDEDOR = (255, 0, 255)         # un vendedor, o lo que lo saca
MARCO_BICHO = (255, 40, 40)          # sale un bicho
NEGRO = (0, 0, 0)
FONDO = (24, 24, 24)
SALIDA = (255, 220, 0)
SALIDA_LEJOS = (0, 200, 255)
SALIDA_SIN_VUELTA = (255, 120, 0)    # la vecina no tiene salida hacia aqui
CONTRARIO = (1, 0, 3, 2)
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


def _dibujo(v, x0, y0, ancho=16, alto=16):
    """Un dibujo de la pagina 1 en RGB con la paleta de la habitacion; None
    donde es el color 0 (transparente)."""
    return [[rgb(v.paleta, v.punto(1, x0 + i, y0 + j)) if v.punto(1, x0 + i, y0 + j) else None
             for i in range(ancho)] for j in range(alto)]


def icono_del_tipo(v, tipo):
    """p02:8CC1: el dibujo tipo - 1."""
    a = tipo - 1
    return _dibujo(v, (a % 16) * 16, FILA_DE_LOS_OBJETOS[a // 16])


def _pega(img, dib, x, y, fondo=NEGRO):
    """Un dibujo a 1x sobre un recuadro negro con borde de un punto."""
    alto, ancho = len(dib), len(dib[0])
    _marca(img, x - 1, y - 1, ancho + 2, alto + 2, fondo)
    for j in range(alto):
        for i in range(ancho):
            if dib[j][i] is not None and 0 <= y + j < len(img) and 0 <= x + i < len(img[0]):
                img[y + j][x + i] = dib[j][i]


def _marco(img, x, y, ancho, alto, color, grueso=2):
    _marca(img, x, y, ancho, grueso, color)
    _marca(img, x, y + alto - grueso, ancho, grueso, color)
    _marca(img, x, y, grueso, alto, color)
    _marca(img, x + ancho - grueso, y, grueso, alto, color)


def _exclamacion(img, x, y, color):
    """Un signo de admiracion de 4 x 14 para 'sale un bicho'."""
    _marca(img, x - 3, y - 3, 10, 20, NEGRO)
    _marca(img, x, y, 4, 9, color)
    _marca(img, x, y + 11, 4, 3, color)


def marca_los_secretos(img, v, cart, fase, hab, x0, y0):
    """Sobre la habitacion a 2x: un marco en lo que se rompe o esta cerrado y,
    a 1x en un recuadro negro, el dibujo de lo que sale."""
    for e in secretos(cart, fase, hab):
        x, y = x0 + e["x"] * ESCALA, y0 + (e["y"] - FILA_DE_LA_HABITACION) * ESCALA
        que, tipo = que_sale(e)
        lado = 32 * ESCALA if e.get("tamano") == 3 or e["que"] == "vendedor" else 16 * ESCALA
        if e["que"] == "bloque":
            _marco(img, x, y, lado, lado, MARCO_BLOQUE)
        elif e["que"] == "vendedor":
            _marco(img, x, y, lado, lado, MARCO_VENDEDOR)
            continue
        elif e["que"] == "objeto":
            continue                          # ya esta pintado
        cx, cy = x + lado // 2 - 8, y + lado // 2 - 8
        if e["que"] in ("vela", "cofre"):
            cx, cy = x + lado - 4, y - 8      # arriba a la derecha de la vela o el cofre
        if que == "vendedor":
            _marco(img, x + 2, y + 2, lado - 4, lado - 4, MARCO_VENDEDOR)
            _pega(img, _dibujo(v, VENDEDOR_BLANCO[0], VENDEDOR_BLANCO[1], 32, 32), x + lado // 2 - 16, y + lado // 2 - 16)
        elif tipo == BICHO:
            _exclamacion(img, cx + 6, cy + 1, MARCO_BICHO)
        elif tipo == 0:
            continue
        elif que == "cofre" and e["que"] != "cofre":
            _pega(img, icono_del_tipo(v, TIPO_DEL_COFRE), cx - 9, cy)
            _pega(img, icono_del_tipo(v, tipo), cx + 9, cy)
        else:
            _pega(img, icono_del_tipo(v, tipo), cx, cy)


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
            fila = fo[y // ESCALA]
            img[y0 + y][x0:x0 + ANCHO] = [fila[x // ESCALA] for x in range(ANCHO)]
        marca_los_secretos(img, v, cart, fase, hab, x0, y0)
        # las salidas: una marca en el borde, amarilla si la vecina esta al
        # lado en la rejilla y azul si esta en otro sitio
        for lado, vecina in enumerate(sal[hab]):
            if vecina is None:
                continue
            lejos = vecina >= len(cas) or (cas[vecina] % COLUMNAS, cas[vecina] // COLUMNAS) != _vecina_en_la_rejilla(cas, hab, lado)
            color = SALIDA_LEJOS if lejos else SALIDA
            if vecina < len(cas) and sal[vecina][CONTRARIO[lado]] != hab:
                color = SALIDA_SIN_VUELTA
            if lado == 0:
                _marca(img, x0 + ANCHO // 2 - 16, y0 - HUECO // 2 - 2, 32, 4, color)
            elif lado == 1:
                _marca(img, x0 + ANCHO // 2 - 16, y0 + ALTO + HUECO // 2 - 2, 32, 4, color)
            elif lado == 2:
                _marca(img, x0 - HUECO // 2 - 2, y0 + ALTO // 2 - 16, 4, 32, color)
            else:
                _marca(img, x0 + ANCHO + HUECO // 2 - 2, y0 + ALTO // 2 - 16, 4, 32, color)
    return img


def sin_vuelta(cart, fase):
    """Las salidas de ida: (habitacion, lado, vecina)."""
    sal = salidas(cart, fase)
    return [(h, lado, v) for h, s in enumerate(sal) for lado, v in enumerate(s)
            if v is not None and sal[v][CONTRARIO[lado]] != h]


def lista(cart, fase):
    cas, sal = casillas(cart, fase), salidas(cart, fase)
    for h in range(len(cas)):
        print("habitacion %d: casilla %d (columna %d, fila %d), salidas %s"
              % (h, cas[h], cas[h] % COLUMNAS, cas[h] // COLUMNAS,
                 ", ".join("%s a la %d" % (LADOS[l], v) for l, v in enumerate(sal[h]) if v is not None) or "ninguna"))
        for e in secretos(cart, fase, h):
            print("     (%3d, %3d) %s" % (e["x"], e["y"], describe(e)))


def _reduce(img, k):
    """Media de cada cuadro de k x k puntos."""
    alto, ancho = len(img) // k, len(img[0]) // k
    fuera = []
    for y in range(alto):
        fila = []
        for x in range(ancho):
            r = g = b = 0
            for j in range(k):
                for p in img[y * k + j][x * k:x * k + k]:
                    r, g, b = r + p[0], g + p[1], b + p[2]
            fila.append((r // (k * k), g // (k * k), b // (k * k)))
        fuera.append(fila)
    return fuera


def castillo(laminas, k=4, hueco=16):
    """Las 19 laminas reducidas: el patio arriba y, debajo, una fila por cada
    bloque de tres fases (el mismo reparto de p14:8000)."""
    filas = [[0]] + [[3 * b + 1, 3 * b + 2, 3 * b + 3] for b in range(6)]
    peq = {f: _reduce(img, k) for f, img in laminas.items()}
    ancho = max(sum(len(peq[f][0]) + hueco for f in fila) for fila in filas) + hueco
    alto = sum(max(len(peq[f]) for f in fila) + hueco for fila in filas) + hueco
    img = [[FONDO] * ancho for _ in range(alto)]
    y = hueco
    for fila in filas:
        x = hueco
        for f in fila:
            for j, linea in enumerate(peq[f]):
                img[y + j][x:x + len(linea)] = linea
            x += len(peq[f][0]) + hueco
        y += max(len(peq[f]) for f in fila) + hueco
    return img


def main():
    cart = Cartucho()
    if sys.argv[1:2] == ["lista"]:
        lista(cart, int(sys.argv[2]))
        return
    fases = [int(a) for a in sys.argv[1:]] or list(range(19))
    laminas = {}
    for fase in fases:
        laminas[fase] = lamina_de_la_fase(cart, fase)
        print(guarda_png(laminas[fase], os.path.join(IMAGENES, "fase_%02d.png" % fase)))
    if len(laminas) == 19:
        print(guarda_png(castillo(laminas), os.path.join(IMAGENES, "castillo.png")))


if __name__ == "__main__":
    main()
