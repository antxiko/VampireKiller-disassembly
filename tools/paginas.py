#!/usr/bin/env python3
"""La regla banco -> direccion del MegaROM, compartida por todas las herramientas.

Penguin Adventure / Yume Tairiku Adventure es un cartucho de 128 KB con el
mapper Konami SIN SCC (Konami4): 16 bancos de 8 KB. El banco de 0x4000-0x5FFF
es FIJO -no hay registro para el- y los otros tres se eligen escribiendo el
numero de banco en 0x6000 (para 0x6000-0x7FFF), 0x8000 (para 0x8000-0x9FFF) y
0xA000 (para 0xA000-0xBFFF).

Lo que dice la ROM (tools/reconocimiento.py lo vuelve a medir cada vez):

  - NO hay ni una escritura a 0x5000, 0x7000, 0x9000 ni 0xB000, que son los
    registros del OTRO mapper de Konami, el que lleva SCC. Por eso este es
    Konami4 y no Konami5.

  - Los bancos se reparten DE TRES EN TRES. La rutina que cambia de modulo
    entra con A = el primer banco del trio y hace `ld (0x6000),a` / `inc a` /
    `ld (0x8000),a` / `inc a` / `ld (0xA000),a`: los 24 KB de 0x6000 a 0xBFFF
    se llenan de golpe con N, N+1 y N+2. Los trios que aparecen son 1-2-3,
    4-5-6 y 7-8-9.

  - Los bancos altos se meten de dos en dos, sin el primer paso: 10-11, 12-13
    y 14-15 van solo a 0x8000 y 0xA000, dejando en 0x6000 lo que hubiera.

  - Ni un solo banco aparece en dos registros distintos. La cuenta completa de
    las 512 escrituras:

        0x6000   banco 1 (55)   banco 4 (16)   banco 7 (43)
        0x8000   banco 2 (87)   banco 5 (16)   banco 8 (43)
                 banco 10 (21)  banco 12 (28)  banco 14 (2)
        0xA000   banco 3 (87)   banco 6 (16)   banco 9 (43)
                 banco 11 (21)  banco 13 (28)  banco 15 (2)

  De ahi sale la tabla de abajo: cada banco tiene UNA sola direccion donde se
  ejecuta, y los 16 estan cubiertos.

        banco 0                        -> 0x4000  (fijo, sin registro)
        bancos 1, 4, 7                 -> 0x6000
        bancos 2, 5, 8, 10, 12, 14     -> 0x8000
        bancos 3, 6, 9, 11, 13, 15     -> 0xA000

  Si alguna vez aparece un banco mapeado en otra ranura, esta regla deja de
  valer para ESE banco y habra que partirlo en dos modulos.

Uso como programa:
    paginas.py org <n>               imprime el org del banco n
    paginas.py lista                 imprime "n org" para los 16
    paginas.py corta <rom> <dir>     escribe <dir>/pNN.bin con cada banco
"""
import os
import sys

TAM_PAGINA = 0x2000
N_PAGINAS = 16

# banco -> direccion de ejecucion. Medido, no supuesto: ver reconocimiento.py.
ORG = {
    0: 0x4000,
    1: 0x6000, 4: 0x6000, 11: 0x6000,
    2: 0x8000, 5: 0x8000, 7: 0x8000, 9: 0x8000, 12: 0x8000, 14: 0x8000,
    3: 0xA000, 6: 0xA000, 8: 0xA000, 10: 0xA000, 13: 0xA000, 15: 0xA000,
}

# Todos los bancos los selecciona alguien: aqui no hay ninguno huerfano.
NUNCA_MAPEADOS = ()


def org(p):
    """Direccion en la que se ejecuta el banco p."""
    return ORG[p]


def nombre(p):
    """Nombre del modulo del banco p: p00..p15."""
    return "p%02d" % p


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    if argv[1] == "org":
        print("%#06x" % org(int(argv[2], 10)))
    elif argv[1] == "lista":
        for p in range(N_PAGINAS):
            print("%d %#06x" % (p, org(p)))
    elif argv[1] == "corta":
        rom, dst = argv[2], argv[3]
        d = open(rom, "rb").read()
        if len(d) != TAM_PAGINA * N_PAGINAS:
            sys.exit("la ROM mide %d bytes y no %d" % (len(d), TAM_PAGINA * N_PAGINAS))
        os.makedirs(dst, exist_ok=True)
        for p in range(N_PAGINAS):
            with open(os.path.join(dst, nombre(p) + ".bin"), "wb") as f:
                f.write(d[p * TAM_PAGINA:(p + 1) * TAM_PAGINA])
        print("16 bancos de %d bytes en %s/" % (TAM_PAGINA, dst))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
