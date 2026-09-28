#!/usr/bin/env python3
"""Saca la marca que Konami escondio al final de algunos cartuchos de MSX.

El hallazgo no es nuestro: lo destapo Manuel Pazos (@ManuelPazosMSX) en
septiembre de 2021. Gracias a el se sabe que hay que mirar ahi.

Detras del relleno 0xFF, leyendo hacia el final del fichero:

    [titulo, N bytes, EN ORDEN INVERSO]  [N]  [las dos ultimas cifras del RC en
    BCD]  [0xAA]

El titulo va en katakana con el codigo de la casa: indice = byte - 0x80, y los
indices 0 a 44 son el gojuon corrido, sin ヲ. El 0x00 es un espacio. Las
CIFRAS, en cambio, van en ASCII pelado: pasa en los cartuchos RC-733, RC-737 y
RC-735, cuyos titulos acaban en un numero.

EN UN MEGAROM NO ESTA AL FINAL DEL FICHERO. En un cartucho de 16 o 32 KB la
marca cae en los ultimos bytes de la imagen, y basta con saltar el relleno
0xFF desde el final. En un MegaROM puede estar al final de CUALQUIER banco
-detras quedan decenas de KB mas de datos-, asi que buscando desde el final del
fichero no aparece. Por eso aqui se prueba el final del fichero Y el final de
cada trozo de 8 y de 16 KB.

Uso: marca_konami.py <rom> [<rom> ...]
Sale con 1 si ninguna de las ROM lleva marca.
"""
import os
import sys

# El gojuon corrido, que es el orden en el que Konami numero los caracteres.
KANA = ("A I U E O KA KI KU KE KO SA SI SU SE SO TA TI TU TE TO "
        "NA NI NU NE NO HA HI HU HE HO MA MI MU ME MO YA YU YO "
        "RA RI RU RE RO WA N").split()
# Los kana pequenos y los signos van detras de los 45 basicos, del 49 en
# adelante. Cada uno se ha DESPEJADO con una marca ya conocida de la serie, no
# supuesto por el orden del silabario -que no lo siguen-. Los cartuchos se citan
# por numero de catalogo, que es como vienen dentro de la propia marca:
#
#   49 ya   RC-728  MO HI o RE N SI " [49] [58]        -> モピレンジャー
#   50 yu   RC-724  YA KI [50] U                       -> ヤキュウ
#   52 i    RC-742  KU " RA TE " [52] U SU             -> グラディウス
#   54 a    RC-730  RO [58] TO " _ HU [54] I TA [58]   -> ロードファイター
#   57 .    RC-725  I [58] [57] A RU [57] KA N HU [58] -> イー・アル・カンフー
#   58 -    los tres de arriba a la vez (alargamiento)
#
# Los otros cuatro ya venian de antes: 51 yo, 53 tsu, 55 dakuten, 56 handakuten.
EXTRA = {49: "ya", 50: "yu", 51: "yo", 52: "i", 53: "tsu", 54: "a",
         55: '"', 56: "o", 57: ".", 58: "-"}


def caracter(v):
    if v == 0:
        return " "
    if 0x30 <= v <= 0x39:       # las cifras van en ASCII, no en el codigo de la casa
        return chr(v)
    i = v - 0x80
    if 0 <= i < len(KANA):
        return KANA[i]
    if i in EXTRA:
        return EXTRA[i]
    return "<%02X>" % v


def marca(rom, fin=None):
    """(rc, cuantos, titulo ya puesto del derecho) o None si no la lleva.

    `fin` es donde se empieza a mirar hacia atras: por defecto, el final del
    fichero. En un MegaROM hay que probar tambien el final de cada banco.
    """
    i = (len(rom) if fin is None else fin) - 1
    while i > 0 and rom[i] == 0xFF:
        i -= 1
    if i < 3 or rom[i] != 0xAA:
        return None
    rc, n = rom[i - 1], rom[i - 2]
    if n == 0 or n > i - 2:
        return None
    return rc, n, bytes(reversed(rom[i - 2 - n:i - 2]))


def busca(rom):
    """Todos los sitios donde aparece la marca: (donde acaba, rc, n, titulo)."""
    fuera = []
    finales = [len(rom)]
    for tam in (0x2000, 0x4000):
        finales += list(range(tam, len(rom) + 1, tam))
    for fin in sorted(set(finales)):
        m = marca(rom, fin)
        if m and all(m != (r, n, t) for _f, r, n, t in fuera):
            fuera.append((fin, m[0], m[1], m[2]))
    return fuera


def main():
    alguna = False
    for fn in sys.argv[1:]:
        rom = open(fn, "rb").read()
        nombre = os.path.basename(fn)
        encontradas = busca(rom)
        if not encontradas:
            print("  %-48s sin marca" % nombre[:48])
            continue
        alguna = True
        for fin, rc, n, tit in encontradas:
            print("  %-48s RC-7%02X  %d caracteres  (acaba en el offset %#07x, "
                  "banco %d)" % (nombre[:48], rc, n, fin - 1, (fin - 1) // 0x2000))
            print("  %-48s %s" % ("", " ".join(caracter(v) for v in tit)))
    sys.exit(0 if alguna else 1)


if __name__ == "__main__":
    main()
