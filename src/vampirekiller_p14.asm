; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 14 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS sin identificar  0x8000..0x8964  (2404 bytes)
DATA_8000:
	defb 019h,080h,0e7h,080h,0b3h,081h,0b1h,082h,098h,083h,097h,084h,094h,021h,09ch,021h	; 8000  .............!.!
	defb 0feh,094h,022h,09ch,022h,0feh,094h,03ah,000h,097h,029h,09bh,021h,0feh,093h,021h	; 8010  .."."..:..).!..!
	defb 097h,026h,049h,021h,08bh,029h,0feh,046h,021h,0b4h,017h,0a8h,078h,0bbh,082h,04bh	; 8020  .&I!.).F!...x..K
	defb 021h,09dh,021h,0feh,0a2h,021h,064h,03ah,0a8h,021h,05bh,022h,073h,08dh,0feh,023h	; 8030  !.!..!d:.!["s..#
	defb 020h,063h,021h,096h,021h,04bh,022h,09ah,020h,032h,08ch,072h,083h,0b2h,017h,0feh	; 8040   c!.!K". 2.r....
	defb 094h,020h,089h,03ah,0feh,087h,030h,05dh,021h,0feh,0a6h,022h,0aah,020h,078h,017h	; 8050  . .:..0]!..". x.
	defb 0ach,07fh,0e1h,0ffh,02ah,0d5h,092h,021h,048h,021h,06ah,062h,06ch,062h,0a8h,077h	; 8060  ....*..!H!jblb.w
	defb 0aah,062h,0ach,07fh,0ceh,0feh,062h,077h,064h,077h,066h,060h,0a2h,07fh,08ah,0a4h	; 8070  .b....bwdwf`....
	defb 07fh,08ch,0a6h,077h,037h,027h,031h,091h,0feh,034h,028h,075h,021h,07ah,025h,03eh	; 8080  ...w7'1..4(u!z%>
	defb 022h,056h,08fh,04ah,07fh,0dbh,0feh,074h,022h,036h,022h,03ch,022h,08eh,029h,0b8h	; 8090  "V.J...t"6"<".).
	defb 017h,0feh,052h,07ch,054h,029h,04eh,021h,0feh,045h,022h,04ch,030h,07ch,078h,0ffh	; 80a0  ..R|T)N!.E"L0|x.
	defb 068h,021h,093h,021h,098h,029h,0b2h,017h,074h,084h,0feh,097h,034h,05dh,028h,09ch	; 80b0  h!.!.)..t...4](.
	defb 017h,0feh,0a1h,03ah,06ah,07fh,0dch,0aah,078h,077h,08ah,0b7h,017h,0bch,089h,0feh	; 80c0  ...:j...xw......
	defb 053h,03ah,093h,021h,096h,029h,099h,021h,09ch,030h,05ch,017h,0feh,053h,085h,0b3h	; 80d0  S:.!.).!.0\..S..
	defb 083h,0feh,087h,022h,08ah,021h,000h,098h,021h,09eh,028h,048h,035h,05dh,017h,042h	; 80e0  ...".!..!.(H5].B
	defb 078h,0feh,034h,026h,084h,029h,089h,022h,07ch,017h,03ch,035h,0b9h,08fh,0ach,0c4h	; 80f0  x.4&.)."|.<5....
	defb 0feh,035h,035h,083h,021h,04ch,027h,0adh,028h,07dh,017h,044h,0d6h,0feh,034h,022h	; 8100  .55.!L'.(}.D..4"
	defb 03ah,022h,0b1h,091h,097h,017h,0feh,031h,035h,037h,027h,03bh,021h,0bbh,017h,072h	; 8110  :".....157';!..r
	defb 08ah,07ah,09ch,0feh,036h,021h,07dh,022h,091h,083h,0ffh,024h,035h,028h,021h,02ch	; 8120  .z..6!}"...$5(!,
	defb 021h,0feh,047h,022h,04bh,021h,076h,017h,09ah,017h,0feh,022h,026h,03bh,022h,07ah	; 8130  !.G"K!v...."&;"z
	defb 089h,0feh,082h,022h,04ch,078h,08ch,07fh,0d3h,05bh,093h,09bh,09eh,0feh,044h,021h	; 8140  ..."Lx...[....D!
	defb 04dh,035h,048h,021h,083h,021h,088h,021h,095h,017h,09ch,017h,0feh,035h,035h,03dh	; 8150  M5H!.!.!.....55=
	defb 035h,094h,021h,099h,035h,09ch,021h,0ffh,067h,017h,054h,029h,02ch,07fh,0d5h,0a4h	; 8160  5.!.5.!.g.T),...
	defb 062h,0a6h,075h,0a8h,075h,0aah,075h,0ach,078h,0feh,022h,03ah,026h,035h,02ah,021h	; 8170  b.u.u.u.x.":&5*!
	defb 082h,035h,086h,035h,08ah,022h,09ch,017h,0feh,038h,022h,073h,021h,07bh,021h,032h	; 8180  .5.5."...8"s!{!2
	defb 07fh,0e3h,044h,017h,088h,07fh,089h,0a2h,09ah,0feh,062h,026h,066h,03ah,09dh,017h	; 8190  ..D.......b&f:..
	defb 0feh,062h,021h,066h,035h,06ah,022h,06eh,035h,0feh,062h,027h,06eh,021h,076h,021h	; 81a0  .b!f5j"n5.b'n!v!
	defb 07ah,021h,000h,09ah,021h,032h,0c0h,0feh,033h,021h,056h,022h,05ah,035h,092h,021h	; 81b0  z!..!2..3!V"Z5.!
	defb 09eh,022h,084h,090h,04eh,017h,0feh,03eh,022h,056h,022h,064h,022h,099h,030h,0a2h	; 81c0  ."..N..>"V"d".0.
	defb 017h,0feh,051h,029h,04ch,035h,08ch,078h,06dh,083h,0feh,024h,022h,02ch,034h,081h	; 81d0  ..Q)L5.xm..$",4.
	defb 021h,094h,021h,044h,084h,04ah,017h,07ah,09ch,0feh,039h,020h,055h,022h,098h,020h	; 81e0  !.!D.J.z..9 U".
	defb 082h,08fh,06bh,017h,0feh,044h,022h,094h,035h,098h,022h,09bh,017h,0feh,091h,021h	; 81f0  ..k..D".5."....!
	defb 094h,022h,098h,021h,07eh,017h,0feh,059h,021h,08ch,022h,094h,020h,092h,0c8h,0ffh	; 8200  .".!~..Y!.". ...
	defb 075h,035h,056h,075h,058h,075h,05ah,075h,076h,075h,078h,075h,07ah,07fh,089h,07ch	; 8210  u5VuXuZuvuxuz..|
	defb 077h,0feh,065h,02ch,06ah,03ah,06ch,021h,074h,07fh,092h,076h,07fh,08fh,078h,060h	; 8220  w.e,j:l!t..v..x`
	defb 07ch,077h,0feh,02bh,021h,064h,021h,068h,030h,07ch,0cfh,0feh,037h,022h,077h,035h	; 8230  |w.+!d!h0|..7"w5
	defb 07eh,020h,082h,08ch,04ah,017h,07ch,0d3h,0feh,026h,021h,02ah,021h,084h,022h,0a1h	; 8240  ~ ..J.|..&!*!.".
	defb 017h,0feh,054h,02dh,059h,035h,0bbh,021h,05ah,07fh,082h,0feh,0feh,072h,035h,075h	; 8250  ..T-Y5.!Z....r5u
	defb 035h,042h,018h,04ch,075h,08ch,07fh,09bh,0ach,062h,0ffh,068h,089h,0feh,05eh,021h	; 8260  5B.Lu....b.h..^!
	defb 0feh,043h,035h,046h,035h,049h,028h,04ch,02ch,0feh,0feh,046h,028h,049h,022h,03ch	; 8270  .C5F5I(L,..F(I"<
	defb 077h,0aeh,089h,06bh,017h,06eh,017h,0feh,091h,025h,097h,021h,06ah,017h,0a9h,082h	; 8280  w..k.n...%.!j...
	defb 0feh,034h,028h,03bh,021h,0a4h,021h,042h,085h,089h,017h,0feh,062h,034h,096h,021h	; 8290  .4(;!.!B....b4.!
	defb 099h,021h,09ch,021h,0feh,039h,022h,089h,021h,06dh,018h,09ch,07fh,0dch,047h,09eh	; 82a0  .!.!.9".!m....G.
	defb 000h,065h,029h,07ah,026h,033h,018h,08eh,09ah,0feh,038h,030h,03eh,022h,065h,021h	; 82b0  .e)z&3....80>"e!
	defb 032h,0c5h,069h,017h,0feh,062h,025h,07dh,029h,0feh,07ah,028h,076h,077h,07dh,021h	; 82c0  2.i..b%}).z(vw}!
	defb 0feh,077h,034h,07dh,021h,084h,091h,0feh,035h,021h,03dh,02dh,07dh,021h,08eh,017h	; 82d0  .w4}!...5!=-}!..
	defb 046h,09ch,087h,093h,0feh,082h,021h,086h,022h,08ah,021h,08ch,022h,0feh,092h,021h	; 82e0  F.....!.".!."..!
	defb 084h,022h,086h,021h,089h,021h,09bh,021h,09eh,022h,0feh,094h,021h,092h,0ceh,0ffh	; 82f0  .".!.!.!."..!...
	defb 097h,022h,09ah,035h,09dh,035h,0feh,048h,017h,056h,078h,076h,07fh,09eh,078h,07fh	; 8300  .".5.5.H.Vxv..x.
	defb 091h,07ah,07fh,092h,07ch,062h,094h,060h,096h,07fh,0c1h,0feh,072h,022h,075h,021h	; 8310  .z..|b.`....r"u!
	defb 08dh,022h,0feh,056h,07fh,092h,078h,062h,07ch,07fh,083h,094h,060h,096h,07fh,09ch	; 8320  .".V..xb|...`...
	defb 098h,060h,09ah,07fh,0d7h,0feh,08bh,021h,08eh,03ah,098h,07fh,085h,0feh,094h,035h	; 8330  .`.....!.:.....5
	defb 097h,035h,0ffh,093h,021h,0feh,089h,021h,08eh,021h,074h,077h,0feh,082h,020h,097h	; 8340  .5..!..!.!tw.. .
	defb 022h,09ch,020h,0aeh,092h,0feh,093h,021h,098h,021h,09bh,020h,09eh,022h,0feh,08eh	; 8350  ". ....!.!. ."..
	defb 021h,086h,091h,078h,0dfh,0feh,098h,022h,06ch,078h,092h,07fh,088h,09ah,060h,0feh	; 8360  !..x..."lx....`.
	defb 0feh,091h,02ch,07ah,035h,07eh,020h,08ch,08fh,0feh,072h,021h,079h,035h,09ch,022h	; 8370  ..,z5~ ...r!y5."
	defb 0aeh,017h,0feh,072h,022h,077h,021h,07ah,035h,074h,077h,0feh,091h,021h,096h,028h	; 8380  ...r"w!z5tw..!.(
	defb 08ch,022h,0feh,097h,020h,084h,085h,000h,093h,022h,098h,021h,09eh,022h,032h,07fh	; 8390  .".. ....".!."2.
	defb 0e3h,0feh,094h,021h,08ch,021h,0aeh,017h,0feh,087h,022h,08ch,021h,049h,017h,0adh	; 83a0  ...!.!....".!I..
	defb 017h,0feh,031h,021h,036h,022h,03bh,030h,049h,017h,0feh,035h,022h,03ah,027h,098h	; 83b0  ..1!6";0I..5":'.
	defb 020h,094h,07fh,08fh,092h,0c6h,0feh,034h,029h,039h,022h,03eh,021h,0feh,049h,017h	; 83c0   ......4)9">!.I.
	defb 03ch,07fh,0d1h,07ah,078h,0feh,083h,021h,089h,022h,08ch,03ah,04bh,017h,0a2h,017h	; 83d0  <..zx..!.".:K...
	defb 0feh,028h,021h,02bh,021h,02eh,020h,032h,07fh,091h,052h,07fh,093h,0feh,05bh,022h	; 83e0  .(!+!. 2..R...["
	defb 05eh,020h,0feh,059h,021h,05ch,021h,09ch,07fh,0d8h,0feh,032h,07fh,09ch,0ffh,023h	; 83f0  ^ .Y!\!....2...#
	defb 022h,083h,03ah,06dh,017h,0feh,094h,02ch,098h,022h,09ch,035h,06dh,09ch,064h,017h	; 8400  ".:m...,.".5m.d.
	defb 0feh,064h,027h,08ch,021h,04bh,089h,06eh,083h,0a6h,017h,0feh,024h,025h,029h,020h	; 8410  .d'.!K.n....$%)
	defb 0feh,024h,035h,02dh,021h,078h,021h,0a5h,017h,0ach,017h,0feh,044h,060h,064h,078h	; 8420  .$5-!x!.....D`dx
	defb 04bh,08fh,0feh,043h,021h,049h,025h,04ch,021h,0a3h,087h,096h,0c1h,0feh,037h,020h	; 8430  K..C!I%L!.....7
	defb 03ah,021h,08ah,034h,093h,021h,095h,021h,0ffh,035h,021h,094h,030h,04bh,08fh,03ch	; 8440  :!.4.!.!.5!.0K.<
	defb 07fh,0d6h,0feh,096h,022h,09ah,030h,08dh,022h,03bh,022h,0a4h,017h,0feh,081h,030h	; 8450  ....".0.";"....0
	defb 085h,021h,089h,021h,08dh,029h,04bh,091h,03ch,07fh,0dch,0feh,089h,029h,08dh,022h	; 8460  .!.!.)K.<....)."
	defb 042h,018h,0feh,04bh,017h,0feh,042h,022h,04ah,022h,062h,08ah,06bh,083h,0ach,08fh	; 8470  B..K..B"J"b.k...
	defb 0feh,087h,021h,08ch,022h,0a9h,017h,0adh,092h,0feh,0feh,0a4h,017h,0feh,062h,022h	; 8480  ..!.".........b"
	defb 076h,027h,079h,022h,06dh,022h,000h,068h,035h,096h,021h,09bh,035h,0feh,06ch,017h	; 8490  v'y"m".h5.!.5.l.
	defb 0feh,062h,089h,0feh,0feh,0feh,056h,022h,069h,018h,0feh,021h,028h,036h,022h,094h	; 84a0  .b....V"i..!(6".
	defb 021h,098h,022h,0a6h,092h,0feh,0feh,0ach,018h,0feh,057h,02dh,059h,022h,066h,087h	; 84b0  !.".......W-Y"f.
	defb 068h,08ah,06dh,018h,0ffh,025h,031h,058h,021h,091h,022h,098h,078h,0feh,032h,021h	; 84c0  h.m..%1X!.".x.2!
	defb 03dh,021h,058h,060h,078h,060h,098h,07fh,0dbh,0a7h,083h,061h,017h,0feh,04dh,022h	; 84d0  =!X`x`.....a..M"
	defb 09dh,021h,052h,09dh,094h,060h,096h,07fh,091h,0a8h,08fh,0feh,047h,030h,04ch,022h	; 84e0  .!R..`......G0L"
	defb 094h,022h,09ch,035h,06dh,017h,0feh,031h,021h,035h,026h,03ch,021h,084h,022h,08ch	; 84f0  .".5m..1!5&<!.".
	defb 022h,0aah,08ah,0feh,038h,035h,03bh,021h,03eh,035h,08eh,022h,042h,093h,0ach,017h	; 8500  "...85;!>5."B...
	defb 0feh,03ah,022h,084h,021h,04dh,08ch,068h,089h,0abh,084h,09ch,07fh,0e0h,090h,060h	; 8510  .:".!M.h.......`
	defb 0feh,08dh,09dh,0aeh,082h,04eh,017h,0feh,038h,020h,078h,020h,04eh,017h,032h,0cah	; 8520  .....N..8 x N.2.
	defb 0feh,044h,017h,032h,0d4h,058h,075h,05ah,07fh,085h,076h,062h,078h,062h,0a9h,092h	; 8530  .D.2.XuZ..vbxb..
	defb 0feh,04dh,018h,0adh,017h,0feh,043h,034h,0ffh,0feh,036h,022h,03eh,022h,084h,017h	; 8540  .M....C4..6">"..
	defb 09ch,0e3h,0feh,075h,022h,07dh,022h,081h,092h,044h,017h,0feh,046h,022h,04eh,035h	; 8550  ...u"}"..D..F"N5
	defb 091h,020h,096h,022h,09eh,021h,061h,088h,0feh,022h,035h,069h,035h,094h,035h,09dh	; 8560  . .".!a.."5i5.5.
	defb 021h,041h,08ch,066h,017h,0feh,03ch,03ah,048h,017h,0b1h,017h,042h,087h,0a7h,089h	; 8570  !A.f..<:H...B...
	defb 0feh,03ah,020h,046h,021h,0bbh,021h,031h,018h,0feh,034h,021h,049h,022h,07dh,021h	; 8580  .: F!.!1..4!I"}!
	defb 091h,022h,0a3h,093h,066h,017h,0feh,035h,020h,038h,021h,03bh,021h,094h,020h,098h	; 8590  ."..f..5 8!;!. .
	defb 022h,09ch,021h,032h,0d4h,000h,0cch,085h,0cfh,085h,0d7h,085h,0ddh,085h,0e3h,085h	; 85a0  ".!2............
	defb 0e9h,085h,0efh,085h,0f5h,085h,0feh,085h,006h,086h,00fh,086h,018h,086h,01eh,086h	; 85b0  ................
	defb 02ah,086h,036h,086h,03eh,086h,048h,086h,052h,086h,05eh,086h,000h,000h,000h,001h	; 85c0  *.6.>.H.R.^.....
	defb 001h,000h,000h,008h,001h,001h,000h,008h,008h,001h,008h,002h,002h,000h,000h,000h	; 85d0  ................
	defb 081h,008h,000h,080h,000h,000h,000h,0a0h,080h,0a0h,020h,080h,080h,020h,0a0h,010h	; 85e0  .......... .. ..
	defb 000h,000h,0a0h,020h,000h,080h,080h,080h,080h,000h,080h,000h,000h,000h,000h,020h	; 85f0  ... ...........
	defb 000h,000h,000h,000h,000h,000h,0a0h,0a0h,020h,020h,000h,000h,000h,000h,000h,008h	; 8600  ........  ......
	defb 004h,004h,004h,004h,004h,000h,000h,000h,081h,000h,040h,040h,040h,080h,000h,000h	; 8610  ..........@@@...
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,080h,000h,000h,000h	; 8620  ................
	defb 080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,000h,080h	; 8630  ................
	defb 080h,080h,000h,000h,000h,080h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8640  ................
	defb 000h,000h,000h,000h,000h,080h,000h,080h,000h,040h,000h,000h,040h,000h,000h,080h	; 8650  .........@..@...
	defb 000h,000h,000h,000h,000h,080h,080h,000h,074h,086h,08eh,086h,0b6h,086h,006h,087h	; 8660  ........t.......
	defb 03fh,087h,0ceh,087h,000h,000h,005h,088h,000h,085h,046h,000h,000h,000h,000h,085h	; 8670  ?.........F.....
	defb 06ch,0ffh,0ffh,005h,087h,000h,005h,088h,085h,0abh,000h,01fh,067h,0ffh,006h,0ceh	; 8680  l...........g...
	defb 006h,069h,000h,006h,0c8h,006h,064h,01fh,034h,000h,006h,0cbh,006h,064h,000h,01fh	; 8690  .i....d.4....d..
	defb 033h,000h,006h,0cah,006h,0a6h,0ffh,000h,000h,006h,065h,000h,006h,06ah,006h,0aah	; 86a0  3.........e..j..
	defb 0ffh,000h,000h,00ah,05ch,0ffh,000h,00dh,095h,00dh,09ah,000h,00bh,0b9h,000h,00bh	; 86b0  ....\...........
	defb 0cbh,000h,00bh,0cdh,00dh,08bh,00dh,055h,000h,00bh,093h,000h,00bh,0b9h,000h,00ch	; 86c0  .......U........
	defb 057h,000h,00ch,057h,0ffh,000h,000h,00bh,05dh,000h,00bh,099h,000h,000h,00ch,055h	; 86d0  W..W....]......U
	defb 000h,00ah,099h,00ch,0c5h,000h,00bh,0c8h,0ffh,000h,00ah,07ch,000h,00ah,075h,00ah	; 86e0  ...........|..u.
	defb 07bh,000h,000h,00ah,075h,00bh,07bh,000h,00dh,075h,00dh,057h,000h,00bh,054h,000h	; 86f0  {...u.{..u.W..T.
	defb 000h,00bh,0b3h,00dh,057h,0ffh,000h,000h,000h,000h,000h,000h,021h,0b3h,021h,0bch	; 8700  ....W.......!.!.
	defb 000h,021h,0b8h,000h,021h,0b3h,021h,0bdh,0ffh,000h,00dh,059h,000h,00dh,077h,000h	; 8710  .!..!.!....Y..w.
	defb 000h,000h,00eh,07dh,0ffh,00eh,09ch,000h,000h,000h,000h,00eh,065h,000h,00eh,07dh	; 8720  ...}........e..}
	defb 000h,000h,00eh,096h,000h,00eh,099h,000h,000h,00eh,09ah,000h,00eh,09eh,0ffh,00bh	; 8730  ................
	defb 0bch,009h,05ch,000h,00bh,054h,00dh,07bh,000h,00dh,055h,00dh,05ah,00dh,097h,00dh	; 8740  ..\..T.{..U.Z...
	defb 0beh,000h,00bh,056h,00bh,05ch,00dh,09dh,000h,00bh,09ch,009h,0b2h,000h,00bh,05ch	; 8750  ...V.\.........\
	defb 00bh,077h,00dh,0b6h,00dh,0bch,000h,00dh,057h,000h,00bh,056h,00bh,0b4h,000h,009h	; 8760  .w......W..V....
	defb 05bh,009h,074h,009h,0bah,000h,009h,055h,009h,07ch,009h,0b4h,009h,0b7h,000h,00bh	; 8770  [.t....U.|......
	defb 079h,00bh,0b4h,000h,00dh,05ah,00dh,075h,00dh,0b6h,0ffh,010h,07ch,000h,010h,072h	; 8780  y....Z.u....|..r
	defb 010h,0bah,000h,010h,0b9h,000h,009h,056h,009h,05ch,009h,0b2h,009h,0bah,000h,010h	; 8790  .......V.\......
	defb 059h,010h,0b4h,000h,010h,0bah,000h,010h,074h,010h,0bch,000h,010h,058h,010h,0bdh	; 87a0  Y.......t....X..
	defb 0ffh,000h,010h,058h,010h,0b5h,000h,010h,055h,010h,0b5h,000h,010h,0bch,000h,010h	; 87b0  ...X....U.......
	defb 079h,010h,0b6h,000h,000h,010h,0bah,000h,010h,0bah,000h,010h,0bah,0ffh,000h,012h	; 87c0  y...............
	defb 0b8h,000h,012h,097h,000h,012h,098h,000h,012h,0bah,000h,000h,000h,012h,056h,000h	; 87d0  ..............V.
	defb 012h,058h,0ffh,000h,00bh,0b6h,000h,00dh,07eh,000h,010h,076h,000h,010h,05bh,010h	; 87e0  .X......~..v..[.
	defb 0bah,000h,010h,053h,000h,00dh,079h,00dh,0b9h,000h,000h,00dh,053h,000h,00dh,055h	; 87f0  ...S..y.....S..U
	defb 0ffh,000h,010h,056h,000h,010h,095h,000h,00dh,07dh,00dh,077h,000h,00dh,077h,00dh	; 8800  ...V.....}.w..w.
	defb 053h,000h,00dh,05ah,00dh,054h,000h,00dh,07bh,00dh,0b4h,000h,00dh,079h,00dh,055h	; 8810  S..Z.T..{....y.U
	defb 000h,010h,0b6h,0ffh,07ch,0c4h,086h,082h,0c2h,046h,07ch,000h,018h,030h,010h,010h	; 8820  ....|....F|..0..
	defb 010h,020h,038h,000h,07ch,082h,0c2h,01ch,060h,082h,0feh,000h,07ch,082h,006h,018h	; 8830  . 8.|...`...|...
	defb 006h,082h,07ch,000h,00eh,012h,024h,044h,086h,0fah,006h,000h,0feh,040h,078h,0c6h	; 8840  ..|...$D.....@x.
	defb 002h,0c2h,03ch,000h,03ch,040h,0bch,0c6h,082h,086h,07ch,000h,0feh,082h,044h,008h	; 8850  ..<.<@....|...D.
	defb 008h,010h,018h,000h,07ch,086h,082h,07ch,082h,0c2h,07ch,000h,07ch,0c2h,082h,0c6h	; 8860  ....|..|..|.|...
	defb 07ah,004h,078h,000h,000h,000h,000h,000h,000h,060h,060h,000h,060h,060h,020h,040h	; 8870  z.x......``.`` @
	defb 000h,000h,000h,000h,000h,018h,018h,000h,018h,018h,000h,000h,000h,000h,000h,000h	; 8880  ................
	defb 030h,030h,010h,020h,038h,044h,044h,082h,0e2h,09eh,0c6h,000h,0fch,082h,044h,078h	; 8890  00. 8DD.......Dx
	defb 044h,082h,0fch,000h,03ch,046h,080h,080h,080h,046h,03ch,000h,0f8h,084h,042h,042h	; 88a0  D...<F...F<...BB
	defb 042h,084h,0f8h,000h,0fch,086h,040h,078h,040h,086h,0fch,000h,0fch,086h,040h,078h	; 88b0  B.....@x@.....@x
	defb 040h,080h,0c0h,000h,03ch,046h,080h,08eh,082h,046h,03ch,000h,0c6h,082h,044h,07ch	; 88c0  @...<F...F<...D|
	defb 044h,082h,0c6h,000h,038h,020h,010h,010h,010h,008h,038h,000h,00eh,002h,004h,084h	; 88d0  D...8 ....8.....
	defb 084h,0cch,078h,000h,0c6h,08ch,050h,060h,050h,090h,0ceh,000h,0c0h,080h,040h,040h	; 88e0  ..x...P`P.....@@
	defb 042h,086h,0fch,000h,0c6h,044h,06ch,054h,054h,082h,0c6h,000h,0c6h,042h,064h,054h	; 88f0  B....DlTT....BdT
	defb 04ch,084h,0c6h,000h,03ch,046h,0c2h,082h,086h,0c4h,078h,000h,0fch,086h,042h,046h	; 8900  L...<F....x...BF
	defb 07ch,080h,0c0h,000h,03ch,046h,0c2h,082h,09eh,0c4h,07eh,000h,0fch,082h,042h,07ch	; 8910  |...<F....~...B|
	defb 048h,088h,0c6h,000h,07ch,086h,0c0h,07ch,006h,0c2h,07ch,000h,07ch,092h,010h,010h	; 8920  H...|..|..|.|...
	defb 010h,008h,038h,000h,0c6h,082h,044h,082h,082h,0c6h,07ch,000h,0c6h,082h,044h,044h	; 8930  ..8...D...|...DD
	defb 06ch,028h,038h,000h,0c6h,092h,054h,054h,06ch,0c6h,082h,000h,0c6h,082h,044h,038h	; 8940  l(8...TTl.....D8
	defb 044h,082h,0c6h,000h,0c6h,082h,044h,028h,010h,008h,038h,000h,0feh,082h,01ch,010h	; 8950  D.....D(..8.....
	defb 070h,082h,0feh,000h	; 8960

; ======================================================================
; CODIGO 0x8964..0x89f1  (141 bytes)
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
	ld de,089f1h		;89e6
	ld (hl),e			;89e9
	inc hl			;89ea
	ld (hl),d			;89eb
	ld e,000h		;89ec
	jp L_8A0B		;89ee

; ----------------------------------------------------------------------
; DATOS sin identificar  0x89f1..0x89f2  (1 bytes)
DATA_89F1:
	defb 0c9h	; 89f1

; ======================================================================
; CODIGO 0x89f2..0x8a45  (83 bytes)
; ======================================================================


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
; DATOS sin identificar  0x8a45..0x8a5d  (24 bytes)
DATA_8A45:
	defb 0feh,008h,0fdh,010h,0fbh,020h,0f7h,001h,0efh,002h,0dfh,004h,0f6h,000h,0edh,000h	; 8a45  ..... ..........
	defb 0dbh,000h,0ffh,009h,0ffh,012h,0ffh,024h	; 8a55  .......$

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
; DATOS sin identificar  0x8b81..0x8b99  (24 bytes)
DATA_8B81:
	defb 0b8h,01ah,038h,019h,0d0h,017h,078h,016h,034h,015h,004h,014h,0e4h,012h,0d4h,011h	; 8b81  ..8...x.4.......
	defb 0d4h,010h,0e4h,00fh,000h,00fh,028h,00eh	; 8b91  ......(.

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
; DATOS sin identificar  0x8d8f..0xa000  (4721 bytes)
DATA_8D8F:
	defb 02bh,08eh,058h,08eh,08ah,08eh,099h,08eh,0aeh,08eh,0cbh,08eh,0e4h,08eh,0f3h,08eh	; 8d8f  +.X.............
	defb 025h,08fh,056h,08fh,075h,08fh,0b9h,08fh,0ddh,08fh,02eh,090h,065h,090h,09ah,090h	; 8d9f  %.V.u.......e...
	defb 0c7h,090h,0e6h,090h,037h,091h,052h,091h,079h,091h,012h,092h,075h,092h,0d8h,092h	; 8daf  ....7.R.y...u...
	defb 070h,094h,01ah,093h,0cah,093h,09fh,093h,069h,08eh,09bh,094h,001h,095h,098h,095h	; 8dbf  p.......i.......
	defb 069h,096h,0c7h,096h,06dh,097h,0dah,097h,091h,098h,03dh,099h,058h,09ah,0b8h,09ah	; 8dcf  i...m.....=.X...
	defb 06ah,09bh,015h,09ch,0dbh,09ch,0f8h,09dh,0c1h,09eh,089h,09fh,051h,0a0h,057h,0a1h	; 8ddf  j...........Q.W.
	defb 017h,0a2h,0b9h,0a1h,0c5h,0a2h,003h,0a3h,05bh,0a3h,09eh,0a3h,0e4h,0a3h,03ch,0a4h	; 8def  ........[.....<.
	defb 09bh,0a4h,0b0h,0a4h,0c4h,0a4h,0d1h,0a4h,006h,0a5h,01dh,0a5h,04eh,0a5h,073h,0a5h	; 8dff  ............N.s.
	defb 0a5h,0a5h,0dfh,0a5h,0fdh,0a5h,021h,0a6h,071h,0a6h,08fh,0a6h,0aah,0a6h,0c4h,0a6h	; 8e0f  ......!.q.......
	defb 065h,0a7h,000h,0a8h,022h,0a8h,022h,0a8h,022h,0a8h,022h,0a8h,022h,001h,0d0h,0ech	; 8e1f  e..."."."."."...
	defb 0c0h,046h,0d0h,08eh,0c0h,046h,0d0h,08eh,0d0h,046h,0c0h,050h,0d0h,0f0h,0d0h,0e0h	; 8e2f  .F...F...F.P....
	defb 0d0h,0d0h,0d0h,0c0h,0c0h,0b0h,0b0h,0a0h,0a0h,090h,090h,080h,090h,066h,090h,055h	; 8e3f  .............f.U
	defb 0c0h,044h,0c0h,033h,0e0h,022h,0e0h,011h,0ffh,02ah,005h,000h,013h,0a0h,070h,022h	; 8e4f  .D.3."...*....p"
	defb 003h,000h,000h,02ah,010h,000h,013h,0a0h,070h,0ffh,022h,003h,060h,010h,070h,014h	; 8e5f  ...*....p.".`.p.
	defb 080h,018h,090h,01ch,0a0h,020h,0b0h,010h,0c0h,01eh,0d0h,02dh,0e0h,03ch,0f0h,051h	; 8e6f  ..... .....-.<.Q
	defb 0c0h,06ch,0d0h,025h,0c0h,032h,0b0h,062h,0c0h,049h,0ffh,021h,002h,01dh,0c0h,000h	; 8e7f  .l.%.2.b.I.!....
	defb 01bh,0c0h,000h,012h,0e0h,000h,01dh,0c0h,000h,0ffh,021h,001h,011h,090h,000h,012h	; 8e8f  ..........!.....
	defb 0c0h,000h,013h,0e0h,000h,017h,0f0h,000h,01bh,0e0h,000h,01ch,0a0h,000h,0ffh,021h	; 8e9f  ...............!
	defb 001h,011h,050h,000h,013h,070h,000h,015h,0a0h,000h,017h,0d0h,000h,021h,002h,018h	; 8eaf  ..P..p.......!..
	defb 040h,000h,016h,0e0h,000h,014h,030h,000h,012h,0e0h,000h,0ffh,022h,001h,091h,0a0h	; 8ebf  @.....0....."...
	defb 0c1h,0e0h,0d1h,050h,0d1h,080h,0e2h,000h,0d1h,0f0h,0e2h,050h,0d2h,0a0h,0c3h,000h	; 8ecf  ...P.......P....
	defb 0b3h,080h,0a4h,000h,0ffh,021h,002h,01eh,0d0h,000h,022h,001h,000h,000h,021h,002h	; 8edf  .....!...."...!.
	defb 01ah,0e0h,000h,0ffh,022h,001h,0d1h,080h,0d2h,000h,021h,003h,01ah,0f0h,000h,000h	; 8eef  ....".....!.....
	defb 000h,021h,002h,019h,0f0h,000h,018h,0f0h,000h,017h,0e0h,000h,016h,0e0h,000h,015h	; 8eff  .!..............
	defb 0d0h,000h,016h,0d0h,000h,015h,0c0h,000h,021h,005h,013h,0b0h,000h,080h,000h,070h	; 8f0f  ........!......p
	defb 000h,060h,000h,050h,000h,0ffh,022h,001h,0d1h,070h,0d2h,000h,021h,002h,01dh,0f0h	; 8f1f  .`.P.."..p..!...
	defb 000h,01ah,0f0h,000h,000h,000h,021h,003h,012h,080h,000h,0f0h,000h,015h,0e0h,000h	; 8f2f  ......!.........
	defb 0c0h,000h,014h,0c0h,000h,015h,0b0h,000h,014h,0c0h,000h,013h,0c0h,000h,0a0h,000h	; 8f3f  ................
	defb 090h,000h,080h,000h,070h,000h,0ffh,022h,001h,0a0h,050h,0c0h,060h,0d0h,080h,0e0h	; 8f4f  ....p.."..P.`...
	defb 0a0h,0c0h,0d0h,022h,003h,000h,000h,022h,001h,0b0h,050h,0a0h,060h,090h,080h,080h	; 8f5f  ..."..."..P.`...
	defb 0a0h,0feh,004h,056h,08fh,0ffh,02ah,001h,000h,005h,081h,0f0h,006h,000h,02ah,002h	; 8f6f  ...V..*.......*.
	defb 006h,000h,090h,02ch,023h,001h,01fh,0e0h,010h,0e0h,030h,0e0h,010h,0e0h,0a0h,0e0h	; 8f7f  ...,#.....0.....
	defb 060h,0e0h,050h,0e0h,040h,0e0h,030h,0d0h,020h,0d0h,010h,0d0h,050h,0d0h,040h,0c0h	; 8f8f  `.P.@.0. ...P.@.
	defb 030h,0c0h,020h,0c0h,010h,0c0h,00ah,0b0h,006h,0b0h,040h,0b0h,030h,0a0h,020h,0a0h	; 8f9f  0. .......@.0. .
	defb 010h,02ah,001h,000h,001h,0c0h,001h,0c0h,001h,0ffh,021h,001h,01dh,0e0h,000h,01fh	; 8faf  .*........!.....
	defb 0e0h,000h,01eh,0e0h,000h,01dh,0e0h,000h,01ch,0e0h,000h,01ah,0e0h,000h,018h,0e0h	; 8fbf  ................
	defb 000h,016h,0e0h,000h,014h,0e0h,000h,013h,0e0h,000h,011h,0e0h,000h,0ffh,022h,001h	; 8fcf  ..............".
	defb 0f2h,020h,0f2h,0a0h,0f3h,010h,0f3h,070h,0e3h,0c0h,0e4h,030h,0e4h,030h,0e4h,050h	; 8fdf  . .....p...0.0.P
	defb 0e4h,060h,0f2h,060h,0f2h,0a0h,0f3h,010h,0f3h,070h,0f3h,0c0h,022h,002h,0f4h,000h	; 8fef  .`.`.....p.."...
	defb 0f4h,030h,0f4h,050h,0f4h,060h,022h,001h,0e2h,020h,0e2h,0a0h,0e3h,010h,0e3h,070h	; 8fff  .0.P.`".. .....p
	defb 0d3h,0c0h,0d4h,000h,0d3h,000h,0d4h,050h,0d4h,060h,0e2h,060h,0e2h,0a0h,0e3h,010h	; 900f  .......P.`.`....
	defb 0e3h,070h,0e3h,0c0h,022h,002h,0d4h,000h,0d4h,030h,0d4h,050h,0d4h,060h,0ffh,021h	; 901f  .p.."....0.P.`.!
	defb 003h,01ch,0f0h,000h,01ah,0f0h,000h,021h,001h,012h,0e0h,000h,021h,003h,018h,0a0h	; 902f  .......!....!...
	defb 000h,021h,001h,012h,0d0h,000h,021h,004h,016h,090h,000h,021h,001h,012h,0d0h,000h	; 903f  .!....!....!....
	defb 015h,0e0h,000h,021h,001h,012h,0e0h,000h,021h,004h,014h,0c0h,000h,021h,001h,012h	; 904f  ...!....!....!..
	defb 0f0h,000h,013h,0e0h,000h,0ffh,022h,001h,0e0h,049h,0f0h,062h,0f0h,032h,0d0h,025h	; 905f  ......"..I.b.2.%
	defb 0e0h,06ch,0d0h,051h,0e0h,03ch,0d0h,02dh,0c0h,01eh,0b0h,010h,0c0h,049h,0b0h,062h	; 906f  .l.Q.<.-.....I.b
	defb 0c0h,032h,0d0h,025h,0c0h,06ch,0f0h,051h,0e0h,03ch,0d0h,02dh,0c0h,01eh,0b0h,010h	; 907f  .2.%.l.Q.<.-....
	defb 0a0h,020h,090h,01ch,080h,018h,070h,014h,060h,010h,0ffh,022h,001h,0e0h,0ech,0d0h	; 908f  . ....p.`.."....
	defb 046h,0e0h,08eh,0d0h,046h,0e0h,08eh,0e0h,046h,0d0h,050h,0e0h,0f0h,0e0h,0e0h,0e0h	; 909f  F...F...F.P.....
	defb 0d0h,0e0h,0c0h,0d0h,0b0h,0c0h,0a0h,0b0h,090h,0a0h,080h,0a0h,066h,0a0h,055h,0d0h	; 90af  ............f.U.
	defb 044h,0d0h,033h,0f0h,022h,0f0h,011h,0ffh,022h,003h,0f0h,050h,0f0h,035h,000h,000h	; 90bf  D.3."..."..P.5..
	defb 0e0h,050h,0e0h,035h,000h,000h,0d0h,050h,0d0h,035h,000h,000h,0c0h,050h,0c0h,035h	; 90cf  .P.5...P.5...P.5
	defb 000h,000h,0b0h,050h,0b0h,035h,0ffh,022h,001h,0d0h,066h,0d0h,055h,0d0h,044h,0d0h	; 90df  ...P.5."..f.U.D.
	defb 033h,0d0h,022h,0d0h,043h,0d0h,03bh,0d0h,033h,0d0h,02bh,0d0h,023h,022h,001h,0f0h	; 90ef  3.".C.;.3.+.#"..
	defb 088h,0f0h,077h,0f0h,066h,0f0h,055h,0f0h,077h,0f0h,066h,0f0h,055h,0f0h,044h,0f0h	; 90ff  ..w.f.U.w.f.U.D.
	defb 03fh,0d0h,030h,0d0h,028h,0d0h,020h,0d0h,067h,0d0h,057h,0d0h,047h,0d0h,037h,0c0h	; 910f  ?.0.(. .g.W.G.7.
	defb 088h,0c0h,077h,0c0h,066h,0c0h,055h,0b0h,077h,0b0h,066h,0b0h,055h,0b0h,044h,0a0h	; 911f  ..w.f.U.w.f.U.D.
	defb 06fh,0a0h,05fh,0a0h,04fh,0a0h,03fh,0ffh,022h,004h,071h,0e0h,0a2h,02ch,0b1h,0e0h	; 912f  o._.O.?.".q..,..
	defb 0d2h,02ch,0e1h,0e0h,0e2h,02ch,0d1h,0e0h,0c2h,02ch,0b1h,0e0h,0a2h,02ch,091h,0e0h	; 913f  .,...,...,...,..
	defb 072h,02ch,0ffh,022h,003h,0e0h,028h,0e0h,070h,0e0h,060h,0e0h,040h,0d0h,020h,0c0h	; 914f  r,."..(.p.`.@. .
	defb 020h,022h,004h,0b0h,028h,0b0h,070h,0b0h,060h,0b0h,040h,022h,003h,0a0h,020h,090h	; 915f   "..(.p.`.@".. .
	defb 020h,080h,020h,070h,020h,060h,020h,050h,020h,0ffh,022h,001h,0b1h,033h,0b1h,003h	; 916f   . p ` P ."..3..
	defb 0b0h,0d3h,0b0h,0a3h,0b0h,073h,0e1h,02bh,0e0h,0fbh,0e0h,0dbh,0e0h,0bbh,0e0h,09bh	; 917f  .....s.+........
	defb 0e1h,033h,0e1h,003h,0e0h,0d3h,0e0h,0a3h,0e0h,073h,0e1h,022h,0e0h,0f2h,0e0h,0c2h	; 918f  .3.......s."....
	defb 0e0h,092h,0e0h,062h,0e1h,02bh,0e0h,0fbh,0e0h,0dbh,0e0h,0bbh,0e0h,09bh,0d1h,007h	; 919f  ...b.+..........
	defb 0d0h,0d7h,0d0h,0a7h,0d0h,077h,0d0h,047h,0d1h,028h,0d0h,0f8h,0d0h,0d8h,0d0h,0b8h	; 91af  .....w.G.(......
	defb 0d0h,098h,0c1h,033h,0c1h,003h,0c0h,0d3h,0c0h,0a3h,0c0h,073h,0c1h,007h,0c0h,0d7h	; 91bf  ...3.......s....
	defb 0c0h,0a7h,0c0h,077h,0c0h,047h,0b1h,007h,0b0h,0d7h,0b0h,0a7h,0b0h,077h,0b0h,047h	; 91cf  ...w.G.......w.G
	defb 0a1h,007h,0a0h,0d7h,0a0h,0a7h,0a0h,077h,0a0h,047h,0c1h,033h,0c1h,003h,0c0h,0d3h	; 91df  .......w.G.3....
	defb 0c0h,0a3h,0c0h,073h,0b1h,007h,0b0h,0d7h,0b0h,0a7h,0b0h,077h,0b0h,047h,0a1h,007h	; 91ef  ...s.......w.G..
	defb 0a0h,0d7h,0a0h,0a7h,0a0h,077h,0a0h,047h,091h,007h,080h,0d7h,090h,0a7h,090h,077h	; 91ff  .....w.G.......w
	defb 090h,047h,0ffh,022h,001h,0c0h,044h,0c0h,01eh,0b0h,006h,0b0h,044h,0b0h,01eh,0b0h	; 920f  .G."..D.....D...
	defb 006h,0b0h,044h,0b0h,01eh,0b0h,006h,0c0h,044h,0c0h,01eh,0c0h,006h,0c0h,044h,0c0h	; 921f  ..D.....D.....D.
	defb 01eh,0c0h,006h,0c0h,044h,0c0h,01eh,0c0h,006h,0c0h,044h,0c0h,01eh,0c0h,006h,0c0h	; 922f  ....D.....D.....
	defb 044h,0c0h,01eh,0c0h,006h,0d0h,044h,0d0h,01eh,0d0h,006h,0d0h,044h,0d0h,01eh,0f0h	; 923f  D.....D.....D...
	defb 006h,0f0h,044h,0f0h,01eh,0f0h,006h,0f0h,044h,0f0h,01eh,0f0h,006h,0f0h,044h,0f0h	; 924f  ..D.....D.....D.
	defb 01eh,0f0h,006h,0e0h,044h,0e0h,01eh,0e0h,006h,0e0h,044h,0d0h,01eh,0d0h,006h,0d0h	; 925f  ....D.....D.....
	defb 044h,0c0h,01eh,0b0h,006h,0ffh,022h,001h,090h,055h,0a0h,033h,0b0h,011h,090h,055h	; 926f  D....."..U.3...U
	defb 0a0h,033h,0b0h,011h,0a0h,055h,0b0h,033h,0c0h,011h,0b0h,055h,0c0h,033h,0d0h,011h	; 927f  .3...U.3...U.3..
	defb 0c0h,055h,0d0h,033h,0e0h,011h,0c0h,055h,0d0h,033h,0e0h,011h,0d0h,055h,0e0h,033h	; 928f  .U.3...U.3...U.3
	defb 0f0h,011h,0e0h,055h,0f0h,033h,0f0h,011h,0f0h,055h,0f0h,033h,0f0h,011h,0f0h,055h	; 929f  ...U.3...U.3...U
	defb 0f0h,033h,0f0h,011h,0e0h,055h,0e0h,033h,0e0h,011h,0d0h,055h,0c0h,033h,0c0h,011h	; 92af  .3...U.3...U.3..
	defb 0c0h,055h,0c0h,033h,0c0h,011h,0b0h,055h,0b0h,033h,0b0h,011h,0b0h,055h,0b0h,033h	; 92bf  .U.3...U.3...U.3
	defb 0b0h,011h,0b0h,055h,0a0h,033h,0a0h,011h,0ffh,023h,003h,014h,0f0h,015h,0f0h,010h	; 92cf  ...U.3...#......
	defb 0e0h,02ah,01dh,0e0h,020h,022h,001h,000h,000h,023h,003h,01fh,0d0h,010h,01eh,0d0h	; 92df  .*.. "...#......
	defb 00ah,01fh,0d0h,025h,01dh,0d0h,01ah,022h,001h,000h,000h,021h,003h,014h,050h,000h	; 92ef  ...%..."...!..P.
	defb 01fh,060h,000h,01eh,0a0h,000h,01fh,0a0h,000h,01eh,0b0h,000h,01fh,0b0h,000h,01eh	; 92ff  .`..............
	defb 090h,000h,01fh,090h,000h,01dh,090h,000h,080h,000h,0ffh,02ah,005h,000h,027h,0c0h	; 930f  ...........*..'.
	defb 010h,022h,001h,0c2h,059h,0d2h,0bdh,0e3h,03dh,02ah,005h,000h,027h,0c0h,010h,022h	; 931f  ."..Y...=*..'.."
	defb 001h,0f2h,0b6h,0f3h,09eh,0f4h,0e9h,02ah,005h,000h,027h,0c0h,010h,022h,001h,0f2h	; 932f  .......*..'.."..
	defb 0e9h,0f3h,0ceh,0f5h,034h,02ah,005h,000h,027h,0c0h,010h,022h,001h,0e2h,0b6h,0f3h	; 933f  ....4*..'.."....
	defb 09eh,0e4h,0e9h,02ah,005h,000h,027h,0c0h,010h,022h,001h,0f2h,0e9h,0e3h,0ceh,0d5h	; 934f  ...*..'.."......
	defb 034h,02ah,005h,000h,027h,0c0h,010h,022h,001h,0e2h,0b6h,0d3h,09eh,0c4h,0e9h,02ah	; 935f  4*..'..".......*
	defb 005h,000h,027h,0c0h,010h,022h,001h,0c2h,0e9h,0c3h,0ceh,0b5h,034h,02ah,005h,000h	; 936f  ..'.."......4*..
	defb 027h,0c0h,010h,022h,001h,0b2h,0b6h,0a3h,09eh,094h,0e9h,02ah,005h,000h,027h,0c0h	; 937f  '..".......*..'.
	defb 010h,022h,001h,0a2h,0e9h,0a3h,0ceh,095h,034h,02ah,005h,000h,027h,0c0h,010h,0ffh	; 938f  ."......4*..'...
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
	defb 00fh,0a0h,009h,0ffh,0d1h,0fdh,088h,0e1h,004h,074h,044h,074h,0fdh,023h,0e0h,009h	; 945f  .........tDt.#..
	defb 0ffh,022h,004h,0f0h,048h,0e0h,056h,0f0h,048h,0f0h,056h,0e0h,048h,0e0h,056h,0d0h	; 946f  ."..H.V.H.V.H.V.
	defb 048h,0d0h,056h,0c0h,056h,0b0h,056h,0a0h,056h,080h,056h,0ffh,022h,001h,0f0h,07fh	; 947f  H.V.V.V.V.V."...
	defb 0a0h,07fh,0e0h,07fh,022h,02dh,000h,000h,0feh,0feh,08bh,094h,0e7h,0d7h,0fch,051h	; 948f  ...."-.........Q
	defb 0e1h,0edh,023h,0a8h,0e1h,006h,0edh,023h,0a8h,006h,0fch,080h,0e1h,0c1h,022h,092h	; 949f  ..#....#......".
	defb 080h,090h,080h,054h,0c1h,050h,020h,0fah,040h,050h,020h,0fch,080h,050h,020h,0fah	; 94af  ...T.P .@P ..P .
	defb 040h,050h,0fdh,080h,050h,020h,0fah,040h,050h,020h,0fch,080h,050h,020h,0fah,040h	; 94bf  @P..P .@P ..P .@
	defb 050h,0feh,002h,0a9h,094h,0fch,040h,0e1h,0edh,033h,0a8h,012h,042h,0a1h,092h,020h	; 94cf  P.....@..3..B..
	defb 0c3h,0edh,033h,0a8h,042h,072h,0a1h,092h,0b2h,0e0h,011h,0fch,030h,0edh,03ah,0a8h	; 94df  ..3.Br......0.:.
	defb 000h,0c0h,000h,0c0h,040h,072h,0edh,03ah,0a8h,000h,0c2h,0e3h,090h,0e2h,002h,0eah	; 94ef  ....@r.:........
	defb 09bh,094h,0e9h,0d7h,0edh,039h,0a9h,0e3h,0a3h,000h,000h,0e2h,000h,0e3h,000h,000h	; 94ff  .....9..........
	defb 000h,000h,000h,0feh,002h,001h,095h,0edh,039h,0a9h,0e3h,0a0h,0e4h,0a1h,0a0h,0c0h	; 950f  ........9.......
	defb 0a0h,0e3h,0a1h,0a1h,0a1h,0feh,002h,016h,095h,0fdh,051h,0e3h,011h,010h,0fbh,071h	; 951f  ..........Q....q
	defb 0e2h,0a2h,0e1h,011h,0fdh,051h,0e3h,021h,020h,0fbh,071h,0e2h,092h,051h,0fdh,051h	; 952f  .....Q.! .q..Q.Q
	defb 0e3h,041h,040h,0fbh,071h,0e2h,0a2h,0e1h,011h,0fdh,051h,0e3h,021h,020h,0fbh,071h	; 953f  .A@.q.....Q.! .q
	defb 0e2h,090h,0fdh,051h,0e3h,0c3h,011h,010h,0fbh,071h,0e2h,0a2h,0e1h,011h,0fdh,051h	; 954f  ...Q.....q.....Q
	defb 0e3h,021h,020h,0fbh,071h,0e2h,092h,051h,0fdh,051h,0e3h,041h,040h,0fbh,071h,0e2h	; 955f  .! .q..Q.Q.A@.q.
	defb 0a2h,0e1h,011h,0fdh,051h,0e3h,091h,090h,0fbh,071h,0e1h,042h,071h,0edh,04ah,0a8h	; 956f  ....Q....q.Bq.J.
	defb 0fdh,052h,0e3h,001h,001h,0fch,02bh,0e2h,000h,042h,0edh,04ah,0a8h,0fdh,052h,0e3h	; 957f  .R....+..B.J..R.
	defb 000h,0c2h,0e4h,090h,0e3h,002h,0eah,001h,095h,0e9h,0d7h,0fbh,051h,0e2h,090h,090h	; 958f  ............Q...
	defb 0c0h,070h,0e8h,010h,0e9h,0e2h,075h,0c0h,0e8h,010h,0e9h,0e2h,020h,000h,000h,022h	; 959f  .p....u..... .."
	defb 0e3h,0a0h,0e8h,010h,000h,0e9h,0e2h,021h,000h,072h,0e8h,010h,030h,030h,030h,0feh	; 95af  .......!.r..000.
	defb 002h,098h,095h,001h,0e9h,0fbh,051h,0e2h,091h,0e8h,010h,0e9h,0fbh,041h,0e1h,022h	; 95bf  ......Q......A."
	defb 010h,020h,010h,000h,0e8h,010h,0e9h,0fbh,026h,0e2h,020h,020h,020h,0e8h,001h,000h	; 95cf  . ......&.   ...
	defb 000h,010h,0edh,05fh,0a8h,030h,000h,030h,030h,030h,0feh,002h,0c2h,095h,0e9h,0fch	; 95df  ..._.0.000......
	defb 030h,0e2h,0a2h,0e1h,010h,0edh,033h,0a9h,0e9h,0fch,040h,022h,0e2h,090h,0edh,033h	; 95ef  0.....3...@"...3
	defb 0a9h,0e9h,0a2h,0e1h,010h,0edh,033h,0a9h,0e9h,022h,0e2h,090h,0e8h,000h,000h,021h	; 95ff  ......3..".....!
	defb 0e9h,0a2h,0e1h,010h,0edh,033h,0a9h,0e9h,022h,0e2h,090h,0edh,033h,0a9h,0e9h,0a2h	; 960f  .....3.."...3...
	defb 0e1h,010h,0edh,033h,0a9h,0e9h,012h,040h,0e8h,010h,030h,030h,030h,0e9h,090h,090h	; 961f  ...3...@..000...
	defb 0e2h,090h,094h,0e8h,021h,0edh,05fh,0a8h,0e9h,0fch,02ah,0e3h,051h,051h,0edh,04dh	; 962f  ....!._...*.QQ.M
	defb 0a9h,0e9h,071h,071h,0edh,04dh,0a9h,0e9h,0fch,040h,0e1h,090h,090h,0e2h,090h,094h	; 963f  ..qq.M...@......
	defb 0e8h,021h,0edh,05fh,0a8h,0e9h,0fch,02ah,0e3h,051h,051h,0edh,04dh,0a9h,0e9h,070h	; 964f  .!._...*.QQ.M..p
	defb 0e8h,000h,000h,000h,0e9h,040h,072h,0eah,098h,095h,0e9h,0e7h,0d8h,0fdh,071h,0e3h	; 965f  .....@r.......q.
	defb 021h,091h,0e2h,021h,0e3h,090h,0e2h,001h,0e3h,070h,0b2h,0e4h,090h,0e3h,000h,020h	; 966f  !..!.....p.....
	defb 0feh,002h,069h,096h,0fdh,071h,0e4h,021h,021h,050h,090h,0c3h,021h,070h,0b2h,021h	; 967f  ..i..q.!!P..!p.!
	defb 021h,050h,092h,0fdh,043h,0e4h,0c3h,090h,0e3h,002h,0feh,002h,083h,096h,0fah,000h	; 968f  !P..C...........
	defb 0e1h,022h,09ch,080h,090h,080h,05ch,0feh,002h,09dh,096h,0fch,041h,0edh,06bh,0a9h	; 969f  ."....\.....A.k.
	defb 052h,02ch,0feh,002h,0aah,096h,0d8h,0fch,041h,0e1h,0c1h,020h,020h,0c0h,022h,011h	; 96af  R,......A..  .".
	defb 0c5h,0feh,002h,0b8h,096h,0eah,083h,096h,0e9h,0d8h,0f8h,000h,0e1h,020h,0f9h,000h	; 96bf  ............. ..
	defb 020h,0fah,000h,021h,0fbh,000h,026h,0fah,000h,020h,0f9h,000h,020h,0fbh,031h,0e3h	; 96cf   ..!..&.. .. .1.
	defb 090h,0e2h,000h,020h,0feh,002h,0c7h,096h,0fdh,071h,0edh,053h,0a9h,0c7h,0edh,053h	; 96df  ... .....q.S...S
	defb 0a9h,0c3h,0fbh,043h,090h,0e2h,002h,0fdh,051h,0e3h,021h,021h,050h,090h,0d6h,0fah	; 96ef  ...C....Q.!!P...
	defb 000h,0e2h,020h,050h,090h,0d5h,0f8h,000h,020h,050h,0d4h,0f7h,000h,090h,0d8h,0fdh	; 96ff  .. P.... P......
	defb 041h,0e3h,021h,050h,092h,0e4h,0a1h,0a1h,0e3h,020h,050h,0d6h,0fah,000h,0e3h,0a0h	; 970f  A.!P..... P.....
	defb 0e2h,020h,050h,0d5h,0f8h,000h,0e3h,0a0h,0e2h,020h,0d4h,0f7h,000h,050h,0d8h,0fdh	; 971f  . P...... ...P..
	defb 041h,0e4h,0a1h,0e3h,020h,052h,0feh,002h,0f8h,096h,0fch,030h,0e4h,090h,0e3h,090h	; 972f  A... R.....0....
	defb 0feh,008h,03bh,097h,0edh,061h,0a9h,0feh,002h,043h,097h,0e4h,090h,0e3h,090h,0feh	; 973f  ..;..a...C......
	defb 008h,04ah,097h,0edh,061h,0a9h,0feh,002h,052h,097h,0fdh,041h,0e4h,080h,080h,0e3h	; 974f  .J..a...R..A....
	defb 080h,0e4h,080h,0c0h,082h,091h,0c5h,0feh,002h,05bh,097h,0eah,0e7h,096h,0e9h,0d8h	; 975f  .........[......
	defb 0fah,010h,0e3h,02ch,0e8h,000h,000h,000h,0feh,002h,06dh,097h,0e9h,0fch,085h,0e2h	; 976f  ...,......m.....
	defb 0edh,0c2h,0a8h,000h,0e9h,021h,070h,0b2h,0edh,0c2h,0a8h,0edh,05fh,0a8h,000h,0feh	; 977f  .....!p....._...
	defb 002h,07bh,097h,0e9h,0f9h,000h,0e2h,092h,0e1h,026h,011h,001h,0e2h,0b1h,0e1h,020h	; 978f  .{.......&.....
	defb 040h,020h,0e2h,0ach,0feh,002h,092h,097h,0e9h,0d8h,0fch,041h,0edh,06bh,0a9h,0e8h	; 979f  @ .........A.k..
	defb 000h,000h,000h,010h,000h,0edh,033h,0a9h,000h,000h,010h,000h,010h,000h,000h,0feh	; 97af  ......3.........
	defb 002h,0a7h,097h,0e8h,000h,000h,0e9h,0e2h,0b0h,0b0h,0e8h,010h,0e9h,0b2h,0edh,033h	; 97bf  ...............3
	defb 0a9h,000h,000h,021h,0feh,002h,0c2h,097h,0eah,07bh,097h,0e7h,0e9h,0d5h,0fch,041h	; 97cf  ...!.....{.....A
	defb 0e1h,0c3h,041h,0c3h,031h,0c3h,021h,0c3h,015h,0e2h,001h,021h,0feh,004h,0dah,097h	; 97df  ..A.1.!....!....
	defb 0e9h,0d5h,0fch,025h,0edh,066h,0a8h,0fbh,000h,003h,0fch,000h,005h,0fch,025h,0edh	; 97ef  ...%.f........%.
	defb 066h,0a8h,0fbh,000h,001h,0fch,050h,053h,043h,0e9h,0d5h,0fbh,022h,0e1h,041h,0edh	; 97ff  f.....PSC...".A.
	defb 0d4h,0a8h,0e9h,0e1h,042h,0c0h,0edh,0d4h,0a8h,041h,0e9h,021h,0edh,0cbh,0a8h,0e9h	; 980f  ....B....A.!....
	defb 0e2h,022h,0c0h,0edh,0cbh,0a8h,041h,0feh,002h,008h,098h,0e9h,0fch,026h,0e2h,055h	; 981f  ."....A......&.U
	defb 075h,0f9h,000h,091h,0fah,000h,091h,0fbh,000h,093h,0ech,053h,073h,093h,0e9h,0fch	; 982f  u..........Ss...
	defb 026h,0e2h,045h,055h,0f9h,000h,071h,0fah,000h,071h,0fbh,000h,073h,0ech,043h,053h	; 983f  &.EU..q..q..s.CS
	defb 073h,0e9h,0fch,026h,0e2h,025h,045h,0f9h,000h,051h,0fah,000h,051h,0fbh,000h,053h	; 984f  s..&.%E..Q..Q..S
	defb 0ech,023h,043h,053h,0e9h,0fch,026h,015h,025h,0f9h,000h,043h,0fah,000h,043h,0fbh	; 985f  .#CS..&.%..C..C.
	defb 000h,043h,0fch,000h,043h,0fch,025h,0e4h,0b1h,0e3h,011h,0feh,002h,02ah,098h,0e2h	; 986f  .C..C.%......*..
	defb 045h,055h,0f9h,000h,073h,0fah,000h,073h,0fbh,000h,073h,0fch,000h,075h,0c1h,0eah	; 987f  EU..s..s..s..u..
	defb 0efh,097h,0e9h,0d5h,0fch,026h,0e4h,090h,090h,091h,0e1h,001h,0e4h,091h,091h,0e2h	; 988f  .....&..........
	defb 0b1h,0e3h,091h,0e4h,091h,0e2h,0a1h,0e4h,091h,0c1h,0e2h,091h,0e4h,091h,091h,0e3h	; 989f  ................
	defb 001h,021h,0feh,002h,091h,098h,0edh,078h,0a9h,0e1h,001h,0edh,078h,0a9h,0e2h,0b1h	; 98af  .!.....x....x...
	defb 0edh,078h,0a9h,0e2h,0a1h,0edh,078h,0a9h,0e2h,091h,0edh,078h,0a9h,0e3h,001h,021h	; 98bf  .x....x....x...!
	defb 0feh,002h,0b5h,098h,0e9h,0edh,087h,0a8h,0e3h,001h,001h,011h,011h,0edh,087h,0a8h	; 98cf  ................
	defb 0fbh,026h,0e3h,023h,003h,0e9h,0d5h,0fch,025h,0e3h,0edh,0ach,0a8h,0edh,0ach,0a8h	; 98df  .&.#....%.......
	defb 0edh,0b7h,0a8h,0edh,0b7h,0a8h,0feh,002h,0e4h,098h,0e9h,0fch,025h,0e3h,020h,020h	; 98ef  ............%.
	defb 0edh,07dh,0a9h,0edh,07dh,0a9h,021h,000h,000h,0edh,085h,0a9h,0edh,085h,0a9h,001h	; 98ff  .}..}.!.........
	defb 0e4h,0edh,08dh,0a9h,0edh,08dh,0a9h,0edh,096h,0a9h,0edh,096h,0a9h,0e8h,040h,0e9h	; 990f  ..............@.
	defb 090h,091h,091h,091h,0c3h,0feh,002h,0f9h,098h,0e9h,0e4h,0edh,096h,0a9h,0edh,096h	; 991f  ................
	defb 0a9h,0e8h,040h,0e9h,090h,091h,091h,091h,0b1h,0e3h,011h,0eah,0d3h,098h,0d5h,0e8h	; 992f  ..@.............
	defb 001h,001h,010h,000h,001h,0feh,008h,03fh,099h,000h,000h,001h,010h,000h,001h,0feh	; 993f  .......?........
	defb 008h,048h,099h,0e9h,0d5h,0fah,024h,0e2h,021h,021h,0e8h,031h,0e9h,021h,021h,0e3h	; 994f  .H....$.!!.1.!!.
	defb 091h,0e8h,031h,0e9h,051h,0c1h,0e2h,021h,0e8h,031h,0e9h,021h,0e3h,091h,0e2h,021h	; 995f  ..1.Q..!.1.!...!
	defb 0e8h,031h,0e9h,051h,0e3h,0a1h,0e2h,021h,0e8h,031h,0e9h,0c3h,0e3h,0a1h,0e8h,031h	; 996f  .1.Q...!.1.....1
	defb 0e9h,0f8h,000h,0e2h,055h,0e8h,031h,001h,001h,001h,030h,030h,030h,030h,0feh,002h	; 997f  ....U.1...0000..
	defb 052h,099h,0e9h,0d5h,0f9h,011h,0e1h,041h,001h,0e2h,071h,0e1h,001h,0e2h,071h,043h	; 998f  R......A..q...qC
	defb 0e1h,043h,001h,0e2h,071h,0e1h,001h,0e2h,071h,041h,0e8h,010h,010h,011h,0e9h,021h	; 999f  .C..q...qA.....!
	defb 051h,091h,051h,091h,0e1h,023h,0e2h,023h,0e2h,051h,091h,051h,091h,0e1h,021h,0e8h	; 99af  Q.Q..#.#.Q.Q..!.
	defb 010h,010h,011h,0feh,002h,091h,099h,0e9h,0d5h,0fbh,026h,0e2h,023h,0e8h,031h,0e9h	; 99bf  ..........&.#.1.
	defb 045h,0e8h,031h,0e9h,0f8h,000h,051h,0f9h,000h,053h,0e8h,031h,0ech,053h,071h,0e8h	; 99cf  E.1...Q..S.1.Sq.
	defb 031h,0ech,091h,0e9h,0fbh,026h,0e2h,003h,0e8h,031h,0e9h,025h,0e8h,031h,0e9h,0f8h	; 99df  1....&...1.%.1..
	defb 000h,041h,0f9h,000h,043h,0e8h,031h,0ech,043h,051h,0e8h,031h,0ech,071h,0e9h,0fbh	; 99ef  .A..C.1.CQ.1.q..
	defb 026h,0e3h,0a3h,0e8h,031h,0e9h,0e2h,005h,0e8h,031h,0e9h,0f8h,000h,021h,0f9h,000h	; 99ff  &...1....1...!..
	defb 023h,0e8h,031h,0ech,023h,041h,0e8h,031h,0ech,051h,0e9h,0fbh,026h,0e3h,093h,0e8h	; 9a0f  #.1.#A.1.Q..&...
	defb 031h,0e9h,0fbh,027h,0b5h,0e8h,031h,0e9h,0f8h,000h,0e2h,011h,0f9h,000h,013h,0e8h	; 9a1f  1..'..1.........
	defb 033h,031h,031h,0e8h,030h,030h,031h,0feh,002h,0c6h,099h,0e9h,0fbh,026h,0e2h,013h	; 9a2f  311.001......&..
	defb 0e8h,031h,0e9h,025h,0e8h,031h,0e9h,0f8h,000h,041h,0f9h,000h,043h,0e8h,033h,031h	; 9a3f  .1.%.1...A..C.31
	defb 031h,0e8h,030h,030h,030h,030h,0eah,052h,099h,0e9h,0e7h,0d6h,0fch,090h,0fdh,090h	; 9a4f  1.0000.R........
	defb 0e1h,021h,021h,071h,021h,071h,021h,0fdh,051h,050h,072h,0feh,004h,05dh,09ah,0fch	; 9a5f  .!!q!q!.QPr..]..
	defb 042h,0e2h,075h,0a7h,090h,0a0h,0e1h,005h,0e2h,0a5h,093h,0a5h,079h,0fbh,021h,022h	; 9a6f  B.u.........y.!"
	defb 092h,0e1h,029h,0feh,002h,06eh,09ah,0fch,031h,0e1h,072h,022h,0f8h,022h,072h,022h	; 9a7f  ..)..n..1.r"."r"
	defb 0fch,031h,071h,021h,0feh,004h,089h,09ah,0fch,032h,0e2h,072h,092h,0a1h,092h,0a2h	; 9a8f  .1q!.....2.r....
	defb 0e1h,001h,0e2h,0a2h,0e1h,002h,021h,002h,022h,031h,02fh,0f8h,000h,0c1h,021h,011h	; 9a9f  ......!."1/...!.
	defb 001h,0e2h,0b1h,0a1h,091h,081h,0eah,058h,09ah,0e9h,0d6h,0fdh,02ah,0e4h,071h,071h	; 9aaf  .......X....*.qq
	defb 071h,071h,051h,051h,051h,051h,031h,031h,031h,031h,051h,051h,051h,051h,0feh,002h	; 9abf  qqQQQQ1111QQQQ..
	defb 0b8h,09ah,0d6h,0fch,042h,0edh,09ch,0a9h,0edh,09ch,0a9h,030h,030h,0c0h,030h,030h	; 9acf  ....B......00.00
	defb 0c0h,0e2h,023h,0e4h,090h,0a0h,0e2h,011h,0e3h,071h,020h,020h,0c0h,020h,020h,0c0h	; 9adf  ..#......q  .  .
	defb 0c3h,000h,020h,051h,091h,0feh,002h,0d4h,09ah,0fch,028h,0e3h,071h,070h,070h,0feh	; 9aef  .. Q......(.qpp.
	defb 002h,0fbh,09ah,051h,050h,050h,0feh,002h,002h,09bh,041h,040h,040h,0feh,002h,009h	; 9aff  ...QPP....A@@...
	defb 09bh,031h,030h,030h,0feh,002h,010h,09bh,0e4h,071h,0e3h,070h,070h,0feh,002h,017h	; 9b0f  .100.....q.pp...
	defb 09bh,0e4h,051h,0e3h,050h,050h,0feh,002h,020h,09bh,0e4h,041h,0e3h,040h,040h,0feh	; 9b1f  ..Q.PP.. ..A.@@.
	defb 002h,029h,09bh,0e4h,031h,0e3h,030h,030h,0e4h,021h,0e3h,020h,020h,0edh,0abh,0a9h	; 9b2f  .)..1.00.!.  ...
	defb 052h,071h,0edh,0abh,0a9h,072h,091h,0edh,0abh,0a9h,092h,0a1h,0edh,0abh,0a9h,0a2h	; 9b3f  Rq...r..........
	defb 0e1h,001h,0fch,026h,0e3h,021h,020h,020h,0feh,004h,054h,09bh,021h,0fah,010h,0e2h	; 9b4f  ...&.!  ..T.!...
	defb 021h,011h,001h,0e3h,0b1h,0a1h,091h,081h,0eah,0b8h,09ah,0e9h,0d6h,0fbh,071h,0e2h	; 9b5f  !.............q.
	defb 071h,0e8h,001h,0feh,010h,06ah,09bh,0e9h,0d6h,0fch,042h,0e2h,023h,0e8h,010h,000h	; 9b6f  q....j....B.#...
	defb 0e9h,0e2h,0c5h,0e8h,010h,000h,0e9h,0e2h,050h,070h,093h,0e8h,010h,000h,0e9h,0e2h	; 9b7f  ........Pp......
	defb 0c5h,0e8h,010h,000h,0e9h,0fah,011h,0e2h,050h,040h,033h,0e8h,010h,000h,0e9h,0fch	; 9b8f  ........P@3.....
	defb 042h,0e2h,0c5h,0e8h,010h,000h,0e9h,0fch,042h,0e2h,0c1h,0fah,021h,0c0h,022h,090h	; 9b9f  B.......B...!.".
	defb 0e8h,010h,000h,0e9h,0fch,042h,0e1h,024h,0e8h,000h,000h,011h,0feh,002h,076h,09bh	; 9baf  .....B.$......v.
	defb 0e9h,0d6h,0fbh,031h,0e1h,0c0h,072h,0e8h,010h,000h,0e9h,0e1h,020h,0f8h,022h,072h	; 9bbf  ...1..r..... ."r
	defb 021h,0e8h,010h,000h,0e9h,021h,0feh,004h,0bfh,09bh,0fbh,032h,0e2h,032h,0e3h,030h	; 9bcf  !....!.....2.2.0
	defb 0e8h,000h,000h,011h,0e9h,0e2h,052h,0e3h,030h,0e8h,000h,000h,011h,0e9h,0e2h,072h	; 9bdf  ......R.0......r
	defb 0e3h,030h,0e8h,000h,000h,011h,0e9h,0e2h,092h,0e3h,030h,0e8h,000h,000h,011h,0e9h	; 9bef  .0........0.....
	defb 0e2h,09fh,0e8h,001h,000h,000h,001h,000h,000h,001h,000h,000h,0e9h,0fch,032h,0e3h	; 9bff  ..............2.
	defb 020h,0e4h,022h,0eah,06ah,09bh,0e9h,0e7h,0d7h,0fch,065h,0e2h,001h,001h,0fdh,067h	; 9c0f   .".j.....e....g
	defb 001h,0fch,065h,001h,001h,0e3h,070h,070h,0c0h,0fdh,067h,081h,0fch,065h,0b0h,0e2h	; 9c1f  ..e...pp..g..e..
	defb 000h,000h,001h,0fdh,067h,001h,0fch,065h,001h,001h,0e3h,070h,070h,0c0h,0fdh,067h	; 9c2f  ....g..e...pp..g
	defb 081h,0fch,064h,0b0h,0e9h,0fbh,024h,0e1h,00dh,0d1h,0f9h,000h,001h,021h,031h,051h	; 9c3f  ..d...$......!1Q
	defb 071h,081h,0b1h,0d7h,0fch,024h,0e0h,00fh,0edh,0d8h,0a9h,0edh,0d8h,0a9h,0fdh,045h	; 9c4f  q....$.........E
	defb 0e2h,072h,0b1h,0c0h,0f8h,000h,0e1h,023h,0f9h,000h,021h,0fah,000h,021h,0fbh,022h	; 9c5f  .r.....#..!..!."
	defb 0c1h,0fch,045h,022h,051h,0c0h,0f8h,000h,071h,0f9h,000h,071h,0fah,000h,070h,0fbh	; 9c6f  ..E"Q...q..q..p.
	defb 000h,070h,0c0h,0fch,021h,0e1h,070h,090h,0b0h,0fah,010h,0edh,00dh,0aah,0fbh,010h	; 9c7f  .p..!.p.........
	defb 0edh,00dh,0aah,0fch,010h,0edh,00dh,0aah,0c0h,0fch,024h,020h,030h,050h,071h,050h	; 9c8f  ..........$ 0PqP
	defb 070h,0c0h,070h,0c0h,070h,071h,0b1h,0feh,002h,088h,09ch,0fdh,044h,0e1h,030h,020h	; 9c9f  p.p.pq......D.0
	defb 030h,020h,031h,000h,032h,001h,021h,001h,0feh,002h,0aah,09ch,032h,002h,031h,052h	; 9caf  0 1.2.!.....2.1R
	defb 022h,051h,072h,052h,071h,0a2h,082h,0a1h,0e0h,00fh,0fch,064h,0e2h,000h,000h,001h	; 9cbf  "QrRq......d....
	defb 001h,001h,001h,0e3h,070h,070h,0c0h,081h,0b0h,0eah,043h,09ch,0e9h,0d7h,0fch,064h	; 9ccf  ....pp....C....d
	defb 0e3h,001h,001h,0fdh,067h,001h,0fch,064h,001h,001h,0e4h,070h,070h,0fdh,067h,070h	; 9cdf  ....g..d...pp.gp
	defb 081h,0fch,064h,0b0h,0e3h,000h,000h,001h,0fdh,067h,001h,0fch,064h,001h,001h,0e4h	; 9cef  ..d......g..d...
	defb 070h,070h,0fdh,067h,070h,081h,0fch,064h,0b0h,0e9h,0d7h,0fdh,064h,0e3h,001h,001h	; 9cff  pp.gp..d....d...
	defb 001h,001h,001h,0e4h,070h,071h,081h,0b0h,0e3h,000h,000h,001h,001h,001h,001h,0e4h	; 9d0f  ....pq..........
	defb 070h,071h,081h,0b0h,0edh,021h,0aah,0edh,021h,0aah,0e9h,0fdh,065h,0e4h,071h,070h	; 9d1f  pq...!..!...e.qp
	defb 070h,071h,070h,070h,071h,070h,070h,0b1h,0e3h,021h,0e4h,071h,070h,070h,071h,070h	; 9d2f  pqppqpp..!.qppqp
	defb 070h,071h,070h,070h,0b1h,0e3h,021h,0fdh,065h,0e3h,001h,0e2h,000h,000h,0e3h,001h	; 9d3f  pqpp..!.e.......
	defb 0e2h,001h,0e3h,001h,0e2h,000h,000h,0e3h,000h,000h,0e2h,000h,000h,0e4h,0a1h,0e3h	; 9d4f  ................
	defb 0a0h,0a0h,0e4h,0a1h,0e3h,0a1h,0e4h,0a1h,0e3h,0a0h,0a0h,0e4h,0a0h,0a0h,0e3h,0a0h	; 9d5f  ................
	defb 0a0h,0e4h,081h,0e3h,080h,080h,0e4h,081h,0e3h,081h,0e4h,081h,0e3h,080h,080h,0e4h	; 9d6f  ................
	defb 080h,080h,0e3h,080h,080h,0e4h,071h,0e3h,070h,070h,0e4h,071h,0e3h,071h,0e4h,071h	; 9d7f  ......q.pp.q.q.q
	defb 0e3h,070h,070h,0e4h,070h,070h,0e3h,070h,070h,0feh,002h,046h,09dh,0fdh,065h,0e3h	; 9d8f  .pp.pp.pp..F..e.
	defb 000h,000h,001h,001h,001h,001h,001h,001h,0e4h,0a1h,080h,080h,081h,081h,081h,081h	; 9d9f  ................
	defb 081h,071h,071h,051h,0e3h,050h,050h,0e4h,051h,0e3h,050h,050h,0e4h,071h,0e3h,070h	; 9daf  .qqQ.PP.Q.PP.q.p
	defb 070h,0e4h,071h,0e3h,070h,070h,0e4h,081h,0e3h,080h,080h,0e4h,081h,0e3h,080h,080h	; 9dbf  p.q.pp..........
	defb 0e4h,0a1h,0e3h,0a0h,0a0h,0e4h,0a1h,0e3h,0a0h,0a0h,0fdh,065h,001h,001h,001h,001h	; 9dcf  ...........e....
	defb 001h,0e4h,070h,070h,0c0h,081h,0b0h,0fch,064h,0e3h,000h,000h,001h,001h,001h,001h	; 9ddf  ..pp....d.......
	defb 0e4h,070h,070h,0c0h,081h,0b0h,0eah,008h,09dh,0e9h,0d7h,0fch,065h,0e4h,001h,001h	; 9def  .pp.........e...
	defb 001h,001h,001h,0e5h,070h,070h,070h,081h,0b0h,0e4h,000h,000h,001h,001h,001h,001h	; 9dff  ....ppp.........
	defb 0e5h,070h,070h,070h,081h,0b0h,0e9h,0d7h,0f8h,000h,0e2h,07dh,0d1h,0f7h,000h,071h	; 9e0f  .ppp.......}...q
	defb 091h,0b1h,0e1h,001h,021h,041h,051h,0d7h,0fah,024h,0e1h,07fh,0edh,059h,0aah,0edh	; 9e1f  ....!AQ..$...Y..
	defb 059h,0aah,0fbh,045h,0e2h,022h,071h,0c0h,0f7h,000h,077h,0c1h,0fbh,045h,072h,0e1h	; 9e2f  Y..E."q...w..Er.
	defb 021h,0c0h,0f7h,000h,021h,0f8h,000h,021h,0f9h,000h,020h,0fah,000h,020h,0fbh,014h	; 9e3f  !...!..!.. .. ..
	defb 0e1h,0c0h,020h,020h,020h,0d1h,0f7h,000h,0e0h,0c0h,0d7h,0f7h,011h,0edh,093h,0aah	; 9e4f  ..   ...........
	defb 0d7h,0f8h,011h,0edh,093h,0aah,0d7h,0f9h,011h,0edh,093h,0aah,0d1h,0f7h,000h,0e0h	; 9e5f  ................
	defb 0c5h,0d7h,0fah,024h,0e2h,070h,0b0h,0b0h,0e1h,021h,020h,020h,0c0h,020h,0c0h,020h	; 9e6f  ...$.p...!  . .
	defb 021h,021h,0feh,002h,054h,09eh,0d7h,0fah,043h,0e1h,000h,0e2h,0b0h,0e1h,000h,0e2h	; 9e7f  !!..T...C.......
	defb 0b0h,0e1h,001h,0e2h,070h,0e1h,002h,0e2h,071h,0b1h,071h,0e1h,000h,0e2h,080h,0e1h	; 9e8f  ....p...q.q.....
	defb 000h,0e2h,080h,0e1h,001h,0e2h,080h,0e1h,002h,0e2h,081h,0b1h,0e2h,071h,082h,052h	; 9e9f  .............q.R
	defb 081h,0a2h,072h,0a1h,0e1h,002h,0e2h,082h,0e1h,001h,022h,022h,021h,07fh,0cfh,0eah	; 9eaf  ..r.......""!...
	defb 015h,09eh,0e7h,0e9h,0d6h,0fbh,034h,0e4h,0cfh,001h,011h,0feh,004h,0c8h,09eh,0fch	; 9ebf  ......4.........
	defb 034h,0e2h,001h,011h,0feh,004h,0d1h,09eh,0fdh,034h,001h,011h,0feh,004h,0d9h,09eh	; 9ecf  4........4......
	defb 0e9h,0fch,024h,0e2h,043h,0c1h,01fh,0c9h,003h,0c1h,013h,0c1h,045h,015h,073h,063h	; 9edf  ..$.C.......E.sc
	defb 0fch,034h,0e2h,005h,015h,045h,015h,001h,0c1h,011h,0c1h,045h,065h,075h,065h,071h	; 9eef  .4...E.....Eeueq
	defb 0c1h,0b1h,0c1h,0a5h,095h,0e1h,005h,01bh,0c1h,0e2h,0edh,0b4h,0a9h,043h,041h,0e1h	; 9eff  .............CA.
	defb 0edh,0b4h,0a9h,041h,0e8h,041h,0e9h,0fch,023h,041h,0fdh,023h,0e1h,041h,0f9h,021h	; 9f0f  ...A.A..#A.#.A.!
	defb 040h,040h,0fdh,023h,01bh,0e2h,0f8h,021h,040h,040h,0f8h,000h,080h,0f9h,000h,080h	; 9f1f  @@.#...!@@......
	defb 0fah,000h,080h,0fbh,000h,080h,0fbh,020h,080h,080h,0c1h,0fdh,023h,0e1h,011h,033h	; 9f2f  ....... ....#..3
	defb 041h,0f9h,021h,040h,040h,0fdh,023h,01bh,0e2h,042h,0fch,021h,010h,010h,0c0h,0f7h	; 9f3f  A.!@@.#..B.!....
	defb 000h,071h,0f8h,000h,070h,0f9h,000h,070h,0fah,000h,070h,0fbh,000h,070h,0fch,000h	; 9f4f  .q..p..p..p..p..
	defb 071h,0fbh,020h,070h,070h,0fdh,023h,0e1h,0c1h,011h,031h,041h,0f9h,021h,040h,040h	; 9f5f  q. pp.#...1A.!@@
	defb 0fdh,023h,015h,0c1h,061h,081h,091h,0f9h,021h,090h,090h,0fdh,023h,065h,08fh,0fdh	; 9f6f  .#..a...!...#e..
	defb 023h,0e3h,081h,0e2h,0edh,0dfh,0a8h,0eah,0dfh,09eh,0e9h,0d6h,0fdh,034h,0e3h,001h	; 9f7f  #............4..
	defb 011h,0feh,008h,08eh,09fh,0fdh,034h,001h,011h,0feh,008h,096h,09fh,0e9h,0fdh,020h	; 9f8f  ......4........
	defb 001h,0c1h,011h,0c1h,0feh,003h,09ch,09fh,001h,0c1h,011h,0e8h,040h,040h,0e9h,001h	; 9f9f  ............@@..
	defb 0c1h,011h,0c1h,001h,0c1h,011h,0e8h,040h,040h,0feh,002h,0adh,09fh,0e9h,0fdh,024h	; 9faf  .......@@......$
	defb 0e3h,001h,011h,0feh,018h,0c0h,09fh,043h,0e8h,042h,042h,0e9h,041h,0e8h,041h,0e9h	; 9fbf  .......C.BB.A.A.
	defb 040h,0e8h,040h,0e9h,073h,0e8h,042h,042h,0e9h,071h,0e8h,041h,0e9h,070h,0e8h,040h	; 9fcf  @.@.s.BB.q.A.p.@
	defb 0e9h,0e3h,043h,0e8h,042h,042h,0e9h,041h,0e8h,041h,0e9h,040h,0e8h,040h,0e9h,073h	; 9fdf  ..C.BB.A.A.@.@.s
	defb 0e8h,042h,040h,041h,0e9h,071h,0c1h,071h,0fdh,035h,0e3h,011h,0e2h,010h,010h,0e8h	; 9fef  .B@A.q.q.5......
	defb 041h	; 9fff
