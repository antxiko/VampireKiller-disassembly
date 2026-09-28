#!/usr/bin/env python3
"""Lo que cada habitacion esconde, leido de la lista del banco 14 y pintado
como lo pinta el juego.

  p14:8000  seis punteros, uno por bloque de tres fases, a su lista, que
            p00:5A67 copia a 0xE000: 0xFE pasa a la habitacion siguiente,
            0xFF a la fase siguiente y 0x00 acaba; el patio tiene la suya en
            0x800C. Cada entrada son dos bytes -y otro mas si el segundo es
            0x7F- y p00:5B1B (con 0xD001 y la fila de 0x5C04) la recorre al
            entrar:
    byte 1    la posicion: la y en el nibble alto, la x en el bajo, por 16
              (p00:5C16).
    byte 2    los bits 7-5 dicen que es:
      000     un OBJETO a la vista, del tipo de los bits 0-4 (p00:5B88 ->
              p02:89FD: la lista de 0xC500). No siempre esta: 0xCF38 lo
              impide.
      001     una VELA: al romperla sale lo de los bits 0-4 (p00:5B5A, tamano
              0 en la lista de 0xC470; en el patio, tamano 1: la antorcha).
      010/011 un BLOQUE que se rompe, pequeno (2 x 2 dibujos) o grande
              (4 x 4), con lo de los bits 0-4 dentro; 0x1F es que lo dice el
              tercer byte.
      10x     un COFRE (p02:8A13: el objeto 0x19) con lo de los bits 0-4.
      11x     un VENDEDOR, el viejo encapuchado (p02:9179, dos por habitacion en
              0xC5B5 y 0xC5C5): vende lo que dicen los bits 5-2 en la tabla
              de 0x5B0B, y los bits 1-0 son su clase, la fila de 0x9300 que
              dice lo que pasa en cada visita (p02:92BB): la tienda, cinco
              corazones mas o menos, una VUELTA mas o menos, nada, o se va
              con 5.000 puntos.
  p02:8CC1  los objetos se pintan con LMMM y transparencia desde la pagina 1:
            el dibujo A -el tipo menos uno- esta en la fila 0x50 (los dieciseis
            primeros) o en la 0x60, columna A * 16. Las velas, que no son
            objetos, salen de la fila 0x70: dos dibujos que se turnan (y la
            antorcha del patio, el cuarto).
  p02:86CA  los bloques se pintan con los dibujos de 0x8792 (bloque de fases
            0) o 0x87A6: cuatro para el pequeno y dieciseis para el grande.
  p02:924C  los vendedores, el viejo blanco: 32 x 32 de la pagina 1 (96, 0xA0), con
            transparencia.
  p13:BB37  LA PUERTA DE LA FASE: tres bytes por fase en 0xBB61 -la habitacion
            (bit 7: cerrada), la y y la x- y, cuando se entra en esa habitacion,
            p00:53FC la pinta desde la ROM: seis piezas de 8x8 (0x5421) en
            columna, por HMMC.

Uso:  secretos.py <fase>       lista lo que esconde cada habitacion
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from graficos import (Cartucho, B123, B111213, cuantas_habitaciones,  # noqa: E402
                      PAGINA_1, ANCHO_DE_LINEA, clase_especial, remata_la_sala_de_dracula)

B14 = (1, 14, 15)
LISTAS_DE_CADA_BLOQUE = 0x8000       # banco 14
LISTA_DEL_PATIO = 0x800C             # banco 14, la fase 0
LO_QUE_VENDEN = 0x5B0B               # banco 0: lo que vende cada vendedor
DIBUJOS_DE_LOS_BLOQUES = {0: 0x8792, 1: 0x87A6}   # banco 2, p02:86CF
FILA_DE_LOS_OBJETOS = (0x50, 0x60)   # p02:8CC1
FILA_DE_LAS_VELAS = 0x70
COLUMNA_DE_LA_ANTORCHA = 48          # el cuarto dibujo de la fila 0x70
VENDEDOR_BLANCO = (96, 0xA0)          # p02:925E con A = 3
TIPO_DEL_COFRE = 0x19
PUERTA_DE_CADA_FASE = 0xBB61         # banco 13
PIEZAS_DE_LA_PUERTA = 0x5421         # banco 0, seis punteros


def bloque_de(fase):
    return (fase - 1) // 3 if fase else 0


def _entradas(cart, a):
    """Las entradas de una lista desde `a`: [[(b1, b2, b3)...] por
    habitacion], por fase."""
    fases, hab, ent = [], [], []
    while True:
        b = cart.leer(a, B14)
        a += 1
        if b == 0x00:
            hab.append(ent)
            fases.append(hab)
            return fases
        if b == 0xFE:
            hab.append(ent)
            ent = []
        elif b == 0xFF:
            hab.append(ent)
            fases.append(hab)
            hab, ent = [], []
        else:
            b2 = cart.leer(a, B14)
            a += 1
            b3 = None
            if b2 == 0x7F:                    # p00:5A67: solo con 0x7F hay tercer byte
                b3 = cart.leer(a, B14)
                a += 1
            ent.append((b, b2, b3))


def lista_del_bloque(cart, bloque):
    return _entradas(cart, cart.palabra(LISTAS_DE_CADA_BLOQUE + 2 * bloque, B14))


def decodifica(cart, b1, b2, b3):
    """Una entrada, como diccionario."""
    x, y = (b1 & 0x0F) * 16, b1 & 0xF0
    clase, bajo = b2 >> 5, b2 & 0x1F
    e = dict(x=x, y=y, bytes=(b1, b2, b3))
    if clase == 0:
        e.update(que="objeto", tipo=bajo)
    elif clase == 1:
        e.update(que="vela", contenido=bajo)
    elif clase in (2, 3):
        e.update(que="bloque", tamano=clase, contenido=b3 if bajo == 0x1F else bajo)
        if bajo == 0x1F and b3 & 0xC0 == 0xC0:      # un vendedor dentro (p02:8831)
            e.update(vende=cart.leer(LO_QUE_VENDEN + ((b3 >> 2) & 0x0F), B123), clase=b3 & 3)
    elif clase in (4, 5):
        e.update(que="cofre", contenido=bajo)
    else:
        e.update(que="vendedor", vende=cart.leer(LO_QUE_VENDEN + ((b2 >> 2) & 0x0F), B123),
                 clase=b2 & 3)
    return e


def secretos(cart, fase, habitacion):
    """Lo que esconde una habitacion: lista de entradas decodificadas."""
    if fase == 0:
        lista = _entradas(cart, LISTA_DEL_PATIO)[0]
    else:
        lista = lista_del_bloque(cart, bloque_de(fase))[(fase - 1) % 3]
    if habitacion >= len(lista):
        return []
    return [decodifica(cart, *e) for e in lista[habitacion]]


def puerta_de_la_fase(cart, fase):
    """p13:BB37: (habitacion, cerrada, x, y) de la puerta de salida."""
    q = PUERTA_DE_CADA_FASE + 3 * fase
    b = cart.leer(q, B111213)
    return b & 0x0F, bool(b & 0x80), cart.leer(q + 2, B111213), cart.leer(q + 1, B111213)


# ------------------------------------------------------------ que es cada cosa
# Lo que hace recoger cada tipo: los 25 manejadores de p02:8D3E y, desde el
# 0x1A, las armas (p02:8D70: el arma es el tipo menos 0x19). Donde el codigo
# solo pone un bit, el nombre es el de su dibujo (fila 0x50/0x60 de la pagina
# 1, el tipo menos uno).
NOMBRES = {
    0x00: "nada",                                   # p02:8AA6: el objeto se quita
    0x01: "corazon (+1)",                           # p02:8DAF
    0x02: "corazon grande (+5)",                    # p02:8DB7
    0x03: "escudo rojo (16 golpes)",                # p02:8D98
    0x04: "escudo (16 golpes)",                     # p02:8DA1
    0x05: "cruz: borra lo que hay en la habitacion",  # p02:8DBB
    0x06: "cruz gris (cuenta del arma)",            # p02:8D7C
    0x07: "8 de vida",                              # p02:8DDE
    0x08: "invencibilidad",                         # p02:8DCD
    0x09: "anillo (cuenta de 0xC434)",              # p02:8DE5
    0x0A: "reloj de arena",                         # p02:8D94
    0x0B: "lazo: alarga las cuentas",               # p02:8DF5
    0x0C: "botas",                                  # p02:8DFC
    0x0D: "alas",                                   # p02:8E03
    0x0E: "vela: marca los bloques que se rompen",  # p02:8E16
    0x0F: "pergamino",                              # p02:8E33
    0x10: "libro rojo",                             # p02:8E1D
    0x11: "libro blanco",                           # p02:8E26
    0x12: "baston",                                 # p02:8E79
    0x13: "5.000 puntos",                           # p02:8E42
    0x14: "1.000 puntos",                           # p02:8E4B
    0x15: "sale un bicho",                          # p02:8AD0, la cosa de 0x8AF0
    0x16: "vida llena",                             # p02:8E0D
    0x17: "llave",                                  # p02:8E50
    0x18: "llave blanca",                           # p02:8E60
    0x19: "cofre",
    0x1A: "arma 1: latigo de cadena",
    0x1B: "arma 2: daga",
    0x1C: "arma 3: hacha",
    0x1D: "arma 4: cruz que vuelve",
    0x1E: "arma 5: frasco",                         # p02:8D8D, aparte: el bit 3
}
BICHO = 0x15


def que_sale(e):
    """Lo que esconde una entrada: (que, tipo). que es 'objeto', 'cofre' (un
    cofre con el tipo dentro, tercer byte 10xxxxxx: p02:8827) o 'vendedor' (un
    vendedor, tercer byte 11xxxxxx: p02:8831)."""
    if e["que"] == "bloque" and e["bytes"][2] is not None:
        b3 = e["bytes"][2]
        if b3 & 0xC0 == 0xC0:
            return "vendedor", None
        return "cofre", b3 & 0x1F
    if e["que"] == "cofre":
        return "cofre", e["contenido"]
    if e["que"] == "objeto":
        return "objeto", e["tipo"]
    if e["que"] in ("vela", "bloque"):
        return "objeto", e["contenido"]
    return "vendedor", None


def describe(e):
    que, tipo = que_sale(e)
    if e["que"] == "vendedor":
        return "vendedor de %s (clase %d)" % (NOMBRES.get(e["vende"], "tipo %d" % e["vende"]), e["clase"])
    donde = {"vela": "vela", "bloque": "bloque que se rompe" + (" grande" if e.get("tamano") == 3 else ""),
             "cofre": "cofre", "objeto": "a la vista"}[e["que"]]
    if que == "vendedor":
        return "%s: sale un vendedor de %s (clase %d)" % (
            donde, NOMBRES.get(e["vende"], "tipo %d" % e["vende"]), e["clase"])
    if que == "cofre" and e["que"] != "cofre":
        return "%s: sale un cofre con %s" % (donde, NOMBRES.get(tipo, "tipo %d" % tipo))
    return "%s: %s" % (donde, NOMBRES.get(tipo, "tipo %d" % tipo))


# ------------------------------------------------------------ pintar
def _lmmm(vram, x0, y0, x, y, ancho, alto):
    """p00:49DB con TIMP: de la pagina 1 a la 0, el color 0 no se copia."""
    for j in range(alto):
        for i in range(ancho):
            c = vram.punto(1, x0 + i, y0 + j)
            if c:
                vram.pon_punto(0, x + i, y + j, c)


def pinta_objeto(vram, tipo, x, y):
    """p02:8CC1: el dibujo `tipo - 1`, 16 x 16."""
    a = tipo - 1
    if a < 16:
        _lmmm(vram, a * 16, FILA_DE_LOS_OBJETOS[0], x, y, 16, 16)
    else:
        _lmmm(vram, (a - 16) * 16, FILA_DE_LOS_OBJETOS[1], x, y, 16, 16)


def pinta_vela(vram, x, y, paso=0, antorcha=False):
    """Dos dibujos que se turnan: el 0 y el 1 de la fila 0x70 para la vela, el
    2 y el 3 para la antorcha del patio."""
    x0 = (COLUMNA_DE_LA_ANTORCHA - 16 + 16 * paso) if antorcha else 16 * paso
    _lmmm(vram, x0, FILA_DE_LAS_VELAS, x, y, 16, 16)


def pinta_bloque(cart, vram, fase, tamano, x, y):
    """p02:86CA: 2 x 2 o 4 x 4 dibujos del decorado, copiados con HMMM."""
    t = DIBUJOS_DE_LOS_BLOQUES[0 if bloque_de(fase) == 0 else 1]
    n = 2 if tamano == 2 else 4
    if n == 4:
        t += 4
    for f in range(n):
        for c in range(n):
            k = cart.leer(t + n * f + c, B123)
            x0, y0 = (k & 0x1F) * 8, (k >> 5) * 8
            for j in range(8):
                for i in range(8):
                    vram.pon_punto(0, x + 8 * c + i, y + 8 * f + j, vram.punto(1, x0 + i, y0 + j))


def pinta_vendedor(vram, x, y):
    _lmmm(vram, VENDEDOR_BLANCO[0], VENDEDOR_BLANCO[1], x, y, 32, 32)


def pinta_puerta_de_la_fase(cart, vram, fase, habitacion):
    """p00:53FC: las seis piezas en columna, si la puerta esta en esta
    habitacion. Devuelve si la ha pintado."""
    hab, cerrada, x, y = puerta_de_la_fase(cart, fase)
    if hab != habitacion or not cerrada:
        return False
    for k in range(6):
        a = cart.palabra(PIEZAS_DE_LA_PUERTA + 2 * k, B123)
        for j in range(8):
            for i in range(4):
                b = cart.leer(a + 4 * j + i, B123)
                vram.pon_punto(0, x + 2 * i, y + 8 * k + j, b >> 4)
                vram.pon_punto(0, x + 2 * i + 1, y + 8 * k + j, b & 0x0F)
    return True


# ------------------------------------------------------------ las trampas
TRAMPAS = 0x8FBD                     # banco 2: tres registros de seis bytes
DONDE_ESTAN_LAS_TRAMPAS = (6, 1)     # p02:8F9F: fase 6, habitacion 1
PIEZA_DE_LA_TRAMPA = (0x80, 0x70)    # pagina 1: cadena (0x9A80) y pinchos (0x9A90)


def trampas(cart):
    """p02:8FA7: [tipo, y, x, ritmo, cuenta, recorrido, pasos]: tipo 1 baja
    y 2 sube."""
    return [[cart.leer(TRAMPAS + 6 * k + i, B123) for i in range(6)] + [0] for k in range(3)]


def mueve_las_trampas(vram, regs):
    """p02:8FEA, un cuadro: la cuenta sube; bajando se mueve si ritmo & cuenta
    es cero (cada cuadro o uno si y otro no), subiendo uno de cada cuatro. Al
    moverse va 4 lineas y copia con HMMM los 32 x 16 de la pieza a (x, y - 4):
    arriba el trozo de cadena, que la alarga, y abajo cuatro lineas en negro,
    que borran al subir. Tras `recorrido` pasos, da la vuelta."""
    for r in regs:
        r[4] = (r[4] + 1) & 0xFF
        if r[0] == 1:
            if r[3] & r[4]:
                continue
            paso = 4
        else:
            if r[4] & 3:
                continue
            paso = -4
        r[1] = (r[1] + paso) & 0xFF
        r[6] += 1
        if r[6] == r[5]:
            r[6] = 0
            r[0] ^= 3
        x0, y0 = PIEZA_DE_LA_TRAMPA
        for j in range(16):
            for i in range(32):
                vram.pon_punto(0, r[2] + i, r[1] - 4 + j, vram.punto(1, x0 + i, y0 + j))


def pinta_las_trampas(cart, vram, fase, habitacion, cuadros=None):
    """Las trampas tras `cuadros` cuadros; sin cuadros, cada una en lo mas bajo
    de su recorrido (la primera vez que da la vuelta)."""
    if (fase, habitacion) != DONDE_ESTAN_LAS_TRAMPAS:
        return
    regs = trampas(cart)
    if cuadros is not None:
        for _ in range(cuadros):
            mueve_las_trampas(vram, regs)
        return
    for k in range(3):
        r = [regs[k]]
        while r[0][0] == 1:
            mueve_las_trampas(vram, r)


def pinta_secretos(cart, vram, fase, habitacion, pasos_de_las_velas=(0,), con_objetos=True,
                   cuadros_de_las_trampas=None):
    """Todo lo de la habitacion sobre la pantalla ya montada. Devuelve la
    lista. Las velas se pintan con transparencia encima del paso anterior:
    `pasos_de_las_velas` es la secuencia de dibujos que llevan (la antorcha
    del patio deja asi algun punto del otro)."""
    lista = secretos(cart, fase, habitacion)
    for e in lista:
        if e["que"] == "objeto" and con_objetos:
            pinta_objeto(vram, e["tipo"], e["x"], e["y"])
        elif e["que"] == "vela":
            for paso in pasos_de_las_velas:
                pinta_vela(vram, e["x"], e["y"], paso, antorcha=fase == 0)
        elif e["que"] == "bloque":
            pinta_bloque(cart, vram, fase, e["tamano"], e["x"], e["y"])
        elif e["que"] == "cofre":
            pinta_objeto(vram, TIPO_DEL_COFRE, e["x"], e["y"])
        elif e["que"] == "vendedor":
            pinta_vendedor(vram, e["x"], e["y"])
    pinta_puerta_de_la_fase(cart, vram, fase, habitacion)
    if clase_especial(cart, fase, habitacion) == 6:
        remata_la_sala_de_dracula(vram)
    pinta_las_trampas(cart, vram, fase, habitacion, cuadros_de_las_trampas)
    return lista


def main():
    cart = Cartucho()
    fase = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    print("puerta de la fase:", puerta_de_la_fase(cart, fase))
    for h in range(cuantas_habitaciones(cart, fase)):
        print("fase %d habitacion %d:" % (fase, h))
        for e in secretos(cart, fase, h):
            print("   ", e)


if __name__ == "__main__":
    main()
