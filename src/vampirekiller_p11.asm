; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 11 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS primera_habitacion_de_cada_fase: 19 bytes: el numero de la primera
;   habitacion de cada fase en la tabla de 0x6013; lo leen p00:4FDC (19 bytes)
;   0x6000..0x6013  (19 bytes)
DATA_primera_habitacion_de_cada_fase:
	defb 000h,003h,00bh,011h,017h,01dh,023h,029h,032h,03ah,043h,04ch,052h,05eh,06ah,072h,07ch,086h,092h	; 6000  ......#)2:CLR^jr|..

; ----------------------------------------------------------------------
; DATOS habitaciones: 156 punteros, uno por habitacion de todo el castillo, a
;   sus 8x6 bloques; lo leen p00:4FEC (312 bytes)
;   0x6013..0x614b  (312 bytes)
DATA_habitaciones:
	defb 07bh,061h	; 6013
	defb 0abh,061h	; 6015
	defb 0dbh,061h	; 6017
	defb 00bh,062h	; 6019
	defb 03bh,062h	; 601b
	defb 06bh,062h	; 601d
	defb 09bh,062h	; 601f
	defb 0cbh,062h	; 6021
	defb 0fbh,062h	; 6023
	defb 02bh,063h	; 6025
	defb 05bh,063h	; 6027
	defb 08bh,063h	; 6029
	defb 0bbh,063h	; 602b
	defb 0ebh,063h	; 602d
	defb 01bh,064h	; 602f
	defb 04bh,064h	; 6031
	defb 07bh,064h	; 6033
	defb 0abh,064h	; 6035
	defb 0dbh,064h	; 6037
	defb 00bh,065h	; 6039
	defb 03bh,065h	; 603b
	defb 06bh,065h	; 603d
	defb 09bh,065h	; 603f
	defb 0cbh,065h	; 6041
	defb 0fbh,065h	; 6043
	defb 02bh,066h	; 6045
	defb 05bh,066h	; 6047
	defb 08bh,066h	; 6049
	defb 0bbh,066h	; 604b
	defb 0ebh,066h	; 604d
	defb 01bh,067h	; 604f
	defb 04bh,067h	; 6051
	defb 07bh,067h	; 6053
	defb 0abh,067h	; 6055
	defb 0dbh,067h	; 6057
	defb 00bh,068h	; 6059
	defb 03bh,068h	; 605b
	defb 06bh,068h	; 605d
	defb 09bh,068h	; 605f
	defb 0cbh,068h	; 6061
	defb 0fbh,068h	; 6063
	defb 02bh,069h	; 6065
	defb 05bh,069h	; 6067
	defb 08bh,069h	; 6069
	defb 0bbh,069h	; 606b
	defb 0ebh,069h	; 606d
	defb 01bh,06ah	; 606f
	defb 04bh,06ah	; 6071
	defb 07bh,06ah	; 6073
	defb 0abh,06ah	; 6075
	defb 0dbh,06ah	; 6077
	defb 00bh,06bh	; 6079
	defb 03bh,06bh	; 607b
	defb 06bh,06bh	; 607d
	defb 09bh,06bh	; 607f
	defb 0cbh,06bh	; 6081
	defb 0fbh,06bh	; 6083
	defb 02bh,06ch	; 6085
	defb 05bh,06ch	; 6087
	defb 08bh,06ch	; 6089
	defb 0bbh,06ch	; 608b
	defb 0ebh,06ch	; 608d
	defb 01bh,06dh	; 608f
	defb 04bh,06dh	; 6091
	defb 07bh,06dh	; 6093
	defb 0abh,06dh	; 6095
	defb 0dbh,06dh	; 6097
	defb 00bh,06eh	; 6099
	defb 03bh,06eh	; 609b
	defb 06bh,06eh	; 609d
	defb 09bh,06eh	; 609f
	defb 0cbh,06eh	; 60a1
	defb 0fbh,06eh	; 60a3
	defb 02bh,06fh	; 60a5
	defb 05bh,06fh	; 60a7
	defb 08bh,06fh	; 60a9
	defb 0bbh,06fh	; 60ab
	defb 0ebh,06fh	; 60ad
	defb 01bh,070h	; 60af
	defb 04bh,070h	; 60b1
	defb 07bh,070h	; 60b3
	defb 0abh,070h	; 60b5
	defb 0dbh,070h	; 60b7
	defb 00bh,071h	; 60b9
	defb 03bh,071h	; 60bb
	defb 06bh,071h	; 60bd
	defb 09bh,071h	; 60bf
	defb 0cbh,071h	; 60c1
	defb 0fbh,071h	; 60c3
	defb 02bh,072h	; 60c5
	defb 05bh,072h	; 60c7
	defb 08bh,072h	; 60c9
	defb 0bbh,072h	; 60cb
	defb 0ebh,072h	; 60cd
	defb 01bh,073h	; 60cf
	defb 04bh,073h	; 60d1
	defb 07bh,073h	; 60d3
	defb 0abh,073h	; 60d5
	defb 0dbh,073h	; 60d7
	defb 00bh,074h	; 60d9
	defb 03bh,074h	; 60db
	defb 06bh,074h	; 60dd
	defb 09bh,074h	; 60df
	defb 0cbh,074h	; 60e1
	defb 0fbh,074h	; 60e3
	defb 02bh,075h	; 60e5
	defb 05bh,075h	; 60e7
	defb 08bh,075h	; 60e9
	defb 0bbh,075h	; 60eb
	defb 0ebh,075h	; 60ed
	defb 01bh,076h	; 60ef
	defb 04bh,076h	; 60f1
	defb 07bh,076h	; 60f3
	defb 0abh,076h	; 60f5
	defb 0dbh,076h	; 60f7
	defb 00bh,077h	; 60f9
	defb 03bh,077h	; 60fb
	defb 06bh,077h	; 60fd
	defb 09bh,077h	; 60ff
	defb 0cbh,077h	; 6101
	defb 0fbh,077h	; 6103
	defb 02bh,078h	; 6105
	defb 05bh,078h	; 6107
	defb 08bh,078h	; 6109
	defb 0bbh,078h	; 610b
	defb 0ebh,078h	; 610d
	defb 01bh,079h	; 610f
	defb 04bh,079h	; 6111
	defb 07bh,079h	; 6113
	defb 0abh,079h	; 6115
	defb 0dbh,079h	; 6117
	defb 00bh,07ah	; 6119
	defb 03bh,07ah	; 611b
	defb 06bh,07ah	; 611d
	defb 09bh,07ah	; 611f
	defb 0cbh,07ah	; 6121
	defb 0fbh,07ah	; 6123
	defb 02bh,07bh	; 6125
	defb 05bh,07bh	; 6127
	defb 08bh,07bh	; 6129
	defb 0bbh,07bh	; 612b
	defb 0ebh,07bh	; 612d
	defb 01bh,07ch	; 612f
	defb 04bh,07ch	; 6131
	defb 07bh,07ch	; 6133
	defb 0abh,07ch	; 6135
	defb 0dbh,07ch	; 6137
	defb 00bh,07dh	; 6139
	defb 03bh,07dh	; 613b
	defb 06bh,07dh	; 613d
	defb 09bh,07dh	; 613f
	defb 0cbh,07dh	; 6141
	defb 0fbh,07dh	; 6143
	defb 02bh,07eh	; 6145
	defb 05bh,07eh	; 6147
	defb 08bh,07eh	; 6149

; ----------------------------------------------------------------------
; DATOS habitacion_especial: la habitacion que se monta con 0xC41A puesto
;   (p00:4FD0): 8 x 6 bloques del juego de 0xA041; lo leen p00:4FD0 (48 bytes)
;   0x614b..0x617b  (48 bytes)
DATA_habitacion_especial:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 614b  ........
	defb 001h,000h,000h,002h,00ah,00bh,00ch,00dh	; 6153  ........
	defb 003h,004h,005h,006h,00eh,00fh,010h,011h	; 615b  ........
	defb 007h,008h,009h,007h,007h,012h,013h,007h	; 6163  ........
	defb 014h,015h,016h,017h,01ch,01dh,01eh,01fh	; 616b  ........
	defb 018h,019h,01ah,01bh,020h,021h,022h,023h	; 6173  .... !"#

; ----------------------------------------------------------------------
; DATOS habitacion_0: fase 0, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x7EE1; lo leen p00:4FF9 (48 bytes)
;   0x617b..0x61ab  (48 bytes)
DATA_habitacion_0:
	defb 000h,001h,000h,001h,000h,001h,000h,001h	; 617b  ........
	defb 002h,003h,002h,003h,002h,003h,002h,003h	; 6183  ........
	defb 004h,005h,004h,005h,004h,005h,004h,005h	; 618b  ........
	defb 008h,00fh,00ah,007h,006h,00bh,009h,007h	; 6193  ........
	defb 00ch,010h,00eh,00dh,00dh,00dh,00eh,00ch	; 619b  ........
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 61a3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_1: fase 0, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x7EE1; lo leen p00:4FF9 (48 bytes)
;   0x61ab..0x61db  (48 bytes)
DATA_habitacion_1:
	defb 000h,001h,000h,001h,000h,001h,000h,001h	; 61ab  ........
	defb 002h,003h,002h,003h,002h,003h,002h,003h	; 61b3  ........
	defb 004h,005h,004h,005h,004h,005h,004h,005h	; 61bb  ........
	defb 008h,00fh,00ah,007h,006h,00bh,009h,007h	; 61c3  ........
	defb 00ch,010h,00eh,00dh,00dh,00dh,00eh,00ch	; 61cb  ........
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 61d3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_2: fase 0, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x7EE1; lo leen p00:4FF9 (48 bytes)
;   0x61db..0x620b  (48 bytes)
DATA_habitacion_2:
	defb 000h,001h,000h,001h,000h,011h,012h,012h	; 61db  ........
	defb 002h,003h,002h,003h,002h,013h,014h,015h	; 61e3  ........
	defb 004h,005h,004h,005h,004h,016h,017h,018h	; 61eb  ........
	defb 008h,00fh,009h,007h,006h,016h,017h,018h	; 61f3  ........
	defb 00ch,010h,00eh,00ch,00ch,019h,01ah,01bh	; 61fb  ........
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 6203  ........

; ----------------------------------------------------------------------
; DATOS habitacion_3: fase 1, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x620b..0x623b  (48 bytes)
DATA_habitacion_3:
	defb 00bh,01ah,000h,001h,00bh,01bh,000h,002h	; 620b  ........
	defb 009h,01bh,000h,002h,009h,01eh,000h,000h	; 6213  ........
	defb 009h,01dh,018h,000h,009h,001h,018h,000h	; 621b  ........
	defb 009h,01ch,018h,000h,009h,002h,018h,000h	; 6223  ........
	defb 009h,01eh,018h,000h,009h,000h,018h,000h	; 622b  ........
	defb 00ah,003h,003h,003h,00ah,003h,003h,003h	; 6233  ........

; ----------------------------------------------------------------------
; DATOS habitacion_4: fase 1, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x623b..0x626b  (48 bytes)
DATA_habitacion_4:
	defb 00bh,01ah,000h,001h,006h,00eh,000h,002h	; 623b  ........
	defb 009h,01bh,018h,018h,000h,006h,00eh,000h	; 6243  ........
	defb 009h,01dh,018h,018h,000h,010h,015h,013h	; 624b  ........
	defb 009h,01ch,002h,010h,012h,007h,008h,001h	; 6253  ........
	defb 02ah,01eh,00fh,007h,000h,000h,009h,002h	; 625b  *.......
	defb 00ah,012h,014h,003h,003h,003h,019h,003h	; 6263  ........

; ----------------------------------------------------------------------
; DATOS habitacion_5: fase 1, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x626b..0x629b  (48 bytes)
DATA_habitacion_5:
	defb 001h,009h,01bh,000h,000h,000h,002h,000h	; 626b  ........
	defb 002h,009h,01eh,000h,018h,000h,000h,010h	; 6273  ........
	defb 003h,00ah,011h,000h,018h,000h,00fh,007h	; 627b  ........
	defb 000h,008h,015h,013h,003h,012h,007h,001h	; 6283  ........
	defb 000h,009h,002h,02ch,02fh,000h,000h,002h	; 628b  ...,/...
	defb 003h,019h,003h,02ch,003h,003h,003h,003h	; 6293  ...,....

; ----------------------------------------------------------------------
; DATOS habitacion_6: fase 1, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x629b..0x62cb  (48 bytes)
DATA_habitacion_6:
	defb 002h,000h,00fh,007h,000h,001h,00bh,01ah	; 629b  ........
	defb 003h,012h,014h,011h,000h,002h,009h,01bh	; 62a3  ........
	defb 008h,002h,000h,006h,00eh,000h,009h,01dh	; 62ab  ........
	defb 009h,003h,003h,010h,015h,013h,02bh,01ch	; 62b3  ......+.
	defb 02ah,000h,00fh,007h,000h,002h,009h,01eh	; 62bb  *.......
	defb 00ah,012h,014h,003h,003h,003h,00ah,003h	; 62c3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_7: fase 1, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x62cb..0x62fb  (48 bytes)
DATA_habitacion_7:
	defb 02ch,000h,00bh,000h,000h,000h,002h,00bh	; 62cb  ,.......
	defb 02ch,003h,009h,003h,011h,000h,001h,009h	; 62d3  ,.......
	defb 02ch,000h,009h,002h,006h,00eh,002h,009h	; 62db  ,.......
	defb 02ch,003h,019h,003h,001h,006h,013h,019h	; 62e3  ,.......
	defb 02ch,002h,008h,000h,002h,000h,000h,008h	; 62eb  ,.......
	defb 02ch,003h,00ah,003h,003h,003h,003h,00ah	; 62f3  ,.......

; ----------------------------------------------------------------------
; DATOS habitacion_8: fase 1, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x62fb..0x632b  (48 bytes)
DATA_habitacion_8:
	defb 000h,00bh,01bh,000h,001h,000h,00bh,01ah	; 62fb  ........
	defb 001h,009h,01dh,018h,018h,000h,009h,01bh	; 6303  ........
	defb 002h,02ah,01eh,018h,018h,000h,009h,01dh	; 630b  .*......
	defb 003h,00ah,011h,002h,000h,001h,009h,01eh	; 6313  ........
	defb 000h,002h,006h,00eh,000h,002h,02bh,000h	; 631b  ......+.
	defb 003h,003h,003h,015h,013h,011h,00ah,003h	; 6323  ........

; ----------------------------------------------------------------------
; DATOS habitacion_9: fase 1, habitacion 6: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x632b..0x635b  (48 bytes)
DATA_habitacion_9:
	defb 000h,002h,00bh,01ah,000h,001h,000h,001h	; 632b  ........
	defb 001h,000h,009h,01bh,000h,018h,000h,018h	; 6333  ........
	defb 018h,000h,009h,01dh,001h,018h,000h,018h	; 633b  ........
	defb 018h,001h,009h,01ch,002h,010h,003h,003h	; 6343  ........
	defb 018h,002h,009h,01eh,00fh,007h,002h,000h	; 634b  ........
	defb 003h,003h,00ah,012h,014h,003h,003h,003h	; 6353  ........

; ----------------------------------------------------------------------
; DATOS habitacion_10: fase 1, habitacion 7: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x635b..0x638b  (48 bytes)
DATA_habitacion_10:
	defb 00bh,01ah,000h,001h,000h,000h,001h,02ch	; 635b  .......,
	defb 009h,01bh,001h,018h,000h,000h,002h,030h	; 6363  .......0
	defb 02bh,01eh,002h,018h,000h,010h,003h,01fh	; 636b  +.......
	defb 019h,003h,003h,003h,012h,007h,001h,02ch	; 6373  .......,
	defb 008h,002h,000h,000h,002h,000h,002h,02ch	; 637b  .......,
	defb 00ah,003h,010h,003h,003h,003h,003h,02ch	; 6383  .......,

