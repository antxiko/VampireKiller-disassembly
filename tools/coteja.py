#!/usr/bin/env python3
"""Coteja las habitaciones montadas desde las tablas con los volcados de
openMSX (tools/omsx_habitacion.tcl, en work/habitaciones: los 128 KB de VRAM,
la RAM de 0xC000 y la paleta de cada habitacion, medio segundo despues de que
p01:6321 encienda la pantalla).

  habitaciones  por cada volcado: la paleta, los bytes de la pagina 1 que el
                montaje toca (los dibujos del decorado, los de los objetos y lo
                que carga el guion de la habitacion) y la pantalla (la pagina
                0, filas 32 a 207) con lo que esconde la habitacion pintado.
                Las velas se turnan entre dos dibujos: se admiten los dos.

  mapa          la rejilla y las salidas de las 19 fases (tools/mapa.py).
  titulo        el logotipo de Konami y el titulo, europeo y japones, contra
                work/titulo (tools/lanza_titulo.sh).

  simon         los sprites de Simon contra los 156 volcados de habitaciones.

Uso:  coteja.py [habitaciones] [mapa] [titulo] [simon] [-v]
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import (Cartucho, habitacion, FILA_DE_LA_HABITACION, FILAS_PINTADAS,  # noqa: E402
                      ANCHO_DE_LINEA)
from secretos import pinta_secretos, DONDE_ESTAN_LAS_TRAMPAS  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WORK = os.path.join(RAIZ, "work")


def _lee(ruta):
    with open(ruta, "rb") as f:
        return f.read()


def _pantalla(v):
    ini = FILA_DE_LA_HABITACION * ANCHO_DE_LINEA
    return bytes(v[ini:ini + FILAS_PINTADAS * 8 * ANCHO_DE_LINEA])


def habitaciones(cart, detalle=False):
    vistos = malos = 0
    resumen = []
    for ruta in sorted(glob.glob(os.path.join(WORK, "habitaciones", "hab_f*_h*.vram"))):
        base = os.path.basename(ruta)
        fase, hab = int(base[5:7]), int(base[9:11])
        d = _lee(ruta)
        pal = _lee(ruta[:-5] + ".pal")
        paleta = [((pal[2 * k] >> 4) & 7, pal[2 * k + 1] & 7, pal[2 * k] & 7) for k in range(16)]
        # los montajes: las velas en sus dos pasos -solos o uno encima del
        # otro-, con y sin los objetos a la vista (0xCF38 decide si salen);
        # cada byte vale si lo da alguno. Las trampas de (6,1) se mueven: vale
        # el primer cuadro, de 0 a 60 desde que se entra, que da el volcado
        pe = _pantalla(d)
        cuadros = range(61) if (fase, hab) == DONDE_ESTAN_LAS_TRAMPAS else [None]
        for cuadro in cuadros:
            variantes = []
            for pasos in ((0,), (1,), (0, 1), (1, 0)):
                for con_objetos in (True, False):
                    v = habitacion(cart, fase, hab)
                    pinta_secretos(cart, v, fase, hab, pasos, con_objetos, cuadro)
                    variantes.append(v)
            ps = [_pantalla(v.v) for v in variantes]
            malas = [a for a in range(len(pe)) if all(pe[a] != p[a] for p in ps)]
            if not malas:
                break
        v0 = variantes[0]
        dp = sum(1 for k in range(16) if paleta[k] != v0.paleta[k])
        # p00:54E4 lee 0x48 bytes de RAM para el quinto dibujo de 0xB800: ese
        # trozo (x 64-79, filas 0x77-0x7F de la pagina 1) no sale de la ROM
        d1 = sum(1 for a in range(0x8000, 0x10000) if v0.tocado[a] and v0.v[a] != d[a]
                 and not (0x77 <= (a - 0x8000) // ANCHO_DE_LINEA <= 0x7F
                          and 32 <= (a - 0x8000) % ANCHO_DE_LINEA < 40))
        if cuadro is not None and detalle:
            print("  fase %2d hab %2d: las trampas, en el cuadro %d" % (fase, hab, cuadro))
        d0 = len(malas)
        vistos += 1
        if dp or d1 or d0:
            malos += 1
            celdas = sorted({((a // ANCHO_DE_LINEA) // 8, (a % ANCHO_DE_LINEA) // 4) for a in malas})
            print("  fase %2d hab %2d: paleta %d, pagina 1 %d, pantalla %d bytes en %d celdas %s"
                  % (fase, hab, dp, d1, d0, len(celdas),
                     " ".join("(%d,%d)" % c for c in celdas[:6]) if detalle else ""))
        resumen.append((fase, hab, dp, d1, d0))
    print("habitaciones: %d volcados, %d con diferencias" % (vistos, malos))
    return vistos > 0 and malos == 0


def mapa(cart, detalle=False):
    """La rejilla y las salidas de las 19 fases: cada habitacion en su casilla,
    sin dos en la misma, y las salidas de ida (la vecina no vuelve) son
    caidas -hacia abajo- o la entrada a la habitacion especial de la fase
    (0x636F, la del jefe). Las que no, se listan: son las que hay que mirar."""
    from graficos import cuantas_habitaciones, HABITACION_ESPECIAL_DE_CADA_FASE, B123
    from mapa import casillas, sin_vuelta, LADOS
    malas, raras, n = 0, [], 0
    for fase in range(19):
        cas = casillas(cart, fase)
        if len(set(cas)) != len(cas) or len(cas) != cuantas_habitaciones(cart, fase):
            print("  fase %2d: casillas repetidas %s" % (fase, cas))
            malas += 1
        jefe = cart.leer(HABITACION_ESPECIAL_DE_CADA_FASE + fase, B123) >> 4
        for h, lado, v in sin_vuelta(cart, fase):
            n += 1
            if LADOS[lado] != "abajo" and v != jefe:
                raras.append((fase, h, LADOS[lado], v))
    for r in raras:
        print("  fase %2d hab %2d: sale por %s a la %d y no vuelve" % r)
    print("mapa: 19 fases, %d salidas de ida, %d que no son caidas ni la del jefe" % (n, len(raras)))
    return malas == 0


def titulo(cart, detalle=False):
    """Las dos pantallas del principio (tools/titulo.py) contra los volcados
    de tools/omsx_titulo.tcl con la BIOS europea y la japonesa: la pagina 0,
    lo que el montaje toca del resto de la VRAM (dibujos, letras, sprites) y
    la paleta en los colores que salen en pantalla; los demas los deja la
    BIOS."""
    from titulo import konami, titulo as pantalla_del_titulo, sprites_del_titulo, COLORES
    malos = vistos = 0
    for nombre, hazla in (("EU_telon", konami), ("JP_telon", konami),
                          ("EU_titulo", pantalla_del_titulo),
                          ("JP_titulo", lambda c: pantalla_del_titulo(c, True))):
        ruta = os.path.join(WORK, "titulo", nombre + ".vram")
        if not os.path.exists(ruta):
            continue
        vistos += 1
        v, d = hazla(cart), _lee(ruta)
        pal = _lee(ruta[:-5] + ".pal")
        paleta = [((pal[2 * k] >> 4) & 7, pal[2 * k + 1] & 7, pal[2 * k] & 7) for k in range(16)]
        usados = {v.punto(0, x, y) for y in range(212) for x in range(256)}
        if nombre == "JP_titulo":
            usados |= {v.v[COLORES + 16 * s] & 15 for s in range(22)}
        dp = sum(1 for k in usados if paleta[k] != v.paleta[k])
        d0 = sum(1 for a in range(212 * ANCHO_DE_LINEA) if v.v[a] != d[a])
        d1 = sum(1 for a in range(212 * ANCHO_DE_LINEA, 0x20000) if v.tocado[a] and v.v[a] != d[a])
        if dp or d0 or d1:
            malos += 1
        print("  %-9s paleta %d de %d, pantalla %d, resto %d" % (nombre, dp, len(usados), d0, d1))
    print("titulo: %d volcados, %d con diferencias" % (vistos, malos))
    return vistos == 4 and malos == 0


def simon(cart, detalle=False):
    """Simon (tools/simon.py) contra los 156 volcados de las habitaciones: los
    patrones de sus poses en la VRAM de 0xF800 y sus atributos y colores en la
    copia de la RAM (0xD400-0xD67F; la VRAM lleva otra, rotada por p01:6560).
    Entre que p01:7837 coloca los sprites y el volcado pasa un cuadro: Simon
    puede haberse movido (vale la posicion que da su primer sprite) y, con
    0xC42D puesto, estar en la otra fase del parpadeo."""
    from graficos import Vram, B123
    from simon import carga_la_pose, coloca, SPRITES_DE_LAS_PIERNAS, N_PIERNAS, N_CUERPO

    patrones = {}

    def patrones_de(piernas, cuerpo):
        """Los bytes que suben las dos poses a 0xF800 y 0xF840."""
        if (piernas, cuerpo) not in patrones:
            v = Vram()
            carga_la_pose(cart, v, piernas, cuerpo)
            patrones[(piernas, cuerpo)] = {a: v.v[a] for a in range(0xF800, 0x10000) if v.tocado[a]}
        return patrones[(piernas, cuerpo)]

    def fallos(d, r, x, y, escondido):
        """Los atributos y colores contra la RAM, con las poses de la RAM."""
        R = lambda a: r[a - 0xC000]  # noqa: E731
        v = Vram()
        coloca(cart, v, R(0xC42E), R(0xC42F), x, y, R(0xC416), R(0xC5AC), R(0xC420), escondido)
        return sum(1 for a in range(0xF400, 0xF800) if v.tocado[a] and v.v[a] != r[a - 0xE000])

    def pose_de_los_patrones(d, piernas, cuerpo):
        """La pose cuyos patrones son los del volcado: la de la RAM o, si en
        ese cuadro ha cambiado, la que haya (None si ninguna)."""
        for p in [piernas] + list(range(N_PIERNAS)):
            if all(d[a] == b for a, b in patrones_de(p, 0).items() if a < 0xF840):
                break
        else:
            return None
        for q in [cuerpo] + list(range(N_CUERPO)):
            if all(d[a] == b for a, b in patrones_de(0, q).items() if a >= 0xF840):
                return p, q
        return None
    vistos = malos = movidos = otra_pose = 0
    for ruta in sorted(glob.glob(os.path.join(WORK, "habitaciones", "hab_f*_h*.vram"))):
        d, r = _lee(ruta), _lee(ruta[:-5] + ".ram")
        R = lambda a: r[a - 0xC000]  # noqa: E731
        vistos += 1
        hl = cart.palabra(SPRITES_DE_LAS_PIERNAS + 2 * R(0xC42E), B123)
        base = 0xD620 if R(0xC5AC) == 5 else 0xD600
        dx = cart.leer(hl + 2, B123)
        movido = ((R(base + 1) - (dx - 256 if dx & 0x80 else dx)) & 0xFF,
                  (R(base) + 2 - cart.leer(hl + 1, B123)) & 0xFF)
        mejor = None
        for k, (x, y) in enumerate(((R(0xC427), R(0xC425)), movido)):
            for escondido in ((False, True) if R(0xC42D) else (False,)):
                n = fallos(d, r, x, y, escondido)
                if mejor is None or n < mejor[0]:
                    mejor = (n, k)
        pose = pose_de_los_patrones(d, R(0xC42E), R(0xC42F))
        if mejor[0] or pose is None:
            malos += 1
            print("  %s: %d bytes de atributos, patrones %s" % (os.path.basename(ruta)[:-5], mejor[0],
                                                              "de ninguna pose" if pose is None else "bien"))
            continue
        movidos += mejor[1]
        if pose != (R(0xC42E), R(0xC42F)):
            otra_pose += 1
            if detalle:
                print("  %s: patrones de la pose %s, la RAM ya dice %s" % (os.path.basename(ruta)[:-5], pose,
                                                                           (R(0xC42E), R(0xC42F))))
    print("simon: %d volcados, %d con Simon movido un cuadro, %d con los patrones de la pose de antes, "
          "%d con diferencias" % (vistos, movidos, otra_pose, malos))
    return vistos > 0 and malos == 0


PRUEBAS = {"habitaciones": habitaciones, "mapa": mapa, "titulo": titulo, "simon": simon}


def main():
    cart = Cartucho()
    cuales = [a for a in sys.argv[1:] if not a.startswith("-")] or list(PRUEBAS)
    detalle = "-v" in sys.argv
    todo = True
    for c in cuales:
        todo &= PRUEBAS[c](cart, detalle)
    print("VERDE" if todo else "ROJO")
    sys.exit(0 if todo else 1)


if __name__ == "__main__":
    main()
