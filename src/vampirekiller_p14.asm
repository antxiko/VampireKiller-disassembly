; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 14 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS listas_de_cada_bloque: 6 punteros, uno por bloque de tres fases
;   (0xD002), a la lista que p00:5A67 copia a 0xE000; lo leen p00:5AA3 (12
;   bytes)
;   0x8000..0x800c  (12 bytes)
DATA_listas_de_cada_bloque:
	defb 019h,080h	; 8000
	defb 0e7h,080h	; 8002
	defb 0b3h,081h	; 8004
	defb 0b1h,082h	; 8006
	defb 098h,083h	; 8008
	defb 097h,084h	; 800a

; ----------------------------------------------------------------------
; DATOS lista_800C: lista que p00:5A67 copia a 0xE000 (0x00 acaba, 0xFF otra
;   fila, 0xFE otro grupo, pares de bytes y un tercero si el segundo es 0x7F);
;   es la del patio, la fase 0; lo leen p00:5A67 (13 bytes)
;   0x800c..0x8019  (13 bytes)
DATA_lista_800C:
	defb 094h,021h,09ch,021h,0feh,094h,022h,09ch,022h,0feh,094h,03ah,000h	; 800c  .!.!.."."..:.

; ----------------------------------------------------------------------
; DATOS lista_8019: lista que p00:5A67 copia a 0xE000 (0x00 acaba, 0xFF otra
;   fila, 0xFE otro grupo, pares de bytes y un tercero si el segundo es 0x7F);
;   lo leen p00:5A67 (206 bytes)
;   0x8019..0x80e7  (206 bytes)
DATA_lista_8019:
	defb 097h,029h,09bh,021h,0feh,093h,021h,097h,026h,049h,021h,08bh,029h,0feh,046h,021h	; 8019  .).!..!.&I!.).F!
	defb 0b4h,017h,0a8h,078h,0bbh,082h,04bh,021h,09dh,021h,0feh,0a2h,021h,064h,03ah,0a8h	; 8029  ...x..K!.!..!d:.
	defb 021h,05bh,022h,073h,08dh,0feh,023h,020h,063h,021h,096h,021h,04bh,022h,09ah,020h	; 8039  !["s..# c!.!K".
	defb 032h,08ch,072h,083h,0b2h,017h,0feh,094h,020h,089h,03ah,0feh,087h,030h,05dh,021h	; 8049  2.r..... .:..0]!
	defb 0feh,0a6h,022h,0aah,020h,078h,017h,0ach,07fh,0e1h,0ffh,02ah,0d5h,092h,021h,048h	; 8059  ..". x.....*..!H
	defb 021h,06ah,062h,06ch,062h,0a8h,077h,0aah,062h,0ach,07fh,0ceh,0feh,062h,077h,064h	; 8069  !jblb.w.b....bwd
	defb 077h,066h,060h,0a2h,07fh,08ah,0a4h,07fh,08ch,0a6h,077h,037h,027h,031h,091h,0feh	; 8079  wf`.......w7'1..
	defb 034h,028h,075h,021h,07ah,025h,03eh,022h,056h,08fh,04ah,07fh,0dbh,0feh,074h,022h	; 8089  4(u!z%>"V.J...t"
	defb 036h,022h,03ch,022h,08eh,029h,0b8h,017h,0feh,052h,07ch,054h,029h,04eh,021h,0feh	; 8099  6"<".)...R|T)N!.
	defb 045h,022h,04ch,030h,07ch,078h,0ffh,068h,021h,093h,021h,098h,029h,0b2h,017h,074h	; 80a9  E"L0|x.h!.!.)..t
	defb 084h,0feh,097h,034h,05dh,028h,09ch,017h,0feh,0a1h,03ah,06ah,07fh,0dch,0aah,078h	; 80b9  ...4](....:j...x
	defb 077h,08ah,0b7h,017h,0bch,089h,0feh,053h,03ah,093h,021h,096h,029h,099h,021h,09ch	; 80c9  w......S:.!.).!.
	defb 030h,05ch,017h,0feh,053h,085h,0b3h,083h,0feh,087h,022h,08ah,021h,000h	; 80d9  0\..S.....".!.

; ----------------------------------------------------------------------
; DATOS lista_80E7: lista que p00:5A67 copia a 0xE000 (0x00 acaba, 0xFF otra
;   fila, 0xFE otro grupo, pares de bytes y un tercero si el segundo es 0x7F);
;   lo leen p00:5A67 (204 bytes)
;   0x80e7..0x81b3  (204 bytes)
DATA_lista_80E7:
	defb 098h,021h,09eh,028h,048h,035h,05dh,017h,042h,078h,0feh,034h,026h,084h,029h,089h	; 80e7  .!.(H5].Bx.4&.).
	defb 022h,07ch,017h,03ch,035h,0b9h,08fh,0ach,0c4h,0feh,035h,035h,083h,021h,04ch,027h	; 80f7  "|.<5.....55.!L'
	defb 0adh,028h,07dh,017h,044h,0d6h,0feh,034h,022h,03ah,022h,0b1h,091h,097h,017h,0feh	; 8107  .(}.D..4":".....
	defb 031h,035h,037h,027h,03bh,021h,0bbh,017h,072h,08ah,07ah,09ch,0feh,036h,021h,07dh	; 8117  157';!..r.z..6!}
	defb 022h,091h,083h,0ffh,024h,035h,028h,021h,02ch,021h,0feh,047h,022h,04bh,021h,076h	; 8127  "...$5(!,!.G"K!v
	defb 017h,09ah,017h,0feh,022h,026h,03bh,022h,07ah,089h,0feh,082h,022h,04ch,078h,08ch	; 8137  ...."&;"z..."Lx.
	defb 07fh,0d3h,05bh,093h,09bh,09eh,0feh,044h,021h,04dh,035h,048h,021h,083h,021h,088h	; 8147  ..[....D!M5H!.!.
	defb 021h,095h,017h,09ch,017h,0feh,035h,035h,03dh,035h,094h,021h,099h,035h,09ch,021h	; 8157  !.....55=5.!.5.!
	defb 0ffh,067h,017h,054h,029h,02ch,07fh,0d5h,0a4h,062h,0a6h,075h,0a8h,075h,0aah,075h	; 8167  .g.T),...b.u.u.u
	defb 0ach,078h,0feh,022h,03ah,026h,035h,02ah,021h,082h,035h,086h,035h,08ah,022h,09ch	; 8177  .x.":&5*!.5.5.".
	defb 017h,0feh,038h,022h,073h,021h,07bh,021h,032h,07fh,0e3h,044h,017h,088h,07fh,089h	; 8187  ..8"s!{!2..D....
	defb 0a2h,09ah,0feh,062h,026h,066h,03ah,09dh,017h,0feh,062h,021h,066h,035h,06ah,022h	; 8197  ...b&f:...b!f5j"
	defb 06eh,035h,0feh,062h,027h,06eh,021h,076h,021h,07ah,021h,000h	; 81a7  n5.b'n!v!z!.

; ----------------------------------------------------------------------
; DATOS lista_81B3: lista que p00:5A67 copia a 0xE000 (0x00 acaba, 0xFF otra
;   fila, 0xFE otro grupo, pares de bytes y un tercero si el segundo es 0x7F);
;   lo leen p00:5A67 (254 bytes)
;   0x81b3..0x82b1  (254 bytes)
DATA_lista_81B3:
	defb 09ah,021h,032h,0c0h,0feh,033h,021h,056h,022h,05ah,035h,092h,021h,09eh,022h,084h	; 81b3  .!2..3!V"Z5.!.".
	defb 090h,04eh,017h,0feh,03eh,022h,056h,022h,064h,022h,099h,030h,0a2h,017h,0feh,051h	; 81c3  .N..>"V"d".0...Q
	defb 029h,04ch,035h,08ch,078h,06dh,083h,0feh,024h,022h,02ch,034h,081h,021h,094h,021h	; 81d3  )L5.xm..$",4.!.!
	defb 044h,084h,04ah,017h,07ah,09ch,0feh,039h,020h,055h,022h,098h,020h,082h,08fh,06bh	; 81e3  D.J.z..9 U". ..k
	defb 017h,0feh,044h,022h,094h,035h,098h,022h,09bh,017h,0feh,091h,021h,094h,022h,098h	; 81f3  ..D".5."....!.".
	defb 021h,07eh,017h,0feh,059h,021h,08ch,022h,094h,020h,092h,0c8h,0ffh,075h,035h,056h	; 8203  !~..Y!.". ...u5V
	defb 075h,058h,075h,05ah,075h,076h,075h,078h,075h,07ah,07fh,089h,07ch,077h,0feh,065h	; 8213  uXuZuvuxuz..|w.e
	defb 02ch,06ah,03ah,06ch,021h,074h,07fh,092h,076h,07fh,08fh,078h,060h,07ch,077h,0feh	; 8223  ,j:l!t..v..x`|w.
	defb 02bh,021h,064h,021h,068h,030h,07ch,0cfh,0feh,037h,022h,077h,035h,07eh,020h,082h	; 8233  +!d!h0|..7"w5~ .
	defb 08ch,04ah,017h,07ch,0d3h,0feh,026h,021h,02ah,021h,084h,022h,0a1h,017h,0feh,054h	; 8243  .J.|..&!*!."...T
	defb 02dh,059h,035h,0bbh,021h,05ah,07fh,082h,0feh,0feh,072h,035h,075h,035h,042h,018h	; 8253  -Y5.!Z....r5u5B.
	defb 04ch,075h,08ch,07fh,09bh,0ach,062h,0ffh,068h,089h,0feh,05eh,021h,0feh,043h,035h	; 8263  Lu....b.h..^!.C5
	defb 046h,035h,049h,028h,04ch,02ch,0feh,0feh,046h,028h,049h,022h,03ch,077h,0aeh,089h	; 8273  F5I(L,..F(I"<w..
	defb 06bh,017h,06eh,017h,0feh,091h,025h,097h,021h,06ah,017h,0a9h,082h,0feh,034h,028h	; 8283  k.n...%.!j....4(
	defb 03bh,021h,0a4h,021h,042h,085h,089h,017h,0feh,062h,034h,096h,021h,099h,021h,09ch	; 8293  ;!.!B....b4.!.!.
	defb 021h,0feh,039h,022h,089h,021h,06dh,018h,09ch,07fh,0dch,047h,09eh,000h	; 82a3  !.9".!m....G..

; ----------------------------------------------------------------------
; DATOS lista_82B1: lista que p00:5A67 copia a 0xE000 (0x00 acaba, 0xFF otra
;   fila, 0xFE otro grupo, pares de bytes y un tercero si el segundo es 0x7F);
;   lo leen p00:5A67 (231 bytes)
;   0x82b1..0x8398  (231 bytes)
DATA_lista_82B1:
	defb 065h,029h,07ah,026h,033h,018h,08eh,09ah,0feh,038h,030h,03eh,022h,065h,021h,032h	; 82b1  e)z&3....80>"e!2
	defb 0c5h,069h,017h,0feh,062h,025h,07dh,029h,0feh,07ah,028h,076h,077h,07dh,021h,0feh	; 82c1  .i..b%}).z(vw}!.
	defb 077h,034h,07dh,021h,084h,091h,0feh,035h,021h,03dh,02dh,07dh,021h,08eh,017h,046h	; 82d1  w4}!...5!=-}!..F
	defb 09ch,087h,093h,0feh,082h,021h,086h,022h,08ah,021h,08ch,022h,0feh,092h,021h,084h	; 82e1  .....!.".!."..!.
	defb 022h,086h,021h,089h,021h,09bh,021h,09eh,022h,0feh,094h,021h,092h,0ceh,0ffh,097h	; 82f1  ".!.!.!."..!....
	defb 022h,09ah,035h,09dh,035h,0feh,048h,017h,056h,078h,076h,07fh,09eh,078h,07fh,091h	; 8301  ".5.5.H.Vxv..x..
	defb 07ah,07fh,092h,07ch,062h,094h,060h,096h,07fh,0c1h,0feh,072h,022h,075h,021h,08dh	; 8311  z..|b.`....r"u!.
	defb 022h,0feh,056h,07fh,092h,078h,062h,07ch,07fh,083h,094h,060h,096h,07fh,09ch,098h	; 8321  ".V..xb|...`....
	defb 060h,09ah,07fh,0d7h,0feh,08bh,021h,08eh,03ah,098h,07fh,085h,0feh,094h,035h,097h	; 8331  `.....!.:.....5.
	defb 035h,0ffh,093h,021h,0feh,089h,021h,08eh,021h,074h,077h,0feh,082h,020h,097h,022h	; 8341  5..!..!.!tw.. ."
	defb 09ch,020h,0aeh,092h,0feh,093h,021h,098h,021h,09bh,020h,09eh,022h,0feh,08eh,021h	; 8351  . ....!.!. ."..!
	defb 086h,091h,078h,0dfh,0feh,098h,022h,06ch,078h,092h,07fh,088h,09ah,060h,0feh,0feh	; 8361  ..x..."lx....`..
	defb 091h,02ch,07ah,035h,07eh,020h,08ch,08fh,0feh,072h,021h,079h,035h,09ch,022h,0aeh	; 8371  .,z5~ ...r!y5.".
	defb 017h,0feh,072h,022h,077h,021h,07ah,035h,074h,077h,0feh,091h,021h,096h,028h,08ch	; 8381  ..r"w!z5tw..!.(.
	defb 022h,0feh,097h,020h,084h,085h,000h	; 8391

