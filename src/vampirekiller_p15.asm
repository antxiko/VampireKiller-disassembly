; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 15 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS musica_9F89_cola: partitura de un canal de musica (p14:8AD0) (sigue
;   del banco anterior, 0x9F8E); se solapan 6 bloques (0xA000-0xA051,
;   0xA007-0xA051, 0xA010-0xA051, 0xA01E-0xA051, 0xA027-0xA051,
;   0xA035-0xA051); lo leen musica 5 (81 bytes)
;   0xa000..0xa051  (81 bytes)
DATA_musica_9F89_cola:
	defb 0e9h,010h,010h,0feh,002h,0f9h,09fh,0e3h,011h,0e2h,010h,010h,0feh,004h,007h,0a0h	; a000  ................
	defb 0e4h,091h,0e3h,090h,090h,0e8h,041h,0e9h,090h,090h,0feh,002h,010h,0a0h,0e4h,091h	; a010  ......A.........
	defb 0e3h,090h,090h,0feh,004h,01eh,0a0h,0e4h,061h,0e3h,060h,060h,0e8h,041h,0e9h,060h	; a020  ........a.``.A.`
	defb 060h,0feh,004h,027h,0a0h,0e4h,081h,0e3h,080h,080h,0e8h,041h,0e9h,080h,080h,0feh	; a030  `..'.......A....
	defb 002h,035h,0a0h,0e4h,081h,0e2h,041h,031h,021h,011h,001h,0e3h,0b1h,0a1h,0eah,09ch	; a040  .5....A1!.......
	defb 09fh	; a050

; ----------------------------------------------------------------------
; DATOS musica_A051: partitura de un canal de musica (p14:8AD0); se solapan 3
;   bloques (0xA051-0xA157, 0xA053-0xA157, 0xA062-0xA157); lo leen musica 5
;   (262 bytes)
;   0xa051..0xa157  (262 bytes)
DATA_musica_A051:
	defb 0d6h,0e8h,001h,0feh,017h,053h,0a0h,000h,000h,001h,001h,001h,001h,001h,031h,031h	; a051  .....S........11
	defb 031h,0e9h,0fch,034h,0e2h,013h,0c1h,0e3h,07fh,0e4h,0c1h,001h,0c1h,011h,0c1h,0e9h	; a061  1..4............
	defb 0fch,024h,0e3h,063h,0c1h,073h,0c1h,0e2h,015h,0e3h,075h,0e2h,003h,0e3h,0b3h,0e9h	; a071  .$.c.s....u.....
	defb 0fch,031h,0e3h,063h,0e8h,031h,0e9h,073h,0c1h,0e9h,0e2h,013h,0c1h,0e3h,071h,0e8h	; a081  .1.c.1.s......q.
	defb 031h,0e9h,0c1h,061h,0c1h,071h,0c1h,0e2h,013h,0e8h,031h,0e9h,031h,0c3h,043h,0c1h	; a091  1..a.q....1.1.C.
	defb 031h,0e8h,031h,0e9h,0c1h,041h,0c1h,0e9h,071h,0c1h,0fch,024h,073h,0e8h,031h,0e9h	; a0a1  1.1..A..q..$s.1.
	defb 061h,0c3h,091h,0c3h,081h,0e8h,031h,001h,001h,001h,030h,030h,030h,030h,0e9h,0fbh	; a0b1  a.....1...0000..
	defb 034h,0e3h,093h,0e8h,0edh,0e7h,0a8h,0e9h,093h,091h,0e2h,013h,0e8h,0edh,0e7h,0a8h	; a0c1  4...............
	defb 0e9h,0fch,024h,013h,011h,073h,0e8h,0edh,0e7h,0a8h,0e9h,073h,071h,0e1h,013h,0e8h	; a0d1  ..$..s.....sq...
	defb 0edh,0e7h,0a8h,0e9h,011h,0e8h,000h,000h,0e9h,011h,0fdh,024h,0e1h,011h,0f9h,021h	; a0e1  ...........$...!
	defb 010h,010h,0fch,024h,0e2h,085h,081h,061h,0fdh,024h,041h,0e8h,0edh,0eeh,0a8h,001h	; a0f1  ...$...a.$A.....
	defb 0e9h,0fbh,022h,081h,0f9h,000h,080h,0fah,000h,080h,0e8h,030h,030h,0e9h,0fch,024h	; a101  .."........00..$
	defb 0e1h,011h,0f9h,021h,010h,010h,0fch,024h,0e2h,075h,071h,063h,0e8h,0edh,0eeh,0a8h	; a111  ...!...$.uqc....
	defb 001h,000h,000h,031h,030h,030h,000h,000h,0e9h,0fch,022h,0e2h,061h,061h,0e1h,011h	; a121  ...100....".aa..
	defb 0e8h,000h,000h,0e9h,0e2h,065h,0e8h,000h,000h,0e9h,011h,011h,0f9h,000h,060h,0fah	; a131  .....e........`.
	defb 000h,060h,0e8h,000h,000h,0e9h,015h,03fh,0fdh,071h,0e5h,081h,0fch,071h,0e1h,0e1h	; a141  .`.....?.q...q..
	defb 0edh,0dfh,0a8h,0eah,062h,0a0h	; a151

; ----------------------------------------------------------------------
; DATOS musica_A157: partitura de un canal de musica (p14:8AD0); se solapan 4
;   bloques (0xA157-0xA1B9, 0xA176-0xA1B9, 0xA194-0xA1B9, 0xA1A6-0xA1B9); lo
;   leen musica 6 (98 bytes)
;   0xa157..0xa1b9  (98 bytes)
DATA_musica_A157:
	defb 0e7h,0e9h,0d6h,0fch,051h,0e2h,0b3h,0d2h,0fch,026h,0b3h,0b3h,0b3h,0d6h,0fch,051h	; a157  ....Q....&.....Q
	defb 0e1h,003h,0d2h,0fch,026h,003h,003h,003h,0feh,002h,057h,0a1h,0d6h,0fch,051h,0e2h	; a167  ....&.....W...Q.
	defb 0b3h,0e1h,003h,0feh,004h,076h,0a1h,0d2h,0fah,023h,0e2h,0edh,0f6h,0a8h,0fbh,023h	; a177  .....v...#.....#
	defb 0edh,0f6h,0a8h,0fch,023h,0edh,0f6h,0a8h,0fdh,023h,0edh,0f6h,0a8h,0d2h,0e2h,0edh	; a187  ....#....#......
	defb 0fdh,0a8h,0edh,0fdh,0a8h,0edh,0fdh,0a8h,0edh,0fdh,0a8h,0feh,002h,094h,0a1h,0edh	; a197  ................
	defb 012h,0a9h,0edh,012h,0a9h,0edh,012h,0a9h,0edh,012h,0a9h,0feh,002h,0a6h,0a1h,0eah	; a1a7  ................
	defb 057h,0a1h	; a1b7

; ----------------------------------------------------------------------
; DATOS musica_A1B9: partitura de un canal de musica (p14:8AD0); se solapan 4
;   bloques (0xA1B9-0xA217, 0xA1CB-0xA217, 0xA1E6-0xA217, 0xA1FF-0xA217); lo
;   leen musica 6 (94 bytes)
;   0xa1b9..0xa217  (94 bytes)
DATA_musica_A1B9:
	defb 0d6h,0fbh,051h,0e2h,073h,0d2h,0fbh,025h,073h,073h,073h,0feh,004h,0b9h,0a1h,0d6h	; a1b9  ..Q.s..%sss.....
	defb 0fch,050h,073h,0feh,008h,0cbh,0a1h,0d2h,0f9h,022h,0e1h,0edh,027h,0a9h,0fah,022h	; a1c9  .Ps......"..'.."
	defb 0edh,027h,0a9h,0fbh,022h,0edh,027h,0a9h,0fch,022h,0edh,027h,0a9h,0d4h,0fch,024h	; a1d9  .'..".'..".'...$
	defb 0e2h,013h,0cfh,012h,0c0h,0e2h,043h,0cfh,042h,0c0h,063h,0cfh,062h,0c0h,073h,0cfh	; a1e9  ......C.B.c.b.s.
	defb 072h,0c0h,0feh,002h,0e6h,0a1h,0e3h,083h,0cfh,082h,0c0h,073h,0cfh,072h,0c0h,083h	; a1f9  r..........s.r..
	defb 0cfh,082h,0c0h,093h,0cfh,092h,0c0h,0feh,002h,0ffh,0a1h,0eah,0b9h,0a1h	; a209  ..............

; ----------------------------------------------------------------------
; DATOS musica_A217: partitura de un canal de musica (p14:8AD0); se solapan 6
;   bloques (0xA217-0xA2C5, 0xA21B-0xA2C5, 0xA226-0xA2C5, 0xA230-0xA2C5,
;   0xA23A-0xA2C5, 0xA28F-0xA2C5); lo leen musica 6 (174 bytes)
;   0xa217..0xa2c5  (174 bytes)
DATA_musica_A217:
	defb 0d6h,0fdh,050h,0e3h,043h,0c3h,033h,0c3h,0feh,002h,01bh,0a2h,0fdh,051h,0e3h,043h	; a217  ..P.C.3......Q.C
	defb 033h,0feh,004h,026h,0a2h,0d2h,0fdh,061h,0e3h,043h,033h,023h,013h,023h,033h,0feh	; a227  3..&...a.C3#.#3.
	defb 004h,030h,0a2h,0d2h,0fdh,025h,0e3h,017h,0f9h,058h,013h,013h,013h,0fah,058h,013h	; a237  .0...%...X....X.
	defb 013h,013h,0fbh,058h,013h,013h,0fdh,025h,015h,0c1h,0e3h,047h,0f9h,058h,043h,043h	; a247  ...X...%...G.XCC
	defb 043h,0fah,058h,043h,043h,043h,0fbh,058h,043h,043h,0fdh,025h,045h,0c1h,067h,0f9h	; a257  C.XCCC.XCC.%E.g.
	defb 058h,063h,063h,063h,0fah,068h,063h,063h,063h,0fbh,058h,063h,063h,0fdh,025h,065h	; a267  Xccc.hccc.Xcc.%e
	defb 0c1h,077h,0f9h,058h,073h,073h,073h,0fah,058h,073h,073h,073h,0fbh,059h,073h,073h	; a277  .w.Xsss.Xsss.Yss
	defb 0fdh,025h,075h,0c1h,0feh,002h,03ah,0a2h,0fdh,040h,0e4h,0edh,0bbh,0a9h,077h,0f9h	; a287  .%u...:..@....w.
	defb 058h,073h,073h,073h,0fah,058h,073h,073h,073h,0fbh,058h,073h,073h,0fdh,023h,075h	; a297  Xsss.Xsss.Xss.#u
	defb 0c1h,0edh,0bbh,0a9h,097h,0f9h,058h,093h,093h,093h,0fah,058h,093h,093h,093h,0fbh	; a2a7  ......X....X....
	defb 058h,093h,093h,0fdh,023h,095h,0c1h,0feh,002h,08fh,0a2h,0eah,017h,0a2h	; a2b7  X...#.........

; ----------------------------------------------------------------------
; DATOS musica_A2C5: partitura de un canal de musica (p14:8AD0); se solapan 8
;   bloques (0xA2C5-0xA303, 0xA2C8-0xA303, 0xA2D0-0xA303, 0xA2D8-0xA303,
;   0xA2E0-0xA303, 0xA2E8-0xA303); lo leen musica 7 (62 bytes)
;   0xa2c5..0xa303  (62 bytes)
DATA_musica_A2C5:
	defb 0e9h,0d7h,0ech,000h,070h,030h,070h,0feh,002h,0c8h,0a2h,020h,070h,050h,070h,0feh	; a2c5  ....p0p.... pPp.
	defb 002h,0d0h,0a2h,000h,070h,030h,070h,0feh,004h,0d8h,0a2h,000h,080h,050h,080h,0feh	; a2d5  ....p0p......P..
	defb 002h,0e0h,0a2h,000h,070h,030h,070h,0feh,002h,0e8h,0a2h,020h,070h,050h,070h,0feh	; a2e5  ....p0p.... pPp.
	defb 002h,0f0h,0a2h,000h,070h,050h,070h,0feh,002h,0f8h,0a2h,0eah,0c5h,0a2h	; a2f5  ....pPp.......

