#!/usr/bin/env python3
"""Las cosas del castillo -enemigos, jefes y lo que lanzan-, montadas desde las
tablas como las monta el cartucho.

  p14:8668  las cosas de cada habitacion: un puntero por bloque de tres fases;
            cada fase es una lista de [tipo][posicion] (y en el nibble alto, x
            en el bajo, por 16; el bit 7 del tipo es una bandera) con 0x00 para
            pasar a la habitacion siguiente y 0xFF al final (p01:6181).
  p00:5F48  al crear una cosa: cuantos sprites lleva (0x6058 + tipo), el color
            de cada uno (0x6084[tipo], p01:6029; el 0 la esconde) y su vida
            (0x60E1 + tipo).
  p01:6445  cada cuadro, el dibujo de la cosa (ix+0Bh) elige en 0xB473 (banco
            6) la lista de [dy][dx][patron] de sus sprites; 0x80, 0x81 y 0x82
            son composiciones con las posiciones fijas de 0x64CD, 0x64D5 y
            0x64D9 y solo el patron detras. Los tipos 0x0E y 0x17 no pasan por
            aqui.
  Los patrones los sube el guion de carga de cada habitacion (0x9AB0), el
  mismo que pinta su decorado (tools/graficos.py).

  Los cuadros de animacion y los parpadeos de color los elige el codigo de
  cada tipo; se toman de lo que se vio en openMSX (tools/lanza_cosas.sh: 250
  cuadros por habitacion en work/cosas) y cada muestra se coteja: su
  geometria tiene que ser la de 0xB473.

Uso:  enemigos.py lista [fase]    las cosas de cada habitacion
      enemigos.py                 docs/imagenes/enemigos.png
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import glob  # noqa: E402

from graficos import Cartucho, Vram, B123, IMAGENES, cuantas_habitaciones, habitacion, guarda_png  # noqa: E402
from simon import pinta_sprites, ATRIBUTOS, COLORES  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
COSAS = os.path.join(RAIZ, "work", "cosas")

B14 = (1, 14, 15)
B6 = (1, 2, 6)
COSAS_DE_CADA_BLOQUE = 0x8668        # banco 14
SPRITES_DE_CADA_TIPO = 0x6057        # banco 1, + tipo
COLORES_DE_CADA_TIPO = 0x6084        # banco 1, palabra tipo
VIDA_DE_CADA_TIPO = 0x60E1           # banco 1, + tipo
COMPOSICIONES = 0xB473               # banco 6, palabra dibujo
POSICIONES_FIJAS = {0x80: 0x64CD, 0x81: 0x64D5, 0x82: 0x64D9}
SIN_COMPONER = (0x0E, 0x17)          # p01:6445
N_TIPOS = 46


def cosas_de_la_fase(cart, fase):
    """[[(tipo, x, y, bandera)] por habitacion] (el patio no tiene)."""
    if fase == 0:
        return [[] for _ in range(cuantas_habitaciones(cart, 0))]
    bloque, dentro = (fase - 1) // 3, (fase - 1) % 3
    hl = cart.palabra(COSAS_DE_CADA_BLOQUE + 2 * bloque, B14)
    fases = []
    hab, habs = [], []
    while len(fases) < 3:
        t = cart.leer(hl, B14)
        hl += 1
        if t == 0xFF:
            habs.append(hab)
            fases.append(habs)
            hab, habs = [], []
        elif t == 0x00:
            habs.append(hab)
            hab = []
        else:
            p = cart.leer(hl, B14)
            hl += 1
            hab.append((t & 0x7F, (p & 0x0F) * 16, p & 0xF0, bool(t & 0x80)))
    lista = fases[dentro]
    n = cuantas_habitaciones(cart, fase)
    return (lista + [[] for _ in range(n)])[:n]


def sprites_del_tipo(cart, tipo):
    return cart.leer(SPRITES_DE_CADA_TIPO + tipo, B123)


def colores_del_tipo(cart, tipo):
    hl = cart.palabra(COLORES_DE_CADA_TIPO + 2 * tipo, B123)
    return [cart.leer(hl + k, B123) for k in range(sprites_del_tipo(cart, tipo))]


def vida_del_tipo(cart, tipo):
    return cart.leer(VIDA_DE_CADA_TIPO + tipo, B123)


def compone(cart, tipo, dibujo, x, y, n=None):
    """p01:6445 y p01:6029: [(y, x, patron, color)] de sus sprites; la y y la
    x, en 8 bits como las deja el juego. p01:6445 compone tantos como diga la
    ficha (+0x20), que nace con los de 0x6058 pero el codigo del tipo puede
    cambiar: `n`."""
    n = sprites_del_tipo(cart, tipo) if n is None else n
    de = cart.palabra(COMPOSICIONES + 2 * dibujo, B6)
    colores = (colores_del_tipo(cart, tipo) + [0] * n)[:n]
    fuera = []
    fija = POSICIONES_FIJAS.get(cart.leer(de, B6))
    for k in range(n):
        if fija:
            dy, dx = cart.leer(fija + 2 * k, B123), cart.leer(fija + 2 * k + 1, B123)
            patron = cart.leer(de + 1 + k, B6)
        else:
            dy, dx, patron = (cart.leer(de + 3 * k + i, B6) for i in range(3))
        fuera.append(((y + dy) & 0xFF, (x + dx) & 0xFF, patron, colores[k]))
    return fuera


# ------------------------------------------------------------ lo visto
def muestras():
    """De cada .cosas: (fase, hab, cuadro, tipo, dibujo, y, x, [(y, x, patron,
    color)])."""
    for ruta in sorted(glob.glob(os.path.join(COSAS, "hab_f*_h*.cosas"))):
        base = os.path.basename(ruta)
        fase, hab = int(base[5:7]), int(base[9:11])
        with open(ruta) as f:
            for cuadro, linea in enumerate(f):
                for trozo in linea.split():
                    b = bytes.fromhex(trozo)
                    tipo, dibujo, y, x, n = b[:5]
                    spr = [tuple(b[6 + 5 * k:10 + 5 * k]) for k in range(n)]
                    yield fase, hab, cuadro, tipo, dibujo, y, x, spr


def _relativo(spr):
    return [((a[0] - spr[0][0]) & 0xFF, (a[1] - spr[0][1]) & 0xFF, a[2]) for a in spr] if spr else []


def coteja_muestras(cart):
    """Cuantas muestras compuestas tienen la geometria (posiciones relativas y
    patrones) de 0xB473 con su dibujo, con el dibujo de otro cuadro (lo cambio
    el codigo despues de componer) o ninguna."""
    bien = otro = mal = 0
    malas = []
    for fase, hab, cuadro, tipo, dibujo, y, x, spr in muestras():
        if tipo in SIN_COMPONER or not spr:
            continue
        n = len(spr)
        if _relativo(compone(cart, tipo, dibujo, 0, 0, n)) == _relativo(spr):
            bien += 1
        elif any(_relativo(compone(cart, tipo, d, 0, 0, n)) == _relativo(spr) for d in range(256)):
            otro += 1
        else:
            mal += 1
            malas.append((fase, hab, cuadro, tipo, dibujo))
    return bien, otro, mal, malas


def clasifica_muestras(cart):
    """Cada muestra compuesta, en una de estas clases:
      'su dibujo'      la geometria de 0xB473 con el dibujo de la ficha;
      'otro dibujo'    la de otro dibujo (el codigo lo cambio al componer);
      'a medio crear'  la ficha recien nacida: desde algun byte todo a cero;
      'leida a medias' la sonda leyo mientras p01:6445 escribia: la lista se
                       parte en dos o tres trozos (posiciones y patrones van en
                       pasadas distintas) y cada trozo es el de algun dibujo en
                       esos mismos sprites. Un trozo de un solo sprite solo
                       prueba que su patron es de ese sprite en algun dibujo;
      'sin explicar'   lo demas.
    Devuelve (Counter, [muestras sin explicar])."""
    from collections import Counter
    cache = {}

    def geometria(tipo, d, n):
        if (tipo, d, n) not in cache:
            cache[(tipo, d, n)] = [a[:3] for a in compone(cart, tipo, d, 0, 0, n)]
        return cache[(tipo, d, n)]

    def trozo_de_algun_dibujo(trozo, tipo, n, j):
        r = _relativo(trozo)
        return any(_relativo(geometria(tipo, d, n)[j:j + len(trozo)]) == r for d in range(256))

    clases, raras = Counter(), []
    for fase, hab, cuadro, tipo, dibujo, y, x, spr in muestras():
        if tipo in SIN_COMPONER or not spr:
            continue
        n, s3 = len(spr), [a[:3] for a in spr]
        plano = [b for a in s3 for b in a]
        if _relativo(geometria(tipo, dibujo, n)) == _relativo(s3):
            clases["su dibujo"] += 1
        elif trozo_de_algun_dibujo(s3, tipo, n, 0):
            clases["otro dibujo"] += 1
        elif any(not any(plano[k:]) for k in range(1, len(plano))):
            clases["a medio crear"] += 1
        elif any(all(trozo_de_algun_dibujo(s3[a:b], tipo, n, a) for a, b in zip(cortes, cortes[1:]))
                 for cortes in ([0, j, n] for j in range(1, n))):
            clases["leida a medias"] += 1
        elif any(all(trozo_de_algun_dibujo(s3[a:b], tipo, n, a) for a, b in zip(cortes, cortes[1:]))
                 for cortes in ([0, j, k, n] for j in range(1, n) for k in range(j + 1, n))):
            clases["leida a medias"] += 1
        else:
            clases["sin explicar"] += 1
            raras.append((fase, hab, cuadro, tipo, dibujo, s3))
    return clases, raras


def vistos(cart):
    """{tipo: [(dibujo, colores, fase, hab)]}: cada cuadro distinto que se vio
    con la geometria de su tabla."""
    fuera = {}
    for fase, hab, cuadro, tipo, dibujo, y, x, spr in muestras():
        if tipo in SIN_COMPONER or not spr:
            continue
        if _relativo(compone(cart, tipo, dibujo, 0, 0, len(spr))) != _relativo(spr):
            continue
        colores = tuple(a[3] for a in spr)
        if not any(colores):
            continue                          # escondida: todo a color 0
        if tipo == DRACULA and dibujo in DE_PIE and not all(colores):
            continue                          # p03:AD61: el parpadeo al aparecer
        lista = fuera.setdefault(tipo, [])
        if all((d, c) != (dibujo, colores) for d, c, _, _ in lista):
            lista.append((dibujo, colores, fase, hab))
    # Dracula de pie en sus cuatro dibujos, los que no salieran en las
    # muestras: cotejados aparte (coteja.py dracula)
    from dracula import colores_de_pie, FASE, SALA
    lista = fuera.setdefault(DRACULA, [])
    for dibujo in DE_PIE:
        if all(d != dibujo for d, _, _, _ in lista):
            lista.append((dibujo, tuple(colores_de_pie(cart)), FASE, SALA))
    return fuera


DRACULA = 0x11
DE_PIE = (0x5B, 0x5C, 0x5D, 0x5E)


def pinta_el_cuerpo_en(cart, v, img, dibujo, dy, dx):
    """El cuerpo de Dracula de pie (tools/dracula.py) debajo de sus sprites,
    con Dracula en (0x80, 0x80): lo que p03:AD93 copia al fondo en (x - 16,
    y - 0x2F), sobre el fondo de la hoja."""
    from dracula import cuerpo, pasos_del_cuerpo, FILA_DEL_CUERPO, Y_DE_PIE
    from graficos import rgb
    y0 = 0x80 - (Y_DE_PIE - FILA_DEL_CUERPO)
    for paso in pasos_del_cuerpo(dibujo):
        sx, sy = cuerpo(cart, paso)
        for j in range(32):
            for i in range(32):
                c = v.punto(1, sx + i, sy + j)
                if c and 0 <= y0 + j - dy < len(img) and 0 <= 0x70 + i - dx < len(img[0]):
                    img[y0 + j - dy][0x70 + i - dx] = rgb(v.paleta, c)


def hoja(cart, por_tipo, tope=12):
    """Una fila por tipo con sus cuadros (hasta `tope`), cada uno con los
    patrones y la paleta de la habitacion donde se vio."""
    salas = {}
    filas = []
    for tipo in sorted(por_tipo):
        cuadros = sorted(por_tipo[tipo])[:tope]
        cajas = []
        for dibujo, colores, fase, hab in cuadros:
            spr = compone(cart, tipo, dibujo, 0x80, 0x80, len(colores))
            spr = [a[:3] + (c,) for a, c in zip(spr, colores)]
            ys = [(a[0] - 0x80 + 128) % 256 - 128 for a in spr if a[3]]
            xs = [(a[1] - 0x80 + 128) % 256 - 128 for a in spr if a[3]]
            cajas.append((min(ys or [0]), max(ys or [0]) + 17, min(xs or [0]), max(xs or [0]) + 16))
        y0, y1 = min(c[0] for c in cajas), max(c[1] for c in cajas)
        ancho = max(c[3] - c[2] for c in cajas) + 8
        alto = y1 - y0 + 8
        fila = [[(40, 40, 40)] * (ancho * len(cuadros)) for _ in range(alto)]
        for k, ((dibujo, colores, fase, hab), caja) in enumerate(zip(cuadros, cajas)):
            if (fase, hab) not in salas:
                salas[(fase, hab)] = habitacion(cart, fase, hab)
            v = Vram()
            v.v[:] = salas[(fase, hab)].v
            v.paleta = salas[(fase, hab)].paleta
            spr = compone(cart, tipo, dibujo, 0x80, 0x80, len(colores))
            if tipo == DRACULA and dibujo in DE_PIE:
                pinta_el_cuerpo_en(cart, v, fila, dibujo, 0x80 + y0 - 4, 0x80 + caja[2] - 4 - k * ancho)
            for s, (yy, xx, patron, _) in enumerate(spr):
                color = colores[s]
                v.v[ATRIBUTOS + 4 * s:ATRIBUTOS + 4 * s + 3] = bytes((yy if color else 0xE1, xx, patron))
                v.v[COLORES + 16 * s:COLORES + 16 * s + 16] = bytes([color]) * 16
            pinta_sprites(v, fila, len(spr), dy=0x80 + y0 - 4, dx=0x80 + caja[2] - 4 - k * ancho)
        filas.append(fila)
    ancho = max(len(f[0]) for f in filas)
    img = []
    for f in filas:
        for linea in f:
            img.append(linea + [(24, 24, 24)] * (ancho - len(linea)))
        img.append([(24, 24, 24)] * ancho)
    return img


def main():
    cart = Cartucho()
    if sys.argv[1:2] == ["lista"]:
        fases = [int(sys.argv[2])] if len(sys.argv) > 2 else range(1, 19)
        for f in fases:
            for h, cs in enumerate(cosas_de_la_fase(cart, f)):
                print("fase %2d hab %2d: %s" % (f, h, ", ".join("tipo %d en (%d, %d)%s" % (t, x, y, "*" if b else "")
                                                               for t, x, y, b in cs)))
        return
    bien, otro, mal, malas = coteja_muestras(cart)
    print("muestras: %d con la geometria de su dibujo, %d con la de otro cuadro, %d sin ninguna" % (bien, otro, mal))
    if "-v" in sys.argv:
        from collections import Counter
        print("sin ninguna, por tipo:", sorted(Counter(t for _, _, _, t, _ in malas).items()))
    por_tipo = vistos(cart)
    print("tipos vistos:", sorted(por_tipo))
    print(guarda_png(hoja(cart, por_tipo), os.path.join(IMAGENES, "enemigos.png"), 2))


if __name__ == "__main__":
    main()