; ----------------------------------------------------------------------
; DATOS lista_8398: lista que p00:5A67 copia a 0xE000 (0x00 acaba, 0xFF otra
;   fila, 0xFE otro grupo, pares de bytes y un tercero si el segundo es 0x7F);
;   lo leen p00:5A67 (255 bytes)
;   0x8398..0x8497  (255 bytes)
DATA_lista_8398:
	defb 093h,022h,098h,021h,09eh,022h,032h,07fh,0e3h,0feh,094h,021h,08ch,021h,0aeh,017h	; 8398  .".!."2....!.!..
	defb 0feh,087h,022h,08ch,021h,049h,017h,0adh,017h,0feh,031h,021h,036h,022h,03bh,030h	; 83a8  ..".!I....1!6";0
	defb 049h,017h,0feh,035h,022h,03ah,027h,098h,020h,094h,07fh,08fh,092h,0c6h,0feh,034h	; 83b8  I..5":'. ......4
	defb 029h,039h,022h,03eh,021h,0feh,049h,017h,03ch,07fh,0d1h,07ah,078h,0feh,083h,021h	; 83c8  )9">!.I.<..zx..!
	defb 089h,022h,08ch,03ah,04bh,017h,0a2h,017h,0feh,028h,021h,02bh,021h,02eh,020h,032h	; 83d8  .".:K....(!+!. 2
	defb 07fh,091h,052h,07fh,093h,0feh,05bh,022h,05eh,020h,0feh,059h,021h,05ch,021h,09ch	; 83e8  ..R...["^ .Y!\!.
	defb 07fh,0d8h,0feh,032h,07fh,09ch,0ffh,023h,022h,083h,03ah,06dh,017h,0feh,094h,02ch	; 83f8  ...2...#".:m...,
	defb 098h,022h,09ch,035h,06dh,09ch,064h,017h,0feh,064h,027h,08ch,021h,04bh,089h,06eh	; 8408  .".5m.d..d'.!K.n
	defb 083h,0a6h,017h,0feh,024h,025h,029h,020h,0feh,024h,035h,02dh,021h,078h,021h,0a5h	; 8418  ....$%) .$5-!x!.
	defb 017h,0ach,017h,0feh,044h,060h,064h,078h,04bh,08fh,0feh,043h,021h,049h,025h,04ch	; 8428  ....D`dxK..C!I%L
	defb 021h,0a3h,087h,096h,0c1h,0feh,037h,020h,03ah,021h,08ah,034h,093h,021h,095h,021h	; 8438  !.....7 :!.4.!.!
	defb 0ffh,035h,021h,094h,030h,04bh,08fh,03ch,07fh,0d6h,0feh,096h,022h,09ah,030h,08dh	; 8448  .5!.0K.<....".0.
	defb 022h,03bh,022h,0a4h,017h,0feh,081h,030h,085h,021h,089h,021h,08dh,029h,04bh,091h	; 8458  ";"....0.!.!.)K.
	defb 03ch,07fh,0dch,0feh,089h,029h,08dh,022h,042h,018h,0feh,04bh,017h,0feh,042h,022h	; 8468  <....)."B..K..B"
	defb 04ah,022h,062h,08ah,06bh,083h,0ach,08fh,0feh,087h,021h,08ch,022h,0a9h,017h,0adh	; 8478  J"b.k.....!."...
	defb 092h,0feh,0feh,0a4h,017h,0feh,062h,022h,076h,027h,079h,022h,06dh,022h,000h	; 8488  ......b"v'y"m".

; ----------------------------------------------------------------------
; DATOS lista_8497: lista que p00:5A67 copia a 0xE000 (0x00 acaba, 0xFF otra
;   fila, 0xFE otro grupo, pares de bytes y un tercero si el segundo es 0x7F);
;   lo leen p00:5A67 (271 bytes)
;   0x8497..0x85a6  (271 bytes)
DATA_lista_8497:
	defb 068h,035h,096h,021h,09bh,035h,0feh,06ch,017h,0feh,062h,089h,0feh,0feh,0feh,056h	; 8497  h5.!.5.l..b....V
	defb 022h,069h,018h,0feh,021h,028h,036h,022h,094h,021h,098h,022h,0a6h,092h,0feh,0feh	; 84a7  "i..!(6".!."....
	defb 0ach,018h,0feh,057h,02dh,059h,022h,066h,087h,068h,08ah,06dh,018h,0ffh,025h,031h	; 84b7  ...W-Y"f.h.m..%1
	defb 058h,021h,091h,022h,098h,078h,0feh,032h,021h,03dh,021h,058h,060h,078h,060h,098h	; 84c7  X!.".x.2!=!X`x`.
	defb 07fh,0dbh,0a7h,083h,061h,017h,0feh,04dh,022h,09dh,021h,052h,09dh,094h,060h,096h	; 84d7  ....a..M".!R..`.
	defb 07fh,091h,0a8h,08fh,0feh,047h,030h,04ch,022h,094h,022h,09ch,035h,06dh,017h,0feh	; 84e7  .....G0L".".5m..
	defb 031h,021h,035h,026h,03ch,021h,084h,022h,08ch,022h,0aah,08ah,0feh,038h,035h,03bh	; 84f7  1!5&<!."."...85;
	defb 021h,03eh,035h,08eh,022h,042h,093h,0ach,017h,0feh,03ah,022h,084h,021h,04dh,08ch	; 8507  !>5."B....:".!M.
	defb 068h,089h,0abh,084h,09ch,07fh,0e0h,090h,060h,0feh,08dh,09dh,0aeh,082h,04eh,017h	; 8517  h.......`.....N.
	defb 0feh,038h,020h,078h,020h,04eh,017h,032h,0cah,0feh,044h,017h,032h,0d4h,058h,075h	; 8527  .8 x N.2..D.2.Xu
	defb 05ah,07fh,085h,076h,062h,078h,062h,0a9h,092h,0feh,04dh,018h,0adh,017h,0feh,043h	; 8537  Z..vbxb...M....C
	defb 034h,0ffh,0feh,036h,022h,03eh,022h,084h,017h,09ch,0e3h,0feh,075h,022h,07dh,022h	; 8547  4..6">".....u"}"
	defb 081h,092h,044h,017h,0feh,046h,022h,04eh,035h,091h,020h,096h,022h,09eh,021h,061h	; 8557  ..D..F"N5. .".!a
	defb 088h,0feh,022h,035h,069h,035h,094h,035h,09dh,021h,041h,08ch,066h,017h,0feh,03ch	; 8567  .."5i5.5.!A.f..<
	defb 03ah,048h,017h,0b1h,017h,042h,087h,0a7h,089h,0feh,03ah,020h,046h,021h,0bbh,021h	; 8577  :H...B....: F!.!
	defb 031h,018h,0feh,034h,021h,049h,022h,07dh,021h,091h,022h,0a3h,093h,066h,017h,0feh	; 8587  1..4!I"}!."..f..
	defb 035h,020h,038h,021h,03bh,021h,094h,020h,098h,022h,09ch,021h,032h,0d4h,000h	; 8597  5 8!;!. .".!2..

; ----------------------------------------------------------------------
; DATOS cosas_de_cada_habitacion: 19 punteros, uno por fase, a un byte por
;   habitacion; lo leen p00:5EDB (38 bytes)
;   0x85a6..0x85cc  (38 bytes)
DATA_cosas_de_cada_habitacion:
	defb 0cch,085h	; 85a6
	defb 0cfh,085h	; 85a8
	defb 0d7h,085h	; 85aa
	defb 0ddh,085h	; 85ac
	defb 0e3h,085h	; 85ae
	defb 0e9h,085h	; 85b0
	defb 0efh,085h	; 85b2
	defb 0f5h,085h	; 85b4
	defb 0feh,085h	; 85b6
	defb 006h,086h	; 85b8
	defb 00fh,086h	; 85ba
	defb 018h,086h	; 85bc
	defb 01eh,086h	; 85be
	defb 02ah,086h	; 85c0
	defb 036h,086h	; 85c2
	defb 03eh,086h	; 85c4
	defb 048h,086h	; 85c6
	defb 052h,086h	; 85c8
	defb 05eh,086h	; 85ca

; ----------------------------------------------------------------------
; DATOS cosas_fase_0: un byte por cada una de las 3 habitaciones de la fase 0:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (3 bytes)
;   0x85cc..0x85cf  (3 bytes)
DATA_cosas_fase_0:
	defb 000h,000h,000h	; 85cc

; ----------------------------------------------------------------------
; DATOS cosas_fase_1: un byte por cada una de las 8 habitaciones de la fase 1:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (8 bytes)
;   0x85cf..0x85d7  (8 bytes)
DATA_cosas_fase_1:
	defb 001h,001h,000h,000h,008h,001h,001h,000h	; 85cf  ........

; ----------------------------------------------------------------------
; DATOS cosas_fase_2: un byte por cada una de las 6 habitaciones de la fase 2:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (6 bytes)
;   0x85d7..0x85dd  (6 bytes)
DATA_cosas_fase_2:
	defb 008h,008h,001h,008h,002h,002h	; 85d7

; ----------------------------------------------------------------------
; DATOS cosas_fase_3: un byte por cada una de las 6 habitaciones de la fase 3:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (6 bytes)
;   0x85dd..0x85e3  (6 bytes)
DATA_cosas_fase_3:
	defb 000h,000h,000h,081h,008h,000h	; 85dd

; ----------------------------------------------------------------------
; DATOS cosas_fase_4: un byte por cada una de las 6 habitaciones de la fase 4:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (6 bytes)
;   0x85e3..0x85e9  (6 bytes)
DATA_cosas_fase_4:
	defb 080h,000h,000h,000h,0a0h,080h	; 85e3

; ----------------------------------------------------------------------
; DATOS cosas_fase_5: un byte por cada una de las 6 habitaciones de la fase 5:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (6 bytes)
;   0x85e9..0x85ef  (6 bytes)
DATA_cosas_fase_5:
	defb 0a0h,020h,080h,080h,020h,0a0h	; 85e9

; ----------------------------------------------------------------------
; DATOS cosas_fase_6: un byte por cada una de las 6 habitaciones de la fase 6:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (6 bytes)
;   0x85ef..0x85f5  (6 bytes)
DATA_cosas_fase_6:
	defb 010h,000h,000h,0a0h,020h,000h	; 85ef

; ----------------------------------------------------------------------
; DATOS cosas_fase_7: un byte por cada una de las 9 habitaciones de la fase 7:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (9 bytes)
;   0x85f5..0x85fe  (9 bytes)
DATA_cosas_fase_7:
	defb 080h,080h,080h,080h,000h,080h,000h,000h,000h	; 85f5  .........

; ----------------------------------------------------------------------
; DATOS cosas_fase_8: un byte por cada una de las 8 habitaciones de la fase 8:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (8 bytes)
;   0x85fe..0x8606  (8 bytes)
DATA_cosas_fase_8:
	defb 000h,020h,000h,000h,000h,000h,000h,000h	; 85fe  . ......

; ----------------------------------------------------------------------
; DATOS cosas_fase_9: un byte por cada una de las 9 habitaciones de la fase 9:
;   cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19; lo
;   leen p00:5EE7 (9 bytes)
;   0x8606..0x860f  (9 bytes)
DATA_cosas_fase_9:
	defb 0a0h,0a0h,020h,020h,000h,000h,000h,000h,000h	; 8606  ..  .....

; ----------------------------------------------------------------------
; DATOS cosas_fase_10: un byte por cada una de las 9 habitaciones de la fase
;   10: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (9 bytes)
;   0x860f..0x8618  (9 bytes)
DATA_cosas_fase_10:
	defb 008h,004h,004h,004h,004h,004h,000h,000h,000h	; 860f  .........

; ----------------------------------------------------------------------
; DATOS cosas_fase_11: un byte por cada una de las 6 habitaciones de la fase
;   11: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (6 bytes)
;   0x8618..0x861e  (6 bytes)
DATA_cosas_fase_11:
	defb 081h,000h,040h,040h,040h,080h	; 8618

; ----------------------------------------------------------------------
; DATOS cosas_fase_12: un byte por cada una de las 12 habitaciones de la fase
;   12: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (12 bytes)
;   0x861e..0x862a  (12 bytes)
DATA_cosas_fase_12:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 861e  ............

; ----------------------------------------------------------------------
; DATOS cosas_fase_13: un byte por cada una de las 12 habitaciones de la fase
;   13: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (12 bytes)
;   0x862a..0x8636  (12 bytes)
DATA_cosas_fase_13:
	defb 000h,000h,080h,000h,000h,000h,080h,080h,080h,080h,080h,080h	; 862a  ............

; ----------------------------------------------------------------------
; DATOS cosas_fase_14: un byte por cada una de las 8 habitaciones de la fase
;   14: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (8 bytes)
;   0x8636..0x863e  (8 bytes)
DATA_cosas_fase_14:
	defb 080h,080h,080h,080h,080h,080h,080h,080h	; 8636  ........

; ----------------------------------------------------------------------
; DATOS cosas_fase_15: un byte por cada una de las 10 habitaciones de la fase
;   15: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (10 bytes)
;   0x863e..0x8648  (10 bytes)
DATA_cosas_fase_15:
	defb 000h,080h,080h,080h,000h,000h,000h,080h,000h,000h	; 863e  ..........

; ----------------------------------------------------------------------
; DATOS cosas_fase_16: un byte por cada una de las 10 habitaciones de la fase
;   16: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (10 bytes)
;   0x8648..0x8652  (10 bytes)
DATA_cosas_fase_16:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8648  ..........

; ----------------------------------------------------------------------
; DATOS cosas_fase_17: un byte por cada una de las 12 habitaciones de la fase
;   17: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (12 bytes)
;   0x8652..0x865e  (12 bytes)
DATA_cosas_fase_17:
	defb 000h,000h,000h,080h,000h,080h,000h,040h,000h,000h,040h,000h	; 8652  .......@..@.

; ----------------------------------------------------------------------
; DATOS cosas_fase_18: un byte por cada una de las 10 habitaciones de la fase
;   18: cada bit puesto llama a una de las siete rutinas de p00:5EF6-p00:5F19;
;   lo leen p00:5EE7 (10 bytes)
;   0x865e..0x8668  (10 bytes)
DATA_cosas_fase_18:
	defb 000h,080h,000h,000h,000h,000h,000h,080h,080h,000h	; 865e  ..........

; ----------------------------------------------------------------------
; DATOS tres_listas_de_cada_bloque: 6 punteros, uno por bloque de tres fases,
;   a las tres listas que p01:6181 copia a 0xDB00, 0xDC00 y 0xDD00; lo leen
;   p01:61A1 (12 bytes)
;   0x8668..0x8674  (12 bytes)
DATA_tres_listas_de_cada_bloque:
	defb 074h,086h	; 8668
	defb 08eh,086h	; 866a
	defb 0b6h,086h	; 866c
	defb 006h,087h	; 866e
	defb 03fh,087h	; 8670
	defb 0ceh,087h	; 8672

; ----------------------------------------------------------------------
; DATOS tres_listas_8674: tres listas seguidas para p01:6181 (0xFF acaba cada
;   una, 0x00 salta 16 en el destino, y si no, pares de bytes); lo leen
;   p01:6185 (26 bytes)
;   0x8674..0x868e  (26 bytes)
DATA_tres_listas_8674:
	defb 000h,000h,005h,088h,000h,085h,046h,000h,000h,000h,000h,085h,06ch,0ffh,0ffh,005h	; 8674  ......F.....l...
	defb 087h,000h,005h,088h,085h,0abh,000h,01fh,067h,0ffh	; 8684  ........g.

; ----------------------------------------------------------------------
; DATOS tres_listas_868E: tres listas seguidas para p01:6181 (0xFF acaba cada
;   una, 0x00 salta 16 en el destino, y si no, pares de bytes); lo leen
;   p01:6185 (40 bytes)
;   0x868e..0x86b6  (40 bytes)
DATA_tres_listas_868E:
	defb 006h,0ceh,006h,069h,000h,006h,0c8h,006h,064h,01fh,034h,000h,006h,0cbh,006h,064h	; 868e  ...i....d.4....d
	defb 000h,01fh,033h,000h,006h,0cah,006h,0a6h,0ffh,000h,000h,006h,065h,000h,006h,06ah	; 869e  ..3.........e..j
	defb 006h,0aah,0ffh,000h,000h,00ah,05ch,0ffh	; 86ae  ......\.

; ----------------------------------------------------------------------
; DATOS tres_listas_86B6: tres listas seguidas para p01:6181 (0xFF acaba cada
;   una, 0x00 salta 16 en el destino, y si no, pares de bytes); lo leen
;   p01:6185 (80 bytes)
;   0x86b6..0x8706  (80 bytes)
DATA_tres_listas_86B6:
	defb 000h,00dh,095h,00dh,09ah,000h,00bh,0b9h,000h,00bh,0cbh,000h,00bh,0cdh,00dh,08bh	; 86b6  ................
	defb 00dh,055h,000h,00bh,093h,000h,00bh,0b9h,000h,00ch,057h,000h,00ch,057h,0ffh,000h	; 86c6  .U........W..W..
	defb 000h,00bh,05dh,000h,00bh,099h,000h,000h,00ch,055h,000h,00ah,099h,00ch,0c5h,000h	; 86d6  ..]......U......
	defb 00bh,0c8h,0ffh,000h,00ah,07ch,000h,00ah,075h,00ah,07bh,000h,000h,00ah,075h,00bh	; 86e6  .....|..u.{...u.
	defb 07bh,000h,00dh,075h,00dh,057h,000h,00bh,054h,000h,000h,00bh,0b3h,00dh,057h,0ffh	; 86f6  {..u.W..T.....W.

; ----------------------------------------------------------------------
; DATOS tres_listas_8706: tres listas seguidas para p01:6181 (0xFF acaba cada
;   una, 0x00 salta 16 en el destino, y si no, pares de bytes); lo leen
;   p01:6185 (57 bytes)
;   0x8706..0x873f  (57 bytes)
DATA_tres_listas_8706:
	defb 000h,000h,000h,000h,000h,000h,021h,0b3h,021h,0bch,000h,021h,0b8h,000h,021h,0b3h	; 8706  ......!.!..!..!.
	defb 021h,0bdh,0ffh,000h,00dh,059h,000h,00dh,077h,000h,000h,000h,00eh,07dh,0ffh,00eh	; 8716  !....Y..w....}..
	defb 09ch,000h,000h,000h,000h,00eh,065h,000h,00eh,07dh,000h,000h,00eh,096h,000h,00eh	; 8726  ......e..}......
	defb 099h,000h,000h,00eh,09ah,000h,00eh,09eh,0ffh	; 8736  .........

; ----------------------------------------------------------------------
; DATOS tres_listas_873F: tres listas seguidas para p01:6181 (0xFF acaba cada
;   una, 0x00 salta 16 en el destino, y si no, pares de bytes); lo leen
;   p01:6185 (143 bytes)
;   0x873f..0x87ce  (143 bytes)
DATA_tres_listas_873F:
	defb 00bh,0bch,009h,05ch,000h,00bh,054h,00dh,07bh,000h,00dh,055h,00dh,05ah,00dh,097h	; 873f  ...\..T.{..U.Z..
	defb 00dh,0beh,000h,00bh,056h,00bh,05ch,00dh,09dh,000h,00bh,09ch,009h,0b2h,000h,00bh	; 874f  ....V.\.........
	defb 05ch,00bh,077h,00dh,0b6h,00dh,0bch,000h,00dh,057h,000h,00bh,056h,00bh,0b4h,000h	; 875f  \.w......W..V...
	defb 009h,05bh,009h,074h,009h,0bah,000h,009h,055h,009h,07ch,009h,0b4h,009h,0b7h,000h	; 876f  .[.t....U.|.....
	defb 00bh,079h,00bh,0b4h,000h,00dh,05ah,00dh,075h,00dh,0b6h,0ffh,010h,07ch,000h,010h	; 877f  .y....Z.u....|..
	defb 072h,010h,0bah,000h,010h,0b9h,000h,009h,056h,009h,05ch,009h,0b2h,009h,0bah,000h	; 878f  r.......V.\.....
	defb 010h,059h,010h,0b4h,000h,010h,0bah,000h,010h,074h,010h,0bch,000h,010h,058h,010h	; 879f  .Y.......t....X.
	defb 0bdh,0ffh,000h,010h,058h,010h,0b5h,000h,010h,055h,010h,0b5h,000h,010h,0bch,000h	; 87af  ....X....U......
	defb 010h,079h,010h,0b6h,000h,000h,010h,0bah,000h,010h,0bah,000h,010h,0bah,0ffh	; 87bf  .y.............

; ----------------------------------------------------------------------
; DATOS tres_listas_87CE: tres listas seguidas para p01:6181 (0xFF acaba cada
;   una, 0x00 salta 16 en el destino, y si no, pares de bytes); lo leen
;   p01:6185 (86 bytes)
;   0x87ce..0x8824  (86 bytes)
DATA_tres_listas_87CE:
	defb 000h,012h,0b8h,000h,012h,097h,000h,012h,098h,000h,012h,0bah,000h,000h,000h,012h	; 87ce  ................
	defb 056h,000h,012h,058h,0ffh,000h,00bh,0b6h,000h,00dh,07eh,000h,010h,076h,000h,010h	; 87de  V..X......~..v..
	defb 05bh,010h,0bah,000h,010h,053h,000h,00dh,079h,00dh,0b9h,000h,000h,00dh,053h,000h	; 87ee  [....S..y.....S.
	defb 00dh,055h,0ffh,000h,010h,056h,000h,010h,095h,000h,00dh,07dh,00dh,077h,000h,00dh	; 87fe  .U...V.....}.w..
	defb 077h,00dh,053h,000h,00dh,05ah,00dh,054h,000h,00dh,07bh,00dh,0b4h,000h,00dh,079h	; 880e  w.S..Z.T..{....y
	defb 00dh,055h,000h,010h,0b6h,0ffh	; 881e

; ----------------------------------------------------------------------
; DATOS letras_8824: 14 caracteres de 8x8 a 1 bit (8 bytes cada uno) que
;   0x4AA5 pinta de color al subirlos; lo leen p00:53EA (112 bytes)
;   0x8824..0x8894  (112 bytes)
DATA_letras_8824:
	defb 07ch,0c4h,086h,082h,0c2h,046h,07ch,000h	; 8824  |....F|.
	defb 018h,030h,010h,010h,010h,020h,038h,000h	; 882c  .0... 8.
	defb 07ch,082h,0c2h,01ch,060h,082h,0feh,000h	; 8834  |...`...
	defb 07ch,082h,006h,018h,006h,082h,07ch,000h	; 883c  |.....|.
	defb 00eh,012h,024h,044h,086h,0fah,006h,000h	; 8844  ..$D....
	defb 0feh,040h,078h,0c6h,002h,0c2h,03ch,000h	; 884c  .@x...<.
	defb 03ch,040h,0bch,0c6h,082h,086h,07ch,000h	; 8854  <@....|.
	defb 0feh,082h,044h,008h,008h,010h,018h,000h	; 885c  ..D.....
	defb 07ch,086h,082h,07ch,082h,0c2h,07ch,000h	; 8864  |..|..|.
	defb 07ch,0c2h,082h,0c6h,07ah,004h,078h,000h	; 886c  |...z.x.
	defb 000h,000h,000h,000h,000h,060h,060h,000h	; 8874  .....``.
	defb 060h,060h,020h,040h,000h,000h,000h,000h	; 887c  `` @....
	defb 000h,018h,018h,000h,018h,018h,000h,000h	; 8884  ........
	defb 000h,000h,000h,000h,030h,030h,010h,020h	; 888c  ....00.