; ----------------------------------------------------------------------
; DATOS musica_A303: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 7 (88 bytes)
;   0xa303..0xa35b  (88 bytes)
DATA_musica_A303:
	defb 0e9h,0edh,0a7h,0aah,0edh,0c0h,0aah,0edh,0a7h,0aah,0d1h,0f6h,000h,031h,0f7h,000h	; a303  .............1..
	defb 031h,0f8h,000h,032h,0f9h,000h,031h,0fah,000h,031h,0fbh,000h,032h,0d7h,0fch,000h	; a313  1..2..1..1..2...
	defb 035h,0d1h,0f6h,000h,051h,0f7h,000h,051h,0f8h,000h,052h,0f9h,000h,051h,0fah,000h	; a323  5...Q..Q..R..Q..
	defb 051h,0fbh,000h,052h,0d7h,0fch,000h,055h,0d1h,0f6h,000h,071h,0f7h,000h,071h,0f8h	; a333  Q..R...U...q..q.
	defb 000h,072h,0f9h,000h,071h,0fah,000h,071h,0fbh,000h,072h,0d7h,0fch,000h,075h,0edh	; a343  .r..q..q..r...u.
	defb 0c0h,0aah,0edh,0a7h,0aah,0eah,003h,0a3h	; a353  ........

; ----------------------------------------------------------------------
; DATOS musica_A35B: partitura de un canal de musica (p14:8AD0); se solapan 7
;   bloques (0xA35B-0xA39E, 0xA362-0xA39E, 0xA36A-0xA39E, 0xA372-0xA39E,
;   0xA37A-0xA39E, 0xA382-0xA39E); lo leen musica 7 (67 bytes)
;   0xa35b..0xa39e  (67 bytes)
DATA_musica_A35B:
	defb 0e9h,0d1h,0fah,010h,0e2h,0c0h,0d7h,000h,070h,030h,070h,0feh,002h,062h,0a3h,020h	; a35b  ........p0p..b.
	defb 070h,050h,070h,0feh,002h,06ah,0a3h,000h,070h,030h,070h,0feh,004h,072h,0a3h,000h	; a36b  pPp..j..p0p..r..
	defb 080h,050h,080h,0feh,002h,07ah,0a3h,000h,070h,030h,070h,0feh,002h,082h,0a3h,020h	; a37b  .P...z..p0p....
	defb 070h,050h,070h,0feh,002h,08ah,0a3h,000h,070h,050h,070h,000h,070h,050h,0d1h,075h	; a38b  pPp.....pPp.pP.u
	defb 0eah,05bh,0a3h	; a39b

