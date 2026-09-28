#!/usr/bin/env python3
"""La regla banco -> direccion del MegaROM, compartida por todas las herramientas.

Vampire Killer / Akumajo Dracula es un cartucho de 128 KB con el mapper Konami
SIN SCC (Konami4): 16 bancos de 8 KB. El banco de 0x4000-0x5FFF es FIJO -no hay
registro para el- y los otros tres se eligen escribiendo el numero de banco en
0x6000 (para 0x6000-0x7FFF), 0x8000 (para 0x8000-0x9FFF) y 0xA000 (para
0xA000-0xBFFF).

Lo que dice la ROM (tools/reconocimiento.py lo vuelve a medir cada vez):
  - NO hay ni una escritura a 0x5000, 0x7000, 0x9000 ni 0xB000, que son los
    registros del OTRO mapper de Konami, el que lleva SCC. Por eso este es
    Konami4 y no Konami5.
  - Hay 39 escrituras a los registros: 6 a 0x6000, 17 a 0x8000 y 16 a
    0xA000. Dos de ellas (p00:4042 y p00:4048) devuelven el banco que guardan
    las copias 0xF0F2 y 0xF0F3; las otras 37 llevan el numero en el codigo.
  - Los trios se meten con `ld a,N` / `inc a` / `inc a`: 1-2-3, 4-5-6 y
    11-12-13 llenan de golpe 0x6000-0xBFFF. Las parejas 7-8, 9-10 y 14-15 van
    solo a 0x8000 y 0xA000. Y hay escrituras sueltas (p01:6451 el banco 6,
    p01:6746 el 8, p01:6750 el 5...) que respetan la misma ranura.
  - Ni un solo banco aparece en dos registros distintos:
        0x6000   bancos 1, 4, 11
        0x8000   bancos 2, 5, 7, 9, 12, 14
        0xA000   bancos 3, 6, 8, 10, 13, 15
  De ahi sale la tabla de abajo: cada banco tiene UNA sola direccion donde se
  ejecuta, y los 16 estan cubiertos.

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