; ----------------------------------------------------------------------
; DATOS letras_8894: 26 caracteres de 8x8 a 1 bit (8 bytes cada uno) que
;   0x4AA5 pinta de color al subirlos; lo leen p00:53F6 (208 bytes)
;   0x8894..0x8964  (208 bytes)
DATA_letras_8894:
	defb 038h,044h,044h,082h,0e2h,09eh,0c6h,000h	; 8894  8DD.....
	defb 0fch,082h,044h,078h,044h,082h,0fch,000h	; 889c  ..DxD...
	defb 03ch,046h,080h,080h,080h,046h,03ch,000h	; 88a4  <F...F<.
	defb 0f8h,084h,042h,042h,042h,084h,0f8h,000h	; 88ac  ..BBB...
	defb 0fch,086h,040h,078h,040h,086h,0fch,000h	; 88b4  ..@x@...
	defb 0fch,086h,040h,078h,040h,080h,0c0h,000h	; 88bc  ..@x@...
	defb 03ch,046h,080h,08eh,082h,046h,03ch,000h	; 88c4  <F...F<.
	defb 0c6h,082h,044h,07ch,044h,082h,0c6h,000h	; 88cc  ..D|D...
	defb 038h,020h,010h,010h,010h,008h,038h,000h	; 88d4  8 ....8.
	defb 00eh,002h,004h,084h,084h,0cch,078h,000h	; 88dc  ......x.
	defb 0c6h,08ch,050h,060h,050h,090h,0ceh,000h	; 88e4  ..P`P...
	defb 0c0h,080h,040h,040h,042h,086h,0fch,000h	; 88ec  ..@@B...
	defb 0c6h,044h,06ch,054h,054h,082h,0c6h,000h	; 88f4  .DlTT...
	defb 0c6h,042h,064h,054h,04ch,084h,0c6h,000h	; 88fc  .BdTL...
	defb 03ch,046h,0c2h,082h,086h,0c4h,078h,000h	; 8904  <F....x.
	defb 0fch,086h,042h,046h,07ch,080h,0c0h,000h	; 890c  ..BF|...
	defb 03ch,046h,0c2h,082h,09eh,0c4h,07eh,000h	; 8914  <F....~.
	defb 0fch,082h,042h,07ch,048h,088h,0c6h,000h	; 891c  ..B|H...
	defb 07ch,086h,0c0h,07ch,006h,0c2h,07ch,000h	; 8924  |..|..|.
	defb 07ch,092h,010h,010h,010h,008h,038h,000h	; 892c  |.....8.
	defb 0c6h,082h,044h,082h,082h,0c6h,07ch,000h	; 8934  ..D...|.
	defb 0c6h,082h,044h,044h,06ch,028h,038h,000h	; 893c  ..DDl(8.
	defb 0c6h,092h,054h,054h,06ch,0c6h,082h,000h	; 8944  ..TTl...
	defb 0c6h,082h,044h,038h,044h,082h,0c6h,000h	; 894c  ..D8D...
	defb 0c6h,082h,044h,028h,010h,008h,038h,000h	; 8954  ..D(..8.
	defb 0feh,082h,01ch,010h,070h,082h,0feh,000h	; 895c  ....p...

; ======================================================================
; CODIGO 0x8964..0x8a45  (225 bytes)
; ======================================================================


L_8964:
	ld a,(0c097h)		;8964
	ld e,a			;8967
	ld a,007h		;8968
	call 00093h		;896a   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c098h)		;896d
	bit 0,a		;8970
	jp nz,L_89F2		;8972
	bit 1,a		;8975
	jp nz,L_89F6		;8977
	ld a,(0c0a5h)		;897a
	dec a			;897d
	jp m,L_89A5		;897e
	jp nz,L_89A2		;8981
	ld a,(0c0a6h)		;8984
	dec a			;8987
	ld (0c0a6h),a		;8988
	cp 0f0h		;898b
	jp nz,L_89A0		;898d
	ld hl,L_89CE		;8990
	ld (0c010h),hl		;8993
	ld (0c012h),hl		;8996
	ld (0c014h),hl		;8999
	xor a			;899c
	jp L_89A2		;899d
L_89A0:
	ld a,03ah		;89a0
L_89A2:
	ld (0c0a5h),a		;89a2
L_89A5:
	xor a			;89a5
	ld b,a			;89a6
	ld hl,(0c010h)		;89a7
	call L_89C6		;89aa
	ld a,001h		;89ad
	ld b,a			;89af
	ld hl,(0c012h)		;89b0
	call L_89C6		;89b3
	ld a,002h		;89b6
	ld b,a			;89b8
	ld hl,(0c014h)		;89b9
L_89BC:
	call L_89C6		;89bc
	ld a,002h		;89bf
	ld b,003h		;89c1
	ld hl,(0c016h)		;89c3
L_89C6:
	ld (0c094h),a		;89c6
	ld a,b			;89c9
	ld (0c095h),a		;89ca
	jp (hl)			;89cd
L_89CE:
	ld a,(0c095h)		;89ce
	cp 003h		;89d1
	jp nz,L_89DD		;89d3
	xor a			;89d6
	ld (0c096h),a		;89d7
	ld a,(0c095h)		;89da
L_89DD:
	rlca			;89dd
	ld hl,0c010h		;89de
	add a,l			;89e1
	ld l,a			;89e2
	jr nc,L_89E6		;89e3
	inc h			;89e5
L_89E6:
	ld de,L_89F1		;89e6
	ld (hl),e			;89e9
	inc hl			;89ea
	ld (hl),d			;89eb
	ld e,000h		;89ec
	jp L_8A0B		;89ee
L_89F1:
	ret			;89f1
L_89F2:
	ld hl,(0c01ah)		;89f2
	jp (hl)			;89f5
L_89F6:
	xor a			;89f6
	ld b,004h		;89f7
	ld hl,(0c018h)		;89f9
	jp L_89BC		;89fc
L_89FF:
	ld a,(0c094h)		;89ff
	rlca			;8a02
	call 00093h		;8a03   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;8a06
	ld e,d			;8a07
	jp 00093h		;8a08   ; BIOS WRTPSG - Writes data to PSG-register
L_8A0B:
	ld a,(0c094h)		;8a0b
	add a,008h		;8a0e
	jp 00093h		;8a10   ; BIOS WRTPSG - Writes data to PSG-register
L_8A13:
	push hl			;8a13
	ld hl,08a57h		;8a14
	jp L_8A2C		;8a17
L_8A1A:
	push hl			;8a1a
	ld hl,08a51h		;8a1b
	jp L_8A2C		;8a1e
L_8A21:
	push hl			;8a21
	ld hl,08a4bh		;8a22
	jp L_8A2C		;8a25
L_8A28:
	push hl			;8a28
	ld hl,08a45h		;8a29
L_8A2C:
	ld a,(0c094h)		;8a2c
	rlca			;8a2f
	add a,l			;8a30
	ld l,a			;8a31
	jr nc,L_8A35		;8a32
	inc h			;8a34
L_8A35:
	ld a,(0c097h)		;8a35
	and (hl)			;8a38
	inc hl			;8a39
	or (hl)			;8a3a
	ld (0c097h),a		;8a3b
	pop hl			;8a3e
	ld e,a			;8a3f
	ld a,007h		;8a40
	jp 00093h		;8a42   ; BIOS WRTPSG - Writes data to PSG-register

; ----------------------------------------------------------------------
; DATOS mascaras_del_mezclador: cuatro tablas de 6 bytes, [AND][OR] por canal,
;   para abrir o cerrar tono y ruido en el registro 7 del PSG (p14:8A2C); lo
;   leen p14:8A14 (24 bytes)
;   0x8a45..0x8a5d  (24 bytes)
DATA_mascaras_del_mezclador:
	defb 0feh,008h,0fdh,010h,0fbh,020h	; 8a45
	defb 0f7h,001h,0efh,002h,0dfh,004h	; 8a4b
	defb 0f6h,000h,0edh,000h,0dbh,000h	; 8a51
	defb 0ffh,009h,0ffh,012h,0ffh,024h	; 8a57

; ======================================================================
; CODIGO 0x8a5d..0x8b81  (292 bytes)
; ======================================================================


L_8A5D:
	ld ix,0c080h		;8a5d
	jp L_8A76		;8a61
L_8A64:
	ld ix,0c01ch		;8a64
	jp L_8A76		;8a68
L_8A6B:
	ld ix,0c030h		;8a6b
	jp L_8A76		;8a6f
L_8A72:
	ld ix,0c044h		;8a72
L_8A76:
	ld a,(0c095h)		;8a76
	cp 002h		;8a79
	jp nz,L_8A89		;8a7b
	ld a,(0c096h)		;8a7e
	or a			;8a81
	jp z,L_8A89		;8a82
	set 5,(ix+002h)		;8a85
L_8A89:
	dec (ix+009h)		;8a89
	jp z,L_8ACA		;8a8c
	bit 0,(ix+002h)		;8a8f
	jp z,L_8AB3		;8a93
	ld a,(ix+009h)		;8a96
	cp (ix+00bh)		;8a99
	jp nc,L_8AA3		;8a9c
	cp (ix+006h)		;8a9f
	ret nc			;8aa2
L_8AA3:
	ld e,(ix+00ah)		;8aa3
	dec e			;8aa6
	ret m			;8aa7
	ld (ix+00ah),e		;8aa8
	bit 5,(ix+002h)		;8aab
	ret nz			;8aaf
	jp L_8A0B		;8ab0
L_8AB3:
	bit 5,(ix+002h)		;8ab3
	ret nz			;8ab7
	bit 7,(ix+002h)		;8ab8
	ret nz			;8abc
	call L_8CA7		;8abd
	ret nc			;8ac0
	set 7,(ix+002h)		;8ac1
	ld e,000h		;8ac5
	jp L_8A0B		;8ac7
L_8ACA:
	ld l,(ix+000h)		;8aca
	ld h,(ix+001h)		;8acd
L_8AD0:
	ld a,(hl)			;8ad0
	inc hl			;8ad1
	ld c,a			;8ad2
	cp 0d0h		;8ad3
	jp nc,L_8BB4		;8ad5
	ld (ix+000h),l		;8ad8
	ld (ix+001h),h		;8adb
	cp 0c0h		;8ade
	jp nc,L_8B99		;8ae0
	and 00fh		;8ae3
	inc a			;8ae5
	ld b,a			;8ae6
	ld e,(ix+003h)		;8ae7
	xor a			;8aea
L_8AEB:
	add a,e			;8aeb
	djnz L_8AEB		;8aec
	ld (ix+009h),a		;8aee
	ld a,(0c095h)		;8af1
	cp 002h		;8af4
	jp nz,L_8B04		;8af6
	ld a,(0c096h)		;8af9
	or a			;8afc
	jp nz,L_8B04		;8afd
	res 5,(ix+002h)		;8b00
L_8B04:
	bit 0,(ix+002h)		;8b04
	jp z,L_8B53		;8b08
	ld a,(ix+009h)		;8b0b
	sub (ix+005h)		;8b0e
	ld (ix+00bh),a		;8b11
	bit 5,(ix+002h)		;8b14
	ret nz			;8b18
	ld a,c			;8b19
	and 0f0h		;8b1a
	rrca			;8b1c
	rrca			;8b1d
	rrca			;8b1e
	ld hl,08b81h		;8b1f
	add a,l			;8b22
	ld l,a			;8b23
	jr nc,L_8B27		;8b24
	inc h			;8b26
L_8B27:
	ld e,(hl)			;8b27
	inc hl			;8b28
	ld d,(hl)			;8b29
	ld b,(ix+007h)		;8b2a
L_8B2D:
	srl d		;8b2d
	rr e		;8b2f
	djnz L_8B2D		;8b31
	bit 6,(ix+002h)		;8b33
	jp z,L_8B3C		;8b37
	inc de			;8b3a
	inc de			;8b3b
L_8B3C:
	call L_89FF		;8b3c
	ld a,(0c0a6h)		;8b3f
	add a,(ix+004h)		;8b42
	jp p,L_8B49		;8b45
	xor a			;8b48
L_8B49:
	ld (ix+00ah),a		;8b49
	ld e,a			;8b4c
	call L_8A0B		;8b4d
	jp L_8A28		;8b50
L_8B53:
	bit 2,(ix+002h)		;8b53
	jp nz,L_8B7B		;8b57
	ld hl,0aad9h		;8b5a
L_8B5D:
	ld a,c			;8b5d
	and 0f0h		;8b5e
	rrca			;8b60
	rrca			;8b61
	rrca			;8b62
	add a,l			;8b63
	ld l,a			;8b64
	jr nc,L_8B68		;8b65
	inc h			;8b67
L_8B68:
	ld a,(hl)			;8b68
	ld (ix+00ch),a		;8b69
	inc hl			;8b6c
	ld a,(hl)			;8b6d
	ld (ix+00dh),a		;8b6e
	res 7,(ix+002h)		;8b71
	ld a,001h		;8b75
	ld (ix+00eh),a		;8b77
	ret			;8b7a
L_8B7B:
	ld hl,0aaf1h		;8b7b
	jp L_8B5D		;8b7e

; ----------------------------------------------------------------------
; DATOS periodos_de_las_notas: doce palabras: el periodo de tono del PSG de
;   cada nota (do a si) de la octava mas grave; las otras octavas se sacan
;   dividiendo; lo leen p14:8B1F (24 bytes)
;   0x8b81..0x8b99  (24 bytes)
DATA_periodos_de_las_notas:
	defb 0b8h,01ah	; 8b81
	defb 038h,019h	; 8b83
	defb 0d0h,017h	; 8b85
	defb 078h,016h	; 8b87
	defb 034h,015h	; 8b89
	defb 004h,014h	; 8b8b
	defb 0e4h,012h	; 8b8d
	defb 0d4h,011h	; 8b8f
	defb 0d4h,010h	; 8b91
	defb 0e4h,00fh	; 8b93
	defb 000h,00fh	; 8b95
	defb 028h,00eh	; 8b97

; ======================================================================
; CODIGO 0x8b99..0x8d8f  (502 bytes)
; ======================================================================


L_8B99:
	and 00fh		;8b99
	inc a			;8b9b
	ld b,a			;8b9c
	ld e,(ix+003h)		;8b9d
	xor a			;8ba0
L_8BA1:
	add a,e			;8ba1
	djnz L_8BA1		;8ba2
	ld (ix+009h),a		;8ba4
	bit 5,(ix+002h)		;8ba7
	ret nz			;8bab
	ld e,000h		;8bac
	ld (ix+00ah),e		;8bae
	jp L_8A0B		;8bb1
L_8BB4:
	and 0f0h		;8bb4
	cp 0d0h		;8bb6
	jp z,L_8C06		;8bb8
	cp 0e0h		;8bbb
	jp z,L_8C0F		;8bbd
	ld a,c			;8bc0
	and 00fh		;8bc1
	cp 00fh		;8bc3
	jp z,L_8C80		;8bc5
	cp 00eh		;8bc8
	jp nz,L_8BED		;8bca
	ld a,(ix+010h)		;8bcd
	dec a			;8bd0
	jp z,L_8BE4		;8bd1
	jp p,L_8BD9		;8bd4
	ld a,(hl)			;8bd7
	dec a			;8bd8
L_8BD9:
	inc hl			;8bd9
	ld (ix+010h),a		;8bda
	ld a,(hl)			;8bdd
	inc hl			;8bde
	ld h,(hl)			;8bdf
	ld l,a			;8be0
	jp L_8AD0		;8be1
L_8BE4:
	ld (ix+010h),a		;8be4
	inc hl			;8be7
	inc hl			;8be8
	inc hl			;8be9
	jp L_8AD0		;8bea
L_8BED:
	inc a			;8bed
	ld (ix+004h),a		;8bee
	ld a,(hl)			;8bf1
	rrca			;8bf2
	rrca			;8bf3
	rrca			;8bf4
	rrca			;8bf5
	and 00fh		;8bf6
	dec a			;8bf8
	ld (ix+005h),a		;8bf9
	ld a,(hl)			;8bfc
	inc hl			;8bfd
	and 00fh		;8bfe
	ld (ix+006h),a		;8c00
	jp L_8AD0		;8c03
L_8C06:
	ld a,c			;8c06
	and 00fh		;8c07
	ld (ix+003h),a		;8c09
	jp L_8AD0		;8c0c
L_8C0F:
	ld a,c			;8c0f
	and 00fh		;8c10
	cp 006h		;8c12
	jp c,L_8C42		;8c14
	jp z,L_8C4C		;8c17
	cp 007h		;8c1a
	jp z,L_8C5B		;8c1c
	cp 00ah		;8c1f
	jp z,L_8C62		;8c21
	cp 00bh		;8c24
	jp z,L_8C54		;8c26
	cp 00dh		;8c29
	jp z,L_8C69		;8c2b
	cp 00eh		;8c2e
	jp z,L_8C77		;8c30
	and 007h		;8c33
	ld b,a			;8c35
	ld a,(ix+002h)		;8c36
	and 0f8h		;8c39
	or b			;8c3b
	ld (ix+002h),a		;8c3c
	jp L_8AD0		;8c3f
L_8C42:
	neg		;8c42
	add a,006h		;8c44
	ld (ix+007h),a		;8c46
	jp L_8AD0		;8c49
L_8C4C:
	ld a,001h		;8c4c
	ld (0c0a8h),a		;8c4e
	jp L_8AD0		;8c51
L_8C54:
	xor a			;8c54
	ld (0c0a8h),a		;8c55
	jp L_8AD0		;8c58
L_8C5B:
	set 6,(ix+002h)		;8c5b
	jp L_8AD0		;8c5f
L_8C62:
	ld a,(hl)			;8c62
	inc hl			;8c63
	ld h,(hl)			;8c64
	ld l,a			;8c65
	jp L_8AD0		;8c66
L_8C69:
	ld e,(hl)			;8c69
	inc hl			;8c6a
	ld d,(hl)			;8c6b
	inc hl			;8c6c
	ld (ix+012h),l		;8c6d
	ld (ix+013h),h		;8c70
	ex de,hl			;8c73
	jp L_8AD0		;8c74
L_8C77:
	ld l,(ix+012h)		;8c77
	ld h,(ix+013h)		;8c7a
	jp L_8AD0		;8c7d
L_8C80:
	ld a,(0c095h)		;8c80
	inc a			;8c83
	ld b,a			;8c84
	ld a,07fh		;8c85
L_8C87:
	rlca			;8c87
	djnz L_8C87		;8c88
	ld b,a			;8c8a
	ld a,(0c0a7h)		;8c8b
	and b			;8c8e
	ld (0c0a7h),a		;8c8f
	jp L_89CE		;8c92
L_8C95:
	ld ix,0c06ch		;8c95
	jp L_8CA0		;8c99
L_8C9C:
	ld ix,0c058h		;8c9c
L_8CA0:
	call L_8CA7		;8ca0
	ret nc			;8ca3
	jp L_89CE		;8ca4
L_8CA7:
	dec (ix+00eh)		;8ca7
	jp nz,L_8D8B		;8caa
	ld a,(ix+00fh)		;8cad
	ld (ix+00eh),a		;8cb0
	ld l,(ix+00ch)		;8cb3
	ld h,(ix+00dh)		;8cb6
L_8CB9:
	ld a,(hl)			;8cb9
	cp 0ffh		;8cba
	jp z,L_8D8D		;8cbc
	inc hl			;8cbf
	ld c,a			;8cc0
	cp 0feh		;8cc1
	jp z,L_8D18		;8cc3
	and 0f0h		;8cc6
	cp 020h		;8cc8
	jp z,L_8D38		;8cca
	cp 010h		;8ccd
	jp nz,L_8CE1		;8ccf
	ld a,c			;8cd2
	and 00fh		;8cd3
	rlca			;8cd5
	ld e,a			;8cd6
	ld a,006h		;8cd7
	call 00093h		;8cd9   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(hl)			;8cdc
	inc hl			;8cdd
	ld c,a			;8cde
	and 0f0h		;8cdf
L_8CE1:
	rrca			;8ce1
	rrca			;8ce2
	rrca			;8ce3
	rrca			;8ce4
	ld e,a			;8ce5
	bit 4,(ix+00ah)		;8ce6
	jp z,L_8CF5		;8cea
	ld a,00dh		;8ced
	call 00093h		;8cef   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_8D09		;8cf2
L_8CF5:
	ld a,(0c095h)		;8cf5
	cp 003h		;8cf8
	jp nc,L_8D06		;8cfa
	ld a,(0c0a6h)		;8cfd
	add a,e			;8d00
	jp p,L_8D05		;8d01
	xor a			;8d04
L_8D05:
	ld e,a			;8d05
L_8D06:
	call L_8A0B		;8d06
L_8D09:
	ld a,c			;8d09
	and 00fh		;8d0a
	ld d,a			;8d0c
	ld e,(hl)			;8d0d
	inc hl			;8d0e
	ld (ix+00ch),l		;8d0f
	ld (ix+00dh),h		;8d12
	jp L_89FF		;8d15
L_8D18:
	ld a,(ix+011h)		;8d18
	dec a			;8d1b
	jp z,L_8D2F		;8d1c
	jp p,L_8D24		;8d1f
	ld a,(hl)			;8d22
	dec a			;8d23
L_8D24:
	inc hl			;8d24
	ld (ix+011h),a		;8d25
	ld a,(hl)			;8d28
	inc hl			;8d29
	ld h,(hl)			;8d2a
	ld l,a			;8d2b
	jp L_8CB9		;8d2c
L_8D2F:
	ld (ix+011h),a		;8d2f
	inc hl			;8d32
	inc hl			;8d33
	inc hl			;8d34
	jp L_8CB9		;8d35
L_8D38:
	bit 0,c		;8d38
	jp nz,L_8D4E		;8d3a
	bit 1,c		;8d3d
	jp nz,L_8D48		;8d3f
	call L_8A13		;8d42
	jp L_8D5C		;8d45
L_8D48:
	call L_8A28		;8d48
	jp L_8D5C		;8d4b
L_8D4E:
	bit 1,c		;8d4e
	jp nz,L_8D59		;8d50
	call L_8A21		;8d53
	jp L_8D5C		;8d56
L_8D59:
	call L_8A1A		;8d59
L_8D5C:
	ld a,c			;8d5c
	rlca			;8d5d
	and 010h		;8d5e
	ld (ix+00ah),a		;8d60
	ld e,a			;8d63
	call L_8A0B		;8d64
	ld a,(hl)			;8d67
	inc hl			;8d68
	ld (ix+00eh),a		;8d69
	ld (ix+00fh),a		;8d6c
	ld a,c			;8d6f
	cp 020h		;8d70
	jp z,L_8D8B		;8d72
	cp 028h		;8d75
	jp c,L_8CB9		;8d77
	ld e,(hl)			;8d7a
	inc hl			;8d7b
	ld a,00ch		;8d7c
	call 00093h		;8d7e   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,(hl)			;8d81
	inc hl			;8d82
	ld a,00bh		;8d83
	call 00093h		;8d85   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_8CB9		;8d88
L_8D8B:
	or a			;8d8b
	ret			;8d8c
L_8D8D:
	scf			;8d8d
	ret			;8d8e

; ----------------------------------------------------------------------
; DATOS efectos_de_sonido: 29 punteros, los de los efectos 1 a 29 (0x8D8D + 2
;   * A; la entrada 0 serian los `scf / ret` de 0x8D8D); lo leen p00:518C (58
;   bytes)
;   0x8d8f..0x8dc9  (58 bytes)
DATA_efectos_de_sonido:
	defb 02bh,08eh	; 8d8f
	defb 058h,08eh	; 8d91
	defb 08ah,08eh	; 8d93
	defb 099h,08eh	; 8d95
	defb 0aeh,08eh	; 8d97
	defb 0cbh,08eh	; 8d99
	defb 0e4h,08eh	; 8d9b
	defb 0f3h,08eh	; 8d9d
	defb 025h,08fh	; 8d9f
	defb 056h,08fh	; 8da1
	defb 075h,08fh	; 8da3
	defb 0b9h,08fh	; 8da5
	defb 0ddh,08fh	; 8da7
	defb 02eh,090h	; 8da9
	defb 065h,090h	; 8dab
	defb 09ah,090h	; 8dad
	defb 0c7h,090h	; 8daf
	defb 0e6h,090h	; 8db1
	defb 037h,091h	; 8db3
	defb 052h,091h	; 8db5
	defb 079h,091h	; 8db7
	defb 012h,092h	; 8db9
	defb 075h,092h	; 8dbb
	defb 0d8h,092h	; 8dbd
	defb 070h,094h	; 8dbf
	defb 01ah,093h	; 8dc1
	defb 0cah,093h	; 8dc3
	defb 09fh,093h	; 8dc5
	defb 069h,08eh	; 8dc7

; ----------------------------------------------------------------------
; DATOS musicas: 16 musicas, seis bytes cada una: los tres canales del PSG (el
;   numero de p00:509F con el bit 7); lo leen p00:50E7 (96 bytes)
;   0x8dc9..0x8e29  (96 bytes)
DATA_musicas:
	defb 09bh,094h,001h,095h,098h,095h	; 8dc9
	defb 069h,096h,0c7h,096h,06dh,097h	; 8dcf
	defb 0dah,097h,091h,098h,03dh,099h	; 8dd5
	defb 058h,09ah,0b8h,09ah,06ah,09bh	; 8ddb
	defb 015h,09ch,0dbh,09ch,0f8h,09dh	; 8de1
	defb 0c1h,09eh,089h,09fh,051h,0a0h	; 8de7
	defb 057h,0a1h,017h,0a2h,0b9h,0a1h	; 8ded
	defb 0c5h,0a2h,003h,0a3h,05bh,0a3h	; 8df3
	defb 09eh,0a3h,0e4h,0a3h,03ch,0a4h	; 8df9
	defb 09bh,0a4h,0b0h,0a4h,0c4h,0a4h	; 8dff
	defb 0d1h,0a4h,006h,0a5h,01dh,0a5h	; 8e05
	defb 04eh,0a5h,073h,0a5h,0a5h,0a5h	; 8e0b
	defb 0dfh,0a5h,0fdh,0a5h,021h,0a6h	; 8e11
	defb 071h,0a6h,08fh,0a6h,0aah,0a6h	; 8e17
	defb 0c4h,0a6h,065h,0a7h,000h,0a8h	; 8e1d
	defb 022h,0a8h,022h,0a8h,022h,0a8h	; 8e23

; ----------------------------------------------------------------------
; DATOS palabra_suelta: 0xA822 otra vez, detras de la tabla de musicas: el
;   canal de una musica 16 que no existe (la tabla acaba en la 15 y el efecto
;   1 empieza aqui al lado); lo leen nadie (2 bytes)
;   0x8e29..0x8e2b  (2 bytes)
DATA_palabra_suelta:
	defb 022h,0a8h	; 8e29

; ----------------------------------------------------------------------
; DATOS efecto_8E2B: guion de un efecto de sonido (p14:8CB9); lo leen efecto 1
;   (45 bytes)
;   0x8e2b..0x8e58  (45 bytes)
DATA_efecto_8E2B:
	defb 022h,001h,0d0h,0ech,0c0h,046h,0d0h,08eh,0c0h,046h,0d0h,08eh,0d0h,046h,0c0h,050h	; 8e2b  "....F...F...F.P
	defb 0d0h,0f0h,0d0h,0e0h,0d0h,0d0h,0d0h,0c0h,0c0h,0b0h,0b0h,0a0h,0a0h,090h,090h,080h	; 8e3b  ................
	defb 090h,066h,090h,055h,0c0h,044h,0c0h,033h,0e0h,022h,0e0h,011h,0ffh	; 8e4b  .f.U.D.3."...

; ----------------------------------------------------------------------
; DATOS efecto_8E58: guion de un efecto de sonido (p14:8CB9); lo leen efecto 2
;   (17 bytes)
;   0x8e58..0x8e69  (17 bytes)
DATA_efecto_8E58:
	defb 02ah,005h,000h,013h,0a0h,070h,022h,003h,000h,000h,02ah,010h,000h,013h,0a0h,070h	; 8e58  *....p"...*....p
	defb 0ffh	; 8e68

; ----------------------------------------------------------------------
; DATOS efecto_8E69: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   29 (33 bytes)
;   0x8e69..0x8e8a  (33 bytes)
DATA_efecto_8E69:
	defb 022h,003h,060h,010h,070h,014h,080h,018h,090h,01ch,0a0h,020h,0b0h,010h,0c0h,01eh	; 8e69  ".`.p...... ....
	defb 0d0h,02dh,0e0h,03ch,0f0h,051h,0c0h,06ch,0d0h,025h,0c0h,032h,0b0h,062h,0c0h,049h	; 8e79  .-.<.Q.l.%.2.b.I
	defb 0ffh	; 8e89

