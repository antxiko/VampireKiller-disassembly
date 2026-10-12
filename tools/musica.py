#!/usr/bin/env python3
"""La musica del cartucho, ejecutando su motor de sonido (ver motor_musica.py).

`sonido` (p00:509F, A = numero) pide el sonido: 0 lo calla todo, 0x80-0xFA es
una musica de tres canales (tabla de 0x8DC9 del banco 14) y 1-0x7F un efecto.
Antes se corre `inicia_el_sonido` (p00:5076), que deja la mezcla del PSG en
0xBC. El reproductor `reproductor` (p14:8964, bancos 14 y 15) lo llama la
interrupcion en cada cuadro (p00:403B). La RAM del sonido es 0xC010-0xC0A8.
MegaROM Konami4 de 128 KB, MSX2, sin SCC.
Uso:  musica.py registros 0x88 [cuadros] | mp3 0x88 f.mp3 | todas docs/audio
      musica.py barrido 0x80 0xFA | emu
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
from motor_musica import P  # noqa: E402

TABLA = "ninguna llamada directa: sale de la tabla de musicas por un número calculado"

PIEZAS = [
    P(0x8A, "Suena la partida", "The game plays", "`suena_la_partida`"),
    P(0x88, "Drácula, paso 4", "Dracula, step 4", "`dracula_paso_4`"),
    P(0x86, "La salida de la puerta", "Out of the door",
      "`la_salida_de_la_puerta`"),
    P(0x89, "Simon muere", "Simon dies", "`simon_muere`"),
    P(0x8B, "Sin vidas", "No lives left", "`sin_vidas`"),
    P(0x8C, "Se coge la bola del jefe", "The boss's ball is taken",
      "`final_del_jefe_coger_la_bola`"),
    P(0x8D, "Drácula, paso 7", "Dracula, step 7", "`dracula_paso_7`"),
    P(0x8E, "El final empieza", "The ending begins", "`final_empieza`"),
] + [P(n, "Pista 0x%02X de la tabla" % n, "Table track 0x%02X" % n, TABLA)
     for n in (0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x87, 0xAB, 0xAC, 0xAD,
               0xAE, 0xAF, 0xB0, 0xB1, 0xB2, 0xB9)]

PAGINA = motor_musica.pagina_basica(
    "`reproductor`, 0x8964 del banco 14, y `sonido`, p00:509F, que apunta las "
    "partituras en las fichas de los canales; lo llama la interrupción en "
    "p00:403B con los bancos 14 y 15 puestos",
    "`reproductor`, 0x8964 of bank 14, and `sonido`, p00:509F, which writes "
    "the scores into the channel records; the interrupt calls it at "
    "p00:403B with banks 14 and 15 mapped",
    "C-BIOS MSX2 japonés",
    [("«Drácula, paso 4» (0x88), sus primeros 181 cuadros",
      "\"Dracula, step 4\" (0x88), its first 181 frames"),
     ("«suena la partida» (0x8A) entera, 386 cuadros, dos veces",
      "\"the game plays\" (0x8A), whole, 386 frames, twice"),
     ("la pieza 0x80, sus primeros 41 cuadros",
      "tune 0x80, its first 41 frames")],
    [("Cómo se pide una pieza",
      "`sonido` recibe el número en A: el 0 lo calla todo, del 0x80 al 0xFA "
      "es una música de tres canales cuyas partituras salen de la tabla de "
      "0x8DC9 del banco 14 (seis bytes por música), del 1 al 0x7F es un "
      "efecto y del 0xFB en adelante son órdenes especiales. Antes de "
      "arrancar hay que correr `inicia_el_sonido`, que deja la copia del "
      "mezclador del PSG en 0xBC y los manejadores de los canales en "
      "reposo. La RAM del sonido está en 0xC010-0xC0A8. Las pistas «de la "
      "tabla» salen de la tabla por un número calculado. Las que repiten "
      "partitura de otra se publican una sola vez; las que duran más de "
      "75 segundos sin volver a empezar se cortan a los 75.",
      "How a piece is asked for",
      "`sonido` takes the number in A: 0 silences everything, 0x80 to 0xFA "
      "is a three-channel tune whose scores come from the 0x8DC9 table of "
      "bank 14 (six bytes per tune), 1 to 0x7F is an effect and from 0xFB "
      "up are special orders. Before starting, `inicia_el_sonido` must run: "
      "it leaves the copy of the PSG mixer at 0xBC and the channel handlers "
      "idle. The sound RAM is at 0xC010-0xC0A8. The tracks marked «in the "
      "table» come out of the table by a computed number. Tunes that reuse "
      "another's score are published only once; those that last over 75 "
      "seconds without starting again are cut at 75.")])

CFG = dict(rom="vampirekiller.rom", org=0x4000, mapper="konami",
           bancos0=((0x4000, 0), (0x6000, 1), (0x8000, 14), (0xA000, 15)),
           init=[(0x5076, {})], bancos_frame=((0x8000, 14), (0xA000, 15)),
           frame=0x8964, pide=0x509F, banco_frame=14, banco_pide=0,
           ram=(0xC010, 0xC0AA), hz=60, psg0={7: 0xBC}, romtype="konami",
           maquina="C-BIOS_MSX2_JP", max_s=75, piezas=PIEZAS, pagina=PAGINA,
           cotejado=[(0x8A, 386, None), (0x88, 1057, 97)])

if __name__ == "__main__":
    sys.exit(motor_musica.main(CFG, sys.argv[1:]))
