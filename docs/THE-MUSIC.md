# The music

Everything you hear here comes from running the cartridge's own sound engine (`reproductor`, 0x8964 of bank 14, and `sonido`, p00:509F, which writes the scores into the channel records; the interrupt calls it at p00:403B with banks 14 and 15 mapped) on an emulated Z80, frame by frame at 60 per second, just as the game calls it. What the engine writes to the PSG is turned into sound with an AY-3-8910 (`tools/musica.py`). Each MP3 is the whole piece up to where it starts again, plus 8 seconds of the repeat fading out; those that do not repeat end where the engine ends.

## Checked against openMSX

The PSG writes have been compared frame by frame with those of openMSX (C-BIOS MSX2 japonés). In every frame the PSG ends up the same:

- "Dracula, step 4" (0x88), its first 181 frames;
- "the game plays" (0x8A), whole, 386 frames, twice;
- tune 0x80, its first 41 frames.

The timbre is not checked: it is a textbook AY-3-8910, not a recording of the emulator. The probes are `tools/omsx_psg.tcl` and `tools/coteja_psg.py`.

## How a piece is asked for

`sonido` takes the number in A: 0 silences everything, 0x80 to 0xFA is a three-channel tune whose scores come from the 0x8DC9 table of bank 14 (six bytes per tune), 1 to 0x7F is an effect and from 0xFB up are special orders. Before starting, `inicia_el_sonido` must run: it leaves the copy of the PSG mixer at 0xBC and the channel handlers idle. The sound RAM is at 0xC010-0xC0A8. The tracks marked «in the table» come out of the table by a computed number. Tunes that reuse another's score are published only once; those that last over 75 seconds without starting again are cut at 75.

## The tunes

**The game plays** (0x8A)

Asked for by `suena_la_partida`; lasts 6.4 s.

<audio controls preload="none" src="audio/musica_8A.mp3?v=f852fb75"></audio>

**Dracula, step 4** (0x88)

Asked for by `dracula_paso_4`; lasts 17.6 s and starts again at second 1.6.

<audio controls preload="none" src="audio/musica_88.mp3?v=0df0e4ce"></audio>

**Out of the door** (0x86)

Asked for by `la_salida_de_la_puerta`; lasts 57.6 s and starts again at second 22.4.

<audio controls preload="none" src="audio/musica_86.mp3?v=451dc5d1"></audio>

**Simon dies** (0x89)

Asked for by `simon_muere`; lasts 1.6 s.

<audio controls preload="none" src="audio/musica_89.mp3?v=58dfd7e3"></audio>

**No lives left** (0x8B)

Asked for by `sin_vidas`; lasts 4.3 s.

<audio controls preload="none" src="audio/musica_8B.mp3?v=ba43bfc0"></audio>

**The boss's ball is taken** (0x8C)

Asked for by `final_del_jefe_coger_la_bola`; lasts 4.0 s.

<audio controls preload="none" src="audio/musica_8C.mp3?v=1e79dec8"></audio>

**Dracula, step 7** (0x8D)

Asked for by `dracula_paso_7`; lasts 4.1 s.

<audio controls preload="none" src="audio/musica_8D.mp3?v=a5dd66a7"></audio>

**The ending begins** (0x8E)

Asked for by `final_empieza`; lasts 18.6 s and starts again at second 5.8.

<audio controls preload="none" src="audio/musica_8E.mp3?v=5fea1edb"></audio>

**Table track 0x80** (0x80)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 39.8 s and starts again at second 9.9.

<audio controls preload="none" src="audio/musica_80.mp3?v=ea22dae0"></audio>

**Table track 0x81** (0x81)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 51.2 s and starts again at second 21.4.

<audio controls preload="none" src="audio/musica_81.mp3?v=02e48628"></audio>

**Table track 0x82** (0x82)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 67.7 s and starts again at second 22.4.

<audio controls preload="none" src="audio/musica_82.mp3?v=9aeaa752"></audio>

**Table track 0x83** (0x83)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 38.4 s and starts again at second 6.4.

<audio controls preload="none" src="audio/musica_83.mp3?v=1be5f27d"></audio>

**Table track 0x84** (0x84)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 63.5 s and starts again at second 7.5.

<audio controls preload="none" src="audio/musica_84.mp3?v=f644db8f"></audio>

**Table track 0x85** (0x85)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 63.6 s and starts again at second 28.4.

<audio controls preload="none" src="audio/musica_85.mp3?v=e76df71e"></audio>

**Table track 0x87** (0x87)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 7.5 s and starts again at second 0.0.

<audio controls preload="none" src="audio/musica_87.mp3?v=f63bf558"></audio>

**Table track 0xAB** (0xAB)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 51.2 s and starts again at second 21.4.

<audio controls preload="none" src="audio/musica_AB.mp3?v=e9a2bd93"></audio>

**Table track 0xAC** (0xAC)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_AC.mp3?v=a292ecf8"></audio>

**Table track 0xAD** (0xAD)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_AD.mp3?v=7338a140"></audio>

**Table track 0xAE** (0xAE)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_AE.mp3?v=089069fb"></audio>

**Table track 0xAF** (0xAF)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_AF.mp3?v=444874b9"></audio>

**Table track 0xB0** (0xB0)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 58.0 s and starts again at second 22.8.

<audio controls preload="none" src="audio/musica_B0.mp3?v=8c507162"></audio>

**Table track 0xB1** (0xB1)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_B1.mp3?v=472b6280"></audio>

**Table track 0xB2** (0xB2)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_B2.mp3?v=0e2b9fde"></audio>

**Table track 0xB9** (0xB9)

Asked for by ninguna llamada directa: sale de la tabla de musicas por un número calculado; lasts 13.0 s and starts again at second 0.2.

<audio controls preload="none" src="audio/musica_B9.mp3?v=d611daf3"></audio>