; ----------------------------------------------------------------------
; DATOS efecto_8E8A: guion de un efecto de sonido (p14:8CB9); lo leen efecto 3
;   (15 bytes)
;   0x8e8a..0x8e99  (15 bytes)
DATA_efecto_8E8A:
	defb 021h,002h,01dh,0c0h,000h,01bh,0c0h,000h,012h,0e0h,000h,01dh,0c0h,000h,0ffh	; 8e8a  !..............

; ----------------------------------------------------------------------
; DATOS efecto_8E99: guion de un efecto de sonido (p14:8CB9); lo leen efecto 4
;   (21 bytes)
;   0x8e99..0x8eae  (21 bytes)
DATA_efecto_8E99:
	defb 021h,001h,011h,090h,000h,012h,0c0h,000h,013h,0e0h,000h,017h,0f0h,000h,01bh,0e0h	; 8e99  !...............
	defb 000h,01ch,0a0h,000h,0ffh	; 8ea9

; ----------------------------------------------------------------------
; DATOS efecto_8EAE: guion de un efecto de sonido (p14:8CB9); lo leen efecto 5
;   (29 bytes)
;   0x8eae..0x8ecb  (29 bytes)
DATA_efecto_8EAE:
	defb 021h,001h,011h,050h,000h,013h,070h,000h,015h,0a0h,000h,017h,0d0h,000h,021h,002h	; 8eae  !..P..p.......!.
	defb 018h,040h,000h,016h,0e0h,000h,014h,030h,000h,012h,0e0h,000h,0ffh	; 8ebe  .@.....0.....