; ----------------------------------------------------------------------
; DATOS habitacion_11: fase 2, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x638b..0x63bb  (48 bytes)
DATA_habitacion_11:
	defb 008h,022h,021h,036h,03ch,022h,022h,009h	; 638b  ."!6<"".
	defb 009h,020h,036h,03ch,020h,024h,024h,019h	; 6393  . 6< $$.
	defb 019h,03bh,026h,020h,021h,028h,028h,02ch	; 639b  .;& !((,
	defb 009h,021h,020h,039h,024h,024h,024h,02ch	; 63a3  .! 9$$$,
	defb 02ah,020h,036h,03ch,028h,028h,028h,02ch	; 63ab  * 6<(((,
	defb 00ah,03fh,026h,024h,024h,024h,024h,02ch	; 63b3  .?&$$$$,

; ----------------------------------------------------------------------
; DATOS habitacion_12: fase 2, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x63bb..0x63eb  (48 bytes)
DATA_habitacion_12:
	defb 022h,022h,022h,022h,008h,022h,022h,02ch	; 63bb  """"."",
	defb 026h,025h,021h,020h,009h,023h,020h,030h	; 63c3  &%! .# 0
	defb 02ch,028h,020h,020h,009h,021h,024h,01fh	; 63cb  ,(  .!$.
	defb 02ch,024h,024h,024h,019h,038h,023h,023h	; 63d3  ,$$$.8##
	defb 02ch,028h,028h,028h,009h,03dh,032h,021h	; 63db  ,(((.=2!
	defb 02ch,024h,024h,024h,00ah,026h,039h,03ah	; 63e3  ,$$$.&9:

; ----------------------------------------------------------------------
; DATOS habitacion_13: fase 2, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x63eb..0x641b  (48 bytes)
DATA_habitacion_13:
	defb 020h,008h,020h,021h,02ch,02ch,008h,020h	; 63eb   . !,,.
	defb 020h,009h,03dh,03ch,02ch,028h,02bh,03ch	; 63f3   .=<,(+<
	defb 025h,019h,024h,024h,02ch,024h,019h,024h	; 63fb  %.$$,$.$
	defb 022h,022h,020h,022h,022h,021h,022h,022h	; 6403  "" ""!""
	defb 024h,025h,024h,024h,039h,024h,025h,026h	; 640b  $%$$9$%&
	defb 023h,023h,023h,036h,03ch,023h,023h,023h	; 6413  ###6<###

; ----------------------------------------------------------------------
; DATOS habitacion_14: fase 2, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x641b..0x644b  (48 bytes)
DATA_habitacion_14:
	defb 021h,008h,020h,020h,020h,008h,020h,03dh	; 641b  !.   . =
	defb 020h,009h,020h,020h,021h,009h,03dh,03ch	; 6423   .  !.=<
	defb 026h,019h,038h,020h,025h,019h,024h,024h	; 642b  &.8 %.$$
	defb 022h,022h,03dh,032h,022h,022h,022h,03dh	; 6433  ""=2"""=
	defb 025h,026h,03ch,03dh,032h,03dh,026h,024h	; 643b  %&<=2=&$
	defb 023h,023h,025h,026h,025h,03ah,023h,023h	; 6443  ##%&%:##

; ----------------------------------------------------------------------
; DATOS habitacion_15: fase 2, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x644b..0x647b  (48 bytes)
DATA_habitacion_15:
	defb 02ch,033h,030h,008h,030h,030h,008h,022h	; 644b  ,30.00."
	defb 02ch,03dh,033h,02ah,030h,030h,02bh,021h	; 6453  ,=3*00+!
	defb 02ch,021h,03dh,029h,030h,030h,009h,03ch	; 645b  ,!=)00.<
	defb 029h,034h,034h,02bh,034h,030h,029h,040h	; 6463  )44+40)@
	defb 02ah,035h,035h,02ah,035h,031h,02ah,041h	; 646b  *55*51*A
	defb 03eh,03eh,03eh,03eh,03eh,03eh,03eh,03eh	; 6473  >>>>>>>>

; ----------------------------------------------------------------------
; DATOS habitacion_16: fase 2, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x647b..0x64ab  (48 bytes)
DATA_habitacion_16:
	defb 022h,008h,022h,022h,020h,022h,036h,02ch	; 647b  "."" "6,
	defb 03ch,009h,03ch,021h,020h,036h,03ch,02ch	; 6483  <.<! 6<,
	defb 03dh,02ah,03ch,020h,036h,03ch,021h,02ch	; 648b  =*< 6<!,
	defb 040h,029h,02dh,03bh,02eh,040h,02dh,02ch	; 6493  @)-;.@-,
	defb 041h,02ah,031h,031h,031h,031h,040h,040h	; 649b  A*1111@@
	defb 03eh,03eh,03eh,03eh,03eh,037h,03eh,03eh	; 64a3  >>>>>7>>

; ----------------------------------------------------------------------
; DATOS habitacion_17: fase 3, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x64ab..0x64db  (48 bytes)
DATA_habitacion_17:
	defb 00bh,002h,000h,000h,000h,001h,000h,00bh	; 64ab  ........
	defb 02bh,000h,010h,003h,000h,018h,000h,009h	; 64b3  +.......
	defb 019h,012h,007h,000h,000h,018h,000h,009h	; 64bb  ........
	defb 009h,002h,003h,003h,011h,002h,001h,009h	; 64c3  ........
	defb 02ah,000h,002h,000h,006h,00eh,002h,02ah	; 64cb  *......*
	defb 00ah,003h,003h,003h,003h,017h,013h,00ah	; 64d3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_18: fase 3, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x64db..0x650b  (48 bytes)
DATA_habitacion_18:
	defb 00bh,01ah,004h,005h,004h,005h,004h,005h	; 64db  ........
	defb 009h,01bh,018h,018h,001h,000h,010h,003h	; 64e3  ........
	defb 009h,01dh,018h,018h,002h,00fh,007h,002h	; 64eb  ........
	defb 009h,01ch,002h,010h,012h,007h,000h,003h	; 64f3  ........
	defb 009h,01eh,00fh,007h,000h,003h,011h,000h	; 64fb  ........
	defb 00ah,012h,014h,003h,003h,003h,015h,013h	; 6503  ........

; ----------------------------------------------------------------------
; DATOS habitacion_19: fase 3, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x650b..0x653b  (48 bytes)
DATA_habitacion_19:
	defb 005h,004h,005h,004h,005h,004h,005h,00bh	; 650b  ........
	defb 003h,003h,003h,003h,003h,003h,003h,009h	; 6513  ........
	defb 002h,000h,000h,002h,02ch,02fh,000h,009h	; 651b  ....,/..
	defb 003h,001h,003h,003h,02ch,003h,003h,019h	; 6523  ....,...
	defb 000h,002h,001h,002h,02ch,02fh,002h,008h	; 652b  ....,/..
	defb 003h,003h,003h,003h,02ch,003h,003h,00ah	; 6533  ....,...

; ----------------------------------------------------------------------
; DATOS habitacion_20: fase 3, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x653b..0x656b  (48 bytes)
DATA_habitacion_20:
	defb 01ah,005h,00bh,004h,005h,00bh,01bh,002h	; 653b  ........
	defb 01bh,005h,009h,004h,005h,02bh,01eh,000h	; 6543  .....+..
	defb 01eh,000h,009h,001h,000h,009h,003h,003h	; 654b  ........
	defb 003h,000h,009h,002h,000h,009h,001h,000h	; 6553  ........
	defb 002h,000h,02ah,000h,000h,02ah,002h,000h	; 655b  ..*..*..
	defb 003h,003h,00ah,003h,003h,00ah,003h,003h	; 6563  ........

; ----------------------------------------------------------------------
; DATOS habitacion_21: fase 3, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x656b..0x659b  (48 bytes)
DATA_habitacion_21:
	defb 02ch,00bh,01ah,002h,000h,00fh,00bh,02ch	; 656b  ,......,
	defb 02ch,009h,01bh,000h,00fh,007h,02bh,02ch	; 6573  ,.....+,
	defb 02ch,019h,01eh,00fh,007h,001h,009h,02ch	; 657b  ,......,
	defb 02ch,009h,012h,016h,000h,002h,009h,027h	; 6583  ,......'
	defb 02ch,009h,002h,006h,00eh,000h,02ah,030h	; 658b  ,.....*0
	defb 02ch,00ah,003h,003h,015h,013h,00ah,02ch	; 6593  ,......,

; ----------------------------------------------------------------------
; DATOS habitacion_22: fase 3, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x80B1; lo leen p00:4FF9 (48 bytes)
;   0x659b..0x65cb  (48 bytes)
DATA_habitacion_22:
	defb 020h,00bh,021h,020h,00bh,020h,020h,00bh	; 659b   .! .  .
	defb 041h,02bh,041h,041h,009h,041h,041h,009h	; 65a3  A+AA.AA.
	defb 041h,009h,041h,041h,02bh,041h,041h,009h	; 65ab  A.AA+AA.
	defb 021h,009h,021h,03dh,009h,03ch,039h,019h	; 65b3  !.!=.<9.
	defb 022h,02ah,022h,022h,009h,03bh,03ch,02ah	; 65bb  "*"".;<*
	defb 025h,00ah,026h,024h,00ah,026h,025h,00ah	; 65c3  %.&$.&%.

; ----------------------------------------------------------------------
; DATOS habitacion_23: fase 4, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x65cb..0x65fb  (48 bytes)
DATA_habitacion_23:
	defb 000h,000h,002h,003h,00eh,002h,003h,000h	; 65cb  ........
	defb 000h,01bh,011h,003h,010h,011h,003h,000h	; 65d3  ........
	defb 000h,006h,029h,004h,006h,002h,004h,000h	; 65db  ..).....
	defb 000h,000h,002h,003h,002h,002h,003h,010h	; 65e3  ........
	defb 010h,002h,011h,003h,002h,029h,003h,002h	; 65eb  .....)..
	defb 005h,029h,006h,004h,029h,006h,004h,005h	; 65f3  .)..)...

; ----------------------------------------------------------------------
; DATOS habitacion_24: fase 4, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x65fb..0x662b  (48 bytes)
DATA_habitacion_24:
	defb 000h,003h,016h,002h,027h,000h,002h,003h	; 65fb  ....'...
	defb 000h,003h,002h,027h,011h,000h,002h,003h	; 6603  ...'....
	defb 000h,004h,00ch,006h,009h,000h,00eh,004h	; 660b  ........
	defb 010h,003h,002h,027h,002h,000h,005h,003h	; 6613  ...'....
	defb 011h,003h,027h,00eh,011h,000h,010h,003h	; 661b  ..'.....
	defb 006h,026h,029h,005h,006h,000h,006h,004h	; 6623  .&).....

; ----------------------------------------------------------------------
; DATOS habitacion_25: fase 4, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x662b..0x665b  (48 bytes)
DATA_habitacion_25:
	defb 00eh,002h,027h,000h,002h,010h,027h,000h	; 662b  ..'...'.
	defb 010h,027h,002h,000h,011h,027h,002h,000h	; 6633  .'...'..
	defb 00ch,006h,029h,000h,00ch,002h,002h,000h	; 663b  ..).....
	defb 010h,002h,003h,010h,002h,009h,005h,000h	; 6643  ........
	defb 002h,029h,003h,002h,027h,00eh,002h,011h	; 664b  .)..'...
	defb 029h,006h,004h,00ch,029h,005h,029h,006h	; 6653  )...).).

; ----------------------------------------------------------------------
; DATOS habitacion_26: fase 4, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x665b..0x668b  (48 bytes)
DATA_habitacion_26:
	defb 000h,002h,002h,003h,002h,010h,003h,002h	; 665b  ........
	defb 00fh,011h,002h,003h,011h,002h,003h,011h	; 6663  ........
	defb 017h,00eh,002h,004h,029h,002h,004h,006h	; 666b  ....)...
	defb 001h,005h,002h,002h,000h,002h,003h,000h	; 6673  ........
	defb 001h,010h,002h,029h,000h,016h,003h,000h	; 667b  ...)....
	defb 01ch,006h,002h,010h,000h,002h,003h,000h	; 6683  ........

; ----------------------------------------------------------------------
; DATOS habitacion_27: fase 4, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x668b..0x66bb  (48 bytes)
DATA_habitacion_27:
	defb 010h,002h,003h,016h,002h,002h,003h,002h	; 668b  ........
	defb 002h,011h,003h,00eh,011h,002h,003h,011h	; 6693  ........
	defb 029h,00eh,003h,010h,006h,002h,004h,029h	; 669b  )......)
	defb 001h,005h,003h,002h,002h,006h,002h,000h	; 66a3  ........
	defb 001h,010h,004h,006h,011h,016h,002h,000h	; 66ab  ........
	defb 001h,002h,003h,010h,009h,029h,00eh,000h	; 66b3  .....)..

; ----------------------------------------------------------------------
; DATOS habitacion_28: fase 4, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x66bb..0x66eb  (48 bytes)
DATA_habitacion_28:
	defb 00eh,003h,002h,010h,002h,003h,010h,000h	; 66bb  ........
	defb 016h,003h,011h,002h,011h,003h,011h,000h	; 66c3  ........
	defb 029h,003h,029h,029h,002h,003h,00eh,000h	; 66cb  ).))....
	defb 001h,003h,010h,002h,009h,003h,010h,000h	; 66d3  ........
	defb 01ch,004h,011h,027h,00eh,004h,011h,000h	; 66db  ...'....
	defb 001h,003h,027h,029h,016h,003h,009h,000h	; 66e3  ..')....

; ----------------------------------------------------------------------
; DATOS habitacion_29: fase 5, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x66eb..0x671b  (48 bytes)
DATA_habitacion_29:
	defb 010h,003h,002h,003h,002h,003h,002h,003h	; 66eb  ........
	defb 011h,003h,011h,003h,011h,003h,011h,003h	; 66f3  ........
	defb 029h,004h,005h,004h,029h,004h,006h,004h	; 66fb  )...)...
	defb 013h,012h,013h,012h,013h,012h,013h,000h	; 6703  ........
	defb 011h,003h,011h,003h,011h,003h,011h,000h	; 670b  ........
	defb 010h,003h,00eh,003h,002h,003h,00eh,000h	; 6713  ........

; ----------------------------------------------------------------------
; DATOS habitacion_30: fase 5, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x671b..0x674b  (48 bytes)
DATA_habitacion_30:
	defb 002h,00eh,002h,010h,002h,00eh,002h,003h	; 671b  ........
	defb 011h,005h,011h,002h,011h,010h,011h,003h	; 6723  ........
	defb 029h,010h,006h,002h,002h,002h,029h,004h	; 672b  ).....).
	defb 013h,012h,013h,008h,013h,012h,013h,012h	; 6733  ........
	defb 011h,003h,011h,003h,011h,004h,011h,003h	; 673b  ........
	defb 002h,003h,002h,003h,002h,003h,002h,003h	; 6743  ........

; ----------------------------------------------------------------------
; DATOS habitacion_31: fase 5, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x674b..0x677b  (48 bytes)
DATA_habitacion_31:
	defb 000h,002h,027h,003h,010h,002h,002h,003h	; 674b  ..'.....
	defb 000h,00ch,011h,003h,011h,029h,011h,003h	; 6753  .....)..
	defb 000h,029h,029h,004h,006h,002h,00eh,004h	; 675b  .)).....
	defb 000h,012h,013h,012h,013h,008h,013h,012h	; 6763  ........
	defb 000h,003h,011h,003h,011h,003h,011h,003h	; 676b  ........
	defb 000h,003h,00eh,003h,016h,003h,002h,003h	; 6773  ........

; ----------------------------------------------------------------------
; DATOS habitacion_32: fase 5, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x677b..0x67ab  (48 bytes)
DATA_habitacion_32:
	defb 00eh,003h,002h,003h,010h,003h,000h,000h	; 677b  ........
	defb 011h,003h,011h,004h,011h,003h,01bh,000h	; 6783  ........
	defb 029h,004h,010h,003h,006h,004h,029h,000h	; 678b  ).....).
	defb 013h,028h,029h,014h,013h,014h,019h,000h	; 6793  .().....
	defb 017h,029h,029h,004h,017h,004h,017h,000h	; 679b  .)).....
	defb 013h,012h,013h,012h,013h,012h,013h,000h	; 67a3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_33: fase 5, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x67ab..0x67db  (48 bytes)
