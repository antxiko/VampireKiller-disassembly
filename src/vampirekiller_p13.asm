; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 13 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS bloques_9AC1_cola: 88 bloques de 32x32 (16 bytes cada uno: 4 x 4
;   dibujos de 8x8); tantos como el indice mas alto que usan sus habitaciones
;   (sigue del banco anterior, 0x9AC1); lo leen p00:5010 (65 bytes)
;   0xa000..0xa041  (65 bytes)
DATA_bloques_9AC1_cola:
	defb 000h,067h,071h,072h,073h,076h,000h,000h,077h,07ah,07bh,07ch,07dh,082h,083h,084h	; a000  .gqrsv..wz{|}...
	defb 085h,074h,075h,000h,000h,078h,079h,000h,000h,07eh,07fh,080h,081h,086h,087h,088h	; a010  .tu..xy..~......
	defb 089h,000h,000h,0e1h,0e0h,000h,000h,0e5h,0e4h,0edh,0ech,0ebh,0eah,0f5h,0f4h,0f3h	; a020  ................
	defb 0f2h,0dfh,0deh,0ddh,0d3h,0e3h,000h,000h,0e2h,0e9h,0e8h,0e7h,0e6h,0f1h,0f0h,0efh	; a030  ................
	defb 0eeh	; a040