; ----------------------------------------------------------------------
; DATOS efecto_8ECB: guion de un efecto de sonido (p14:8CB9); lo leen efecto 6
;   (25 bytes)
;   0x8ecb..0x8ee4  (25 bytes)
DATA_efecto_8ECB:
	defb 022h,001h,091h,0a0h,0c1h,0e0h,0d1h,050h,0d1h,080h,0e2h,000h,0d1h,0f0h,0e2h,050h	; 8ecb  "......P.......P
	defb 0d2h,0a0h,0c3h,000h,0b3h,080h,0a4h,000h,0ffh	; 8edb  .........

; ----------------------------------------------------------------------
; DATOS efecto_8EE4: guion de un efecto de sonido (p14:8CB9); lo leen efecto 7
;   (15 bytes)
;   0x8ee4..0x8ef3  (15 bytes)
DATA_efecto_8EE4:
	defb 021h,002h,01eh,0d0h,000h,022h,001h,000h,000h,021h,002h,01ah,0e0h,000h,0ffh	; 8ee4  !...."...!.....

; ----------------------------------------------------------------------
; DATOS efecto_8EF3: guion de un efecto de sonido (p14:8CB9); lo leen efecto 8
;   (50 bytes)
;   0x8ef3..0x8f25  (50 bytes)
DATA_efecto_8EF3:
	defb 022h,001h,0d1h,080h,0d2h,000h,021h,003h,01ah,0f0h,000h,000h,000h,021h,002h,019h	; 8ef3  ".....!......!..
	defb 0f0h,000h,018h,0f0h,000h,017h,0e0h,000h,016h,0e0h,000h,015h,0d0h,000h,016h,0d0h	; 8f03  ................
	defb 000h,015h,0c0h,000h,021h,005h,013h,0b0h,000h,080h,000h,070h,000h,060h,000h,050h	; 8f13  ....!......p.`.P
	defb 000h,0ffh	; 8f23

; ----------------------------------------------------------------------
; DATOS efecto_8F25: guion de un efecto de sonido (p14:8CB9); lo leen efecto 9
;   (49 bytes)
;   0x8f25..0x8f56  (49 bytes)
DATA_efecto_8F25:
	defb 022h,001h,0d1h,070h,0d2h,000h,021h,002h,01dh,0f0h,000h,01ah,0f0h,000h,000h,000h	; 8f25  "..p..!.........
	defb 021h,003h,012h,080h,000h,0f0h,000h,015h,0e0h,000h,0c0h,000h,014h,0c0h,000h,015h	; 8f35  !...............
	defb 0b0h,000h,014h,0c0h,000h,013h,0c0h,000h,0a0h,000h,090h,000h,080h,000h,070h,000h	; 8f45  ..............p.
	defb 0ffh	; 8f55

; ----------------------------------------------------------------------
; DATOS efecto_8F56: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   10 (31 bytes)
;   0x8f56..0x8f75  (31 bytes)
DATA_efecto_8F56:
	defb 022h,001h,0a0h,050h,0c0h,060h,0d0h,080h,0e0h,0a0h,0c0h,0d0h,022h,003h,000h,000h	; 8f56  "..P.`......"...
	defb 022h,001h,0b0h,050h,0a0h,060h,090h,080h,080h,0a0h,0feh,004h,056h,08fh,0ffh	; 8f66  "..P.`......V..

; ----------------------------------------------------------------------
; DATOS efecto_8F75: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   11 (68 bytes)
;   0x8f75..0x8fb9  (68 bytes)
DATA_efecto_8F75:
	defb 02ah,001h,000h,005h,081h,0f0h,006h,000h,02ah,002h,006h,000h,090h,02ch,023h,001h	; 8f75  *.......*....,#.
	defb 01fh,0e0h,010h,0e0h,030h,0e0h,010h,0e0h,0a0h,0e0h,060h,0e0h,050h,0e0h,040h,0e0h	; 8f85  ....0.....`.P.@.
	defb 030h,0d0h,020h,0d0h,010h,0d0h,050h,0d0h,040h,0c0h,030h,0c0h,020h,0c0h,010h,0c0h	; 8f95  0. ...P.@.0. ...
	defb 00ah,0b0h,006h,0b0h,040h,0b0h,030h,0a0h,020h,0a0h,010h,02ah,001h,000h,001h,0c0h	; 8fa5  ....@.0. ..*....
	defb 001h,0c0h,001h,0ffh	; 8fb5

; ----------------------------------------------------------------------
; DATOS efecto_8FB9: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   12 (36 bytes)
;   0x8fb9..0x8fdd  (36 bytes)
DATA_efecto_8FB9:
	defb 021h,001h,01dh,0e0h,000h,01fh,0e0h,000h,01eh,0e0h,000h,01dh,0e0h,000h,01ch,0e0h	; 8fb9  !...............
	defb 000h,01ah,0e0h,000h,018h,0e0h,000h,016h,0e0h,000h,014h,0e0h,000h,013h,0e0h,000h	; 8fc9  ................
	defb 011h,0e0h,000h,0ffh	; 8fd9

; ----------------------------------------------------------------------
; DATOS efecto_8FDD: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   13 (81 bytes)
;   0x8fdd..0x902e  (81 bytes)
DATA_efecto_8FDD:
	defb 022h,001h,0f2h,020h,0f2h,0a0h,0f3h,010h,0f3h,070h,0e3h,0c0h,0e4h,030h,0e4h,030h	; 8fdd  ".. .....p...0.0
	defb 0e4h,050h,0e4h,060h,0f2h,060h,0f2h,0a0h,0f3h,010h,0f3h,070h,0f3h,0c0h,022h,002h	; 8fed  .P.`.`.....p..".
	defb 0f4h,000h,0f4h,030h,0f4h,050h,0f4h,060h,022h,001h,0e2h,020h,0e2h,0a0h,0e3h,010h	; 8ffd  ...0.P.`".. ....
	defb 0e3h,070h,0d3h,0c0h,0d4h,000h,0d3h,000h,0d4h,050h,0d4h,060h,0e2h,060h,0e2h,0a0h	; 900d  .p.......P.`.`..
	defb 0e3h,010h,0e3h,070h,0e3h,0c0h,022h,002h,0d4h,000h,0d4h,030h,0d4h,050h,0d4h,060h	; 901d  ...p.."....0.P.`
	defb 0ffh	; 902d

; ----------------------------------------------------------------------
; DATOS efecto_902E: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   14 (55 bytes)
;   0x902e..0x9065  (55 bytes)
DATA_efecto_902E:
	defb 021h,003h,01ch,0f0h,000h,01ah,0f0h,000h,021h,001h,012h,0e0h,000h,021h,003h,018h	; 902e  !.......!....!..
	defb 0a0h,000h,021h,001h,012h,0d0h,000h,021h,004h,016h,090h,000h,021h,001h,012h,0d0h	; 903e  ..!....!....!...
	defb 000h,015h,0e0h,000h,021h,001h,012h,0e0h,000h,021h,004h,014h,0c0h,000h,021h,001h	; 904e  ....!....!....!.
	defb 012h,0f0h,000h,013h,0e0h,000h,0ffh	; 905e

; ----------------------------------------------------------------------
; DATOS efecto_9065: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   15 (53 bytes)
;   0x9065..0x909a  (53 bytes)
DATA_efecto_9065:
	defb 022h,001h,0e0h,049h,0f0h,062h,0f0h,032h,0d0h,025h,0e0h,06ch,0d0h,051h,0e0h,03ch	; 9065  "..I.b.2.%.l.Q.<
	defb 0d0h,02dh,0c0h,01eh,0b0h,010h,0c0h,049h,0b0h,062h,0c0h,032h,0d0h,025h,0c0h,06ch	; 9075  .-.....I.b.2.%.l
	defb 0f0h,051h,0e0h,03ch,0d0h,02dh,0c0h,01eh,0b0h,010h,0a0h,020h,090h,01ch,080h,018h	; 9085  .Q.<.-..... ....
	defb 070h,014h,060h,010h,0ffh	; 9095

; ----------------------------------------------------------------------
; DATOS efecto_909A: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   16 (45 bytes)
;   0x909a..0x90c7  (45 bytes)
DATA_efecto_909A:
	defb 022h,001h,0e0h,0ech,0d0h,046h,0e0h,08eh,0d0h,046h,0e0h,08eh,0e0h,046h,0d0h,050h	; 909a  "....F...F...F.P
	defb 0e0h,0f0h,0e0h,0e0h,0e0h,0d0h,0e0h,0c0h,0d0h,0b0h,0c0h,0a0h,0b0h,090h,0a0h,080h	; 90aa  ................
	defb 0a0h,066h,0a0h,055h,0d0h,044h,0d0h,033h,0f0h,022h,0f0h,011h,0ffh	; 90ba  .f.U.D.3."...

; ----------------------------------------------------------------------
; DATOS efecto_90C7: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   17 (31 bytes)
;   0x90c7..0x90e6  (31 bytes)
DATA_efecto_90C7:
	defb 022h,003h,0f0h,050h,0f0h,035h,000h,000h,0e0h,050h,0e0h,035h,000h,000h,0d0h,050h	; 90c7  "..P.5...P.5...P
	defb 0d0h,035h,000h,000h,0c0h,050h,0c0h,035h,000h,000h,0b0h,050h,0b0h,035h,0ffh	; 90d7  .5...P.5...P.5.