; ----------------------------------------------------------------------
; DATOS musica_A39E: partitura de un canal de musica (p14:8AD0); se solapan 6
;   bloques (0xA39E-0xA3E4, 0xA3AF-0xA3E4, 0xA3B4-0xA3E4, 0xA3BA-0xA3E4,
;   0xA3C2-0xA3E4, 0xA3CA-0xA3E4); lo leen musica 8 (70 bytes)
;   0xa39e..0xa3e4  (70 bytes)
DATA_musica_A39E:
	defb 0e9h,0d2h,0fdh,028h,0e3h,053h,053h,053h,063h,063h,063h,073h,073h,073h,083h,083h	; a39e  ...(.SSScccsss..
	defb 083h,0e9h,0d6h,0fbh,010h,0e2h,070h,0a0h,0feh,010h,0b4h,0a3h,0e2h,090h,0e1h,000h	; a3ae  ......p.........
	defb 0feh,010h,0bah,0a3h,0e2h,0a0h,0e1h,020h,0feh,010h,0c2h,0a3h,0e1h,000h,030h,0feh	; a3be  ....... ......0.
	defb 010h,0cah,0a3h,0fdh,026h,0e2h,073h,061h,053h,041h,031h,021h,013h,001h,0e3h,0b3h	; a3ce  ....&.saSA1!....
	defb 0a1h,091h,081h,0eah,0afh,0a3h	; a3de

; ----------------------------------------------------------------------
; DATOS musica_A3E4: partitura de un canal de musica (p14:8AD0); se solapan 2
;   bloques (0xA3E4-0xA43C, 0xA3EE-0xA43C); lo leen musica 8 (88 bytes)
;   0xa3e4..0xa43c  (88 bytes)
DATA_musica_A3E4:
	defb 0e9h,0d2h,0fdh,028h,0e3h,023h,0feh,00ch,0e4h,0a3h,0e9h,0d6h,0e4h,073h,091h,0a3h	; a3e4  ...(.#.......s..
	defb 0e3h,001h,0e4h,0a1h,091h,073h,091h,0a3h,0e3h,021h,001h,0e4h,0a1h,093h,0a1h,0e3h	; a3f4  .....s...!......
	defb 003h,021h,001h,0e4h,0a1h,093h,0a1h,0e3h,003h,031h,021h,001h,0e4h,0a3h,0e3h,001h	; a404  .!.......1!.....
	defb 023h,031h,021h,001h,0e4h,0a3h,0e3h,001h,023h,051h,031h,021h,003h,021h,033h,051h	; a414  #1!.....#Q1!.!3Q
	defb 031h,021h,003h,021h,033h,071h,051h,031h,073h,061h,053h,041h,031h,021h,013h,001h	; a424  1!.!3qQ1saSA1!..
	defb 0e4h,0b3h,0a1h,091h,081h,0eah,0eeh,0a3h	; a434  ........

; ----------------------------------------------------------------------
; DATOS musica_A43C: partitura de un canal de musica (p14:8AD0); se solapan 2
;   bloques (0xA43C-0xA49B, 0xA448-0xA49B); lo leen musica 8 (95 bytes)
;   0xa43c..0xa49b  (95 bytes)
DATA_musica_A43C:
	defb 0e9h,0d2h,0fdh,028h,0e4h,073h,0feh,00bh,03ch,0a4h,071h,0c1h,0e9h,0d6h,0fch,025h	; a43c  ...(.s..<.q....%
	defb 0e3h,073h,091h,0a3h,0e2h,001h,0e3h,0a1h,091h,073h,091h,0a3h,0e2h,021h,001h,0e3h	; a44c  .s.......s...!..
	defb 0a1h,093h,0a1h,0e2h,003h,021h,001h,0e3h,0a1h,093h,0a1h,0e2h,003h,031h,021h,001h	; a45c  .....!.......1!.
	defb 0fdh,026h,0e3h,0a3h,0e2h,001h,023h,031h,021h,001h,0e3h,0a3h,0e2h,001h,023h,051h	; a46c  .&....#1!.....#Q
	defb 031h,021h,003h,021h,033h,051h,031h,021h,003h,021h,033h,071h,051h,031h,0e4h,073h	; a47c  1!.!3Q1!.!3qQ1.s
	defb 061h,053h,041h,031h,021h,013h,001h,0e5h,0b3h,0a1h,091h,081h,0eah,048h,0a4h	; a48c  aSA1!........H.

; ----------------------------------------------------------------------
; DATOS musica_A49B: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 9 (21 bytes)
;   0xa49b..0xa4b0  (21 bytes)
DATA_musica_A49B:
	defb 0e6h,0e7h,0e9h,0d8h,0fbh,012h,0e1h,040h,030h,0e2h,0b0h,0e1h,020h,010h,0e2h,090h	; a49b  .......@0... ...
	defb 0e1h,000h,0e2h,0b4h,0ffh	; a4ab

; ----------------------------------------------------------------------
; DATOS musica_A4B0: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 9 (20 bytes)
;   0xa4b0..0xa4c4  (20 bytes)
DATA_musica_A4B0:
	defb 0e6h,0e9h,0d8h,0fbh,012h,0e1h,040h,030h,0e2h,0b0h,0e1h,020h,010h,0e2h,090h,0e1h	; a4b0  ......@0... ....
	defb 000h,0e2h,0b4h,0ffh	; a4c0

; ----------------------------------------------------------------------
; DATOS musica_A4C4: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 9 (13 bytes)
;   0xa4c4..0xa4d1  (13 bytes)
DATA_musica_A4C4:
	defb 0e6h,0e9h,0d8h,0fbh,023h,0e3h,040h,0feh,007h,0c4h,0a4h,044h,0ffh	; a4c4  ....#.@....D.

; ----------------------------------------------------------------------
; DATOS musica_A4D1: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 10 (53 bytes)
;   0xa4d1..0xa506  (53 bytes)
DATA_musica_A4D1:
	defb 0e9h,0e7h,0d6h,0fch,025h,0e2h,0edh,0cfh,0a9h,0e1h,015h,0e2h,0a5h,077h,0c5h,071h	; a4d1  ....%........w.q
	defb 0a1h,0e1h,011h,0f7h,000h,040h,0f8h,000h,040h,0f9h,000h,040h,0fah,000h,040h,0fbh	; a4e1  .....@..@..@..@.
	defb 000h,040h,0fch,000h,040h,0f9h,000h,031h,0fah,000h,031h,0fbh,000h,031h,0fch,000h	; a4f1  .@..@..1..1..1..
	defb 031h,0fdh,000h,031h,0ffh	; a501

; ----------------------------------------------------------------------
; DATOS musica_A506: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 10 (23 bytes)
;   0xa506..0xa51d  (23 bytes)
DATA_musica_A506:
	defb 0e9h,0d6h,0fbh,024h,0e3h,0edh,0cfh,0a9h,0e2h,075h,075h,017h,0c5h,011h,071h,071h	; a506  ...$.....uu...qq
	defb 0fch,024h,075h,0fdh,024h,079h,0ffh	; a516

; ----------------------------------------------------------------------
; DATOS musica_A51D: partitura de un canal de musica (p14:8AD0); se solapan 2
;   bloques (0xA51D-0xA54D, 0xA52A-0xA54D); lo leen musica 10 (48 bytes)
;   0xa51d..0xa54d  (48 bytes)
DATA_musica_A51D:
	defb 0e9h,0d6h,0fch,035h,0e4h,021h,031h,071h,061h,071h,061h,051h,061h,0e4h,071h,0a1h	; a51d  ...5.!1qaqaQa.q.
	defb 0e3h,011h,021h,0feh,002h,02ah,0a5h,0e4h,071h,0d2h,0a1h,0a1h,0a1h,0d6h,0e3h,011h	; a52d  ..!..*..q.......
	defb 021h,071h,0d2h,0a1h,0a1h,0a1h,0d6h,0e2h,011h,021h,0fch,024h,0e3h,0a5h,099h,0ffh	; a53d  !q.......!.$....

; ----------------------------------------------------------------------
; DATOS ff_de_mas: un 0xFF de mas: la musica 10 ya acabo en el de 0xA54C y la
;   11 empieza en 0xA54E; lo leen nadie (1 bytes)
;   0xa54d..0xa54e  (1 bytes)
DATA_ff_de_mas:
	defb 0ffh	; a54d

; ----------------------------------------------------------------------
; DATOS musica_A54E: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 11 (37 bytes)
;   0xa54e..0xa573  (37 bytes)
DATA_musica_A54E:
	defb 0e6h,0e9h,0d4h,0fch,024h,0e2h,0c3h,0b1h,0c1h,0b1h,0c1h,0e1h,021h,063h,0e3h,061h	; a54e  ....$.......!c.a
	defb 0e2h,0c3h,0b1h,0c1h,0e1h,021h,075h,071h,061h,051h,061h,0c1h,071h,0c1h,071h,0e2h	; a55e  .....!uqaQa.q.q.
	defb 0a3h,0c3h,0b3h,0ebh,0ffh	; a56e

; ----------------------------------------------------------------------
; DATOS musica_A573: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 11 (50 bytes)
;   0xa573..0xa5a5  (50 bytes)
DATA_musica_A573:
	defb 0e6h,0e9h,0d4h,0fch,024h,0e2h,0c0h,0e8h,000h,000h,000h,0e9h,061h,0c1h,061h,0c1h	; a573  ....$.......a.a.
	defb 0e2h,0b1h,0e1h,023h,0e8h,0edh,02eh,0a9h,0e9h,0e2h,061h,0c1h,0e2h,0b1h,0e1h,025h	; a583  ...#......a....%
	defb 021h,011h,001h,011h,0c1h,021h,0c1h,021h,0e2h,011h,0e8h,0edh,02eh,0a9h,0e9h,023h	; a593  !....!.!.......#
	defb 0ebh,0ffh	; a5a3

; ----------------------------------------------------------------------
; DATOS musica_A5A5: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 11 (58 bytes)
;   0xa5a5..0xa5df  (58 bytes)
DATA_musica_A5A5:
	defb 0e6h,0e9h,0d4h,0fch,025h,0e4h,0c0h,0b0h,0b0h,0b0h,0b1h,0c1h,0b1h,0c1h,0b1h,0fbh	; a5a5  ....%...........
	defb 034h,0e3h,0b3h,0fch,025h,0e4h,0b0h,0b0h,0b1h,0c1h,0b1h,0c1h,0b1h,0fbh,034h,0e3h	; a5b5  4...%.........4.
	defb 0b3h,0fch,025h,0e4h,0b0h,0b0h,0fbh,034h,0e3h,061h,0c1h,061h,0c1h,0e4h,061h,0e3h	; a5c5  ..%....4.a.a..a.
	defb 063h,061h,063h,0c3h,0fch,024h,0e4h,0b3h,0ebh,0ffh	; a5d5  cac..$....

; ----------------------------------------------------------------------
; DATOS musica_A5DF: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 12 (30 bytes)
;   0xa5df..0xa5fd  (30 bytes)
DATA_musica_A5DF:
	defb 0e6h,0e9h,0d4h,0fch,041h,0e1h,033h,0c1h,031h,0c1h,051h,0c1h,031h,021h,021h,0c1h	; a5df  ....A.3.1.Q.1!!.
	defb 021h,0c1h,031h,0c1h,021h,001h,021h,031h,021h,031h,051h,07fh,0ebh,0ffh	; a5ef  !.1.!.!1!1Q...

; ----------------------------------------------------------------------
; DATOS musica_A5FD: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 12 (36 bytes)
;   0xa5fd..0xa621  (36 bytes)
DATA_musica_A5FD:
	defb 0e6h,0e9h,0d4h,0fch,041h,0e1h,003h,0c1h,001h,0c1h,021h,0c1h,001h,0e2h,0a1h,0a1h	; a5fd  ....A.....!.....
	defb 0c1h,0a1h,0c1h,0e1h,001h,0c1h,0e2h,0a1h,071h,0a1h,0e1h,001h,0e2h,0a1h,0e1h,001h	; a60d  ........q.......
	defb 021h,03eh,0ebh,0ffh	; a61d

; ----------------------------------------------------------------------
; DATOS musica_A621: partitura de un canal de musica (p14:8AD0); se solapan 3
;   bloques (0xA621-0xA671, 0xA62D-0xA671, 0xA64C-0xA671); lo leen musica 12
;   (80 bytes)
;   0xa621..0xa671  (80 bytes)
DATA_musica_A621:
	defb 0e6h,0e9h,0d4h,0fdh,033h,0e3h,000h,000h,0fch,033h,0e2h,001h,0fdh,033h,0e9h,0e3h	; a621  ....3....3...3..
	defb 001h,0fch,033h,0e2h,001h,0feh,002h,02dh,0a6h,0fdh,033h,0e3h,001h,0fch,033h,0e2h	; a631  ..3....-..3...3.
	defb 000h,000h,0fdh,033h,0e4h,0a0h,0a0h,0fch,033h,0e3h,0a1h,0e9h,0fdh,033h,0e4h,0a1h	; a641  ...3....3....3..
	defb 0fch,033h,0e3h,0a1h,0feh,002h,04ch,0a6h,0fdh,033h,0e4h,0a1h,0fch,033h,0e3h,0a0h	; a651  .3....L..3...3..
	defb 0a0h,0fdh,035h,0e4h,081h,081h,0c1h,0a1h,0a1h,0c1h,0fch,033h,0e3h,00fh,0ebh,0ffh	; a661  ..5........3....

; ----------------------------------------------------------------------
; DATOS musica_A671: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 13 (30 bytes)
;   0xa671..0xa68f  (30 bytes)
DATA_musica_A671:
	defb 0e6h,0e7h,0e9h,0d6h,0fdh,024h,0e2h,073h,0e1h,003h,0e2h,081h,051h,0b1h,0e1h,021h	; a671  .....$.s....Q..!
	defb 003h,0e2h,073h,081h,0e1h,001h,0e2h,0b0h,0e1h,030h,020h,050h,038h,0ffh	; a681  ..s......0 P8.

; ----------------------------------------------------------------------
; DATOS musica_A68F: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 13 (27 bytes)
;   0xa68f..0xa6aa  (27 bytes)
DATA_musica_A68F:
	defb 0e6h,0e9h,0d6h,0fch,022h,0e2h,000h,020h,030h,050h,073h,021h,0e3h,0b1h,0e2h,051h	; a68f  ....".. 0Ps!...Q
	defb 0b1h,073h,033h,051h,051h,071h,070h,0b0h,0e1h,008h,0ffh	; a69f  .s3QQqp....

; ----------------------------------------------------------------------
; DATOS musica_A6AA: partitura de un canal de musica (p14:8AD0); se solapan 3
;   bloques (0xA6AA-0xA6C4, 0xA6AF-0xA6C4, 0xA6B7-0xA6C4); lo leen musica 13
;   (26 bytes)
;   0xa6aa..0xa6c4  (26 bytes)
DATA_musica_A6AA:
	defb 0e6h,0e9h,0d6h,0fdh,035h,0e3h,000h,0e2h,000h,0feh,00ch,0afh,0a6h,0e3h,020h,0e2h	; a6aa  ....5......... .
	defb 020h,0feh,002h,0b7h,0a6h,0e4h,073h,0e3h,008h,0ffh	; a6ba   .....s...

; ----------------------------------------------------------------------
; DATOS musica_A6C4: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 14 (161 bytes)
;   0xa6c4..0xa765  (161 bytes)
DATA_musica_A6C4:
	defb 0e6h,0e9h,0d6h,0fbh,013h,0e1h,001h,0f8h,023h,000h,000h,0fbh,013h,0e2h,091h,0f8h	; a6c4  ........#.......
	defb 023h,090h,090h,0fbh,013h,0e1h,002h,020h,0f8h,023h,020h,020h,0fbh,013h,031h,0f8h	; a6d4  #...... .#  ..1.
	defb 023h,030h,030h,0fbh,013h,031h,021h,0f8h,023h,020h,020h,0fbh,013h,001h,0f8h,023h	; a6e4  #00..1!.#  ....#
	defb 000h,000h,0fbh,013h,0e2h,091h,0f8h,023h,090h,090h,0d4h,0fbh,013h,0e1h,031h,021h	; a6f4  .......#......1!
	defb 001h,0d6h,0e2h,093h,0e1h,002h,020h,0f8h,023h,020h,020h,0fbh,013h,001h,032h,020h	; a704  ...... .#  ...2
	defb 001h,043h,0e8h,001h,001h,011h,0e9h,092h,040h,031h,0f8h,023h,030h,030h,0fbh,013h	; a714  .C......@1.#00..
	defb 021h,0f9h,023h,020h,020h,0fbh,013h,002h,0e2h,090h,0f9h,023h,090h,090h,0fbh,013h	; a724  !.#  ......#....
	defb 091h,0e1h,001h,021h,031h,021h,0f8h,023h,020h,020h,0fbh,013h,001h,020h,000h,0e2h	; a734  ...!1!.#  ... ..
	defb 093h,0fah,023h,090h,090h,0e1h,020h,000h,0e2h,093h,0f9h,023h,090h,090h,0e1h,020h	; a744  ..#... ....#...
	defb 000h,0e2h,093h,090h,090h,0e1h,020h,000h,0e2h,093h,0fah,013h,090h,0b0h,0eah,0c4h	; a754  ...... .........
	defb 0a6h	; a764

; ----------------------------------------------------------------------
; DATOS musica_A765: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 14 (155 bytes)
;   0xa765..0xa800  (155 bytes)
DATA_musica_A765:
	defb 0e6h,0e9h,0d6h,0fbh,013h,0e2h,091h,0f8h,023h,090h,090h,0fbh,013h,041h,0f8h,023h	; a765  ........#....A.#
	defb 040h,040h,0fbh,013h,092h,0b0h,0f8h,023h,0b0h,0b0h,0fbh,013h,0e1h,001h,0f8h,023h	; a775  @@.....#.......#
	defb 000h,000h,0fbh,013h,001h,0e2h,0b1h,0f8h,023h,0b0h,0b0h,0fbh,013h,091h,0f8h,023h	; a785  ........#......#
	defb 090h,090h,0fbh,013h,041h,0f8h,023h,040h,040h,0d4h,0fbh,013h,0e1h,001h,0e2h,0b1h	; a795  ....A.#@@.......
	defb 091h,0d6h,043h,092h,0b0h,0f8h,013h,0b0h,0b0h,0fbh,023h,091h,0e1h,002h,0e2h,0b0h	; a7a5  ..C.......#.....
	defb 091h,0b3h,0e3h,041h,061h,081h,0e1h,042h,000h,001h,0f9h,023h,000h,000h,0fbh,013h	; a7b5  ...Aa..B...#....
	defb 0e2h,0b1h,0f9h,023h,0b0h,0b0h,0fbh,013h,092h,040h,0f9h,023h,040h,040h,0fbh,013h	; a7c5  ...#.....@.#@@..
	defb 041h,091h,0b1h,0e1h,001h,0e2h,0b1h,0f8h,023h,0b0h,0b0h,0fbh,013h,091h,0b0h,090h	; a7d5  A.......#.......
	defb 043h,0fah,023h,040h,040h,0b0h,090h,043h,0f9h,023h,040h,040h,0b0h,090h,043h,040h	; a7e5  C.#@@..C.#@@..C@
	defb 040h,0b0h,090h,043h,0fah,013h,040h,080h,0eah,065h,0a7h	; a7f5  @..C..@..e.

; ----------------------------------------------------------------------
; DATOS musica_A800: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 14 (34 bytes)
;   0xa800..0xa822  (34 bytes)
DATA_musica_A800:
	defb 0e6h,0e9h,0d6h,0fdh,023h,0e4h,091h,0e8h,001h,0e9h,091h,0e8h,001h,0e9h,071h,0e8h	; a800  ....#.........q.
	defb 001h,0e9h,071h,0e8h,011h,0e9h,052h,050h,0e8h,001h,0e9h,043h,041h,061h,081h,0eah	; a810  ..q...RP...CAa..
	defb 000h,0a8h	; a820

; ----------------------------------------------------------------------
; DATOS musica_A822: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 15 (1 bytes)
;   0xa822..0xa823  (1 bytes)
DATA_musica_A822:
	defb 0ffh	; a822

; ----------------------------------------------------------------------
; DATOS musica_A823: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 0 (16 bytes)
;   0xa823..0xa833  (16 bytes)
DATA_musica_A823:
	defb 020h,020h,0c0h,000h,0c0h,0e2h,0b5h,021h,040h,050h,070h,092h,022h,091h,070h,0eeh	; a823    .....!@Pp.".p.

; ----------------------------------------------------------------------
; DATOS musica_A833: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 0 (7 bytes)
;   0xa833..0xa83a  (7 bytes)
DATA_musica_A833:
	defb 012h,042h,0a1h,092h,052h,021h,0eeh	; a833

; ----------------------------------------------------------------------
; DATOS musica_A83A: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 0 (16 bytes)
;   0xa83a..0xa84a  (16 bytes)
DATA_musica_A83A:
	defb 0e0h,020h,020h,0e1h,020h,025h,0c6h,0e3h,0a0h,0c0h,0a0h,0c0h,0e2h,020h,052h,0eeh	; a83a  .  . %....... R.

; ----------------------------------------------------------------------
; DATOS musica_A84A: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 0 (21 bytes)
;   0xa84a..0xa85f  (21 bytes)
DATA_musica_A84A:
	defb 0fdh,052h,0e3h,021h,020h,020h,0c0h,020h,001h,021h,0c5h,0e4h,0a1h,0a1h,0fch,02bh	; a84a  .R.!  . .!.....+
	defb 0e3h,0a0h,0e2h,022h,0eeh	; a85a

; ----------------------------------------------------------------------
; DATOS musica_A85F: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 0 (7 bytes)
;   0xa85f..0xa866  (7 bytes)
DATA_musica_A85F:
	defb 000h,000h,000h,000h,000h,000h,0eeh	; a85f

; ----------------------------------------------------------------------
; DATOS musica_A866: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (33 bytes)
;   0xa866..0xa887  (33 bytes)
DATA_musica_A866:
	defb 0e2h,091h,081h,091h,081h,091h,021h,051h,091h,0c1h,091h,081h,091h,021h,051h,0c1h	; a866  ......!Q.....!Q.
	defb 091h,021h,051h,0e1h,003h,0c1h,0e2h,021h,051h,0f9h,000h,0e1h,003h,0fah,000h,003h	; a876  .!Q....!Q.......
	defb 0eeh	; a886

; ----------------------------------------------------------------------
; DATOS musica_A887: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (37 bytes)
;   0xa887..0xa8ac  (37 bytes)
DATA_musica_A887:
	defb 0fch,027h,0e3h,021h,021h,021h,021h,021h,021h,021h,021h,021h,020h,020h,021h,021h	; a887  .'.!!!!!!!!!  !!
	defb 021h,021h,021h,021h,0e4h,0a1h,0a0h,0a0h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h	; a897  !!!!............
	defb 0fdh,025h,0a1h,0a1h,0eeh	; a8a7

; ----------------------------------------------------------------------
; DATOS musica_A8AC: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (11 bytes)
;   0xa8ac..0xa8b7  (11 bytes)
DATA_musica_A8AC:
	defb 001h,001h,0e8h,041h,0e9h,001h,001h,001h,021h,041h,0eeh	; a8ac  ...A....!A.

; ----------------------------------------------------------------------
; DATOS musica_A8B7: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (11 bytes)
;   0xa8b7..0xa8c2  (11 bytes)
DATA_musica_A8B7:
	defb 021h,021h,0e8h,041h,0e9h,021h,021h,021h,041h,051h,0eeh	; a8b7  !!.A.!!!AQ.

; ----------------------------------------------------------------------
; DATOS musica_A8C2: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 1 (9 bytes)
;   0xa8c2..0xa8cb  (9 bytes)
DATA_musica_A8C2:
	defb 021h,021h,050h,090h,0e8h,000h,000h,010h,0eeh	; a8c2  !!P......

; ----------------------------------------------------------------------
; DATOS musica_A8CB: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (9 bytes)
;   0xa8cb..0xa8d4  (9 bytes)
DATA_musica_A8CB:
	defb 051h,091h,051h,091h,0e1h,021h,0e8h,041h,0eeh	; a8cb  Q.Q..!.A.

; ----------------------------------------------------------------------
; DATOS musica_A8D4: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (11 bytes)
;   0xa8d4..0xa8df  (11 bytes)
DATA_musica_A8D4:
	defb 001h,0e2h,071h,0e1h,001h,0e2h,071h,041h,0e8h,041h,0eeh	; a8d4  ..q...qA.A.

; ----------------------------------------------------------------------
; DATOS musica_A8DF: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 5 (8 bytes)
;   0xa8df..0xa8e7  (8 bytes)
DATA_musica_A8DF:
	defb 081h,071h,061h,051h,041h,031h,021h,0eeh	; a8df  .qaQA1!.

; ----------------------------------------------------------------------
; DATOS musica_A8E7: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 5 (7 bytes)
;   0xa8e7..0xa8ee  (7 bytes)
DATA_musica_A8E7:
	defb 000h,000h,000h,000h,000h,000h,0eeh	; a8e7

; ----------------------------------------------------------------------
; DATOS musica_A8EE: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 5 (8 bytes)
;   0xa8ee..0xa8f6  (8 bytes)
DATA_musica_A8EE:
	defb 001h,000h,000h,030h,000h,000h,000h,0eeh	; a8ee  ...0....

; ----------------------------------------------------------------------
; DATOS musica_A8F6: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 6 (7 bytes)
;   0xa8f6..0xa8fd  (7 bytes)
DATA_musica_A8F6:
	defb 043h,033h,023h,013h,023h,033h,0eeh	; a8f6

; ----------------------------------------------------------------------
; DATOS musica_A8FD: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 6 (21 bytes)
;   0xa8fd..0xa912  (21 bytes)
DATA_musica_A8FD:
	defb 0fch,022h,043h,0fah,023h,033h,023h,013h,023h,0fbh,023h,033h,043h,033h,0fah,023h	; a8fd  ."C.#3#.#.#3C3.#
	defb 023h,013h,023h,033h,0eeh	; a90d

; ----------------------------------------------------------------------
; DATOS musica_A912: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 6 (21 bytes)
;   0xa912..0xa927  (21 bytes)
DATA_musica_A912:
	defb 0fch,022h,093h,0fah,023h,083h,073h,063h,073h,0fbh,023h,083h,093h,083h,0fah,023h	; a912  ."..#.scs.#....#
	defb 073h,063h,073h,083h,0eeh	; a922

; ----------------------------------------------------------------------
; DATOS musica_A927: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 6 (7 bytes)
;   0xa927..0xa92e  (7 bytes)
DATA_musica_A927:
	defb 043h,033h,023h,013h,023h,033h,0eeh	; a927

; ----------------------------------------------------------------------
; DATOS musica_A92E: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 11 (5 bytes)
;   0xa92e..0xa933  (5 bytes)
DATA_musica_A92E:
	defb 000h,000h,001h,001h,0eeh	; a92e

; ----------------------------------------------------------------------
; DATOS musica_A933: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 0 (6 bytes)
;   0xa933..0xa939  (6 bytes)
DATA_musica_A933:
	defb 0e8h,010h,000h,000h,000h,0eeh	; a933

; ----------------------------------------------------------------------
; DATOS musica_A939: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 0 (20 bytes)
;   0xa939..0xa94d  (20 bytes)
DATA_musica_A939:
	defb 0fdh,074h,0e3h,021h,020h,020h,022h,020h,021h,020h,020h,020h,020h,020h,020h,0e4h	; a939  .t.!  " !      .
	defb 0a1h,0a0h,0a0h,0eeh	; a949

; ----------------------------------------------------------------------
; DATOS musica_A94D: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 0 (6 bytes)
;   0xa94d..0xa953  (6 bytes)
DATA_musica_A94D:
	defb 0e8h,030h,030h,030h,000h,0eeh	; a94d

; ----------------------------------------------------------------------
; DATOS musica_A953: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 1 (14 bytes)
;   0xa953..0xa961  (14 bytes)
DATA_musica_A953:
	defb 0e3h,021h,021h,050h,090h,0c3h,021h,070h,0b2h,021h,021h,050h,092h,0eeh	; a953  .!!P..!p.!!P..

; ----------------------------------------------------------------------
; DATOS musica_A961: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 1 (10 bytes)
;   0xa961..0xa96b  (10 bytes)
DATA_musica_A961:
	defb 0e4h,0a0h,0a0h,0a0h,090h,090h,090h,080h,080h,0eeh	; a961  ..........

; ----------------------------------------------------------------------
; DATOS musica_A96B: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 1 (13 bytes)
;   0xa96b..0xa978  (13 bytes)
DATA_musica_A96B:
	defb 0e1h,001h,000h,0e2h,0b1h,0b0h,0a1h,091h,090h,081h,080h,071h,0eeh	; a96b  ...........q.

; ----------------------------------------------------------------------
; DATOS musica_A978: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (5 bytes)
;   0xa978..0xa97d  (5 bytes)
DATA_musica_A978:
	defb 0e4h,090h,090h,091h,0eeh	; a978

; ----------------------------------------------------------------------
; DATOS musica_A97D: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (8 bytes)
;   0xa97d..0xa985  (8 bytes)
DATA_musica_A97D:
	defb 021h,021h,021h,021h,021h,021h,021h,0eeh	; a97d  !!!!!!!.

; ----------------------------------------------------------------------
; DATOS musica_A985: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (8 bytes)
;   0xa985..0xa98d  (8 bytes)
DATA_musica_A985:
	defb 001h,001h,001h,001h,001h,001h,001h,0eeh	; a985  ........

; ----------------------------------------------------------------------
; DATOS musica_A98D: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (9 bytes)
;   0xa98d..0xa996  (9 bytes)
DATA_musica_A98D:
	defb 0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0eeh	; a98d  .........

; ----------------------------------------------------------------------
; DATOS musica_A996: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 2 (6 bytes)
;   0xa996..0xa99c  (6 bytes)
DATA_musica_A996:
	defb 091h,091h,091h,091h,091h,0eeh	; a996

; ----------------------------------------------------------------------
; DATOS musica_A99C: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 3 (15 bytes)
;   0xa99c..0xa9ab  (15 bytes)
DATA_musica_A99C:
	defb 0e4h,070h,070h,0c0h,070h,070h,0c0h,0e2h,073h,0e3h,000h,020h,051h,091h,0eeh	; a99c  .pp.pp..s.. Q..

; ----------------------------------------------------------------------
; DATOS musica_A9AB: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 3 (9 bytes)
;   0xa9ab..0xa9b4  (9 bytes)
DATA_musica_A9AB:
	defb 0fch,026h,0e3h,031h,030h,0fbh,041h,0e2h,0eeh	; a9ab  .&.10.A..

; ----------------------------------------------------------------------
; DATOS musica_A9B4: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 5 (7 bytes)
;   0xa9b4..0xa9bb  (7 bytes)
DATA_musica_A9B4:
	defb 013h,0c5h,013h,011h,043h,0c5h,0eeh	; a9b4

; ----------------------------------------------------------------------
; DATOS musica_A9BB: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 6 (20 bytes)
;   0xa9bb..0xa9cf  (20 bytes)
DATA_musica_A9BB:
	defb 087h,0f9h,058h,083h,083h,083h,0fah,058h,083h,083h,083h,0fbh,058h,083h,083h,0fdh	; a9bb  ..X....X....X...
	defb 023h,085h,0c1h,0eeh	; a9cb

; ----------------------------------------------------------------------
; DATOS musica_A9CF: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 10 (9 bytes)
;   0xa9cf..0xa9d8  (9 bytes)
DATA_musica_A9CF:
	defb 021h,031h,071h,061h,071h,061h,051h,061h,0eeh	; a9cf  !1qaqaQa.

; ----------------------------------------------------------------------
; DATOS musica_A9D8: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 4 (53 bytes)
;   0xa9d8..0xaa0d  (53 bytes)
DATA_musica_A9D8:
	defb 0fdh,046h,0e1h,071h,001h,051h,000h,032h,001h,021h,001h,0fch,044h,0e2h,0c0h,000h	; a9d8  .F.q.Q.2.!..D...
	defb 020h,030h,021h,000h,032h,001h,021h,001h,0feh,002h,0d8h,0a9h,0fdh,045h,0e2h,082h	; a9e8   0!.2.!......E..
	defb 0e1h,000h,0c1h,033h,0e2h,081h,0e1h,001h,031h,0e2h,0a2h,0e1h,020h,0c1h,053h,0e2h	; a9f8  ...3....1... .S.
	defb 0a1h,0e1h,021h,051h,0eeh	; aa08

; ----------------------------------------------------------------------
; DATOS musica_AA0D: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 4 (20 bytes)
;   0xaa0d..0xaa21  (20 bytes)
DATA_musica_AA0D:
	defb 0e1h,000h,070h,050h,070h,030h,070h,020h,070h,000h,070h,0e2h,0b0h,0e1h,070h,000h	; aa0d  ..pPp0p p.p...p.
	defb 070h,020h,070h,0eeh	; aa1d

; ----------------------------------------------------------------------
; DATOS musica_AA21: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 4 (56 bytes)
;   0xaa21..0xaa59  (56 bytes)
DATA_musica_AA21:
	defb 0e9h,0d7h,0fdh,065h,0e3h,001h,001h,001h,001h,001h,000h,000h,031h,050h,050h,001h	; aa21  ...e........1PP.
	defb 000h,000h,001h,001h,001h,001h,031h,050h,050h,0feh,002h,021h,0aah,0e4h,081h,080h	; aa31  ......1PP..!....
	defb 080h,081h,080h,080h,081h,080h,080h,0a1h,0e3h,001h,0e4h,0a1h,0a0h,0a0h,0a1h,0a0h	; aa41  ................
	defb 0a0h,0a1h,0a0h,0a0h,0e3h,001h,021h,0eeh	; aa51  ......!.

; ----------------------------------------------------------------------
; DATOS musica_AA59: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 4 (58 bytes)
;   0xaa59..0xaa93  (58 bytes)
DATA_musica_AA59:
	defb 0fch,046h,0e1h,001h,0e2h,071h,0e1h,001h,0e2h,070h,0e1h,002h,0e2h,071h,0b1h,071h	; aa59  .F...q...p...q.q
	defb 0fbh,044h,0e1h,0c0h,000h,020h,030h,021h,000h,032h,001h,021h,001h,0feh,002h,059h	; aa69  .D... 0!.2.!...Y
	defb 0aah,0fch,044h,0e2h,032h,080h,0c1h,0e1h,003h,0e2h,031h,081h,0e1h,001h,0e2h,052h	; aa79  ..D.2.....1....R
	defb 0a0h,0c1h,0e1h,023h,0e2h,051h,0a1h,0e1h,021h,0eeh	; aa89  ...#.Q..!.

; ----------------------------------------------------------------------
; DATOS musica_AA93: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 4 (20 bytes)
;   0xaa93..0xaaa7  (20 bytes)
DATA_musica_AA93:
	defb 0e1h,000h,070h,050h,070h,030h,070h,020h,070h,000h,070h,0e2h,0b0h,0e1h,070h,000h	; aa93  ..pPp0p p.p...p.
	defb 070h,020h,070h,0eeh	; aaa3

; ----------------------------------------------------------------------
; DATOS musica_AAA7: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 7 (25 bytes)
;   0xaaa7..0xaac0  (25 bytes)
DATA_musica_AAA7:
	defb 0d1h,0f6h,000h,0e3h,001h,0f7h,000h,001h,0f8h,000h,002h,0f9h,000h,001h,0fah,000h	; aaa7  ................
	defb 001h,0fbh,000h,002h,0d7h,0fch,000h,005h,0eeh	; aab7  .........

; ----------------------------------------------------------------------
; DATOS musica_AAC0: partitura de un canal de musica (p14:8AD0); lo leen
;   musica 7 (25 bytes)
;   0xaac0..0xaad9  (25 bytes)
DATA_musica_AAC0:
	defb 0d1h,0f6h,000h,0e4h,0b1h,0f7h,000h,0b1h,0f8h,000h,0b2h,0f9h,000h,0b1h,0fah,000h	; aac0  ................
	defb 0b1h,0fbh,000h,0b2h,0d7h,0fch,000h,0b5h,0eeh	; aad0  .........

; ----------------------------------------------------------------------
; DATOS percusion_AAD9: 12 punteros, uno por nota, al guion del golpe de
;   percusion que suena en su lugar; lo leen p14:8B5A (24 bytes)
;   0xaad9..0xaaf1  (24 bytes)
DATA_percusion_AAD9:
	defb 009h,0abh	; aad9
	defb 00fh,0abh	; aadb
	defb 01fh,0abh	; aadd
	defb 032h,0abh	; aadf
	defb 048h,0abh	; aae1
	defb 063h,0abh	; aae3
	defb 063h,0abh	; aae5
	defb 063h,0abh	; aae7
	defb 063h,0abh	; aae9
	defb 063h,0abh	; aaeb
	defb 063h,0abh	; aaed
	defb 063h,0abh	; aaef

; ----------------------------------------------------------------------
; DATOS percusion_AAF1: 12 punteros, uno por nota, al guion del golpe de
;   percusion que suena en su lugar (canales con el bit 2); lo leen p14:8B7B
;   (24 bytes)
;   0xaaf1..0xab09  (24 bytes)
DATA_percusion_AAF1:
	defb 063h,0abh	; aaf1
	defb 076h,0abh	; aaf3
	defb 076h,0abh	; aaf5
	defb 089h,0abh	; aaf7
	defb 09ch,0abh	; aaf9
	defb 0afh,0abh	; aafb
	defb 0c2h,0abh	; aafd
	defb 0c2h,0abh	; aaff
	defb 0d5h,0abh	; ab01
	defb 0e8h,0abh	; ab03
	defb 0fbh,0abh	; ab05
	defb 0fbh,0abh	; ab07

; ----------------------------------------------------------------------
; DATOS golpe_AB09: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (6 bytes)
;   0xab09..0xab0f  (6 bytes)
DATA_golpe_AB09:
	defb 021h,001h,010h,0d0h,000h,0ffh	; ab09

; ----------------------------------------------------------------------
; DATOS golpe_AB0F: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (16 bytes)
;   0xab0f..0xab1f  (16 bytes)
DATA_golpe_AB0F:
	defb 021h,002h,010h,0d0h,000h,021h,010h,010h,0b0h,000h,021h,010h,010h,090h,000h,0ffh	; ab0f  !....!....!.....

; ----------------------------------------------------------------------
; DATOS golpe_AB1F: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xab1f..0xab32  (19 bytes)
DATA_golpe_AB1F:
	defb 023h,001h,010h,0dah,000h,021h,004h,010h,0b0h,000h,0a0h,000h,090h,000h,080h,000h	; ab1f  #....!..........
	defb 070h,000h,0ffh	; ab2f

; ----------------------------------------------------------------------
; DATOS golpe_AB32: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (22 bytes)
;   0xab32..0xab48  (22 bytes)
DATA_golpe_AB32:
	defb 021h,001h,015h,0c0h,006h,022h,001h,0c2h,000h,021h,002h,018h,080h,006h,070h,006h	; ab32  !...."...!....p.
	defb 021h,001h,013h,060h,006h,0ffh	; ab42

; ----------------------------------------------------------------------
; DATOS golpe_AB48: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (27 bytes)
;   0xab48..0xab63  (27 bytes)
DATA_golpe_AB48:
	defb 022h,001h,0c1h,0b3h,0c1h,097h,0b1h,0e4h,0b2h,098h,0a2h,0b8h,0a2h,0d2h,022h,003h	; ab48  ".............".
	defb 093h,085h,022h,004h,083h,0e0h,084h,03dh,074h,098h,0ffh	; ab58  .."....=t..

; ----------------------------------------------------------------------
; DATOS golpe_AB63: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xab63..0xab76  (19 bytes)
DATA_golpe_AB63:
	defb 022h,004h,090h,036h,080h,036h,070h,036h,060h,036h,050h,036h,040h,036h,030h,036h	; ab63  "..6.6p6`6P6@606
	defb 020h,036h,0ffh	; ab73

; ----------------------------------------------------------------------
; DATOS golpe_AB76: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xab76..0xab89  (19 bytes)
DATA_golpe_AB76:
	defb 022h,004h,090h,02fh,080h,02fh,070h,02fh,060h,02fh,050h,02fh,040h,02fh,030h,02fh	; ab76  ".././p/`/P/@/0/
	defb 020h,02fh,0ffh	; ab86

; ----------------------------------------------------------------------
; DATOS golpe_AB89: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xab89..0xab9c  (19 bytes)
DATA_golpe_AB89:
	defb 022h,004h,0a0h,02dh,090h,02dh,080h,02dh,070h,02dh,060h,02dh,050h,02dh,040h,02dh	; ab89  "..-.-.-p-`-P-@-
	defb 030h,02dh,0ffh	; ab99

; ----------------------------------------------------------------------
; DATOS golpe_AB9C: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xab9c..0xabaf  (19 bytes)
DATA_golpe_AB9C:
	defb 022h,004h,0a0h,02ah,090h,02ah,080h,02ah,070h,02ah,060h,02ah,050h,02ah,040h,02ah	; ab9c  "..*.*.*p*`*P*@*
	defb 030h,02ah,0ffh	; abac

; ----------------------------------------------------------------------
; DATOS golpe_ABAF: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xabaf..0xabc2  (19 bytes)
DATA_golpe_ABAF:
	defb 022h,004h,0a0h,028h,090h,028h,080h,028h,070h,028h,060h,028h,050h,028h,040h,028h	; abaf  "..(.(.(p(`(P(@(
	defb 030h,028h,0ffh	; abbf

; ----------------------------------------------------------------------
; DATOS golpe_ABC2: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xabc2..0xabd5  (19 bytes)
DATA_golpe_ABC2:
	defb 022h,004h,0a0h,024h,090h,024h,080h,024h,070h,024h,060h,024h,050h,024h,040h,024h	; abc2  "..$.$.$p$`$P$@$
	defb 030h,024h,0ffh	; abd2

; ----------------------------------------------------------------------
; DATOS golpe_ABD5: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xabd5..0xabe8  (19 bytes)
DATA_golpe_ABD5:
	defb 022h,004h,0a0h,022h,090h,022h,080h,022h,070h,022h,060h,022h,050h,022h,040h,022h	; abd5  ".."."."p"`"P"@"
	defb 030h,022h,0ffh	; abe5

; ----------------------------------------------------------------------
; DATOS golpe_ABE8: guion de un golpe de percusion (p14:8CA7); lo leen
;   p14:8B68 (19 bytes)
;   0xabe8..0xabfb  (19 bytes)
DATA_golpe_ABE8:
	defb 022h,004h,0a0h,020h,090h,020h,080h,020h,070h,020h,060h,020h,050h,020h,040h,020h	; abe8  ".. . . p ` P @
	defb 030h,020h,0ffh	; abf8

; ----------------------------------------------------------------------
; DATOS dibujos_ABFB: 8 dibujos de 8x8 a 4 bits (32 bytes cada uno); se
;   solapan 8 bloques (0xABFB-0xACFB, 0xABFB-0xBFDC, 0xACFB-0xAD3B,
;   0xAD3B-0xAD7B, 0xAD7B-0xAD9B, 0xAD9B-0xBB1B); lo leen nadie, p00:589D,
;   p00:58A8, p00:58B3, p00:58BE, p00:58C9, p00:5993, p14:8B68 (5089 bytes)
;   0xabfb..0xbfdc  (5089 bytes)
DATA_dibujos_ABFB:
	defb 00bh,0bbh,0bbh,0bbh,000h,000h,000h,000h,0bbh,0bbh,00bh,0bbh,000h,000h,000h,000h,00ah,0ddh,0ddh,0ddh,00bh,0bbh,0bbh,0bbh,000h,000h,000h,000h,0ddh,0dbh,00ah,0adh	; abfb  ................................
	defb 000h,000h,000h,000h,000h,0cah,0aah,0aah,00ah,0aah,0aah,0aah,00ah,0aah,0aah,0aah,00ah,0aah,0aah,0aah,00ah,0aah,0aah,0aah,00ah,0aah,0aah,0aah,000h,099h,099h,099h	; ac1b  ................................
	defb 000h,000h,000h,000h,0aah,0aah,0aah,0a0h,0aah,0aah,0aah,0a9h,0aah,0aah,0aah,0a9h,0aah,0aah,0aah,0a9h,0aah,0aah,0aah,0a9h,0aah,0aah,0aah,099h,099h,099h,099h,090h	; ac3b  ................................
	defb 000h,000h,000h,000h,000h,0cah,0aah,090h,00ch,0aah,0aah,090h,00ah,0aah,0aah,090h,00ah,0aah,0aah,090h,00ah,0aah,0aah,090h,00ah,0aah,0aah,090h,000h,099h,099h,090h	; ac5b  ................................
	defb 000h,000h,000h,000h,009h,0aah,0aah,0a9h,009h,0aah,0aah,0a9h,009h,0aah,0aah,0a9h,009h,0aah,0aah,0a9h,009h,0aah,0aah,0a9h,009h,0aah,0aah,099h,009h,099h,099h,090h	; ac7b  ................................
	defb 0ddh,0dbh,00dh,0ddh,0bbh,0bbh,00bh,0bbh,000h,000h,000h,000h,00dh,0ddh,0ddh,0dbh,00bh,0bbh,0bbh,0bbh,000h,000h,000h,000h,0bbh,0bbh,00bh,0bbh,000h,000h,000h,000h	; ac9b  ................................
	defb 000h,000h,000h,000h,09ah,0c0h,09ah,0ceh,09ah,0a0h,09ah,0cch,099h,0a0h,09ah,0cch,000h,000h,000h,000h,099h,0ach,0cch,0a0h,099h,0aah,0cch,0a0h,099h,0aah,0cch,0a0h	; acbb  ................................
	defb 000h,000h,000h,000h,0cch,0a9h,00ch,0a9h,0cch,0a9h,00ch,0a9h,0cch,0a9h,00ch,099h,000h,000h,000h,000h,0aeh,0cch,0cch,0a9h,0ach,0cch,0cah,0a9h,0ach,0cah,0aah,0a9h	; acdb  ................................
	defb 005h,055h,055h,055h,000h,044h,044h,044h,009h,007h,077h,077h,009h,090h,0ddh,0ddh,009h,0a9h,00dh,0ddh,009h,0aah,090h,0bbh,009h,0aah,0a9h,00bh,000h,000h,000h,000h	; acfb  .UUU.DDD..ww....................
	defb 055h,055h,055h,055h,055h,055h,055h,055h,054h,055h,055h,055h,054h,075h,055h,055h,054h,07dh,05bh,0bbh,054h,07dh,0d5h,0ddh,054h,07dh,0dbh,057h,054h,07dh,0dbh,0b5h	; ad1b  UUUUUUUUTUUUTuUUT}[.T}..T}.WT}..
	defb 055h,055h,055h,055h,044h,044h,044h,044h,077h,077h,077h,077h,0ddh,0ddh,0ddh,0ddh,0ddh,0ddh,0ddh,0ddh,0bbh,0bbh,0bbh,0bbh,0bbh,0bbh,0bbh,0bbh,055h,055h,055h,055h	; ad3b  UUUUDDDDwwww................UUUU
	defb 055h,055h,055h,055h,055h,055h,055h,055h,055h,055h,055h,055h,055h,055h,055h,055h,0bbh,0bbh,0bbh,0bbh,0ddh,0ddh,0ddh,0ddh,077h,077h,077h,077h,000h,000h,000h,000h	; ad5b  UUUUUUUUUUUUUUUU........wwww....
	defb 054h,07dh,0dbh,050h,054h,07dh,0dbh,050h,054h,07dh,0dbh,050h,054h,07dh,0dbh,050h,054h,07dh,0dbh,050h,054h,07dh,0dbh,050h,054h,07dh,0dbh,050h,054h,07dh,0dbh,050h	; ad7b  T}.PT}.PT}.PT}.PT}.PT}.PT}.PT}.P
	defb 099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,099h,0a9h,099h	; ad9b  ................................
	defb 0aah,0a9h,099h,099h,09ah,099h,099h,099h,0a9h,099h,099h,099h,099h,099h,099h,0a9h,099h,099h,09ah,099h,099h,099h,099h,099h,099h,099h,0aah,099h,099h,099h,0a9h,099h	; adbb  ................................
	defb 099h,099h,0aah,099h,099h,099h,0aah,099h,099h,09ah,0a9h,099h,099h,09ah,0a9h,099h,099h,0a9h,099h,090h,099h,099h,099h,000h,099h,0a9h,099h,000h,099h,099h,099h,000h	; addb  ................................
	defb 099h,090h,000h,000h,090h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; adfb  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h	; ae1b  ...............................P
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,000h,0bbh,0bdh,0ddh	; ae3b  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ddh,050h,000h,000h	; ae5b  .............................P..
	defb 099h,09ah,09ah,099h,099h,0a9h,099h,099h,099h,0a9h,0a9h,099h,099h,0aah,0a9h,099h,09ah,09ah,099h,099h,0aah,0aah,099h,0a9h,0aah,0aah,099h,09ah,09ch,0a9h,09ah,09ah	; ae7b  ................................
	defb 099h,09ah,0a9h,099h,099h,09ah,099h,099h,099h,0aah,09ah,099h,09ah,0aah,099h,099h,0aah,0aah,099h,099h,0ach,0a9h,099h,099h,0aah,0aah,099h,099h,0cah,09ah,099h,099h	; ae9b  ................................
	defb 099h,099h,099h,000h,099h,099h,090h,000h,099h,099h,090h,000h,099h,099h,090h,000h,099h,099h,090h,000h,099h,099h,000h,000h,099h,090h,000h,000h,099h,090h,000h,000h	; aebb  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,000h,0b0h,000h,000h,000h	; aedb  ................................
	defb 000h,005h,000h,000h,000h,055h,000h,00bh,000h,000h,000h,007h,000h,000h,000h,0bbh,000h,000h,007h,07bh,000h,000h,00bh,0b7h,000h,000h,07bh,0bbh,000h,000h,0bbh,0bbh	; aefb  .....U.............{......{.....
	defb 0bbh,0bbh,0bbh,0bbh,077h,07bh,000h,077h,0b0h,077h,057h,057h,0b7h,077h,077h,077h,077h,070h,077h,077h,0b7h,077h,0d7h,0b7h,077h,0ddh,077h,040h,0bdh,07dh,0d7h,077h	; af1b  ....w{.w.wWW.wwwwpww.w..w.w@.}.w
	defb 0ddh,0ddh,000h,000h,0bdh,0ddh,0d0h,000h,0d7h,0ddh,0d0h,000h,075h,07dh,07dh,000h,005h,057h,07dh,050h,077h,047h,07dh,0d0h,044h,075h,077h,0ddh,07bh,04bh,05bh,0ddh	; af3b  ............u}}..W}PwG}.Duw.{K[.
	defb 09ch,0cah,099h,0ach,09ah,0eah,0aah,0ceh,09ah,0cch,0aah,0eeh,099h,0aeh,0ach,0ech,099h,09ah,0aeh,0cah,099h,0aah,0cch,0aah,099h,09ah,0cah,0cah,099h,0aah,0cah,0a0h	; af5b  ................................
	defb 0a9h,0aah,099h,099h,0aah,099h,099h,099h,0aah,0a9h,099h,0c9h,0ach,0a9h,099h,099h,0aah,099h,099h,099h,0a9h,099h,099h,09ah,099h,09ch,099h,0aah,000h,099h,09ah,0aah	; af7b  ................................
	defb 099h,090h,000h,00dh,099h,090h,000h,00dh,099h,000h,000h,000h,099h,000h,000h,000h,0a9h,000h,000h,000h,099h,000h,000h,0d0h,09ah,000h,000h,000h,099h,000h,000h,0d0h	; af9b  ................................
	defb 005h,000h,000h,000h,000h,050h,000h,000h,0b0h,000h,000h,000h,0b0h,000h,000h,050h,005h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,050h,000h,000h,007h	; afbb  .....P.........P........P...P...
	defb 050h,00bh,047h,07bh,000h,0b7h,075h,0bbh,00bh,077h,055h,0bdh,00bh,0ddh,05bh,05bh,0bdh,0d5h,0bbh,0dbh,0bbh,05bh,0bdh,0bdh,07bh,05bh,05dh,0bbh,0bbh,0b5h,05dh,0b0h	; afdb  P.G{..u..wU...[[.....[..{[]...].
	defb 0b4h,0d4h,044h,040h,07dh,0b7h,000h,07bh,0bbh,0ddh,000h,05bh,0bdh,0b0h,0b4h,070h,0dbh,000h,05bh,0bbh,0b0h,004h,074h,07bh,000h,0b4h,07bh,0bbh,000h,0bbh,044h,075h	; affb  ..D@}..{...[...p..[...t{..{...Du
	defb 075h,044h,0bbh,0bdh,044h,04bh,074h,0bdh,077h,004h,007h,07bh,04bh,047h,0b4h,07bh,077h,04bh,04bh,0b4h,00bh,04bh,04bh,0bbh,045h,047h,0b4h,074h,07bh,0b4h,0b4h,044h	; b01b  uD..DKt.w..{KG.{wKK..KK.EG.t{..D
	defb 050h,000h,000h,000h,0d0h,000h,000h,000h,070h,000h,000h,006h,0b7h,000h,000h,066h,077h,000h,006h,066h,04bh,000h,006h,066h,077h,070h,006h,066h,047h,070h,006h,066h	; b03b  P.......p......fw..fK..fwp.fGp.f
	defb 099h,0aah,0cah,090h,099h,09ah,0aah,090h,099h,09ah,0cah,0a0h,099h,09ah,0aah,099h,099h,09ah,0a9h,099h,099h,099h,0aah,099h,099h,099h,0aah,099h,099h,099h,099h,0a9h	; b05b  ................................
	defb 070h,000h,09ah,0cah,057h,050h,000h,0cah,005h,0d5h,000h,00ah,005h,0ddh,050h,000h,000h,057h,0d5h,005h,000h,00bh,0ddh,000h,090h,000h,0bdh,0b0h,090h,050h,0bdh,0dbh	; b07b  p...WP........P..W...........P..
	defb 0a9h,000h,000h,00bh,090h,000h,000h,000h,0a0h,000h,000h,000h,0a0h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b09b  ....................P...........
	defb 000h,000h,000h,000h,055h,000h,000h,00bh,000h,000h,000h,00dh,0b0h,000h,005h,00dh,055h,000h,000h,00dh,005h,000h,000h,00dh,005h,000h,000h,00dh,000h,000h,000h,0dbh	; b0bb  ....U...........U...............
	defb 07bh,0bbh,0bbh,000h,0bbh,0b5h,0dbh,000h,0b7h,0b5h,050h,000h,0d5h,055h,0b0h,000h,0b5h,05bh,0b0h,000h,0bbh,0bbh,000h,000h,0bbh,07bh,000h,000h,0bbh,0b0h,000h,000h	; b0db  {.........P..U...[.......{......
	defb 000h,0bbh,047h,04bh,00bh,0bbh,054h,0b4h,00bh,0b7h,00bh,044h,00bh,070h,0b7h,0bbh,05bh,077h,0b7h,077h,0bbh,005h,075h,077h,0b7h,00bh,057h,07bh,0b5h,05bh,0bbh,0b5h	; b0fb  ..GK..T....D.p..[w.w..uw..W{.[..
	defb 074h,044h,0b4h,0bbh,054h,044h,04bh,074h,077h,075h,0b4h,044h,057h,05bh,05bh,0b0h,05bh,077h,0b0h,0b4h,07bh,077h,0b0h,050h,0b5h,075h,0bbh,0bbh,0b7h,077h,0bbh,077h	; b11b  tD..TDKtwu.DW[[.[w..{w.P.u...w.w
	defb 044h,0b0h,006h,066h,0b4h,077h,000h,066h,047h,077h,000h,066h,075h,007h,000h,006h,0b7h,07bh,070h,000h,0b0h,077h,070h,000h,00bh,070h,077h,000h,00bh,007h,0b7h,000h	; b13b  D..f.w.fGw.fu....{p..wp..pw.....
	defb 099h,099h,099h,099h,0a9h,099h,099h,09ah,099h,099h,099h,099h,099h,099h,099h,099h,09ah,0a9h,099h,099h,099h,099h,099h,099h,099h,0a9h,099h,099h,099h,099h,099h,0a9h	; b15b  ................................
	defb 090h,000h,00bh,0ddh,099h,005h,00bh,0bdh,099h,000h,000h,0bbh,099h,090h,000h,05bh,099h,090h,000h,00bh,0a9h,099h,000h,000h,099h,099h,000h,000h,099h,099h,000h,000h	; b17b  ...............[................
	defb 0b0h,000h,000h,000h,0b0h,000h,000h,000h,0dbh,000h,000h,000h,0bbh,0b0h,000h,000h,0bdh,0b5h,000h,000h,0bbh,0d5h,050h,000h,00bh,0ddh,0b0h,000h,00bh,0b7h,0b5h,000h	; b19b  ......................P.........
	defb 000h,000h,000h,0dbh,000h,000h,000h,0bdh,000h,000h,00dh,0bdh,000h,000h,00bh,0bbh,000h,000h,000h,0bbh,000h,000h,007h,007h,000h,000h,007h,007h,000h,000h,005h,05bh	; b1bb  ...............................[
	defb 0bbh,0b0h,000h,000h,0bbh,0b0h,000h,000h,0bbh,0b0h,000h,000h,0bdh,0b0h,000h,000h,07dh,0b0h,000h,000h,07dh,000h,000h,000h,07dh,000h,000h,000h,07dh,000h,000h,000h	; b1db  ................}...}...}...}...
	defb 0bbh,007h,05bh,0b0h,05bh,05bh,0b7h,057h,055h,007h,04bh,07bh,055h,0b7h,04bh,0bbh,055h,0bbh,0d4h,0d7h,005h,055h,0bbh,04dh,000h,055h,0bbh,044h,050h,000h,00bh,0bbh	; b1fb  ..[.[[.WU.K{U.K.U....U.M.U.DP...
	defb 057h,07bh,077h,0bbh,075h,0b5h,075h,0bbh,0b7h,07bh,07bh,0bdh,0b0h,0b7h,077h,07bh,07bh,077h,077h,07dh,037h,0b7h,077h,0bbh,0bbh,0bbh,077h,047h,044h,047h,074h,077h	; b21b  W{w.u.u..{{...w{{ww}7.w...wGDGtw
	defb 0bbh,0bdh,077h,000h,0bbh,0dbh,0b7h,000h,0dbh,0bbh,077h,070h,0b7h,0dbh,075h,070h,0bdh,0bbh,0b7h,070h,07bh,0bbh,0bbh,070h,0bdh,0bbh,0b7h,077h,07dh,077h,0bbh,057h	; b23b  ..w.......wp..up...p{..p...w}w.W
	defb 099h,099h,099h,099h,099h,099h,099h,0a9h,099h,099h,0a9h,09ah,099h,099h,099h,09ah,099h,099h,099h,09ah,099h,099h,099h,0aah,099h,099h,09ah,09ah,099h,099h,09ah,0aah	; b25b  ................................
	defb 09ah,099h,090h,005h,09ah,099h,090h,005h,09ah,099h,099h,00bh,0aah,099h,099h,000h,0a9h,0a9h,099h,090h,09ah,099h,099h,090h,0a9h,099h,099h,090h,0aah,0a9h,099h,099h	; b27b  ................................
	defb 005h,0b7h,0d5h,000h,000h,07dh,0dbh,000h,055h,00dh,07bh,000h,0b0h,00bh,07dh,050h,0b5h,000h,07dh,0b5h,0b5h,000h,0bdh,0b5h,005h,000h,0bdh,0d5h,00bh,000h,007h,0dbh	; b29b  .....}..U.{...}P..}.............
	defb 000h,000h,005h,055h,000h,000h,005h,0bbh,000h,000h,05bh,05bh,000h,005h,00bh,0bbh,000h,000h,05bh,05bh,000h,000h,05bh,0bdh,000h,000h,055h,0ddh,000h,005h,0b5h,0d5h	; b2bb  ...U......[[......[[..[...U.....
	defb 0d0h,000h,000h,000h,0b0h,000h,000h,000h,0b0h,000h,000h,050h,0d0h,000h,005h,000h,0d0h,000h,050h,000h,0dbh,000h,000h,000h,0b0h,005h,000h,000h,0b0h,000h,000h,000h	; b2db  ...........P......P.............
	defb 070h,0bdh,0b7h,077h,077h,07bh,077h,077h,047h,040h,0d7h,077h,074h,077h,07dh,077h,07bh,070h,070h,0d7h,0b5h,00bh,007h,007h,055h,000h,070h,07dh,055h,055h,00dh,077h	; b2fb  p..ww{wwG@.wtw}w{pp.....U.p}UU.w
	defb 099h,0a9h,09ah,0a9h,09ah,0a9h,09ah,0ach,09ah,0a9h,099h,0ach,09ah,09ah,099h,0ach,09ah,0aah,099h,0ach,09ah,0aah,0a9h,0aah,09ah,0aah,0aah,0ach,099h,0aah,0ach,0aah	; b31b  ................................
	defb 0a9h,0a9h,099h,0a9h,0aah,0aah,09ah,0a9h,09ch,0aah,0aah,0aah,0cch,0cch,0cah,0aah,0ech,0ceh,0cch,0ach,0cch,0ech,0cch,0cah,0ceh,0eeh,0ech,0cch,0cch,0eeh,0eeh,0ech	; b33b  ................................
	defb 000h,000h,007h,0dbh,0a0h,050h,000h,0dbh,0a0h,000h,0b0h,0dbh,0cah,005h,000h,0dbh,0cch,000h,000h,00bh,0cch,0e0h,050h,00bh,0cch,0e0h,000h,00bh,0eeh,0e0h,000h,00bh	; b35b  .....P................P.........
	defb 005h,005h,05bh,0dbh,000h,005h,05bh,0bbh,050h,005h,05bh,0bbh,0b0h,000h,05bh,0b5h,050h,005h,005h,055h,050h,000h,0b5h,050h,050h,005h,050h,000h,000h,000h,007h,055h	; b37b  ..[...[.P.[...[.P..UP..PP.P....U
	defb 050h,000h,000h,000h,050h,000h,00dh,000h,050h,000h,000h,00bh,050h,000h,000h,000h,000h,000h,050h,000h,005h,000h,055h,050h,005h,050h,000h,0b0h,050h,0b0h,000h,005h	; b39b  P...P...P...P.....P...UP.P..P...
	defb 000h,005h,005h,0ddh,000h,000h,000h,0b0h,000h,00bh,00bh,00bh,000h,00bh,00bh,00bh,000h,000h,0d0h,0bbh,000h,000h,0ddh,00bh,000h,000h,00dh,0bbh,000h,050h,0dbh,077h	; b3bb  .............................P.w
	defb 0a9h,0ach,0cah,0ach,0aah,0cch,0ech,0cch,0cch,0cch,0ech,0cch,0cch,0ech,0ceh,0eeh,0ech,0ceh,0eeh,0eeh,0eeh,0eeh,0eeh,0eeh,0eeh,0eeh,0e0h,000h,0e0h,000h,000h,000h	; b3db  ................................
	defb 0ach,0eeh,0eeh,0eeh,0eeh,0eeh,0eeh,0eeh,0ceh,0eeh,0eeh,0e0h,0eeh,0eeh,0e0h,000h,0eeh,0e0h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b3fb  ................................
	defb 0eeh,0e0h,000h,00bh,0eeh,000h,000h,0bbh,000h,000h,000h,0b5h,000h,000h,000h,0bbh,000h,000h,000h,00bh,000h,000h,000h,0bbh,000h,000h,000h,00dh,000h,000h,000h,05dh	; b41b  ...............................]
	defb 000h,00bh,0b5h,055h,000h,000h,0b5h,05bh,000h,000h,0bbh,057h,000h,0b0h,00bh,0bbh,050h,000h,00bh,05bh,050h,000h,00bh,05bh,050h,000h,000h,0bbh,0b0h,000h,000h,05bh	; b43b  ...U...[...W....P..[P..[P......[
	defb 070h,000h,000h,005h,00bh,070h,070h,000h,007h,077h,000h,000h,077h,0bbh,0b0h,000h,0b7h,04bh,0ddh,0d0h,07bh,0ddh,077h,0ddh,05dh,0d7h,077h,077h,05dh,0b4h,077h,077h	; b45b  p....pp..w..w....K..{.w.].ww].ww
	defb 05bh,000h,000h,000h,055h,0b0h,000h,000h,000h,05bh,0bbh,000h,0bbh,000h,000h,000h,00bh,000h,000h,000h,000h,000h,000h,005h,0d0h,00bh,005h,050h,07dh,000h,00bh,070h	; b47b  [...U....[.................P}..p
	defb 000h,055h,050h,000h,0d5h,050h,050h,000h,000h,000h,000h,000h,000h,00bh,0d0h,0d0h,000h,057h,000h,000h,055h,000h,0d0h,055h,000h,070h,005h,050h,00dh,0ddh,0d5h,0d0h	; b49b  .UP..PP..........W..U..U.p.P....
	defb 000h,000h,07bh,077h,000h,000h,00dh,077h,000h,000h,007h,077h,000h,00dh,00bh,077h,000h,000h,0d7h,077h,000h,050h,0d4h,0d7h,000h,000h,0d4h,077h,000h,00dh,0d7h,0b7h	; b4bb  ..{w...w...w...w...w.P.....w....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,005h,000h,000h,000h,000h,050h,000h,000h,000h,005h,000h,000h,005h,050h	; b4db  ..............P........P.......P
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,000h,050h,000h,005h,050h,000h,050h,005h,050h,050h,005h,000h,000h,000h,000h,055h,000h,005h,000h,005h,050h,005h	; b4fb  ...........P..P.P.PP.....U....P.
	defb 000h,000h,000h,05bh,000h,000h,000h,05dh,050h,000h,000h,005h,000h,000h,000h,00bh,005h,000h,000h,000h,050h,000h,050h,000h,000h,000h,000h,050h,000h,000h,005h,000h	; b51b  ...[...]P...........P.P....P....
	defb 0b0h,000h,000h,055h,0b0h,000h,000h,005h,0b5h,000h,000h,000h,0b5h,000h,000h,005h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b53b  ...U............P...............
	defb 05dh,0d7h,074h,077h,0b5h,0ddh,044h,047h,0bbh,05dh,0d4h,04dh,055h,05bh,0ddh,0ddh,055h,0b7h,057h,0b5h,005h,055h,0b5h,0bbh,005h,050h,00bh,055h,000h,055h,005h,055h	; b55b  ].tw..DG.].MU[..U.W..U...P.U.U.U
	defb 07dh,0d0h,007h,055h,077h,0d7h,07bh,00dh,04dh,044h,077h,00bh,0ddh,007h,07dh,0b0h,0dbh,05bh,0b5h,055h,0bbh,0b5h,055h,055h,050h,050h,0d5h,05bh,005h,000h,055h,07bh	; b57b  }..Uw.{.MDw...}..[.U..UUPP.[..U{
	defb 050h,0dbh,0bdh,000h,070h,05bh,0d0h,000h,0b5h,0dbh,050h,050h,055h,0bbh,005h,050h,05bh,0b5h,005h,000h,0bbh,0bdh,050h,000h,0b5h,055h,000h,000h,050h,050h,000h,000h	; b59b  P...p[....PPU..P[.....P..U..PP..
	defb 055h,050h,074h,077h,055h,050h,074h,0d7h,055h,00dh,074h,077h,05dh,00dh,077h,077h,000h,00dh,074h,077h,0ddh,00dh,074h,077h,00dh,005h,074h,077h,00dh,005h,074h,077h	; b5bb  UPtwUPt.U.tw].ww..tw..tw..tw..tw
	defb 000h,005h,000h,055h,000h,000h,000h,050h,0bbh,0b5h,000h,005h,00bh,0bbh,000h,005h,000h,05bh,0bbh,005h,000h,005h,05bh,0bbh,000h,000h,005h,0bbh,000h,000h,000h,05bh	; b5db  ...U...P.........[....[........[
	defb 050h,000h,055h,050h,055h,000h,000h,055h,000h,050h,005h,055h,050h,050h,000h,050h,055h,055h,000h,050h,055h,050h,005h,050h,0bdh,055h,050h,050h,0bbh,0b0h,005h,055h	; b5fb  P.UPU..U.P.UPP.PUU.PUP.P.UPP...U
	defb 005h,000h,000h,000h,000h,000h,050h,000h,000h,005h,000h,000h,050h,005h,000h,050h,055h,055h,000h,050h,000h,055h,000h,000h,000h,050h,050h,000h,050h,005h,000h,000h	; b61b  ......P.....P..PUU.P.U...PP.P...
	defb 000h,000h,055h,055h,000h,000h,005h,055h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0b0h,050h,005h,050h,000h,000h,00bh,000h,00bh,000h,000h	; b63b  ..UU...U..............P.P.......
	defb 000h,005h,05bh,0bbh,050h,000h,00bh,0b5h,050h,00dh,0bbh,055h,005h,0b0h,0bbh,000h,050h,0b0h,0bbh,070h,050h,0d0h,0bdh,0b0h,0bdh,000h,0bbh,0b0h,000h,00bh,0d7h,070h	; b65b  ..[.P...P..U....P..pP..........p
	defb 055h,050h,000h,000h,050h,000h,000h,055h,050h,000h,005h,0ddh,000h,005h,005h,0d7h,000h,000h,005h,05dh,000h,000h,000h,0d5h,000h,000h,050h,000h,050h,000h,05bh,000h	; b67b  UP..P..UP..........]......P.P.[.
	defb 055h,007h,077h,077h,0ddh,055h,077h,077h,0dbh,007h,0b7h,077h,050h,0bbh,077h,047h,050h,0bdh,074h,044h,0d0h,0bdh,074h,044h,055h,00bh,0d7h,044h,000h,0b0h,0d7h,077h	; b69b  U.ww.Uww...wP.wGP.tD..tDU..D...w
	defb 000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b6bb  ................................
	defb 005h,0bbh,000h,055h,005h,05bh,0b0h,055h,000h,055h,0bbh,050h,000h,005h,055h,050h,000h,000h,055h,055h,000h,000h,000h,05bh,000h,000h,000h,055h,000h,000h,000h,000h	; b6db  ...U.[.U.U.P..UP..UU...[...U....
	defb 050h,005h,050h,000h,050h,000h,050h,050h,055h,000h,055h,000h,055h,050h,055h,000h,0b5h,055h,005h,000h,055h,0b5h,050h,050h,05bh,055h,050h,050h,050h,0b5h,055h,000h	; b6fb  P.P.P.PPU.U.UPU..U..U.PP[UPPP.U.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b71b  ........P.......................
	defb 000h,000h,000h,005h,000h,0b0h,050h,055h,000h,000h,050h,05bh,000h,000h,050h,050h,005h,000h,000h,05bh,000h,0b0h,005h,05bh,000h,000h,005h,0bbh,000h,05bh,005h,0bbh	; b73b  ......PU..P[..PP...[...[.....[..
	defb 0bdh,00dh,0d5h,000h,0bbh,0bdh,070h,000h,0b7h,00dh,050h,000h,0bbh,0d7h,000h,000h,0b7h,0d5h,000h,005h,007h,0d5h,000h,050h,0bdh,050h,000h,005h,07dh,070h,000h,055h	; b75b  ......p...P............P.P..}p.U
	defb 005h,005h,055h,000h,000h,055h,055h,050h,000h,005h,055h,050h,000h,000h,050h,050h,000h,000h,055h,055h,000h,000h,005h,055h,000h,000h,000h,055h,000h,000h,000h,055h	; b77b  ..U..UUP..UP..PP..UU...U...U...U
	defb 000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h	; b79b  ....P...............P...P.......
	defb 000h,005h,005h,0bbh,000h,005h,005h,0b7h,000h,000h,000h,0bbh,000h,00bh,000h,0bbh,000h,000h,000h,0b7h,000h,000h,000h,00bh,000h,000h,0b0h,00bh,000h,000h,000h,00bh	; b7bb  ................................
	defb 0ddh,005h,000h,05bh,0b5h,000h,000h,055h,0ddh,000h,000h,055h,0d7h,000h,005h,05bh,0d0h,000h,000h,05bh,0ddh,050h,005h,05bh,0bdh,050h,000h,05dh,0d7h,005h,000h,000h	; b7db  ...[...U...U...[...[.P.[.P.]....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b7fb  ................................
	defb 000h,000h,000h,005h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b81b  ................................
	defb 005h,000h,000h,000h,050h,055h,000h,000h,000h,000h,000h,000h,000h,055h,000h,000h,005h,050h,050h,000h,000h,000h,005h,000h,000h,005h,005h,000h,000h,000h,050h,000h	; b83b  ....PU.......U...PP...........P.
	defb 000h,000h,000h,00bh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h	; b85b  ...............P................
	defb 0bdh,0b5h,000h,050h,05dh,0b0h,005h,050h,05bh,0b0h,000h,050h,00bh,070h,000h,000h,005h,0bbh,0b5h,000h,000h,050h,005h,000h,000h,05bh,0b0h,000h,000h,005h,0b0h,000h	; b87b  ...P]..P[..P.p.......P...[......
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b89b  ................................
	defb 000h,000h,050h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b8bb  ..P............P................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,000h,000h,050h,000h,000h	; b8db  .............................P..
	defb 000h,005h,0d0h,00bh,000h,000h,05bh,000h,000h,000h,00bh,0bbh,000h,000h,000h,0b0h,000h,000h,000h,000h,000h,000h,000h,00bh,000h,000h,000h,000h,000h,000h,000h,000h	; b8fb  ......[.........................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,055h,000h,000h,000h	; b91b  ..............P.............U...
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,000h,000h,000h,050h,000h	; b93b  ..............................P.
	defb 000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b95b  .P..............................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h	; b97b  ..............................P.
	defb 005h,050h,000h,000h,000h,050h,000h,000h,000h,055h,000h,000h,000h,050h,050h,000h,000h,000h,050h,000h,000h,000h,055h,000h,000h,000h,005h,00bh,000h,000h,005h,055h	; b99b  .P...P...U...PP...P...U........U
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,050h,000h,000h,000h	; b9bb  ........................P...P...
	defb 000h,005h,05bh,00bh,000h,000h,055h,00bh,000h,000h,000h,05bh,000h,000h,000h,05bh,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; b9db  ..[...U....[...[................
	defb 0ddh,0d7h,074h,044h,0ddh,077h,074h,044h,0ddh,0d7h,077h,044h,0bdh,0ddh,077h,077h,0bbh,0ddh,0d7h,077h,0bbh,0bdh,0ddh,0ddh,00bh,0bbh,0bdh,0ddh,000h,00bh,0bbh,0bbh	; b9fb  ..tD.wtD..wD..ww...w............
	defb 050h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; ba1b  P...............................
	defb 000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,0b0h,000h,000h,000h,005h,000h,000h,050h,000h,000h,000h,000h,000h,000h,00bh,000h,000h,000h	; ba3b  .....................P..........
	defb 005h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,050h,000h,005h,000h,000h,000h,050h,000h,005h,000h,000h	; ba5b  .......P...........P.P.....P....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,050h,005h,000h,000h,005h,005h,000h,005h	; ba7b  ..........P.............P.......
	defb 000h,000h,000h,050h,000h,000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,000h,050h,000h,000h,000h,000h,050h,050h,005h,000h	; ba9b  ...P...................P....PP..
	defb 055h,000h,000h,000h,055h,050h,000h,000h,005h,055h,000h,000h,0b5h,055h,055h,000h,000h,0b5h,055h,050h,000h,050h,055h,055h,000h,005h,055h,0d0h,000h,00bh,0b5h,0bdh	; babb  U...UP...U...UU...UP.PUU..U.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,0d5h,000h,000h,000h,000h,0d0h,000h,000h	; badb  ....................P...........
	defb 000h,005h,00bh,0dbh,000h,000h,000h,000h,000h,000h,000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bafb  ...........P....................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bb1b  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bb3b  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bb5b  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bb7b  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bb9b  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; bbbb  ................................
	defb 000h,000h,000h,007h,074h,044h,044h,074h,000h,000h,000h,000h,007h,074h,044h,044h,000h,000h,000h,000h,000h,007h,074h,074h,000h,000h,000h,000h,000h,000h,007h,077h	; bbdb  ....tDDt.....tDD......tt.......w
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00bh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0bbh,000h,000h,000h,000h,000h	; bbfb  ................................
	defb 000h,0bbh,000h,000h,000h,000h,000h,000h,00bh,000h,000h,000h,000h,000h,000h,000h,000h,004h,0b0h,008h,000h,050h,000h,000h,000h,044h,0bbh,000h,005h,0c7h,050h,000h	; bc1b  .....................P...D....P.
	defb 000h,000h,04bh,0b0h,05ch,070h,007h,000h,000h,070h,004h,044h,000h,000h,0d0h,000h,000h,007h,070h,000h,000h,0d7h,000h,000h,000h,000h,007h,0ddh,00dh,000h,05dh,000h	; bc3b  ..K.\p...p.D......p...........].
	defb 047h,044h,044h,047h,070h,000h,000h,000h,044h,044h,047h,070h,000h,000h,000h,000h,047h,047h,070h,000h,000h,000h,000h,000h,077h,070h,000h,000h,000h,000h,000h,000h	; bc5b  GDDGp...DDGp....GGp.....wp......
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0bbh,000h,000h	; bc7b  ................................
	defb 000h,000h,000h,000h,000h,000h,0bbh,000h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,005h,000h,080h,00bh,040h,000h,000h,005h,07ch,050h,000h,0bbh,044h,000h	; bc9b  ......................@...|P..D.
	defb 000h,070h,007h,0c5h,00bh,0b4h,000h,000h,000h,00dh,000h,000h,044h,040h,007h,000h,000h,000h,07dh,000h,000h,007h,070h,000h,000h,0d5h,000h,0d0h,0ddh,070h,000h,000h	; bcbb  .p..........D@....}...p......p..
	defb 000h,000h,000h,007h,074h,044h,044h,074h,000h,000h,000h,000h,007h,074h,044h,044h,000h,000h,000h,000h,000h,007h,074h,074h,000h,000h,000h,000h,000h,000h,007h,077h	; bcdb  ....tDDt.....tDD......tt.......w
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00bh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,055h,055h,000h,000h,000h,000h	; bcfb  ..........................UU....
	defb 000h,055h,0bbh,0b5h,055h,050h,000h,000h,005h,05bh,0bdh,0dbh,055h,055h,000h,000h,000h,00dh,0ddh,0bbh,0b5h,050h,000h,000h,000h,000h,007h,0dbh,0b0h,00bh,050h,000h	; bd1b  .U..UP...[..UU.......P........P.
	defb 000h,000h,000h,000h,00bh,0bbh,00bh,000h,000h,0b0h,00bh,0bbh,0b0h,000h,0d0h,000h,000h,00bh,0b0h,000h,000h,0d7h,000h,000h,0b0h,000h,00bh,0ddh,0bdh,000h,05dh,000h	; bd3b  ..............................].
	defb 047h,044h,044h,047h,070h,000h,000h,000h,044h,044h,047h,070h,000h,000h,000h,000h,047h,047h,070h,000h,000h,000h,000h,000h,077h,070h,000h,000h,000h,000h,000h,000h	; bd5b  GDDGp...DDGp....GGp.....wp......
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0b0h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,055h,055h,000h,000h	; bd7b  ............................UU..
	defb 000h,000h,005h,055h,05bh,0bbh,055h,000h,000h,000h,055h,055h,0bdh,0dbh,0b5h,050h,000h,000h,005h,05bh,0bbh,0ddh,0d0h,000h,000h,005h,0b0h,00bh,0bdh,070h,000h,000h	; bd9b  ...U[.U...UU...P...[.........p..
	defb 000h,0b0h,0bbh,0b0h,000h,000h,000h,000h,000h,00dh,000h,00bh,0bbh,0b0h,00bh,000h,000h,000h,07dh,000h,000h,00bh,0b0h,000h,000h,0d5h,000h,0dbh,0ddh,0b0h,000h,00bh	; bdbb  ..................}.............
	defb 000h,005h,05bh,0b5h,000h,0b0h,00dh,0ddh,005h,055h,0bbh,0b5h,050h,00bh,000h,000h,005h,05bh,0bdh,0dbh,0bbh,000h,055h,000h,055h,0bdh,0ddh,0ddh,0bbh,050h,000h,055h	; bddb  ..[......U..P....[....U.U....P.U
	defb 05bh,0bbh,0ddh,0ddh,0ddh,0b5h,000h,000h,05bh,0bbh,0ddh,0ddh,0ddh,0d5h,050h,000h,0bbh,0bbh,0ddh,0ddh,0bbh,0ddh,055h,0b5h,0bbh,0bdh,0ddh,0bbh,0ddh,075h,050h,0b5h	; bdfb  [.......[.....P.......U......uP.
	defb 0bdh,0bbh,0dbh,077h,077h,077h,005h,0bbh,0bdh,0bbh,077h,077h,07dh,0d7h,070h,077h,00bh,0b7h,07dh,0ddh,000h,000h,0d7h,007h,0bbh,077h,000h,000h,000h,000h,000h,000h	; be1b  ...www....ww}.pw..}......w......
	defb 0bdh,000h,000h,000h,000h,000h,000h,000h,0d5h,000h,00eh,000h,000h,000h,000h,000h,005h,055h,0eeh,0e0h,000h,000h,000h,000h,000h,050h,0eeh,0ebh,0b5h,055h,000h,000h	; be3b  .................U.......P...U..
	defb 000h,007h,0eeh,0c5h,05bh,0bbh,0bbh,055h,00bh,05bh,0ech,0c7h,075h,055h,055h,055h,0dbh,055h,0ech,0d7h,077h,077h,0ddh,0ddh,0dbh,055h,0ech,0ddh,077h,074h,047h,077h	; be5b  ....[..U.[..uUUU.U..ww...U..wtGw
	defb 0dbh,055h,0ech,055h,05dh,0bbh,0bbh,07bh,0bdh,055h,0bch,0bbh,055h,055h,055h,055h,0bdh,055h,05eh,0cbh,0bbh,055h,05bh,000h,00bh,0b5h,05bh,0ebh,0bbh,0bbh,055h,055h	; be7b  .U.U]..{.U..UUUU.U^..U[...[...UU
	defb 0bbh,0dbh,0bbh,0bbh,0bbh,0bdh,055h,055h,0bbh,0dbh,0bbh,0bbh,0bbh,0b5h,0b5h,055h,0bbh,0bdh,0bbh,0bbh,0b5h,0b5h,055h,0b5h,00bh,0b0h,0bbh,05bh,05bh,0b5h,0ddh,0ddh	; be9b  ......UU.......U......U....[[...
	defb 007h,0bbh,0ddh,00dh,0bdh,0bdh,0ddh,0ddh,000h,0bbh,0b5h,0bdh,0dbh,0ddh,0ddh,07dh,000h,00bh,0dbh,0bdh,00bh,0ddh,0d7h,077h,050h,0dbh,0bdh,0dbh,0bdh,0ddh,077h,074h	; bebb  ...............}.......wP.....wt
	defb 000h,005h,05bh,0b5h,000h,0b0h,00dh,0ddh,005h,055h,0bbh,0b5h,050h,00bh,000h,000h,005h,05bh,0bdh,0dbh,0bbh,000h,055h,000h,055h,0bdh,0ddh,0ddh,0bbh,050h,000h,055h	; bedb  ..[......U..P....[....U.U....P.U
	defb 05bh,0bbh,0ddh,0ddh,0bdh,0b5h,000h,000h,055h,0bbh,0dbh,0bbh,0ddh,0d5h,050h,000h,05bh,0bbh,0b5h,05dh,0bbh,0ddh,055h,0ddh,055h,0b5h,0ddh,0bbh,077h,077h,070h,005h	; befb  [.......U.....P.[..]..U.U...wwp.
	defb 055h,055h,0dbh,0bbh,0bbh,0bbh,0b5h,055h,0bbh,0bdh,0bbh,0b0h,000h,000h,000h,055h,00bh,00bh,0b0h,000h,000h,000h,000h,000h,0bbh,0bbh,00eh,000h,000h,000h,000h,000h	; bf1b  UU.....U.......U................
	defb 0bdh,000h,0eeh,0e0h,000h,000h,000h,000h,0d5h,000h,0eeh,0e0h,000h,000h,000h,000h,005h,000h,0eeh,0c0h,000h,000h,000h,000h,000h,000h,0ech,0c0h,000h,000h,000h,000h	; bf3b  ................................
	defb 000h,000h,0ech,000h,000h,000h,000h,000h,05bh,000h,0ech,000h,000h,000h,000h,000h,05bh,000h,0ech,000h,000h,000h,000h,000h,05bh,000h,00ch,000h,000h,000h,000h,000h	; bf5b  ........[.......[.......[.......
	defb 05bh,0b0h,00eh,0c0h,000h,000h,000h,000h,0b5h,050h,000h,0e0h,000h,000h,000h,000h,0b5h,077h,000h,000h,000h,000h,000h,000h,005h,0d7h,050h,000h,000h,000h,000h,000h	; bf7b  [........P.......w........P.....
	defb 0d5h,05dh,077h,000h,000h,000h,000h,000h,00dh,055h,077h,0bbh,0b5h,0bbh,0b5h,05bh,0b5h,055h,0bbh,077h,077h,0d5h,057h,077h,00bh,055h,05bh,0b0h,055h,077h,07bh,0b7h	; bf9b  .]w......Uw....[.U.ww.Ww.U[.Uw{.
	defb 007h,0b5h,055h,055h,0b5h,005h,000h,000h,000h,0b5h,0d5h,0d5h,055h,000h,000h,000h,000h,007h,05dh,055h,05bh,0b5h,055h,005h,000h,0dbh,055h,0b5h,055h,055h,055h,057h	; bfbb  ..UU........U.....]U[.U...U.UUUW
	defb 0ffh	; bfdb

; ----------------------------------------------------------------------
; DATOS relleno_p15: 36 bytes a 0xFF hasta el final del banco: espacio libre;
;   lo leen nadie (36 bytes)
;   0xbfdc..0xc000  (36 bytes)
DATA_relleno_p15:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfec  ................
	defb 0ffh,0ffh,0ffh,0ffh	; bffc
