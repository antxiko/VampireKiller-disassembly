# La música

Todo lo que suena aquí sale de ejecutar el motor de sonido del cartucho (`reproductor`, 0x8964 del banco 14, y `sonido`, p00:509F, que apunta las partituras en las fichas de los canales; lo llama la interrupción en p00:403B con los bancos 14 y 15 puestos) en un Z80 emulado, cuadro a cuadro y a 60 por segundo, igual que lo llama el juego. Lo que el motor escribe en el PSG pasa a sonido con un AY-3-8910 (`tools/musica.py`). Cada MP3 es la pieza entera hasta donde vuelve a empezar, más 8 segundos de la vuelta apagándose; las que no se repiten acaban donde acaba el motor.

## Cotejado con openMSX

Las escrituras al PSG se han comparado cuadro a cuadro con las de openMSX (C-BIOS MSX2 japonés). En todos los cuadros el PSG queda igual:

- «Drácula, paso 4» (0x88), sus primeros 181 cuadros;
- «suena la partida» (0x8A) entera, 386 cuadros, dos veces;
- la pieza 0x80, sus primeros 41 cuadros.

El timbre no está cotejado: es el de un AY-3-8910 de manual, no una grabación del emulador. Las sondas están en `tools/omsx_psg.tcl` y `tools/coteja_psg.py`.

## Cómo se pide una pieza

`sonido` recibe el número en A: el 0 lo calla todo, del 0x80 al 0xFA es una música de tres canales cuyas partituras salen de la tabla de 0x8DC9 del banco 14 (seis bytes por música), del 1 al 0x7F es un efecto y del 0xFB en adelante son órdenes especiales. Antes de arrancar hay que correr `inicia_el_sonido`, que deja la copia del mezclador del PSG en 0xBC y los manejadores de los canales en reposo. La RAM del sonido está en 0xC010-0xC0A8. Las pistas «de la tabla» salen de la tabla por un número calculado. Las que repiten partitura de otra se publican una sola vez; las que duran más de 75 segundos sin volver a empezar se cortan a los 75.

## Las músicas

**Suena la partida** (0x8A)

Lo pide `suena_la_partida`; dura 6,4 s.

<audio controls preload="none" src="../audio/musica_8A.mp3?v=f852fb75"></audio>

**Drácula, paso 4** (0x88)

Lo pide `dracula_paso_4`; dura 17,6 s y vuelve a empezar en el segundo 1,6.

<audio controls preload="none" src="../audio/musica_88.mp3?v=0df0e4ce"></audio>

**La salida de la puerta** (0x86)

Lo pide `la_salida_de_la_puerta`; dura 57,6 s y vuelve a empezar en el segundo 22,4.

<audio controls preload="none" src="../audio/musica_86.mp3?v=451dc5d1"></audio>

**Simon muere** (0x89)

Lo pide `simon_muere`; dura 1,6 s.

<audio controls preload="none" src="../audio/musica_89.mp3?v=58dfd7e3"></audio>

**Sin vidas** (0x8B)

Lo pide `sin_vidas`; dura 4,3 s.

<audio controls preload="none" src="../audio/musica_8B.mp3?v=ba43bfc0"></audio>

**Se coge la bola del jefe** (0x8C)

Lo pide `final_del_jefe_coger_la_bola`; dura 4,0 s.

<audio controls preload="none" src="../audio/musica_8C.mp3?v=1e79dec8"></audio>

**Drácula, paso 7** (0x8D)

Lo pide `dracula_paso_7`; dura 4,1 s.

<audio controls preload="none" src="../audio/musica_8D.mp3?v=a5dd66a7"></audio>

**El final empieza** (0x8E)

Lo pide `final_empieza`; dura 18,6 s y vuelve a empezar en el segundo 5,8.

<audio controls preload="none" src="../audio/musica_8E.mp3?v=5fea1edb"></audio>

**Pista 0x80 de la tabla** (0x80)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 39,8 s y vuelve a empezar en el segundo 9,9.

<audio controls preload="none" src="../audio/musica_80.mp3?v=ea22dae0"></audio>

**Pista 0x81 de la tabla** (0x81)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 51,2 s y vuelve a empezar en el segundo 21,4.

<audio controls preload="none" src="../audio/musica_81.mp3?v=02e48628"></audio>

**Pista 0x82 de la tabla** (0x82)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 67,7 s y vuelve a empezar en el segundo 22,4.

<audio controls preload="none" src="../audio/musica_82.mp3?v=9aeaa752"></audio>

**Pista 0x83 de la tabla** (0x83)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 38,4 s y vuelve a empezar en el segundo 6,4.

<audio controls preload="none" src="../audio/musica_83.mp3?v=1be5f27d"></audio>

**Pista 0x84 de la tabla** (0x84)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 63,5 s y vuelve a empezar en el segundo 7,5.

<audio controls preload="none" src="../audio/musica_84.mp3?v=f644db8f"></audio>

**Pista 0x85 de la tabla** (0x85)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 63,6 s y vuelve a empezar en el segundo 28,4.

<audio controls preload="none" src="../audio/musica_85.mp3?v=e76df71e"></audio>

**Pista 0x87 de la tabla** (0x87)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 7,5 s y vuelve a empezar en el segundo 0,0.

<audio controls preload="none" src="../audio/musica_87.mp3?v=f63bf558"></audio>

**Pista 0xAB de la tabla** (0xAB)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 51,2 s y vuelve a empezar en el segundo 21,4.

<audio controls preload="none" src="../audio/musica_AB.mp3?v=e9a2bd93"></audio>

**Pista 0xAC de la tabla** (0xAC)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_AC.mp3?v=a292ecf8"></audio>

**Pista 0xAD de la tabla** (0xAD)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_AD.mp3?v=7338a140"></audio>

**Pista 0xAE de la tabla** (0xAE)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_AE.mp3?v=089069fb"></audio>

**Pista 0xAF de la tabla** (0xAF)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_AF.mp3?v=444874b9"></audio>

**Pista 0xB0 de la tabla** (0xB0)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 58,0 s y vuelve a empezar en el segundo 22,8.

<audio controls preload="none" src="../audio/musica_B0.mp3?v=8c507162"></audio>

**Pista 0xB1 de la tabla** (0xB1)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_B1.mp3?v=472b6280"></audio>

**Pista 0xB2 de la tabla** (0xB2)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_B2.mp3?v=0e2b9fde"></audio>

**Pista 0xB9 de la tabla** (0xB9)

Lo pide ninguna llamada directa: sale de la tabla de musicas por un número calculado; dura 13,0 s y vuelve a empezar en el segundo 0,2.

<audio controls preload="none" src="../audio/musica_B9.mp3?v=d611daf3"></audio>