; ----------------------------------------------------------------------
; DATOS efecto_90E6: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   18 (81 bytes)
;   0x90e6..0x9137  (81 bytes)
DATA_efecto_90E6:
	defb 022h,001h,0d0h,066h,0d0h,055h,0d0h,044h,0d0h,033h,0d0h,022h,0d0h,043h,0d0h,03bh	; 90e6  "..f.U.D.3.".C.;
	defb 0d0h,033h,0d0h,02bh,0d0h,023h,022h,001h,0f0h,088h,0f0h,077h,0f0h,066h,0f0h,055h	; 90f6  .3.+.#"....w.f.U
	defb 0f0h,077h,0f0h,066h,0f0h,055h,0f0h,044h,0f0h,03fh,0d0h,030h,0d0h,028h,0d0h,020h	; 9106  .w.f.U.D.?.0.(.
	defb 0d0h,067h,0d0h,057h,0d0h,047h,0d0h,037h,0c0h,088h,0c0h,077h,0c0h,066h,0c0h,055h	; 9116  .g.W.G.7...w.f.U
	defb 0b0h,077h,0b0h,066h,0b0h,055h,0b0h,044h,0a0h,06fh,0a0h,05fh,0a0h,04fh,0a0h,03fh	; 9126  .w.f.U.D.o._.O.?
	defb 0ffh	; 9136

; ----------------------------------------------------------------------
; DATOS efecto_9137: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   19 (27 bytes)
;   0x9137..0x9152  (27 bytes)
DATA_efecto_9137:
	defb 022h,004h,071h,0e0h,0a2h,02ch,0b1h,0e0h,0d2h,02ch,0e1h,0e0h,0e2h,02ch,0d1h,0e0h	; 9137  ".q..,...,...,..
	defb 0c2h,02ch,0b1h,0e0h,0a2h,02ch,091h,0e0h,072h,02ch,0ffh	; 9147  .,...,..r,.

; ----------------------------------------------------------------------
; DATOS efecto_9152: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   20 (39 bytes)
;   0x9152..0x9179  (39 bytes)
DATA_efecto_9152:
	defb 022h,003h,0e0h,028h,0e0h,070h,0e0h,060h,0e0h,040h,0d0h,020h,0c0h,020h,022h,004h	; 9152  "..(.p.`.@. . ".
	defb 0b0h,028h,0b0h,070h,0b0h,060h,0b0h,040h,022h,003h,0a0h,020h,090h,020h,080h,020h	; 9162  .(.p.`.@".. . .
	defb 070h,020h,060h,020h,050h,020h,0ffh	; 9172

; ----------------------------------------------------------------------
; DATOS efecto_9179: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   21 (153 bytes)
;   0x9179..0x9212  (153 bytes)
DATA_efecto_9179:
	defb 022h,001h,0b1h,033h,0b1h,003h,0b0h,0d3h,0b0h,0a3h,0b0h,073h,0e1h,02bh,0e0h,0fbh	; 9179  "..3.......s.+..
	defb 0e0h,0dbh,0e0h,0bbh,0e0h,09bh,0e1h,033h,0e1h,003h,0e0h,0d3h,0e0h,0a3h,0e0h,073h	; 9189  .......3.......s
	defb 0e1h,022h,0e0h,0f2h,0e0h,0c2h,0e0h,092h,0e0h,062h,0e1h,02bh,0e0h,0fbh,0e0h,0dbh	; 9199  .".......b.+....
	defb 0e0h,0bbh,0e0h,09bh,0d1h,007h,0d0h,0d7h,0d0h,0a7h,0d0h,077h,0d0h,047h,0d1h,028h	; 91a9  ...........w.G.(
	defb 0d0h,0f8h,0d0h,0d8h,0d0h,0b8h,0d0h,098h,0c1h,033h,0c1h,003h,0c0h,0d3h,0c0h,0a3h	; 91b9  .........3......
	defb 0c0h,073h,0c1h,007h,0c0h,0d7h,0c0h,0a7h,0c0h,077h,0c0h,047h,0b1h,007h,0b0h,0d7h	; 91c9  .s.......w.G....
	defb 0b0h,0a7h,0b0h,077h,0b0h,047h,0a1h,007h,0a0h,0d7h,0a0h,0a7h,0a0h,077h,0a0h,047h	; 91d9  ...w.G.......w.G
	defb 0c1h,033h,0c1h,003h,0c0h,0d3h,0c0h,0a3h,0c0h,073h,0b1h,007h,0b0h,0d7h,0b0h,0a7h	; 91e9  .3.......s......
	defb 0b0h,077h,0b0h,047h,0a1h,007h,0a0h,0d7h,0a0h,0a7h,0a0h,077h,0a0h,047h,091h,007h	; 91f9  .w.G.......w.G..
	defb 080h,0d7h,090h,0a7h,090h,077h,090h,047h,0ffh	; 9209  .....w.G.

; ----------------------------------------------------------------------
; DATOS efecto_9212: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   22 (99 bytes)
;   0x9212..0x9275  (99 bytes)
DATA_efecto_9212:
	defb 022h,001h,0c0h,044h,0c0h,01eh,0b0h,006h,0b0h,044h,0b0h,01eh,0b0h,006h,0b0h,044h	; 9212  "..D.....D.....D
	defb 0b0h,01eh,0b0h,006h,0c0h,044h,0c0h,01eh,0c0h,006h,0c0h,044h,0c0h,01eh,0c0h,006h	; 9222  .....D.....D....
	defb 0c0h,044h,0c0h,01eh,0c0h,006h,0c0h,044h,0c0h,01eh,0c0h,006h,0c0h,044h,0c0h,01eh	; 9232  .D.....D.....D..
	defb 0c0h,006h,0d0h,044h,0d0h,01eh,0d0h,006h,0d0h,044h,0d0h,01eh,0f0h,006h,0f0h,044h	; 9242  ...D.....D.....D
	defb 0f0h,01eh,0f0h,006h,0f0h,044h,0f0h,01eh,0f0h,006h,0f0h,044h,0f0h,01eh,0f0h,006h	; 9252  .....D.....D....
	defb 0e0h,044h,0e0h,01eh,0e0h,006h,0e0h,044h,0d0h,01eh,0d0h,006h,0d0h,044h,0c0h,01eh	; 9262  .D.....D.....D..
	defb 0b0h,006h,0ffh	; 9272

; ----------------------------------------------------------------------
; DATOS efecto_9275: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   23 (99 bytes)
;   0x9275..0x92d8  (99 bytes)
DATA_efecto_9275:
	defb 022h,001h,090h,055h,0a0h,033h,0b0h,011h,090h,055h,0a0h,033h,0b0h,011h,0a0h,055h	; 9275  "..U.3...U.3...U
	defb 0b0h,033h,0c0h,011h,0b0h,055h,0c0h,033h,0d0h,011h,0c0h,055h,0d0h,033h,0e0h,011h	; 9285  .3...U.3...U.3..
	defb 0c0h,055h,0d0h,033h,0e0h,011h,0d0h,055h,0e0h,033h,0f0h,011h,0e0h,055h,0f0h,033h	; 9295  .U.3...U.3...U.3
	defb 0f0h,011h,0f0h,055h,0f0h,033h,0f0h,011h,0f0h,055h,0f0h,033h,0f0h,011h,0e0h,055h	; 92a5  ...U.3...U.3...U
	defb 0e0h,033h,0e0h,011h,0d0h,055h,0c0h,033h,0c0h,011h,0c0h,055h,0c0h,033h,0c0h,011h	; 92b5  .3...U.3...U.3..
	defb 0b0h,055h,0b0h,033h,0b0h,011h,0b0h,055h,0b0h,033h,0b0h,011h,0b0h,055h,0a0h,033h	; 92c5  .U.3...U.3...U.3
	defb 0a0h,011h,0ffh	; 92d5

; ----------------------------------------------------------------------
; DATOS efecto_92D8: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   24 (66 bytes)
;   0x92d8..0x931a  (66 bytes)
DATA_efecto_92D8:
	defb 023h,003h,014h,0f0h,015h,0f0h,010h,0e0h,02ah,01dh,0e0h,020h,022h,001h,000h,000h	; 92d8  #.......*.. "...
	defb 023h,003h,01fh,0d0h,010h,01eh,0d0h,00ah,01fh,0d0h,025h,01dh,0d0h,01ah,022h,001h	; 92e8  #.........%...".
	defb 000h,000h,021h,003h,014h,050h,000h,01fh,060h,000h,01eh,0a0h,000h,01fh,0a0h,000h	; 92f8  ..!..P..`.......
	defb 01eh,0b0h,000h,01fh,0b0h,000h,01eh,090h,000h,01fh,090h,000h,01dh,090h,000h,080h	; 9308  ................
	defb 000h,0ffh	; 9318

; ----------------------------------------------------------------------
; DATOS efecto_931A: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   26 (133 bytes)
;   0x931a..0x939f  (133 bytes)
DATA_efecto_931A:
	defb 02ah,005h,000h,027h,0c0h,010h,022h,001h,0c2h,059h,0d2h,0bdh,0e3h,03dh,02ah,005h	; 931a  *..'.."..Y...=*.
	defb 000h,027h,0c0h,010h,022h,001h,0f2h,0b6h,0f3h,09eh,0f4h,0e9h,02ah,005h,000h,027h	; 932a  .'..".......*..'
	defb 0c0h,010h,022h,001h,0f2h,0e9h,0f3h,0ceh,0f5h,034h,02ah,005h,000h,027h,0c0h,010h	; 933a  .."......4*..'..
	defb 022h,001h,0e2h,0b6h,0f3h,09eh,0e4h,0e9h,02ah,005h,000h,027h,0c0h,010h,022h,001h	; 934a  ".......*..'..".
	defb 0f2h,0e9h,0e3h,0ceh,0d5h,034h,02ah,005h,000h,027h,0c0h,010h,022h,001h,0e2h,0b6h	; 935a  .....4*..'.."...
	defb 0d3h,09eh,0c4h,0e9h,02ah,005h,000h,027h,0c0h,010h,022h,001h,0c2h,0e9h,0c3h,0ceh	; 936a  ....*..'..".....
	defb 0b5h,034h,02ah,005h,000h,027h,0c0h,010h,022h,001h,0b2h,0b6h,0a3h,09eh,094h,0e9h	; 937a  .4*..'..".......
	defb 02ah,005h,000h,027h,0c0h,010h,022h,001h,0a2h,0e9h,0a3h,0ceh,095h,034h,02ah,005h	; 938a  *..'.."......4*.
	defb 000h,027h,0c0h,010h,0ffh	; 939a

; ----------------------------------------------------------------------
; DATOS efecto_939F: guion de un efecto de sonido (p14:8CB9); se solapan 2
;   bloques (0x939F-0x9463, 0x93CA-0x9463); lo leen efecto 27, efecto 28 (196
;   bytes)
;   0x939f..0x9463  (196 bytes)
DATA_efecto_939F:
	defb 021h,001h,01dh,0e0h,000h,01fh,0e0h,000h,000h,000h,01eh,0e0h,000h,000h,000h,01dh	; 939f  !...............
	defb 0e0h,000h,000h,000h,01ch,0e0h,000h,01ah,0e0h,000h,018h,0e0h,000h,016h,0e0h,000h	; 93af  ................
	defb 014h,0e0h,000h,013h,0e0h,000h,021h,002h,011h,0e0h,000h,022h,001h,0f0h,033h,0f0h	; 93bf  ......!...."..3.
	defb 013h,0f0h,077h,0f0h,097h,0f0h,033h,0f0h,013h,0e0h,077h,0e0h,097h,0e0h,033h,0e0h	; 93cf  ..w...3...w...3.
	defb 013h,0e0h,077h,0e0h,097h,0e0h,033h,0e0h,013h,0c0h,077h,0c0h,097h,0c0h,033h,0c0h	; 93df  ..w...3...w...3.
	defb 02eh,0c0h,029h,0c0h,024h,0c0h,01fh,0c0h,01ah,0c0h,015h,0c0h,010h,0f0h,033h,0f0h	; 93ef  ..).$.........3.
	defb 02dh,0f0h,027h,0f0h,021h,0f0h,01bh,0f0h,015h,0f0h,00fh,0f0h,009h,0e0h,077h,0e0h	; 93ff  -.'.!.........w.
	defb 097h,0e0h,0b7h,0e0h,0d7h,0e0h,0f7h,0e1h,017h,0e1h,037h,0e1h,057h,0e0h,033h,0e0h	; 940f  ..........7.W.3.
	defb 02dh,0e0h,027h,0e0h,021h,0e0h,01bh,0e0h,015h,0e0h,00fh,0e0h,009h,0d0h,077h,0d0h	; 941f  -.'.!.........w.
	defb 097h,0d0h,0b7h,0d0h,0d7h,0d0h,0f7h,0d1h,017h,0d1h,037h,0d1h,057h,0c0h,033h,0c0h	; 942f  ..........7.W.3.
	defb 02dh,0c0h,027h,0c0h,021h,0c0h,01bh,0c0h,015h,0c0h,00fh,0c0h,077h,0c0h,097h,0c0h	; 943f  -.'.!.......w...
	defb 0b7h,0c0h,0d7h,0b0h,033h,0b0h,02dh,0b0h,027h,0b0h,021h,0a0h,01bh,0a0h,015h,0a0h	; 944f  ....3.-.'.!.....
	defb 00fh,0a0h,009h,0ffh	; 945f

; ----------------------------------------------------------------------
; DATOS musica_9463: partitura de un canal de musica (p14:8AD0); lo leen
;   p00:5224 (13 bytes)
;   0x9463..0x9470  (13 bytes)
DATA_musica_9463:
	defb 0d1h,0fdh,088h,0e1h,004h,074h,044h,074h,0fdh,023h,0e0h,009h,0ffh	; 9463  .....tDt.#...

; ----------------------------------------------------------------------
; DATOS efecto_9470: guion de un efecto de sonido (p14:8CB9); lo leen efecto
;   25 (27 bytes)
;   0x9470..0x948b  (27 bytes)
DATA_efecto_9470:
	defb 022h,004h,0f0h,048h,0e0h,056h,0f0h,048h,0f0h,056h,0e0h,048h,0e0h,056h,0d0h,048h	; 9470  "..H.V.H.V.H.V.H
	defb 0d0h,056h,0c0h,056h,0b0h,056h,0a0h,056h,080h,056h,0ffh	; 9480  .V.V.V.V.V.

; ----------------------------------------------------------------------
; DATOS musica_948B: partitura de un canal de musica (p14:8AD0); se solapan 3
;   bloques (0x948B-0x9501, 0x949B-0x9501, 0x94A9-0x9501); lo leen musica 0,
;   p00:52C0 (118 bytes)
;   0x948b..0x9501  (118 bytes)
DATA_musica_948B:
	defb 022h,001h,0f0h,07fh,0a0h,07fh,0e0h,07fh,022h,02dh,000h,000h,0feh,0feh,08bh,094h	; 948b  "......."-......
	defb 0e7h,0d7h,0fch,051h,0e1h,0edh,023h,0a8h,0e1h,006h,0edh,023h,0a8h,006h,0fch,080h	; 949b  ...Q..#....#....
	defb 0e1h,0c1h,022h,092h,080h,090h,080h,054h,0c1h,050h,020h,0fah,040h,050h,020h,0fch	; 94ab  .."....T.P .@P .
	defb 080h,050h,020h,0fah,040h,050h,0fdh,080h,050h,020h,0fah,040h,050h,020h,0fch,080h	; 94bb  .P .@P..P .@P ..
	defb 050h,020h,0fah,040h,050h,0feh,002h,0a9h,094h,0fch,040h,0e1h,0edh,033h,0a8h,012h	; 94cb  P .@P.....@..3..
	defb 042h,0a1h,092h,020h,0c3h,0edh,033h,0a8h,042h,072h,0a1h,092h,0b2h,0e0h,011h,0fch	; 94db  B.. ..3.Br......
	defb 030h,0edh,03ah,0a8h,000h,0c0h,000h,0c0h,040h,072h,0edh,03ah,0a8h,000h,0c2h,0e3h	; 94eb  0.:.....@r.:....
	defb 090h,0e2h,002h,0eah,09bh,094h	; 94fb

; ----------------------------------------------------------------------
; DATOS musica_9501: partitura de un canal de musica (p14:8AD0); se solapan 2
;   bloques (0x9501-0x9598, 0x9516-0x9598); lo leen musica 0 (151 bytes)
;   0x9501..0x9598  (151 bytes)
DATA_musica_9501:
	defb 0e9h,0d7h,0edh,039h,0a9h,0e3h,0a3h,000h,000h,0e2h,000h,0e3h,000h,000h,000h,000h	; 9501  ...9............
	defb 000h,0feh,002h,001h,095h,0edh,039h,0a9h,0e3h,0a0h,0e4h,0a1h,0a0h,0c0h,0a0h,0e3h	; 9511  ......9.........
	defb 0a1h,0a1h,0a1h,0feh,002h,016h,095h,0fdh,051h,0e3h,011h,010h,0fbh,071h,0e2h,0a2h	; 9521  ........Q....q..
	defb 0e1h,011h,0fdh,051h,0e3h,021h,020h,0fbh,071h,0e2h,092h,051h,0fdh,051h,0e3h,041h	; 9531  ...Q.! .q..Q.Q.A
	defb 040h,0fbh,071h,0e2h,0a2h,0e1h,011h,0fdh,051h,0e3h,021h,020h,0fbh,071h,0e2h,090h	; 9541  @.q.....Q.! .q..
	defb 0fdh,051h,0e3h,0c3h,011h,010h,0fbh,071h,0e2h,0a2h,0e1h,011h,0fdh,051h,0e3h,021h	; 9551  .Q.....q.....Q.!
	defb 020h,0fbh,071h,0e2h,092h,051h,0fdh,051h,0e3h,041h,040h,0fbh,071h,0e2h,0a2h,0e1h	; 9561   .q..Q.Q.A@.q...
	defb 011h,0fdh,051h,0e3h,091h,090h,0fbh,071h,0e1h,042h,071h,0edh,04ah,0a8h,0fdh,052h	; 9571  ..Q....q.Bq.J..R
	defb 0e3h,001h,001h,0fch,02bh,0e2h,000h,042h,0edh,04ah,0a8h,0fdh,052h,0e3h,000h,0c2h	; 9581  ....+..B.J..R...
	defb 0e4h,090h,0e3h,002h,0eah,001h,095h	; 9591

; ----------------------------------------------------------------------
; DATOS musica_9598: partitura de un canal de musica (p14:8AD0); se solapan 2
;   bloques (0x9598-0x9669, 0x95C2-0x9669); lo leen musica 0 (209 bytes)
;   0x9598..0x9669  (209 bytes)
DATA_musica_9598:
	defb 0e9h,0d7h,0fbh,051h,0e2h,090h,090h,0c0h,070h,0e8h,010h,0e9h,0e2h,075h,0c0h,0e8h	; 9598  ...Q....p....u..
	defb 010h,0e9h,0e2h,020h,000h,000h,022h,0e3h,0a0h,0e8h,010h,000h,0e9h,0e2h,021h,000h	; 95a8  ... ..".......!.
	defb 072h,0e8h,010h,030h,030h,030h,0feh,002h,098h,095h,001h,0e9h,0fbh,051h,0e2h,091h	; 95b8  r..000.......Q..
	defb 0e8h,010h,0e9h,0fbh,041h,0e1h,022h,010h,020h,010h,000h,0e8h,010h,0e9h,0fbh,026h	; 95c8  ....A.". ......&
	defb 0e2h,020h,020h,020h,0e8h,001h,000h,000h,010h,0edh,05fh,0a8h,030h,000h,030h,030h	; 95d8  .   ......_.0.00
	defb 030h,0feh,002h,0c2h,095h,0e9h,0fch,030h,0e2h,0a2h,0e1h,010h,0edh,033h,0a9h,0e9h	; 95e8  0......0.....3..
	defb 0fch,040h,022h,0e2h,090h,0edh,033h,0a9h,0e9h,0a2h,0e1h,010h,0edh,033h,0a9h,0e9h	; 95f8  .@"...3......3..
	defb 022h,0e2h,090h,0e8h,000h,000h,021h,0e9h,0a2h,0e1h,010h,0edh,033h,0a9h,0e9h,022h	; 9608  ".....!.....3.."
	defb 0e2h,090h,0edh,033h,0a9h,0e9h,0a2h,0e1h,010h,0edh,033h,0a9h,0e9h,012h,040h,0e8h	; 9618  ...3......3...@.
	defb 010h,030h,030h,030h,0e9h,090h,090h,0e2h,090h,094h,0e8h,021h,0edh,05fh,0a8h,0e9h	; 9628  .000.......!._..
	defb 0fch,02ah,0e3h,051h,051h,0edh,04dh,0a9h,0e9h,071h,071h,0edh,04dh,0a9h,0e9h,0fch	; 9638  .*.QQ.M..qq.M...
	defb 040h,0e1h,090h,090h,0e2h,090h,094h,0e8h,021h,0edh,05fh,0a8h,0e9h,0fch,02ah,0e3h	; 9648  @.......!._...*.
	defb 051h,051h,0edh,04dh,0a9h,0e9h,070h,0e8h,000h,000h,000h,0e9h,040h,072h,0eah,098h	; 9658  QQ.M..p.....@r..
	defb 095h	; 9668

; ----------------------------------------------------------------------
; DATOS musica_9669: partitura de un canal de musica (p14:8AD0); se solapan 5
;   bloques (0x9669-0x96C7, 0x9683-0x96C7, 0x969D-0x96C7, 0x96AA-0x96C7,
;   0x96B8-0x96C7); lo leen musica 1 (94 bytes)
;   0x9669..0x96c7  (94 bytes)
DATA_musica_9669:
	defb 0e9h,0e7h,0d8h,0fdh,071h,0e3h,021h,091h,0e2h,021h,0e3h,090h,0e2h,001h,0e3h,070h	; 9669  ....q.!..!.....p
	defb 0b2h,0e4h,090h,0e3h,000h,020h,0feh,002h,069h,096h,0fdh,071h,0e4h,021h,021h,050h	; 9679  ..... ..i..q.!!P
	defb 090h,0c3h,021h,070h,0b2h,021h,021h,050h,092h,0fdh,043h,0e4h,0c3h,090h,0e3h,002h	; 9689  ..!p.!!P..C.....
	defb 0feh,002h,083h,096h,0fah,000h,0e1h,022h,09ch,080h,090h,080h,05ch,0feh,002h,09dh	; 9699  ......."....\...
	defb 096h,0fch,041h,0edh,06bh,0a9h,052h,02ch,0feh,002h,0aah,096h,0d8h,0fch,041h,0e1h	; 96a9  ..A.k.R,......A.
	defb 0c1h,020h,020h,0c0h,022h,011h,0c5h,0feh,002h,0b8h,096h,0eah,083h,096h	; 96b9  .  .".........

; ----------------------------------------------------------------------
; DATOS musica_96C7: partitura de un canal de musica (p14:8AD0); se solapan 8
;   bloques (0x96C7-0x976D, 0x96E7-0x976D, 0x96F8-0x976D, 0x973B-0x976D,
;   0x9743-0x976D, 0x974A-0x976D); lo leen musica 1 (166 bytes)
;   0x96c7..0x976d  (166 bytes)
DATA_musica_96C7:
	defb 0e9h,0d8h,0f8h,000h,0e1h,020h,0f9h,000h,020h,0fah,000h,021h,0fbh,000h,026h,0fah	; 96c7  ..... .. ..!..&.
	defb 000h,020h,0f9h,000h,020h,0fbh,031h,0e3h,090h,0e2h,000h,020h,0feh,002h,0c7h,096h	; 96d7  . .. .1.... ....
	defb 0fdh,071h,0edh,053h,0a9h,0c7h,0edh,053h,0a9h,0c3h,0fbh,043h,090h,0e2h,002h,0fdh	; 96e7  .q.S...S...C....
	defb 051h,0e3h,021h,021h,050h,090h,0d6h,0fah,000h,0e2h,020h,050h,090h,0d5h,0f8h,000h	; 96f7  Q.!!P..... P....
	defb 020h,050h,0d4h,0f7h,000h,090h,0d8h,0fdh,041h,0e3h,021h,050h,092h,0e4h,0a1h,0a1h	; 9707   P......A.!P....
	defb 0e3h,020h,050h,0d6h,0fah,000h,0e3h,0a0h,0e2h,020h,050h,0d5h,0f8h,000h,0e3h,0a0h	; 9717  . P...... P.....
	defb 0e2h,020h,0d4h,0f7h,000h,050h,0d8h,0fdh,041h,0e4h,0a1h,0e3h,020h,052h,0feh,002h	; 9727  . ...P..A... R..
	defb 0f8h,096h,0fch,030h,0e4h,090h,0e3h,090h,0feh,008h,03bh,097h,0edh,061h,0a9h,0feh	; 9737  ...0......;..a..
	defb 002h,043h,097h,0e4h,090h,0e3h,090h,0feh,008h,04ah,097h,0edh,061h,0a9h,0feh,002h	; 9747  .C.......J..a...
	defb 052h,097h,0fdh,041h,0e4h,080h,080h,0e3h,080h,0e4h,080h,0c0h,082h,091h,0c5h,0feh	; 9757  R..A............
	defb 002h,05bh,097h,0eah,0e7h,096h	; 9767

; ----------------------------------------------------------------------
; DATOS musica_976D: partitura de un canal de musica (p14:8AD0); se solapan 5
;   bloques (0x976D-0x97DA, 0x977B-0x97DA, 0x9792-0x97DA, 0x97A7-0x97DA,
;   0x97C2-0x97DA); lo leen musica 1 (109 bytes)
;   0x976d..0x97da  (109 bytes)
DATA_musica_976D:
	defb 0e9h,0d8h,0fah,010h,0e3h,02ch,0e8h,000h,000h,000h,0feh,002h,06dh,097h,0e9h,0fch	; 976d  .....,......m...
	defb 085h,0e2h,0edh,0c2h,0a8h,000h,0e9h,021h,070h,0b2h,0edh,0c2h,0a8h,0edh,05fh,0a8h	; 977d  .......!p....._.
	defb 000h,0feh,002h,07bh,097h,0e9h,0f9h,000h,0e2h,092h,0e1h,026h,011h,001h,0e2h,0b1h	; 978d  ...{.......&....
	defb 0e1h,020h,040h,020h,0e2h,0ach,0feh,002h,092h,097h,0e9h,0d8h,0fch,041h,0edh,06bh	; 979d  . @ .........A.k
	defb 0a9h,0e8h,000h,000h,000h,010h,000h,0edh,033h,0a9h,000h,000h,010h,000h,010h,000h	; 97ad  ........3.......
	defb 000h,0feh,002h,0a7h,097h,0e8h,000h,000h,0e9h,0e2h,0b0h,0b0h,0e8h,010h,0e9h,0b2h	; 97bd  ................
	defb 0edh,033h,0a9h,000h,000h,021h,0feh,002h,0c2h,097h,0eah,07bh,097h	; 97cd  .3...!.....{.

; ----------------------------------------------------------------------
; DATOS musica_97DA: partitura de un canal de musica (p14:8AD0); se solapan 4
;   bloques (0x97DA-0x9891, 0x97EF-0x9891, 0x9808-0x9891, 0x982A-0x9891); lo
;   leen musica 2 (183 bytes)
;   0x97da..0x9891  (183 bytes)
DATA_musica_97DA:
	defb 0e7h,0e9h,0d5h,0fch,041h,0e1h,0c3h,041h,0c3h,031h,0c3h,021h,0c3h,015h,0e2h,001h	; 97da  ....A..A.1.!....
	defb 021h,0feh,004h,0dah,097h,0e9h,0d5h,0fch,025h,0edh,066h,0a8h,0fbh,000h,003h,0fch	; 97ea  !.......%.f.....
	defb 000h,005h,0fch,025h,0edh,066h,0a8h,0fbh,000h,001h,0fch,050h,053h,043h,0e9h,0d5h	; 97fa  ...%.f.....PSC..
	defb 0fbh,022h,0e1h,041h,0edh,0d4h,0a8h,0e9h,0e1h,042h,0c0h,0edh,0d4h,0a8h,041h,0e9h	; 980a  .".A.....B....A.
	defb 021h,0edh,0cbh,0a8h,0e9h,0e2h,022h,0c0h,0edh,0cbh,0a8h,041h,0feh,002h,008h,098h	; 981a  !....."....A....
	defb 0e9h,0fch,026h,0e2h,055h,075h,0f9h,000h,091h,0fah,000h,091h,0fbh,000h,093h,0ech	; 982a  ..&.Uu..........
	defb 053h,073h,093h,0e9h,0fch,026h,0e2h,045h,055h,0f9h,000h,071h,0fah,000h,071h,0fbh	; 983a  Ss...&.EU..q..q.
	defb 000h,073h,0ech,043h,053h,073h,0e9h,0fch,026h,0e2h,025h,045h,0f9h,000h,051h,0fah	; 984a  .s.CSs..&.%E..Q.
	defb 000h,051h,0fbh,000h,053h,0ech,023h,043h,053h,0e9h,0fch,026h,015h,025h,0f9h,000h	; 985a  .Q..S.#CS..&.%..
	defb 043h,0fah,000h,043h,0fbh,000h,043h,0fch,000h,043h,0fch,025h,0e4h,0b1h,0e3h,011h	; 986a  C..C..C..C.%....
	defb 0feh,002h,02ah,098h,0e2h,045h,055h,0f9h,000h,073h,0fah,000h,073h,0fbh,000h,073h	; 987a  ..*..EU..s..s..s
	defb 0fch,000h,075h,0c1h,0eah,0efh,097h	; 988a

; ----------------------------------------------------------------------
; DATOS musica_9891: partitura de un canal de musica (p14:8AD0); se solapan 5
;   bloques (0x9891-0x993D, 0x98B5-0x993D, 0x98D3-0x993D, 0x98E4-0x993D,
;   0x98F9-0x993D); lo leen musica 2 (172 bytes)
;   0x9891..0x993d  (172 bytes)
DATA_musica_9891:
	defb 0e9h,0d5h,0fch,026h,0e4h,090h,090h,091h,0e1h,001h,0e4h,091h,091h,0e2h,0b1h,0e3h	; 9891  ...&............
	defb 091h,0e4h,091h,0e2h,0a1h,0e4h,091h,0c1h,0e2h,091h,0e4h,091h,091h,0e3h,001h,021h	; 98a1  ...............!
	defb 0feh,002h,091h,098h,0edh,078h,0a9h,0e1h,001h,0edh,078h,0a9h,0e2h,0b1h,0edh,078h	; 98b1  .....x....x....x
	defb 0a9h,0e2h,0a1h,0edh,078h,0a9h,0e2h,091h,0edh,078h,0a9h,0e3h,001h,021h,0feh,002h	; 98c1  ....x....x...!..
	defb 0b5h,098h,0e9h,0edh,087h,0a8h,0e3h,001h,001h,011h,011h,0edh,087h,0a8h,0fbh,026h	; 98d1  ...............&
	defb 0e3h,023h,003h,0e9h,0d5h,0fch,025h,0e3h,0edh,0ach,0a8h,0edh,0ach,0a8h,0edh,0b7h	; 98e1  .#....%.........
	defb 0a8h,0edh,0b7h,0a8h,0feh,002h,0e4h,098h,0e9h,0fch,025h,0e3h,020h,020h,0edh,07dh	; 98f1  ..........%.  .}
	defb 0a9h,0edh,07dh,0a9h,021h,000h,000h,0edh,085h,0a9h,0edh,085h,0a9h,001h,0e4h,0edh	; 9901  ..}.!...........
	defb 08dh,0a9h,0edh,08dh,0a9h,0edh,096h,0a9h,0edh,096h,0a9h,0e8h,040h,0e9h,090h,091h	; 9911  ............@...
	defb 091h,091h,0c3h,0feh,002h,0f9h,098h,0e9h,0e4h,0edh,096h,0a9h,0edh,096h,0a9h,0e8h	; 9921  ................
	defb 040h,0e9h,090h,091h,091h,091h,0b1h,0e3h,011h,0eah,0d3h,098h	; 9931  @...........

; ----------------------------------------------------------------------
; DATOS musica_993D: partitura de un canal de musica (p14:8AD0); se solapan 6
;   bloques (0x993D-0x9A58, 0x993F-0x9A58, 0x9948-0x9A58, 0x9952-0x9A58,
;   0x9991-0x9A58, 0x99C6-0x9A58); lo leen musica 2 (283 bytes)
;   0x993d..0x9a58  (283 bytes)
DATA_musica_993D:
	defb 0d5h,0e8h,001h,001h,010h,000h,001h,0feh,008h,03fh,099h,000h,000h,001h,010h,000h	; 993d  .........?......
	defb 001h,0feh,008h,048h,099h,0e9h,0d5h,0fah,024h,0e2h,021h,021h,0e8h,031h,0e9h,021h	; 994d  ...H....$.!!.1.!
	defb 021h,0e3h,091h,0e8h,031h,0e9h,051h,0c1h,0e2h,021h,0e8h,031h,0e9h,021h,0e3h,091h	; 995d  !...1.Q..!.1.!..
	defb 0e2h,021h,0e8h,031h,0e9h,051h,0e3h,0a1h,0e2h,021h,0e8h,031h,0e9h,0c3h,0e3h,0a1h	; 996d  .!.1.Q...!.1....
	defb 0e8h,031h,0e9h,0f8h,000h,0e2h,055h,0e8h,031h,001h,001h,001h,030h,030h,030h,030h	; 997d  .1....U.1...0000
	defb 0feh,002h,052h,099h,0e9h,0d5h,0f9h,011h,0e1h,041h,001h,0e2h,071h,0e1h,001h,0e2h	; 998d  ..R......A..q...
	defb 071h,043h,0e1h,043h,001h,0e2h,071h,0e1h,001h,0e2h,071h,041h,0e8h,010h,010h,011h	; 999d  qC.C..q...qA....
	defb 0e9h,021h,051h,091h,051h,091h,0e1h,023h,0e2h,023h,0e2h,051h,091h,051h,091h,0e1h	; 99ad  .!Q.Q..#.#.Q.Q..
	defb 021h,0e8h,010h,010h,011h,0feh,002h,091h,099h,0e9h,0d5h,0fbh,026h,0e2h,023h,0e8h	; 99bd  !...........&.#.
	defb 031h,0e9h,045h,0e8h,031h,0e9h,0f8h,000h,051h,0f9h,000h,053h,0e8h,031h,0ech,053h	; 99cd  1.E.1...Q..S.1.S
	defb 071h,0e8h,031h,0ech,091h,0e9h,0fbh,026h,0e2h,003h,0e8h,031h,0e9h,025h,0e8h,031h	; 99dd  q.1....&...1.%.1
	defb 0e9h,0f8h,000h,041h,0f9h,000h,043h,0e8h,031h,0ech,043h,051h,0e8h,031h,0ech,071h	; 99ed  ...A..C.1.CQ.1.q
	defb 0e9h,0fbh,026h,0e3h,0a3h,0e8h,031h,0e9h,0e2h,005h,0e8h,031h,0e9h,0f8h,000h,021h	; 99fd  ..&...1....1...!
	defb 0f9h,000h,023h,0e8h,031h,0ech,023h,041h,0e8h,031h,0ech,051h,0e9h,0fbh,026h,0e3h	; 9a0d  ..#.1.#A.1.Q..&.
	defb 093h,0e8h,031h,0e9h,0fbh,027h,0b5h,0e8h,031h,0e9h,0f8h,000h,0e2h,011h,0f9h,000h	; 9a1d  ..1..'..1.......
	defb 013h,0e8h,033h,031h,031h,0e8h,030h,030h,031h,0feh,002h,0c6h,099h,0e9h,0fbh,026h	; 9a2d  ..311.001......&
	defb 0e2h,013h,0e8h,031h,0e9h,025h,0e8h,031h,0e9h,0f8h,000h,041h,0f9h,000h,043h,0e8h	; 9a3d  ...1.%.1...A..C.
	defb 033h,031h,031h,0e8h,030h,030h,030h,030h,0eah,052h,099h	; 9a4d  311.0000.R.

; ----------------------------------------------------------------------
; DATOS musica_9A58: partitura de un canal de musica (p14:8AD0); se solapan 4
;   bloques (0x9A58-0x9AB8, 0x9A5D-0x9AB8, 0x9A6E-0x9AB8, 0x9A89-0x9AB8); lo
;   leen musica 3 (96 bytes)
;   0x9a58..0x9ab8  (96 bytes)
DATA_musica_9A58:
	defb 0e9h,0e7h,0d6h,0fch,090h,0fdh,090h,0e1h,021h,021h,071h,021h,071h,021h,0fdh,051h	; 9a58  ........!!q!q!.Q
	defb 050h,072h,0feh,004h,05dh,09ah,0fch,042h,0e2h,075h,0a7h,090h,0a0h,0e1h,005h,0e2h	; 9a68  Pr..]..B.u......
	defb 0a5h,093h,0a5h,079h,0fbh,021h,022h,092h,0e1h,029h,0feh,002h,06eh,09ah,0fch,031h	; 9a78  ...y.!"..)..n..1
	defb 0e1h,072h,022h,0f8h,022h,072h,022h,0fch,031h,071h,021h,0feh,004h,089h,09ah,0fch	; 9a88  .r"."r".1q!.....
	defb 032h,0e2h,072h,092h,0a1h,092h,0a2h,0e1h,001h,0e2h,0a2h,0e1h,002h,021h,002h,022h	; 9a98  2.r..........!."
	defb 031h,02fh,0f8h,000h,0c1h,021h,011h,001h,0e2h,0b1h,0a1h,091h,081h,0eah,058h,09ah	; 9aa8  1/...!........X.