; ----------------------------------------------------------------------
; DATOS bloques_A041: 36 bloques de 32x32 (16 bytes cada uno: 4 x 4 dibujos de
;   8x8); tantos como el indice mas alto que usan sus habitaciones; lo leen
;   p00:5010 (576 bytes)
;   0xa041..0xa281  (576 bytes)
DATA_bloques_A041:
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h	; a041  ................
	defb 001h,001h,001h,001h,017h,002h,001h,001h,003h,017h,001h,001h,004h,005h,001h,001h	; a051  ................
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,008h,001h,001h,001h,018h	; a061  ................
	defb 000h,000h,005h,006h,000h,000h,003h,004h,000h,000h,000h,007h,000h,000h,000h,000h	; a071  ................
	defb 001h,001h,001h,001h,017h,002h,001h,001h,003h,017h,001h,001h,004h,005h,001h,001h	; a081  ................
	defb 001h,001h,001h,001h,001h,001h,00ah,019h,001h,001h,00bh,01ah,001h,001h,000h,000h	; a091  ................
	defb 001h,001h,001h,000h,00ch,00dh,013h,01bh,000h,01eh,001h,000h,000h,000h,00eh,000h	; a0a1  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; a0b1  ................
	defb 000h,000h,01eh,001h,000h,000h,01eh,012h,000h,000h,015h,013h,000h,000h,018h,014h	; a0c1  ................
	defb 014h,00fh,000h,000h,011h,010h,000h,000h,003h,000h,000h,000h,004h,000h,000h,000h	; a0d1  ................
	defb 016h,008h,001h,001h,01ch,018h,001h,001h,001h,01bh,001h,001h,001h,01bh,001h,001h	; a0e1  ................
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,025h	; a0f1  ...............%
	defb 01fh,020h,001h,001h,021h,022h,001h,001h,023h,024h,001h,001h,026h,027h,001h,001h	; a101  . ..!"..#$..&'..
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,009h,00fh	; a111  ................
	defb 01eh,000h,019h,00ch,013h,000h,000h,000h,00eh,000h,000h,000h,000h,000h,000h,000h	; a121  ................
	defb 00eh,00dh,001h,001h,000h,01eh,001h,001h,000h,01dh,001h,001h,000h,015h,001h,001h	; a131  ................
	defb 001h,001h,001h,001h,001h,001h,001h,00fh,001h,001h,011h,003h,001h,001h,00fh,004h	; a141  ................
	defb 009h,00fh,004h,003h,004h,003h,000h,000h,007h,000h,000h,000h,000h,000h,000h,000h	; a151  ................
	defb 000h,000h,01eh,001h,000h,000h,01dh,012h,000h,000h,017h,013h,000h,000h,018h,014h	; a161  ................
	defb 001h,00fh,000h,000h,011h,010h,000h,000h,000h,000h,000h,000h,004h,000h,000h,000h	; a171  ................
	defb 000h,000h,000h,000h,07bh,07ch,07ah,07bh,039h,03ah,03bh,03ch,040h,041h,042h,043h	; a181  ....{|z{9:;<@ABC
	defb 000h,000h,000h,000h,07bh,07ah,07ch,07ch,03dh,03eh,03ah,03bh,044h,045h,041h,042h	; a191  ....{z||=>:;DEAB
	defb 000h,000h,000h,000h,07ah,07bh,02ah,02ah,03eh,03fh,034h,035h,050h,046h,064h,065h	; a1a1  ....z{**>?45PFde
	defb 000h,000h,000h,028h,02bh,02ch,02dh,02eh,036h,037h,038h,05eh,05fh,060h,066h,067h	; a1b1  ...(+,-.678^_`fg
	defb 047h,048h,042h,049h,050h,051h,052h,053h,07dh,07fh,080h,080h,000h,000h,000h,000h	; a1c1  GHBIPQRS}.......
	defb 04ah,04bh,04ch,04dh,054h,055h,056h,042h,07dh,07eh,080h,080h,000h,000h,000h,000h	; a1d1  JKLMTUVB}~......
	defb 04eh,04fh,06ch,06dh,043h,057h,074h,075h,07eh,07fh,07eh,07fh,000h,000h,000h,000h	; a1e1  NOlmCWtu~.~.....
	defb 05fh,060h,06eh,06fh,036h,060h,076h,077h,07fh,07fh,080h,07dh,000h,000h,000h,000h	; a1f1  _`no6`vw...}....
	defb 029h,000h,000h,000h,02fh,02ah,030h,031h,05fh,060h,061h,05eh,05fh,060h,068h,069h	; a201  ).../*01_`a^_`hi
	defb 000h,000h,000h,000h,032h,033h,07bh,07ch,062h,063h,058h,03dh,06ah,06bh,059h,044h	; a211  ....23{|bcX=jkYD
	defb 000h,000h,000h,000h,07ah,07bh,07bh,07ah,03eh,03ah,03bh,05ch,047h,041h,042h,045h	; a221  ....z{{z>:;\GABE
	defb 000h,000h,000h,000h,07ch,07ch,07ch,07bh,03eh,05ch,03ah,05dh,040h,043h,048h,052h	; a231  ....|||{>\:]@CHR
	defb 070h,05fh,071h,05eh,036h,078h,076h,077h,07eh,07fh,07dh,080h,000h,000h,000h,000h	; a241  p_q^6xvw~.}.....
	defb 072h,073h,05ah,045h,079h,074h,05bh,050h,07fh,07eh,07fh,080h,000h,000h,000h,000h	; a251  rsZEyt[P.~......
	defb 040h,048h,042h,04ah,053h,051h,052h,054h,07dh,07eh,080h,080h,000h,000h,000h,000h	; a261  @HBJSQRT}~......
	defb 04bh,049h,051h,042h,055h,045h,04ch,042h,07fh,07eh,07eh,080h,000h,000h,000h,000h	; a271  KIQBUELB.~~.....

; ----------------------------------------------------------------------
; DATOS tabla_A281: 40 punteros a rle que lee p00:56F4; lo leen p00:56F4 (80
;   bytes)
;   0xa281..0xa2d1  (80 bytes)
DATA_tabla_A281:
	defb 0d1h,0ach	; a281
	defb 04eh,0adh	; a283
	defb 0c3h,0adh	; a285
	defb 0b4h,0afh	; a287
	defb 026h,0b0h	; a289
	defb 09bh,0b0h	; a28b
	defb 071h,0b1h	; a28d
	defb 0ffh,0b1h	; a28f
	defb 04bh,0b2h	; a291
	defb 0bch,0b2h	; a293
	defb 0cah,0a3h	; a295
	defb 047h,0a4h	; a297
	defb 0bch,0a4h	; a299
	defb 0adh,0a6h	; a29b
	defb 020h,0a7h	; a29d
	defb 095h,0a7h	; a29f
	defb 069h,0a8h	; a2a1
	defb 0f4h,0a8h	; a2a3
	defb 041h,0a9h	; a2a5
	defb 0b1h,0a9h	; a2a7
	defb 0bch,0aeh	; a2a9
	defb 0fdh,0aeh	; a2ab
	defb 036h,0afh	; a2ad
	defb 0ceh,0b0h	; a2af
	defb 005h,0b1h	; a2b1
	defb 03eh,0b1h	; a2b3
	defb 09eh,0b1h	; a2b5
	defb 0ffh,0b1h	; a2b7
	defb 04bh,0b2h	; a2b9
	defb 0bch,0b2h	; a2bb
	defb 0b5h,0a5h	; a2bd
	defb 0f6h,0a5h	; a2bf
	defb 02fh,0a6h	; a2c1
	defb 0c7h,0a7h	; a2c3
	defb 0feh,0a7h	; a2c5
	defb 037h,0a8h	; a2c7
	defb 095h,0a8h	; a2c9
	defb 0f4h,0a8h	; a2cb
	defb 041h,0a9h	; a2cd
	defb 0b1h,0a9h	; a2cf

; ----------------------------------------------------------------------
; DATOS tabla_A2D1: 36 punteros a rle que lee p00:5707; lo leen p00:5707 (72
;   bytes)
;   0xa2d1..0xa319  (72 bytes)
DATA_tabla_A2D1:
	defb 093h,0ach	; a2d1
	defb 012h,0adh	; a2d3
	defb 087h,0adh	; a2d5
	defb 0cch,0b1h	; a2d7
	defb 035h,0b2h	; a2d9
	defb 08ah,0b2h	; a2db
	defb 0edh,0b2h	; a2dd
	defb 04ah,0b3h	; a2df
	defb 092h,0b3h	; a2e1
	defb 0fbh,0b3h	; a2e3
	defb 06bh,0b4h	; a2e5
	defb 0beh,0b4h	; a2e7
	defb 0edh,0b2h	; a2e9
	defb 02dh,0b5h	; a2eb
	defb 056h,0b5h	; a2ed
	defb 08ch,0a3h	; a2ef
	defb 00bh,0a4h	; a2f1
	defb 080h,0a4h	; a2f3
	defb 0c1h,0a8h	; a2f5
	defb 02bh,0a9h	; a2f7
	defb 080h,0a9h	; a2f9
	defb 0e2h,0a9h	; a2fb
	defb 03fh,0aah	; a2fd
	defb 087h,0aah	; a2ff
	defb 0eeh,0aah	; a301
	defb 060h,0abh	; a303
	defb 0b4h,0abh	; a305
	defb 0e2h,0a9h	; a307
	defb 021h,0ach	; a309
	defb 04ch,0ach	; a30b
	defb 005h,0aeh	; a30d
	defb 043h,0aeh	; a30f
	defb 080h,0aeh	; a311
	defb 0feh,0a4h	; a313
	defb 03ch,0a5h	; a315
	defb 079h,0a5h	; a317

; ----------------------------------------------------------------------
; DATOS rle_A319: rle a la VRAM (0x00 acaba, 0x80 otro destino, 1nnnnnnn van
;   tal cual, 0nnnnnnn repite el que viene); lo leen p00:5681 (56 bytes)
;   0xa319..0xa351  (56 bytes)
DATA_rle_A319:
	defb 007h,000h,089h,006h,017h,01bh,030h,030h,060h,06bh,06bh,040h,007h,000h,095h,018h	; a319  ......00`kk@....
	defb 0fah,0f6h,002h,000h,002h,0f2h,0f0h,000h,001h,003h,003h,007h,003h,001h,00fh,01fh	; a329  ................
	defb 02fh,027h,04fh,04fh,004h,0ffh,081h,0e0h,003h,0f0h,002h,0e0h,08ah,0fch,0feh,0fdh	; a339  /'OO............
	defb 0f9h,0fdh,0ffh,0ffh,0f7h,0ffh,0ffh,000h	; a349  ........

; ----------------------------------------------------------------------
; DATOS rle_A351: rle a la VRAM (0x00 acaba, 0x80 otro destino, 1nnnnnnn van
;   tal cual, 0nnnnnnn repite el que viene); lo leen p00:568A (59 bytes)
;   0xa351..0xa38c  (59 bytes)
DATA_rle_A351:
	defb 089h,020h,008h,008h,00ah,002h,006h,006h,000h,004h,003h,006h,087h,004h,00eh,01eh	; a351  . ..............
	defb 000h,000h,004h,000h,004h,030h,082h,000h,010h,003h,030h,08bh,010h,038h,03ch,000h	; a361  .....0....0..8<.
	defb 05fh,03fh,01fh,01dh,01dh,009h,00bh,006h,00fh,08ah,01fh,03fh,03fh,0feh,0fah,0feh	; a371  _?.........??...
	defb 0ceh,0c8h,048h,068h,006h,078h,083h,07ch,07eh,07eh,000h	; a381  ..Hh.x.|~~.

; ----------------------------------------------------------------------
; DATOS rle_A38C: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5693,
;   p00:5707 (62 bytes)
;   0xa38c..0xa3ca  (62 bytes)
DATA_rle_A38C:
	defb 003h,000h,08dh,00ch,00eh,00eh,00ch,003h,007h,000h,006h,066h,06ah,02ch,000h,001h	; a38c  ...........fj,..
	defb 006h,000h,0aah,078h,0f0h,0f0h,066h,002h,000h,000h,040h,008h,050h,000h,00fh,01fh	; a39c  ...x..f...@.P...
	defb 013h,01bh,013h,017h,01dh,003h,00fh,079h,099h,09dh,05fh,03fh,003h,000h,000h,080h	; a3ac  .......y.._?....
	defb 0c0h,0c0h,0f8h,0fch,0fch,0feh,0f9h,0fdh,0ffh,0fch,0fch,0f8h,0f8h,000h	; a3bc  ..............

; ----------------------------------------------------------------------
; DATOS rle_A3CA: rle a la VRAM, de la tabla de 0xA281; lo leen p00:569C,
;   p00:56F4 (65 bytes)
;   0xa3ca..0xa40b  (65 bytes)
DATA_rle_A3CA:
	defb 088h,000h,002h,004h,006h,00eh,00ch,010h,000h,003h,018h,08fh,010h,038h,078h,000h	; a3ca  .............8x.
	defb 000h,040h,040h,000h,070h,070h,030h,020h,008h,018h,00ch,003h,006h,08ah,00eh,000h	; a3da  .@@.pp0 ........
	defb 000h,001h,003h,007h,009h,011h,032h,02ch,004h,03ch,081h,038h,003h,0fch,081h,000h	; a3ea  ......2,.<.8....
	defb 003h,0fch,002h,088h,085h,0c8h,058h,07ch,03eh,01fh,003h,00fh,002h,01fh,081h,000h	; a3fa  ......X|>.......
	defb 000h	; a40a

; ----------------------------------------------------------------------
; DATOS rle_A40B: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:56A5,
;   p00:5707 (60 bytes)
;   0xa40b..0xa447  (60 bytes)
DATA_rle_A40B:
	defb 002h,000h,08dh,060h,070h,078h,07bh,017h,004h,059h,030h,020h,001h,013h,03fh,03eh	; a40b  ...`px{..Y0 ..?>
	defb 006h,000h,09bh,080h,040h,0a0h,0c0h,0c0h,020h,060h,0a0h,080h,000h,080h,07ch,0fch	; a41b  ....@... `....|.
	defb 09eh,0deh,09fh,0bdh,0fbh,07fh,0feh,07fh,03fh,03eh,02dh,043h,043h,03fh,004h,000h	; a42b  ........?>-CC?..
	defb 088h,080h,0c0h,0c0h,060h,020h,020h,0c0h,0d0h,004h,0f0h,000h	; a43b  ....`  .....

; ----------------------------------------------------------------------
; DATOS rle_A447: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56AE,
;   p00:56F4 (57 bytes)
;   0xa447..0xa480  (57 bytes)
DATA_rle_A447:
	defb 002h,010h,002h,003h,086h,00bh,01bh,01bh,008h,007h,003h,003h,001h,084h,003h,000h	; a447  ................
	defb 000h,080h,009h,000h,002h,0a0h,002h,0c0h,002h,000h,002h,01fh,088h,01ch,00ch,014h	; a457  ................
	defb 024h,024h,037h,01fh,007h,003h,003h,002h,007h,081h,000h,003h,0e0h,005h,080h,081h	; a467  $$7.............
	defb 0c0h,003h,0f0h,002h,0e0h,082h,0c0h,000h,000h	; a477  .........

; ----------------------------------------------------------------------
; DATOS rle_A480: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:56B7,
;   p00:5707 (60 bytes)
;   0xa480..0xa4bc  (60 bytes)
DATA_rle_A480:
	defb 003h,000h,08dh,060h,070h,078h,079h,013h,006h,02ch,018h,010h,004h,00fh,00fh,00ch	; a480  ...`pxy..,......
	defb 006h,000h,09ah,080h,0c0h,000h,0e0h,040h,010h,0c0h,0e0h,088h,048h,000h,07ch,0feh	; a490  .......@....H.|.
	defb 09eh,0dfh,09fh,0beh,0fdh,03fh,05fh,03fh,03fh,03bh,010h,011h,01fh,005h,000h,08bh	; a4a0  .....?_??;......
	defb 080h,0c0h,0e0h,0e0h,010h,0b8h,0f8h,038h,0f8h,0fch,0fch,000h	; a4b0  .......8....

; ----------------------------------------------------------------------
; DATOS rle_A4BC: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56C0,
;   p00:56F4 (66 bytes)
;   0xa4bc..0xa4fe  (66 bytes)
DATA_rle_A4BC:
	defb 088h,001h,003h,007h,00eh,01ch,000h,000h,030h,003h,038h,0a1h,030h,070h,0f0h,000h	; a4bc  ........0.8.0p..
	defb 000h,0b8h,0c0h,080h,000h,060h,060h,000h,010h,038h,018h,00ch,006h,00ch,01ch,000h	; a4cc  .....``..8......
	defb 000h,00eh,004h,008h,031h,063h,07ch,078h,078h,07ch,07ch,078h,078h,003h,0f8h,091h	; a4dc  ....1c|xx||xx...
	defb 000h,07ch,03ch,07ch,0f0h,090h,090h,0f0h,0f8h,07ch,03eh,01eh,00eh,01eh,03eh,07eh	; a4ec  .|<|.....|>...>~
	defb 000h,000h	; a4fc

; ----------------------------------------------------------------------
; DATOS rle_A4FE: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (62
;   bytes)
;   0xa4fe..0xa53c  (62 bytes)
DATA_rle_A4FE:
	defb 003h,000h,08dh,00ch,00eh,00eh,00ch,043h,067h,060h,046h,026h,06ah,06ch,060h,041h	; a4fe  .......Cg`F&jl`A
	defb 006h,000h,0aah,078h,0f0h,0f0h,066h,002h,000h,000h,040h,008h,050h,000h,00fh,01fh	; a50e  ...x..f...@.P...
	defb 013h,01bh,013h,0d7h,0fdh,0b3h,0bfh,0f9h,0f9h,0bdh,0bfh,0bfh,0b3h,000h,000h,080h	; a51e  ................
	defb 0c0h,0c0h,0f8h,0fch,0fch,0feh,0f9h,0fdh,0ffh,0fch,0fch,0f8h,0f8h,000h	; a52e  ..............

; ----------------------------------------------------------------------
; DATOS rle_A53C: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (61
;   bytes)
;   0xa53c..0xa579  (61 bytes)
DATA_rle_A53C:
	defb 002h,000h,08eh,060h,070h,078h,07bh,017h,004h,019h,040h,060h,061h,043h,02fh,06eh	; a53c  ...`px{...@`aC/n
	defb 060h,005h,000h,09bh,080h,040h,0a0h,0c0h,0c0h,020h,060h,0a0h,080h,000h,080h,07ch	; a54c  `....@... `....|
	defb 0fch,09eh,0deh,09fh,0bdh,0fbh,07fh,0feh,0ffh,0bfh,0beh,0fdh,0f3h,0b3h,0bfh,004h	; a55c  ................
	defb 000h,088h,080h,0c0h,0c0h,060h,020h,020h,0c0h,0d0h,004h,0f0h,000h	; a56c  .....`  .....

; ----------------------------------------------------------------------
; DATOS rle_A579: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (60
;   bytes)
;   0xa579..0xa5b5  (60 bytes)
DATA_rle_A579:
	defb 003h,000h,08dh,060h,070h,078h,079h,013h,006h,04ch,068h,060h,044h,02fh,06fh,06ch	; a579  ...`pxy..Lh`D/ol
	defb 006h,000h,09ah,080h,0c0h,000h,0e0h,040h,010h,0c0h,0e0h,088h,048h,000h,07ch,0feh	; a589  .......@....H.|.
	defb 09eh,0dfh,09fh,0beh,0fdh,0ffh,0ffh,0bfh,0bfh,0fbh,0f0h,0b1h,0bfh,005h,000h,08bh	; a599  ................
	defb 080h,0c0h,0e0h,0e0h,010h,0b8h,0f8h,038h,0f8h,0fch,0fch,000h	; a5a9  .......8....

; ----------------------------------------------------------------------
; DATOS rle_A5B5: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (65
;   bytes)
;   0xa5b5..0xa5f6  (65 bytes)
DATA_rle_A5B5:
	defb 088h,040h,042h,044h,006h,00eh,00ch,010h,000h,003h,018h,08fh,010h,038h,078h,000h	; a5b5  .@BD.........8x.
	defb 000h,040h,040h,000h,070h,070h,030h,020h,008h,018h,00ch,003h,006h,08ah,00eh,000h	; a5c5  .@@.pp0 ........
	defb 000h,0a1h,0e3h,0e7h,0e9h,0d1h,0b2h,02ch,004h,03ch,081h,038h,003h,0fch,081h,000h	; a5d5  .......,.<.8....
	defb 003h,0fch,002h,088h,085h,0c8h,058h,07ch,03eh,01fh,003h,00fh,002h,01fh,081h,000h	; a5e5  ......X|>.......
	defb 000h	; a5f5

; ----------------------------------------------------------------------
; DATOS rle_A5F6: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (57
;   bytes)
;   0xa5f6..0xa62f  (57 bytes)
DATA_rle_A5F6:
	defb 08ah,060h,040h,043h,043h,04bh,01bh,01bh,008h,007h,003h,003h,001h,084h,003h,000h	; a5f6  .`@CCK..........
	defb 000h,080h,009h,000h,002h,0a0h,002h,0c0h,002h,000h,002h,0bfh,088h,0bch,0ech,0f4h	; a606  ................
	defb 0e4h,0e4h,0b7h,01fh,007h,003h,003h,002h,007h,081h,000h,003h,0e0h,005h,080h,081h	; a616  ................
	defb 0c0h,003h,0f0h,002h,0e0h,082h,0c0h,000h,000h	; a626  .........

; ----------------------------------------------------------------------
; DATOS rle_A62F: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (66
;   bytes)
;   0xa62f..0xa671  (66 bytes)
DATA_rle_A62F:
	defb 088h,061h,043h,047h,04eh,05ch,000h,000h,030h,003h,038h,0a1h,030h,070h,0f0h,000h	; a62f  .aCGN\..0.8.0p..
	defb 000h,0b8h,0c0h,080h,000h,060h,060h,000h,010h,038h,018h,00ch,006h,00ch,01ch,000h	; a63f  .....``..8......
	defb 000h,0beh,0b4h,0a8h,0f1h,0e3h,0fch,0f8h,0f8h,07ch,07ch,078h,078h,003h,0f8h,091h	; a64f  .........||xx...
	defb 000h,07ch,03ch,07ch,0f0h,090h,090h,0f0h,0f8h,07ch,03eh,01eh,00eh,01eh,03eh,07eh	; a65f  .|<|.....|>...>~
	defb 000h,000h	; a66f

; ----------------------------------------------------------------------
; DATOS rle_sin_usar_A671: rle que no lee nadie (su direccion no aparece como
;   palabra en el cartucho) y que cierra clavado en el hueco; lo leen nadie
;   (60 bytes)
;   0xa671..0xa6ad  (60 bytes)
DATA_rle_sin_usar_A671:
	defb 003h,000h,08dh,060h,070h,078h,079h,013h,006h,02ch,018h,010h,004h,00fh,00fh,00ch	; a671  ...`pxy..,......
	defb 006h,000h,09ah,080h,0c0h,000h,0e0h,040h,010h,0c0h,0e0h,088h,048h,000h,07ch,0feh	; a681  .......@....H.|.
	defb 09eh,0dfh,09fh,0beh,0fdh,03fh,05fh,03fh,03fh,03bh,010h,011h,01fh,005h,000h,08bh	; a691  .....?_??;......
	defb 080h,0c0h,0e0h,0e0h,010h,0b8h,0f8h,038h,0f8h,0fch,0fch,000h	; a6a1  .......8....

; ----------------------------------------------------------------------
; DATOS rle_A6AD: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (55
;   bytes)
;   0xa6ad..0xa6e4  (55 bytes)
DATA_rle_A6AD:
	defb 088h,000h,006h,00eh,00fh,01eh,01dh,018h,000h,003h,038h,002h,018h,083h,01ch,038h	; a6ad  ..........8....8
	defb 070h,003h,000h,085h,086h,0ceh,03ah,042h,006h,008h,000h,088h,007h,009h,011h,010h	; a6bd  p.....:B........
	defb 021h,022h,025h,038h,003h,07ch,002h,03ch,08bh,03eh,07eh,0f8h,0fch,0fch,0feh,07fh	; a6cd  !"%8.|.<.>~.....
	defb 03fh,0ffh,0ffh,0dfh,008h,000h,000h	; a6dd

; ----------------------------------------------------------------------
; DATOS rle_sin_usar_A6E4: rle que no lee nadie (su direccion no aparece como
;   palabra en el cartucho) y que cierra clavado en el hueco; lo leen nadie
;   (60 bytes)
;   0xa6e4..0xa720  (60 bytes)
DATA_rle_sin_usar_A6E4:
	defb 002h,000h,08dh,060h,070h,078h,07bh,017h,004h,059h,030h,020h,001h,013h,03fh,03eh	; a6e4  ...`px{..Y0 ..?>
	defb 006h,000h,09bh,080h,040h,0a0h,0c0h,0c0h,020h,060h,0a0h,080h,000h,080h,07ch,0fch	; a6f4  ....@... `....|.
	defb 09eh,0deh,09fh,0bdh,0fbh,07fh,0feh,07fh,03fh,03eh,02dh,043h,043h,03fh,004h,000h	; a704  ........?>-CC?..
	defb 088h,080h,0c0h,0c0h,060h,020h,020h,0c0h,0d0h,004h,0f0h,000h	; a714  ....`  .....

; ----------------------------------------------------------------------
; DATOS rle_A720: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (57
;   bytes)
;   0xa720..0xa759  (57 bytes)
DATA_rle_A720:
	defb 002h,010h,002h,003h,086h,00bh,01bh,01bh,008h,007h,003h,003h,001h,084h,003h,000h	; a720  ................
	defb 000h,080h,009h,000h,002h,0a0h,002h,0c0h,002h,000h,002h,01fh,088h,01ch,00ch,014h	; a730  ................
	defb 024h,024h,037h,01fh,007h,003h,003h,002h,007h,081h,000h,003h,0e0h,005h,080h,081h	; a740  $$7.............
	defb 0c0h,003h,0f0h,002h,0e0h,082h,0c0h,000h,000h	; a750  .........

; ----------------------------------------------------------------------
; DATOS rle_sin_usar_A759: rle que no lee nadie (su direccion no aparece como
;   palabra en el cartucho) y que cierra clavado en el hueco; lo leen nadie
;   (60 bytes)
;   0xa759..0xa795  (60 bytes)
DATA_rle_sin_usar_A759:
	defb 003h,000h,08dh,060h,070h,078h,079h,013h,006h,02ch,018h,010h,004h,00fh,00fh,00ch	; a759  ...`pxy..,......
	defb 006h,000h,09ah,080h,0c0h,000h,0e0h,040h,010h,0c0h,0e0h,088h,048h,000h,07ch,0feh	; a769  .......@....H.|.
	defb 09eh,0dfh,09fh,0beh,0fdh,03fh,05fh,03fh,03fh,03bh,010h,011h,01fh,005h,000h,08bh	; a779  .....?_??;......
	defb 080h,0c0h,0e0h,0e0h,010h,0b8h,0f8h,038h,0f8h,0fch,0fch,000h	; a789  .......8....

; ----------------------------------------------------------------------
; DATOS rle_A795: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (50
;   bytes)
;   0xa795..0xa7c7  (50 bytes)
DATA_rle_A795:
	defb 088h,000h,07eh,003h,038h,018h,00ch,01eh,03eh,00ch,000h,086h,030h,070h,070h,060h	; a795  ..~.8...>...0pp`
	defb 010h,038h,003h,018h,08bh,01ch,038h,070h,07fh,081h,0fch,07fh,03ch,01eh,02fh,05fh	; a7a5  .8....8p....<./_
	defb 008h,000h,004h,0fch,084h,0c8h,088h,088h,0f8h,003h,07ch,002h,03ch,083h,03eh,05eh	; a7b5  ..........|.<.>^
	defb 0b8h,000h	; a7c5

; ----------------------------------------------------------------------
; DATOS rle_A7C7: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (55
;   bytes)
;   0xa7c7..0xa7fe  (55 bytes)
DATA_rle_A7C7:
	defb 088h,060h,046h,04eh,04fh,05eh,01dh,018h,000h,003h,038h,002h,018h,083h,01ch,038h	; a7c7  .`FNO^....8....8
	defb 070h,003h,000h,085h,086h,0ceh,03ah,042h,006h,008h,000h,088h,0b7h,0b9h,0b1h,0f0h	; a7d7  p.....:B........
	defb 0e1h,0e2h,0e5h,0b8h,003h,07ch,002h,03ch,08bh,03eh,07eh,0f8h,0fch,0fch,0feh,07fh	; a7e7  .....|.<.>~.....
	defb 03fh,0ffh,0ffh,0dfh,008h,000h,000h	; a7f7

; ----------------------------------------------------------------------
; DATOS rle_A7FE: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (57
;   bytes)
;   0xa7fe..0xa837  (57 bytes)
DATA_rle_A7FE:
	defb 08ah,060h,040h,043h,043h,04bh,01bh,01bh,008h,007h,003h,003h,001h,084h,003h,000h	; a7fe  .`@CCK..........
	defb 000h,080h,009h,000h,002h,0a0h,002h,0c0h,002h,000h,002h,0bfh,088h,0bch,0ech,0f4h	; a80e  ................
	defb 0e4h,0e4h,0b7h,01fh,007h,003h,003h,002h,007h,081h,000h,003h,0e0h,005h,080h,081h	; a81e  ................
	defb 0c0h,003h,0f0h,002h,0e0h,082h,0c0h,000h,000h	; a82e  .........

; ----------------------------------------------------------------------
; DATOS rle_A837: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (50
;   bytes)
;   0xa837..0xa869  (50 bytes)
DATA_rle_A837:
	defb 088h,060h,04eh,043h,058h,058h,00ch,01eh,03eh,00ch,000h,086h,030h,070h,070h,060h	; a837  .`NCXX..>...0pp`
	defb 010h,038h,003h,018h,08bh,01ch,038h,070h,0bfh,0b1h,0bch,0ffh,0fch,0feh,0efh,0dfh	; a847  .8....8p........
	defb 008h,000h,004h,0fch,084h,0c8h,088h,088h,0f8h,003h,07ch,002h,03ch,083h,03eh,05eh	; a857  ..........|.<.>^
	defb 0b8h,000h	; a867

; ----------------------------------------------------------------------
; DATOS rle_A869: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (44
;   bytes)
;   0xa869..0xa895  (44 bytes)
DATA_rle_A869:
	defb 088h,000h,06ch,074h,071h,033h,01ah,03bh,07ch,00bh,000h,085h,086h,0ceh,03ah,042h	; a869  ..ltq3.;|.....:B
	defb 006h,008h,000h,089h,07fh,0f3h,0fbh,0feh,07ch,03dh,07ch,0ffh,0feh,007h,000h,002h	; a879  ........|=|.....
	defb 0fch,087h,0feh,07fh,03fh,0ffh,0ffh,0dfh,01fh,007h,000h,000h	; a889  ....?.......

; ----------------------------------------------------------------------
; DATOS rle_A895: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (44
;   bytes)
;   0xa895..0xa8c1  (44 bytes)
DATA_rle_A895:
	defb 088h,040h,04ch,054h,011h,033h,01ah,03bh,07ch,00bh,000h,085h,086h,0ceh,03ah,042h	; a895  .@LT.3.;|.....:B
	defb 006h,008h,000h,089h,0bfh,0f3h,0fbh,0feh,0fch,0bdh,07ch,0ffh,0feh,007h,000h,002h	; a8a5  ..........|.....
	defb 0fch,087h,0feh,07fh,03fh,0ffh,0ffh,0dfh,01fh,007h,000h,000h	; a8b5  ....?.......

; ----------------------------------------------------------------------
; DATOS rle_A8C1: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (51
;   bytes)
;   0xa8c1..0xa8f4  (51 bytes)
DATA_rle_A8C1:
	defb 006h,000h,089h,003h,007h,003h,015h,006h,007h,007h,036h,030h,008h,000h,089h,080h	; a8c1  ..........60....
	defb 0f8h,0f8h,000h,000h,004h,004h,008h,0f0h,003h,000h,082h,02ch,07ch,004h,0ffh,087h	; a8d1  ...........,|...
	defb 0efh,01dh,008h,038h,079h,07fh,03fh,006h,000h,082h,080h,0f8h,004h,0fch,002h,0fah	; a8e1  ...8y.?.........
	defb 002h,0fch,000h	; a8f1

; ----------------------------------------------------------------------
; DATOS rle_A8F4: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (55
;   bytes)
;   0xa8f4..0xa92b  (55 bytes)
DATA_rle_A8F4:
	defb 088h,000h,006h,00eh,00fh,01eh,01dh,018h,000h,003h,038h,002h,018h,083h,01ch,038h	; a8f4  ..........8....8
	defb 070h,003h,000h,085h,086h,0ceh,03ah,042h,006h,008h,000h,088h,007h,009h,011h,010h	; a904  p.....:B........
	defb 021h,022h,025h,038h,003h,07ch,002h,03ch,08bh,03eh,07eh,0f8h,0fch,0fch,0feh,07fh	; a914  !"%8.|.<.>~.....
	defb 03fh,0ffh,0ffh,0dfh,008h,000h,000h	; a924

; ----------------------------------------------------------------------
; DATOS rle_A92B: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (22
;   bytes)
;   0xa92b..0xa941  (22 bytes)
DATA_rle_A92B:
	defb 00eh,000h,082h,003h,007h,00fh,000h,081h,080h,00bh,000h,082h,02ch,07ch,003h,0ffh	; a92b  ............,|..
	defb 00eh,000h,082h,080h,0f8h,000h	; a93b

; ----------------------------------------------------------------------
; DATOS rle_A941: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (63
;   bytes)
;   0xa941..0xa980  (63 bytes)
DATA_rle_A941:
	defb 098h,003h,015h,006h,007h,007h,036h,030h,000h,000h,07ch,07ch,071h,033h,01ah,03bh	; a941  ......60..||q3.;
	defb 07ch,0f8h,0f8h,000h,000h,004h,004h,008h,0f0h,003h,000h,095h,086h,0ceh,03ah,042h	; a951  |.............:B
	defb 006h,0ffh,0efh,01dh,008h,038h,079h,07fh,03fh,07fh,0f3h,0f3h,0feh,07ch,03dh,07ch	; a961  .....8y.?....|=|
	defb 0ffh,004h,0fch,002h,0fah,004h,0fch,086h,0feh,07fh,03fh,0ffh,0ffh,0dfh,000h	; a971  ..........?....

; ----------------------------------------------------------------------
; DATOS rle_A980: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (49
;   bytes)
;   0xa980..0xa9b1  (49 bytes)
DATA_rle_A980:
	defb 00bh,000h,084h,002h,007h,007h,006h,006h,000h,08bh,003h,00ch,020h,0e0h,0c0h,0c0h	; a980  ............ ...
	defb 05ch,05bh,007h,076h,060h,008h,000h,090h,001h,00fh,03fh,03dh,078h,07fh,0ffh,0feh	; a990  \[.v`.....?=x...
	defb 000h,001h,001h,000h,003h,00fh,03fh,0dfh,003h,0ffh,085h,0e3h,0e7h,0ffh,08fh,01fh	; a9a0  ......?.........
	defb 000h	; a9b0

; ----------------------------------------------------------------------
; DATOS rle_A9B1: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (49
;   bytes)
;   0xa9b1..0xa9e2  (49 bytes)
DATA_rle_A9B1:
	defb 002h,000h,08dh,080h,000h,020h,010h,008h,000h,018h,03ch,05eh,06eh,067h,05bh,07ch	; a9b1  ..... ....<^ng[|
	defb 00ch,000h,095h,0ech,07ch,06eh,00eh,0c6h,000h,080h,0c0h,0e0h,0f0h,0f8h,0fch,0fch	; a9c1  ....|n..........
	defb 0e4h,0c2h,0a1h,091h,098h,0bch,09fh,0ffh,00ah,000h,083h,0fch,0feh,0feh,003h,0ffh	; a9d1  ................
	defb 000h	; a9e1

; ----------------------------------------------------------------------
; DATOS rle_A9E2: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (93
;   bytes)
;   0xa9e2..0xaa3f  (93 bytes)
DATA_rle_A9E2:
	defb 003h,000h,081h,018h,003h,01ch,089h,040h,003h,0beh,03ch,001h,000h,002h,0f2h,0f8h	; a9e2  .......@..<.....
	defb 008h,000h,085h,086h,047h,0c2h,0cch,05ch,004h,000h,08bh,01eh,03fh,037h,023h,027h	; a9f2  ....G..\....?7#'
	defb 07fh,0ffh,0ffh,07fh,0ffh,0feh,004h,0ffh,003h,000h,003h,080h,088h,000h,086h,0c9h	; aa02  ................
	defb 0e8h,03dh,03eh,0beh,07ch,00bh,000h,081h,07eh,005h,002h,081h,004h,018h,000h,083h	; aa12  .=>.|...~.......
	defb 0feh,0ffh,0fdh,004h,005h,081h,00ah,010h,000h,004h,008h,084h,00ch,006h,003h,07eh	; aa22  ...............~
	defb 018h,000h,004h,014h,085h,012h,009h,0fch,081h,07eh,017h,000h,000h	; aa32  .........~...

; ----------------------------------------------------------------------
; DATOS rle_AA3F: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (72
;   bytes)
;   0xaa3f..0xaa87  (72 bytes)
DATA_rle_AA3F:
	defb 003h,000h,002h,060h,08bh,07bh,078h,01ch,01eh,06eh,04fh,084h,080h,074h,0f4h,080h	; aa3f  ...`.{x..nO..t..
	defb 006h,000h,082h,070h,00fh,009h,000h,08bh,078h,0fch,0feh,09fh,09ch,0b7h,0f3h,071h	; aa4f  ...p....x......q
	defb 0f1h,0f1h,0fbh,004h,0feh,005h,000h,086h,0f0h,08fh,070h,00fh,080h,080h,005h,000h	; aa5f  ..........p.....
	defb 088h,080h,040h,020h,018h,004h,004h,002h,002h,018h,000h,089h,040h,0a0h,058h,024h	; aa6f  ..@ ........@.X$
	defb 01ah,00ah,005h,005h,002h,017h,000h,000h	; aa7f  ........

; ----------------------------------------------------------------------
; DATOS rle_AA87: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (103
;   bytes)
;   0xaa87..0xaaee  (103 bytes)
DATA_rle_AA87:
	defb 004h,000h,08ah,008h,00ch,000h,007h,000h,01ch,03ch,0b8h,0a2h,0c0h,009h,000h,08fh	; aa87  .........<......
	defb 0fch,0f8h,006h,002h,00bh,00ah,000h,074h,0c4h,000h,000h,00fh,01fh,017h,01bh,003h	; aa97  .......t........
	defb 01fh,094h,023h,0c3h,0c7h,0dbh,0f3h,0c1h,001h,000h,000h,080h,0c0h,0e0h,0c0h,0fch	; aaa7  ..#.............
	defb 0feh,0ffh,0fdh,0fdh,0feh,0ffh,003h,0feh,019h,000h,002h,080h,083h,040h,030h,00fh	; aab7  .............@0.
	defb 00bh,000h,002h,001h,00dh,000h,087h,080h,040h,040h,0b0h,04fh,030h,00fh,00fh,000h	; aac7  ........@@.O0...
	defb 081h,0ffh,00dh,000h,083h,005h,00bh,0cch,00eh,000h,083h,0ffh,000h,0ffh,00bh,000h	; aad7  ................
	defb 085h,005h,01bh,0f7h,0f3h,0feh,000h	; aae7

; ----------------------------------------------------------------------
; DATOS rle_AAEE: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (114
;   bytes)
;   0xaaee..0xab60  (114 bytes)
DATA_rle_AAEE:
	defb 003h,000h,081h,018h,003h,01ch,089h,040h,003h,0beh,03ch,001h,000h,002h,0f2h,0f8h	; aaee  .......@..<.....
	defb 008h,000h,085h,086h,047h,0c2h,0cch,05ch,004h,000h,08bh,01eh,03fh,037h,023h,027h	; aafe  ....G..\....?7#'
	defb 07fh,0ffh,0ffh,07fh,0ffh,0feh,004h,0ffh,003h,000h,003h,080h,088h,000h,086h,0c9h	; ab0e  ................
	defb 0e8h,03dh,03eh,0beh,07ch,00bh,000h,087h,07eh,000h,002h,000h,002h,000h,004h,018h	; ab1e  .=>.|...~.......
	defb 000h,088h,0feh,0ffh,0ffh,005h,007h,005h,007h,00ah,011h,000h,08fh,010h,000h,010h	; ab2e  ................
	defb 000h,010h,000h,008h,000h,008h,000h,008h,004h,000h,002h,0a8h,010h,000h,090h,01ch	; ab3e  ................
	defb 028h,038h,028h,038h,028h,038h,014h,01ch,014h,01ch,014h,01ah,00fh,0fdh,057h,010h	; ab4e  (8(8(8........W.
	defb 000h,000h	; ab5e

; ----------------------------------------------------------------------
; DATOS rle_AB60: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (84
;   bytes)
;   0xab60..0xabb4  (84 bytes)
DATA_rle_AB60:
	defb 003h,000h,002h,060h,08bh,07bh,078h,01ch,01eh,06eh,04fh,084h,080h,074h,0f4h,080h	; ab60  ...`.{x..nO..t..
	defb 006h,000h,082h,050h,005h,009h,000h,08bh,078h,0fch,0feh,09fh,09ch,0b7h,0f3h,071h	; ab70  ...P....x......q
	defb 0f1h,0f1h,0fbh,004h,0feh,005h,000h,086h,0f0h,0afh,07ah,00fh,080h,080h,005h,000h	; ab80  ..........z.....
	defb 08eh,080h,000h,020h,008h,000h,004h,000h,002h,000h,002h,000h,004h,010h,020h,012h	; ab90  ... .......... .
	defb 000h,08fh,040h,0e0h,058h,034h,01eh,00ah,007h,005h,007h,005h,00eh,01ah,02ch,058h	; aba0  ..@.X4........,X
	defb 060h,011h,000h,000h	; abb0

; ----------------------------------------------------------------------
; DATOS rle_ABB4: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (109
;   bytes)
;   0xabb4..0xac21  (109 bytes)
DATA_rle_ABB4:
	defb 004h,000h,08ah,008h,00ch,000h,007h,000h,01ch,03ch,0b8h,0a2h,0c0h,009h,000h,08fh	; abb4  .........<......
	defb 0fch,0f8h,006h,002h,00bh,00ah,000h,074h,0c4h,000h,000h,00fh,01fh,017h,01bh,003h	; abc4  .......t........
	defb 01fh,094h,023h,0c3h,0c7h,0dbh,0f3h,0c1h,001h,000h,000h,080h,0c0h,0e0h,0c0h,0fch	; abd4  ..#.............
	defb 0feh,0ffh,0fdh,0fdh,0feh,0ffh,003h,0feh,009h,000h,085h,080h,000h,040h,010h,005h	; abe4  .............@..
	defb 010h,000h,081h,055h,009h,000h,087h,080h,040h,0c0h,0b0h,06fh,03ah,00fh,00eh,000h	; abf4  ...U....@..o:...
	defb 083h,0ffh,0aah,0ffh,00eh,000h,081h,055h,00dh,000h,083h,005h,00bh,04ch,00eh,000h	; ac04  .......U.....L..
	defb 083h,0ffh,0aah,0ffh,00bh,000h,085h,005h,01bh,0f7h,0f3h,0feh,000h	; ac14  .............

; ----------------------------------------------------------------------
; DATOS rle_AC21: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (43
;   bytes)
;   0xac21..0xac4c  (43 bytes)
DATA_rle_AC21:
	defb 003h,000h,002h,060h,08bh,07bh,078h,01ch,01eh,06eh,04fh,084h,080h,074h,0f4h,080h	; ac21  ...`.{x..nO..t..
	defb 011h,000h,08bh,078h,0fch,0feh,09fh,09ch,0b7h,0f3h,071h,0f1h,0f1h,0fbh,004h,0feh	; ac31  ...x......q.....
	defb 005h,000h,002h,080h,002h,000h,002h,080h,005h,000h,000h	; ac41  ...........

; ----------------------------------------------------------------------
; DATOS rle_AC4C: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (71
;   bytes)
;   0xac4c..0xac93  (71 bytes)
DATA_rle_AC4C:
	defb 004h,000h,08ah,008h,00ch,000h,007h,000h,01ch,03ch,0b8h,0a2h,0c0h,009h,000h,08fh	; ac4c  .........<......
	defb 0fch,0f8h,006h,002h,00bh,00ah,000h,074h,0c4h,000h,000h,00fh,01fh,017h,01bh,003h	; ac5c  .......t........
	defb 01fh,094h,023h,0c3h,0c7h,0dbh,0f3h,0c1h,001h,000h,000h,080h,0c0h,0e0h,0c0h,0fch	; ac6c  ..#.............
	defb 0feh,0ffh,0fdh,0fdh,0feh,0ffh,003h,0feh,01ch,000h,083h,005h,00bh,00ch,01ch,000h	; ac7c  ................
	defb 085h,005h,00bh,017h,013h,00eh,000h	; ac8c

; ----------------------------------------------------------------------
; DATOS rle_AC93: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (62
;   bytes)
;   0xac93..0xacd1  (62 bytes)
DATA_rle_AC93:
	defb 006h,000h,08ah,01eh,00fh,00fh,066h,040h,000h,000h,002h,010h,00ah,003h,000h,0adh	; ac93  ......f@........
	defb 030h,070h,070h,030h,0c0h,0e0h,000h,060h,066h,056h,034h,000h,080h,000h,000h,001h	; aca3  0pp0...`fV4.....
	defb 003h,003h,01fh,03fh,03fh,07fh,09fh,0bfh,0ffh,03fh,03fh,01fh,01fh,000h,0f0h,0f8h	; acb3  ...??....??.....
	defb 0c8h,0d8h,0c8h,0e8h,0b8h,0c0h,0f0h,09eh,099h,0b9h,0fah,0fch,0c0h,000h	; acc3  ..............

; ----------------------------------------------------------------------
; DATOS rle_ACD1: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (65
;   bytes)
;   0xacd1..0xad12  (65 bytes)
DATA_rle_ACD1:
	defb 002h,002h,088h,000h,00eh,00eh,00ch,004h,010h,018h,030h,003h,060h,081h,070h,003h	; acd1  ..........0.`.p.
	defb 000h,087h,040h,020h,060h,070h,030h,008h,000h,003h,018h,085h,008h,01ch,01eh,000h	; ace1  ..@ `p0.........
	defb 000h,003h,03fh,002h,011h,085h,013h,01ah,03eh,07ch,0f8h,003h,0f0h,002h,0f8h,088h	; acf1  ..?.....>|......
	defb 000h,080h,0c0h,0e0h,090h,088h,04ch,034h,004h,03ch,081h,01ch,003h,03fh,081h,000h	; ad01  ......L4.<...?..
	defb 000h	; ad11

; ----------------------------------------------------------------------
; DATOS rle_AD12: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (60
;   bytes)
;   0xad12..0xad4e  (60 bytes)
DATA_rle_AD12:
	defb 005h,000h,09ah,001h,002h,005h,003h,003h,004h,006h,005h,001h,000h,001h,000h,000h	; ad12  ................
	defb 006h,00eh,01eh,0deh,0e8h,020h,09ah,00ch,004h,080h,0c8h,0fch,07ch,005h,000h,088h	; ad22  ..... ......|...
	defb 001h,003h,003h,006h,004h,004h,003h,00bh,004h,00fh,090h,03eh,03fh,079h,07bh,0f9h	; ad32  ...........>?y{.
	defb 0bdh,0dfh,0feh,07fh,0feh,0fch,07ch,0b4h,0c2h,0c2h,0fch,000h	; ad42  ......|.....

; ----------------------------------------------------------------------
; DATOS rle_AD4E: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (57
;   bytes)
;   0xad4e..0xad87  (57 bytes)
DATA_rle_AD4E:
	defb 081h,001h,009h,000h,002h,005h,002h,003h,002h,000h,002h,008h,002h,0c0h,086h,0d0h	; ad4e  ................
	defb 0d8h,0d8h,010h,0e0h,0c0h,003h,080h,083h,0c0h,000h,000h,003h,007h,005h,001h,081h	; ad5e  ................
	defb 003h,003h,00fh,002h,007h,08ch,003h,000h,0f8h,0f8h,038h,030h,028h,024h,024h,0ech	; ad6e  ..........80($$.
	defb 0f8h,0e0h,003h,0c0h,002h,0e0h,081h,000h,000h	; ad7e  .........

; ----------------------------------------------------------------------
; DATOS rle_AD87: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (60
;   bytes)
;   0xad87..0xadc3  (60 bytes)
DATA_rle_AD87:
	defb 006h,000h,08ah,001h,003h,000h,007h,002h,008h,003h,007h,011h,012h,003h,000h,08dh	; ad87  ................
	defb 006h,00eh,01eh,09eh,0c8h,060h,034h,018h,008h,020h,0f0h,0f0h,030h,005h,000h,09bh	; ad97  .....`4.. ..0...
	defb 001h,003h,007h,007h,008h,01dh,01fh,01ch,01fh,03fh,03fh,000h,03eh,07fh,079h,0fbh	; ada7  .........??.>.y.
	defb 0f9h,07dh,0bfh,0fch,0fah,0fch,0fch,0dch,008h,088h,0f8h,000h	; adb7  .}..........

; ----------------------------------------------------------------------
; DATOS rle_ADC3: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (66
;   bytes)
;   0xadc3..0xae05  (66 bytes)
DATA_rle_ADC3:
	defb 098h,01dh,003h,001h,000h,006h,006h,000h,008h,01ch,018h,030h,060h,030h,038h,000h	; adc3  ...........0`08.
	defb 000h,080h,0c0h,0e0h,070h,038h,000h,000h,00ch,003h,01ch,0a1h,00ch,00eh,00fh,000h	; add3  ....p8..........
	defb 000h,03eh,03ch,03eh,00fh,009h,009h,00fh,01fh,03eh,07ch,078h,070h,078h,07ch,07eh	; ade3  .><>.....>|xpx|~
	defb 000h,070h,020h,010h,08ch,0c6h,03eh,01eh,01eh,03eh,03eh,01eh,01eh,003h,01fh,081h	; adf3  .p ...>..>>.....
	defb 000h,000h	; ae03

; ----------------------------------------------------------------------
; DATOS rle_AE05: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (62
;   bytes)
;   0xae05..0xae43  (62 bytes)
DATA_rle_AE05:
	defb 006h,000h,08ah,01eh,00fh,00fh,066h,040h,000h,000h,002h,010h,00ah,003h,000h,0adh	; ae05  ......f@........
	defb 030h,070h,070h,030h,0c2h,0e6h,006h,062h,064h,056h,036h,006h,082h,000h,000h,001h	; ae15  0pp0...bdV6.....
	defb 003h,003h,01fh,03fh,03fh,07fh,09fh,0bfh,0ffh,03fh,03fh,01fh,01fh,000h,0f0h,0f8h	; ae25  ...??....??.....
	defb 0c8h,0d8h,0c8h,0ebh,0bfh,0cdh,0fdh,09fh,09fh,0bdh,0fdh,0fdh,0cdh,000h	; ae35  ..............

; ----------------------------------------------------------------------
; DATOS rle_AE43: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (61
;   bytes)
;   0xae43..0xae80  (61 bytes)
DATA_rle_AE43:
	defb 005h,000h,09bh,001h,002h,005h,003h,003h,004h,006h,005h,001h,000h,001h,000h,000h	; ae43  ................
	defb 006h,00eh,01eh,0deh,0e8h,020h,098h,002h,006h,086h,0c2h,0f4h,076h,006h,004h,000h	; ae53  ..... ......v...
	defb 088h,001h,003h,003h,006h,004h,004h,003h,00bh,004h,00fh,090h,03eh,03fh,079h,07bh	; ae63  ............>?y{
	defb 0f9h,0bdh,0dfh,0feh,07fh,0ffh,0fdh,07dh,0bfh,0cfh,0cdh,0fdh,000h	; ae73  .......}.....

; ----------------------------------------------------------------------
; DATOS rle_AE80: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (60
;   bytes)
;   0xae80..0xaebc  (60 bytes)
DATA_rle_AE80:
	defb 006h,000h,08ah,001h,003h,000h,007h,002h,008h,003h,007h,011h,012h,003h,000h,08dh	; ae80  ................
	defb 006h,00eh,01eh,09eh,0c8h,060h,032h,016h,006h,022h,0f4h,0f6h,036h,005h,000h,09bh	; ae90  .....`2.."..6...
	defb 001h,003h,007h,007h,008h,01dh,01fh,01ch,01fh,03fh,03fh,000h,03eh,07fh,079h,0fbh	; aea0  .........??.>.y.
	defb 0f9h,07dh,0bfh,0ffh,0ffh,0fdh,0fdh,0dfh,00fh,08dh,0fdh,000h	; aeb0  .}..........

; ----------------------------------------------------------------------
; DATOS rle_AEBC: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (65
;   bytes)
;   0xaebc..0xaefd  (65 bytes)
DATA_rle_AEBC:
	defb 002h,002h,088h,000h,00eh,00eh,00ch,004h,010h,018h,030h,003h,060h,08bh,070h,000h	; aebc  ..........0.`.p.
	defb 000h,002h,042h,022h,060h,070h,030h,008h,000h,003h,018h,085h,008h,01ch,01eh,000h	; aecc  ..B"`p0.........
	defb 000h,003h,03fh,002h,011h,085h,013h,01ah,03eh,07ch,0f8h,003h,0f0h,002h,0f8h,088h	; aedc  ..?.....>|......
	defb 000h,085h,0c7h,0e7h,097h,08bh,04dh,034h,004h,03ch,081h,01ch,003h,03fh,081h,000h	; aeec  ......M4.<...?..
	defb 000h	; aefc

; ----------------------------------------------------------------------
; DATOS rle_AEFD: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (57
;   bytes)
;   0xaefd..0xaf36  (57 bytes)
DATA_rle_AEFD:
	defb 081h,001h,009h,000h,002h,005h,002h,003h,002h,000h,08ah,006h,002h,0c2h,0c2h,0d2h	; aefd  ................
	defb 0d8h,0d8h,010h,0e0h,0c0h,003h,080h,083h,0c0h,000h,000h,003h,007h,005h,001h,081h	; af0d  ................
	defb 003h,003h,00fh,002h,007h,08ch,003h,000h,0fdh,0fdh,03dh,037h,02fh,027h,027h,0edh	; af1d  ..........=7/''.
	defb 0f8h,0e0h,003h,0c0h,002h,0e0h,081h,000h,000h	; af2d  .........

; ----------------------------------------------------------------------
; DATOS rle_AF36: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (66
;   bytes)
;   0xaf36..0xaf78  (66 bytes)
DATA_rle_AF36:
	defb 098h,01dh,003h,001h,000h,006h,006h,000h,008h,01ch,018h,030h,060h,030h,038h,000h	; af36  ...........0`08.
	defb 000h,086h,0c2h,0e2h,072h,03ah,000h,000h,00ch,003h,01ch,0a1h,00ch,00eh,00fh,000h	; af46  ....r:..........
	defb 000h,03eh,03ch,03eh,00fh,009h,009h,00fh,01fh,03eh,07ch,078h,070h,078h,07ch,07eh	; af56  .><>.....>|xpx|~
	defb 000h,07dh,02dh,015h,08fh,0c7h,03fh,01fh,01fh,03eh,03eh,01eh,01eh,003h,01fh,081h	; af66  .}-...?..>>.....
	defb 000h,000h	; af76

; ----------------------------------------------------------------------
; DATOS rle_sin_usar_AF78: rle que no lee nadie (su direccion no aparece como
;   palabra en el cartucho) y que cierra clavado en el hueco; lo leen nadie
;   (60 bytes)
;   0xaf78..0xafb4  (60 bytes)
DATA_rle_sin_usar_AF78:
	defb 006h,000h,08ah,001h,003h,000h,007h,002h,008h,003h,007h,011h,012h,003h,000h,08dh	; af78  ................
	defb 006h,00eh,01eh,09eh,0c8h,060h,034h,018h,008h,020h,0f0h,0f0h,030h,005h,000h,09bh	; af88  .....`4.. ..0...
	defb 001h,003h,007h,007h,008h,01dh,01fh,01ch,01fh,03fh,03fh,000h,03eh,07fh,079h,0fbh	; af98  .........??.>.y.
	defb 0f9h,07dh,0bfh,0fch,0fah,0fch,0fch,0dch,008h,088h,0f8h,000h	; afa8  .}..........

; ----------------------------------------------------------------------
; DATOS rle_AFB4: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (54
;   bytes)
;   0xafb4..0xafea  (54 bytes)
DATA_rle_AFB4:
	defb 003h,000h,085h,061h,073h,05ch,042h,060h,009h,000h,087h,060h,070h,0f0h,078h,0b8h	; afb4  ...as\B`...`p.x.
	defb 018h,000h,003h,01ch,002h,018h,08bh,038h,01ch,00eh,03fh,03fh,07fh,0feh,0fch,0ffh	; afc4  .......8..??....
	defb 0ffh,0fbh,008h,000h,088h,0e0h,090h,088h,008h,084h,044h,0a4h,01ch,003h,03eh,002h	; afd4  ..........D...>.
	defb 03ch,083h,07ch,07eh,01fh,000h	; afe4

; ----------------------------------------------------------------------
; DATOS rle_sin_usar_AFEA: rle que no lee nadie (su direccion no aparece como
;   palabra en el cartucho) y que cierra clavado en el hueco; lo leen nadie
;   (60 bytes)
;   0xafea..0xb026  (60 bytes)
DATA_rle_sin_usar_AFEA:
	defb 005h,000h,09ah,001h,002h,005h,003h,003h,004h,006h,005h,001h,000h,001h,000h,000h	; afea  ................
	defb 006h,00eh,01eh,0deh,0e8h,020h,09ah,00ch,004h,080h,0c8h,0fch,07ch,005h,000h,088h	; affa  ..... ......|...
	defb 001h,003h,003h,006h,004h,004h,003h,00bh,004h,00fh,090h,03eh,03fh,079h,07bh,0f9h	; b00a  ...........>?y{.
	defb 0bdh,0dfh,0feh,07fh,0feh,0fch,07ch,0b4h,0c2h,0c2h,0fch,000h	; b01a  ......|.....

; ----------------------------------------------------------------------
; DATOS rle_B026: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (57
;   bytes)
;   0xb026..0xb05f  (57 bytes)
DATA_rle_B026:
	defb 081h,001h,009h,000h,002h,005h,002h,003h,002h,000h,002h,008h,002h,0c0h,086h,0d0h	; b026  ................
	defb 0d8h,0d8h,010h,0e0h,0c0h,003h,080h,083h,0c0h,000h,000h,003h,007h,005h,001h,081h	; b036  ................
	defb 003h,003h,00fh,002h,007h,08ch,003h,000h,0f8h,0f8h,038h,030h,028h,024h,024h,0ech	; b046  ..........80($$.
	defb 0f8h,0e0h,003h,0c0h,002h,0e0h,081h,000h,000h	; b056  .........

; ----------------------------------------------------------------------
; DATOS rle_sin_usar_B05F: rle que no lee nadie (su direccion no aparece como
;   palabra en el cartucho) y que cierra clavado en el hueco; lo leen nadie
;   (60 bytes)
;   0xb05f..0xb09b  (60 bytes)
DATA_rle_sin_usar_B05F:
	defb 006h,000h,08ah,001h,003h,000h,007h,002h,008h,003h,007h,011h,012h,003h,000h,08dh	; b05f  ................
	defb 006h,00eh,01eh,09eh,0c8h,060h,034h,018h,008h,020h,0f0h,0f0h,030h,005h,000h,09bh	; b06f  .....`4.. ..0...
	defb 001h,003h,007h,007h,008h,01dh,01fh,01ch,01fh,03fh,03fh,000h,03eh,07fh,079h,0fbh	; b07f  .........??.>.y.
	defb 0f9h,07dh,0bfh,0fch,0fah,0fch,0fch,0dch,008h,088h,0f8h,000h	; b08f  .}..........

; ----------------------------------------------------------------------
; DATOS rle_B09B: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (51
;   bytes)
;   0xb09b..0xb0ce  (51 bytes)
DATA_rle_B09B:
	defb 004h,000h,086h,00ch,00eh,00eh,006h,008h,01ch,003h,018h,08bh,038h,01ch,00eh,000h	; b09b  ............8...
	defb 07eh,0c0h,01ch,018h,030h,078h,07ch,008h,000h,004h,03fh,084h,013h,011h,011h,01fh	; b0ab  ~...0x|...?.....
	defb 003h,03eh,002h,03ch,08bh,07ch,07ah,01dh,0feh,081h,03fh,0feh,03ch,078h,0f4h,0fah	; b0bb  .>.<.|z...?.<x..
	defb 008h,000h,000h	; b0cb

; ----------------------------------------------------------------------
; DATOS rle_B0CE: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (55
;   bytes)
;   0xb0ce..0xb105  (55 bytes)
DATA_rle_B0CE:
	defb 003h,000h,085h,061h,073h,05ch,042h,060h,008h,000h,088h,006h,062h,072h,0f2h,07ah	; b0ce  ...as\B`....br.z
	defb 0b8h,018h,000h,003h,01ch,002h,018h,08bh,038h,01ch,00eh,03fh,03fh,07fh,0feh,0fch	; b0de  ........8..??...
	defb 0ffh,0ffh,0fbh,008h,000h,088h,0edh,09dh,08dh,00fh,087h,047h,0a7h,01dh,003h,03eh	; b0ee  ...........G...>
	defb 002h,03ch,083h,07ch,07eh,01fh,000h	; b0fe

; ----------------------------------------------------------------------
; DATOS rle_B105: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (57
;   bytes)
;   0xb105..0xb13e  (57 bytes)
DATA_rle_B105:
	defb 081h,001h,009h,000h,002h,005h,002h,003h,002h,000h,08ah,006h,002h,0c2h,0c2h,0d2h	; b105  ................
	defb 0d8h,0d8h,010h,0e0h,0c0h,003h,080h,083h,0c0h,000h,000h,003h,007h,005h,001h,081h	; b115  ................
	defb 003h,003h,00fh,002h,007h,08ch,003h,000h,0fdh,0fdh,03dh,037h,02fh,027h,027h,0edh	; b125  ..........=7/''.
	defb 0f8h,0e0h,003h,0c0h,002h,0e0h,081h,000h,000h	; b135  .........

; ----------------------------------------------------------------------
; DATOS rle_B13E: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (51
;   bytes)
;   0xb13e..0xb171  (51 bytes)
DATA_rle_B13E:
	defb 004h,000h,086h,00ch,00eh,00eh,006h,008h,01ch,003h,018h,08bh,038h,01ch,00eh,006h	; b13e  ............8...
	defb 072h,0c2h,01ah,01ah,030h,078h,07ch,008h,000h,004h,03fh,084h,013h,011h,011h,01fh	; b14e  r...0x|...?.....
	defb 003h,03eh,002h,03ch,08bh,07ch,07ah,01dh,0fdh,08dh,03dh,0ffh,03fh,07fh,0f7h,0fbh	; b15e  .>.<.|z...=.?...
	defb 008h,000h,000h	; b16e

; ----------------------------------------------------------------------
; DATOS rle_B171: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (45
;   bytes)
;   0xb171..0xb19e  (45 bytes)
DATA_rle_B171:
	defb 003h,000h,085h,061h,073h,05ch,042h,060h,009h,000h,087h,036h,02eh,08eh,0cch,058h	; b171  ...as\B`...6...X
	defb 0dch,03eh,008h,000h,002h,03fh,087h,07fh,0feh,0fch,0ffh,0ffh,0fbh,0f8h,007h,000h	; b181  .>...?..........
	defb 089h,0feh,0cfh,0dfh,07fh,03eh,0bch,03eh,0ffh,07fh,007h,000h,000h	; b191  .....>.>.....

; ----------------------------------------------------------------------
; DATOS rle_B19E: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (46
;   bytes)
;   0xb19e..0xb1cc  (46 bytes)
DATA_rle_B19E:
	defb 003h,000h,085h,061h,073h,05ch,042h,060h,008h,000h,088h,002h,032h,02ah,088h,0cch	; b19e  ...as\B`....2*..
	defb 058h,0dch,03eh,008h,000h,002h,03fh,087h,07fh,0feh,0fch,0ffh,0ffh,0fbh,0f8h,007h	; b1ae  X.>...?.........
	defb 000h,089h,0fdh,0cfh,0dfh,07fh,03fh,0bdh,03eh,0ffh,07fh,007h,000h,000h	; b1be  ......?.>.....

; ----------------------------------------------------------------------
; DATOS rle_B1CC: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (51
;   bytes)
;   0xb1cc..0xb1ff  (51 bytes)
DATA_rle_B1CC:
	defb 007h,000h,089h,001h,01fh,01fh,000h,000h,020h,020h,010h,00fh,006h,000h,089h,0c0h	; b1cc  ........  ......
	defb 0e0h,0c0h,0a8h,060h,0e0h,0e0h,06ch,00ch,007h,000h,082h,001h,01fh,004h,03fh,002h	; b1dc  ...`..l.......?.
	defb 05fh,002h,03fh,003h,000h,082h,034h,03eh,004h,0ffh,087h,0f7h,0b8h,010h,01ch,09eh	; b1ec  _.?...4>........
	defb 0feh,0fch,000h	; b1fc

; ----------------------------------------------------------------------
; DATOS rle_B1FF: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (54
;   bytes)
;   0xb1ff..0xb235  (54 bytes)
DATA_rle_B1FF:
	defb 003h,000h,085h,061h,073h,05ch,042h,060h,009h,000h,087h,060h,070h,0f0h,078h,0b8h	; b1ff  ...as\B`...`p.x.
	defb 018h,000h,003h,01ch,002h,018h,08bh,038h,01ch,00eh,03fh,03fh,07fh,0feh,0fch,0ffh	; b20f  .......8..??....
	defb 0ffh,0fbh,008h,000h,088h,0e0h,090h,088h,008h,084h,044h,0a4h,01ch,003h,03eh,002h	; b21f  ..........D...>.
	defb 03ch,083h,07ch,07eh,01fh,000h	; b22f

; ----------------------------------------------------------------------
; DATOS rle_B235: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (22
;   bytes)
;   0xb235..0xb24b  (22 bytes)
DATA_rle_B235:
	defb 00fh,000h,081h,001h,00eh,000h,082h,0c0h,0e0h,00eh,000h,082h,001h,01fh,00bh,000h	; b235  ................
	defb 082h,034h,03eh,003h,0ffh,000h	; b245

; ----------------------------------------------------------------------
; DATOS rle_B24B: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (63
;   bytes)
;   0xb24b..0xb28a  (63 bytes)
DATA_rle_B24B:
	defb 002h,01fh,002h,000h,002h,020h,082h,010h,00fh,003h,000h,095h,061h,073h,05ch,042h	; b24b  ..... ......as\B
	defb 060h,0c0h,0a8h,060h,0e0h,0e0h,06ch,00ch,000h,000h,03eh,03eh,08eh,0cch,058h,0dch	; b25b  `..`..l...>>..X.
	defb 03eh,004h,03fh,002h,05fh,004h,03fh,096h,07fh,0feh,0fch,0ffh,0ffh,0fbh,0ffh,0f7h	; b26b  >.?._.?.........
	defb 0b8h,010h,01ch,09eh,0feh,0fch,0feh,0cfh,0cfh,07fh,03eh,0bch,03eh,0ffh,000h	; b27b  ..........>.>..

; ----------------------------------------------------------------------
; DATOS rle_B28A: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (50
;   bytes)
;   0xb28a..0xb2bc  (50 bytes)
DATA_rle_B28A:
	defb 005h,000h,08bh,0c0h,030h,004h,007h,003h,003h,03ah,0dah,0e0h,06eh,006h,00bh,000h	; b28a  ....0....:..n...
	defb 08dh,040h,0e0h,0e0h,060h,000h,000h,080h,080h,000h,0c0h,0f0h,0fch,0fbh,003h,0ffh	; b29a  .@..`...........
	defb 085h,0c7h,0e7h,0ffh,0f1h,0f8h,008h,000h,088h,080h,0f0h,0fch,0bch,01eh,0feh,0ffh	; b2aa  ................
	defb 07fh,000h	; b2ba

; ----------------------------------------------------------------------
; DATOS rle_B2BC: rle a la VRAM, de la tabla de 0xA281; lo leen p00:56F4 (49
;   bytes)
;   0xb2bc..0xb2ed  (49 bytes)
DATA_rle_B2BC:
	defb 00bh,000h,094h,037h,03eh,076h,070h,063h,000h,000h,001h,000h,004h,008h,010h,000h	; b2bc  ...7>vpc........
	defb 018h,03ch,07ah,076h,0e6h,0dah,03eh,00bh,000h,083h,03fh,07fh,07fh,003h,0ffh,090h	; b2cc  .<zv..>...?.....
	defb 000h,001h,003h,007h,00fh,01fh,03fh,03fh,027h,043h,085h,089h,019h,03dh,0f9h,0ffh	; b2dc  ......??'C...=..
	defb 000h	; b2ec

; ----------------------------------------------------------------------
; DATOS rle_B2ED: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (93
;   bytes)
;   0xb2ed..0xb34a  (93 bytes)
DATA_rle_B2ED:
	defb 008h,000h,085h,061h,0e2h,043h,033h,03ah,006h,000h,081h,018h,003h,038h,089h,002h	; b2ed  ...a.C3:.....8..
	defb 0c0h,07dh,03ch,080h,000h,040h,04fh,01fh,003h,000h,003h,001h,088h,000h,061h,093h	; b2fd  .}<..@O.......a.
	defb 017h,0bch,07ch,07dh,03eh,003h,000h,08bh,078h,0fch,0ech,0c4h,0e4h,0feh,0ffh,0ffh	; b30d  ..|}>...x.......
	defb 0feh,0ffh,07fh,004h,0ffh,019h,000h,081h,07eh,005h,040h,081h,020h,018h,000h,083h	; b31d  ........~.@. ...
	defb 07fh,0ffh,0bfh,004h,0a0h,081h,050h,010h,000h,004h,010h,084h,030h,060h,0c0h,07eh	; b32d  ......P.....0`.~
	defb 018h,000h,004h,028h,085h,048h,090h,03fh,081h,07eh,007h,000h,000h	; b33d  ...(.H.?.~...

; ----------------------------------------------------------------------
; DATOS rle_B34A: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (72
;   bytes)
;   0xb34a..0xb392  (72 bytes)
DATA_rle_B34A:
	defb 006h,000h,082h,00eh,0f0h,00bh,000h,002h,006h,08bh,0deh,01eh,038h,078h,076h,0f2h	; b34a  ............8xv.
	defb 021h,001h,02eh,02fh,001h,005h,000h,086h,00fh,0f1h,00eh,0f0h,001h,001h,006h,000h	; b35a  !../............
	defb 08bh,01eh,03fh,07fh,0f9h,039h,0edh,0cfh,08eh,08fh,08fh,0dfh,004h,07fh,010h,000h	; b36a  ..?..9..........
	defb 088h,001h,002h,004h,018h,020h,020h,040h,040h,018h,000h,089h,002h,005h,01ah,024h	; b37a  .....  @@......$
	defb 058h,050h,0a0h,0a0h,040h,007h,000h,000h	; b38a  XP..@...

; ----------------------------------------------------------------------
; DATOS rle_B392: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (105
;   bytes)
;   0xb392..0xb3fb  (105 bytes)
DATA_rle_B392:
	defb 007h,000h,089h,03fh,01fh,060h,040h,0d0h,050h,000h,02eh,023h,004h,000h,08ah,010h	; b392  ...?.`@.P..#....
	defb 030h,000h,0e0h,000h,038h,03ch,01dh,045h,003h,004h,000h,08bh,001h,003h,007h,003h	; b3a2  0...8<.E........
	defb 03fh,07fh,0ffh,0bfh,0bfh,07fh,0ffh,003h,07fh,002h,000h,084h,0f0h,0f8h,0e8h,0d8h	; b3b2  ?...............
	defb 003h,0f8h,087h,0c4h,0c3h,0e3h,0dbh,0cfh,083h,080h,009h,000h,002h,001h,083h,002h	; b3c2  ................
	defb 00ch,0f0h,01ah,000h,087h,001h,002h,002h,00dh,0f2h,00ch,0f0h,00ah,000h,002h,080h	; b3d2  ................
	defb 011h,000h,083h,0a0h,0d0h,033h,00fh,000h,081h,0ffh,00ch,000h,085h,0a0h,0d8h,0efh	; b3e2  .....3..........
	defb 0cfh,07fh,00dh,000h,083h,0ffh,000h,0ffh,000h	; b3f2  .........

; ----------------------------------------------------------------------
; DATOS rle_B3FB: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (112
;   bytes)
;   0xb3fb..0xb46b  (112 bytes)
DATA_rle_B3FB:
	defb 008h,000h,085h,061h,0e2h,043h,033h,03ah,006h,000h,081h,018h,003h,038h,089h,002h	; b3fb  ...a.C3:.....8..
	defb 0c0h,07dh,03ch,080h,000h,040h,04fh,01fh,003h,000h,003h,001h,088h,000h,061h,093h	; b40b  .}<..@O.......a.
	defb 017h,0bch,07ch,07dh,03eh,003h,000h,08bh,078h,0fch,0ech,0c4h,0e4h,0feh,0ffh,0ffh	; b41b  ..|}>...x.......
	defb 0feh,0ffh,07fh,004h,0ffh,019h,000h,087h,07eh,000h,040h,000h,040h,000h,020h,018h	; b42b  ........~.@.@. .
	defb 000h,088h,07fh,0ffh,0ffh,0a0h,0e0h,0a0h,0e0h,050h,011h,000h,08fh,008h,000h,008h	; b43b  .........P......
	defb 000h,008h,000h,010h,000h,010h,000h,010h,020h,000h,040h,015h,010h,000h,090h,038h	; b44b  ........ .@....8
	defb 014h,01ch,014h,01ch,014h,01ch,028h,038h,028h,038h,028h,058h,0f0h,0bfh,0eah,000h	; b45b  ......(8(8(X....

; ----------------------------------------------------------------------
; DATOS rle_B46B: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (83
;   bytes)
;   0xb46b..0xb4be  (83 bytes)
DATA_rle_B46B:
	defb 006h,000h,082h,00ah,0a0h,00bh,000h,002h,006h,08bh,0deh,01eh,038h,078h,076h,0f2h	; b46b  ............8xv.
	defb 021h,001h,02eh,02fh,001h,005h,000h,086h,00fh,0f5h,05eh,0f0h,001h,001h,006h,000h	; b47b  !../......^.....
	defb 08bh,01eh,03fh,07fh,0f9h,039h,0edh,0cfh,08eh,08fh,08fh,0dfh,004h,07fh,010h,000h	; b48b  ..?..9..........
	defb 08eh,001h,000h,004h,010h,000h,020h,000h,040h,000h,040h,000h,020h,008h,004h,012h	; b49b  ...... .@.@. ...
	defb 000h,090h,002h,007h,01ah,02ch,078h,050h,0e0h,0a0h,0e0h,0a0h,070h,058h,034h,01ah	; b4ab  .....,xP....pX4.
	defb 006h,000h,000h	; b4bb

; ----------------------------------------------------------------------
; DATOS rle_B4BE: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (111
;   bytes)
;   0xb4be..0xb52d  (111 bytes)
DATA_rle_B4BE:
	defb 007h,000h,089h,03fh,01fh,060h,040h,0d0h,050h,000h,02eh,023h,004h,000h,08ah,010h	; b4be  ...?.`@.P..#....
	defb 030h,000h,0e0h,000h,038h,03ch,01dh,045h,003h,004h,000h,08bh,001h,003h,007h,003h	; b4ce  0...8<.E........
	defb 03fh,07fh,0ffh,0bfh,0bfh,07fh,0ffh,003h,07fh,002h,000h,084h,0f0h,0f8h,0e8h,0d8h	; b4de  ?...............
	defb 003h,0f8h,087h,0c4h,0c3h,0e3h,0dbh,0cfh,083h,080h,00eh,000h,081h,0aah,00ah,000h	; b4ee  ................
	defb 085h,001h,000h,002h,008h,0a0h,00fh,000h,083h,0ffh,055h,0ffh,008h,000h,087h,001h	; b4fe  ..........U.....
	defb 002h,003h,00dh,0f6h,05ch,0f0h,00dh,000h,083h,0a0h,0d0h,032h,00fh,000h,081h,0aah	; b50e  ....\......2....
	defb 00ch,000h,085h,0a0h,0d8h,0efh,0cfh,07fh,00dh,000h,083h,0ffh,055h,0ffh,000h	; b51e  ............U..

; ----------------------------------------------------------------------
; DATOS rle_B52D: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (41
;   bytes)
;   0xb52d..0xb556  (41 bytes)
DATA_rle_B52D:
	defb 013h,000h,002h,006h,08bh,0deh,01eh,038h,078h,076h,0f2h,021h,001h,02eh,02fh,001h	; b52d  .......8xv.!../.
	defb 005h,000h,002h,001h,002h,000h,002h,001h,006h,000h,08bh,01eh,03fh,07fh,0f9h,039h	; b53d  ............?..9
	defb 0edh,0cfh,08eh,08fh,08fh,0dfh,004h,07fh,000h	; b54d  .........

; ----------------------------------------------------------------------
; DATOS rle_B556: rle a la VRAM, de la tabla de 0xA2D1; lo leen p00:5707 (75
;   bytes)
;   0xb556..0xb5a1  (75 bytes)
DATA_rle_B556:
	defb 007h,000h,089h,03fh,01fh,060h,040h,0d0h,050h,000h,02eh,023h,004h,000h,08ah,010h	; b556  ...?.`@.P..#....
	defb 030h,000h,0e0h,000h,038h,03ch,01dh,045h,003h,004h,000h,08bh,001h,003h,007h,003h	; b566  0...8<.E........
	defb 03fh,07fh,0ffh,0bfh,0bfh,07fh,0ffh,003h,07fh,002h,000h,084h,0f0h,0f8h,0e8h,0d8h	; b576  ?...............
	defb 003h,0f8h,087h,0c4h,0c3h,0e3h,0dbh,0cfh,083h,080h,00ch,000h,083h,0a0h,0d0h,030h	; b586  ...............0
	defb 01ch,000h,085h,0a0h,0d0h,0e8h,0c8h,070h,010h,000h,000h	; b596  .......p...

; ----------------------------------------------------------------------
; DATOS filas_B5A1: dibujo de 32 filas para 0x582D: por fila, cuantos ceros
;   van a la izquierda y los 12 - n bytes de dibujo (se completa a 16 en
;   0xE800); lo leen p00:57E5 (376 bytes)
;   0xb5a1..0xb719  (376 bytes)
DATA_filas_B5A1:
	defb 004h,002h,082h,022h,022h,022h,088h,082h,022h,004h,002h,082h,022h,022h,022h,088h	; b5a1  ...""".."...""".
	defb 022h,082h,004h,022h,088h,022h,022h,022h,022h,028h,082h,003h,002h,082h,028h,022h	; b5b1  "..".""""(....("
	defb 022h,022h,0a2h,028h,088h,003h,022h,082h,022h,022h,022h,022h,028h,088h,082h,003h	; b5c1  "".(..".""""(...
	defb 028h,022h,0a2h,022h,022h,0a2h,088h,088h,088h,003h,022h,0a2h,022h,0a2h,0a2h,028h	; b5d1  (".""....."."..(
	defb 088h,028h,082h,002h,002h,082h,0a2h,022h,022h,028h,088h,022h,088h,082h,002h,002h	; b5e1  .(.....""(."....
	defb 02ah,022h,088h,02ah,022h,082h,028h,088h,082h,002h,022h,02ah,028h,082h,0aah,0a2h	; b5f1  *".*".(..."*(...
	defb 022h,088h,088h,082h,002h,022h,0a2h,082h,082h,0aah,0a2h,028h,088h,088h,082h,001h	; b601  "....".....(....
	defb 002h,082h,0a2h,022h,082h,0aah,022h,088h,088h,088h,082h,001h,002h,028h,022h,022h	; b611  ...".."......(""
	defb 022h,022h,028h,088h,088h,088h,028h,001h,022h,0aah,0aah,022h,022h,088h,088h,088h	; b621  ""(...(."..""...
	defb 088h,088h,028h,001h,028h,02ah,0aah,0a2h,028h,088h,088h,088h,088h,088h,022h,001h	; b631  ..(.(*..(.....".
	defb 022h,0a2h,02ah,022h,088h,088h,088h,088h,088h,088h,082h,000h,002h,082h,0a2h,022h	; b641  ".*"..........."
	defb 022h,088h,088h,088h,088h,088h,088h,022h,000h,002h,02ah,028h,022h,022h,088h,088h	; b651  "......"..*(""..
	defb 088h,082h,088h,088h,022h,000h,002h,02ah,028h,022h,028h,088h,088h,088h,082h,088h	; b661  ...."..*("(.....
	defb 088h,022h,000h,002h,0a2h,088h,022h,028h,088h,088h,088h,028h,088h,088h,022h,000h	; b671  ."...."(...(..".
	defb 002h,0a2h,088h,022h,028h,088h,088h,082h,088h,088h,088h,022h,000h,02ah,028h,088h	; b681  ..."(......".*(.
	defb 082h,028h,088h,088h,028h,088h,088h,088h,022h,000h,02ah,028h,088h,082h,022h,088h	; b691  .(..(...".*(..".
	defb 022h,088h,088h,088h,088h,082h,000h,022h,088h,088h,082h,022h,088h,088h,088h,088h	; b6a1  "......"..."....
	defb 088h,088h,082h,000h,002h,082h,088h,082h,022h,028h,088h,088h,088h,088h,088h,088h	; b6b1  ........"(......
	defb 000h,002h,088h,028h,082h,022h,028h,088h,028h,088h,088h,088h,088h,000h,002h,088h	; b6c1  ...(."(.(.......
	defb 028h,082h,022h,028h,088h,082h,088h,088h,088h,088h,000h,002h,088h,028h,088h,022h	; b6d1  (."(.........(."
	defb 028h,088h,088h,028h,088h,088h,088h,000h,002h,088h,082h,088h,022h,022h,088h,088h	; b6e1  (..(........""..
	defb 082h,088h,088h,088h,001h,028h,082h,088h,082h,022h,088h,088h,088h,088h,088h,088h	; b6f1  .....(..."......
	defb 001h,028h,088h,028h,088h,022h,088h,088h,088h,028h,088h,088h,001h,028h,088h,088h	; b701  .(.(."...(...(..
	defb 088h,082h,028h,088h,088h,082h,088h,088h	; b711  ..(.....

; ----------------------------------------------------------------------
; DATOS filas_B719: dibujo de 32 filas para 0x582D: por fila, cuantos ceros
;   van a la izquierda y los 12 - n bytes de dibujo (se completa a 16 en
;   0xE800); lo leen p00:57FA (380 bytes)
;   0xb719..0xb895  (380 bytes)
DATA_filas_B719:
	defb 004h,002h,082h,022h,022h,022h,088h,082h,000h,004h,002h,082h,022h,022h,022h,088h	; b719  ..."""......""".
	defb 022h,000h,004h,022h,088h,022h,022h,022h,022h,022h,020h,003h,002h,082h,028h,022h	; b729  "..".""""" ...("
	defb 022h,022h,0a2h,028h,022h,003h,022h,082h,022h,022h,022h,022h,028h,088h,022h,003h	; b739  "".(".".""""(.".
	defb 028h,082h,0a2h,022h,022h,0a2h,088h,088h,082h,003h,028h,022h,022h,0a2h,0a2h,028h	; b749  (.."".....(""..(
	defb 082h,088h,082h,002h,002h,082h,02ah,022h,022h,022h,028h,088h,028h,088h,002h,002h	; b759  ......*"""(.(...
	defb 082h,02ah,022h,02ah,022h,022h,088h,088h,082h,002h,028h,022h,022h,0a2h,0aah,0a2h	; b769  .*"*""....(""...
	defb 0a2h,088h,082h,028h,001h,002h,028h,022h,0a2h,022h,0aah,0a2h,022h,088h,088h,088h	; b779  ...(..(".".."...
	defb 001h,022h,088h,02ah,022h,022h,0aah,0a2h,022h,028h,088h,088h,001h,028h,082h,02ah	; b789  .".*"".."(...(.*
	defb 02ah,022h,02ah,022h,0aah,028h,088h,028h,000h,002h,028h,082h,0a2h,022h,0a2h,022h	; b799  *"*".(.(..(.."."
	defb 0a2h,022h,028h,088h,022h,000h,002h,088h,022h,0a2h,022h,02ah,0a2h,0a2h,0aah,028h	; b7a9  ."(."..."."*...(
	defb 088h,02ah,000h,002h,088h,02ah,022h,02ah,022h,022h,022h,022h,028h,082h,02ah,000h	; b7b9  .*...*"*""""(.*.
	defb 022h,082h,02ah,022h,02ah,022h,022h,0a2h,022h,022h,082h,02ah,000h,028h,082h,022h	; b7c9  ".*"*""."".*.(."
	defb 022h,022h,0aah,0a2h,0a2h,0aah,022h,082h,0a2h,000h,028h,022h,022h,022h,022h,022h	; b7d9  ""...."...("""""
	defb 022h,022h,022h,028h,082h,0a2h,000h,028h,028h,022h,082h,02ah,022h,022h,0a2h,022h	; b7e9  """(...((".*""."
	defb 088h,02ah,022h,000h,028h,022h,088h,022h,022h,0aah,0a2h,0a2h,0aah,088h,02ah,022h	; b7f9  .*".("."".....*"
	defb 000h,028h,022h,022h,022h,022h,022h,022h,022h,022h,082h,0a2h,022h,000h,028h,082h	; b809  .(""""""""..".(.
	defb 022h,028h,022h,02ah,0aah,022h,0a2h,082h,0a2h,022h,000h,022h,088h,022h,028h,022h	; b819  "("*."..."."."("
	defb 02ah,02ah,08ah,0a2h,088h,028h,082h,000h,022h,082h,082h,028h,022h,02ah,0a2h,0aah	; b829  **...(.."..("*..
	defb 022h,088h,088h,082h,000h,002h,088h,022h,022h,022h,022h,0a2h,0a8h,022h,088h,022h	; b839  "......"""".."."
	defb 088h,000h,002h,088h,028h,028h,022h,022h,0aah,022h,028h,088h,082h,022h,000h,002h	; b849  ....((""."(.."..
	defb 088h,028h,022h,088h,022h,022h,022h,028h,088h,088h,022h,000h,002h,088h,082h,082h	; b859  .("."""(..".....
	defb 022h,02ah,0a2h,0a2h,088h,028h,088h,088h,001h,028h,082h,088h,022h,02ah,0a2h,022h	; b869  "*...(...(.."*."
	defb 088h,028h,088h,088h,001h,028h,088h,028h,088h,022h,022h,028h,082h,088h,088h,088h	; b879  .(...(.(.""(....
	defb 001h,028h,088h,088h,088h,082h,022h,088h,028h,088h,088h,088h	; b889  .(....".(...

; ----------------------------------------------------------------------
; DATOS rle_B895: rle a la VRAM (0x00 acaba, 0x80 otro destino, 1nnnnnnn van
;   tal cual, 0nnnnnnn repite el que viene); lo leen p00:56C9 (206 bytes)
;   0xb895..0xb963  (206 bytes)
DATA_rle_B895:
	defb 002h,000h,089h,001h,007h,01fh,03fh,07fh,07fh,03fh,03ch,01eh,006h,000h,082h,001h	; b895  ......?..?<.....
	defb 0e7h,004h,0ffh,08bh,0feh,0ffh,0ffh,03fh,0feh,0d8h,060h,000h,000h,00ch,0dfh,004h	; b8a5  .......?..`.....
	defb 0ffh,084h,0fbh,067h,08fh,0dfh,003h,01fh,081h,00ch,004h,000h,002h,080h,082h,08ch	; b8b5  ...g............
	defb 0dfh,005h,0ffh,084h,09fh,03eh,024h,018h,003h,000h,082h,01ch,07fh,003h,0ffh,086h	; b8c5  .....>$.........
	defb 07fh,03fh,01fh,087h,07dh,078h,005h,000h,083h,038h,0fch,0feh,003h,0ffh,084h,0bfh	; b8d5  .?..}x...8......
	defb 0dfh,0cfh,080h,009h,000h,085h,070h,0feh,0ffh,0bfh,09bh,00dh,000h,082h,0fch,0e0h	; b8e5  ......p.........
	defb 00fh,000h,088h,040h,043h,061h,03fh,01fh,003h,003h,001h,007h,000h,089h,001h,000h	; b8f5  ...@Ca?.........
	defb 000h,0c0h,001h,027h,09eh,0fch,0f0h,006h,000h,089h,004h,098h,070h,020h,0e0h,0e0h	; b905  ...'........p ..
	defb 060h,033h,01fh,00ch,000h,085h,060h,0c1h,0dbh,0e6h,0fch,007h,000h,087h,080h,0c0h	; b915  `3....`.........
	defb 0e0h,078h,082h,086h,07ch,00ah,000h,085h,040h,020h,030h,01fh,00fh,00bh,000h,084h	; b925  .x..|...@ 0.....
	defb 040h,064h,0ffh,0f0h,00ch,000h,082h,010h,0c0h,00fh,000h,087h,00ch,00eh,00eh,006h	; b935  @d..............
	defb 003h,003h,001h,009h,000h,087h,030h,070h,070h,060h,0c0h,0c0h,080h,00bh,000h,085h	; b945  ......0pp`......
	defb 00ah,00fh,00fh,00dh,008h,00bh,000h,085h,050h,0f0h,0f0h,0b0h,010h,000h	; b955  ........P.....

; ======================================================================
; CODIGO 0xb963..0xb9d3  (112 bytes)
; ======================================================================


L_B963:
	ld a,(0c41bh)		;b963
	inc a			;b966
	jr z,L_B98C		;b967
	call L_B9BD		;b969
	ld de,0c41bh		;b96c
	ld a,(de)			;b96f
	ld b,a			;b970
	xor a			;b971
	ld (de),a			;b972
	dec b			;b973
	bit 1,b		;b974
	jr z,L_B979		;b976
	inc hl			;b978
L_B979:
	bit 0,b		;b979
	ld a,(hl)			;b97b
	jr nz,L_B982		;b97c
	rrca			;b97e
	rrca			;b97f
	rrca			;b980
	rrca			;b981
L_B982:
	and 00fh		;b982
	cp 00fh		;b984
	ret z			;b986
L_B987:
	ld (0d001h),a		;b987
	scf			;b98a
	ret			;b98b
L_B98C:
	xor a			;b98c
	ld (0c41bh),a		;b98d
	ld a,(0c5b4h)		;b990
	jr L_B987		;b993
L_B995:
	add a,l			;b995
	ld l,a			;b996
	ret nc			;b997
	inc h			;b998
	ret			;b999
L_B99A:
	call L_B9BD		;b99a
	ld de,0c41ch		;b99d
	ld b,004h		;b9a0
L_B9A2:
	ld a,(hl)			;b9a2
	bit 0,b		;b9a3
	jr nz,L_B9AB		;b9a5
	rrca			;b9a7
	rrca			;b9a8
	rrca			;b9a9
	rrca			;b9aa
L_B9AB:
	and 00fh		;b9ab
	cp 00fh		;b9ad
	jr nz,L_B9B3		;b9af
	ld a,0ffh		;b9b1
L_B9B3:
	ld (de),a			;b9b3
	inc de			;b9b4
	bit 0,b		;b9b5
	jr z,L_B9BA		;b9b7
	inc hl			;b9b9
L_B9BA:
	djnz L_B9A2		;b9ba
	ret			;b9bc
L_B9BD:
	ld a,(0d000h)		;b9bd
	ld hl,0b9d3h		;b9c0
	add a,a			;b9c3
	call L_B995		;b9c4
	ld a,(hl)			;b9c7
	inc hl			;b9c8
	ld h,(hl)			;b9c9
	ld l,a			;b9ca
	ld a,(0d001h)		;b9cb
	add a,a			;b9ce
	call L_B995		;b9cf
	ret			;b9d2

; ----------------------------------------------------------------------
; DATOS salidas_de_cada_fase: 19 punteros, uno por fase, a las salidas de sus
;   habitaciones; lo leen p13:B9C0 (38 bytes)
;   0xb9d3..0xb9f9  (38 bytes)
DATA_salidas_de_cada_fase:
	defb 0f9h,0b9h	; b9d3
	defb 0ffh,0b9h	; b9d5
	defb 00fh,0bah	; b9d7
	defb 01bh,0bah	; b9d9
	defb 027h,0bah	; b9db
	defb 033h,0bah	; b9dd
	defb 03fh,0bah	; b9df
	defb 04bh,0bah	; b9e1
	defb 05dh,0bah	; b9e3
	defb 06dh,0bah	; b9e5
	defb 07fh,0bah	; b9e7
	defb 091h,0bah	; b9e9
	defb 09dh,0bah	; b9eb
	defb 0b5h,0bah	; b9ed
	defb 0cdh,0bah	; b9ef
	defb 0ddh,0bah	; b9f1
	defb 0f1h,0bah	; b9f3
	defb 005h,0bbh	; b9f5
	defb 01dh,0bbh	; b9f7

; ----------------------------------------------------------------------
; DATOS salidas_fase_0: las salidas de las 3 habitaciones de la fase 0: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (6 bytes)
;   0xb9f9..0xb9ff  (6 bytes)
DATA_salidas_fase_0:
	defb 0ffh,0f1h	; b9f9
	defb 0ffh,002h	; b9fb
	defb 0ffh,01fh	; b9fd

; ----------------------------------------------------------------------
; DATOS salidas_fase_1: las salidas de las 8 habitaciones de la fase 1: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (16 bytes)
;   0xb9ff..0xba0f  (16 bytes)
DATA_salidas_fase_1:
	defb 0ffh,031h	; b9ff
	defb 05fh,002h	; ba01
	defb 0ffh,013h	; ba03
	defb 07fh,020h	; ba05
	defb 0ffh,0f5h	; ba07
	defb 0f1h,046h	; ba09
	defb 0ffh,057h	; ba0b
	defb 0f3h,06fh	; ba0d

; ----------------------------------------------------------------------
; DATOS salidas_fase_2: las salidas de las 6 habitaciones de la fase 2: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (12 bytes)
;   0xba0f..0xba1b  (12 bytes)
DATA_salidas_fase_2:
	defb 024h,0f1h	; ba0f
	defb 0f5h,00fh	; ba11
	defb 0f0h,033h	; ba13
	defb 0ffh,022h	; ba15
	defb 00fh,0f5h	; ba17
	defb 01fh,04fh	; ba19

; ----------------------------------------------------------------------
; DATOS salidas_fase_3: las salidas de las 6 habitaciones de la fase 3: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (12 bytes)
;   0xba1b..0xba27  (12 bytes)
DATA_salidas_fase_3:
	defb 0f4h,031h	; ba1b
	defb 0ffh,002h	; ba1d
	defb 0ffh,013h	; ba1f
	defb 0ffh,020h	; ba21
	defb 00fh,0f5h	; ba23
	defb 0ffh,0ffh	; ba25

; ----------------------------------------------------------------------
; DATOS salidas_fase_4: las salidas de las 6 habitaciones de la fase 4: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (12 bytes)
;   0xba27..0xba33  (12 bytes)
DATA_salidas_fase_4:
	defb 0ffh,021h	; ba27
	defb 04fh,002h	; ba29
	defb 05fh,010h	; ba2b
	defb 0f0h,0f4h	; ba2d
	defb 0f1h,035h	; ba2f
	defb 0f2h,04fh	; ba31

; ----------------------------------------------------------------------
; DATOS salidas_fase_5: las salidas de las 6 habitaciones de la fase 5: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (12 bytes)
;   0xba33..0xba3f  (12 bytes)
DATA_salidas_fase_5:
	defb 0ffh,01fh	; ba33
	defb 0ffh,020h	; ba35
	defb 05fh,0f1h	; ba37
	defb 0ffh,04fh	; ba39
	defb 0f1h,053h	; ba3b
	defb 0f2h,0f4h	; ba3d

; ----------------------------------------------------------------------
; DATOS salidas_fase_6: las salidas de las 6 habitaciones de la fase 6: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (12 bytes)
;   0xba3f..0xba4b  (12 bytes)
DATA_salidas_fase_6:
	defb 03fh,01fh	; ba3f
	defb 0ffh,020h	; ba41
	defb 0ffh,0f1h	; ba43
	defb 0f0h,04fh	; ba45
	defb 0ffh,053h	; ba47
	defb 0ffh,0ffh	; ba49

; ----------------------------------------------------------------------
; DATOS salidas_fase_7: las salidas de las 9 habitaciones de la fase 7: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (18 bytes)
;   0xba4b..0xba5d  (18 bytes)
DATA_salidas_fase_7:
	defb 0ffh,01fh	; ba4b
	defb 0ffh,020h	; ba4d
	defb 05fh,0f1h	; ba4f
	defb 0ffh,04fh	; ba51
	defb 0ffh,053h	; ba53
	defb 082h,0f4h	; ba55
	defb 0f3h,07fh	; ba57
	defb 0f4h,086h	; ba59
	defb 0f5h,0f7h	; ba5b

; ----------------------------------------------------------------------
; DATOS salidas_fase_8: las salidas de las 8 habitaciones de la fase 8: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (16 bytes)
;   0xba5d..0xba6d  (16 bytes)
DATA_salidas_fase_8:
	defb 0ffh,0f1h	; ba5d
	defb 0ffh,002h	; ba5f
	defb 05fh,01fh	; ba61
	defb 0ffh,0f4h	; ba63
	defb 0f7h,03fh	; ba65
	defb 0f2h,0f6h	; ba67
	defb 0f3h,057h	; ba69
	defb 0f4h,06fh	; ba6b

; ----------------------------------------------------------------------
; DATOS salidas_fase_9: las salidas de las 9 habitaciones de la fase 9: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (18 bytes)
;   0xba6d..0xba7f  (18 bytes)
DATA_salidas_fase_9:
	defb 0ffh,0f1h	; ba6d
	defb 0ffh,002h	; ba6f
	defb 0ffh,013h	; ba71
	defb 0ffh,024h	; ba73
	defb 0ffh,035h	; ba75
	defb 068h,04fh	; ba77
	defb 0f5h,0ffh	; ba79
	defb 0ffh,0ffh	; ba7b
	defb 05fh,07fh	; ba7d

; ----------------------------------------------------------------------
; DATOS salidas_fase_10: las salidas de las 9 habitaciones de la fase 10: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (18 bytes)
;   0xba7f..0xba91  (18 bytes)
DATA_salidas_fase_10:
	defb 0ffh,051h	; ba7f
	defb 06fh,002h	; ba81
	defb 0ffh,013h	; ba83
	defb 0ffh,024h	; ba85
	defb 0ffh,035h	; ba87
	defb 08fh,040h	; ba89
	defb 0f1h,077h	; ba8b
	defb 0ffh,066h	; ba8d
	defb 0f5h,0ffh	; ba8f

; ----------------------------------------------------------------------
; DATOS salidas_fase_11: las salidas de las 6 habitaciones de la fase 11: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (12 bytes)
;   0xba91..0xba9d  (12 bytes)
DATA_salidas_fase_11:
	defb 0ffh,0f1h	; ba91
	defb 0ffh,002h	; ba93
	defb 0ffh,013h	; ba95
	defb 0ffh,024h	; ba97
	defb 0ffh,035h	; ba99
	defb 0ffh,04fh	; ba9b

; ----------------------------------------------------------------------
; DATOS salidas_fase_12: las salidas de las 12 habitaciones de la fase 12: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (24 bytes)
;   0xba9d..0xbab5  (24 bytes)
DATA_salidas_fase_12:
	defb 0ffh,021h	; ba9d
	defb 0ffh,002h	; ba9f
	defb 0ffh,010h	; baa1
	defb 0ffh,0f4h	; baa3
	defb 0ffh,035h	; baa5
	defb 0ffh,046h	; baa7
	defb 0ffh,0ffh	; baa9
	defb 0ffh,088h	; baab
	defb 0ffh,077h	; baad
	defb 0ffh,0bah	; baaf
	defb 0ffh,09bh	; bab1
	defb 0ffh,0a9h	; bab3

; ----------------------------------------------------------------------
; DATOS salidas_fase_13: las salidas de las 12 habitaciones de la fase 13: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (24 bytes)
;   0xbab5..0xbacd  (24 bytes)
DATA_salidas_fase_13:
	defb 03fh,0f1h	; bab5
	defb 0ffh,002h	; bab7
	defb 057h,01fh	; bab9
	defb 0f0h,064h	; babb
	defb 0ffh,035h	; babd
	defb 0f2h,046h	; babf
	defb 0bfh,053h	; bac1
	defb 029h,0ffh	; bac3
	defb 0ffh,0f9h	; bac5
	defb 07fh,08ah	; bac7
	defb 0fbh,09fh	; bac9
	defb 0a6h,09fh	; bacb

; ----------------------------------------------------------------------
; DATOS salidas_fase_14: las salidas de las 8 habitaciones de la fase 14: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (16 bytes)
;   0xbacd..0xbadd  (16 bytes)
DATA_salidas_fase_14:
	defb 03fh,0ffh	; bacd
	defb 0ffh,02fh	; bacf
	defb 0f5h,0f1h	; bad1
	defb 0f0h,04fh	; bad3
	defb 0f1h,053h	; bad5
	defb 0ffh,064h	; bad7
	defb 0ffh,075h	; bad9
	defb 0ffh,0f6h	; badb

; ----------------------------------------------------------------------
; DATOS salidas_fase_15: las salidas de las 10 habitaciones de la fase 15: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (20 bytes)
;   0xbadd..0xbaf1  (20 bytes)
DATA_salidas_fase_15:
	defb 02fh,01fh	; badd
	defb 0ffh,0f0h	; badf
	defb 040h,033h	; bae1
	defb 0ffh,022h	; bae3
	defb 072h,055h	; bae5
	defb 0f3h,044h	; bae7
	defb 0ffh,07fh	; bae9
	defb 0f4h,086h	; baeb
	defb 0f5h,097h	; baed
	defb 0ffh,0ffh	; baef

; ----------------------------------------------------------------------
; DATOS salidas_fase_16: las salidas de las 10 habitaciones de la fase 16: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (20 bytes)
;   0xbaf1..0xbb05  (20 bytes)
DATA_salidas_fase_16:
	defb 0f6h,01fh	; baf1
	defb 0f7h,020h	; baf3
	defb 0f8h,031h	; baf5
	defb 0f9h,042h	; baf7
	defb 0ffh,053h	; baf9
	defb 0ffh,0f4h	; bafb
	defb 00fh,07fh	; bafd
	defb 0ffh,086h	; baff
	defb 0ffh,097h	; bb01
	defb 0ffh,0f8h	; bb03

; ----------------------------------------------------------------------
; DATOS salidas_fase_17: las salidas de las 12 habitaciones de la fase 17: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (24 bytes)
;   0xbb05..0xbb1d  (24 bytes)
DATA_salidas_fase_17:
	defb 03fh,01fh	; bb05
	defb 04fh,020h	; bb07
	defb 05fh,0f1h	; bb09
	defb 0f0h,04fh	; bb0b
	defb 0f1h,053h	; bb0d
	defb 062h,0f4h	; bb0f
	defb 095h,07fh	; bb11
	defb 0afh,086h	; bb13
	defb 0bfh,0f7h	; bb15
	defb 0f6h,0afh	; bb17
	defb 0f7h,0b9h	; bb19
	defb 0f8h,0ffh	; bb1b

; ----------------------------------------------------------------------
; DATOS salidas_fase_18: las salidas de las 10 habitaciones de la fase 18: dos
;   bytes por habitacion, cuatro nibbles con la habitacion vecina por cada
;   lado (0xF, no hay); lo leen p13:B9A2 (20 bytes)
;   0xbb1d..0xbb31  (20 bytes)
DATA_salidas_fase_18:
	defb 0ffh,01fh	; bb1d
	defb 0ffh,020h	; bb1f
	defb 03fh,0f1h	; bb21
	defb 052h,0ffh	; bb23
	defb 065h,055h	; bb25
	defb 043h,044h	; bb27
	defb 074h,0ffh	; bb29
	defb 0f6h,08fh	; bb2b
	defb 0ffh,097h	; bb2d
	defb 0ffh,0ffh	; bb2f

; ======================================================================
; CODIGO 0xbb31..0xbb61  (48 bytes)
; ======================================================================


L_BB31:
	call L_BB37		;bb31
	jp L_BB9A		;bb34
L_BB37:
	ld a,(0d000h)		;bb37
	ld hl,0bb61h		;bb3a
	ld b,a			;bb3d
	add a,a			;bb3e
	add a,b			;bb3f
	call L_B995		;bb40
	ld a,(hl)			;bb43
	ld b,a			;bb44
	and 00fh		;bb45
	ld c,a			;bb47
	ld a,(0d001h)		;bb48
	cp c			;bb4b
	ret nz			;bb4c
	inc hl			;bb4d
	ld a,(hl)			;bb4e
	inc hl			;bb4f
	ld h,(hl)			;bb50
	ld l,a			;bb51
	ld (0c5adh),hl		;bb52
	ld a,b			;bb55
	add a,a			;bb56
	ld a,0ffh		;bb57
	jr c,L_BB5D		;bb59
	ld a,004h		;bb5b
L_BB5D:
	ld (0c5ach),a		;bb5d
	ret			;bb60

; ----------------------------------------------------------------------
; DATOS puerta_de_cada_fase: tres bytes por fase: [habitacion (nibble bajo) y
;   bandera (bit 7)][puntero que p13:BB52 deja en 0xC5AD]; lo leen p13:BB3A
;   (57 bytes)
;   0xbb61..0xbb9a  (57 bytes)
DATA_puerta_de_cada_fase:
	defb 042h,090h,0e0h	; bb61
	defb 087h,030h,0ech	; bb64
	defb 081h,030h,0ech	; bb67
	defb 084h,080h,0ech	; bb6a
	defb 083h,030h,00ch	; bb6d
	defb 085h,050h,00ch	; bb70
	defb 084h,050h,00ch	; bb73
	defb 086h,060h,0ech	; bb76
	defb 087h,040h,0ech	; bb79
	defb 088h,080h,00ch	; bb7c
	defb 088h,080h,0ech	; bb7f
	defb 085h,080h,0ech	; bb82
	defb 085h,080h,0ech	; bb85
	defb 088h,080h,00ch	; bb88
	defb 087h,080h,00ch	; bb8b
	defb 088h,080h,00ch	; bb8e
	defb 085h,040h,00ch	; bb91
	defb 08bh,040h,00ch	; bb94
	defb 088h,080h,00ch	; bb97

; ======================================================================
; CODIGO 0xbb9a..0xbbcd  (51 bytes)
; ======================================================================


L_BB9A:
	ld de,(0d000h)		;bb9a
	ld hl,0bbcdh		;bb9e
L_BBA1:
	ld a,(hl)			;bba1
	inc a			;bba2
	ret z			;bba3
	inc hl			;bba4
	dec a			;bba5
	cp e			;bba6
	jr nz,L_BBB0		;bba7
	ld a,(hl)			;bba9
	ld c,a			;bbaa
	and 00fh		;bbab
	cp d			;bbad
	jr z,L_BBB5		;bbae
L_BBB0:
	inc hl			;bbb0
	inc hl			;bbb1
	inc hl			;bbb2
	jr L_BBA1		;bbb3
L_BBB5:
	inc hl			;bbb5
	ld a,(hl)			;bbb6
	inc hl			;bbb7
	ld h,(hl)			;bbb8
	ld l,a			;bbb9
	ld (0c5b2h),hl		;bbba
	ld a,001h		;bbbd
	ld (0c5b1h),a		;bbbf
	ld a,c			;bbc2
	rrca			;bbc3
	rrca			;bbc4
	rrca			;bbc5
	rrca			;bbc6
	and 00fh		;bbc7
	ld (0c5b4h),a		;bbc9
	ret			;bbcc

; ----------------------------------------------------------------------
; DATOS pasos_entre_habitaciones: 10 registros de cuatro bytes [fase +
;   1][habitacion nueva << 4 | habitacion][puntero que p13:BBBA deja en
;   0xC5B2], y 0xFF; lo leen p13:BB9E (41 bytes)
;   0xbbcd..0xbbf6  (41 bytes)
DATA_pasos_entre_habitaciones:
	defb 00ch,030h,0a8h,058h	; bbcd
	defb 00ch,041h,088h,0b8h	; bbd1
	defb 00ch,0b2h,0a8h,098h	; bbd5
	defb 00ch,003h,0a8h,058h	; bbd9
	defb 00ch,014h,088h,0b8h	; bbdd
	defb 00ch,085h,0a8h,058h	; bbe1
	defb 00ch,0a7h,0a8h,038h	; bbe5
	defb 00ch,058h,0a8h,058h	; bbe9
	defb 00ch,07ah,0a8h,038h	; bbed
	defb 00ch,02bh,0a8h,098h	; bbf1
	defb 0ffh	; bbf5

; ----------------------------------------------------------------------
; DATOS rle_BBF6: rle a la VRAM (0x00 acaba, 0x80 otro destino, 1nnnnnnn van
;   tal cual, 0nnnnnnn repite el que viene), con el destino delante; lo leen
;   p00:5A1E (610 bytes)
;   0xbbf6..0xbe58  (610 bytes)
DATA_rle_BBF6:
	defb 000h,0f8h,0ffh,020h,03fh,046h,03fh,036h,036h,03fh,046h,07fh,000h,013h,037h,036h	; bbf6  ... ?F?66?F...76
	defb 077h,027h,000h,002h,0feh,064h,0fch,06ch,06ch,0fch,062h,0feh,000h,06ch,076h,016h	; bc06  w'...d.ll.b..lv.
	defb 0fah,0fch,000h,05fh,040h,039h,040h,049h,049h,040h,0b9h,080h,07fh,02ch,048h,049h	; bc16  ..._@9@II@...,HI
	defb 088h,058h,027h,0fdh,001h,09ah,002h,092h,092h,002h,09dh,001h,0feh,092h,089h,0e9h	; bc26  .X'.............
	defb 005h,002h,0fch,001h,0ffh,066h,07fh,06eh,07fh,066h,07fh,079h,07fh,079h,06fh,06eh	; bc36  .....f.n.f.y.yon
	defb 0deh,0dch,080h,0c0h,0feh,018h,0feh,03ch,07eh,09ah,0fch,0cch,0fch,0cch,0f8h,0feh	; bc46  .......<~.......
	defb 0e7h,0feh,000h,0feh,000h,099h,080h,091h,080h,099h,080h,086h,080h,086h,090h,091h	; bc56  ................
	defb 021h,023h,05ch,03eh,001h,0e6h,001h,0c2h,081h,065h,002h,032h,002h,032h,006h,001h	; bc66  !#\>.....e.2.2..
	defb 018h,001h,0c1h,0feh,000h,038h,033h,037h,037h,07fh,07fh,033h,037h,03fh,07bh,0f7h	; bc76  .....8377..37?{.
	defb 067h,07eh,00ch,000h,002h,01bh,018h,0ffh,0ffh,018h,05bh,0fbh,07bh,07eh,0deh,05ch	; bc86  g~........[.{~.\
	defb 07ch,0efh,043h,000h,038h,047h,04ch,048h,048h,080h,080h,04ch,048h,040h,084h,008h	; bc96  |.C.8GLHH..LH@..
	defb 098h,081h,073h,00ch,01dh,024h,0e7h,000h,000h,0e7h,0a4h,004h,084h,081h,021h,0a2h	; bca6  ..s..$........!.
	defb 083h,010h,0bch,043h,011h,000h,081h,067h,003h,03fh,083h,03eh,01eh,01eh,005h,01fh	; bcb6  ...C...g.?.>....
	defb 083h,03fh,03eh,03ah,010h,000h,08ah,067h,098h,0c0h,0c0h,040h,041h,061h,061h,060h	; bcc6  .?>:...g...@Aaa`
	defb 060h,003h,020h,09bh,040h,041h,045h,0e0h,0c1h,083h,006h,005h,002h,001h,000h,000h	; bcd6  `. .@AE.........
	defb 0c0h,0f0h,0fch,0ffh,0ffh,03fh,01fh,000h,01ch,03ch,0dah,0d2h,06ch,080h,080h,005h	; bce6  .....?...<..l...
	defb 000h,0a3h,0c0h,0f0h,0f8h,011h,032h,074h,0e9h,0eah,0edh,0aeh,0abh,0c3h,03ah,00eh	; bcf6  ......2t......:.
	defb 003h,000h,000h,0c0h,0e0h,01ch,0a2h,0c2h,025h,02dh,093h,07fh,07eh,0fah,0eah,0a8h	; bd06  ........%-..~...
	defb 088h,0e0h,030h,00ch,004h,010h,000h,084h,038h,03ch,03ch,03eh,003h,07fh,085h,067h	; bd16  ..0.....8<<>...g
	defb 077h,072h,0c0h,080h,014h,000h,084h,047h,043h,043h,0c1h,003h,080h,08ch,098h,088h	; bd26  wr.....GCC......
	defb 08dh,03fh,07fh,0ffh,0feh,0eah,048h,003h,000h,001h,004h,000h,002h,080h,081h,0c0h	; bd36  .?....H.........
	defb 006h,000h,081h,0f8h,003h,0f0h,002h,020h,00ah,000h,091h,0fch,0ffh,07eh,037h,0a7h	; bd46  ....... .....~7.
	defb 0a7h,0c3h,042h,060h,020h,0e0h,0f0h,0f0h,0d8h,088h,080h,004h,003h,00ch,002h,0d8h	; bd56  ..B` ...........
	defb 085h,0f8h,0b8h,0b0h,090h,010h,00bh,000h,095h,018h,01fh,01fh,03fh,03fh,038h,060h	; bd66  ............??8`
	defb 040h,073h,07fh,000h,000h,00eh,007h,003h,001h,061h,079h,0ffh,0ffh,0fdh,003h,003h	; bd76  @s.......ay.....
	defb 002h,0ffh,005h,000h,099h,038h,027h,020h,020h,040h,040h,047h,09fh,0b7h,08ch,080h	; bd86  .....8'  @@G....
	defb 000h,00eh,011h,008h,004h,062h,09eh,086h,000h,000h,002h,0fch,0d4h,0fch,003h,000h	; bd96  .....b..........
	defb 08fh,004h,01eh,0f8h,0e0h,090h,0f4h,0f7h,0ffh,0ffh,0dfh,0e3h,0c0h,0e0h,0e0h,0fbh	; bda6  ................
	defb 003h,000h,0b5h,004h,00ch,00ch,05ch,078h,0f8h,0f8h,0f0h,060h,036h,006h,06eh,07eh	; bdb6  ......\x...`6.n~
	defb 004h,01ah,0e1h,007h,01fh,06dh,00bh,008h,000h,000h,020h,01ch,037h,017h,01fh,004h	; bdc6  .....m.... .7...
	defb 000h,000h,004h,00ah,012h,072h,0a2h,086h,006h,004h,008h,09eh,0c9h,079h,091h,081h	; bdd6  .....r.......y..
	defb 03fh,03fh,07bh,07ch,078h,060h,0c0h,080h,008h,000h,083h,0ffh,01fh,0c1h,004h,001h	; bde6  ??{|x`..........
	defb 003h,003h,082h,007h,004h,004h,000h,002h,040h,08ch,084h,083h,087h,09fh,03fh,07fh	; bdf6  ........@.....?.
	defb 0fbh,0fah,0e8h,0a8h,020h,020h,003h,000h,09ah,0e0h,03eh,0feh,0feh,0fah,0d2h,0c4h	; be06  ....  ....>.....
	defb 084h,084h,088h,00bh,00fh,00fh,006h,004h,0fbh,0ffh,0fch,0f1h,0f0h,0f0h,0f8h,0f4h	; be16  ................
	defb 04ch,09fh,013h,005h,000h,003h,0fch,082h,038h,018h,005h,000h,081h,080h,005h,000h	; be26  L.......8.......
	defb 08bh,004h,000h,003h,00eh,00fh,00eh,006h,00bh,0b3h,060h,0ech,003h,0ffh,082h,0f5h	; be36  ..........`.....
	defb 0b4h,003h,003h,08dh,0c7h,0e6h,0feh,0feh,0bah,02ah,0e8h,040h,0c0h,0c0h,080h,000h	; be46  .........*.@....
	defb 000h,000h	; be56

; ----------------------------------------------------------------------
; DATOS rle_sin_usar_BE58: rle que no lee nadie (su direccion no aparece como
;   palabra en el cartucho) y que cierra clavado en el hueco; lo leen nadie (1
;   bytes)
;   0xbe58..0xbe59  (1 bytes)
DATA_rle_sin_usar_BE58:
	defb 000h	; be58

; ----------------------------------------------------------------------
; DATOS letras_BE59: 13 caracteres de 8x8 a 1 bit (8 bytes cada uno) que
;   0x4AA5 pinta de color al subirlos; lo leen p00:531B (104 bytes)
;   0xbe59..0xbec1  (104 bytes)
DATA_letras_BE59:
	defb 007h,007h,00fh,00fh,00fh,01fh,01fh,03fh	; be59  .......?
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be61  ........
	defb 0f8h,0f8h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h	; be69  ........
	defb 000h,000h,000h,000h,001h,003h,00fh,07fh	; be71  ........
	defb 03fh,07fh,07fh,0ffh,0ffh,0ffh,0ffh,0ffh	; be79  ?.......
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0fch,0f0h,0c0h	; be81  ........
	defb 0c0h,0c0h,080h,080h,000h,000h,000h,000h	; be89  ........
	defb 000h,000h,000h,001h,003h,007h,00fh,00fh	; be91  ........
	defb 00fh,03fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be99  .?......
	defb 0ffh,0ffh,0ffh,0feh,0fch,0f8h,0f8h,0f0h	; bea1  ........
	defb 0f8h,0c0h,000h,000h,000h,000h,000h,000h	; bea9  ........
	defb 01fh,01fh,01fh,03fh,03fh,03fh,07fh,07fh	; beb1  ...???..
	defb 0f0h,0e0h,0e0h,0c0h,0c0h,0c0h,080h,080h	; beb9  ........

; ----------------------------------------------------------------------
; DATOS letras_BEC1: 13 caracteres de 8x8 a 1 bit (8 bytes cada uno) que
;   0x4AA5 pinta de color al subirlos; lo leen p00:5327 (104 bytes)
;   0xbec1..0xbf29  (104 bytes)
DATA_letras_BEC1:
	defb 000h,000h,000h,000h,000h,001h,001h,003h	; bec1  ........
	defb 07fh,07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bec9  ........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0feh,0fch	; bed1  ........
	defb 080h,080h,000h,000h,000h,000h,000h,000h	; bed9  ........
	defb 000h,000h,000h,000h,000h,000h,000h,007h	; bee1  ........
	defb 003h,007h,007h,00fh,01fh,03fh,0ffh,0ffh	; bee9  .....?..
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f8h	; bef1  ........
	defb 0fch,0f8h,0f8h,0f0h,0e0h,0c0h,000h,000h	; bef9  ........
	defb 000h,003h,00fh,01fh,03fh,07fh,0ffh,0ffh	; bf01  ....?...
	defb 0ffh,0fch,0f0h,0e0h,0c0h,080h,080h,000h	; bf09  ........
	defb 001h,001h,001h,003h,003h,003h,007h,007h	; bf11  ........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf19  ........
	defb 0ffh,0feh,0feh,0fch,0fch,0fch,0f8h,0f8h	; bf21  ........

; ----------------------------------------------------------------------
; DATOS letras_BF29: 26 caracteres de 8x8 a 1 bit (8 bytes cada uno) que
;   0x4AA5 pinta de color al subirlos; lo leen p00:5333 (208 bytes)
;   0xbf29..0xbff9  (208 bytes)
DATA_letras_BF29:
	defb 03ch,03ch,078h,078h,079h,0f3h,0f7h,0ffh	; bf29  <<xxy...
	defb 01fh,03eh,07ch,0f9h,0f3h,0e3h,0c3h,087h	; bf31  .>|.....
	defb 01fh,07fh,0f8h,0f0h,0e0h,0e0h,0c0h,0c0h	; bf39  ........
	defb 0c0h,0f0h,0f8h,078h,078h,079h,079h,079h	; bf41  ...xxyyy
	defb 07fh,07fh,0ffh,0f7h,0f7h,0e7h,0e7h,0e7h	; bf49  ........
	defb 00fh,00fh,01eh,01eh,01eh,03ch,03ch,03ch	; bf51  .....<<<
	defb 003h,007h,00fh,00eh,01eh,03ch,038h,078h	; bf59  .....<8x
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e1h,0e1h,0e1h	; bf61  ........
	defb 07eh,07eh,0feh,0f6h,0f6h,0eeh,0eeh,0eeh	; bf69  ~~......
	defb 00fh,00fh,01fh,01dh,03dh,03bh,07bh,073h	; bf71  ....=;{s
	defb 0f1h,0f1h,0e3h,0e3h,0e3h,0c7h,0c7h,0c7h	; bf79  ........
	defb 0e0h,0e0h,0c0h,0c0h,0c0h,080h,080h,080h	; bf81  ........
	defb 001h,001h,001h,003h,003h,003h,007h,007h	; bf89  ........
	defb 0efh,0e7h,0e7h,0c7h,0c7h,0c3h,083h,083h	; bf91  ........
	defb 087h,087h,087h,0c7h,0c7h,0c7h,0e3h,0e0h	; bf99  ........
	defb 080h,080h,081h,081h,083h,0c7h,0ffh,0feh	; bfa1  ........
	defb 0fbh,0f3h,0f3h,0f7h,0e7h,0c7h,08fh,00fh	; bfa9  ........
	defb 0c7h,0c7h,0c7h,087h,087h,087h,007h,007h	; bfb1  ........
	defb 078h,078h,079h,0f1h,0f3h,0f7h,0e7h,0efh	; bfb9  xxy.....
	defb 070h,0f0h,0ffh,0ffh,0ffh,080h,080h,000h	; bfc1  p.......
	defb 0e3h,0e3h,0e3h,0e7h,0e7h,0e7h,0efh,0efh	; bfc9  ........
	defb 0ceh,0ceh,0cfh,08fh,08fh,08fh,00fh,00fh	; bfd1  ........
	defb 0f7h,0e7h,0c7h,0cfh,08fh,08fh,01eh,01eh	; bfd9  ........
	defb 08fh,08fh,08fh,01eh,01eh,01eh,03ch,03ch	; bfe1  ......<<
	defb 007h,008h,017h,014h,017h,014h,008h,007h	; bfe9  ........
	defb 080h,040h,020h,0a0h,020h,0a0h,040h,080h	; bff1  .@ . .@.

; ----------------------------------------------------------------------
; DATOS relleno_p13: 7 bytes a 0xFF hasta el final del banco: espacio libre;
;   lo leen nadie (7 bytes)
;   0xbff9..0xc000  (7 bytes)
DATA_relleno_p13:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff9