DATA_habitacion_33:
	defb 011h,002h,011h,010h,011h,003h,011h,002h	; 67ab  ........
	defb 002h,011h,002h,011h,002h,003h,010h,011h	; 67b3  ........
	defb 005h,002h,00eh,002h,010h,003h,002h,006h	; 67bb  ........
	defb 013h,028h,010h,002h,002h,014h,013h,012h	; 67c3  .(......
	defb 017h,002h,029h,005h,002h,004h,017h,004h	; 67cb  ..).....
	defb 013h,012h,013h,012h,013h,012h,013h,012h	; 67d3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_34: fase 5, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x67db..0x680b  (48 bytes)
DATA_habitacion_34:
	defb 000h,002h,011h,003h,010h,003h,011h,003h	; 67db  ........
	defb 000h,002h,002h,003h,011h,003h,002h,003h	; 67e3  ........
	defb 00fh,002h,006h,004h,005h,004h,006h,004h	; 67eb  ........
	defb 017h,029h,010h,012h,013h,012h,013h,012h	; 67f3  .)......
	defb 000h,010h,002h,003h,002h,003h,002h,004h	; 67fb  ........
	defb 000h,002h,00bh,007h,013h,007h,013h,014h	; 6803  ........

; ----------------------------------------------------------------------
; DATOS habitacion_35: fase 6, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x680b..0x683b  (48 bytes)
DATA_habitacion_35:
	defb 010h,002h,00eh,002h,027h,002h,002h,000h	; 680b  ....'...
	defb 006h,029h,005h,00ch,029h,029h,029h,000h	; 6813  .)..))).
	defb 002h,002h,028h,002h,002h,010h,002h,00fh	; 681b  ..(.....
	defb 002h,002h,01bh,01bh,002h,00eh,029h,017h	; 6823  ......).
	defb 029h,002h,00eh,002h,00eh,01bh,01bh,000h	; 682b  ).......
	defb 000h,000h,005h,029h,029h,029h,029h,000h	; 6833  ...)))).

; ----------------------------------------------------------------------
; DATOS habitacion_36: fase 6, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x683b..0x686b  (48 bytes)
DATA_habitacion_36:
	defb 002h,012h,013h,012h,013h,012h,013h,012h	; 683b  ........
	defb 002h,004h,017h,004h,017h,004h,017h,004h	; 6843  ........
	defb 01bh,012h,025h,012h,025h,012h,025h,012h	; 684b  ..%.%.%.
	defb 002h,003h,00fh,003h,00fh,003h,00fh,003h	; 6853  ........
	defb 006h,004h,017h,004h,017h,004h,017h,004h	; 685b  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 6863  ........

; ----------------------------------------------------------------------
; DATOS habitacion_37: fase 6, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x686b..0x689b  (48 bytes)
DATA_habitacion_37:
	defb 000h,000h,003h,002h,002h,002h,003h,002h	; 686b  ........
	defb 000h,002h,003h,002h,002h,002h,003h,002h	; 6873  ........
	defb 000h,01bh,007h,002h,002h,02ah,007h,01bh	; 687b  .....*..
	defb 000h,002h,003h,00bh,01bh,002h,003h,002h	; 6883  ........
	defb 000h,00eh,000h,029h,005h,006h,004h,005h	; 688b  ...)....
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 6893  ........