; ----------------------------------------------------------------------
; DATOS musica_9AB8: partitura de un canal de musica (p14:8AD0); se solapan 10
;   bloques (0x9AB8-0x9B6A, 0x9AD4-0x9B6A, 0x9AFB-0x9B6A, 0x9B02-0x9B6A,
;   0x9B09-0x9B6A, 0x9B10-0x9B6A); lo leen musica 3 (178 bytes)
;   0x9ab8..0x9b6a  (178 bytes)
DATA_musica_9AB8:
	defb 0e9h,0d6h,0fdh,02ah,0e4h,071h,071h,071h,071h,051h,051h,051h,051h,031h,031h,031h	; 9ab8  ...*.qqqqQQQQ111
	defb 031h,051h,051h,051h,051h,0feh,002h,0b8h,09ah,0d6h,0fch,042h,0edh,09ch,0a9h,0edh	; 9ac8  1QQQQ......B....
	defb 09ch,0a9h,030h,030h,0c0h,030h,030h,0c0h,0e2h,023h,0e4h,090h,0a0h,0e2h,011h,0e3h	; 9ad8  ..00.00..#......
	defb 071h,020h,020h,0c0h,020h,020h,0c0h,0c3h,000h,020h,051h,091h,0feh,002h,0d4h,09ah	; 9ae8  q  .  ... Q.....
	defb 0fch,028h,0e3h,071h,070h,070h,0feh,002h,0fbh,09ah,051h,050h,050h,0feh,002h,002h	; 9af8  .(.qpp....QPP...
	defb 09bh,041h,040h,040h,0feh,002h,009h,09bh,031h,030h,030h,0feh,002h,010h,09bh,0e4h	; 9b08  .A@@....100.....
	defb 071h,0e3h,070h,070h,0feh,002h,017h,09bh,0e4h,051h,0e3h,050h,050h,0feh,002h,020h	; 9b18  q.pp.....Q.PP..
	defb 09bh,0e4h,041h,0e3h,040h,040h,0feh,002h,029h,09bh,0e4h,031h,0e3h,030h,030h,0e4h	; 9b28  ..A.@@..)..1.00.
	defb 021h,0e3h,020h,020h,0edh,0abh,0a9h,052h,071h,0edh,0abh,0a9h,072h,091h,0edh,0abh	; 9b38  !.  ...Rq...r...
	defb 0a9h,092h,0a1h,0edh,0abh,0a9h,0a2h,0e1h,001h,0fch,026h,0e3h,021h,020h,020h,0feh	; 9b48  ..........&.!  .
	defb 004h,054h,09bh,021h,0fah,010h,0e2h,021h,011h,001h,0e3h,0b1h,0a1h,091h,081h,0eah	; 9b58  .T.!...!........
	defb 0b8h,09ah	; 9b68