; ----------------------------------------------------------------------
; DATOS habitacion_38: fase 6, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x689b..0x68cb  (48 bytes)
DATA_habitacion_38:
	defb 01ah,01ah,01ah,01ah,01ah,01ah,01ah,000h	; 689b  ........
	defb 013h,012h,013h,012h,013h,028h,002h,000h	; 68a3  .....(..
	defb 01dh,003h,01dh,003h,01dh,002h,00eh,000h	; 68ab  ........
	defb 01eh,003h,01eh,003h,01eh,002h,010h,000h	; 68b3  ........
	defb 01bh,01bh,01bh,01bh,01bh,009h,029h,000h	; 68bb  ......).
	defb 013h,012h,013h,028h,027h,002h,010h,000h	; 68c3  ...('...

; ----------------------------------------------------------------------
; DATOS habitacion_39: fase 6, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x68cb..0x68fb  (48 bytes)
DATA_habitacion_39:
	defb 000h,01ah,01ah,01ah,01ah,01ah,01ah,01ah	; 68cb  ........
	defb 000h,012h,013h,012h,013h,012h,013h,012h	; 68d3  ........
	defb 00fh,003h,01dh,003h,01dh,003h,01dh,003h	; 68db  ........
	defb 017h,003h,01eh,003h,01eh,003h,01eh,003h	; 68e3  ........
	defb 000h,01bh,01bh,01bh,01bh,01bh,01bh,01bh	; 68eb  ........
	defb 000h,012h,013h,012h,013h,012h,013h,012h	; 68f3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_40: fase 6, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x84D1; lo leen p00:4FF9 (48 bytes)
;   0x68fb..0x692b  (48 bytes)
DATA_habitacion_40:
	defb 002h,02bh,018h,02bh,018h,02bh,018h,02bh	; 68fb  .+.+.+.+
	defb 002h,003h,01fh,003h,021h,003h,01fh,003h	; 6903  ....!...
	defb 002h,003h,020h,003h,022h,003h,020h,003h	; 690b  .. .". .
	defb 002h,003h,020h,003h,024h,003h,020h,003h	; 6913  .. .$. .
	defb 000h,004h,020h,003h,023h,003h,020h,004h	; 691b  .. .#. .
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 6923  ........

; ----------------------------------------------------------------------
; DATOS habitacion_41: fase 7, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x692b..0x695b  (48 bytes)
DATA_habitacion_41:
	defb 000h,000h,000h,027h,013h,028h,027h,02bh	; 692b  ...'.('+
	defb 00ch,000h,00ch,02ah,013h,026h,00ch,000h	; 6933  ...*.&..
	defb 01bh,01ah,027h,00bh,013h,000h,00ah,000h	; 693b  ..'.....
	defb 013h,009h,026h,000h,013h,000h,02ah,027h	; 6943  ..&...*'
	defb 013h,010h,011h,012h,013h,000h,00ch,000h	; 694b  ........
	defb 01fh,052h,054h,053h,01fh,01dh,01ch,01ch	; 6953  .RTS....

; ----------------------------------------------------------------------
; DATOS habitacion_42: fase 7, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x695b..0x698b  (48 bytes)
DATA_habitacion_42:
	defb 013h,00ah,02ah,028h,013h,027h,026h,027h	; 695b  ..*(.'&'
	defb 013h,00ah,00ch,026h,013h,02ah,00ch,02ah	; 6963  ...&.*.*
	defb 01bh,01ah,026h,000h,013h,000h,022h,01ah	; 696b  ..&...".
	defb 013h,000h,008h,000h,013h,023h,02bh,000h	; 6973  .....#+.
	defb 013h,000h,01ah,000h,01bh,01ah,00ch,000h	; 697b  ........
	defb 01fh,01dh,01dh,01dh,01fh,01dh,01dh,01dh	; 6983  ........

; ----------------------------------------------------------------------
; DATOS habitacion_43: fase 7, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x698b..0x69bb  (48 bytes)
DATA_habitacion_43:
	defb 01ch,028h,027h,02ah,021h,000h,000h,000h	; 698b  .('*!...
	defb 01ch,027h,028h,02bh,02ah,021h,00ch,000h	; 6993  .'(+*!..
	defb 01ch,00ah,026h,000h,022h,02ch,02dh,02eh	; 699b  ..&.",-.
	defb 01ch,00bh,008h,023h,02bh,02ah,026h,02bh	; 69a3  ...#+*&+
	defb 01ch,00ah,01ah,01ah,000h,010h,011h,012h	; 69ab  ........
	defb 01ch,01ch,01ch,01ch,01ch,052h,054h,053h	; 69b3  .....RTS

; ----------------------------------------------------------------------
; DATOS habitacion_44: fase 7, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x69bb..0x69eb  (48 bytes)
DATA_habitacion_44:
	defb 027h,013h,02bh,02ah,027h,013h,02bh,01ch	; 69bb  '.+*'.+.
	defb 02ah,013h,009h,00ch,02ah,013h,000h,01ch	; 69c3  *...*...
	defb 000h,013h,027h,00bh,000h,013h,000h,01ch	; 69cb  ..'.....
	defb 02fh,01fh,026h,02bh,022h,01bh,01ah,01ch	; 69d3  /.&+"...
	defb 02ah,013h,00ah,023h,02bh,013h,01dh,01ch	; 69db  *..#+...
	defb 01dh,01fh,031h,02fh,01dh,01fh,01ch,01ch	; 69e3  ..1/....

; ----------------------------------------------------------------------
; DATOS habitacion_45: fase 7, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x69eb..0x6a1b  (48 bytes)
DATA_habitacion_45:
	defb 02bh,013h,026h,000h,000h,013h,026h,02bh	; 69eb  +.&...&+
	defb 009h,013h,000h,00ch,000h,013h,000h,00ch	; 69f3  ........
	defb 00ah,013h,02eh,00ah,00bh,01bh,00bh,009h	; 69fb  ........
	defb 00bh,013h,027h,02ah,027h,01fh,02fh,01dh	; 6a03  ..'*'./.
	defb 008h,013h,026h,00ch,028h,013h,02bh,00ch	; 6a0b  ..&.(.+.
	defb 01ch,01ch,01dh,01dh,02fh,01fh,01dh,02fh	; 6a13  ..../../

; ----------------------------------------------------------------------
; DATOS habitacion_46: fase 7, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6a1b..0x6a4b  (48 bytes)
DATA_habitacion_46:
	defb 01ch,02ah,021h,000h,02ah,013h,02bh,02ah	; 6a1b  .*!.*.+*
	defb 01ch,009h,02ah,021h,000h,013h,027h,00bh	; 6a23  ..*!..'.
	defb 01ch,00ah,00bh,02ah,021h,013h,02ah,02bh	; 6a2b  ...*!.*+
	defb 01ch,02ah,027h,01ah,02ch,01bh,027h,00bh	; 6a33  .*'.,.'.
	defb 01ch,02eh,028h,00ch,02ah,013h,010h,012h	; 6a3b  ..(.*...
	defb 01ch,02bh,01ch,01ch,024h,01ch,01ch,01ch	; 6a43  .+..$...

; ----------------------------------------------------------------------
; DATOS habitacion_47: fase 7, habitacion 6: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6a4b..0x6a7b  (48 bytes)
DATA_habitacion_47:
	defb 02ah,013h,027h,026h,000h,013h,003h,01ch	; 6a4b  *.'&....
	defb 000h,013h,02ah,00ch,000h,013h,003h,01ch	; 6a53  ..*.....
	defb 00bh,013h,000h,009h,000h,013h,003h,01eh	; 6a5b  ........
	defb 02fh,01bh,020h,00ah,000h,013h,003h,04fh	; 6a63  /. ....O
	defb 026h,013h,02ah,021h,00bh,01fh,02eh,01ch	; 6a6b  &.*!....
	defb 01dh,013h,000h,02ch,02eh,013h,02bh,01ch	; 6a73  ...,..+.

; ----------------------------------------------------------------------
; DATOS habitacion_48: fase 7, habitacion 7: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6a7b..0x6aab  (48 bytes)
DATA_habitacion_48:
	defb 027h,013h,02bh,000h,02ah,013h,028h,02bh	; 6a7b  '.+.*.(+
	defb 02ah,013h,000h,00ch,008h,013h,02bh,00ch	; 6a83  *.....+.
	defb 000h,013h,00bh,026h,009h,013h,000h,000h	; 6a8b  ...&....
	defb 000h,013h,02bh,000h,00ah,013h,027h,02fh	; 6a93  ..+...'/
	defb 000h,013h,000h,00ch,022h,01bh,026h,00ah	; 6a9b  ....".&.
	defb 01ah,01bh,00ah,02dh,02bh,013h,01dh,01dh	; 6aa3  ...-+...

; ----------------------------------------------------------------------
; DATOS habitacion_49: fase 7, habitacion 8: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6aab..0x6adb  (48 bytes)
DATA_habitacion_49:
	defb 01ch,02bh,009h,02ah,028h,013h,02bh,000h	; 6aab  .+.*(.+.
	defb 01ch,002h,000h,00ch,026h,013h,000h,00ch	; 6ab3  ....&...
	defb 01ch,002h,000h,009h,008h,013h,000h,026h	; 6abb  .......&
	defb 01ch,002h,00ah,022h,01ch,013h,000h,00bh	; 6ac3  ..."....
	defb 01ch,002h,023h,02bh,000h,013h,027h,00ch	; 6acb  ..#+..'.
	defb 01ch,01ch,020h,008h,000h,01bh,02ch,02eh	; 6ad3  .. ...,.

; ----------------------------------------------------------------------
; DATOS habitacion_50: fase 8, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6adb..0x6b0b  (48 bytes)
DATA_habitacion_50:
	defb 013h,02ah,02bh,003h,00fh,00fh,00fh,00fh	; 6adb  .*+.....
	defb 013h,000h,00ch,003h,019h,017h,00fh,00fh	; 6ae3  ........
	defb 013h,02ch,00bh,000h,004h,004h,007h,00fh	; 6aeb  .,......
	defb 013h,02ah,02bh,000h,02ah,00ah,003h,019h	; 6af3  .*+.*...
	defb 01bh,02dh,01ah,01ah,01ah,02ch,01bh,01ah	; 6afb  .-...,..
	defb 013h,026h,00ch,000h,000h,02ah,013h,010h	; 6b03  .&...*..

; ----------------------------------------------------------------------
; DATOS habitacion_51: fase 8, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6b0b..0x6b3b  (48 bytes)
DATA_habitacion_51:
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh	; 6b0b  ........
	defb 00fh,00fh,00fh,017h,017h,017h,00fh,00fh	; 6b13  ........
	defb 00fh,00fh,006h,029h,029h,004h,007h,00fh	; 6b1b  ...))...
	defb 018h,032h,002h,027h,00bh,01ch,001h,017h	; 6b23  .2.'....
	defb 01ah,01ah,01ah,01bh,01bh,01bh,01ah,01ah	; 6b2b  ........
	defb 055h,056h,057h,013h,013h,013h,055h,056h	; 6b33  UVW...UV

; ----------------------------------------------------------------------
; DATOS habitacion_52: fase 8, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6b3b..0x6b6b  (48 bytes)
DATA_habitacion_52:
	defb 00fh,00fh,002h,02ah,021h,026h,013h,01ch	; 6b3b  ...*!&..
	defb 00fh,00fh,002h,027h,02ah,021h,013h,01ch	; 6b43  ...'*!..
	defb 00fh,034h,002h,026h,00ah,022h,01bh,01ch	; 6b4b  .4.&."..
	defb 019h,036h,002h,009h,023h,02bh,013h,01ch	; 6b53  .6..#+..
	defb 01bh,01ah,01ah,02ch,02eh,02ch,01bh,01ch	; 6b5b  ...,.,..
	defb 013h,014h,015h,016h,00ah,02ah,013h,01ch	; 6b63  .....*..

; ----------------------------------------------------------------------
; DATOS habitacion_53: fase 8, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6b6b..0x6b9b  (48 bytes)
DATA_habitacion_53:
	defb 01ch,013h,001h,02ah,02bh,000h,02ah,02bh	; 6b6b  ...*+.*+
	defb 01ch,013h,001h,008h,00ch,000h,00ch,026h	; 6b73  .......&
	defb 01ch,013h,001h,009h,026h,01ah,025h,01ah	; 6b7b  ....&.%.
	defb 01ch,013h,001h,000h,000h,023h,02bh,000h	; 6b83  .....#+.
	defb 01ch,01bh,001h,01ah,01ah,01ah,01ah,008h	; 6b8b  ........
	defb 01ch,013h,001h,000h,00ch,000h,00ch,01ah	; 6b93  ........

; ----------------------------------------------------------------------
; DATOS habitacion_54: fase 8, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6b9b..0x6bcb  (48 bytes)
DATA_habitacion_54:
	defb 02ah,001h,02bh,000h,000h,02ah,013h,01ch	; 6b9b  *.+..*..
	defb 00ch,001h,00ch,008h,00ch,000h,013h,01ch	; 6ba3  ........
	defb 01ah,001h,02ch,00bh,000h,022h,01bh,01ch	; 6bab  ..,.."..
	defb 000h,001h,02ah,02bh,023h,02bh,013h,01ch	; 6bb3  ..*+#+..
	defb 00ah,001h,000h,023h,02bh,000h,01bh,01ch	; 6bbb  ...#+...
	defb 01ah,001h,01ah,01ah,00ch,000h,013h,01ch	; 6bc3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_55: fase 8, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6bcb..0x6bfb  (48 bytes)
DATA_habitacion_55:
	defb 00fh,002h,02ah,02bh,000h,003h,00fh,00fh	; 6bcb  ..*+....
	defb 00fh,002h,00ch,00ah,00ch,003h,00fh,00fh	; 6bd3  ........
	defb 00fh,002h,026h,027h,02bh,003h,00fh,00fh	; 6bdb  ..&'+...
	defb 006h,002h,000h,02ah,000h,003h,019h,035h	; 6be3  ...*...5
	defb 016h,000h,01ah,024h,01ah,01ah,02ch,02eh	; 6beb  ...$..,.
	defb 04fh,057h,00ah,02ah,021h,000h,02ah,02bh	; 6bf3  OW.*!.*+

; ----------------------------------------------------------------------
; DATOS habitacion_56: fase 8, habitacion 6: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6bfb..0x6c2b  (48 bytes)
DATA_habitacion_56:
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,002h	; 6bfb  ........
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,002h	; 6c03  ........
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,002h	; 6c0b  ........
	defb 032h,033h,019h,017h,017h,018h,032h,002h	; 6c13  23....2.
	defb 01ah,01ah,029h,02ch,02eh,01ah,029h,01ah	; 6c1b  ..),..).
	defb 014h,015h,016h,02ah,02bh,014h,015h,016h	; 6c23  ...*+...

; ----------------------------------------------------------------------
; DATOS habitacion_57: fase 8, habitacion 7: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6c2b..0x6c5b  (48 bytes)
DATA_habitacion_57:
	defb 013h,02bh,000h,000h,027h,013h,003h,01ch	; 6c2b  .+..'...
	defb 013h,000h,000h,027h,028h,013h,003h,01eh	; 6c33  ...'(...
	defb 013h,02ch,00bh,02ah,02bh,01bh,003h,04fh	; 6c3b  .,.*+..O
	defb 013h,02ah,02bh,000h,008h,013h,02dh,01ch	; 6c43  .*+...-.
	defb 02dh,024h,01ah,00bh,00ah,013h,026h,01ch	; 6c4b  -$....&.
	defb 028h,027h,030h,02fh,01dh,01fh,01dh,01ch	; 6c53  ('0/....

; ----------------------------------------------------------------------
; DATOS habitacion_58: fase 9, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6c5b..0x6c8b  (48 bytes)
DATA_habitacion_58:
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh	; 6c5b  ........
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh	; 6c63  ........
	defb 00fh,00fh,00fh,032h,033h,035h,018h,019h	; 6c6b  ...235..
	defb 01ah,02ch,02eh,01bh,01bh,01ah,01ah,01ah	; 6c73  .,......
	defb 008h,02ah,02bh,013h,013h,00bh,008h,027h	; 6c7b  .*+....'
	defb 010h,011h,012h,013h,013h,055h,056h,057h	; 6c83  .....UVW

; ----------------------------------------------------------------------
; DATOS habitacion_59: fase 9, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6c8b..0x6cbb  (48 bytes)
DATA_habitacion_59:
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh	; 6c8b  ........
	defb 032h,033h,00fh,00fh,00fh,00fh,00fh,00fh	; 6c93  23......
	defb 04fh,04fh,032h,033h,00fh,017h,00dh,00eh	; 6c9b  OO23....
	defb 01bh,01bh,02dh,02eh,02ch,02dh,01bh,01bh	; 6ca3  ..-.,-..
	defb 013h,013h,026h,02bh,02ah,028h,013h,013h	; 6cab  ..&+*(..
	defb 013h,013h,055h,056h,011h,012h,013h,013h	; 6cb3  ..UV....

; ----------------------------------------------------------------------
; DATOS habitacion_60: fase 9, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6cbb..0x6ceb  (48 bytes)
DATA_habitacion_60:
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh	; 6cbb  ........
	defb 00fh,005h,006h,005h,005h,006h,005h,00fh	; 6cc3  ........
	defb 017h,001h,00ah,02ah,02bh,009h,001h,018h	; 6ccb  ...*+...
	defb 01ah,02ch,01bh,02dh,02eh,01bh,02ch,02dh	; 6cd3  .,.-..,-
	defb 000h,02ah,013h,02bh,000h,013h,02ah,027h	; 6cdb  .*.+..*'
	defb 014h,016h,013h,010h,012h,013h,014h,016h	; 6ce3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_61: fase 9, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6ceb..0x6d1b  (48 bytes)
DATA_habitacion_61:
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh	; 6ceb  ........
	defb 00fh,00fh,034h,035h,00fh,00fh,00fh,00fh	; 6cf3  ..45....
	defb 019h,017h,036h,037h,033h,019h,00fh,00fh	; 6cfb  ..673...
	defb 01bh,029h,01ah,029h,01bh,029h,02eh,02ch	; 6d03  .).).).,
	defb 013h,000h,00ah,00bh,013h,008h,02bh,02ah	; 6d0b  ......+*
	defb 013h,055h,056h,057h,013h,055h,011h,012h	; 6d13  .UVW.U..

; ----------------------------------------------------------------------
; DATOS habitacion_62: fase 9, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6d1b..0x6d4b  (48 bytes)
DATA_habitacion_62:
	defb 00fh,035h,013h,02ah,02bh,000h,01ch,03bh	; 6d1b  .5.*+..;
	defb 032h,037h,013h,000h,00ah,000h,003h,03bh	; 6d23  27.....;
	defb 04fh,04fh,013h,008h,00bh,000h,01ch,03bh	; 6d2b  OO.....;
	defb 02eh,01ah,01bh,02dh,02eh,01ah,01ch,039h	; 6d33  ...-...9
	defb 02bh,000h,013h,026h,02bh,000h,01ch,03dh	; 6d3b  +..&+..=
	defb 055h,057h,013h,027h,00bh,000h,01ch,039h	; 6d43  UW.'...9

; ----------------------------------------------------------------------
; DATOS habitacion_63: fase 9, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6d4b..0x6d7b  (48 bytes)
DATA_habitacion_63:
	defb 040h,049h,040h,03dh,01ch,040h,01ch,01ch	; 6d4b  @I@=.@..
	defb 045h,043h,049h,03dh,01ch,045h,01ch,01ch	; 6d53  ECI=.E..
	defb 040h,044h,040h,039h,050h,040h,03bh,01ch	; 6d5b  @D@9P@;.
	defb 051h,048h,038h,03bh,040h,01ch,03bh,01ch	; 6d63  QH8;@.;.
	defb 040h,046h,049h,03bh,040h,01ch,03bh,01ch	; 6d6b  @FI;@.;.
	defb 01ch,058h,050h,039h,050h,050h,03bh,01ch	; 6d73  .XP9PP;.

; ----------------------------------------------------------------------
; DATOS habitacion_64: fase 9, habitacion 6: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6d7b..0x6dab  (48 bytes)
DATA_habitacion_64:
	defb 01ch,047h,046h,040h,045h,040h,03bh,01ch	; 6d7b  .GF@E@;.
	defb 01ch,044h,040h,040h,040h,040h,03bh,01ch	; 6d83  .D@@@@;.
	defb 01ch,038h,038h,04bh,038h,038h,03bh,01ch	; 6d8b  .88K88;.
	defb 04dh,040h,04bh,047h,040h,040h,03bh,01ch	; 6d93  M@KG@@;.
	defb 04dh,04bh,047h,040h,038h,040h,03bh,01ch	; 6d9b  MKG@8@;.
	defb 01ch,048h,046h,040h,03eh,040h,01ch,01ch	; 6da3  .HF@>@..

; ----------------------------------------------------------------------
; DATOS habitacion_65: fase 9, habitacion 7: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6dab..0x6ddb  (48 bytes)
DATA_habitacion_65:
	defb 013h,040h,013h,044h,047h,013h,045h,013h	; 6dab  .@.DG.E.
	defb 013h,045h,013h,046h,043h,013h,040h,013h	; 6db3  .E.FC.@.
	defb 013h,045h,013h,042h,043h,013h,043h,013h	; 6dbb  .E.BC.C.
	defb 01fh,045h,013h,041h,047h,013h,040h,013h	; 6dc3  .E.AG.@.
	defb 013h,04eh,013h,045h,045h,013h,047h,013h	; 6dcb  .N.EE.G.
	defb 01fh,03eh,01fh,03eh,03eh,01fh,03eh,01ch	; 6dd3  .>.>>.>.

; ----------------------------------------------------------------------
; DATOS habitacion_66: fase 9, habitacion 8: 8 x 6 bloques de 32x32 del juego
;   de 0x8791; lo leen p00:4FF9 (48 bytes)
;   0x6ddb..0x6e0b  (48 bytes)
DATA_habitacion_66:
	defb 01ch,049h,040h,046h,044h,047h,03bh,01ch	; 6ddb  .I@FDG;.
	defb 01ch,046h,049h,040h,040h,042h,03bh,01ch	; 6de3  .FI@@B;.
	defb 01ch,040h,038h,038h,047h,045h,03bh,01ch	; 6deb  .@88GE;.
	defb 01eh,038h,048h,040h,046h,047h,01ch,01ch	; 6df3  .8H@FG..
	defb 04fh,041h,046h,049h,042h,045h,03bh,01ch	; 6dfb  OAFIBE;.
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 6e03  ........

; ----------------------------------------------------------------------
; DATOS habitacion_67: fase 10, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6e0b..0x6e3b  (48 bytes)
DATA_habitacion_67:
	defb 00ah,006h,00bh,000h,001h,00ah,000h,00dh	; 6e0b  ........
	defb 00bh,007h,007h,006h,00bh,006h,00ah,00ah	; 6e13  ........
	defb 003h,003h,007h,007h,007h,007h,006h,00bh	; 6e1b  ........
	defb 005h,005h,007h,007h,001h,000h,007h,007h	; 6e23  ........
	defb 003h,003h,003h,007h,006h,00bh,007h,003h	; 6e2b  ........
	defb 002h,002h,002h,002h,002h,002h,002h,002h	; 6e33  ........

; ----------------------------------------------------------------------
; DATOS habitacion_68: fase 10, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6e3b..0x6e6b  (48 bytes)
DATA_habitacion_68:
	defb 001h,000h,00dh,00dh,031h,006h,00bh,006h	; 6e3b  ....1...
	defb 006h,00bh,004h,00bh,007h,031h,009h,007h	; 6e43  .....1..
	defb 007h,036h,003h,030h,007h,036h,036h,005h	; 6e4b  .6.0.66.
	defb 007h,005h,009h,007h,036h,005h,005h,009h	; 6e53  ....6...
	defb 036h,005h,003h,036h,005h,005h,005h,036h	; 6e5b  6..6...6
	defb 002h,002h,002h,002h,002h,002h,002h,002h	; 6e63  ........

; ----------------------------------------------------------------------
; DATOS habitacion_69: fase 10, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6e6b..0x6e9b  (48 bytes)
DATA_habitacion_69:
	defb 03bh,039h,039h,03ah,038h,039h,039h,038h	; 6e6b  ;99:8998
	defb 006h,01fh,038h,038h,03ah,038h,038h,038h	; 6e73  ..88:888
	defb 007h,006h,03bh,03ah,03ah,03eh,03fh,03bh	; 6e7b  ..;::>?;
	defb 00dh,007h,006h,03dh,03fh,00bh,006h,004h	; 6e83  ...=?...
	defb 003h,000h,00dh,006h,00bh,007h,00dh,003h	; 6e8b  ........
	defb 002h,002h,002h,002h,002h,002h,002h,002h	; 6e93  ........

; ----------------------------------------------------------------------
; DATOS habitacion_70: fase 10, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6e9b..0x6ecb  (48 bytes)
DATA_habitacion_70:
	defb 037h,03ah,01dh,03eh,03fh,00ah,00bh,006h	; 6e9b  7:.>?...
	defb 038h,01dh,00ah,00bh,006h,00bh,007h,007h	; 6ea3  8.......
	defb 03ch,00ah,014h,01ah,036h,007h,007h,007h	; 6eab  <...6...
	defb 004h,015h,007h,007h,00dh,007h,007h,007h	; 6eb3  ........
	defb 003h,007h,007h,007h,006h,000h,00dh,036h	; 6ebb  .......6
	defb 002h,002h,002h,002h,002h,002h,002h,002h	; 6ec3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_71: fase 10, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6ecb..0x6efb  (48 bytes)
DATA_habitacion_71:
	defb 00ah,03bh,038h,03ah,039h,037h,03ah,038h	; 6ecb  .;8:97:8
	defb 006h,00ah,03dh,039h,039h,039h,039h,039h	; 6ed3  ..=99999
	defb 007h,006h,006h,03dh,03bh,03ah,03fh,03dh	; 6edb  ...=;:?=
	defb 00dh,007h,009h,006h,00ah,03dh,00bh,006h	; 6ee3  .....=..
	defb 036h,036h,036h,036h,006h,00bh,007h,036h	; 6eeb  6666...6
	defb 002h,002h,002h,002h,002h,002h,002h,002h	; 6ef3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_72: fase 10, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6efb..0x6f2b  (48 bytes)
DATA_habitacion_72:
	defb 007h,006h,00bh,00bh,031h,006h,00bh,006h	; 6efb  ....1...
	defb 007h,007h,007h,007h,007h,031h,001h,000h	; 6f03  .....1..
	defb 007h,007h,007h,003h,007h,036h,036h,003h	; 6f0b  .....66.
	defb 007h,007h,00dh,00dh,003h,007h,00dh,005h	; 6f13  ........
	defb 036h,005h,003h,036h,000h,001h,00bh,036h	; 6f1b  6..6...6
	defb 002h,002h,002h,002h,002h,002h,002h,002h	; 6f23  ........

; ----------------------------------------------------------------------
; DATOS habitacion_73: fase 10, habitacion 6: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6f2b..0x6f5b  (48 bytes)
DATA_habitacion_73:
	defb 038h,039h,03ah,039h,03ah,03ah,03ah,038h	; 6f2b  89:9:::8
	defb 039h,037h,03ah,03ch,03dh,03bh,03ah,03ah	; 6f33  97:<=;::
	defb 039h,039h,03ch,00ah,00ah,00ah,03dh,03ah	; 6f3b  99<...=:
	defb 03eh,03dh,00ah,00ah,00ah,00bh,006h,03bh	; 6f43  >=.....;
	defb 00bh,006h,00bh,006h,00bh,007h,009h,006h	; 6f4b  ........
	defb 036h,036h,036h,036h,032h,036h,036h,036h	; 6f53  66662666

; ----------------------------------------------------------------------
; DATOS habitacion_74: fase 10, habitacion 7: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6f5b..0x6f8b  (48 bytes)
DATA_habitacion_74:
	defb 039h,039h,039h,039h,037h,03ah,039h,037h	; 6f5b  99997:97
	defb 03ah,038h,039h,03eh,01fh,037h,039h,039h	; 6f63  :89>.799
	defb 03ah,039h,03fh,00ah,00ah,03bh,039h,037h	; 6f6b  :9?..;97
	defb 03eh,03ch,00bh,00bh,006h,00ah,03dh,03eh	; 6f73  ><....=>
	defb 004h,00bh,007h,009h,007h,006h,004h,00bh	; 6f7b  ........
	defb 036h,036h,036h,003h,036h,003h,036h,003h	; 6f83  666.6.6.

; ----------------------------------------------------------------------
; DATOS habitacion_75: fase 10, habitacion 8: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6f8b..0x6fbb  (48 bytes)
DATA_habitacion_75:
	defb 03ah,039h,039h,03ah,03ah,03ah,037h,01ah	; 6f8b  :99:::7.
	defb 039h,039h,037h,037h,03eh,03dh,03fh,01ah	; 6f93  9977>=?.
	defb 038h,039h,038h,03fh,00ah,00ah,00ah,01ah	; 6f9b  898?....
	defb 039h,03fh,03ch,00bh,006h,00bh,006h,01ch	; 6fa3  9?<.....
	defb 03eh,004h,00bh,007h,007h,007h,009h,00ah	; 6fab  >.......
	defb 036h,003h,036h,003h,032h,003h,036h,003h	; 6fb3  6.6.2.6.

; ----------------------------------------------------------------------
; DATOS habitacion_76: fase 11, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6fbb..0x6feb  (48 bytes)
DATA_habitacion_76:
	defb 020h,020h,020h,020h,020h,020h,020h,020h	; 6fbb
	defb 020h,020h,020h,020h,018h,019h,020h,020h	; 6fc3      ..
	defb 018h,019h,02eh,018h,007h,007h,019h,018h	; 6fcb  ........
	defb 027h,027h,02ch,028h,027h,027h,027h,027h	; 6fd3  '',(''''
	defb 029h,02dh,029h,029h,029h,02dh,02dh,029h	; 6fdb  )-)))--)
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 6fe3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_77: fase 11, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x6feb..0x701b  (48 bytes)
DATA_habitacion_77:
	defb 020h,020h,020h,018h,019h,020h,020h,020h	; 6feb     ..
	defb 02ah,020h,018h,007h,007h,019h,020h,020h	; 6ff3  * ....
	defb 02bh,018h,007h,007h,01ah,007h,019h,018h	; 6ffb  +.......
	defb 02ch,028h,028h,027h,027h,027h,028h,01ah	; 7003  ,(('''(.
	defb 029h,02dh,02dh,029h,01ah,01ah,01ah,01ah	; 700b  )--)....
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 7013  ........

; ----------------------------------------------------------------------
; DATOS habitacion_78: fase 11, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x701b..0x704b  (48 bytes)
DATA_habitacion_78:
	defb 020h,020h,020h,018h,019h,020h,020h,02eh	; 701b     ..  .
	defb 018h,019h,018h,007h,007h,02ah,018h,02bh	; 7023  .....*.+
	defb 007h,007h,007h,007h,007h,02bh,007h,02bh	; 702b  .....+.+
	defb 01ah,028h,027h,01ah,028h,02ch,027h,02bh	; 7033  .('.(,'+
	defb 01ah,01ah,01ah,01ah,029h,02dh,02dh,02ch	; 703b  ....)--,
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 7043  ........

; ----------------------------------------------------------------------
; DATOS habitacion_79: fase 11, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x704b..0x707b  (48 bytes)
DATA_habitacion_79:
	defb 020h,020h,02bh,02fh,02fh,02bh,020h,020h	; 704b    +//+
	defb 018h,019h,02bh,025h,026h,02bh,020h,020h	; 7053  ..+%&+
	defb 007h,007h,02bh,018h,01ah,02bh,020h,018h	; 705b  ..+..+ .
	defb 028h,028h,02bh,01ah,028h,02bh,027h,01ah	; 7063  ((+.(+'.
	defb 02dh,029h,02ch,02dh,029h,02ch,01ah,01ah	; 706b  -),-),..
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 7073  ........

; ----------------------------------------------------------------------
; DATOS habitacion_80: fase 11, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x707b..0x70ab  (48 bytes)
DATA_habitacion_80:
	defb 020h,020h,020h,02eh,018h,019h,02bh,025h	; 707b     ...+%
	defb 020h,02ah,018h,02bh,007h,007h,02bh,018h	; 7083   *.+..+.
	defb 019h,02bh,007h,02bh,007h,007h,02bh,007h	; 708b  .+.+..+.
	defb 01ah,02ch,027h,02ch,01ah,027h,02bh,027h	; 7093  .,',.'+'
	defb 01ah,01ah,01ah,01ah,029h,02dh,02ch,029h	; 709b  ....)-,)
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 70a3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_81: fase 11, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x70ab..0x70db  (48 bytes)
DATA_habitacion_81:
	defb 026h,02bh,022h,022h,02bh,025h,026h,01ah	; 70ab  &+""+%&.
	defb 018h,02bh,025h,026h,02bh,020h,018h,01ah	; 70b3  .+%&+ ..
	defb 007h,02bh,018h,019h,02bh,018h,007h,01ah	; 70bb  .+..+...
	defb 027h,02bh,027h,028h,02bh,028h,027h,01ch	; 70c3  '+'(+('.
	defb 02dh,02ch,02dh,02dh,02ch,02dh,02dh,00ah	; 70cb  -,--,--.
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 70d3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_82: fase 12, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x70db..0x710b  (48 bytes)
DATA_habitacion_82:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 70db  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 70e3  ........
	defb 00eh,00eh,00eh,00eh,034h,00eh,00eh,00eh	; 70eb  ....4...
	defb 011h,011h,011h,011h,016h,011h,011h,011h	; 70f3  ........
	defb 00fh,00fh,012h,013h,016h,00fh,033h,01ch	; 70fb  ......3.
	defb 01ch,01ch,01ch,01ch,01ch,01ch,00ah,00ah	; 7103  ........

; ----------------------------------------------------------------------
; DATOS habitacion_83: fase 12, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x710b..0x713b  (48 bytes)
DATA_habitacion_83:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 710b  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 7113  ........
	defb 00eh,00eh,01ah,00eh,00eh,00eh,00eh,00eh	; 711b  ........
	defb 011h,011h,011h,011h,011h,012h,013h,011h	; 7123  ........
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 712b  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 7133  ........

; ----------------------------------------------------------------------
; DATOS habitacion_84: fase 12, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x713b..0x716b  (48 bytes)
DATA_habitacion_84:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 713b  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 7143  ........
	defb 00eh,00eh,00eh,00eh,00eh,00eh,00eh,034h	; 714b  .......4
	defb 011h,011h,011h,011h,011h,011h,011h,016h	; 7153  ........
	defb 01ch,01ch,010h,00fh,012h,013h,00fh,016h	; 715b  ........
	defb 00ah,00ah,00ah,01ch,01ch,01ch,01ch,01ch	; 7163  ........

; ----------------------------------------------------------------------
; DATOS habitacion_85: fase 12, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x716b..0x719b  (48 bytes)
DATA_habitacion_85:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 716b  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 7173  ........
	defb 01ah,00eh,00eh,00eh,00eh,00eh,00eh,00eh	; 717b  ........
	defb 01ah,011h,011h,011h,011h,011h,011h,011h	; 7183  ........
	defb 01ah,00fh,012h,013h,00fh,00fh,00fh,00fh	; 718b  ........
	defb 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 7193  ........

; ----------------------------------------------------------------------
; DATOS habitacion_86: fase 12, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x719b..0x71cb  (48 bytes)
DATA_habitacion_86:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 719b  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 71a3  ........
	defb 034h,00eh,00eh,01ah,00eh,00eh,00eh,00eh	; 71ab  4.......
	defb 016h,011h,011h,011h,011h,012h,013h,011h	; 71b3  ........
	defb 016h,033h,01ch,01ch,01ch,01ch,01ch,01ch	; 71bb  .3......
	defb 01ch,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 71c3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_87: fase 12, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x71cb..0x71fb  (48 bytes)
DATA_habitacion_87:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 71cb  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 71d3  ........
	defb 00eh,01ah,00eh,00eh,00eh,00eh,034h,01ah	; 71db  ......4.
	defb 011h,01ah,011h,011h,011h,011h,016h,01ch	; 71e3  ........
	defb 01ah,00fh,012h,013h,00fh,00fh,016h,00ah	; 71eb  ........
	defb 00ah,01ch,01ch,01ch,01ch,01ch,01ch,01ch	; 71f3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_88: fase 12, habitacion 6: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x71fb..0x722b  (48 bytes)
DATA_habitacion_88:
	defb 00fh,016h,017h,021h,021h,017h,016h,00fh	; 71fb  ...!!...
	defb 00fh,016h,017h,00ah,00ah,017h,016h,00fh	; 7203  ........
	defb 00fh,016h,011h,011h,011h,011h,016h,00fh	; 720b  ........
	defb 00fh,016h,00fh,00fh,00fh,00fh,016h,00fh	; 7213  ........
	defb 00fh,01bh,00fh,00fh,00fh,00fh,01bh,00fh	; 721b  ........
	defb 024h,01bh,024h,024h,024h,024h,01bh,024h	; 7223  $.$$$$.$

; ----------------------------------------------------------------------
; DATOS habitacion_89: fase 12, habitacion 7: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x722b..0x725b  (48 bytes)
DATA_habitacion_89:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 722b  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 7233  ........
	defb 00eh,00eh,00eh,00eh,00eh,00eh,01ah,00eh	; 723b  ........
	defb 00fh,011h,00fh,011h,00fh,011h,00fh,011h	; 7243  ........
	defb 011h,012h,013h,033h,01ch,01ch,01ch,01ch	; 724b  ...3....
	defb 01ch,01ch,01ch,00ah,00ah,00ah,00ah,00ah	; 7253  ........

; ----------------------------------------------------------------------
; DATOS habitacion_90: fase 12, habitacion 8: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x725b..0x728b  (48 bytes)
DATA_habitacion_90:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 725b  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 7263  ........
	defb 00eh,00eh,00eh,00eh,00eh,034h,00eh,00eh	; 726b  .....4..
	defb 011h,00fh,011h,00fh,011h,016h,011h,00fh	; 7273  ........
	defb 01ch,010h,012h,013h,00fh,01ah,00fh,011h	; 727b  ........
	defb 00ah,00ah,01ch,01ch,01ch,01ch,01ch,01ch	; 7283  ........

; ----------------------------------------------------------------------
; DATOS habitacion_91: fase 12, habitacion 9: 8 x 6 bloques de 32x32 del juego
;   de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x728b..0x72bb  (48 bytes)
DATA_habitacion_91:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 728b  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 7293  ........
	defb 00eh,00eh,01ah,00eh,00eh,00eh,00eh,00eh	; 729b  ........
	defb 011h,00fh,011h,00fh,011h,00fh,011h,00fh	; 72a3  ........
	defb 01ch,01ch,01ch,01ch,01ch,01ch,010h,011h	; 72ab  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,01ch	; 72b3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_92: fase 12, habitacion 10: 8 x 6 bloques de 32x32 del
;   juego de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x72bb..0x72eb  (48 bytes)
DATA_habitacion_92:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 72bb  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 72c3  ........
	defb 00eh,00eh,00eh,00eh,034h,00eh,00eh,00eh	; 72cb  ....4...
	defb 011h,00fh,011h,00fh,016h,00fh,011h,00fh	; 72d3  ........
	defb 00fh,012h,013h,011h,016h,033h,01ch,01ch	; 72db  .....3..
	defb 01ch,01ch,01ch,01ch,01ch,00ah,00ah,00ah	; 72e3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_93: fase 12, habitacion 11: 8 x 6 bloques de 32x32 del
;   juego de 0x8D21; lo leen p00:4FF9 (48 bytes)
;   0x72eb..0x731b  (48 bytes)
DATA_habitacion_93:
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 72eb  ........
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 72f3  ........
	defb 00eh,00eh,034h,00eh,00eh,00eh,034h,00eh	; 72fb  ..4...4.
	defb 011h,011h,016h,011h,011h,011h,016h,011h	; 7303  ........
	defb 010h,00fh,01ah,00fh,012h,013h,016h,033h	; 730b  .......3
	defb 00ah,01ch,01ch,01ch,01ch,01ch,01ch,00ah	; 7313  ........

; ----------------------------------------------------------------------
; DATOS habitacion_94: fase 13, habitacion 0: 8 x 6 bloques de 32x32 del juego
;   de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x731b..0x734b  (48 bytes)
DATA_habitacion_94:
	defb 01fh,01fh,01ch,001h,001h,001h,001h,001h	; 731b  ........
	defb 01fh,00dh,000h,01bh,040h,040h,040h,040h	; 7323  ....@@@@
	defb 01fh,045h,043h,043h,043h,043h,043h,043h	; 732b  .ECCCCCC
	defb 01fh,00dh,00eh,00fh,00dh,00eh,00fh,00dh	; 7333  ........
	defb 01fh,048h,010h,011h,048h,04bh,010h,048h	; 733b  .H..HK.H
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 7343  ........

; ----------------------------------------------------------------------
; DATOS habitacion_95: fase 13, habitacion 1: 8 x 6 bloques de 32x32 del juego
;   de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x734b..0x737b  (48 bytes)
DATA_habitacion_95:
	defb 001h,001h,001h,001h,001h,002h,01fh,003h	; 734b  ........
	defb 00dh,00dh,040h,000h,000h,004h,01fh,040h	; 7353  ..@....@
	defb 043h,043h,043h,044h,016h,005h,045h,043h	; 735b  CCCD..EC
	defb 00eh,00fh,00dh,000h,012h,01fh,00eh,00fh	; 7363  ........
	defb 010h,011h,003h,019h,048h,01fh,04bh,011h	; 736b  ....H.K.
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 7373  ........

; ----------------------------------------------------------------------
; DATOS habitacion_96: fase 13, habitacion 2: 8 x 6 bloques de 32x32 del juego
;   de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x737b..0x73ab  (48 bytes)
DATA_habitacion_96:
	defb 001h,001h,001h,001h,019h,003h,002h,01fh	; 737b  ........
	defb 00dh,00dh,000h,018h,000h,040h,040h,01fh	; 7383  .....@@.
	defb 044h,041h,045h,043h,043h,043h,044h,01fh	; 738b  DAECCCD.
	defb 00dh,004h,01bh,000h,00eh,00fh,00dh,01fh	; 7393  ........
	defb 003h,005h,045h,044h,04bh,010h,048h,01fh	; 739b  ..EDK.H.
	defb 01fh,01fh,01eh,01eh,01eh,042h,01eh,01fh	; 73a3  .....B..

; ----------------------------------------------------------------------
; DATOS habitacion_97: fase 13, habitacion 3: 8 x 6 bloques de 32x32 del juego
;   de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x73ab..0x73db  (48 bytes)
DATA_habitacion_97:
	defb 002h,00eh,00fh,003h,001h,002h,00eh,00fh	; 73ab  ........
	defb 000h,011h,04bh,040h,000h,00dh,011h,010h	; 73b3  ..K@....
	defb 01fh,021h,043h,044h,041h,045h,043h,043h	; 73bb  .!CDAECC
	defb 01eh,00ch,00dh,000h,004h,01bh,000h,000h	; 73c3  ........
	defb 002h,00ch,003h,001h,005h,045h,044h,007h	; 73cb  .....ED.
	defb 01fh,01fh,041h,01eh,01eh,01eh,01eh,01eh	; 73d3  ..A.....

; ----------------------------------------------------------------------
; DATOS habitacion_98: fase 13, habitacion 4: 8 x 6 bloques de 32x32 del juego
;   de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x73db..0x740b  (48 bytes)
DATA_habitacion_98:
	defb 048h,00ch,048h,00eh,00fh,048h,00ch,003h	; 73db  H.H..H..
	defb 000h,00ch,000h,010h,010h,004h,00ch,00dh	; 73e3  ........
	defb 043h,044h,01fh,016h,001h,005h,00ch,003h	; 73eb  CD......
	defb 000h,004h,01fh,00dh,01bh,040h,00ch,00dh	; 73f3  .....@..
	defb 001h,005h,048h,01fh,006h,01fh,01fh,007h	; 73fb  ..H.....
	defb 01eh,01eh,01eh,01eh,01eh,01eh,01eh,01eh	; 7403  ........

; ----------------------------------------------------------------------
; DATOS habitacion_99: fase 13, habitacion 5: 8 x 6 bloques de 32x32 del juego
;   de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x740b..0x743b  (48 bytes)
DATA_habitacion_99:
	defb 00eh,00fh,003h,001h,002h,00eh,00fh,003h	; 740b  ........
	defb 010h,010h,00dh,000h,00dh,010h,04bh,000h	; 7413  ......K.
	defb 001h,001h,001h,047h,013h,021h,045h,043h	; 741b  ...G.!EC
	defb 000h,000h,012h,01eh,01eh,00ch,00dh,00dh	; 7423  ........
	defb 046h,019h,007h,046h,002h,00ch,003h,047h	; 742b  F..F...G
	defb 01eh,01eh,01eh,01eh,042h,01eh,01eh,01eh	; 7433  ....B...

; ----------------------------------------------------------------------
; DATOS habitacion_100: fase 13, habitacion 6: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x743b..0x746b  (48 bytes)
DATA_habitacion_100:
	defb 00ch,048h,01ch,001h,002h,01fh,01fh,003h	; 743b  .H......
	defb 00ch,000h,000h,01bh,00dh,01fh,000h,040h	; 7443  .......@
	defb 021h,003h,002h,025h,01fh,01fh,043h,044h	; 744b  !..%..CD
	defb 00ch,00dh,01eh,004h,01fh,000h,00dh,000h	; 7453  ........
	defb 00ch,003h,047h,005h,01fh,01fh,046h,047h	; 745b  ..G...FG
	defb 021h,01eh,01eh,01eh,01eh,01eh,01eh,01eh	; 7463  !.......

; ----------------------------------------------------------------------
; DATOS habitacion_101: fase 13, habitacion 7: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x746b..0x749b  (48 bytes)
DATA_habitacion_101:
	defb 01fh,003h,001h,001h,001h,019h,048h,01fh	; 746b  ......H.
	defb 01fh,040h,000h,040h,018h,000h,040h,01fh	; 7473  .@.@..@.
	defb 01fh,025h,041h,045h,043h,043h,044h,01fh	; 747b  .%AECCD.
	defb 01fh,00dh,049h,01bh,000h,049h,00dh,01fh	; 7483  ..I..I..
	defb 01fh,048h,011h,048h,01bh,04bh,048h,01fh	; 748b  .H.H.KH.
	defb 01fh,01eh,042h,01eh,01eh,01eh,01eh,01fh	; 7493  ..B.....

; ----------------------------------------------------------------------
; DATOS habitacion_102: fase 13, habitacion 8: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x749b..0x74cb  (48 bytes)
DATA_habitacion_102:
	defb 01fh,01fh,001h,002h,00eh,04ah,049h,00fh	; 749b  .....JI.
	defb 01fh,000h,00dh,00dh,010h,010h,011h,04bh	; 74a3  .......K
	defb 01fh,007h,001h,013h,045h,043h,044h,021h	; 74ab  ....ECD!
	defb 020h,01eh,01eh,021h,00dh,00dh,004h,00ch	; 74b3   ..!....
	defb 03fh,007h,006h,00ch,007h,001h,005h,00ch	; 74bb  ?.......
	defb 01eh,01eh,01eh,01eh,01eh,01eh,01eh,01eh	; 74c3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_103: fase 13, habitacion 9: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x74cb..0x74fb  (48 bytes)
DATA_habitacion_103:
	defb 003h,001h,019h,048h,00eh,04ah,049h,00fh	; 74cb  ...H.JI.
	defb 040h,018h,040h,040h,010h,011h,010h,010h	; 74d3  @.@@....
	defb 043h,043h,044h,021h,015h,003h,001h,047h	; 74db  CCD!...G
	defb 00dh,00dh,004h,00ch,01eh,01eh,042h,021h	; 74e3  ......B!
	defb 001h,001h,005h,00ch,003h,019h,048h,00ch	; 74eb  ......H.
	defb 01eh,01eh,01eh,01eh,01eh,01eh,01eh,01eh	; 74f3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_104: fase 13, habitacion 10: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x74fb..0x752b  (48 bytes)
DATA_habitacion_104:
	defb 003h,001h,001h,002h,00eh,049h,00fh,01fh	; 74fb  .....I..
	defb 00dh,000h,00dh,040h,010h,010h,010h,01fh	; 7503  ...@....
	defb 001h,013h,025h,021h,007h,046h,001h,01fh	; 750b  ..%!.F..
	defb 01eh,01eh,004h,00ch,01eh,01eh,01fh,01fh	; 7513  ........
	defb 001h,001h,005h,00ch,003h,001h,006h,01fh	; 751b  ........
	defb 01eh,01eh,01eh,01eh,041h,01eh,01eh,01fh	; 7523  ....A...

; ----------------------------------------------------------------------
; DATOS habitacion_105: fase 13, habitacion 11: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x752b..0x755b  (48 bytes)
DATA_habitacion_105:
	defb 01fh,01fh,001h,002h,01ch,001h,002h,01fh	; 752b  ........
	defb 01fh,040h,000h,00dh,040h,01bh,040h,01fh	; 7533  .@..@.@.
	defb 01fh,025h,007h,002h,045h,044h,021h,01fh	; 753b  .%..ED!.
	defb 01fh,00dh,01eh,015h,000h,004h,00ch,01fh	; 7543  ........
	defb 01fh,003h,001h,006h,01ch,005h,00ch,01fh	; 754b  ........
	defb 01fh,01eh,041h,01eh,01eh,01eh,01fh,01fh	; 7553  ..A.....

; ----------------------------------------------------------------------
; DATOS habitacion_106: fase 14, habitacion 0: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x755b..0x758b  (48 bytes)
DATA_habitacion_106:
	defb 01fh,008h,00bh,014h,00ch,031h,033h,01fh	; 755b  .....13.
	defb 01fh,008h,01ah,008h,00ch,032h,033h,01fh	; 7563  .....23.
	defb 01fh,022h,022h,017h,00ch,008h,009h,01fh	; 756b  ."".....
	defb 01fh,009h,00bh,014h,021h,022h,022h,01fh	; 7573  ....!"".
	defb 01fh,008h,01ah,009h,00ch,00ah,00ah,01fh	; 757b  ........
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 7583  ........

; ----------------------------------------------------------------------
; DATOS habitacion_107: fase 14, habitacion 1: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x758b..0x75bb  (48 bytes)
DATA_habitacion_107:
	defb 035h,035h,00ch,031h,032h,033h,031h,01fh	; 758b  55.1231.
	defb 036h,036h,00ch,008h,009h,008h,009h,01fh	; 7593  66......
	defb 030h,030h,00ch,008h,022h,009h,008h,01fh	; 759b  00.."...
	defb 022h,022h,022h,009h,008h,022h,022h,01fh	; 75a3  """.."".
	defb 008h,00bh,008h,00bh,008h,00bh,008h,01fh	; 75ab  ........
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 75b3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_108: fase 14, habitacion 2: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x75bb..0x75eb  (48 bytes)
DATA_habitacion_108:
	defb 01fh,00ch,033h,032h,031h,032h,01fh,035h	; 75bb  ..3212.5
	defb 01fh,00ch,031h,032h,033h,031h,01fh,036h	; 75c3  ..1231.6
	defb 01fh,00ch,008h,008h,014h,022h,022h,030h	; 75cb  .....""0
	defb 01fh,00ch,008h,01ah,009h,00bh,009h,022h	; 75d3  ......."
	defb 01fh,00ch,01fh,008h,008h,009h,008h,009h	; 75db  ........
	defb 01fh,00ch,01fh,01fh,01fh,01fh,01fh,01fh	; 75e3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_109: fase 14, habitacion 3: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x75eb..0x761b  (48 bytes)
DATA_habitacion_109:
	defb 00ch,00bh,009h,00bh,009h,00bh,00ch,01fh	; 75eb  ........
	defb 00ch,008h,009h,008h,008h,009h,00ch,01fh	; 75f3  ........
	defb 02ch,02ch,022h,022h,03dh,020h,020h,01fh	; 75fb  ,,""=  .
	defb 035h,035h,009h,01ah,031h,032h,033h,01fh	; 7603  55..123.
	defb 030h,030h,01ah,031h,033h,032h,031h,01fh	; 760b  00.1321.
	defb 01fh,01fh,01fh,023h,01fh,01fh,01fh,01fh	; 7613  ...#....

; ----------------------------------------------------------------------
; DATOS habitacion_110: fase 14, habitacion 4: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x761b..0x764b  (48 bytes)
DATA_habitacion_110:
	defb 00ch,00bh,009h,00bh,00ch,00bh,008h,00bh	; 761b  ........
	defb 00ch,009h,008h,008h,00ch,009h,009h,008h	; 7623  ........
	defb 020h,03eh,022h,022h,022h,01fh,022h,022h	; 762b   >""".""
	defb 031h,032h,02ah,009h,009h,01fh,009h,008h	; 7633  12*.....
	defb 033h,031h,032h,01fh,009h,01fh,008h,009h	; 763b  312.....
	defb 01fh,01fh,01fh,01fh,009h,01fh,01fh,01fh	; 7643  ........

; ----------------------------------------------------------------------
; DATOS habitacion_111: fase 14, habitacion 5: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x764b..0x767b  (48 bytes)
DATA_habitacion_111:
	defb 008h,00ch,034h,034h,00ch,00bh,01fh,00bh	; 764b  ..44....
	defb 008h,00ch,035h,035h,00ch,009h,01fh,009h	; 7653  ..55....
	defb 008h,00ch,036h,036h,00ch,022h,022h,020h	; 765b  ..66.""
	defb 022h,021h,03fh,03fh,021h,017h,009h,032h	; 7663  "!??!..2
	defb 008h,00ch,030h,030h,00ch,00ah,01dh,033h	; 766b  ..00...3
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 7673  ........

; ----------------------------------------------------------------------
; DATOS habitacion_112: fase 14, habitacion 6: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x767b..0x76ab  (48 bytes)
DATA_habitacion_112:
	defb 049h,04ah,008h,049h,04ah,008h,049h,04ah	; 767b  IJ.IJ.IJ
	defb 010h,011h,00bh,010h,011h,00bh,011h,010h	; 7683  ........
	defb 009h,009h,008h,022h,009h,008h,009h,009h	; 768b  ..."....
	defb 022h,022h,01fh,017h,009h,009h,008h,022h	; 7693  ""....."
	defb 00ah,009h,01fh,009h,01dh,009h,008h,009h	; 769b  ........
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 76a3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_113: fase 14, habitacion 7: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x76ab..0x76db  (48 bytes)
DATA_habitacion_113:
	defb 01fh,009h,049h,04ah,009h,049h,04ah,008h	; 76ab  ..IJ.IJ.
	defb 01fh,00bh,010h,011h,00bh,010h,04bh,00bh	; 76b3  ......K.
	defb 01fh,022h,052h,022h,022h,022h,022h,008h	; 76bb  ."R"""".
	defb 020h,008h,009h,01dh,009h,009h,009h,022h	; 76c3   ......"
	defb 03fh,00ah,00ah,00ah,01dh,009h,008h,008h	; 76cb  ?.......
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 76d3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_114: fase 15, habitacion 0: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x76db..0x770b  (48 bytes)
DATA_habitacion_114:
	defb 049h,04ah,009h,009h,008h,014h,01fh,01fh	; 76db  IJ......
	defb 010h,011h,008h,00bh,01ah,00bh,009h,01fh	; 76e3  ........
	defb 01eh,01eh,01eh,01eh,01eh,01eh,01fh,01fh	; 76eb  ........
	defb 049h,00fh,00dh,000h,00dh,000h,00dh,020h	; 76f3  I......
	defb 04bh,011h,040h,040h,000h,00eh,00fh,03fh	; 76fb  K.@@...?
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 7703  ........

; ----------------------------------------------------------------------
; DATOS habitacion_115: fase 15, habitacion 1: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x770b..0x773b  (48 bytes)
DATA_habitacion_115:
	defb 01fh,008h,049h,04ah,04ah,008h,008h,008h	; 770b  ..IJJ...
	defb 01fh,008h,010h,010h,011h,008h,00bh,008h	; 7713  ........
	defb 01fh,01eh,041h,01eh,01eh,008h,008h,01eh	; 771b  ..A.....
	defb 01fh,00eh,00fh,01bh,000h,00dh,01eh,00eh	; 7723  ........
	defb 01fh,010h,011h,00dh,01bh,040h,040h,010h	; 772b  .....@@.
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 7733  ........

; ----------------------------------------------------------------------
; DATOS habitacion_116: fase 15, habitacion 2: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x773b..0x776b  (48 bytes)
DATA_habitacion_116:
	defb 028h,028h,027h,028h,028h,02fh,01fh,01fh	; 773b  (('((/..
	defb 028h,028h,027h,028h,02fh,028h,028h,01fh	; 7743  (('(/((.
	defb 022h,022h,022h,022h,022h,022h,022h,022h	; 774b  """"""""
	defb 008h,00bh,009h,00bh,008h,00bh,009h,00bh	; 7753  ........
	defb 00ah,00ah,00ah,009h,008h,009h,009h,008h	; 775b  ........
	defb 01fh,01fh,01fh,01fh,01fh,023h,01fh,01fh	; 7763  .....#..

; ----------------------------------------------------------------------
; DATOS habitacion_117: fase 15, habitacion 3: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x776b..0x779b  (48 bytes)
DATA_habitacion_117:
	defb 01fh,028h,027h,028h,028h,028h,027h,028h	; 776b  .('((('(
	defb 01fh,028h,027h,028h,028h,028h,027h,028h	; 7773  .('((('(
	defb 01fh,022h,008h,008h,008h,014h,022h,022h	; 777b  ."....""
	defb 008h,00bh,008h,00bh,01ah,00bh,008h,00bh	; 7783  ........
	defb 008h,00ah,00ah,022h,00ah,008h,008h,008h	; 778b  ..."....
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 7793  ........

; ----------------------------------------------------------------------
; DATOS habitacion_118: fase 15, habitacion 4: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x779b..0x77cb  (48 bytes)
DATA_habitacion_118:
	defb 027h,028h,028h,02fh,028h,028h,027h,028h	; 779b  '((/(('(
	defb 027h,028h,02fh,028h,028h,028h,027h,028h	; 77a3  '(/((('(
	defb 027h,050h,050h,028h,028h,050h,027h,028h	; 77ab  'PP((P'(
	defb 027h,028h,02dh,050h,050h,028h,027h,028h	; 77b3  '(-PP('(
	defb 027h,02fh,028h,028h,028h,028h,027h,028h	; 77bb  '/(((('(
	defb 01fh,01fh,01fh,01fh,01fh,023h,01fh,01fh	; 77c3  .....#..

; ----------------------------------------------------------------------
; DATOS habitacion_119: fase 15, habitacion 5: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x77cb..0x77fb  (48 bytes)
DATA_habitacion_119:
	defb 027h,028h,028h,028h,028h,028h,027h,028h	; 77cb  '((((('(
	defb 027h,028h,028h,028h,028h,028h,027h,028h	; 77d3  '((((('(
	defb 027h,028h,028h,028h,028h,028h,027h,028h	; 77db  '((((('(
	defb 027h,01fh,028h,050h,028h,01fh,027h,028h	; 77e3  '.(P(.'(
	defb 027h,01fh,028h,028h,028h,01fh,027h,028h	; 77eb  '.(((.'(
	defb 01fh,01fh,028h,028h,028h,01fh,01fh,01fh	; 77f3  ..(((...

; ----------------------------------------------------------------------
; DATOS habitacion_120: fase 15, habitacion 6: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x77fb..0x782b  (48 bytes)
DATA_habitacion_120:
	defb 028h,028h,027h,028h,028h,028h,028h,01fh	; 77fb  (('((((.
	defb 028h,028h,027h,028h,028h,028h,028h,01fh	; 7803  (('((((.
	defb 037h,038h,027h,028h,03bh,038h,028h,01fh	; 780b  78'(;8(.
	defb 039h,03ah,027h,028h,039h,03ah,028h,01fh	; 7813  9:'(9:(.
	defb 028h,028h,027h,028h,028h,028h,028h,01fh	; 781b  (('((((.
	defb 01fh,01fh,01fh,028h,01fh,01fh,01fh,01fh	; 7823  ...(....

; ----------------------------------------------------------------------
; DATOS habitacion_121: fase 15, habitacion 7: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x782b..0x785b  (48 bytes)
DATA_habitacion_121:
	defb 028h,028h,027h,028h,028h,028h,028h,027h	; 782b  (('(((('
	defb 028h,028h,027h,028h,028h,028h,028h,027h	; 7833  (('(((('
	defb 03bh,038h,027h,028h,037h,038h,028h,027h	; 783b  ;8'(78('
	defb 039h,03ah,027h,028h,039h,03ah,028h,027h	; 7843  9:'(9:('
	defb 028h,028h,027h,028h,028h,028h,028h,027h	; 784b  (('(((('
	defb 01fh,01fh,01fh,023h,01fh,01fh,01fh,01fh	; 7853  ...#....

; ----------------------------------------------------------------------
; DATOS habitacion_122: fase 15, habitacion 8: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x785b..0x788b  (48 bytes)
DATA_habitacion_122:
	defb 01fh,027h,028h,028h,028h,028h,028h,027h	; 785b  .'((((('
	defb 01fh,027h,028h,028h,028h,028h,028h,027h	; 7863  .'((((('
	defb 01fh,027h,037h,038h,028h,03bh,038h,027h	; 786b  .'78(;8'
	defb 020h,027h,039h,03ah,028h,039h,03ah,027h	; 7873   '9:(9:'
	defb 03fh,027h,028h,028h,028h,028h,028h,027h	; 787b  ?'((((('
	defb 01fh,01fh,01fh,028h,01fh,01fh,01fh,01fh	; 7883  ...(....

; ----------------------------------------------------------------------
; DATOS habitacion_123: fase 15, habitacion 9: 8 x 6 bloques de 32x32 del
;   juego de 0x9121; lo leen p00:4FF9 (48 bytes)
;   0x788b..0x78bb  (48 bytes)
DATA_habitacion_123:
	defb 027h,028h,027h,028h,028h,027h,028h,027h	; 788b  '('(('('
	defb 027h,028h,027h,03bh,038h,027h,028h,027h	; 7893  '(';8'('
	defb 027h,028h,027h,039h,03ah,027h,028h,027h	; 789b  '('9:'('
	defb 051h,028h,027h,028h,028h,027h,028h,051h	; 78a3  Q('(('(Q
	defb 027h,02dh,050h,050h,050h,050h,02eh,027h	; 78ab  '-PPPP.'
	defb 01fh,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 78b3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_124: fase 16, habitacion 0: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x78bb..0x78eb  (48 bytes)
DATA_habitacion_124:
	defb 010h,010h,010h,010h,010h,010h,006h,005h	; 78bb  ........
	defb 010h,010h,010h,000h,006h,011h,005h,001h	; 78c3  ........
	defb 010h,010h,010h,001h,011h,005h,005h,005h	; 78cb  ........
	defb 00ah,00ah,00ah,017h,006h,01fh,004h,005h	; 78d3  ........
	defb 005h,005h,005h,011h,039h,011h,002h,005h	; 78db  ....9...
	defb 00eh,011h,01dh,01ch,01ch,01ch,01ch,01ch	; 78e3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_125: fase 16, habitacion 1: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x78eb..0x791b  (48 bytes)
DATA_habitacion_125:
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 78eb  ........
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 78f3  ........
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 78fb  ........
	defb 00ah,018h,00ah,018h,00ah,018h,00ah,00ah	; 7903  ........
	defb 00bh,01bh,00bh,00bh,01bh,00bh,012h,00eh	; 790b  ........
	defb 019h,019h,019h,019h,019h,019h,019h,00fh	; 7913  ........

; ----------------------------------------------------------------------
; DATOS habitacion_126: fase 16, habitacion 2: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x791b..0x794b  (48 bytes)
DATA_habitacion_126:
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 791b  ........
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 7923  ........
	defb 010h,010h,010h,010h,000h,006h,007h,010h	; 792b  ........
	defb 00ah,00ah,00ah,018h,01ch,01ch,007h,00ah	; 7933  ........
	defb 00bh,00bh,01bh,00bh,003h,021h,007h,00bh	; 793b  .....!..
	defb 019h,019h,019h,019h,001h,011h,007h,019h	; 7943  ........

; ----------------------------------------------------------------------
; DATOS habitacion_127: fase 16, habitacion 3: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x794b..0x797b  (48 bytes)
DATA_habitacion_127:
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 794b  ........
	defb 000h,016h,010h,010h,010h,010h,010h,010h	; 7953  ........
	defb 001h,006h,004h,007h,010h,010h,010h,010h	; 795b  ........
	defb 023h,01ch,006h,01ch,018h,00ah,00ah,00ah	; 7963  #.......
	defb 003h,006h,005h,007h,00bh,00bh,00bh,00bh	; 796b  ........
	defb 001h,005h,004h,007h,019h,019h,019h,019h	; 7973  ........

; ----------------------------------------------------------------------
; DATOS habitacion_128: fase 16, habitacion 4: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x797b..0x79ab  (48 bytes)
DATA_habitacion_128:
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 797b  ........
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 7983  ........
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 798b  ........
	defb 00ah,00ah,018h,00ah,018h,00ah,018h,00ah	; 7993  ........
	defb 00eh,011h,00ch,01bh,00bh,00bh,00bh,00bh	; 799b  ........
	defb 00fh,00ch,00dh,019h,000h,016h,008h,019h	; 79a3  ........

; ----------------------------------------------------------------------
; DATOS habitacion_129: fase 16, habitacion 5: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x79ab..0x79db  (48 bytes)
DATA_habitacion_129:
	defb 022h,003h,006h,007h,010h,010h,010h,010h	; 79ab  ".......
	defb 03fh,003h,004h,007h,010h,010h,010h,010h	; 79b3  ?.......
	defb 037h,003h,002h,009h,010h,010h,010h,010h	; 79bb  7.......
	defb 022h,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 79c3  ".......
	defb 022h,005h,005h,011h,011h,01fh,005h,011h	; 79cb  ".......
	defb 022h,01ah,00dh,00fh,00dh,01eh,01ah,00dh	; 79d3  ".......

; ----------------------------------------------------------------------
; DATOS habitacion_130: fase 16, habitacion 6: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x79db..0x7a0b  (48 bytes)
DATA_habitacion_130:
	defb 01fh,021h,03ah,011h,021h,005h,006h,021h	; 79db  .!:.!..!
	defb 011h,03ah,011h,021h,01fh,006h,005h,006h	; 79e3  .:.!....
	defb 01ch,01ch,01ch,017h,006h,011h,005h,005h	; 79eb  ........
	defb 006h,011h,011h,005h,039h,006h,004h,005h	; 79f3  ....9...
	defb 00bh,012h,00eh,005h,01fh,039h,002h,006h	; 79fb  .....9..
	defb 019h,019h,00fh,01ch,01ch,01ch,01ch,011h	; 7a03  ........

; ----------------------------------------------------------------------
; DATOS habitacion_131: fase 16, habitacion 7: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7a0b..0x7a3b  (48 bytes)
DATA_habitacion_131:
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 7a0b  ........
	defb 010h,010h,010h,010h,010h,010h,010h,010h	; 7a13  ........
	defb 010h,010h,010h,010h,010h,010h,010h,023h	; 7a1b  .......#
	defb 00ah,018h,00ah,018h,00ah,018h,00ah,011h	; 7a23  ........
	defb 00bh,01bh,00bh,00bh,01bh,00bh,00bh,00bh	; 7a2b  ........
	defb 019h,019h,019h,019h,019h,019h,019h,019h	; 7a33  ........

; ----------------------------------------------------------------------
; DATOS habitacion_132: fase 16, habitacion 8: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7a3b..0x7a6b  (48 bytes)
DATA_habitacion_132:
	defb 010h,010h,010h,010h,003h,011h,007h,010h	; 7a3b  ........
	defb 010h,010h,010h,010h,003h,004h,007h,010h	; 7a43  ........
	defb 010h,010h,010h,010h,003h,002h,007h,010h	; 7a4b  ........
	defb 00ah,00ah,00ah,018h,01ch,01ch,021h,00ah	; 7a53  ......!.
	defb 00bh,00bh,012h,00eh,003h,005h,005h,00bh	; 7a5b  ........
	defb 019h,019h,019h,00fh,001h,005h,045h,019h	; 7a63  ......E.

; ----------------------------------------------------------------------
; DATOS habitacion_133: fase 16, habitacion 9: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7a6b..0x7a9b  (48 bytes)
DATA_habitacion_133:
	defb 003h,011h,021h,007h,010h,010h,010h,010h	; 7a6b  ..!.....
	defb 001h,005h,004h,007h,010h,010h,010h,010h	; 7a73  ........
	defb 003h,005h,005h,007h,010h,010h,010h,010h	; 7a7b  ........
	defb 001h,005h,004h,01ch,00ah,018h,00ah,00ah	; 7a83  ........
	defb 003h,006h,011h,01ah,00bh,00bh,00bh,00bh	; 7a8b  ........
	defb 001h,006h,004h,007h,019h,019h,019h,019h	; 7a93  ........

; ----------------------------------------------------------------------
; DATOS habitacion_134: fase 17, habitacion 0: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7a9b..0x7acb  (48 bytes)
DATA_habitacion_134:
	defb 005h,022h,006h,01fh,03ah,006h,005h,03fh	; 7a9b  ."..:..?
	defb 004h,022h,011h,03ah,01fh,006h,004h,037h	; 7aa3  .".:...7
	defb 006h,01fh,01ch,021h,006h,011h,01ch,022h	; 7aab  ...!..."
	defb 01ch,017h,006h,01ch,022h,01fh,005h,022h	; 7ab3  ....".."
	defb 01fh,005h,039h,011h,021h,006h,004h,022h	; 7abb  ..9.!.."
	defb 022h,022h,022h,022h,022h,005h,01fh,022h	; 7ac3  """"".."

; ----------------------------------------------------------------------
; DATOS habitacion_135: fase 17, habitacion 1: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7acb..0x7afb  (48 bytes)
DATA_habitacion_135:
	defb 01fh,024h,004h,022h,011h,006h,006h,024h	; 7acb  .$."...$
	defb 006h,024h,042h,022h,005h,021h,006h,024h	; 7ad3  .$B".!.$
	defb 005h,024h,022h,022h,006h,006h,01ch,024h	; 7adb  .$""...$
	defb 01ch,024h,001h,024h,006h,022h,011h,03bh	; 7ae3  .$.$.".;
	defb 021h,024h,043h,024h,011h,022h,005h,024h	; 7aeb  !$C$.".$
	defb 022h,022h,022h,022h,022h,022h,022h,022h	; 7af3  """"""""

; ----------------------------------------------------------------------
; DATOS habitacion_136: fase 17, habitacion 2: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7afb..0x7b2b  (48 bytes)
DATA_habitacion_136:
	defb 022h,024h,01fh,022h,039h,01fh,005h,024h	; 7afb  "$."9..$
	defb 022h,024h,005h,022h,01fh,039h,011h,024h	; 7b03  "$.".9.$
	defb 022h,014h,011h,022h,005h,004h,039h,024h	; 7b0b  ".."..9$
	defb 022h,024h,01fh,022h,005h,005h,01dh,03bh	; 7b13  "$."...;
	defb 022h,024h,004h,021h,005h,03ah,006h,024h	; 7b1b  "$.!.:.$
	defb 022h,024h,022h,022h,022h,022h,022h,022h	; 7b23  "$""""""

; ----------------------------------------------------------------------
; DATOS habitacion_137: fase 17, habitacion 3: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7b2b..0x7b5b  (48 bytes)
DATA_habitacion_137:
	defb 024h,011h,024h,021h,024h,01fh,024h,022h	; 7b2b  $.$!$.$"
	defb 024h,020h,024h,011h,024h,021h,024h,022h	; 7b33  $ $.$!$"
	defb 03bh,01ch,024h,020h,024h,005h,024h,022h	; 7b3b  ;.$ $.$"
	defb 024h,011h,01ch,01ch,01ch,044h,01ch,022h	; 7b43  $....D."
	defb 024h,005h,021h,011h,03ah,011h,021h,022h	; 7b4b  $.!.:.!"
	defb 022h,022h,022h,022h,044h,022h,022h,022h	; 7b53  """"D"""

; ----------------------------------------------------------------------
; DATOS habitacion_138: fase 17, habitacion 4: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7b5b..0x7b8b  (48 bytes)
DATA_habitacion_138:
	defb 021h,024h,021h,024h,004h,024h,005h,024h	; 7b5b  !$!$.$.$
	defb 006h,024h,011h,024h,042h,024h,011h,024h	; 7b63  .$.$B$.$
	defb 01ch,01ch,017h,024h,01ch,03bh,01ch,03bh	; 7b6b  ...$.;.;
	defb 01fh,005h,006h,022h,001h,024h,021h,024h	; 7b73  ...".$!$
	defb 005h,005h,011h,022h,043h,024h,01fh,024h	; 7b7b  ..."C$.$
	defb 022h,005h,022h,022h,022h,022h,006h,022h	; 7b83  ".""""."

; ----------------------------------------------------------------------
; DATOS habitacion_139: fase 17, habitacion 5: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7b8b..0x7bbb  (48 bytes)
DATA_habitacion_139:
	defb 022h,024h,039h,01fh,011h,024h,004h,024h	; 7b8b  "$9..$.$
	defb 022h,024h,006h,039h,006h,024h,042h,024h	; 7b93  "$.9.$B$
	defb 022h,03bh,01ch,01ch,044h,022h,023h,03bh	; 7b9b  ";..D"#;
	defb 022h,024h,01fh,03ah,005h,022h,001h,024h	; 7ba3  "$.:.".$
	defb 022h,024h,01ch,004h,006h,022h,002h,024h	; 7bab  "$...".$
	defb 022h,024h,022h,022h,038h,022h,022h,022h	; 7bb3  "$""8"""

; ----------------------------------------------------------------------
; DATOS habitacion_140: fase 17, habitacion 6: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7bbb..0x7beb  (48 bytes)
DATA_habitacion_140:
	defb 02ah,03eh,026h,022h,006h,021h,007h,022h	; 7bbb  *>&".!."
	defb 02ah,02ah,013h,022h,01fh,006h,007h,022h	; 7bc3  **."..."
	defb 022h,038h,01ch,01ch,021h,011h,022h,022h	; 7bcb  "8..!.""
	defb 022h,004h,039h,011h,01ch,004h,022h,022h	; 7bd3  ".9...""
	defb 021h,011h,006h,039h,011h,006h,021h,022h	; 7bdb  !..9..!"
	defb 022h,022h,038h,022h,022h,022h,022h,022h	; 7be3  ""8"""""

; ----------------------------------------------------------------------
; DATOS habitacion_141: fase 17, habitacion 7: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7beb..0x7c1b  (48 bytes)
DATA_habitacion_141:
	defb 034h,026h,03dh,025h,02bh,02fh,030h,030h	; 7beb  4&=%+/00
	defb 035h,03dh,02eh,027h,028h,029h,02fh,030h	; 7bf3  5=.'()/0
	defb 040h,02ch,02eh,032h,02bh,02eh,031h,022h	; 7bfb  @,.2+.1"
	defb 02bh,027h,028h,029h,02bh,02eh,031h,022h	; 7c03  +'()+.1"
	defb 02eh,032h,031h,031h,02bh,022h,022h,006h	; 7c0b  .211+"".
	defb 022h,030h,02fh,030h,041h,031h,022h,022h	; 7c13  "0/0A1""

; ----------------------------------------------------------------------
; DATOS habitacion_142: fase 17, habitacion 8: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7c1b..0x7c4b  (48 bytes)
DATA_habitacion_142:
	defb 022h,003h,011h,03ah,007h,022h,035h,02eh	; 7c1b  "..:."5.
	defb 022h,003h,03ah,006h,007h,022h,02dh,02eh	; 7c23  ".:.."-.
	defb 022h,023h,01ch,01ch,017h,032h,031h,040h	; 7c2b  "#...21@
	defb 022h,003h,01fh,006h,007h,03eh,02ch,02bh	; 7c33  "....>,+
	defb 022h,003h,006h,006h,007h,02dh,03eh,02bh	; 7c3b  "....->+
	defb 022h,003h,006h,011h,007h,02eh,02ch,022h	; 7c43  ".....,"

; ----------------------------------------------------------------------
; DATOS habitacion_143: fase 17, habitacion 9: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7c4b..0x7c7b  (48 bytes)
DATA_habitacion_143:
	defb 022h,003h,024h,011h,01fh,024h,007h,022h	; 7c4b  ".$..$."
	defb 022h,003h,024h,01fh,011h,024h,007h,022h	; 7c53  ".$..$."
	defb 022h,022h,022h,021h,006h,024h,007h,022h	; 7c5b  """!.$."
	defb 022h,02fh,02fh,003h,011h,022h,007h,022h	; 7c63  "//.."."
	defb 032h,031h,031h,022h,021h,022h,007h,022h	; 7c6b  211"!"."
	defb 022h,046h,022h,022h,022h,022h,007h,022h	; 7c73  "F""""."

; ----------------------------------------------------------------------
; DATOS habitacion_144: fase 17, habitacion 10: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7c7b..0x7cab  (48 bytes)
DATA_habitacion_144:
	defb 034h,030h,030h,02bh,02fh,030h,025h,022h	; 7c7b  400+/0%"
	defb 035h,02dh,031h,02bh,02ch,025h,025h,022h	; 7c83  5-1+,%%"
	defb 031h,033h,027h,028h,029h,025h,022h,022h	; 7c8b  13'()%""
	defb 034h,033h,032h,02bh,02dh,026h,02ch,022h	; 7c93  432+-&,"
	defb 035h,022h,03ch,027h,028h,029h,02eh,032h	; 7c9b  5"<'().2
	defb 031h,025h,036h,03fh,02bh,027h,029h,022h	; 7ca3  1%6?+')"

; ----------------------------------------------------------------------
; DATOS habitacion_145: fase 17, habitacion 11: 8 x 6 bloques de 32x32 del
;   juego de 0x9651; lo leen p00:4FF9 (48 bytes)
;   0x7cab..0x7cdb  (48 bytes)
DATA_habitacion_145:
	defb 022h,003h,011h,01fh,006h,022h,030h,02dh	; 7cab  "...."0-
	defb 03fh,003h,004h,006h,004h,022h,02fh,030h	; 7cb3  ?...."/0
	defb 037h,003h,011h,005h,01fh,022h,034h,031h	; 7cbb  7...."41
	defb 022h,023h,017h,005h,005h,022h,035h,02eh	; 7cc3  "#..."5.
	defb 022h,003h,004h,039h,005h,022h,035h,02eh	; 7ccb  "..9."5.
	defb 022h,003h,005h,01dh,022h,022h,034h,02dh	; 7cd3  "...""4-

; ----------------------------------------------------------------------
; DATOS habitacion_146: fase 18, habitacion 0: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7cdb..0x7d0b  (48 bytes)
DATA_habitacion_146:
	defb 001h,001h,001h,001h,001h,001h,001h,001h	; 7cdb  ........
	defb 001h,001h,001h,001h,001h,005h,001h,001h	; 7ce3  ........
	defb 001h,001h,001h,001h,001h,001h,001h,001h	; 7ceb  ........
	defb 002h,003h,003h,004h,006h,001h,001h,001h	; 7cf3  ........
	defb 007h,008h,009h,009h,00dh,006h,001h,001h	; 7cfb  ........
	defb 00ah,00bh,00ch,008h,00eh,00fh,010h,00fh	; 7d03  ........

; ----------------------------------------------------------------------
; DATOS habitacion_147: fase 18, habitacion 1: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7d0b..0x7d3b  (48 bytes)
DATA_habitacion_147:
	defb 019h,019h,019h,019h,019h,019h,015h,019h	; 7d0b  ........
	defb 017h,01ah,016h,018h,018h,019h,019h,018h	; 7d13  ........
	defb 013h,018h,013h,013h,013h,029h,013h,014h	; 7d1b  .....)..
	defb 014h,016h,014h,014h,030h,019h,017h,012h	; 7d23  ....0...
	defb 013h,018h,013h,013h,013h,016h,019h,011h	; 7d2b  ........
	defb 014h,019h,015h,019h,014h,012h,012h,011h	; 7d33  ........

; ----------------------------------------------------------------------
; DATOS habitacion_148: fase 18, habitacion 2: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7d3b..0x7d6b  (48 bytes)
DATA_habitacion_148:
	defb 028h,016h,030h,019h,019h,02fh,019h,014h	; 7d3b  (.0../..
	defb 028h,030h,019h,019h,015h,019h,02fh,019h	; 7d43  (0..../.
	defb 02ch,013h,013h,01ch,019h,017h,013h,013h	; 7d4b  ,.......
	defb 028h,015h,019h,019h,02fh,019h,015h,017h	; 7d53  (.../...
	defb 02ch,013h,013h,013h,019h,02fh,019h,013h	; 7d5b  ,..../..
	defb 028h,018h,016h,019h,019h,013h,013h,018h	; 7d63  (.......

; ----------------------------------------------------------------------
; DATOS habitacion_149: fase 18, habitacion 3: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7d6b..0x7d9b  (48 bytes)
DATA_habitacion_149:
	defb 031h,03bh,019h,036h,019h,030h,019h,03dh	; 7d6b  1;.6.0.=
	defb 028h,033h,032h,019h,02ah,02bh,019h,03dh	; 7d73  (32.*+.=
	defb 028h,019h,033h,032h,028h,019h,02fh,03dh	; 7d7b  (.32(./=
	defb 02ch,013h,03eh,013h,02ch,03ah,013h,035h	; 7d83  ,.>.,:.5
	defb 028h,030h,019h,019h,028h,019h,02fh,03dh	; 7d8b  (0..(./=
	defb 02ch,013h,029h,013h,013h,03ah,013h,035h	; 7d93  ,.)..:.5

; ----------------------------------------------------------------------
; DATOS habitacion_150: fase 18, habitacion 4: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7d9b..0x7dcb  (48 bytes)
DATA_habitacion_150:
	defb 019h,019h,030h,019h,030h,019h,017h,011h	; 7d9b  ..0.0...
	defb 019h,030h,019h,030h,019h,015h,019h,011h	; 7da3  .0.0....
	defb 013h,013h,030h,019h,014h,019h,016h,011h	; 7dab  ..0.....
	defb 019h,030h,019h,013h,019h,017h,019h,027h	; 7db3  .0.....'
	defb 012h,019h,019h,019h,013h,018h,019h,017h	; 7dbb  ........
	defb 011h,019h,012h,019h,012h,012h,019h,036h	; 7dc3  .......6

; ----------------------------------------------------------------------
; DATOS habitacion_151: fase 18, habitacion 5: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7dcb..0x7dfb  (48 bytes)
DATA_habitacion_151:
	defb 011h,019h,017h,018h,019h,019h,019h,016h	; 7dcb  ........
	defb 011h,017h,019h,015h,019h,016h,018h,019h	; 7dd3  ........
	defb 011h,013h,013h,019h,02eh,019h,019h,016h	; 7ddb  ........
	defb 027h,019h,014h,019h,028h,013h,019h,019h	; 7de3  '...(...
	defb 015h,019h,017h,016h,028h,019h,01dh,012h	; 7deb  ....(...
	defb 036h,032h,019h,012h,028h,030h,019h,011h	; 7df3  62..(0..

; ----------------------------------------------------------------------
; DATOS habitacion_152: fase 18, habitacion 6: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7dfb..0x7e2b  (48 bytes)
DATA_habitacion_152:
	defb 028h,016h,015h,019h,028h,02fh,019h,03dh	; 7dfb  (...(/.=
	defb 028h,019h,016h,017h,028h,019h,02fh,03dh	; 7e03  (...(./=
	defb 02ch,013h,01ch,018h,028h,01dh,013h,035h	; 7e0b  ,...(..5
	defb 028h,019h,01dh,013h,02ch,03ch,032h,03dh	; 7e13  (...,<2=
	defb 028h,030h,019h,019h,038h,01dh,013h,012h	; 7e1b  (0..8...
	defb 012h,013h,03eh,013h,030h,019h,019h,011h	; 7e23  ..>.0...

; ----------------------------------------------------------------------
; DATOS habitacion_153: fase 18, habitacion 7: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7e2b..0x7e5b  (48 bytes)
DATA_habitacion_153:
	defb 015h,019h,017h,019h,019h,015h,019h,03dh	; 7e2b  .......=
	defb 019h,019h,019h,019h,016h,019h,019h,03dh	; 7e33  .......=
	defb 019h,01dh,013h,019h,019h,019h,015h,03dh	; 7e3b  .......=
	defb 013h,019h,019h,013h,013h,01ch,019h,03dh	; 7e43  .......=
	defb 019h,015h,019h,019h,019h,019h,02fh,03dh	; 7e4b  ....../=
	defb 013h,013h,018h,019h,012h,03ah,013h,035h	; 7e53  .....:.5

; ----------------------------------------------------------------------
; DATOS habitacion_154: fase 18, habitacion 8: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7e5b..0x7e8b  (48 bytes)
DATA_habitacion_154:
	defb 011h,019h,019h,016h,019h,019h,019h,015h	; 7e5b  ........
	defb 011h,019h,017h,019h,019h,016h,019h,019h	; 7e63  ........
	defb 011h,013h,013h,03ah,013h,013h,019h,015h	; 7e6b  ...:....
	defb 03fh,019h,014h,019h,02fh,019h,013h,013h	; 7e73  ?.../...
	defb 000h,014h,019h,016h,019h,02fh,019h,019h	; 7e7b  ...../..
	defb 013h,013h,013h,013h,013h,013h,013h,013h	; 7e83  ........

; ----------------------------------------------------------------------
; DATOS habitacion_155: fase 18, habitacion 9: 8 x 6 bloques de 32x32 del
;   juego de 0x9AC1; lo leen p00:4FF9 (48 bytes)
;   0x7e8b..0x7ebb  (48 bytes)
DATA_habitacion_155:
	defb 020h,023h,01eh,01eh,01eh,01eh,022h,021h	; 7e8b   #...."!
	defb 020h,024h,048h,049h,04ah,04bh,025h,021h	; 7e93   $HIJK%!
	defb 040h,042h,04ch,04dh,04eh,04fh,026h,041h	; 7e9b  @BLMNO&A
	defb 020h,024h,050h,051h,052h,053h,025h,021h	; 7ea3   $PQRS%!
	defb 040h,042h,054h,055h,056h,057h,026h,041h	; 7eab  @BTUVW&A
	defb 044h,047h,043h,043h,043h,043h,046h,045h	; 7eb3  DGCCCCFE

; ----------------------------------------------------------------------
; DATOS bloques_de_cada_fase: 19 punteros, uno por fase, al juego de bloques
;   de 32x32 de su decorado; lo leen p00:500D (38 bytes)
;   0x7ebb..0x7ee1  (38 bytes)
DATA_bloques_de_cada_fase:
	defb 0e1h,07eh	; 7ebb
	defb 0b1h,080h	; 7ebd
	defb 0b1h,080h	; 7ebf
	defb 0b1h,080h	; 7ec1
	defb 0d1h,084h	; 7ec3
	defb 0d1h,084h	; 7ec5
	defb 0d1h,084h	; 7ec7
	defb 091h,087h	; 7ec9
	defb 091h,087h	; 7ecb
	defb 091h,087h	; 7ecd
	defb 021h,08dh	; 7ecf
	defb 021h,08dh	; 7ed1
	defb 021h,08dh	; 7ed3
	defb 021h,091h	; 7ed5
	defb 021h,091h	; 7ed7
	defb 021h,091h	; 7ed9
	defb 051h,096h	; 7edb
	defb 051h,096h	; 7edd
	defb 0c1h,09ah	; 7edf

; ----------------------------------------------------------------------
; DATOS bloques_7EE1: 29 bloques de 32x32 (16 bytes cada uno: 4 x 4 dibujos de
;   8x8); tantos como el indice mas alto que usan sus habitaciones; lo leen
;   p00:5010 (287 bytes)
;   0x7ee1..0x8000  (287 bytes)
DATA_bloques_7EE1:
	defb 016h,016h,016h,016h,027h,028h,030h,016h,031h,032h,033h,034h,039h,03ah,03bh,03ch	; 7ee1  ....'(0.12349:;<
	defb 016h,016h,016h,016h,016h,016h,016h,016h,035h,036h,037h,038h,03dh,03eh,03fh,040h	; 7ef1  ........5678=>?@
	defb 041h,042h,043h,044h,049h,04ah,04bh,04ch,051h,052h,053h,054h,057h,058h,059h,05ah	; 7f01  ABCDIJKLQRSTWXYZ
	defb 045h,046h,047h,048h,04dh,04eh,04fh,050h,04ah,04bh,055h,056h,05bh,05ch,05dh,05eh	; 7f11  EFGHMNOPJKUV[\]^
	defb 05fh,060h,061h,062h,067h,068h,069h,06ah,06fh,070h,071h,072h,077h,078h,079h,07ah	; 7f21  _`abghijopqrwxyz
	defb 063h,064h,065h,066h,06bh,06ch,06dh,06eh,073h,074h,075h,076h,07bh,07ch,07dh,07eh	; 7f31  cdefklmnstuv{|}~
	defb 07fh,080h,081h,082h,083h,084h,085h,086h,087h,088h,089h,08ah,029h,02ah,000h,02ch	; 7f41  ............)*.,
	defb 08bh,08ch,02eh,02fh,083h,084h,085h,086h,087h,088h,089h,08ah,029h,02ah,000h,02ch	; 7f51  .../........)*.,
	defb 07fh,080h,081h,082h,083h,084h,02dh,02bh,087h,088h,089h,000h,029h,02ah,000h,000h	; 7f61  ......-+....)*..
	defb 07fh,080h,081h,082h,02bh,084h,085h,086h,000h,02bh,089h,08ah,000h,000h,000h,02ch	; 7f71  ....+....+.....,
	defb 07fh,080h,081h,082h,02bh,08dh,085h,086h,000h,089h,089h,08ah,000h,000h,000h,02ch	; 7f81  ....+..........,
	defb 08bh,08ch,02eh,02fh,083h,084h,085h,02dh,087h,088h,089h,089h,029h,02ah,000h,000h	; 7f91  .../...-....)*..
	defb 025h,000h,000h,000h,023h,023h,023h,023h,023h,023h,023h,023h,024h,024h,024h,024h	; 7fa1  %...########$$$$
	defb 026h,000h,000h,000h,023h,023h,023h,023h,023h,023h,023h,023h,024h,024h,024h,024h	; 7fb1  &...########$$$$
	defb 000h,000h,000h,000h,023h,023h,023h,023h,08eh,08fh,023h,023h,090h,091h,024h,024h	; 7fc1  ....####..##..$$
	defb 02bh,02bh,089h,02bh,000h,000h,000h,000h,000h,017h,018h,000h,000h,019h,01ah,000h	; 7fd1  ++.+............
	defb 000h,01bh,01dh,000h,023h,01eh,01ch,023h,01fh,020h,021h,022h,01fh,020h,021h,022h	; 7fe1  ....#..#. !". !"
	defb 016h,003h,003h,004h,016h,003h,005h,015h,036h,003h,003h,004h,014h,014h,014h	; 7ff1  ........6......