; ----------------------------------------------------------------------
; DATOS musica_9B6A: partitura de un canal de musica (p14:8AD0); se solapan 3
;   bloques (0x9B6A-0x9C15, 0x9B76-0x9C15, 0x9BBF-0x9C15); lo leen musica 3
;   (171 bytes)
;   0x9b6a..0x9c15  (171 bytes)
DATA_musica_9B6A:
	defb 0e9h,0d6h,0fbh,071h,0e2h,071h,0e8h,001h,0feh,010h,06ah,09bh,0e9h,0d6h,0fch,042h	; 9b6a  ...q.q....j....B
	defb 0e2h,023h,0e8h,010h,000h,0e9h,0e2h,0c5h,0e8h,010h,000h,0e9h,0e2h,050h,070h,093h	; 9b7a  .#...........Pp.
	defb 0e8h,010h,000h,0e9h,0e2h,0c5h,0e8h,010h,000h,0e9h,0fah,011h,0e2h,050h,040h,033h	; 9b8a  .............P@3
	defb 0e8h,010h,000h,0e9h,0fch,042h,0e2h,0c5h,0e8h,010h,000h,0e9h,0fch,042h,0e2h,0c1h	; 9b9a  .....B.......B..
	defb 0fah,021h,0c0h,022h,090h,0e8h,010h,000h,0e9h,0fch,042h,0e1h,024h,0e8h,000h,000h	; 9baa  .!."......B.$...
	defb 011h,0feh,002h,076h,09bh,0e9h,0d6h,0fbh,031h,0e1h,0c0h,072h,0e8h,010h,000h,0e9h	; 9bba  ...v....1..r....
	defb 0e1h,020h,0f8h,022h,072h,021h,0e8h,010h,000h,0e9h,021h,0feh,004h,0bfh,09bh,0fbh	; 9bca  . ."r!....!.....
	defb 032h,0e2h,032h,0e3h,030h,0e8h,000h,000h,011h,0e9h,0e2h,052h,0e3h,030h,0e8h,000h	; 9bda  2.2.0......R.0..
	defb 000h,011h,0e9h,0e2h,072h,0e3h,030h,0e8h,000h,000h,011h,0e9h,0e2h,092h,0e3h,030h	; 9bea  ....r.0........0
	defb 0e8h,000h,000h,011h,0e9h,0e2h,09fh,0e8h,001h,000h,000h,001h,000h,000h,001h,000h	; 9bfa  ................
	defb 000h,0e9h,0fch,032h,0e3h,020h,0e4h,022h,0eah,06ah,09bh	; 9c0a  ...2. .".j.

; ----------------------------------------------------------------------
; DATOS musica_9C15: partitura de un canal de musica (p14:8AD0); se solapan 4
;   bloques (0x9C15-0x9CDB, 0x9C43-0x9CDB, 0x9C88-0x9CDB, 0x9CAA-0x9CDB); lo
;   leen musica 4 (198 bytes)
;   0x9c15..0x9cdb  (198 bytes)
DATA_musica_9C15:
	defb 0e9h,0e7h,0d7h,0fch,065h,0e2h,001h,001h,0fdh,067h,001h,0fch,065h,001h,001h,0e3h	; 9c15  ....e....g..e...
	defb 070h,070h,0c0h,0fdh,067h,081h,0fch,065h,0b0h,0e2h,000h,000h,001h,0fdh,067h,001h	; 9c25  pp..g..e......g.
	defb 0fch,065h,001h,001h,0e3h,070h,070h,0c0h,0fdh,067h,081h,0fch,064h,0b0h,0e9h,0fbh	; 9c35  .e...pp..g..d...
	defb 024h,0e1h,00dh,0d1h,0f9h,000h,001h,021h,031h,051h,071h,081h,0b1h,0d7h,0fch,024h	; 9c45  $......!1Qq....$
	defb 0e0h,00fh,0edh,0d8h,0a9h,0edh,0d8h,0a9h,0fdh,045h,0e2h,072h,0b1h,0c0h,0f8h,000h	; 9c55  .........E.r....
	defb 0e1h,023h,0f9h,000h,021h,0fah,000h,021h,0fbh,022h,0c1h,0fch,045h,022h,051h,0c0h	; 9c65  .#..!..!."..E"Q.
	defb 0f8h,000h,071h,0f9h,000h,071h,0fah,000h,070h,0fbh,000h,070h,0c0h,0fch,021h,0e1h	; 9c75  ..q..q..p..p..!.
	defb 070h,090h,0b0h,0fah,010h,0edh,00dh,0aah,0fbh,010h,0edh,00dh,0aah,0fch,010h,0edh	; 9c85  p...............
	defb 00dh,0aah,0c0h,0fch,024h,020h,030h,050h,071h,050h,070h,0c0h,070h,0c0h,070h,071h	; 9c95  ....$ 0PqPp.p.pq
	defb 0b1h,0feh,002h,088h,09ch,0fdh,044h,0e1h,030h,020h,030h,020h,031h,000h,032h,001h	; 9ca5  ......D.0 0 1.2.
	defb 021h,001h,0feh,002h,0aah,09ch,032h,002h,031h,052h,022h,051h,072h,052h,071h,0a2h	; 9cb5  !.....2.1R"QrRq.
	defb 082h,0a1h,0e0h,00fh,0fch,064h,0e2h,000h,000h,001h,001h,001h,001h,0e3h,070h,070h	; 9cc5  .....d........pp
	defb 0c0h,081h,0b0h,0eah,043h,09ch	; 9cd5

; ----------------------------------------------------------------------
; DATOS musica_9CDB: partitura de un canal de musica (p14:8AD0); se solapan 3
;   bloques (0x9CDB-0x9DF8, 0x9D08-0x9DF8, 0x9D46-0x9DF8); lo leen musica 4
;   (285 bytes)
;   0x9cdb..0x9df8  (285 bytes)
DATA_musica_9CDB:
	defb 0e9h,0d7h,0fch,064h,0e3h,001h,001h,0fdh,067h,001h,0fch,064h,001h,001h,0e4h,070h	; 9cdb  ...d....g..d...p
	defb 070h,0fdh,067h,070h,081h,0fch,064h,0b0h,0e3h,000h,000h,001h,0fdh,067h,001h,0fch	; 9ceb  p.gp..d......g..
	defb 064h,001h,001h,0e4h,070h,070h,0fdh,067h,070h,081h,0fch,064h,0b0h,0e9h,0d7h,0fdh	; 9cfb  d...pp.gp..d....
	defb 064h,0e3h,001h,001h,001h,001h,001h,0e4h,070h,071h,081h,0b0h,0e3h,000h,000h,001h	; 9d0b  d.......pq......
	defb 001h,001h,001h,0e4h,070h,071h,081h,0b0h,0edh,021h,0aah,0edh,021h,0aah,0e9h,0fdh	; 9d1b  ....pq...!..!...
	defb 065h,0e4h,071h,070h,070h,071h,070h,070h,071h,070h,070h,0b1h,0e3h,021h,0e4h,071h	; 9d2b  e.qppqppqpp..!.q
	defb 070h,070h,071h,070h,070h,071h,070h,070h,0b1h,0e3h,021h,0fdh,065h,0e3h,001h,0e2h	; 9d3b  ppqppqpp..!.e...
	defb 000h,000h,0e3h,001h,0e2h,001h,0e3h,001h,0e2h,000h,000h,0e3h,000h,000h,0e2h,000h	; 9d4b  ................
	defb 000h,0e4h,0a1h,0e3h,0a0h,0a0h,0e4h,0a1h,0e3h,0a1h,0e4h,0a1h,0e3h,0a0h,0a0h,0e4h	; 9d5b  ................
	defb 0a0h,0a0h,0e3h,0a0h,0a0h,0e4h,081h,0e3h,080h,080h,0e4h,081h,0e3h,081h,0e4h,081h	; 9d6b  ................
	defb 0e3h,080h,080h,0e4h,080h,080h,0e3h,080h,080h,0e4h,071h,0e3h,070h,070h,0e4h,071h	; 9d7b  ..........q.pp.q
	defb 0e3h,071h,0e4h,071h,0e3h,070h,070h,0e4h,070h,070h,0e3h,070h,070h,0feh,002h,046h	; 9d8b  .q.q.pp.pp.pp..F
	defb 09dh,0fdh,065h,0e3h,000h,000h,001h,001h,001h,001h,001h,001h,0e4h,0a1h,080h,080h	; 9d9b  ..e.............
	defb 081h,081h,081h,081h,081h,071h,071h,051h,0e3h,050h,050h,0e4h,051h,0e3h,050h,050h	; 9dab  .....qqQ.PP.Q.PP
	defb 0e4h,071h,0e3h,070h,070h,0e4h,071h,0e3h,070h,070h,0e4h,081h,0e3h,080h,080h,0e4h	; 9dbb  .q.pp.q.pp......
	defb 081h,0e3h,080h,080h,0e4h,0a1h,0e3h,0a0h,0a0h,0e4h,0a1h,0e3h,0a0h,0a0h,0fdh,065h	; 9dcb  ...............e
	defb 001h,001h,001h,001h,001h,0e4h,070h,070h,0c0h,081h,0b0h,0fch,064h,0e3h,000h,000h	; 9ddb  ......pp....d...
	defb 001h,001h,001h,001h,0e4h,070h,070h,0c0h,081h,0b0h,0eah,008h,09dh	; 9deb  .....pp......

; ----------------------------------------------------------------------
; DATOS musica_9DF8: partitura de un canal de musica (p14:8AD0); se solapan 3
;   bloques (0x9DF8-0x9EC1, 0x9E15-0x9EC1, 0x9E54-0x9EC1); lo leen musica 4
;   (201 bytes)
;   0x9df8..0x9ec1  (201 bytes)
DATA_musica_9DF8:
	defb 0e9h,0d7h,0fch,065h,0e4h,001h,001h,001h,001h,001h,0e5h,070h,070h,070h,081h,0b0h	; 9df8  ...e.......ppp..
	defb 0e4h,000h,000h,001h,001h,001h,001h,0e5h,070h,070h,070h,081h,0b0h,0e9h,0d7h,0f8h	; 9e08  ........ppp.....
	defb 000h,0e2h,07dh,0d1h,0f7h,000h,071h,091h,0b1h,0e1h,001h,021h,041h,051h,0d7h,0fah	; 9e18  ..}...q....!AQ..
	defb 024h,0e1h,07fh,0edh,059h,0aah,0edh,059h,0aah,0fbh,045h,0e2h,022h,071h,0c0h,0f7h	; 9e28  $...Y..Y..E."q..
	defb 000h,077h,0c1h,0fbh,045h,072h,0e1h,021h,0c0h,0f7h,000h,021h,0f8h,000h,021h,0f9h	; 9e38  .w..Er.!...!..!.
	defb 000h,020h,0fah,000h,020h,0fbh,014h,0e1h,0c0h,020h,020h,020h,0d1h,0f7h,000h,0e0h	; 9e48  . .. ....   ....
	defb 0c0h,0d7h,0f7h,011h,0edh,093h,0aah,0d7h,0f8h,011h,0edh,093h,0aah,0d7h,0f9h,011h	; 9e58  ................
	defb 0edh,093h,0aah,0d1h,0f7h,000h,0e0h,0c5h,0d7h,0fah,024h,0e2h,070h,0b0h,0b0h,0e1h	; 9e68  ..........$.p...
	defb 021h,020h,020h,0c0h,020h,0c0h,020h,021h,021h,0feh,002h,054h,09eh,0d7h,0fah,043h	; 9e78  !  . . !!..T...C
	defb 0e1h,000h,0e2h,0b0h,0e1h,000h,0e2h,0b0h,0e1h,001h,0e2h,070h,0e1h,002h,0e2h,071h	; 9e88  ...........p...q
	defb 0b1h,071h,0e1h,000h,0e2h,080h,0e1h,000h,0e2h,080h,0e1h,001h,0e2h,080h,0e1h,002h	; 9e98  .q..............
	defb 0e2h,081h,0b1h,0e2h,071h,082h,052h,081h,0a2h,072h,0a1h,0e1h,002h,0e2h,082h,0e1h	; 9ea8  ....q.R..r......
	defb 001h,022h,022h,021h,07fh,0cfh,0eah,015h,09eh	; 9eb8  .""!.....

; ----------------------------------------------------------------------
; DATOS musica_9EC1: partitura de un canal de musica (p14:8AD0); se solapan 5
;   bloques (0x9EC1-0x9F89, 0x9EC8-0x9F89, 0x9ED1-0x9F89, 0x9ED9-0x9F89,
;   0x9EDF-0x9F89); lo leen musica 5 (200 bytes)
;   0x9ec1..0x9f89  (200 bytes)
DATA_musica_9EC1:
	defb 0e7h,0e9h,0d6h,0fbh,034h,0e4h,0cfh,001h,011h,0feh,004h,0c8h,09eh,0fch,034h,0e2h	; 9ec1  ....4.........4.
	defb 001h,011h,0feh,004h,0d1h,09eh,0fdh,034h,001h,011h,0feh,004h,0d9h,09eh,0e9h,0fch	; 9ed1  .......4........
	defb 024h,0e2h,043h,0c1h,01fh,0c9h,003h,0c1h,013h,0c1h,045h,015h,073h,063h,0fch,034h	; 9ee1  $.C.......E.sc.4
	defb 0e2h,005h,015h,045h,015h,001h,0c1h,011h,0c1h,045h,065h,075h,065h,071h,0c1h,0b1h	; 9ef1  ...E.....Eeueq..
	defb 0c1h,0a5h,095h,0e1h,005h,01bh,0c1h,0e2h,0edh,0b4h,0a9h,043h,041h,0e1h,0edh,0b4h	; 9f01  ...........CA...
	defb 0a9h,041h,0e8h,041h,0e9h,0fch,023h,041h,0fdh,023h,0e1h,041h,0f9h,021h,040h,040h	; 9f11  .A.A..#A.#.A.!@@
	defb 0fdh,023h,01bh,0e2h,0f8h,021h,040h,040h,0f8h,000h,080h,0f9h,000h,080h,0fah,000h	; 9f21  .#...!@@........
	defb 080h,0fbh,000h,080h,0fbh,020h,080h,080h,0c1h,0fdh,023h,0e1h,011h,033h,041h,0f9h	; 9f31  ..... ....#..3A.
	defb 021h,040h,040h,0fdh,023h,01bh,0e2h,042h,0fch,021h,010h,010h,0c0h,0f7h,000h,071h	; 9f41  !@@.#..B.!.....q
	defb 0f8h,000h,070h,0f9h,000h,070h,0fah,000h,070h,0fbh,000h,070h,0fch,000h,071h,0fbh	; 9f51  ..p..p..p..p..q.
	defb 020h,070h,070h,0fdh,023h,0e1h,0c1h,011h,031h,041h,0f9h,021h,040h,040h,0fdh,023h	; 9f61   pp.#...1A.!@@.#
	defb 015h,0c1h,061h,081h,091h,0f9h,021h,090h,090h,0fdh,023h,065h,08fh,0fdh,023h,0e3h	; 9f71  ..a...!...#e..#.
	defb 081h,0e2h,0edh,0dfh,0a8h,0eah,0dfh,09eh	; 9f81  ........

; ----------------------------------------------------------------------
; DATOS musica_9F89: partitura de un canal de musica (p14:8AD0); se solapan 7
;   bloques (0x9F89-0xA000, 0x9F8E-0xA000, 0x9F96-0xA000, 0x9F9C-0xA000,
;   0x9FAD-0xA000, 0x9FC0-0xA000); lo leen musica 5 (119 bytes)
;   0x9f89..0xa000  (119 bytes)
DATA_musica_9F89:
	defb 0e9h,0d6h,0fdh,034h,0e3h,001h,011h,0feh,008h,08eh,09fh,0fdh,034h,001h,011h,0feh	; 9f89  ...4........4...
	defb 008h,096h,09fh,0e9h,0fdh,020h,001h,0c1h,011h,0c1h,0feh,003h,09ch,09fh,001h,0c1h	; 9f99  ..... ..........
	defb 011h,0e8h,040h,040h,0e9h,001h,0c1h,011h,0c1h,001h,0c1h,011h,0e8h,040h,040h,0feh	; 9fa9  ..@@.........@@.
	defb 002h,0adh,09fh,0e9h,0fdh,024h,0e3h,001h,011h,0feh,018h,0c0h,09fh,043h,0e8h,042h	; 9fb9  .....$.......C.B
	defb 042h,0e9h,041h,0e8h,041h,0e9h,040h,0e8h,040h,0e9h,073h,0e8h,042h,042h,0e9h,071h	; 9fc9  B.A.A.@.@.s.BB.q
	defb 0e8h,041h,0e9h,070h,0e8h,040h,0e9h,0e3h,043h,0e8h,042h,042h,0e9h,041h,0e8h,041h	; 9fd9  .A.p.@..C.BB.A.A
	defb 0e9h,040h,0e8h,040h,0e9h,073h,0e8h,042h,040h,041h,0e9h,071h,0c1h,071h,0fdh,035h	; 9fe9  .@.@.s.B@A.q.q.5
	defb 0e3h,011h,0e2h,010h,010h,0e8h,041h	; 9ff9
