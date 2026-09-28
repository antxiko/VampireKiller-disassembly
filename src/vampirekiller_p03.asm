; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ======================================================================
; CODIGO 0xa000..0xa034  (52 bytes)
; ======================================================================


L_A000:
	ld (hl),e			;a000
	inc l			;a001
	ld (hl),d			;a002
	ld de,(0cff7h)		;a003
	inc l			;a007
	ld (hl),e			;a008
	inc l			;a009
	ld (hl),d			;a00a
	inc l			;a00b
	ld (hl),003h		;a00c
	ld a,(ix+000h)		;a00e   ; lee el tipo de la cosa
	ld de,0a0bdh		;a011
	call 06542h		;a014   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld hl,(0cff3h)		;a017   ; lee la ficha de la cosa que se crea
	set 5,l		;a01a
	ld b,(hl)			;a01c
	ld a,005h		;a01d
	add a,l			;a01f
	ld l,a			;a020
L_A021:
	ld a,(de)			;a021
	ld (hl),a			;a022
	inc de			;a023
	ld a,l			;a024
	add a,005h		;a025
	ld l,a			;a027
	djnz L_A021		;a028
	ld hl,(0cff3h)		;a02a   ; lee la ficha de la cosa que se crea
	ld a,(ix+000h)		;a02d   ; lee el tipo de la cosa
	dec a			;a030
	call 0406bh		;a031   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A034: 12 destinos del despachador de 0x406B (call en p03:A031):
;   0xA04C, 0xA04C, 0xA04C, 0xA04C, 0xA04C, 0xA04C, 0xA04D, 0xA06A ...; lo
;   leen p03:A031 (24 bytes)
;   0xa034..0xa04c  (24 bytes)
DATA_tabla_A034:
	defb 04ch,0a0h	; a034
	defb 04ch,0a0h	; a036
	defb 04ch,0a0h	; a038
	defb 04ch,0a0h	; a03a
	defb 04ch,0a0h	; a03c
	defb 04ch,0a0h	; a03e
	defb 04dh,0a0h	; a040
	defb 06ah,0a0h	; a042
	defb 07bh,0a0h	; a044
	defb 04ch,0a0h	; a046
	defb 04ch,0a0h	; a048
	defb 060h,09bh	; a04a

; ======================================================================
; CODIGO 0xa04c..0xa08f  (67 bytes)
; ======================================================================


L_A04C:
	ret			;a04c
L_A04D:
	ld (ix+010h),000h		;a04d
	ld a,(ix+003h)		;a051   ; lee la y de la cosa
	ld (ix+011h),a		;a054
	ld l,(ix+007h)		;a057   ; lee la velocidad vertical (parte baja)
	ld h,(ix+008h)		;a05a   ; lee la velocidad vertical
	ld de,00100h		;a05d
	and a			;a060
	sbc hl,de		;a061
	ld (ix+012h),l		;a063
	ld (ix+013h),h		;a066
	ret			;a069
L_A06A:
	ld (ix+006h),001h		;a06a   ; la cosa se mueve
	ld (ix+00ch),03ch		;a06e   ; la cuenta de cuadros del paso = 0x3C
	ld de,00000h		;a072
	call pon_velocidad_y		;a075   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	jp pon_velocidad_x		;a078   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_A07B:
	ld a,(ix+00ah)		;a07b   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	ld (ix+010h),a		;a07e
	ld (ix+013h),018h		;a081
	ld hl,(0cffch)		;a085
	ld (ix+011h),l		;a088
	ld (ix+012h),h		;a08b
	ret			;a08e

; ----------------------------------------------------------------------
; DATOS tablas_por_tipo: tres tablas seguidas: 0xA08F, un byte por tipo de
;   cosa que p02:9F8C lee con 0xA08E + tipo; 0xA0BF, punteros por tipo
;   (p03:A011 con DE = 0xA0BD, via 0x6542) a las cuatro listas cortas de
;   0xA0D7-0xA0E4, que se copian a los sprites de la cosa (p03:A017); los
;   mismos bytes usan p01:68EA y p03:BBFD como coordenadas de VRAM
;   0xa08f..0xa0e5  (86 bytes)
DATA_tablas_por_tipo:
	defb 001h,001h,002h,001h,001h,001h,001h,001h,001h,003h,004h,001h,001h,001h,001h,009h	; a08f  ................
	defb 005h,001h,006h,007h,001h,008h,00bh,00ah,001h,001h,001h,001h,001h,001h,001h,001h	; a09f  ................
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h	; a0af  ................
	defb 0e3h,0a0h,0e3h,0a0h,0e3h,0a0h,0d7h,0a0h,0e3h,0a0h,0d9h,0a0h,0dbh,0a0h,0dbh,0a0h	; a0bf  ................
	defb 0ddh,0a0h,0e3h,0a0h,0dfh,0a0h,0e1h,0a0h,042h,00ch,045h,002h,042h,005h,042h,005h	; a0cf  ........B.E.B.B.
	defb 048h,005h,000h,008h,000h,008h	; a0df

; ======================================================================
; CODIGO 0xa0e5..0xa1a2  (189 bytes)
; ======================================================================


L_A0E5:
	ld a,080h		;a0e5
L_A0E7:
	ld e,(ix+003h)		;a0e7   ; lee la y de la cosa
	ld d,(ix+005h)		;a0ea   ; lee la x de la cosa
L_A0ED:
	ld c,a			;a0ed
	ld a,(0d012h)		;a0ee
	add a,a			;a0f1
	add a,a			;a0f2
	add a,a			;a0f3
	add a,c			;a0f4
	ld (0cff0h),a		;a0f5   ; guarda el tipo de la cosa que se crea
	call L_A134		;a0f8
	ld a,(0cff8h)		;a0fb
	ld e,a			;a0fe
	ld d,000h		;a0ff
	ld a,e			;a101
	sub 03fh		;a102
	neg		;a104
	ld hl,0a1e2h		;a106
	push hl			;a109
	add hl,de			;a10a
	ld c,(hl)			;a10b
	pop hl			;a10c
	ld e,a			;a10d
	add hl,de			;a10e
	ld a,(hl)			;a10f
	ld (0cff7h),a		;a110
	ld e,c			;a113
	call L_A184		;a114
	ld a,(0cff1h)		;a117   ; lee la posicion de la cosa que se crea
	and a			;a11a
	call nz,niega_de		;a11b   ; niega_de: DE = -DE
	ld (0cff3h),de		;a11e   ; guarda la ficha de la cosa que se crea
	ld a,(0cff7h)		;a122
	ld e,a			;a125
	call L_A184		;a126
	ld a,(0cff2h)		;a129
	and a			;a12c
	call nz,niega_de		;a12d   ; niega_de: DE = -DE
	ld hl,(0cff3h)		;a130   ; lee la ficha de la cosa que se crea
	ret			;a133
L_A134:
	ld hl,0cff1h		;a134   ; apunta a la posicion de la cosa que se crea
	ld (hl),000h		;a137
	ld a,(0c425h)		;a139   ; lee la Y de Simon
	sub e			;a13c
	jr nc,L_A142		;a13d
	neg		;a13f
	inc (hl)			;a141
L_A142:
	inc hl			;a142
	ld (hl),000h		;a143
	rra			;a145
	rra			;a146
	and 038h		;a147
	ld e,a			;a149
	ld a,(0c427h)		;a14a   ; lee la X de Simon
	sub d			;a14d
	jr nc,L_A153		;a14e
	neg		;a150
	inc (hl)			;a152
L_A153:
	rra			;a153
	rra			;a154
	rra			;a155
	rra			;a156
	rra			;a157
	and 007h		;a158
	add a,e			;a15a
	ld hl,0a1a2h		;a15b
	call 04061h		;a15e   ; hl_mas_a: HL += A
	ld a,(hl)			;a161
	ld (0cff8h),a		;a162
	ld c,a			;a165
	ld hl,(0cff1h)		;a166   ; lee la posicion de la cosa que se crea
	ld a,h			;a169
	ld b,000h		;a16a
	and a			;a16c
	jr z,L_A171		;a16d
	ld b,080h		;a16f
L_A171:
	cp l			;a171
	ld a,c			;a172
	jr z,L_A177		;a173
	neg		;a175
L_A177:
	add a,b			;a177
	ld (0cff9h),a		;a178
	ret			;a17b
niega_de:
	ld a,d			;a17c
	cpl			;a17d
	ld d,a			;a17e
	ld a,e			;a17f
	cpl			;a180
	ld e,a			;a181
	inc de			;a182
	ret			;a183
L_A184:
	ld a,(0cff0h)		;a184   ; lee el tipo de la cosa que se crea
	ld h,a			;a187
	call L_A196		;a188
	xor a			;a18b
	add hl,hl			;a18c
	adc a,a			;a18d
	add hl,hl			;a18e
	adc a,a			;a18f
	add hl,hl			;a190
	adc a,a			;a191
	ld l,h			;a192
	ld h,a			;a193
	ex de,hl			;a194
	ret			;a195
L_A196:
	ld b,008h		;a196
	ld l,000h		;a198
	ld d,l			;a19a
L_A19B:
	add hl,hl			;a19b
	jr nc,L_A19F		;a19c
	add hl,de			;a19e
L_A19F:
	djnz L_A19B		;a19f
	ret			;a1a1

; ----------------------------------------------------------------------
; DATOS arcotangente: una tabla de 64 bytes (8 x 8) que p03:A15B indexa con
;   dos diferencias de tres bits para sacar una direccion (0xCFF8), y detras,
;   en 0xA1E2, 64 valores de 0x00 a 0xFF que crecen como un seno (p03:A106):
;   con las dos se apunta a Simon
;   0xa1a2..0xa222  (128 bytes)
DATA_arcotangente:
	defb 020h,008h,004h,003h,002h,002h,001h,001h,038h,020h,015h,00fh,00ch,009h,008h,007h	; a1a2   .......8 ......
	defb 03bh,02bh,020h,019h,014h,010h,00eh,00ch,03dh,031h,027h,020h,01ah,016h,013h,011h	; a1b2  ;+ .....=1' ....
	defb 03dh,034h,02ch,025h,020h,01ch,018h,015h,03eh,036h,02fh,029h,024h,020h,01ch,019h	; a1c2  =4,% ...>6/)$ ..
	defb 03eh,038h,032h,02ch,028h,023h,020h,01dh,03eh,039h,034h,02fh,02ah,026h,023h,020h	; a1d2  >82,(# .>94/*&#
	defb 000h,006h,00ch,012h,019h,01fh,026h,02ch,032h,038h,03eh,044h,04ah,050h,056h,05ch	; a1e2  ......&,28>DJPV\
	defb 062h,068h,06dh,073h,079h,07eh,084h,089h,08eh,093h,099h,09eh,0a2h,0a7h,0ach,0b1h	; a1f2  bhmsy~..........
	defb 0b5h,0b9h,0beh,0c2h,0c6h,0cah,0ceh,0d1h,0d5h,0d8h,0dch,0dfh,0e2h,0e5h,0e7h,0eah	; a202  ................
	defb 0edh,0efh,0f1h,0f3h,0f5h,0f7h,0f8h,0fah,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; a212  ................

; ======================================================================
; CODIGO 0xa222..0xa2a6  (132 bytes)
; ======================================================================


L_A222:
	call L_A2A8		;a222
	ld (ix+010h),008h		;a225
	ld (ix+011h),020h		;a229
	ret			;a22d
L_A22E:
	call L_A2A8		;a22e
	ld a,(ix+001h)		;a231   ; lee el paso en que va la cosa
	dec a			;a234
	jr z,L_A253		;a235
	dec a			;a237
	jr z,L_A299		;a238
	dec (ix+010h)		;a23a
	ret nz			;a23d
	inc (ix+001h)		;a23e   ; sube el paso en que va la cosa
	ld (ix+011h),018h		;a241
	ld a,(0d012h)		;a245
	add a,a			;a248
	add a,a			;a249
	add a,a			;a24a
	sub 028h		;a24b
	neg		;a24d
	ld (ix+010h),a		;a24f
	ret			;a252
L_A253:
	ld a,04ch		;a253
	bit 0,(ix+011h)		;a255
	jr z,L_A25D		;a259
	ld a,048h		;a25b
L_A25D:
	call L_A28A		;a25d
	dec (ix+011h)		;a260
	ret nz			;a263
	ld (ix+013h),012h		;a264
	inc (ix+001h)		;a268   ; sube el paso en que va la cosa
L_A26B:
	ld hl,00000h		;a26b
	ld de,0fc00h		;a26e
	bit 0,(ix+00bh)		;a271   ; mira el bit 0 de el dibujo de la cosa
	jr z,L_A27A		;a275
	ld de,00400h		;a277
L_A27A:
	ld a,(ix+003h)		;a27a   ; lee la y de la cosa
	sub 014h		;a27d
	ld c,a			;a27f
	ld b,(ix+005h)		;a280   ; lee la x de la cosa
	ld a,00ah		;a283
	call 09f6dh		;a285   ; crea_con_parametros: guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa
	ld a,04ch		;a288
L_A28A:
	ld (ix+025h),002h		;a28a
	ld (ix+02ah),a		;a28e
	ld (ix+02fh),002h		;a291
	ld (ix+034h),a		;a295
	ret			;a298
L_A299:
	call L_A2A8		;a299
	dec (ix+013h)		;a29c
	ret nz			;a29f
	ld (ix+001h),000h		;a2a0   ; el paso en que va la cosa = 0x00
	jr L_A26B		;a2a4

; ----------------------------------------------------------------------
; DATOS dos_bytes_sueltos: dos bytes (0x3E 0x4C) entre dos rutinas que no lee
;   nadie; su direccion no aparece como palabra en el cartucho
;   0xa2a6..0xa2a8  (2 bytes)
DATA_dos_bytes_sueltos:
	defb 03eh,04ch	; a2a6

; ======================================================================
; CODIGO 0xa2a8..0xa452  (426 bytes)
; ======================================================================


L_A2A8:
	ld b,005h		;a2a8
	ld a,(0d000h)		;a2aa   ; lee la FASE (0 el patio, 1-18)
	cp 009h		;a2ad
	jr nz,L_A2BA		;a2af
	ld a,(0d001h)		;a2b1   ; lee la HABITACION dentro de la fase
	cp 004h		;a2b4
	jr nz,L_A2BA		;a2b6
	ld b,007h		;a2b8
L_A2BA:
	ld a,(0c427h)		;a2ba   ; lee la X de Simon
	cp (ix+005h)		;a2bd   ; compara con la x de la cosa
	jr nc,L_A2C3		;a2c0
	dec b			;a2c2
L_A2C3:
	ld (ix+00bh),b		;a2c3   ; guarda el dibujo de la cosa
	ret			;a2c6
L_A2C7:
	ld (ix+01bh),001h		;a2c7
	xor a			;a2cb
	ld (ix+01ch),a		;a2cc
	ld (ix+012h),a		;a2cf
	ld (ix+010h),002h		;a2d2
	ld (ix+019h),a		;a2d6
	ld (ix+015h),001h		;a2d9
	jp L_A366		;a2dd
L_A2E0:
	call L_A4B3		;a2e0
	xor a			;a2e3
	ld (ix+018h),a		;a2e4
	ld (ix+01bh),a		;a2e7
	inc a			;a2ea
	ld (ix+006h),a		;a2eb   ; guarda si la cosa se mueve
	ld (ix+019h),a		;a2ee
	ld (ix+008h),0f4h		;a2f1   ; la velocidad vertical = 0xF4
	ld (ix+007h),080h		;a2f5   ; la velocidad vertical (parte baja) = 0x80
	ld a,008h		;a2f9
	call L_A4E8		;a2fb
	ld e,(ix+003h)		;a2fe   ; lee la y de la cosa
	ld d,(ix+005h)		;a301   ; lee la x de la cosa
	ld c,020h		;a304
	push de			;a306
	call 05f1dh		;a307   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	pop de			;a30a
	ld c,020h		;a30b
	jp 05f1dh		;a30d   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
L_A310:
	inc (ix+01dh)		;a310
	ld a,(ix+001h)		;a313   ; lee el paso en que va la cosa
	dec a			;a316
	jp z,L_A3A0		;a317
	dec a			;a31a
	jp z,L_A45A		;a31b
	bit 0,(ix+018h)		;a31e
	jr nz,L_A327		;a322
	call L_A4B3		;a324
L_A327:
	ld de,00000h		;a327
	call pon_velocidad_x		;a32a   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,00080h		;a32d
	call suma_a_la_velocidad_y		;a330   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
	bit 7,(ix+008h)		;a333   ; mira el bit 7 de la velocidad vertical
	ret nz			;a337
	ld d,(ix+005h)		;a338   ; lee la x de la cosa
	ld e,(ix+003h)		;a33b   ; lee la y de la cosa
	bit 0,(ix+012h)		;a33e
	jr z,L_A348		;a342
	ld a,d			;a344
	add a,008h		;a345
	ld d,a			;a347
L_A348:
	call 07b98h		;a348   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	jr nc,L_A380		;a34b
	ld a,007h		;a34d
	call L_A4E8		;a34f
	ld a,(ix+003h)		;a352   ; lee la y de la cosa
	and 0f8h		;a355
	ld (ix+003h),a		;a357   ; guarda la y de la cosa
	ld a,(0d012h)		;a35a
	add a,a			;a35d
	add a,a			;a35e
	sub 030h		;a35f
	neg		;a361
	ld (ix+010h),a		;a363
L_A366:
	ld (ix+011h),010h		;a366
	ld (ix+014h),000h		;a36a
	ld (ix+015h),001h		;a36e
	ld (ix+001h),001h		;a372   ; el paso en que va la cosa = 0x01
	ld (ix+013h),008h		;a376
	ld de,00000h		;a37a
	jp pon_velocidad_y		;a37d   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_A380:
	ld a,(ix+003h)		;a380   ; lee la y de la cosa
	cp 0c0h		;a383
	ret c			;a385
	ld a,009h		;a386
	call L_A4E8		;a388
	call 099f6h		;a38b   ; borra_la_cosa: tipo a cero y sus sprites libres
	ld e,(ix+003h)		;a38e   ; lee la y de la cosa
	ld d,(ix+005h)		;a391   ; lee la x de la cosa
	ld c,020h		;a394
	push de			;a396
	call 05f1dh		;a397   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	pop de			;a39a
	ld c,020h		;a39b
	jp 05f1dh		;a39d   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
L_A3A0:
	bit 0,(ix+01bh)		;a3a0
	jr z,L_A3CB		;a3a4
	bit 0,(ix+01ch)		;a3a6
	jr nz,L_A3CB		;a3aa
	ld (ix+00bh),012h		;a3ac   ; el dibujo de la cosa = 0x12
	ld a,(0c425h)		;a3b0   ; lee la Y de Simon
	ld b,a			;a3b3
	ld (ix+000h),003h		;a3b4   ; el tipo de la cosa = 0x03
	ld a,(ix+003h)		;a3b8   ; lee la y de la cosa
	sub 008h		;a3bb
	cp b			;a3bd
	ret nc			;a3be
	add a,010h		;a3bf
	cp b			;a3c1
	ret c			;a3c2
	ld (ix+006h),001h		;a3c3   ; la cosa se mueve
	ld (ix+01ch),001h		;a3c7
L_A3CB:
	bit 0,(ix+000h)		;a3cb   ; mira el bit 0 de el tipo de la cosa
	jr z,L_A3DE		;a3cf
	dec (ix+010h)		;a3d1
	jr nz,L_A3DE		;a3d4
	inc (ix+001h)		;a3d6   ; sube el paso en que va la cosa
	ld (ix+011h),018h		;a3d9
	ret			;a3dd
L_A3DE:
	dec (ix+015h)		;a3de
	jr nz,L_A403		;a3e1
	call L_A4CF		;a3e3
	ld (ix+012h),000h		;a3e6
	ld de,0fe80h		;a3ea
	ld a,(0c427h)		;a3ed   ; lee la X de Simon
	cp (ix+005h)		;a3f0   ; compara con la x de la cosa
	jr c,L_A3FC		;a3f3
	ld (ix+012h),001h		;a3f5
	ld de,00180h		;a3f9
L_A3FC:
	call pon_velocidad_x		;a3fc   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+013h),001h		;a3ff
L_A403:
	ld hl,0a452h		;a403
	bit 0,(ix+012h)		;a406
	jr z,L_A40F		;a40a
	ld hl,0a456h		;a40c
L_A40F:
	dec (ix+013h)		;a40f
	jr nz,L_A42F		;a412
	ld (ix+013h),008h		;a414
	inc (ix+014h)		;a418
	ld a,(ix+014h)		;a41b
	and 001h		;a41e
	bit 0,(ix+000h)		;a420   ; mira el bit 0 de el tipo de la cosa
	jr z,L_A428		;a424
	add a,002h		;a426
L_A428:
	call 04061h		;a428   ; hl_mas_a: HL += A
	ld a,(hl)			;a42b
	ld (ix+00bh),a		;a42c   ; guarda el dibujo de la cosa
L_A42F:
	ld a,(ix+005h)		;a42f   ; lee la x de la cosa
	bit 7,(ix+00ah)		;a432   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_A43A		;a436
	add a,008h		;a438
L_A43A:
	ld d,a			;a43a
	ld e,(ix+003h)		;a43b   ; lee la y de la cosa
	call 07b98h		;a43e   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret c			;a441
	ld (ix+008h),000h		;a442   ; la velocidad vertical = 0x00
	ld (ix+007h),000h		;a446   ; la velocidad vertical (parte baja) = 0x00
	dec (ix+001h)		;a44a   ; baja el paso en que va la cosa
	ld (ix+018h),001h		;a44d
	ret			;a451

; ----------------------------------------------------------------------
; DATOS dos_animaciones_A452: dos animaciones de cuatro dibujos (0xA452 y
;   0xA456) que p03:A403 elige con el bit 0 de (ix+0x12) y cambia cada ocho
;   cuadros
;   0xa452..0xa45a  (8 bytes)
DATA_dos_animaciones_A452:
	defb 008h,009h,00fh,010h,00bh,00ch,012h,013h	; a452  ........

; ======================================================================
; CODIGO 0xa45a..0xa4af  (85 bytes)
; ======================================================================


L_A45A:
	ld (ix+006h),000h		;a45a   ; la cosa se queda quieta
	dec (ix+011h)		;a45e
	jr z,L_A486		;a461
	ld a,(ix+011h)		;a463
	cp 008h		;a466
	jr z,L_A492		;a468
	ld hl,0a4afh		;a46a
	cp 010h		;a46d
	jr c,L_A482		;a46f
	ld c,000h		;a471
L_A473:
	bit 0,(ix+012h)		;a473
	jr z,L_A47A		;a477
	inc c			;a479
L_A47A:
	ld b,000h		;a47a
	add hl,bc			;a47c
	ld a,(hl)			;a47d
	ld (ix+00bh),a		;a47e   ; guarda el dibujo de la cosa
	ret			;a481
L_A482:
	ld c,002h		;a482
	jr L_A473		;a484
L_A486:
	dec (ix+001h)		;a486   ; baja el paso en que va la cosa
	ld (ix+010h),030h		;a489
	ld (ix+006h),001h		;a48d   ; la cosa se mueve
	ret			;a491
L_A492:
	ld hl,00000h		;a492
	ld de,00300h		;a495
	bit 7,(ix+00ah)		;a498   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_A4A1		;a49c
	ld de,0fd00h		;a49e
L_A4A1:
	ld a,(ix+003h)		;a4a1   ; lee la y de la cosa
	sub 014h		;a4a4
	ld c,a			;a4a6
	ld b,(ix+005h)		;a4a7   ; lee la x de la cosa
	ld a,002h		;a4aa
	jp 09f6dh		;a4ac   ; crea_con_parametros: guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa

; ----------------------------------------------------------------------
; DATOS cuatro_dibujos_A4AF: cuatro dibujos que p03:A46A usa segun la
;   distancia
;   0xa4af..0xa4b3  (4 bytes)
DATA_cuatro_dibujos_A4AF:
	defb 00fh,012h,011h,014h	; a4af

; ======================================================================
; CODIGO 0xa4b3..0xa4f3  (64 bytes)
; ======================================================================


L_A4B3:
	ld b,00bh		;a4b3
	ld c,008h		;a4b5
	bit 0,(ix+000h)		;a4b7   ; mira el bit 0 de el tipo de la cosa
	jr z,L_A4C1		;a4bb
	ld b,012h		;a4bd
	ld c,00fh		;a4bf
L_A4C1:
	ld (ix+00bh),b		;a4c1   ; guarda el dibujo de la cosa
	ld a,(0c427h)		;a4c4   ; lee la X de Simon
	cp (ix+005h)		;a4c7   ; compara con la x de la cosa
	ret nc			;a4ca
	ld (ix+00bh),c		;a4cb   ; guarda el dibujo de la cosa
	ret			;a4ce
L_A4CF:
	ld hl,0a4f3h		;a4cf
	bit 0,(ix+019h)		;a4d2
	jr nz,L_A4DB		;a4d6
	ld hl,0a4f7h		;a4d8
L_A4DB:
	ld a,(ix+01dh)		;a4db
	and 003h		;a4de
	call 04061h		;a4e0   ; hl_mas_a: HL += A
	ld a,(hl)			;a4e3
	ld (ix+015h),a		;a4e4
	ret			;a4e7
L_A4E8:
	ld c,a			;a4e8
	ld a,(0c420h)		;a4e9
	cp 006h		;a4ec
	ret z			;a4ee
	ld a,c			;a4ef
	jp 0509fh		;a4f0   ; sonido: arranca la musica o el efecto A (bit 7 = musica)

; ----------------------------------------------------------------------
; DATOS dos_animaciones_A4F3: dos animaciones de cuatro valores (0xA4F3 y
;   0xA4F7) que p03:A4CF elige con el bit 0 de (ix+0x19) e indexa con los dos
;   bits bajos de (ix+0x1D)
;   0xa4f3..0xa4fb  (8 bytes)
DATA_dos_animaciones_A4F3:
	defb 010h,020h,018h,030h,008h,010h,00bh,006h	; a4f3  . .0....

; ======================================================================
; CODIGO 0xa4fb..0xa627  (300 bytes)
; ======================================================================


L_A4FB:
	ld (ix+006h),001h		;a4fb   ; la cosa se mueve
	ld a,(ix+003h)		;a4ff   ; lee la y de la cosa
	ld (ix+010h),a		;a502
	ld de,0fc80h		;a505
	call pon_velocidad_y		;a508   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld a,(ix+005h)		;a50b   ; lee la x de la cosa
	cp 080h		;a50e
	ld de,00280h		;a510
	jr c,L_A518		;a513
	ld de,0fd80h		;a515
L_A518:
	jp L_A653		;a518
L_A51B:
	ld c,071h		;a51b
	ld a,(0d000h)		;a51d   ; lee la FASE (0 el patio, 1-18)
	cp 015h		;a520
	jr nz,L_A526		;a522
	ld c,072h		;a524
L_A526:
	inc (ix+00ch)		;a526   ; sube la cuenta de cuadros del paso
	bit 2,(ix+00ch)		;a529   ; mira el bit 2 de la cuenta de cuadros del paso
	jr z,L_A530		;a52d
	inc c			;a52f
L_A530:
	bit 7,(ix+00ah)		;a530   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_A538		;a534
	inc c			;a536
	inc c			;a537
L_A538:
	ld (ix+00bh),c		;a538   ; guarda el dibujo de la cosa
	ld de,00040h		;a53b
	ld a,(ix+003h)		;a53e   ; lee la y de la cosa
	cp (ix+010h)		;a541
	jr c,suma_a_la_velocidad_y		;a544
	ld de,0ffc0h		;a546
suma_a_la_velocidad_y:
	ld l,(ix+007h)		;a549   ; lee la velocidad vertical (parte baja)
	ld h,(ix+008h)		;a54c   ; lee la velocidad vertical
	add hl,de			;a54f
	ex de,hl			;a550
	ld a,d			;a551
	and a			;a552
	jp m,pon_velocidad_y		;a553   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	cp 008h		;a556
	jr c,pon_velocidad_y		;a558
	ld de,007ffh		;a55a
pon_velocidad_y:
	ld (ix+007h),e		;a55d   ; guarda la velocidad vertical (parte baja)
	ld (ix+008h),d		;a560   ; guarda la velocidad vertical
	ret			;a563
L_A564:
	ld l,(ix+009h)		;a564   ; lee la velocidad horizontal (parte baja)
	ld h,(ix+00ah)		;a567   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	add hl,de			;a56a
	ex de,hl			;a56b
pon_velocidad_x:
	ld (ix+009h),e		;a56c   ; guarda la velocidad horizontal (parte baja)
	ld (ix+00ah),d		;a56f   ; guarda la velocidad horizontal (el bit 7, hacia la izquierda)
	ret			;a572
L_A573:
	ld (ix+006h),001h		;a573   ; la cosa se mueve
	ld de,00000h		;a577
	ld (ix+010h),e		;a57a
	ld (ix+011h),e		;a57d
	call pon_velocidad_y		;a580   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld de,00160h		;a583
	call pon_velocidad_x		;a586   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+00bh),050h		;a589   ; el dibujo de la cosa = 0x50
	ld (ix+00ch),060h		;a58d   ; la cuenta de cuadros del paso = 0x60
	ret			;a591
L_A592:
	dec (ix+00ch)		;a592   ; baja la cuenta de cuadros del paso
	ld a,014h		;a595
	bit 7,(ix+00ah)		;a597   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_A59F		;a59b
	ld a,0f8h		;a59d
L_A59F:
	add a,(ix+005h)		;a59f   ; le suma la x de la cosa
	ld d,a			;a5a2
	ld e,(ix+003h)		;a5a3   ; lee la y de la cosa
	call 07b98h		;a5a6   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	jr nc,L_A60C		;a5a9
	ld d,(ix+005h)		;a5ab   ; lee la x de la cosa
	ld bc,00808h		;a5ae
	bit 7,(ix+00ah)		;a5b1   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_A5BC		;a5b5
	call 07bbeh		;a5b7
	jr L_A5BF		;a5ba
L_A5BC:
	call 07c1ah		;a5bc
L_A5BF:
	jr c,L_A60C		;a5bf
	ld a,(ix+005h)		;a5c1   ; lee la x de la cosa
	cp 0f0h		;a5c4
	jr c,L_A5D0		;a5c6
	bit 7,(ix+00ah)		;a5c8   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_A60C		;a5cc
	jr L_A5DC		;a5ce
L_A5D0:
	cp 00fh		;a5d0
	jp nc,L_A5DC		;a5d2
	bit 7,(ix+00ah)		;a5d5   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jp nz,L_A60C		;a5d9
L_A5DC:
	call L_A637		;a5dc
	jr nc,L_A5FE		;a5df
	bit 0,(ix+011h)		;a5e1
	jr nz,L_A602		;a5e5
	ld de,00160h		;a5e7
	ld a,(0c427h)		;a5ea   ; lee la X de Simon
	cp (ix+005h)		;a5ed   ; compara con la x de la cosa
	jr nc,L_A5F5		;a5f0
	ld de,0fea0h		;a5f2
L_A5F5:
	call L_A653		;a5f5
	ld (ix+011h),001h		;a5f8
	jr L_A60F		;a5fc
L_A5FE:
	ld (ix+011h),000h		;a5fe
L_A602:
	ld a,(ix+00ch)		;a602   ; lee la cuenta de cuadros del paso
	and a			;a605
	jr nz,L_A60F		;a606
	ld (ix+00ch),060h		;a608   ; la cuenta de cuadros del paso = 0x60
L_A60C:
	call L_A642		;a60c
L_A60F:
	inc (ix+010h)		;a60f
	ld a,(ix+010h)		;a612
	rra			;a615
	rra			;a616
	and 003h		;a617
	ld hl,0a627h		;a619
	bit 7,(ix+00ah)		;a61c   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_A624		;a620
	add a,004h		;a622
L_A624:
	ld c,a			;a624
	jr $+10		;a625

; ----------------------------------------------------------------------
; DATOS dos_animaciones_A627: dos animaciones de cuatro dibujos que p03:A619
;   elige segun mire a un lado o al otro (bit 7 de (ix+0x0A))
;   0xa627..0xa62f  (8 bytes)
DATA_dos_animaciones_A627:
	defb 050h,051h,052h,051h,053h,054h,055h,054h	; a627  PQRQSTUT

; ======================================================================
; CODIGO 0xa62f..0xa686  (87 bytes)
; ======================================================================


dibujo_de_la_tabla:
	ld b,000h		;a62f
	add hl,bc			;a631
	ld a,(hl)			;a632
	ld (ix+00bh),a		;a633   ; guarda el dibujo de la cosa
	ret			;a636
L_A637:
	ld a,(0c425h)		;a637   ; lee la Y de Simon
	sub (ix+003h)		;a63a   ; le resta la y de la cosa
	add a,008h		;a63d
	cp 010h		;a63f
	ret			;a641
L_A642:
	push af			;a642
	push de			;a643
	ld e,(ix+009h)		;a644   ; lee la velocidad horizontal (parte baja)
	ld d,(ix+00ah)		;a647   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	call niega_de		;a64a   ; niega_de: DE = -DE
	call pon_velocidad_x		;a64d   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	pop de			;a650
	pop af			;a651
	ret			;a652
L_A653:
	ld a,d			;a653
	or e			;a654
	jp z,pon_velocidad_x		;a655   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	push hl			;a658
	ex de,hl			;a659
	ld a,(0d012h)		;a65a
	add a,a			;a65d
	add a,a			;a65e
	add a,a			;a65f
	add a,a			;a660
	add a,a			;a661
	ld d,000h		;a662
	ld e,a			;a664
	bit 7,h		;a665
	call nz,niega_de		;a667   ; niega_de: DE = -DE
	add hl,de			;a66a
	ex de,hl			;a66b
	pop hl			;a66c
	jp pon_velocidad_x		;a66d   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_A670:
	ld (ix+010h),018h		;a670
	ld (ix+00bh),089h		;a674   ; el dibujo de la cosa = 0x89
	ld (ix+012h),000h		;a678
	ret			;a67c
L_A67D:
	inc (ix+018h)		;a67d
	ld a,(ix+001h)		;a680   ; lee el paso en que va la cosa
	call 0406bh		;a683   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A686: 8 destinos del despachador de 0x406B (call en p03:A683):
;   0xA696, 0xA6A5, 0xA6D7, 0xA6EA, 0xA6FE, 0xA728, 0xA764, 0xA793; lo leen
;   p03:A683 (16 bytes)
;   0xa686..0xa696  (16 bytes)
DATA_tabla_A686:
	defb 096h,0a6h	; a686
	defb 0a5h,0a6h	; a688
	defb 0d7h,0a6h	; a68a
	defb 0eah,0a6h	; a68c
	defb 0feh,0a6h	; a68e
	defb 028h,0a7h	; a690
	defb 064h,0a7h	; a692
	defb 093h,0a7h	; a694

; ======================================================================
; CODIGO 0xa696..0xa7b9  (291 bytes)
; ======================================================================


L_A696:
	dec (ix+010h)		;a696
	ret nz			;a699
	ld (ix+006h),001h		;a69a   ; la cosa se mueve
	inc (ix+001h)		;a69e   ; sube el paso en que va la cosa
	call L_A7BD		;a6a1
	ret			;a6a4
L_A6A5:
	call L_A82D		;a6a5
	ret c			;a6a8
	call L_A797		;a6a9
	ld a,0e0h		;a6ac
	bit 7,(ix+008h)		;a6ae   ; mira el bit 7 de la velocidad vertical
	jr z,L_A6B6		;a6b2
	ld a,020h		;a6b4
L_A6B6:
	ld h,(ix+008h)		;a6b6   ; lee la velocidad vertical
	ld l,(ix+007h)		;a6b9   ; lee la velocidad vertical (parte baja)
	call L_A823		;a6bc
	ld (ix+008h),h		;a6bf   ; guarda la velocidad vertical
	ld (ix+007h),l		;a6c2   ; guarda la velocidad vertical (parte baja)
	ld a,(ix+008h)		;a6c5   ; lee la velocidad vertical
	and a			;a6c8
	ret nz			;a6c9
	ld a,(ix+007h)		;a6ca   ; lee la velocidad vertical (parte baja)
	and a			;a6cd
	ret nz			;a6ce
	ld (ix+01eh),018h		;a6cf
	inc (ix+001h)		;a6d3   ; sube el paso en que va la cosa
	ret			;a6d6
L_A6D7:
	call L_A797		;a6d7
	ld (ix+006h),000h		;a6da   ; la cosa se queda quieta
	dec (ix+01eh)		;a6de
	ret nz			;a6e1
	ld (ix+006h),001h		;a6e2   ; la cosa se mueve
	inc (ix+001h)		;a6e6   ; sube el paso en que va la cosa
	ret			;a6e9
L_A6EA:
	ld (ix+001h),001h		;a6ea   ; el paso en que va la cosa = 0x01
	ld a,(0c425h)		;a6ee   ; lee la Y de Simon
	sub (ix+003h)		;a6f1   ; le resta la y de la cosa
	cp 018h		;a6f4
	jp nc,L_A7BD		;a6f6
	ld (ix+001h),004h		;a6f9   ; el paso en que va la cosa = 0x04
	ret			;a6fd
L_A6FE:
	ld (ix+00ah),003h		;a6fe   ; la velocidad horizontal (el bit 7, hacia la izquierda) = 0x03
	ld (ix+009h),000h		;a702   ; la velocidad horizontal (parte baja) = 0x00
	ld a,(0c427h)		;a706   ; lee la X de Simon
	cp (ix+005h)		;a709   ; compara con la x de la cosa
	jr nc,L_A716		;a70c
	ld (ix+00ah),0fdh		;a70e   ; la velocidad horizontal (el bit 7, hacia la izquierda) = 0xFD
	ld (ix+009h),000h		;a712   ; la velocidad horizontal (parte baja) = 0x00
L_A716:
	ld (ix+008h),000h		;a716   ; la velocidad vertical = 0x00
	ld (ix+007h),000h		;a71a   ; la velocidad vertical (parte baja) = 0x00
	inc (ix+001h)		;a71e   ; sube el paso en que va la cosa
	ld (ix+010h),030h		;a721
	jp L_A797		;a725
L_A728:
	call L_A82D		;a728
	ret c			;a72b
	call L_A797		;a72c
	dec (ix+010h)		;a72f
	jr z,L_A75C		;a732
	bit 7,(ix+00ah)		;a734   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_A74B		;a738
	ld (ix+011h),000h		;a73a
	ld a,(0c427h)		;a73e   ; lee la X de Simon
	sub 008h		;a741
	cp (ix+005h)		;a743   ; compara con la x de la cosa
	ret c			;a746
	inc (ix+001h)		;a747   ; sube el paso en que va la cosa
	ret			;a74a
L_A74B:
	ld (ix+011h),001h		;a74b
	ld a,(0c427h)		;a74f   ; lee la X de Simon
	add a,008h		;a752
	cp (ix+005h)		;a754   ; compara con la x de la cosa
	ret nc			;a757
	inc (ix+001h)		;a758   ; sube el paso en que va la cosa
	ret			;a75b
L_A75C:
	call L_A7BD		;a75c
	ld (ix+001h),001h		;a75f   ; el paso en que va la cosa = 0x01
	ret			;a763
L_A764:
	call L_A82D		;a764
	ret c			;a767
	call L_A797		;a768
	ld a,0e0h		;a76b
	ld e,0feh		;a76d
	bit 0,(ix+011h)		;a76f
	jr nz,L_A779		;a773
	ld a,020h		;a775
	ld e,002h		;a777
L_A779:
	ld h,(ix+00ah)		;a779   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	ld l,(ix+009h)		;a77c   ; lee la velocidad horizontal (parte baja)
	call L_A823		;a77f
	ld (ix+00ah),h		;a782   ; guarda la velocidad horizontal (el bit 7, hacia la izquierda)
	ld (ix+009h),l		;a785   ; guarda la velocidad horizontal (parte baja)
	ld a,h			;a788
	cp e			;a789
	ret nz			;a78a
	inc (ix+001h)		;a78b   ; sube el paso en que va la cosa
	ld (ix+009h),000h		;a78e   ; la velocidad horizontal (parte baja) = 0x00
	ret			;a792
L_A793:
	call L_A82D		;a793
	ret c			;a796
L_A797:
	ld hl,0a7b9h		;a797
	bit 7,(ix+00ah)		;a79a   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_A7A3		;a79e
	ld hl,0a7bbh		;a7a0
L_A7A3:
	inc (ix+012h)		;a7a3
	ld a,(ix+012h)		;a7a6
	and 008h		;a7a9
	sra a		;a7ab
	sra a		;a7ad
	sra a		;a7af
	call 04061h		;a7b1   ; hl_mas_a: HL += A
	ld a,(hl)			;a7b4
	ld (ix+00bh),a		;a7b5   ; guarda el dibujo de la cosa
	ret			;a7b8

; ----------------------------------------------------------------------
; DATOS dos_animaciones_A7B9: dos animaciones de dos dibujos (0xA7B9 y
;   0xA7BB), una por lado (p03:A797)
;   0xa7b9..0xa7bd  (4 bytes)
DATA_dos_animaciones_A7B9:
	defb 08ah,08bh,087h,088h	; a7b9

; ======================================================================
; CODIGO 0xa7bd..0xa813  (86 bytes)
; ======================================================================


L_A7BD:
	ld de,0fe00h		;a7bd
	ld hl,00200h		;a7c0
	ld a,(0c427h)		;a7c3   ; lee la X de Simon
	cp (ix+005h)		;a7c6   ; compara con la x de la cosa
	jr c,L_A7CC		;a7c9
	ex de,hl			;a7cb
L_A7CC:
	ld a,(ix+005h)		;a7cc   ; lee la x de la cosa
	cp 0c0h		;a7cf
	jr nc,L_A7DC		;a7d1
	cp 040h		;a7d3
	jr nc,L_A7DF		;a7d5
	ld de,00200h		;a7d7
	jr L_A7DF		;a7da
L_A7DC:
	ld de,0fe00h		;a7dc
L_A7DF:
	call pon_velocidad_x		;a7df   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld hl,0a813h		;a7e2
	ld a,(0c425h)		;a7e5   ; lee la Y de Simon
	cp (ix+003h)		;a7e8   ; compara con la y de la cosa
	jr c,L_A7F0		;a7eb
	ld hl,0a81bh		;a7ed
L_A7F0:
	ld a,(ix+018h)		;a7f0
	and 003h		;a7f3
	add a,a			;a7f5
	call 04061h		;a7f6   ; hl_mas_a: HL += A
	ld d,(hl)			;a7f9
	inc hl			;a7fa
	ld e,(hl)			;a7fb
	ld a,(ix+003h)		;a7fc   ; lee la y de la cosa
	bit 7,d		;a7ff
	jr z,L_A80B		;a801
	cp 040h		;a803
	call c,niega_de		;a805   ; niega_de: DE = -DE
	jp pon_velocidad_y		;a808   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_A80B:
	cp 0c0h		;a80b
	call nc,niega_de		;a80d   ; niega_de: DE = -DE
	jp pon_velocidad_y		;a810   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE

; ----------------------------------------------------------------------
; DATOS dos_tablas_A813: dos tablas de ocho bytes (0xA813 y 0xA81B) que
;   p03:A7E2 elige segun Simon este a un lado o al otro; los mismos bytes los
;   usa p00:4DA5 como coordenadas de VRAM
;   0xa813..0xa823  (16 bytes)
DATA_dos_tablas_A813:
	defb 0fdh,0e0h,0fdh,080h,0fdh,000h,0fbh,080h,002h,020h,002h,080h,003h,000h,003h,080h	; a813  ......... ......

; ======================================================================
; CODIGO 0xa823..0xa88b  (104 bytes)
; ======================================================================


L_A823:
	bit 7,a		;a823
	jp z,04061h		;a825   ; hl_mas_a: HL += A
	add a,l			;a828
	ld l,a			;a829
	ret c			;a82a
	dec h			;a82b
	ret			;a82c
L_A82D:
	ld a,(ix+003h)		;a82d   ; lee la y de la cosa
	bit 7,(ix+008h)		;a830   ; mira el bit 7 de la velocidad vertical
	jr nz,L_A83C		;a834
	cp 0c0h		;a836
	jr nc,L_A852		;a838
	jr L_A840		;a83a
L_A83C:
	cp 020h		;a83c
	jr c,L_A852		;a83e
L_A840:
	ld a,(ix+005h)		;a840   ; lee la x de la cosa
	bit 7,(ix+00ah)		;a843   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_A84F		;a847
	cp 0e8h		;a849
	jr nc,L_A852		;a84b
	xor a			;a84d
	ret			;a84e
L_A84F:
	cp 010h		;a84f
	ret nc			;a851
L_A852:
	ld (ix+01eh),018h		;a852
	ld (ix+001h),002h		;a856   ; el paso en que va la cosa = 0x02
	scf			;a85a
	ret			;a85b
L_A85C:
	ld b,(ix+005h)		;a85c   ; lee la x de la cosa
	ld a,(0c427h)		;a85f   ; lee la X de Simon
	cp b			;a862
	ld a,043h		;a863
	jr nc,L_A869		;a865
	ld a,03fh		;a867
L_A869:
	ld (ix+00bh),a		;a869   ; guarda el dibujo de la cosa
	ld (ix+006h),001h		;a86c   ; la cosa se mueve
	ld (ix+00ch),000h		;a870   ; la cuenta de cuadros del paso = 0x00
	ld de,00000h		;a874
	call pon_velocidad_x		;a877   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	jp pon_velocidad_y		;a87a   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_A87D:
	ld a,(ix+005h)		;a87d   ; lee la x de la cosa
	cp 018h		;a880
	jp c,099f6h		;a882   ; borra_la_cosa: tipo a cero y sus sprites libres
	ld a,(ix+001h)		;a885   ; lee el paso en que va la cosa
	call 0406bh		;a888   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A88B: 3 destinos del despachador de 0x406B (call en p03:A888):
;   0xA891, 0xA8AC, 0xA8D2; lo leen p03:A888 (6 bytes)
;   0xa88b..0xa891  (6 bytes)
DATA_tabla_A88B:
	defb 091h,0a8h	; a88b
	defb 0ach,0a8h	; a88d
	defb 0d2h,0a8h	; a88f

; ======================================================================
; CODIGO 0xa891..0xa9c1  (304 bytes)
; ======================================================================


L_A891:
	ld a,(0c427h)		;a891   ; lee la X de Simon
	sub (ix+005h)		;a894   ; le resta la x de la cosa
	ld de,00400h		;a897
	jr nc,L_A8A1		;a89a
	neg		;a89c
	ld de,0fc00h		;a89e
L_A8A1:
	cp 040h		;a8a1
	ret nc			;a8a3
	call pon_velocidad_x		;a8a4   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+001h),001h		;a8a7   ; el paso en que va la cosa = 0x01
	ret			;a8ab
L_A8AC:
	call L_A909		;a8ac
	ld e,(ix+003h)		;a8af   ; lee la y de la cosa
	ld d,(ix+005h)		;a8b2   ; lee la x de la cosa
	call 07b98h		;a8b5   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret c			;a8b8
	ld de,0fef8h		;a8b9
	call pon_velocidad_y		;a8bc   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld a,(ix+00ah)		;a8bf   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	bit 7,a		;a8c2
	ld a,046h		;a8c4
	jr z,L_A8CA		;a8c6
	ld a,042h		;a8c8
L_A8CA:
	ld (ix+00bh),a		;a8ca   ; guarda el dibujo de la cosa
	ld (ix+001h),002h		;a8cd   ; el paso en que va la cosa = 0x02
	ret			;a8d1
L_A8D2:
	ld de,000a0h		;a8d2
	call suma_a_la_velocidad_y		;a8d5   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
	ld e,(ix+003h)		;a8d8   ; lee la y de la cosa
	ld d,(ix+005h)		;a8db   ; lee la x de la cosa
	call 07b98h		;a8de   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;a8e1
	ld b,(ix+005h)		;a8e2   ; lee la x de la cosa
	ld a,(0c427h)		;a8e5   ; lee la X de Simon
	cp b			;a8e8
	ld de,00400h		;a8e9
	jr nc,L_A8F1		;a8ec
	ld de,0fc00h		;a8ee
L_A8F1:
	call pon_velocidad_x		;a8f1   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+00ch),000h		;a8f4   ; la cuenta de cuadros del paso = 0x00
	ld (ix+001h),001h		;a8f8   ; el paso en que va la cosa = 0x01
	ld (ix+002h),000h		;a8fc   ; la fraccion de la y de la cosa = 0x00
	call L_A9A2		;a900
	ld de,00000h		;a903
	jp pon_velocidad_y		;a906   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_A909:
	ld a,(ix+00ch)		;a909   ; lee la cuenta de cuadros del paso
	inc a			;a90c
	cp 00dh		;a90d
	jr c,L_A913		;a90f
	ld a,001h		;a911
L_A913:
	ld (ix+00ch),a		;a913   ; guarda la cuenta de cuadros del paso
	bit 7,(ix+00ah)		;a916   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	ld a,(ix+00ch)		;a91a   ; lee la cuenta de cuadros del paso
	jr z,L_A923		;a91d
	ld b,041h		;a91f
	jr L_A925		;a921
L_A923:
	ld b,045h		;a923
L_A925:
	cp 004h		;a925
	jr c,L_A930		;a927
	inc b			;a929
	cp 00ah		;a92a
	jr c,L_A930		;a92c
	dec b			;a92e
	dec b			;a92f
L_A930:
	ld (ix+00bh),b		;a930   ; guarda el dibujo de la cosa
	ret			;a933
L_A934:
	ld (ix+006h),001h		;a934   ; la cosa se mueve
	ld a,(ix+005h)		;a938   ; lee la x de la cosa
	cp 080h		;a93b
	ld de,00220h		;a93d
	ld bc,03d00h		;a940
	jr c,L_A94B		;a943
	ld de,0fde0h		;a945
	ld bc,03b01h		;a948
L_A94B:
	ld (ix+011h),e		;a94b
	ld (ix+012h),d		;a94e
	call L_A653		;a951
	ld (ix+00bh),b		;a954   ; guarda el dibujo de la cosa
	ld (ix+00ch),008h		;a957   ; la cuenta de cuadros del paso = 0x08
	ld (ix+010h),c		;a95b
	ld de,00000h		;a95e
	jp pon_velocidad_y		;a961   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_A964:
	dec (ix+00ch)		;a964   ; baja la cuenta de cuadros del paso
	jr nz,L_A984		;a967
	ld a,(ix+010h)		;a969
	or a			;a96c
	ld bc,03d3eh		;a96d
	jr z,L_A975		;a970
	ld bc,03b3ch		;a972
L_A975:
	ld a,(ix+00bh)		;a975   ; lee el dibujo de la cosa
	cp b			;a978
	ld a,b			;a979
	jr nz,L_A97D		;a97a
	ld a,c			;a97c
L_A97D:
	ld (ix+00bh),a		;a97d   ; guarda el dibujo de la cosa
	ld (ix+00ch),004h		;a980   ; la cuenta de cuadros del paso = 0x04
L_A984:
	ld d,(ix+005h)		;a984   ; lee la x de la cosa
	ld e,(ix+003h)		;a987   ; lee la y de la cosa
	call 07b98h		;a98a   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	jr nc,L_A9AB		;a98d
	ld de,00000h		;a98f
	call pon_velocidad_y		;a992   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld e,(ix+011h)		;a995
	ld d,(ix+012h)		;a998
	call L_A653		;a99b
	ld (ix+006h),001h		;a99e   ; la cosa se mueve
L_A9A2:
	ld a,(ix+003h)		;a9a2   ; lee la y de la cosa
	and 0f8h		;a9a5
	ld (ix+003h),a		;a9a7   ; guarda la y de la cosa
	ret			;a9aa
L_A9AB:
	ld de,00000h		;a9ab
	call pon_velocidad_x		;a9ae   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,00060h		;a9b1
	jp suma_a_la_velocidad_y		;a9b4   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
L_A9B7:
	ld hl,0a9c7h		;a9b7
	push hl			;a9ba
	ld a,(ix+001h)		;a9bb   ; lee el paso en que va la cosa
	call 0406bh		;a9be   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A9C1: 3 destinos del despachador de 0x406B (call en p03:A9BE):
;   0xA9D8, 0xAA0B, 0xAA37; lo leen p03:A9BE (6 bytes)
;   0xa9c1..0xa9c7  (6 bytes)
DATA_tabla_A9C1:
	defb 0d8h,0a9h	; a9c1
	defb 00bh,0aah	; a9c3
	defb 037h,0aah	; a9c5

; ======================================================================
; CODIGO 0xa9c7..0xaaad  (230 bytes)
; ======================================================================


L_A9C7:
	ld a,(ix+022h)		;a9c7
	add a,010h		;a9ca
	ld (ix+003h),a		;a9cc   ; guarda la y de la cosa
	ld a,(ix+023h)		;a9cf
	add a,008h		;a9d2
	ld (ix+005h),a		;a9d4   ; guarda la x de la cosa
	ret			;a9d7
L_A9D8:
	push ix		;a9d8
	pop hl			;a9da
	ld a,l			;a9db
	add a,023h		;a9dc
	ld l,a			;a9de
	push ix		;a9df
	pop hl			;a9e1
	ld e,l			;a9e2
	ld d,h			;a9e3
	set 4,e		;a9e4
	ld a,023h		;a9e6
	add a,l			;a9e8
	ld l,a			;a9e9
	push hl			;a9ea
	push de			;a9eb
	call L_AA67		;a9ec
	pop de			;a9ef
	pop hl			;a9f0
	call L_AA67		;a9f1
	dec (ix+00ch)		;a9f4   ; baja la cuenta de cuadros del paso
	ret nz			;a9f7
	call L_AA8A		;a9f8
	inc (ix+001h)		;a9fb   ; sube el paso en que va la cosa
	ld (ix+00ch),01eh		;a9fe   ; la cuenta de cuadros del paso = 0x1E
	ld (ix+018h),020h		;aa02
	ld (ix+019h),000h		;aa06
	ret			;aa0a
L_AA0B:
	ld (ix+024h),080h		;aa0b
	ld (ix+029h),084h		;aa0f
	call L_AA7D		;aa13
	push ix		;aa16
	pop hl			;aa18
	ld e,l			;aa19
	set 4,e		;aa1a
	ld d,h			;aa1c
	ld a,022h		;aa1d
	add a,l			;aa1f
	ld l,a			;aa20
	push hl			;aa21
	push de			;aa22
	call L_AA67		;aa23
	pop de			;aa26
	pop hl			;aa27
	call L_AA67		;aa28
	dec (ix+00ch)		;aa2b   ; baja la cuenta de cuadros del paso
	ret nz			;aa2e
	ld (ix+00ch),018h		;aa2f   ; la cuenta de cuadros del paso = 0x18
	inc (ix+001h)		;aa33   ; sube el paso en que va la cosa
	ret			;aa36
L_AA37:
	ld (ix+024h),070h		;aa37
	ld (ix+029h),074h		;aa3b
	dec (ix+00ch)		;aa3f   ; baja la cuenta de cuadros del paso
	jr z,L_AA5E		;aa42
	ld a,(ix+00ch)		;aa44   ; lee la cuenta de cuadros del paso
	cp 008h		;aa47
	ret nz			;aa49
	call L_A0E5		;aa4a
	bit 7,d		;aa4d
	ret z			;aa4f
	ld a,(ix+022h)		;aa50
	add a,00ch		;aa53
	ld c,a			;aa55
	ld b,(ix+023h)		;aa56
	ld a,00eh		;aa59
	jp 09f6dh		;aa5b   ; crea_con_parametros: guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa
L_AA5E:
	ld (ix+00ch),01eh		;aa5e   ; la cuenta de cuadros del paso = 0x1E
	ld (ix+001h),001h		;aa62   ; el paso en que va la cosa = 0x01
	ret			;aa66
L_AA67:
	ld b,008h		;aa67
L_AA69:
	ld a,(de)			;aa69
	inc de			;aa6a
	cp (hl)			;aa6b
	jr z,L_AA76		;aa6c
	ld a,001h		;aa6e
	jr nc,L_AA74		;aa70
	ld a,0ffh		;aa72
L_AA74:
	add a,(hl)			;aa74
	ld (hl),a			;aa75
L_AA76:
	ld a,005h		;aa76
	add a,l			;aa78
	ld l,a			;aa79
	djnz L_AA69		;aa7a
	ret			;aa7c
L_AA7D:
	dec (ix+018h)		;aa7d
	ret nz			;aa80
	ld a,r		;aa81
	and 00fh		;aa83
	add a,010h		;aa85
	ld (ix+018h),a		;aa87
L_AA8A:
	ld a,(ix+019h)		;aa8a
	inc (ix+019h)		;aa8d
	and 007h		;aa90
	add a,a			;aa92
	add a,a			;aa93
	ld hl,0aaadh		;aa94
	call 04061h		;aa97   ; hl_mas_a: HL += A
	push ix		;aa9a
	pop de			;aa9c
	set 4,e		;aa9d
	ld b,004h		;aa9f
L_AAA1:
	ld a,(hl)			;aaa1
	add a,(ix+01ah)		;aaa2
	ld (de),a			;aaa5
	inc de			;aaa6
	ld (de),a			;aaa7
	inc de			;aaa8
	inc hl			;aaa9
	djnz L_AAA1		;aaaa
	ret			;aaac

; ----------------------------------------------------------------------
; DATOS ocho_registros_de_cuatro: ocho registros de cuatro bytes que p03:AA94
;   indexa con A * 4
;   0xaaad..0xaacd  (32 bytes)
DATA_ocho_registros_de_cuatro:
	defb 000h,000h,000h,000h,0ech,0f2h,0f8h,0feh,020h,018h,010h,002h,010h,014h,00ch,002h	; aaad  ........ .......
	defb 0fch,0fch,004h,0feh,004h,00ch,000h,002h,020h,018h,010h,002h,000h,0f4h,0fch,000h	; aabd  ........ .......

; ======================================================================
; CODIGO 0xaacd..0xab0e  (65 bytes)
; ======================================================================


L_AACD:
	ld (ix+00ch),020h		;aacd   ; la cuenta de cuadros del paso = 0x20
	ld a,(ix+003h)		;aad1   ; lee la y de la cosa
	ld (ix+01ah),a		;aad4
	ld a,(ix+005h)		;aad7   ; lee la x de la cosa
	ld (ix+01bh),a		;aada
	push ix		;aadd
	pop de			;aadf
	set 4,e		;aae0
	ld hl,0ab1eh		;aae2
	ld b,004h		;aae5
L_AAE7:
	ld a,(hl)			;aae7
	add a,(ix+01bh)		;aae8
	ld (de),a			;aaeb
	inc de			;aaec
	ld (de),a			;aaed
	inc de			;aaee
	inc hl			;aaef
	djnz L_AAE7		;aaf0
	ld a,00ah		;aaf2
	add a,e			;aaf4
	ld e,a			;aaf5
	ld bc,008ffh		;aaf6
	ld hl,0ab0eh		;aaf9
L_AAFC:
	ld a,(ix+01ah)		;aafc
	ld (de),a			;aaff
	inc de			;ab00
	ld a,(ix+01bh)		;ab01
	ld (de),a			;ab04
	inc de			;ab05
	ldi		;ab06
	ldi		;ab08
	inc e			;ab0a
	djnz L_AAFC		;ab0b
	ret			;ab0d

; ----------------------------------------------------------------------
; DATOS sprites_de_la_cosa: lo que p03:AAF9 y p03:AAE2 copian a los sprites de
;   la cosa: cuatro pares y cuatro desplazamientos
;   0xab0e..0xab22  (20 bytes)
DATA_sprites_de_la_cosa:
	defb 080h,002h,084h,04ch,078h,002h,07ch,04ch,078h,002h,07ch,04ch,078h,002h,07ch,04ch	; ab0e  ...Lx.|Lx.|Lx.|L
	defb 0d0h,0e0h,0f0h,000h	; ab1e

; ======================================================================
; CODIGO 0xab22..0xab4c  (42 bytes)
; ======================================================================


L_AB22:
	ld (ix+006h),000h		;ab22   ; la cosa se queda quieta
	ld de,0fe00h		;ab26
	call pon_velocidad_y		;ab29   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld de,00000h		;ab2c
	call pon_velocidad_x		;ab2f   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+00bh),056h		;ab32   ; el dibujo de la cosa = 0x56
	ld (ix+00ch),01eh		;ab36   ; la cuenta de cuadros del paso = 0x1E
	xor a			;ab3a
	ld (ix+010h),a		;ab3b
	ld (ix+00eh),a		;ab3e
	ret			;ab41
L_AB42:
	ld hl,0ab60h		;ab42
	push hl			;ab45
	ld a,(ix+001h)		;ab46   ; lee el paso en que va la cosa
	call 0406bh		;ab49   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AB4C: 10 destinos del despachador de 0x406B (call en p03:AB49):
;   0xAB67, 0xAB86, 0xABAB, 0xABD4, 0xABE9, 0xAC21, 0xAC40, 0xAC7E ...; lo
;   leen p03:AB49 (20 bytes)
;   0xab4c..0xab60  (20 bytes)
DATA_tabla_AB4C:
	defb 067h,0abh	; ab4c
	defb 086h,0abh	; ab4e
	defb 0abh,0abh	; ab50
	defb 0d4h,0abh	; ab52
	defb 0e9h,0abh	; ab54
	defb 021h,0ach	; ab56
	defb 040h,0ach	; ab58
	defb 07eh,0ach	; ab5a
	defb 0aeh,0ach	; ab5c
	defb 0d9h,0ach	; ab5e

; ======================================================================
; CODIGO 0xab60..0xac76  (278 bytes)
; ======================================================================


L_AB60:
	ld a,(ix+005h)		;ab60   ; lee la x de la cosa
	ld (0ce0fh),a		;ab63
	ret			;ab66
L_AB67:
	ld a,(0c427h)		;ab67   ; lee la X de Simon
	sub (ix+005h)		;ab6a   ; le resta la x de la cosa
	ld c,056h		;ab6d
	jr c,L_AB73		;ab6f
	inc c			;ab71
	inc c			;ab72
L_AB73:
	ld (ix+00bh),c		;ab73   ; guarda el dibujo de la cosa
	dec (ix+00ch)		;ab76   ; baja la cuenta de cuadros del paso
	ret nz			;ab79
	ld (ix+006h),001h		;ab7a   ; la cosa se mueve
	ld a,(ix+003h)		;ab7e   ; lee la y de la cosa
	ld (ix+011h),a		;ab81
	jr L_ABA7		;ab84
L_AB86:
	ld a,(ix+011h)		;ab86
	sub (ix+003h)		;ab89   ; le resta la y de la cosa
	cp 040h		;ab8c
	ret c			;ab8e
	ld a,(ix+003h)		;ab8f   ; lee la y de la cosa
	add a,030h		;ab92
	ld (ix+003h),a		;ab94   ; guarda la y de la cosa
	ld (ix+006h),000h		;ab97   ; la cosa se queda quieta
	ld (ix+00bh),05bh		;ab9b   ; el dibujo de la cosa = 0x5B
	ld a,01eh		;ab9f
	ld (ix+00ch),a		;aba1   ; guarda la cuenta de cuadros del paso
	call L_AD80		;aba4
L_ABA7:
	inc (ix+001h)		;aba7   ; sube el paso en que va la cosa
	ret			;abaa
L_ABAB:
	ld c,000h		;abab
	ld hl,0acaah		;abad
	call dibujo_segun_simon		;abb0   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha
	call L_AD45		;abb3
	bit 0,(ix+00ch)		;abb6   ; mira el bit 0 de la cuenta de cuadros del paso
	call nz,L_AD61		;abba
	call L_ADCC		;abbd
	dec (ix+00ch)		;abc0   ; baja la cuenta de cuadros del paso
	ret nz			;abc3
	call L_AD45		;abc4
	call L_ADD2		;abc7
	ld (ix+00ch),004h		;abca   ; la cuenta de cuadros del paso = 0x04
	ld (ix+00eh),007h		;abce
	jr L_ABA7		;abd2
L_ABD4:
	dec (ix+00ch)		;abd4   ; baja la cuenta de cuadros del paso
	ret nz			;abd7
	ld c,001h		;abd8
	ld hl,0acaah		;abda
	call dibujo_segun_simon		;abdd   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha
	call L_ADD2		;abe0
	ld (ix+00ch),004h		;abe3   ; la cuenta de cuadros del paso = 0x04
	jr L_ABA7		;abe7
L_ABE9:
	dec (ix+00ch)		;abe9   ; baja la cuenta de cuadros del paso
	ret nz			;abec
	ld hl,00000h		;abed
	call L_AC05		;abf0
	ld hl,00180h		;abf3
	call L_AC05		;abf6
	ld hl,0fe80h		;abf9
	call L_AC05		;abfc
	ld (ix+00ch),01eh		;abff   ; la cuenta de cuadros del paso = 0x1E
	jr L_ABA7		;ac03
L_AC05:
	ld a,(0c427h)		;ac05   ; lee la X de Simon
	cp (ix+005h)		;ac08   ; compara con la x de la cosa
	ld de,00280h		;ac0b
	jr nc,L_AC13		;ac0e
	ld de,0fd80h		;ac10
L_AC13:
	ld a,(ix+003h)		;ac13   ; lee la y de la cosa
	sub 018h		;ac16
	ld c,a			;ac18
	ld b,(ix+005h)		;ac19   ; lee la x de la cosa
	ld a,011h		;ac1c
	jp 09f6dh		;ac1e   ; crea_con_parametros: guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa
L_AC21:
	dec (ix+00ch)		;ac21   ; baja la cuenta de cuadros del paso
	ret nz			;ac24
	call L_AD5B		;ac25
	ld a,005h		;ac28
	ld (0ce0eh),a		;ac2a
	ld a,(ix+003h)		;ac2d   ; lee la y de la cosa
	sub 040h		;ac30
	ld (ix+003h),a		;ac32   ; guarda la y de la cosa
	ld (ix+00ch),05ah		;ac35   ; la cuenta de cuadros del paso = 0x5A
	ld (ix+00eh),000h		;ac39
	jp L_ABA7		;ac3d
L_AC40:
	dec (ix+00ch)		;ac40   ; baja la cuenta de cuadros del paso
	ret nz			;ac43
	ld a,(ix+003h)		;ac44   ; lee la y de la cosa
	add a,040h		;ac47
	ld (ix+003h),a		;ac49   ; guarda la y de la cosa
	ld c,000h		;ac4c
	ld hl,0acaah		;ac4e
	call dibujo_segun_simon		;ac51   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha
	ld hl,0ac76h		;ac54
	ld a,(ix+010h)		;ac57
	cp 007h		;ac5a
	jr c,L_AC62		;ac5c
	ld (ix+010h),0ffh		;ac5e
L_AC62:
	call 04061h		;ac62   ; hl_mas_a: HL += A
	ld a,(hl)			;ac65
	ld (ix+005h),a		;ac66   ; guarda la x de la cosa
	call L_AD80		;ac69
	inc (ix+010h)		;ac6c
	ld (ix+00ch),01eh		;ac6f   ; la cuenta de cuadros del paso = 0x1E
	jp L_ABA7		;ac73

; ----------------------------------------------------------------------
; DATOS ocho_valores_AC76: ocho bytes que p03:AC54 elige segun (ix+0x10) sea
;   menor que 7 o no
;   0xac76..0xac7e  (8 bytes)
DATA_ocho_valores_AC76:
	defb 030h,0d0h,050h,0a0h,040h,0c0h,080h,0b0h	; ac76  0.P.@...

; ======================================================================
; CODIGO 0xac7e..0xacaa  (44 bytes)
; ======================================================================


L_AC7E:
	ld c,000h		;ac7e
	ld hl,0acaah		;ac80
	call dibujo_segun_simon		;ac83   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha
	call L_AD45		;ac86
	bit 0,(ix+00ch)		;ac89   ; mira el bit 0 de la cuenta de cuadros del paso
	call nz,L_AD5B		;ac8d
	call L_ADCC		;ac90
	dec (ix+00ch)		;ac93   ; baja la cuenta de cuadros del paso
	ret nz			;ac96
	call L_AD45		;ac97
	call L_ADD2		;ac9a
	ld (ix+00ch),004h		;ac9d   ; la cuenta de cuadros del paso = 0x04
	ld (ix+001h),003h		;aca1   ; el paso en que va la cosa = 0x03
	ld (ix+00eh),007h		;aca5
	ret			;aca9

; ----------------------------------------------------------------------
; DATOS dibujos_ACAA: cuatro dibujos, dos por lado: 0xAD37 suma 2 si Simon
;   esta a su derecha y 0xA62F pone el que toca en (ix+0x0B) (p03:ABAD, ABDA,
;   AC4E, AC80)
;   0xacaa..0xacae  (4 bytes)
DATA_dibujos_ACAA:
	defb 05bh,05ch,05dh,05eh	; acaa

; ======================================================================
; CODIGO 0xacae..0xad20  (114 bytes)
; ======================================================================


L_ACAE:
	call L_ADD2		;acae
	xor a			;acb1
	ld (ix+025h),a		;acb2
	ld (ix+02ah),a		;acb5
	ld (ix+02fh),a		;acb8
	ld (ix+034h),a		;acbb
	ld (ix+00eh),a		;acbe
	ld (ix+00ch),03ch		;acc1   ; la cuenta de cuadros del paso = 0x3C
	inc (ix+001h)		;acc5   ; sube el paso en que va la cosa
	call L_AD18		;acc8
	ld a,(ix+003h)		;accb   ; lee la y de la cosa
	sub 02bh		;acce
	ld e,a			;acd0
	ld d,(ix+005h)		;acd1   ; lee la x de la cosa
	ld c,02dh		;acd4
	jp 05f1dh		;acd6   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
L_ACD9:
	dec (ix+00ch)		;acd9   ; baja la cuenta de cuadros del paso
	ret nz			;acdc
	ld a,001h		;acdd
	ld (0ce16h),a		;acdf
	call L_ADC6		;ace2
	jp 099f6h		;ace5   ; borra_la_cosa: tipo a cero y sus sprites libres
L_ACE8:
	ld (ix+006h),001h		;ace8   ; la cosa se mueve
	ld (ix+00eh),000h		;acec
	ld (ix+07eh),000h		;acf0
	ld a,(0c427h)		;acf4   ; lee la X de Simon
	cp (ix+005h)		;acf7   ; compara con la x de la cosa
	ld c,057h		;acfa
	ld de,00300h		;acfc
	jr c,L_AD06		;acff
	ld de,0fd00h		;ad01
	ld c,059h		;ad04
L_AD06:
	ld (ix+00bh),c		;ad06   ; guarda el dibujo de la cosa
	call pon_velocidad_x		;ad09   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,0fd00h		;ad0c
	jp pon_velocidad_y		;ad0f   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_AD12:
	ld de,00050h		;ad12
	jp suma_a_la_velocidad_y		;ad15   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
L_AD18:
	push ix		;ad18
	ld ix,0d700h		;ad1a
	jr $+10		;ad1e

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_AD20: ocho bytes que desensamblan como `push ix / ld
;   ix,0xC800 / ld b,7` y a los que no llega nadie; su direccion no aparece
;   como palabra en el cartucho
;   0xad20..0xad28  (8 bytes)
DATA_codigo_sin_llamar_AD20:
	defb 0ddh,0e5h,0ddh,021h,000h,0c8h,006h,007h	; ad20  ...!....

; ======================================================================
; CODIGO 0xad28..0xad53  (43 bytes)
; ======================================================================


L_AD28:
	push bc			;ad28
	call 099f6h		;ad29   ; borra_la_cosa: tipo a cero y sus sprites libres
	ld de,00080h		;ad2c
	add ix,de		;ad2f
	pop bc			;ad31
	djnz L_AD28		;ad32
	pop ix		;ad34
	ret			;ad36
dibujo_segun_simon:
	ld a,(0c427h)		;ad37   ; lee la X de Simon
	cp (ix+005h)		;ad3a   ; compara con la x de la cosa
	jp c,dibujo_de_la_tabla		;ad3d   ; dibujo_de_la_tabla: (ix+0x0B) = el dibujo C de la tabla de HL
	inc c			;ad40
	inc c			;ad41
	jp dibujo_de_la_tabla		;ad42   ; dibujo_de_la_tabla: (ix+0x0B) = el dibujo C de la tabla de HL
L_AD45:
	ld b,008h		;ad45
	ld de,00025h		;ad47
L_AD4A:
	ld hl,0ad53h		;ad4a
	call L_AD6D		;ad4d
	djnz L_AD4A		;ad50
	ret			;ad52

; ----------------------------------------------------------------------
; DATOS colores_AD53: ocho bytes que p03:AD4A copia, con 0xAD6D, a los colores
;   de los ocho sprites de la cosa ((ix+0x25) de cinco en cinco)
;   0xad53..0xad5b  (8 bytes)
DATA_colores_AD53:
	defb 002h,048h,002h,048h,002h,048h,002h,048h	; ad53  .H.H.H.H

; ======================================================================
; CODIGO 0xad5b..0xadbc  (97 bytes)
; ======================================================================


L_AD5B:
	ld b,008h		;ad5b
	ld e,025h		;ad5d
	jr L_AD65		;ad5f
L_AD61:
	ld b,004h		;ad61
	ld e,039h		;ad63
L_AD65:
	ld c,000h		;ad65
L_AD67:
	call L_AD72		;ad67
	djnz L_AD67		;ad6a
	ret			;ad6c
L_AD6D:
	ld a,d			;ad6d
	call 04061h		;ad6e   ; hl_mas_a: HL += A
	ld c,(hl)			;ad71
L_AD72:
	push ix		;ad72
	pop hl			;ad74
	ld a,e			;ad75
	call 04061h		;ad76   ; hl_mas_a: HL += A
	ld (hl),c			;ad79
	inc d			;ad7a
	ld a,e			;ad7b
	add a,005h		;ad7c
	ld e,a			;ad7e
	ret			;ad7f
L_AD80:
	ld a,(ix+005h)		;ad80   ; lee la x de la cosa
	sub 010h		;ad83
	ld h,a			;ad85
	ld l,091h		;ad86
	ld de,08080h		;ad88
	ld bc,02020h		;ad8b
	ld a,004h		;ad8e
	jp 04946h		;ad90   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_AD93:
	ld hl,0ce0eh		;ad93
	ld a,(hl)			;ad96
	dec a			;ad97
	ret m			;ad98
	ld (hl),000h		;ad99
	ld de,0adbch		;ad9b
	call 06542h		;ad9e   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ex de,hl			;ada1
	ld a,(0ce0fh)		;ada2
	sub 010h		;ada5
	ld d,a			;ada7
	ld e,091h		;ada8
	ld bc,02020h		;adaa
	ld a,h			;adad
	cp 080h		;adae
	jr z,L_ADB7		;adb0
	ld a,048h		;adb2
	jp 049dbh		;adb4
L_ADB7:
	ld a,001h		;adb7
	jp 04946h		;adb9   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)

; ----------------------------------------------------------------------
; DATOS cinco_pares: cinco pares (0x80 y 0x00, 0x20, 0x40, 0x60, 0x80) que
;   p03:AD9B lee via 0x6542
;   0xadbc..0xadc6  (10 bytes)
DATA_cinco_pares:
	defb 080h,000h,080h,020h,080h,040h,080h,060h,080h,080h	; adbc  ... .@.`..

; ======================================================================
; CODIGO 0xadc6..0xaf28  (354 bytes)
; ======================================================================


L_ADC6:
	ld a,005h		;adc6
	ld (0ce0eh),a		;adc8
	ret			;adcb
L_ADCC:
	bit 0,(ix+00ch)		;adcc   ; mira el bit 0 de la cuenta de cuadros del paso
	jr nz,L_ADC6		;add0
L_ADD2:
	ld a,(ix+00bh)		;add2   ; lee el dibujo de la cosa
	sub 05ah		;add5
	cp 005h		;add7
	ret nc			;add9
	ld (0ce0eh),a		;adda
	ret			;addd
L_ADDE:
	ld (ix+006h),001h		;adde   ; la cosa se mueve
	ld de,00000h		;ade2
	call pon_velocidad_y		;ade5   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	call L_A653		;ade8
	ld (ix+00bh),05fh		;adeb   ; el dibujo de la cosa = 0x5F
	ld (ix+010h),000h		;adef
	ld (ix+011h),03ch		;adf3
	ret			;adf7
L_ADF8:
	bit 0,(ix+001h)		;adf8   ; mira el bit 0 de el paso en que va la cosa
	jr nz,L_AE36		;adfc
	ld d,(ix+005h)		;adfe   ; lee la x de la cosa
	ld e,(ix+003h)		;ae01   ; lee la y de la cosa
	call 07b98h		;ae04   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	jr c,L_AE0C		;ae07
	jp L_B33E		;ae09
L_AE0C:
	ld a,(ix+003h)		;ae0c   ; lee la y de la cosa
	and 0f0h		;ae0f
	ld (ix+003h),a		;ae11   ; guarda la y de la cosa
	inc (ix+001h)		;ae14   ; sube el paso en que va la cosa
	ld de,00140h		;ae17
	ld (ix+00bh),061h		;ae1a   ; el dibujo de la cosa = 0x61
	ld a,(0c427h)		;ae1e   ; lee la X de Simon
	cp (ix+005h)		;ae21   ; compara con la x de la cosa
	jr nc,L_AE2D		;ae24
	ld de,0fec0h		;ae26
	ld (ix+00bh),05fh		;ae29   ; el dibujo de la cosa = 0x5F
L_AE2D:
	call L_A653		;ae2d
	ld de,00000h		;ae30
	jp pon_velocidad_y		;ae33   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_AE36:
	call L_AF18		;ae36
	ld a,010h		;ae39
	bit 7,(ix+00ah)		;ae3b   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_AE43		;ae3f
	ld a,0f8h		;ae41
L_AE43:
	add a,(ix+005h)		;ae43   ; le suma la x de la cosa
	ld d,a			;ae46
	ld e,(ix+003h)		;ae47   ; lee la y de la cosa
	call 07b98h		;ae4a   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	jp nc,L_AEF6		;ae4d
	ld d,(ix+005h)		;ae50   ; lee la x de la cosa
	ld bc,00808h		;ae53
	bit 7,(ix+00ah)		;ae56   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_AE61		;ae5a
	call 07bbeh		;ae5c
	jr L_AE64		;ae5f
L_AE61:
	call 07c1ah		;ae61
L_AE64:
	jp c,L_AEF6		;ae64
	ld (ix+006h),001h		;ae67   ; la cosa se mueve
	call distancia_horizontal		;ae6b   ; distancia_horizontal: A = |x de Simon - x de la cosa|
	cp 02eh		;ae6e
	jr nc,L_AE89		;ae70
	ld de,00140h		;ae72
	ld a,(0c427h)		;ae75   ; lee la X de Simon
	cp (ix+005h)		;ae78   ; compara con la x de la cosa
	jr c,L_AE80		;ae7b
	ld de,0fec0h		;ae7d
L_AE80:
	call L_A653		;ae80
	ld (ix+010h),001h		;ae83
	jr L_AEA2		;ae87
L_AE89:
	cp 05ch		;ae89
	jr c,L_AEA2		;ae8b
	ld de,00140h		;ae8d
	ld a,(0c427h)		;ae90   ; lee la X de Simon
	cp (ix+005h)		;ae93   ; compara con la x de la cosa
	jr nc,L_AE9B		;ae96
	ld de,0fec0h		;ae98
L_AE9B:
	call L_A653		;ae9b
	ld (ix+010h),000h		;ae9e
L_AEA2:
	ld a,(ix+005h)		;aea2   ; lee la x de la cosa
	cp 0f0h		;aea5
	call nc,L_AF2C		;aea7
	cp 00fh		;aeaa
	call c,L_AF36		;aeac
L_AEAF:
	bit 1,(ix+001h)		;aeaf   ; mira el bit 1 de el paso en que va la cosa
	jr nz,L_AEE9		;aeb3
	call distancia_horizontal		;aeb5   ; distancia_horizontal: A = |x de Simon - x de la cosa|
	cp 02ah		;aeb8
	jr nc,L_AEDF		;aeba
	bit 0,(ix+010h)		;aebc
	ret z			;aec0
L_AEC1:
	set 1,(ix+001h)		;aec1   ; pone a uno el bit 1 de el paso en que va la cosa
	push ix		;aec5
	pop hl			;aec7
	ld (0cffch),hl		;aec8
	ld hl,00000h		;aecb
	ld de,00400h		;aece
	ld a,(0c427h)		;aed1   ; lee la X de Simon
	cp (ix+005h)		;aed4   ; compara con la x de la cosa
	jr nc,L_AEDC		;aed7
	ld de,0fc00h		;aed9
L_AEDC:
	jp 09f61h		;aedc
L_AEDF:
	cp 060h		;aedf
	ret c			;aee1
	bit 0,(ix+010h)		;aee2
	ret nz			;aee6
	jr L_AEC1		;aee7
L_AEE9:
	dec (ix+011h)		;aee9
	ret nz			;aeec
	ld (ix+011h),03ch		;aeed
	res 1,(ix+001h)		;aef1   ; pone a cero el bit 1 de el paso en que va la cosa
	ret			;aef5
L_AEF6:
	ld (ix+006h),000h		;aef6   ; la cosa se queda quieta
	call distancia_horizontal		;aefa   ; distancia_horizontal: A = |x de Simon - x de la cosa|
	cp 03eh		;aefd
	jr c,L_AF0C		;aeff
	cp 04ch		;af01
	jr nc,L_AF12		;af03
	ld (ix+006h),001h		;af05   ; la cosa se mueve
	jp L_A642		;af09
L_AF0C:
	ld (ix+010h),001h		;af0c
	jr L_AEAF		;af10
L_AF12:
	ld (ix+010h),000h		;af12
	jr L_AEAF		;af16
L_AF18:
	ld c,000h		;af18
	ld a,(0c003h)		;af1a   ; lee el contador de cuadros
	and 008h		;af1d
	jr z,L_AF22		;af1f
	inc c			;af21
L_AF22:
	ld hl,0af28h		;af22
	jp dibujo_segun_simon		;af25   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha

; ----------------------------------------------------------------------
; DATOS dibujos_AF28: cuatro dibujos, dos por lado, para 0xAD37 (p03:AF22)
;   0xaf28..0xaf2c  (4 bytes)
DATA_dibujos_AF28:
	defb 05fh,060h,061h,062h	; af28

; ======================================================================
; CODIGO 0xaf2c..0xaf65  (57 bytes)
; ======================================================================


L_AF2C:
	bit 7,(ix+00ah)		;af2c   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	ret nz			;af30
	ld (ix+006h),000h		;af31   ; la cosa se queda quieta
	ret			;af35
L_AF36:
	bit 7,(ix+00ah)		;af36   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	ret z			;af3a
	ld (ix+006h),000h		;af3b   ; la cosa se queda quieta
	ret			;af3f
distancia_horizontal:
	ld a,(0c427h)		;af40   ; lee la X de Simon
	sub (ix+005h)		;af43   ; le resta la x de la cosa
	ret nc			;af46
	neg		;af47
	ret			;af49
L_AF4A:
	ld de,00000h		;af4a
	call pon_velocidad_y		;af4d   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+011h),030h		;af50
	xor a			;af54
	ld (ix+02fh),a		;af55
	ld (ix+034h),a		;af58
	ld (ix+00eh),a		;af5b
	ret			;af5e
L_AF5F:
	ld a,(ix+001h)		;af5f   ; lee el paso en que va la cosa
	call 0406bh		;af62   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AF65: 3 destinos del despachador de 0x406B (call en p03:AF62):
;   0xAF6B, 0xAFBE, 0xB035; lo leen p03:AF62 (6 bytes)
;   0xaf65..0xaf6b  (6 bytes)
DATA_tabla_AF65:
	defb 06bh,0afh	; af65
	defb 0beh,0afh	; af67
	defb 035h,0b0h	; af69

; ======================================================================
; CODIGO 0xaf6b..0xb177  (524 bytes)
; ======================================================================


L_AF6B:
	dec (ix+011h)		;af6b
	jr z,L_AF7E		;af6e
	ld c,026h		;af70
	ld a,(ix+011h)		;af72
	cp 00ch		;af75
	jr nc,L_AF7A		;af77
	dec c			;af79
L_AF7A:
	ld (ix+00bh),c		;af7a   ; guarda el dibujo de la cosa
	ret			;af7d
L_AF7E:
	ld (ix+00eh),007h		;af7e
	ld a,(ix+025h)		;af82
	ld (ix+02fh),a		;af85
	ld (ix+034h),045h		;af88
	call L_AF9B		;af8c
	ld (ix+00ch),010h		;af8f   ; la cuenta de cuadros del paso = 0x10
	inc (ix+001h)		;af93   ; sube el paso en que va la cosa
	ld (ix+006h),001h		;af96   ; la cosa se mueve
	ret			;af9a
L_AF9B:
	ld a,(0c427h)		;af9b   ; lee la X de Simon
	sub (ix+005h)		;af9e   ; le resta la x de la cosa
	jr c,L_AFB0		;afa1
	ld (ix+012h),000h		;afa3
	ld (ix+00bh),021h		;afa7   ; el dibujo de la cosa = 0x21
	ld de,00220h		;afab
	jr L_AFBB		;afae
L_AFB0:
	ld (ix+012h),001h		;afb0
	ld (ix+00bh),023h		;afb4   ; el dibujo de la cosa = 0x23
	ld de,0fde0h		;afb8
L_AFBB:
	jp L_A653		;afbb
L_AFBE:
	ld a,(ix+005h)		;afbe   ; lee la x de la cosa
	bit 7,(ix+00ah)		;afc1   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	ld c,010h		;afc5
	jr z,L_AFCB		;afc7
	ld c,0f0h		;afc9
L_AFCB:
	add a,c			;afcb
	ld d,a			;afcc
	ld e,(ix+003h)		;afcd   ; lee la y de la cosa
	call 07b98h		;afd0   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	jr nc,L_AFFD		;afd3
	ld d,(ix+005h)		;afd5   ; lee la x de la cosa
	ld e,(ix+003h)		;afd8   ; lee la y de la cosa
	ld b,008h		;afdb
	ld c,008h		;afdd
	ld a,(ix+012h)		;afdf
	and a			;afe2
	jr nz,L_AFF1		;afe3
	ld a,(ix+005h)		;afe5   ; lee la x de la cosa
	cp 0f0h		;afe8
	jr nc,L_AFFD		;afea
	call 07bbeh		;afec
	jr L_AFFB		;afef
L_AFF1:
	ld a,(ix+005h)		;aff1   ; lee la x de la cosa
	cp 010h		;aff4
	jr c,L_AFFD		;aff6
	call 07c1ah		;aff8
L_AFFB:
	jr nc,L_B011		;affb
L_AFFD:
	ld a,(ix+012h)		;affd
	xor 001h		;b000
	ld (ix+012h),a		;b002
	ld e,(ix+009h)		;b005   ; lee la velocidad horizontal (parte baja)
	ld d,(ix+00ah)		;b008   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	call niega_de		;b00b   ; niega_de: DE = -DE
	call L_A653		;b00e
L_B011:
	bit 2,(ix+00ch)		;b011   ; mira el bit 2 de la cuenta de cuadros del paso
	ld c,021h		;b015
	jr z,L_B01A		;b017
	inc c			;b019
L_B01A:
	ld a,(ix+012h)		;b01a
	and a			;b01d
	jr nz,L_B022		;b01e
	inc c			;b020
	inc c			;b021
L_B022:
	ld (ix+00bh),c		;b022   ; guarda el dibujo de la cosa
	dec (ix+00ch)		;b025   ; baja la cuenta de cuadros del paso
	ret nz			;b028
	ld (ix+006h),000h		;b029   ; la cosa se queda quieta
	ld (ix+00ch),004h		;b02d   ; la cuenta de cuadros del paso = 0x04
	inc (ix+001h)		;b031   ; sube el paso en que va la cosa
	ret			;b034
L_B035:
	dec (ix+00ch)		;b035   ; baja la cuenta de cuadros del paso
	ret nz			;b038
	call L_AF9B		;b039
	ld (ix+00ch),030h		;b03c   ; la cuenta de cuadros del paso = 0x30
	ld (ix+006h),001h		;b040   ; la cosa se mueve
	dec (ix+001h)		;b044   ; baja el paso en que va la cosa
	ret			;b047
L_B048:
	ld (ix+011h),040h		;b048
	xor a			;b04c
	ld (ix+006h),a		;b04d   ; guarda si la cosa se mueve
	ld (ix+00eh),a		;b050
	ld (ix+02fh),a		;b053
	ld (ix+034h),a		;b056
	ld (ix+00bh),026h		;b059   ; el dibujo de la cosa = 0x26
	ld (ix+001h),a		;b05d   ; guarda el paso en que va la cosa
	ret			;b060
L_B061:
	ld (ix+006h),001h		;b061   ; la cosa se mueve
	ld (ix+010h),000h		;b065
	ld (ix+00ch),001h		;b069   ; la cuenta de cuadros del paso = 0x01
	bit 7,(ix+00ah)		;b06d   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	ld c,016h		;b071
	jr nz,L_B076		;b073
	inc c			;b075
L_B076:
	ld (ix+00bh),c		;b076   ; guarda el dibujo de la cosa
	jr L_B086		;b079
L_B07B:
	call L_B0B5		;b07b
	dec (ix+00ch)		;b07e   ; baja la cuenta de cuadros del paso
	ret nz			;b081
	ld (ix+00ch),010h		;b082   ; la cuenta de cuadros del paso = 0x10
L_B086:
	ld a,(0c425h)		;b086   ; lee la Y de Simon
	ld de,0ff00h		;b089
	inc a			;b08c
	cp (ix+003h)		;b08d   ; compara con la y de la cosa
	jr c,L_B09F		;b090
	ld de,00100h		;b092
	sub 018h		;b095
	cp (ix+003h)		;b097   ; compara con la y de la cosa
	jr nc,L_B09F		;b09a
	ld de,00000h		;b09c
L_B09F:
	call pon_velocidad_y		;b09f   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld de,0fee0h		;b0a2
	ld hl,0c427h		;b0a5   ; apunta a la X de Simon
	ld a,(ix+005h)		;b0a8   ; lee la x de la cosa
	sub (hl)			;b0ab
	jr nc,L_B0B1		;b0ac
	ld de,00120h		;b0ae
L_B0B1:
	call pon_velocidad_x		;b0b1   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ret			;b0b4
L_B0B5:
	ld a,016h		;b0b5
	bit 2,(ix+00ch)		;b0b7   ; mira el bit 2 de la cuenta de cuadros del paso
	jr z,L_B0BE		;b0bb
	inc a			;b0bd
L_B0BE:
	bit 7,(ix+00ah)		;b0be   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_B0C6		;b0c2
	add a,002h		;b0c4
L_B0C6:
	ld (ix+00bh),a		;b0c6   ; guarda el dibujo de la cosa
	ret			;b0c9
L_B0CA:
	ld (ix+001h),002h		;b0ca   ; el paso en que va la cosa = 0x02
L_B0CE:
	ld de,00180h		;b0ce
	call pon_velocidad_y		;b0d1   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld de,00300h		;b0d4
	ld a,(0c427h)		;b0d7   ; lee la X de Simon
	sub (ix+005h)		;b0da   ; le resta la x de la cosa
	call c,niega_de		;b0dd   ; niega_de: DE = -DE
	call L_A653		;b0e0
	ld (ix+006h),001h		;b0e3   ; la cosa se mueve
	ld (ix+011h),000h		;b0e7
	ld a,(ix+002h)		;b0eb   ; lee la fraccion de la y de la cosa
	ld (ix+012h),a		;b0ee
	ld a,(ix+003h)		;b0f1   ; lee la y de la cosa
	ld (ix+013h),a		;b0f4
	ret			;b0f7
L_B0F8:
	ld a,(ix+001h)		;b0f8   ; lee el paso en que va la cosa
	dec a			;b0fb
	jr z,L_B13E		;b0fc
	dec a			;b0fe
	jp z,L_B17F		;b0ff
	ld (ix+00bh),01ah		;b102   ; el dibujo de la cosa = 0x1A
	ld (ix+006h),000h		;b106   ; la cosa se queda quieta
	ld a,(0c425h)		;b10a   ; lee la Y de Simon
	sub (ix+003h)		;b10d   ; le resta la y de la cosa
	cp 050h		;b110
	ret nc			;b112
	ld c,01bh		;b113
	ld a,(0c427h)		;b115   ; lee la X de Simon
	sub (ix+005h)		;b118   ; le resta la x de la cosa
	ld de,00180h		;b11b
	jr nc,L_B127		;b11e
	ld de,0fe80h		;b120
	neg		;b123
	ld c,01eh		;b125
L_B127:
	cp 040h		;b127
	ret nc			;b129
	ld (ix+00bh),c		;b12a   ; guarda el dibujo de la cosa
	call pon_velocidad_x		;b12d   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+006h),001h		;b130   ; la cosa se mueve
	ld de,00180h		;b134
	call pon_velocidad_y		;b137   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	inc (ix+001h)		;b13a   ; sube el paso en que va la cosa
	ret			;b13d
L_B13E:
	ld a,(0c425h)		;b13e   ; lee la Y de Simon
	sub (ix+005h)		;b141   ; le resta la x de la cosa
	sub 004h		;b144
	cp 010h		;b146
	jr nc,L_B158		;b148
	ld a,(ix+003h)		;b14a   ; lee la y de la cosa
	ld (ix+013h),a		;b14d
	ld (ix+015h),000h		;b150
	ld (ix+001h),002h		;b154   ; el paso en que va la cosa = 0x02
L_B158:
	ld a,(ix+011h)		;b158
	rra			;b15b
	rra			;b15c
L_B15D:
	rra			;b15d
	inc (ix+011h)		;b15e
	and 003h		;b161
	ld hl,0b177h		;b163
	bit 7,(ix+00ah)		;b166   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_B16F		;b16a
	ld hl,0b17bh		;b16c
L_B16F:
	call 04061h		;b16f   ; hl_mas_a: HL += A
	ld a,(hl)			;b172
	ld (ix+00bh),a		;b173   ; guarda el dibujo de la cosa
	ret			;b176

; ----------------------------------------------------------------------
; DATOS dos_animaciones_B177: dos animaciones de cuatro dibujos, una por lado
;   (bit 7 de (ix+0x0A)), que p03:B163 va poniendo en (ix+0x0B)
;   0xb177..0xb17f  (8 bytes)
DATA_dos_animaciones_B177:
	defb 01eh,01fh,01eh,020h,01bh,01ch,01bh,01dh	; b177  ... ....

; ======================================================================
; CODIGO 0xb17f..0xb20f  (144 bytes)
; ======================================================================


L_B17F:
	call L_B158		;b17f
	ld de,00019h		;b182
	ld a,(ix+003h)		;b185   ; lee la y de la cosa
	cp (ix+013h)		;b188
	jr c,L_B190		;b18b
	ld de,0ffe7h		;b18d
L_B190:
	jp suma_a_la_velocidad_y		;b190   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
L_B193:
	call L_B212		;b193
	ld (ix+011h),000h		;b196
	ld c,023h		;b19a
	ld a,(ix+003h)		;b19c   ; lee la y de la cosa
	add a,00ch		;b19f
	ld e,a			;b1a1
	ld a,(ix+005h)		;b1a2   ; lee la x de la cosa
	cp 080h		;b1a5
	ld b,0fdh		;b1a7
	jr c,L_B1AD		;b1a9
	ld b,004h		;b1ab
L_B1AD:
	add a,b			;b1ad
	ld d,a			;b1ae
	push ix		;b1af
	call 05f1dh		;b1b1   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	pop ix		;b1b4
	ld a,(0cf31h)		;b1b6
	and a			;b1b9
	ret nz			;b1ba
	ld a,001h		;b1bb
	ld (0cf0ch),a		;b1bd
	jp 099f6h		;b1c0   ; borra_la_cosa: tipo a cero y sus sprites libres
L_B1C3:
	call L_B1E7		;b1c3
	bit 0,(ix+001h)		;b1c6   ; mira el bit 0 de el paso en que va la cosa
	jr nz,L_B1DE		;b1ca
	call distancia_horizontal		;b1cc   ; distancia_horizontal: A = |x de Simon - x de la cosa|
	cp 038h		;b1cf
	ret nc			;b1d1
	ld (ix+00ch),008h		;b1d2   ; la cuenta de cuadros del paso = 0x08
	ld (ix+006h),000h		;b1d6   ; la cosa se queda quieta
	inc (ix+001h)		;b1da   ; sube el paso en que va la cosa
	ret			;b1dd
L_B1DE:
	dec (ix+00ch)		;b1de   ; baja la cuenta de cuadros del paso
	ret nz			;b1e1
	ld (ix+006h),001h		;b1e2   ; la cosa se mueve
	ret			;b1e6
L_B1E7:
	inc (ix+011h)		;b1e7
	ld c,000h		;b1ea
	ld a,(ix+011h)		;b1ec
	cp 007h		;b1ef
	jr c,L_B209		;b1f1
	ld c,001h		;b1f3
	cp 00dh		;b1f5
	jr c,L_B209		;b1f7
	ld c,002h		;b1f9
	cp 013h		;b1fb
	jr c,L_B209		;b1fd
	ld c,001h		;b1ff
	cp 018h		;b201
	jr c,L_B209		;b203
	ld (ix+011h),000h		;b205
L_B209:
	ld hl,0b20fh		;b209
	jp dibujo_de_la_tabla		;b20c   ; dibujo_de_la_tabla: (ix+0x0B) = el dibujo C de la tabla de HL

; ----------------------------------------------------------------------
; DATOS tres_dibujos_B20F: tres dibujos que p03:B209 pasa a 0xA62F
;   0xb20f..0xb212  (3 bytes)
DATA_tres_dibujos_B20F:
	defb 06dh,06eh,08dh	; b20f

; ======================================================================
; CODIGO 0xb212..0xb24e  (60 bytes)
; ======================================================================


L_B212:
	ld (ix+006h),001h		;b212   ; la cosa se mueve
	ld a,r		;b216
	srl a		;b218
	srl a		;b21a
	srl a		;b21c
	ld b,a			;b21e
	ld a,03ch		;b21f
	sub b			;b221
	ld (ix+00ch),a		;b222   ; guarda la cuenta de cuadros del paso
	ld a,(ix+000h)		;b225   ; lee el tipo de la cosa
	cp 00dh		;b228
	jr nz,L_B234		;b22a
	ld (ix+001h),004h		;b22c   ; el paso en que va la cosa = 0x04
	ld (ix+006h),000h		;b230   ; la cosa se queda quieta
L_B234:
	ld de,0fd80h		;b234
	ld (ix+00bh),067h		;b237   ; el dibujo de la cosa = 0x67
	ld (ix+010h),001h		;b23b
	call pon_velocidad_x		;b23f   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,00000h		;b242
	jp pon_velocidad_y		;b245   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_B248:
	ld a,(ix+001h)		;b248   ; lee el paso en que va la cosa
	call 0406bh		;b24b   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B24E: 5 destinos del despachador de 0x406B (call en p03:B24B):
;   0xB258, 0xB268, 0xB285, 0xB2C7, 0xB31A; lo leen p03:B24B (10 bytes)
;   0xb24e..0xb258  (10 bytes)
DATA_tabla_B24E:
	defb 058h,0b2h	; b24e
	defb 068h,0b2h	; b250
	defb 085h,0b2h	; b252
	defb 0c7h,0b2h	; b254
	defb 01ah,0b3h	; b256

; ======================================================================
; CODIGO 0xb258..0xb33a  (226 bytes)
; ======================================================================


L_B258:
	call distancia_horizontal		;b258   ; distancia_horizontal: A = |x de Simon - x de la cosa|
	cp 03ch		;b25b
	ret nc			;b25d
	ld de,00000h		;b25e
	call pon_velocidad_x		;b261   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	inc (ix+001h)		;b264   ; sube el paso en que va la cosa
	ret			;b267
L_B268:
	call L_B33E		;b268
	ld d,(ix+005h)		;b26b   ; lee la x de la cosa
	ld e,(ix+003h)		;b26e   ; lee la y de la cosa
	call 07b98h		;b271   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	jr c,L_B276		;b274
L_B276:
	inc (ix+001h)		;b276   ; sube el paso en que va la cosa
L_B279:
	call L_A9A2		;b279
	ld (ix+006h),000h		;b27c   ; la cosa se queda quieta
	ld (ix+00ch),002h		;b280   ; la cuenta de cuadros del paso = 0x02
	ret			;b284
L_B285:
	ld c,000h		;b285
	ld hl,0b33ah		;b287
	call dibujo_segun_simon		;b28a   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha
	dec (ix+00ch)		;b28d   ; baja la cuenta de cuadros del paso
	ret nz			;b290
	inc (ix+001h)		;b291   ; sube el paso en que va la cosa
	ld de,0fda0h		;b294
	ld a,(ix+003h)		;b297   ; lee la y de la cosa
	cp 050h		;b29a
	jr c,L_B2A7		;b29c
	ld a,r		;b29e
	and 003h		;b2a0
	jr nz,L_B2A7		;b2a2
	ld de,0f8e0h		;b2a4
L_B2A7:
	call pon_velocidad_y		;b2a7   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_B2AA:
	ld (ix+006h),001h		;b2aa   ; la cosa se mueve
	ld de,00220h		;b2ae
	ld a,(0c427h)		;b2b1   ; lee la X de Simon
	cp (ix+005h)		;b2b4   ; compara con la x de la cosa
	jr nc,L_B2BC		;b2b7
	ld de,0fde0h		;b2b9
L_B2BC:
	call pon_velocidad_x		;b2bc   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld c,001h		;b2bf
	ld hl,0b33ah		;b2c1
	jp dibujo_segun_simon		;b2c4   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha
L_B2C7:
	call L_B33E		;b2c7
	call L_B300		;b2ca
	ld de,00000h		;b2cd
	call c,L_A642		;b2d0
	ld d,(ix+005h)		;b2d3   ; lee la x de la cosa
	ld e,(ix+003h)		;b2d6   ; lee la y de la cosa
	bit 7,(ix+008h)		;b2d9   ; mira el bit 7 de la velocidad vertical
	jr z,L_B2ED		;b2dd
	ld a,e			;b2df
	sub 010h		;b2e0
	ld e,a			;b2e2
	call 07b98h		;b2e3   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;b2e6
	ld de,00000h		;b2e7
	jp pon_velocidad_y		;b2ea   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_B2ED:
	call 07b98h		;b2ed   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;b2f0
	ld c,000h		;b2f1
	ld hl,0b33ah		;b2f3
	call dibujo_segun_simon		;b2f6   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha
	ld (ix+001h),002h		;b2f9   ; el paso en que va la cosa = 0x02
	jp L_B279		;b2fd
L_B300:
	ld d,(ix+005h)		;b300   ; lee la x de la cosa
	ld e,(ix+003h)		;b303   ; lee la y de la cosa
	ld bc,00808h		;b306
	ld a,(ix+00ah)		;b309   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	or (ix+009h)		;b30c   ; OR con la velocidad horizontal (parte baja)
	ret z			;b30f
	bit 7,(ix+00ah)		;b310   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jp nz,07c13h		;b314
	jp 07bb7h		;b317
L_B31A:
	ld c,000h		;b31a
	ld hl,0b33ah		;b31c
	call dibujo_segun_simon		;b31f   ; dibujo_segun_simon: como 0xA62F, dos mas adelante si Simon esta a su derecha
	call distancia_horizontal		;b322   ; distancia_horizontal: A = |x de Simon - x de la cosa|
	cp 03ch		;b325
	jr c,L_B32D		;b327
	dec (ix+00ch)		;b329   ; baja la cuenta de cuadros del paso
	ret nz			;b32c
L_B32D:
	ld de,0ffffh		;b32d
	call pon_velocidad_y		;b330   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+001h),003h		;b333   ; el paso en que va la cosa = 0x03
	jp L_B2AA		;b337

; ----------------------------------------------------------------------
; DATOS dibujos_B33A: cuatro dibujos, dos por lado, para 0xAD37 (p03:B287,
;   B2C1, B2F3, B31C)
;   0xb33a..0xb33e  (4 bytes)
DATA_dibujos_B33A:
	defb 067h,068h,06ah,06bh	; b33a

; ======================================================================
; CODIGO 0xb33e..0xb387  (73 bytes)
; ======================================================================


L_B33E:
	ld de,000a0h		;b33e
	jp suma_a_la_velocidad_y		;b341   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
L_B344:
	ld a,(0c427h)		;b344   ; lee la X de Simon
	ld b,(ix+005h)		;b347   ; lee la x de la cosa
	cp b			;b34a
	ld de,00240h		;b34b
	jr nc,L_B353		;b34e
	ld de,0fdc0h		;b350
L_B353:
	call L_A653		;b353
	ld de,00000h		;b356
	call pon_velocidad_y		;b359   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+006h),001h		;b35c   ; la cosa se mueve
	ld (ix+011h),000h		;b360
L_B364:
	ld a,(0c427h)		;b364   ; lee la X de Simon
	cp (ix+005h)		;b367   ; compara con la x de la cosa
	ld c,047h		;b36a
	jr c,L_B370		;b36c
	ld c,049h		;b36e
L_B370:
	inc (ix+012h)		;b370
	bit 3,(ix+012h)		;b373
	jr nz,L_B37A		;b377
	inc c			;b379
L_B37A:
	ld (ix+00bh),c		;b37a   ; guarda el dibujo de la cosa
	ret			;b37d
L_B37E:
	call L_B364		;b37e
	ld a,(ix+001h)		;b381   ; lee el paso en que va la cosa
	call 0406bh		;b384   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B387: 3 destinos del despachador de 0x406B (call en p03:B384):
;   0xB38D, 0xB451, 0xB4A9; lo leen p03:B384 (6 bytes)
;   0xb387..0xb38d  (6 bytes)
DATA_tabla_B387:
	defb 08dh,0b3h	; b387
	defb 051h,0b4h	; b389
	defb 0a9h,0b4h	; b38b

; ======================================================================
; CODIGO 0xb38d..0xb4f3  (358 bytes)
; ======================================================================


L_B38D:
	ld a,(0c427h)		;b38d   ; lee la X de Simon
	ld b,a			;b390
	ld a,(ix+005h)		;b391   ; lee la x de la cosa
	add a,030h		;b394
	sub b			;b396
	cp 060h		;b397
	jr nc,L_B3A9		;b399
	ld a,(ix+005h)		;b39b   ; lee la x de la cosa
	cp b			;b39e
	ld de,0fdc0h		;b39f
	jr c,L_B3C3		;b3a2
	ld de,00240h		;b3a4
	jr L_B3C3		;b3a7
L_B3A9:
	ld a,(0c427h)		;b3a9   ; lee la X de Simon
	ld b,a			;b3ac
	ld a,(ix+005h)		;b3ad   ; lee la x de la cosa
	add a,050h		;b3b0
	sub b			;b3b2
	cp 0a0h		;b3b3
	jr c,L_B3DB		;b3b5
	ld a,(ix+005h)		;b3b7   ; lee la x de la cosa
	cp b			;b3ba
	ld de,00240h		;b3bb
	jr c,L_B3C3		;b3be
	ld de,0fdc0h		;b3c0
L_B3C3:
	call L_A653		;b3c3
	ld a,(ix+012h)		;b3c6
	and 006h		;b3c9
	jr nz,L_B3DB		;b3cb
	ld (ix+010h),010h		;b3cd
	ld (ix+001h),002h		;b3d1   ; el paso en que va la cosa = 0x02
	ld (ix+006h),000h		;b3d5   ; la cosa se queda quieta
	jr L_B437		;b3d9
L_B3DB:
	ld e,(ix+003h)		;b3db   ; lee la y de la cosa
	ld d,(ix+005h)		;b3de   ; lee la x de la cosa
	ld bc,0080ch		;b3e1
	ld a,(ix+00ah)		;b3e4   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	and 080h		;b3e7
	jr nz,L_B3F8		;b3e9
	call 07bbeh		;b3eb
	jr nc,L_B403		;b3ee
	ld de,0fdc0h		;b3f0
	call L_A653		;b3f3
	jr L_B403		;b3f6
L_B3F8:
	call 07c1ah		;b3f8
	jr nc,L_B403		;b3fb
	ld de,00240h		;b3fd
	call pon_velocidad_x		;b400   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_B403:
	ld e,(ix+003h)		;b403   ; lee la y de la cosa
	ld a,(ix+00ah)		;b406   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	or a			;b409
	ld b,004h		;b40a
	jr z,L_B415		;b40c
	ld b,009h		;b40e
	jp p,L_B415		;b410
	ld b,0fch		;b413
L_B415:
	ld a,(ix+005h)		;b415   ; lee la x de la cosa
	add a,b			;b418
	ld d,a			;b419
	call 07b98h		;b41a   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	jr c,L_B437		;b41d
	ld de,00240h		;b41f
	bit 7,(ix+00ah)		;b422   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	call nz,niega_de		;b426   ; niega_de: DE = -DE
	call pon_velocidad_x		;b429   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,0fb8fh		;b42c
	call pon_velocidad_y		;b42f   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+001h),001h		;b432   ; el paso en que va la cosa = 0x01
	ret			;b436
L_B437:
	ld a,(ix+005h)		;b437   ; lee la x de la cosa
	cp 010h		;b43a
	ld de,00240h		;b43c
	jr c,L_B44E		;b43f
	cp 0eeh		;b441
	ld de,0fdc0h		;b443
	jr nc,L_B44E		;b446
	ld e,(ix+009h)		;b448   ; lee la velocidad horizontal (parte baja)
	ld d,(ix+00ah)		;b44b   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
L_B44E:
	jp L_A653		;b44e
L_B451:
	ld bc,0080ch		;b451
	ld e,(ix+003h)		;b454   ; lee la y de la cosa
	ld d,(ix+005h)		;b457   ; lee la x de la cosa
	bit 7,(ix+00ah)		;b45a   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_B467		;b45e
	call 07c1ah		;b460
	jr nc,L_B472		;b463
	jr L_B46C		;b465
L_B467:
	call 07bbeh		;b467
	jr nc,L_B472		;b46a
L_B46C:
	ld de,00000h		;b46c
	call pon_velocidad_x		;b46f   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_B472:
	ld de,00068h		;b472
	call suma_a_la_velocidad_y		;b475   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
	bit 7,(ix+008h)		;b478   ; mira el bit 7 de la velocidad vertical
	ret nz			;b47c
	ld e,(ix+003h)		;b47d   ; lee la y de la cosa
	ld a,(ix+00ah)		;b480   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	bit 7,a		;b483
	ld b,008h		;b485
	jr nz,L_B490		;b487
	ld b,0fdh		;b489
	and a			;b48b
	jr nz,L_B490		;b48c
	ld b,005h		;b48e
L_B490:
	ld a,(ix+005h)		;b490   ; lee la x de la cosa
	add a,b			;b493
	ld d,a			;b494
	call 07b98h		;b495   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;b498
	xor a			;b499
	ld (ix+001h),a		;b49a   ; guarda el paso en que va la cosa
	ld (ix+002h),a		;b49d   ; guarda la fraccion de la y de la cosa
	call L_A9A2		;b4a0
	ld de,00000h		;b4a3
	jp pon_velocidad_y		;b4a6   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_B4A9:
	dec (ix+010h)		;b4a9
	ret nz			;b4ac
	ld a,r		;b4ad
	rra			;b4af
	ld hl,0fb00h		;b4b0
	jr nc,L_B4B8		;b4b3
	ld hl,0f800h		;b4b5
L_B4B8:
	ld a,(0c427h)		;b4b8   ; lee la X de Simon
	cp (ix+005h)		;b4bb   ; compara con la x de la cosa
	ld de,00180h		;b4be
	jr nc,L_B4C6		;b4c1
	ld de,0fe80h		;b4c3
L_B4C6:
	call 09f61h		;b4c6
	ld (ix+001h),000h		;b4c9   ; el paso en que va la cosa = 0x00
	ld (ix+006h),001h		;b4cd   ; la cosa se mueve
	ret			;b4d1
L_B4D2:
	call L_B611		;b4d2
	ld (ix+006h),001h		;b4d5   ; la cosa se mueve
	ld de,00000h		;b4d9
	ld (ix+00eh),e		;b4dc
	call pon_velocidad_x		;b4df   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	call pon_velocidad_y		;b4e2   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+010h),008h		;b4e5
	ret			;b4e9
L_B4EA:
	call L_B611		;b4ea
	ld a,(ix+001h)		;b4ed   ; lee el paso en que va la cosa
	call 0406bh		;b4f0   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B4F3: 4 destinos del despachador de 0x406B (call en p03:B4F0):
;   0xB4FB, 0xB50D, 0xB513, 0xB526; lo leen p03:B4F0 (8 bytes)
;   0xb4f3..0xb4fb  (8 bytes)
DATA_tabla_B4F3:
	defb 0fbh,0b4h	; b4f3
	defb 00dh,0b5h	; b4f5
	defb 013h,0b5h	; b4f7
	defb 026h,0b5h	; b4f9

; ======================================================================
; CODIGO 0xb4fb..0xb642  (327 bytes)
; ======================================================================


L_B4FB:
	call L_B589		;b4fb
	ret nz			;b4fe
	ld de,00200h		;b4ff
	call pon_velocidad_y		;b502   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+00eh),007h		;b505
	inc (ix+001h)		;b509   ; sube el paso en que va la cosa
	ret			;b50c
L_B50D:
	call L_B569		;b50d
	ret nc			;b510
	jr L_B54B		;b511
L_B513:
	ld (ix+006h),000h		;b513   ; la cosa se queda quieta
	dec (ix+010h)		;b517
	ret nz			;b51a
	call L_B600		;b51b
	ld (ix+010h),01eh		;b51e
	inc (ix+001h)		;b522   ; sube el paso en que va la cosa
	ret			;b525
L_B526:
	ld (ix+006h),001h		;b526   ; la cosa se mueve
	call L_B611		;b52a
	call L_B5C1		;b52d
	jp nc,L_B58E		;b530
	call L_B5E0		;b533
	jp nc,L_B5EF		;b536
	call L_B5AE		;b539
	ld de,00000h		;b53c
	call c,pon_velocidad_x		;b53f   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	call L_B59E		;b542
	jr c,L_B54B		;b545
	dec (ix+010h)		;b547
	ret nz			;b54a
L_B54B:
	ld de,00000h		;b54b
	call pon_velocidad_y		;b54e   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	call pon_velocidad_x		;b551   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld a,(ix+003h)		;b554   ; lee la y de la cosa
	and 0f8h		;b557
	ld (ix+003h),a		;b559   ; guarda la y de la cosa
	ld (ix+006h),000h		;b55c   ; la cosa se queda quieta
	ld (ix+010h),01eh		;b560
	ld (ix+001h),002h		;b564   ; el paso en que va la cosa = 0x02
	ret			;b568
L_B569:
	call L_B5AE		;b569
	ld de,00000h		;b56c
	call c,pon_velocidad_x		;b56f   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	call L_B5E0		;b572
	jr c,L_B57F		;b575
	ld de,00040h		;b577
	call suma_a_la_velocidad_y		;b57a   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
	xor a			;b57d
	ret			;b57e
L_B57F:
	ld a,(ix+003h)		;b57f   ; lee la y de la cosa
	and 0f8h		;b582
	ld (ix+003h),a		;b584   ; guarda la y de la cosa
	scf			;b587
	ret			;b588
L_B589:
	dec (ix+010h)		;b589
	ret nz			;b58c
	ret			;b58d
L_B58E:
	ld (ix+001h),001h		;b58e   ; el paso en que va la cosa = 0x01
	call L_B600		;b592
	ld de,00200h		;b595
	ld de,0fd00h		;b598
	jp pon_velocidad_y		;b59b   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_B59E:
	ld a,(ix+005h)		;b59e   ; lee la x de la cosa
	bit 7,(ix+00ah)		;b5a1   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_B5AA		;b5a5
	cp 010h		;b5a7
	ret			;b5a9
L_B5AA:
	cp 0e8h		;b5aa
	ccf			;b5ac
	ret			;b5ad
L_B5AE:
	ld e,(ix+003h)		;b5ae   ; lee la y de la cosa
	ld d,(ix+005h)		;b5b1   ; lee la x de la cosa
	ld a,d			;b5b4
	or e			;b5b5
	ret z			;b5b6
	bit 7,(ix+00ah)		;b5b7   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jp z,07bb7h		;b5bb
	jp 07c13h		;b5be
L_B5C1:
	ld a,(0c425h)		;b5c1   ; lee la Y de Simon
	sub 010h		;b5c4
	cp (ix+003h)		;b5c6   ; compara con la y de la cosa
	ccf			;b5c9
	ret c			;b5ca
	ld e,(ix+003h)		;b5cb   ; lee la y de la cosa
	ld d,(ix+005h)		;b5ce   ; lee la x de la cosa
	ld a,008h		;b5d1
	bit 7,(ix+00ah)		;b5d3   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr z,L_B5DB		;b5d7
	ld a,0f8h		;b5d9
L_B5DB:
	add a,d			;b5db
	ld d,a			;b5dc
	jp 07ba3h		;b5dd
L_B5E0:
	xor a			;b5e0
	bit 7,(ix+008h)		;b5e1   ; mira el bit 7 de la velocidad vertical
	ret nz			;b5e5
	ld e,(ix+003h)		;b5e6   ; lee la y de la cosa
	ld d,(ix+005h)		;b5e9   ; lee la x de la cosa
	jp 07ba3h		;b5ec
L_B5EF:
	ld de,00000h		;b5ef
	call pon_velocidad_x		;b5f2   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,00200h		;b5f5
	call pon_velocidad_y		;b5f8   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+001h),001h		;b5fb   ; el paso en que va la cosa = 0x01
	ret			;b5ff
L_B600:
	ld a,(0c427h)		;b600   ; lee la X de Simon
	cp (ix+005h)		;b603   ; compara con la x de la cosa
	ld de,001c0h		;b606
	jr nc,L_B60E		;b609
	ld de,0fe40h		;b60b
L_B60E:
	jp pon_velocidad_x		;b60e   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_B611:
	ld a,(0d000h)		;b611   ; lee la FASE (0 el patio, 1-18)
	ld de,L_B63E+1		;b614
	call 06542h		;b617   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld a,(0d001h)		;b61a   ; lee la HABITACION dentro de la fase
	srl a		;b61d
	push af			;b61f
	call 04066h		;b620   ; de_mas_a: DE += A
	pop af			;b623
	ld a,(de)			;b624
	jr c,L_B62B		;b625
	rra			;b627
	rra			;b628
	rra			;b629
	rra			;b62a
L_B62B:
	and 00fh		;b62b
	ld hl,0b642h		;b62d
	call 04061h		;b630   ; hl_mas_a: HL += A
	ld a,(hl)			;b633
	inc (ix+00ch)		;b634   ; sube la cuenta de cuadros del paso
	bit 4,(ix+00ch)		;b637   ; mira el bit 4 de la cuenta de cuadros del paso
	jr z,L_B63E		;b63b
	inc a			;b63d
L_B63E:
	ld (ix+00bh),a		;b63e   ; guarda el dibujo de la cosa
	ret			;b641

; ----------------------------------------------------------------------
; DATOS tabla_B642: p03:B62D la indexa con cuatro bits: dibujos, punteros a
;   las listas de 0xB665-0xB6A5 y las listas
;   0xb642..0xb6ab  (105 bytes)
DATA_tabla_B642:
	defb 000h,09bh,09dh,09fh,0a1h,065h,0b6h,068h,0b6h,06bh,0b6h,06eh,0b6h,073h,0b6h,077h	; b642  .....e.h.k.n.s.w
	defb 0b6h,07ch,0b6h,081h,0b6h,084h,0b6h,08ah,0b6h,090h,0b6h,094h,0b6h,099h,0b6h,09fh	; b652  .|..............
	defb 0b6h,0a5h,0b6h,032h,032h,033h,033h,033h,033h,011h,013h,031h,044h,011h,001h,013h	; b662  ...223333..1D...
	defb 030h,033h,001h,013h,031h,033h,033h,004h,011h,000h,020h,000h,000h,033h,030h,014h	; b672  03..133... ..30.
	defb 000h,004h,044h,044h,044h,044h,044h,044h,010h,040h,000h,041h,011h,014h,044h,041h	; b682  ..DDDDDD.@.A..DA
	defb 044h,044h,044h,044h,044h,044h,041h,011h,011h,011h,011h,011h,011h,011h,044h,044h	; b692  DDDDDDA.......DD
	defb 040h,044h,004h,044h,044h,044h,044h,044h,044h	; b6a2  @D.DDDDDD

; ======================================================================
; CODIGO 0xb6ab..0xb6b9  (14 bytes)
; ======================================================================


L_B6AB:
	ld a,(0ce0bh)		;b6ab
	or a			;b6ae
	jr nz,$+22		;b6af
	ld a,(0ce00h)		;b6b1
	dec a			;b6b4
	ret m			;b6b5
	call 0406bh		;b6b6   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B6B9: 6 destinos del despachador de 0x406B (call en p03:B6B6):
;   0xBE2B, 0xBCDB, 0xB857, 0xBA26, 0xBBF3, 0x65B0; lo leen p03:B6B6 (12
;   bytes)
;   0xb6b9..0xb6c5  (12 bytes)
DATA_tabla_B6B9:
	defb 02bh,0beh	; b6b9
	defb 0dbh,0bch	; b6bb
	defb 057h,0b8h	; b6bd
	defb 026h,0bah	; b6bf
	defb 0f3h,0bbh	; b6c1
	defb 0b0h,065h	; b6c3

; ======================================================================
; CODIGO 0xb6c5..0xb6cb  (6 bytes)
; ======================================================================


L_B6C5:
	ld a,(0ce10h)		;b6c5
	call 0406bh		;b6c8   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B6CB: 7 destinos del despachador de 0x406B (call en p03:B6C8):
;   0xB6D9, 0xB6E3, 0xB6ED, 0xB706, 0xB6E3, 0xB736, 0xB751; lo leen p03:B6C8
;   (14 bytes)
;   0xb6cb..0xb6d9  (14 bytes)
DATA_tabla_B6CB:
	defb 0d9h,0b6h	; b6cb
	defb 0e3h,0b6h	; b6cd
	defb 0edh,0b6h	; b6cf
	defb 006h,0b7h	; b6d1
	defb 0e3h,0b6h	; b6d3
	defb 036h,0b7h	; b6d5
	defb 051h,0b7h	; b6d7

; ======================================================================
; CODIGO 0xb6d9..0xb7a7  (206 bytes)
; ======================================================================


L_B6D9:
	call 07806h		;b6d9
	ld a,03ch		;b6dc
	ld (0ce02h),a		;b6de
	jr L_B6E8		;b6e1
L_B6E3:
	ld hl,0ce02h		;b6e3
	dec (hl)			;b6e6
	ret nz			;b6e7
L_B6E8:
	ld hl,0ce10h		;b6e8
	inc (hl)			;b6eb
	ret			;b6ec
L_B6ED:
	call 057c0h		;b6ed
	xor a			;b6f0
	ld (0ce11h),a		;b6f1
	ld (0ce14h),a		;b6f4
	ld c,022h		;b6f7
	ld de,07840h		;b6f9
	call 05f1dh		;b6fc   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	ld a,0b4h		;b6ff
	ld (0ce02h),a		;b701
	jr L_B6E8		;b704
L_B706:
	ld a,(0ce11h)		;b706
	and a			;b709
	jr nz,L_B725		;b70a
	ld a,(0ce14h)		;b70c
	and a			;b70f
	ret z			;b710
	ld hl,0ce02h		;b711
	dec (hl)			;b714
	ret nz			;b715
	ld a,006h		;b716
	ld (0ce10h),a		;b718
	ld a,090h		;b71b
	ld (0ce02h),a		;b71d
	ld a,08ch		;b720
	jp 0509fh		;b722   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_B725:
	ld a,000h		;b725
	call 0509fh		;b727   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,08ch		;b72a
	call 0509fh		;b72c   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,096h		;b72f
	ld (0ce02h),a		;b731
	jr L_B6E8		;b734
L_B736:
	ld a,(0c003h)		;b736   ; lee el contador de cuadros
	rra			;b739
	ret c			;b73a
	ld a,(0c415h)		;b73b   ; lee la vida de Simon
	cp 020h		;b73e
	jr nc,L_B74A		;b740
	ld a,001h		;b742
	call 0509fh		;b744   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jp 04651h		;b747
L_B74A:
	ld a,03ch		;b74a
	ld (0ce02h),a		;b74c
	jr L_B6E8		;b74f
L_B751:
	ld hl,0ce02h		;b751
	dec (hl)			;b754
	ret nz			;b755
	ld a,0e0h		;b756
	ld (0c425h),a		;b758   ; guarda la Y de Simon
	ld hl,0d600h		;b75b
	ld b,080h		;b75e
L_B760:
	ld (hl),0e0h		;b760
	inc hl			;b762
	djnz L_B760		;b763
	xor a			;b765
	ld (0ce0bh),a		;b766
	ld (0ce00h),a		;b769
	ld (0ce0ch),a		;b76c
	ld (0ce11h),a		;b76f
	inc a			;b772
	ld (0c409h),a		;b773
	ret			;b776
L_B777:
	ld a,05ah		;b777
	ld (ix+010h),a		;b779
	ld a,001h		;b77c
	ld (0ce0ch),a		;b77e
	ld (ix+00bh),08fh		;b781   ; el dibujo de la cosa = 0x8F
	ld (ix+006h),000h		;b785   ; la cosa se queda quieta
	ld (ix+00eh),000h		;b789
	ld (ix+00ch),000h		;b78d   ; la cuenta de cuadros del paso = 0x00
	ld (ix+07eh),000h		;b791
	ld de,00000h		;b795
	call pon_velocidad_x		;b798   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,00100h		;b79b
	jp pon_velocidad_y		;b79e   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_B7A1:
	ld a,(ix+001h)		;b7a1   ; lee el paso en que va la cosa
	call 0406bh		;b7a4   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B7A7: 3 destinos del despachador de 0x406B (call en p03:B7A4):
;   0xB7AD, 0xB818, 0xB83F; lo leen p03:B7A4 (6 bytes)
;   0xb7a7..0xb7ad  (6 bytes)
DATA_tabla_B7A7:
	defb 0adh,0b7h	; b7a7
	defb 018h,0b8h	; b7a9
	defb 03fh,0b8h	; b7ab

; ======================================================================
; CODIGO 0xb7ad..0xb7fa  (77 bytes)
; ======================================================================


L_B7AD:
	ld a,(0c003h)		;b7ad   ; lee el contador de cuadros
	and 001h		;b7b0
	ld c,0ffh		;b7b2
	jr nz,L_B7B7		;b7b4
	inc c			;b7b6
L_B7B7:
	call L_B7CB		;b7b7
	dec (ix+010h)		;b7ba
	ret nz			;b7bd
	ld c,0ffh		;b7be
	call L_B7CB		;b7c0
	ld (ix+006h),001h		;b7c3   ; la cosa se mueve
	inc (ix+001h)		;b7c7   ; sube el paso en que va la cosa
	ret			;b7ca
L_B7CB:
	ld a,(0d000h)		;b7cb   ; lee la FASE (0 el patio, 1-18)
	ld de,0b7fah		;b7ce
	sub 003h		;b7d1
	jr z,L_B7D8		;b7d3
	ld de,0b809h		;b7d5
L_B7D8:
	ld a,(ix+00bh)		;b7d8   ; lee el dibujo de la cosa
	sub 08fh		;b7db
	ld b,a			;b7dd
	add a,a			;b7de
	add a,a			;b7df
	add a,b			;b7e0
	call 04066h		;b7e1   ; de_mas_a: DE += A
	push ix		;b7e4
	pop hl			;b7e6
	ld a,025h		;b7e7
	add a,l			;b7e9
	ld l,a			;b7ea
	ld b,005h		;b7eb
L_B7ED:
	ld a,(de)			;b7ed
	inc de			;b7ee
	and c			;b7ef
	ld (hl),a			;b7f0
	ld a,005h		;b7f1
	add a,l			;b7f3
	ld l,a			;b7f4
	djnz L_B7ED		;b7f5
	ld (hl),000h		;b7f7
	ret			;b7f9

; ----------------------------------------------------------------------
; DATOS dos_listas_de_quince: dos listas de quince bytes: p03:B7CB usa la de
;   0xB7FA en la fase 3 y la de 0xB809 en las demas; los mismos bytes los usan
;   p00:54DF y p02:8F4A como coordenadas de VRAM
;   0xb7fa..0xb818  (30 bytes)
DATA_dos_listas_de_quince:
	defb 00eh,008h,006h,002h,000h,00eh,008h,006h,004h,002h,008h,006h,004h,002h,000h,00eh	; b7fa  ................
	defb 008h,007h,002h,000h,00eh,008h,007h,005h,002h,008h,007h,005h,002h,000h	; b80a  ..............

; ======================================================================
; CODIGO 0xb818..0xb853  (59 bytes)
; ======================================================================


L_B818:
	call L_B83F		;b818
	ld e,(ix+003h)		;b81b   ; lee la y de la cosa
	ld d,(ix+005h)		;b81e   ; lee la x de la cosa
	call 07b98h		;b821   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;b824
	ld (ix+006h),000h		;b825   ; la cosa se queda quieta
	ld (ix+00bh),08fh		;b829   ; el dibujo de la cosa = 0x8F
	ld c,0ffh		;b82d
	call L_B7CB		;b82f
	ld (ix+00eh),002h		;b832
	ld a,001h		;b836
	ld (0ce14h),a		;b838
	inc (ix+001h)		;b83b   ; sube el paso en que va la cosa
	ret			;b83e
L_B83F:
	ld a,(ix+00ch)		;b83f   ; lee la cuenta de cuadros del paso
	inc (ix+00ch)		;b842   ; sube la cuenta de cuadros del paso
	rra			;b845
	and 003h		;b846
	ld hl,0b853h		;b848
	call 04061h		;b84b   ; hl_mas_a: HL += A
	ld a,(hl)			;b84e
	ld (ix+00bh),a		;b84f   ; guarda el dibujo de la cosa
	ret			;b852

; ----------------------------------------------------------------------
; DATOS cuatro_dibujos_B853: cuatro dibujos que p03:B848 elige con dos bits de
;   una cuenta y deja en (ix+0x0B)
;   0xb853..0xb857  (4 bytes)
DATA_cuatro_dibujos_B853:
	defb 08fh,090h,091h,090h	; b853

; ======================================================================
; CODIGO 0xb857..0xb85d  (6 bytes)
; ======================================================================


L_B857:
	ld a,(0ce01h)		;b857   ; lee el paso de la escena
	call 0406bh		;b85a   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B85D: 2 destinos del despachador de 0x406B (call en p03:B85A):
;   0xB861, 0xB874; lo leen p03:B85A (4 bytes)
;   0xb85d..0xb861  (4 bytes)
DATA_tabla_B85D:
	defb 061h,0b8h	; b85d
	defb 074h,0b8h	; b85f

; ======================================================================
; CODIGO 0xb861..0xb899  (56 bytes)
; ======================================================================


L_B861:
	ld c,014h		;b861
	ld de,030c5h		;b863
	call 05f1dh		;b866   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	ld c,014h		;b869
	ld de,0d0c5h		;b86b
	call 05f1dh		;b86e   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	jp siguiente_paso		;b871   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_B874:
	ld a,(0ce15h)		;b874
	and a			;b877
	ret z			;b878
	jp L_BE47		;b879
L_B87C:
	ld (ix+00bh),036h		;b87c   ; el dibujo de la cosa = 0x36
	ld (ix+010h),020h		;b880
	ld de,00000h		;b884
	call pon_velocidad_y		;b887   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+014h),002h		;b88a
	ld (ix+015h),001h		;b88e
	ret			;b892
L_B893:
	ld a,(ix+001h)		;b893   ; lee el paso en que va la cosa
	call 0406bh		;b896   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B899: 4 destinos del despachador de 0x406B (call en p03:B896):
;   0xB8A1, 0xB8AD, 0xB8D0, 0xB960; lo leen p03:B896 (8 bytes)
;   0xb899..0xb8a1  (8 bytes)
DATA_tabla_B899:
	defb 0a1h,0b8h	; b899
	defb 0adh,0b8h	; b89b
	defb 0d0h,0b8h	; b89d
	defb 060h,0b9h	; b89f

; ======================================================================
; CODIGO 0xb8a1..0xb9c7  (294 bytes)
; ======================================================================


L_B8A1:
	dec (ix+010h)		;b8a1
	ret nz			;b8a4
	inc (ix+001h)		;b8a5   ; sube el paso en que va la cosa
	ld (ix+006h),001h		;b8a8   ; la cosa se mueve
	ret			;b8ac
L_B8AD:
	ld de,0fdd0h		;b8ad
	ld (ix+012h),001h		;b8b0
	ld a,(0c427h)		;b8b4   ; lee la X de Simon
	cp (ix+005h)		;b8b7   ; compara con la x de la cosa
	jr c,L_B8C3		;b8ba
	ld de,00230h		;b8bc
	ld (ix+012h),000h		;b8bf
L_B8C3:
	call pon_velocidad_x		;b8c3   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	inc (ix+001h)		;b8c6   ; sube el paso en que va la cosa
	ld (ix+013h),007h		;b8c9
	jp L_B9B6		;b8cd
L_B8D0:
	call L_B9CF		;b8d0
	dec (ix+010h)		;b8d3
	jr nz,L_B930		;b8d6
	call L_B9B6		;b8d8
	ld (ix+013h),007h		;b8db
	inc (ix+017h)		;b8df
	bit 0,(ix+017h)		;b8e2
	jr z,L_B8F0		;b8e6
	bit 7,(ix+00ah)		;b8e8   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_B90D		;b8ec
	jr L_B8F8		;b8ee
L_B8F0:
	ld a,(0c427h)		;b8f0   ; lee la X de Simon
	cp (ix+005h)		;b8f3   ; compara con la x de la cosa
	jr nc,L_B90D		;b8f6
L_B8F8:
	ld de,0fdd0h		;b8f8
	call pon_velocidad_x		;b8fb   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+012h),001h		;b8fe
	ld a,(0c427h)		;b902   ; lee la X de Simon
	cp (ix+005h)		;b905   ; compara con la x de la cosa
	jr c,L_B922		;b908
	call L_B9CF		;b90a
L_B90D:
	ld de,00230h		;b90d
	call pon_velocidad_x		;b910   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+012h),000h		;b913
	ld a,(0c427h)		;b917   ; lee la X de Simon
	cp (ix+005h)		;b91a   ; compara con la x de la cosa
	jr nc,L_B922		;b91d
	jp L_B9CF		;b91f
L_B922:
	inc (ix+001h)		;b922   ; sube el paso en que va la cosa
	ld (ix+006h),000h		;b925   ; la cosa se queda quieta
	ld (ix+011h),030h		;b929
	jp L_B9CF		;b92d
L_B930:
	ld a,(ix+005h)		;b930   ; lee la x de la cosa
	cp 020h		;b933
	jr c,L_B93A		;b935
	cp 0e1h		;b937
	ret c			;b939
L_B93A:
	bit 7,(ix+00ah)		;b93a   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	ld de,00230h		;b93e
	call pon_velocidad_x		;b941   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+012h),000h		;b944
	ld (ix+005h),020h		;b948   ; la x de la cosa = 0x20
	jr nz,L_B95B		;b94c
	ld de,0fdd0h		;b94e
	call pon_velocidad_x		;b951   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+005h),0e0h		;b954   ; la x de la cosa = 0xE0
	inc (ix+012h)		;b958
L_B95B:
	call L_B9CF		;b95b
	jr L_B9B6		;b95e
L_B960:
	dec (ix+011h)		;b960
	jr z,L_B985		;b963
	ld a,008h		;b965
	bit 0,(ix+011h)		;b967
	jr z,L_B96F		;b96b
	ld a,04ch		;b96d
L_B96F:
	ld (ix+025h),002h		;b96f
	ld (ix+02ah),a		;b973
	ld (ix+02fh),002h		;b976
	ld (ix+034h),a		;b97a
	ld (ix+039h),002h		;b97d
	ld (ix+03eh),a		;b981
	ret			;b984
L_B985:
	ld a,(ix+003h)		;b985   ; lee la y de la cosa
	sub 038h		;b988
	ld e,a			;b98a
	ld d,(ix+005h)		;b98b   ; lee la x de la cosa
	ld a,040h		;b98e
	call L_A0ED		;b990
	ld a,(ix+012h)		;b993
	rrca			;b996
	xor d			;b997
	call m,niega_de		;b998   ; niega_de: DE = -DE
	ld a,(ix+003h)		;b99b   ; lee la y de la cosa
	sub 018h		;b99e
	ld c,a			;b9a0
	ld b,(ix+005h)		;b9a1   ; lee la x de la cosa
	ld a,014h		;b9a4
	call 09f6dh		;b9a6   ; crea_con_parametros: guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa
	ld a,00ah		;b9a9
	call L_A4E8		;b9ab
	dec (ix+001h)		;b9ae   ; baja el paso en que va la cosa
	ld (ix+006h),001h		;b9b1   ; la cosa se mueve
	ret			;b9b5
L_B9B6:
	ld a,r		;b9b6
	or 080h		;b9b8
	ld hl,0b9c7h		;b9ba
	and 007h		;b9bd
	call 04061h		;b9bf   ; hl_mas_a: HL += A
	ld a,(hl)			;b9c2
	ld (ix+010h),a		;b9c3
	ret			;b9c6

; ----------------------------------------------------------------------
; DATOS ocho_valores_al_azar: ocho valores de los que p03:B9BA coge uno al
;   azar (`ld a,r / and 7`) y lo deja en (ix+0x10)
;   0xb9c7..0xb9cf  (8 bytes)
DATA_ocho_valores_al_azar:
	defb 040h,008h,030h,010h,020h,018h,038h,028h	; b9c7  @.0. .8(

; ======================================================================
; CODIGO 0xb9cf..0xba20  (81 bytes)
; ======================================================================


L_B9CF:
	ld hl,0ba23h		;b9cf
	bit 0,(ix+012h)		;b9d2
	jr z,L_B9DB		;b9d6
	ld hl,0ba20h		;b9d8
L_B9DB:
	inc (ix+013h)		;b9db
	ld a,(ix+013h)		;b9de
	cp 008h		;b9e1
	jr nz,L_BA15		;b9e3
	ld (ix+013h),000h		;b9e5
	bit 0,(ix+015h)		;b9e9
	jr z,L_BA03		;b9ed
	inc (ix+014h)		;b9ef
	ld a,(ix+014h)		;b9f2
	cp 003h		;b9f5
	jr nz,L_BA15		;b9f7
	ld (ix+014h),001h		;b9f9
	ld (ix+015h),000h		;b9fd
	jr L_BA15		;ba01
L_BA03:
	dec (ix+014h)		;ba03
	ld a,(ix+014h)		;ba06
	cp 0ffh		;ba09
	jr nz,L_BA15		;ba0b
	ld (ix+014h),001h		;ba0d
	ld (ix+015h),001h		;ba11
L_BA15:
	ld a,(ix+014h)		;ba15
	call 04061h		;ba18   ; hl_mas_a: HL += A
	ld a,(hl)			;ba1b
	ld (ix+00bh),a		;ba1c   ; guarda el dibujo de la cosa
	ret			;ba1f

; ----------------------------------------------------------------------
; DATOS dos_animaciones_BA20: dos animaciones de tres dibujos (0xBA20 y
;   0xBA23) que p03:B9CF elige con el bit 0 de (ix+0x12)
;   0xba20..0xba26  (6 bytes)
DATA_dos_animaciones_BA20:
	defb 033h,034h,035h,036h,037h,038h	; ba20

; ======================================================================
; CODIGO 0xba26..0xba2c  (6 bytes)
; ======================================================================


L_BA26:
	ld a,(0ce01h)		;ba26   ; lee el paso de la escena
	call 0406bh		;ba29   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BA2C: 2 destinos del despachador de 0x406B (call en p03:BA29):
;   0xBA30, 0xBA47; lo leen p03:BA29 (4 bytes)
;   0xba2c..0xba30  (4 bytes)
DATA_tabla_BA2C:
	defb 030h,0bah	; ba2c
	defb 047h,0bah	; ba2e

; ======================================================================
; CODIGO 0xba30..0xbacf  (159 bytes)
; ======================================================================


L_BA30:
	xor a			;ba30
	ld (0ce07h),a		;ba31
	ld c,015h		;ba34
	ld de,0d0c0h		;ba36
	call 05f1dh		;ba39   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	ld c,018h		;ba3c
	ld de,0d0a0h		;ba3e
	call 05f1dh		;ba41   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	jp siguiente_paso		;ba44   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_BA47:
	ld a,(0ce15h)		;ba47
	and a			;ba4a
	ret z			;ba4b
	jp L_BE47		;ba4c
L_BA4F:
	ld (ix+011h),000h		;ba4f
	ld (ix+010h),030h		;ba53
	ld (ix+006h),001h		;ba57   ; la cosa se mueve
	ld de,00000h		;ba5b
	call pon_velocidad_x		;ba5e   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	jp pon_velocidad_y		;ba61   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_BA64:
	ld a,(ix+010h)		;ba64
	and a			;ba67
	call nz,L_BAD3		;ba68
	call L_BAB9		;ba6b
	ld a,(ix+001h)		;ba6e   ; lee el paso en que va la cosa
	dec a			;ba71
	jr z,L_BA97		;ba72
	ld (ix+00ch),020h		;ba74   ; la cuenta de cuadros del paso = 0x20
	ld a,(0c427h)		;ba78   ; lee la X de Simon
	sub (ix+005h)		;ba7b   ; le resta la x de la cosa
	jr nc,L_BA89		;ba7e
	add a,040h		;ba80
	jr c,L_BA89		;ba82
	ld de,0fde0h		;ba84
	jr L_BA8C		;ba87
L_BA89:
	ld de,00220h		;ba89
L_BA8C:
	ld (0ce09h),de		;ba8c
	call pon_velocidad_x		;ba90   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	inc (ix+001h)		;ba93   ; sube el paso en que va la cosa
	ret			;ba96
L_BA97:
	call L_BAA3		;ba97
	dec (ix+00ch)		;ba9a   ; baja la cuenta de cuadros del paso
	ret nz			;ba9d
	ld (ix+001h),000h		;ba9e   ; el paso en que va la cosa = 0x00
	ret			;baa2
L_BAA3:
	ld a,(ix+005h)		;baa3   ; lee la x de la cosa
	cp 0e0h		;baa6
	jr nc,L_BAB3		;baa8
	cp 010h		;baaa
	ret nc			;baac
	ld de,00220h		;baad
	jp pon_velocidad_x		;bab0   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_BAB3:
	ld de,0fde0h		;bab3
	jp pon_velocidad_x		;bab6   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_BAB9:
	ld hl,0bacfh		;bab9
	inc (ix+011h)		;babc
	ld a,(ix+011h)		;babf
	rra			;bac2
	rra			;bac3
	rra			;bac4
	and 003h		;bac5
	call 04061h		;bac7   ; hl_mas_a: HL += A
	ld a,(hl)			;baca
	ld (ix+00bh),a		;bacb   ; guarda el dibujo de la cosa
	ret			;bace

; ----------------------------------------------------------------------
; DATOS cuatro_dibujos_BACF: cuatro dibujos que p03:BAB9 va poniendo con la
;   cuenta de (ix+0x11)
;   0xbacf..0xbad3  (4 bytes)
DATA_cuatro_dibujos_BACF:
	defb 079h,07ah,07bh,07ah	; bacf

; ======================================================================
; CODIGO 0xbad3..0xbbf9  (294 bytes)
; ======================================================================


L_BAD3:
	dec (ix+010h)		;bad3
	ret nz			;bad6
	ld a,001h		;bad7
	ld (0ce07h),a		;bad9
	ret			;badc
L_BADD:
	ld (ix+006h),001h		;badd   ; la cosa se mueve
	ld (ix+010h),000h		;bae1
	ld de,00000h		;bae5
	call pon_velocidad_y		;bae8   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	call pon_velocidad_x		;baeb   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	call L_BBE1		;baee
	xor a			;baf1
	ld (ix+011h),a		;baf2
	ret			;baf5
L_BAF6:
	ld a,(ix+001h)		;baf6   ; lee el paso en que va la cosa
	dec a			;baf9
	jr z,L_BB23		;bafa
	dec a			;bafc
	jp z,L_BB8F		;bafd
	call L_BBC0		;bb00
	ret c			;bb03
	ld a,(0ce07h)		;bb04
	and a			;bb07
	jr z,L_BB18		;bb08
	ld (ix+011h),000h		;bb0a
	ld de,0fa00h		;bb0e
	call pon_velocidad_y		;bb11   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	inc (ix+001h)		;bb14   ; sube el paso en que va la cosa
	ret			;bb17
L_BB18:
	ld (ix+00bh),067h		;bb18   ; el dibujo de la cosa = 0x67
	ld de,(0ce09h)		;bb1c
	jp pon_velocidad_x		;bb20   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_BB23:
	call L_BBC0		;bb23
	ret c			;bb26
	inc (ix+011h)		;bb27
	ld a,(ix+011h)		;bb2a
	ld c,067h		;bb2d
	cp 004h		;bb2f
	jr c,L_BB34		;bb31
	inc c			;bb33
L_BB34:
	call L_BBE6		;bb34
	call L_BBD4		;bb37
	ld de,00060h		;bb3a
	call suma_a_la_velocidad_y		;bb3d   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
	ld a,(ix+005h)		;bb40   ; lee la x de la cosa
	cp 0e8h		;bb43
	ld e,(ix+009h)		;bb45   ; lee la velocidad horizontal (parte baja)
	ld d,(ix+00ah)		;bb48   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	push af			;bb4b
	call nc,L_BB7D		;bb4c
	pop af			;bb4f
	cp 014h		;bb50
	call c,L_BB86		;bb52
	bit 7,(ix+008h)		;bb55   ; mira el bit 7 de la velocidad vertical
	ret nz			;bb59
	ld e,(ix+003h)		;bb5a   ; lee la y de la cosa
	ld d,(ix+005h)		;bb5d   ; lee la x de la cosa
	call 07b98h		;bb60   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;bb63
	ld c,069h		;bb64
	call L_BBE6		;bb66
	ld (ix+006h),000h		;bb69   ; la cosa se queda quieta
	ld a,(ix+003h)		;bb6d   ; lee la y de la cosa
	and 0f8h		;bb70
	ld (ix+003h),a		;bb72   ; guarda la y de la cosa
	ld (ix+00ch),010h		;bb75   ; la cuenta de cuadros del paso = 0x10
	inc (ix+001h)		;bb79   ; sube el paso en que va la cosa
	ret			;bb7c
L_BB7D:
	bit 7,d		;bb7d
	ret nz			;bb7f
	call niega_de		;bb80   ; niega_de: DE = -DE
	jp pon_velocidad_x		;bb83   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_BB86:
	bit 7,d		;bb86
	ret z			;bb88
	call niega_de		;bb89   ; niega_de: DE = -DE
	jp pon_velocidad_x		;bb8c   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_BB8F:
	call L_BBC0		;bb8f
	ld (ix+006h),000h		;bb92   ; la cosa se queda quieta
	ret c			;bb96
	dec (ix+00ch)		;bb97   ; baja la cuenta de cuadros del paso
	ret nz			;bb9a
	ld a,(ix+003h)		;bb9b   ; lee la y de la cosa
	ld de,0f880h		;bb9e
	cp 080h		;bba1
	jr nc,L_BBA8		;bba3
	ld de,0fa80h		;bba5
L_BBA8:
	ld a,r		;bba8
	or 080h		;bbaa
	ld l,a			;bbac
	ld h,000h		;bbad
	add hl,hl			;bbaf
	add hl,de			;bbb0
	call pon_velocidad_y		;bbb1   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+006h),001h		;bbb4   ; la cosa se mueve
	xor a			;bbb8
	ld (ix+011h),a		;bbb9
	ld (ix+001h),a		;bbbc   ; guarda el paso en que va la cosa
	ret			;bbbf
L_BBC0:
	ld a,(ix+010h)		;bbc0
	and a			;bbc3
	jr z,L_BBCF		;bbc4
	dec (ix+010h)		;bbc6
	ld (ix+006h),000h		;bbc9   ; la cosa se queda quieta
	scf			;bbcd
	ret			;bbce
L_BBCF:
	ld (ix+006h),001h		;bbcf   ; la cosa se mueve
	ret			;bbd3
L_BBD4:
	dec (ix+012h)		;bbd4
	ret nz			;bbd7
	call L_BBE1		;bbd8
	call L_A0E5		;bbdb
	jp 09f61h		;bbde
L_BBE1:
	ld (ix+012h),030h		;bbe1
	ret			;bbe5
L_BBE6:
	bit 7,(ix+00ah)		;bbe6   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	ld a,c			;bbea
	jr nz,L_BBEF		;bbeb
	add a,003h		;bbed
L_BBEF:
	ld (ix+00bh),a		;bbef   ; guarda el dibujo de la cosa
	ret			;bbf2
L_BBF3:
	ld a,(0ce01h)		;bbf3   ; lee el paso de la escena
	call 0406bh		;bbf6   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BBF9: 2 destinos del despachador de 0x406B (call en p03:BBF6):
;   0xBBFD, 0xBC18; lo leen p03:BBF6 (4 bytes)
;   0xbbf9..0xbbfd  (4 bytes)
DATA_tabla_BBF9:
	defb 0fdh,0bbh	; bbf9
	defb 018h,0bch	; bbfb

; ======================================================================
; CODIGO 0xbbfd..0xbc44  (71 bytes)
; ======================================================================


L_BBFD:
	ld de,0a090h		;bbfd
	ld c,016h		;bc00
	call 05f1dh		;bc02   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	call L_BC29		;bc05
	call L_BC29		;bc08
	call L_BC29		;bc0b
	call L_BC29		;bc0e
	xor a			;bc11
	ld (0ce02h),a		;bc12
	jp siguiente_paso		;bc15   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_BC18:
	ld a,(0ce15h)		;bc18
	and a			;bc1b
	jp nz,L_BE47		;bc1c
	ld hl,0ce02h		;bc1f
	dec (hl)			;bc22
	ret nz			;bc23
	ld (hl),080h		;bc24
	jp L_BC29		;bc26
L_BC29:
	ld hl,0cf20h		;bc29
	ld a,(hl)			;bc2c
	inc (hl)			;bc2d
	and 007h		;bc2e
	add a,a			;bc30
	ld hl,0bc44h		;bc31
	call 04061h		;bc34   ; hl_mas_a: HL += A
	ld c,(hl)			;bc37
	inc hl			;bc38
	ld b,(hl)			;bc39
	ld de,00000h		;bc3a
	ld h,e			;bc3d
	ld l,e			;bc3e
	ld a,016h		;bc3f
	jp 09f6dh		;bc41   ; crea_con_parametros: guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa

; ----------------------------------------------------------------------
; DATOS ocho_pares: ocho pares que p03:BC31 indexa con los tres bits bajos de
;   A
;   0xbc44..0xbc54  (16 bytes)
DATA_ocho_pares:
	defb 030h,030h,080h,0c0h,030h,0c0h,0c0h,030h,048h,080h,0a0h,080h,068h,030h,068h,0c0h	; bc44  00..0..0H...h0h.

; ======================================================================
; CODIGO 0xbc54..0xbce1  (141 bytes)
; ======================================================================


L_BC54:
	ld de,0fd80h		;bc54
	call pon_velocidad_x		;bc57   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,0fe00h		;bc5a
	call pon_velocidad_y		;bc5d   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+006h),000h		;bc60   ; la cosa se queda quieta
	ld (ix+00ch),01eh		;bc64   ; la cuenta de cuadros del paso = 0x1E
	ld (ix+00bh),07ch		;bc68   ; el dibujo de la cosa = 0x7C
	ret			;bc6c
L_BC6D:
	ld a,(ix+001h)		;bc6d   ; lee el paso en que va la cosa
	dec a			;bc70
	jr z,L_BC7F		;bc71
	dec (ix+00ch)		;bc73   ; baja la cuenta de cuadros del paso
	ret nz			;bc76
	inc (ix+001h)		;bc77   ; sube el paso en que va la cosa
	ld (ix+006h),001h		;bc7a   ; la cosa se mueve
	ret			;bc7e
L_BC7F:
	ld e,(ix+007h)		;bc7f   ; lee la velocidad vertical (parte baja)
	ld d,(ix+008h)		;bc82   ; lee la velocidad vertical
	ld hl,00008h		;bc85
	add hl,de			;bc88
	ex de,hl			;bc89
	call pon_velocidad_y		;bc8a   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld e,(ix+009h)		;bc8d   ; lee la velocidad horizontal (parte baja)
	ld d,(ix+00ah)		;bc90   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	ld a,(ix+005h)		;bc93   ; lee la x de la cosa
	cp 0e8h		;bc96
	push af			;bc98
	call nc,L_BCC9		;bc99
	pop af			;bc9c
	cp 018h		;bc9d
	call c,L_BCD2		;bc9f
	ld a,(ix+003h)		;bca2   ; lee la y de la cosa
	cp 040h		;bca5
	jr nc,L_BCB9		;bca7
	ld e,(ix+007h)		;bca9   ; lee la velocidad vertical (parte baja)
	ld d,(ix+008h)		;bcac   ; lee la velocidad vertical
	bit 7,d		;bcaf
	jr z,L_BCB9		;bcb1
	call niega_de		;bcb3   ; niega_de: DE = -DE
	call pon_velocidad_y		;bcb6   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_BCB9:
	ld e,(ix+003h)		;bcb9   ; lee la y de la cosa
	ld d,(ix+005h)		;bcbc   ; lee la x de la cosa
	call 07b98h		;bcbf   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;bcc2
	ld de,0fd00h		;bcc3
	jp pon_velocidad_y		;bcc6   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_BCC9:
	bit 7,d		;bcc9
	ret nz			;bccb
	call niega_de		;bccc   ; niega_de: DE = -DE
	jp pon_velocidad_x		;bccf   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_BCD2:
	bit 7,d		;bcd2
	ret z			;bcd4
	call niega_de		;bcd5   ; niega_de: DE = -DE
	jp pon_velocidad_x		;bcd8   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_BCDB:
	ld a,(0ce01h)		;bcdb   ; lee el paso de la escena
	call 0406bh		;bcde   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BCE1: 4 destinos del despachador de 0x406B (call en p03:BCDE):
;   0xBCE9, 0xBCF1, 0xBCF9, 0xBD11; lo leen p03:BCDE (8 bytes)
;   0xbce1..0xbce9  (8 bytes)
DATA_tabla_BCE1:
	defb 0e9h,0bch	; bce1
	defb 0f1h,0bch	; bce3
	defb 0f9h,0bch	; bce5
	defb 011h,0bdh	; bce7

; ======================================================================
; CODIGO 0xbce9..0xbd22  (57 bytes)
; ======================================================================


L_BCE9:
	ld a,078h		;bce9
	ld (0ce02h),a		;bceb
	jp siguiente_paso		;bcee   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_BCF1:
	ld hl,0ce02h		;bcf1
	dec (hl)			;bcf4
	ret nz			;bcf5
	jp siguiente_paso		;bcf6   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_BCF9:
	ld de,09090h		;bcf9
	ld c,013h		;bcfc
	call 05f1dh		;bcfe   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	ld hl,08070h		;bd01
	ld bc,02020h		;bd04
	ld a,000h		;bd07
	ld d,000h		;bd09
	call 0490ah		;bd0b   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	jp siguiente_paso		;bd0e   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_BD11:
	ld a,(0ce15h)		;bd11
	and a			;bd14
	ret z			;bd15
	jp L_BE47		;bd16
L_BD19:
	call L_BE0D		;bd19
	ld a,(ix+001h)		;bd1c   ; lee el paso en que va la cosa
	call 0406bh		;bd1f   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BD22: 2 destinos del despachador de 0x406B (call en p03:BD1F):
;   0xBD66, 0xBD99; lo leen p03:BD1F (4 bytes)
;   0xbd22..0xbd26  (4 bytes)
DATA_tabla_BD22:
	defb 066h,0bdh	; bd22
	defb 099h,0bdh	; bd24

; ======================================================================
; CODIGO 0xbd26..0xbe31  (267 bytes)
; ======================================================================


L_BD26:
	xor a			;bd26
	ld (ix+009h),0f8h		;bd27   ; la velocidad horizontal (parte baja) = 0xF8
	ld (ix+00ah),a		;bd2b   ; guarda la velocidad horizontal (el bit 7, hacia la izquierda)
	ld (ix+007h),010h		;bd2e   ; la velocidad vertical (parte baja) = 0x10
	ld (ix+008h),a		;bd32   ; guarda la velocidad vertical
	ld (ix+00bh),02bh		;bd35   ; el dibujo de la cosa = 0x2B
	ld (ix+006h),001h		;bd39   ; la cosa se mueve
	ld (ix+015h),03ch		;bd3d
	ld (ix+014h),008h		;bd41
	ret			;bd45
L_BD46:
	dec (ix+014h)		;bd46
	ld c,02bh		;bd49
	bit 3,(ix+014h)		;bd4b
	jr z,L_BD52		;bd4f
	inc c			;bd51
L_BD52:
	ld (ix+00bh),c		;bd52   ; guarda el dibujo de la cosa
	ld de,00020h		;bd55
	ld a,(ix+003h)		;bd58   ; lee la y de la cosa
	cp 0a0h		;bd5b
	jr c,L_BD62		;bd5d
	ld de,0ffe0h		;bd5f
L_BD62:
	add hl,de			;bd62
	jp suma_a_la_velocidad_y		;bd63   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
L_BD66:
	call L_BD46		;bd66
	ld a,(ix+005h)		;bd69   ; lee la x de la cosa
	sub 010h		;bd6c
	cp 0e0h		;bd6e
	jr nc,L_BD7F		;bd70
	ld a,(0c427h)		;bd72   ; lee la X de Simon
	sub (ix+005h)		;bd75   ; le resta la x de la cosa
	jr nc,L_BD7C		;bd78
	neg		;bd7a
L_BD7C:
	cp 008h		;bd7c
	ret nc			;bd7e
L_BD7F:
	ld a,(ix+009h)		;bd7f   ; lee la velocidad horizontal (parte baja)
	cpl			;bd82
	ld e,a			;bd83
	ld a,(ix+00ah)		;bd84   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	cpl			;bd87
	ld d,a			;bd88
	inc de			;bd89
	call pon_velocidad_x		;bd8a   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+012h),03fh		;bd8d
	ld (ix+013h),060h		;bd91
	inc (ix+001h)		;bd95   ; sube el paso en que va la cosa
	ret			;bd98
L_BD99:
	dec (ix+013h)		;bd99
	ld a,(ix+013h)		;bd9c
	and a			;bd9f
	jr nz,L_BDDD		;bda0
	inc (ix+013h)		;bda2
	ld (ix+006h),000h		;bda5   ; la cosa se queda quieta
	dec (ix+012h)		;bda9
	jr nz,L_BDDC		;bdac
	xor a			;bdae
	ld (ix+009h),0f8h		;bdaf   ; la velocidad horizontal (parte baja) = 0xF8
	ld (ix+00ah),a		;bdb3   ; guarda la velocidad horizontal (el bit 7, hacia la izquierda)
	ld a,(0c427h)		;bdb6   ; lee la X de Simon
	cp (ix+005h)		;bdb9   ; compara con la x de la cosa
	jr nc,L_BDCC		;bdbc
	ld a,(ix+009h)		;bdbe   ; lee la velocidad horizontal (parte baja)
	cpl			;bdc1
	ld e,a			;bdc2
	ld a,(ix+00ah)		;bdc3   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	cpl			;bdc6
	ld d,a			;bdc7
	inc de			;bdc8
	call pon_velocidad_x		;bdc9   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
L_BDCC:
	ld (ix+006h),001h		;bdcc   ; la cosa se mueve
	ld (ix+001h),000h		;bdd0   ; el paso en que va la cosa = 0x00
	ld (ix+012h),02fh		;bdd4
	ld (ix+013h),04fh		;bdd8
L_BDDC:
	ret			;bddc
L_BDDD:
	call L_BD46		;bddd
	ld a,(ix+005h)		;bde0   ; lee la x de la cosa
	sub 010h		;bde3
	cp 0e0h		;bde5
	jr nc,L_BDF6		;bde7
	ld a,(0c427h)		;bde9   ; lee la X de Simon
	sub (ix+005h)		;bdec   ; le resta la x de la cosa
	jr nc,L_BDF3		;bdef
	neg		;bdf1
L_BDF3:
	cp 008h		;bdf3
	ret nc			;bdf5
L_BDF6:
	ld a,(ix+009h)		;bdf6   ; lee la velocidad horizontal (parte baja)
	cpl			;bdf9
	ld e,a			;bdfa
	ld a,(ix+00ah)		;bdfb   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	cpl			;bdfe
	ld d,a			;bdff
	inc de			;be00
	call pon_velocidad_x		;be01   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+012h),03fh		;be04
	ld (ix+013h),010h		;be08
	ret			;be0c
L_BE0D:
	dec (ix+015h)		;be0d
	ret nz			;be10
	ld (ix+015h),03ch		;be11
	call L_A0E5		;be15
	ld a,(ix+003h)		;be18   ; lee la y de la cosa
	sub 010h		;be1b
	ld c,a			;be1d
	ld b,(ix+005h)		;be1e   ; lee la x de la cosa
	push ix		;be21
	ld a,013h		;be23
	call 09f6dh		;be25   ; crea_con_parametros: guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa
	pop ix		;be28
	ret			;be2a
L_BE2B:
	ld a,(0ce01h)		;be2b   ; lee el paso de la escena
	call 0406bh		;be2e   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BE31: 2 destinos del despachador de 0x406B (call en p03:BE2E):
;   0xBE35, 0xBE42; lo leen p03:BE2E (4 bytes)
;   0xbe31..0xbe35  (4 bytes)
DATA_tabla_BE31:
	defb 035h,0beh	; be31
	defb 042h,0beh	; be33

; ======================================================================
; CODIGO 0xbe35..0xbe89  (84 bytes)
; ======================================================================


L_BE35:
	ld c,012h		;be35
	ld de,07040h		;be37
	call 05f1dh		;be3a   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
siguiente_paso:
	ld hl,0ce01h		;be3d   ; apunta a el paso de la escena
	inc (hl)			;be40
	ret			;be41
L_BE42:
	ld a,(0ce15h)		;be42
	and a			;be45
	ret z			;be46
L_BE47:
	xor a			;be47
	ld (0ce10h),a		;be48
	inc a			;be4b
	ld (0ce0bh),a		;be4c
	ret			;be4f
L_BE50:
	ld (ix+00bh),04fh		;be50   ; el dibujo de la cosa = 0x4F
	ld (ix+006h),000h		;be54   ; la cosa se queda quieta
	ld a,(0d000h)		;be58   ; lee la FASE (0 el patio, 1-18)
	cp 003h		;be5b
	ld (ix+013h),03ch		;be5d
	jr z,L_BE67		;be61
	ld (ix+013h),001h		;be63
L_BE67:
	ld de,00000h		;be67
	call pon_velocidad_x		;be6a   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	jp pon_velocidad_y		;be6d   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_BE70:
	inc (ix+014h)		;be70
	inc (ix+00ch)		;be73   ; sube la cuenta de cuadros del paso
	ld a,(ix+00ch)		;be76   ; lee la cuenta de cuadros del paso
	and 008h		;be79
	ld a,04eh		;be7b
	jr z,L_BE80		;be7d
	inc a			;be7f
L_BE80:
	ld (ix+00bh),a		;be80   ; guarda el dibujo de la cosa
	ld a,(ix+001h)		;be83   ; lee el paso en que va la cosa
	call 0406bh		;be86   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BE89: 6 destinos del despachador de 0x406B (call en p03:BE86):
;   0xBE95, 0xBEA2, 0xBEA6, 0xBEF0, 0xBF4A, 0xBF92; lo leen p03:BE86 (12
;   bytes)
;   0xbe89..0xbe95  (12 bytes)
DATA_tabla_BE89:
	defb 095h,0beh	; be89
	defb 0a2h,0beh	; be8b
	defb 0a6h,0beh	; be8d
	defb 0f0h,0beh	; be8f
	defb 04ah,0bfh	; be91
	defb 092h,0bfh	; be93

; ======================================================================
; CODIGO 0xbe95..0xbfc0  (299 bytes)
; ======================================================================


L_BE95:
	dec (ix+013h)		;be95
	ret nz			;be98
	ld (ix+006h),001h		;be99   ; la cosa se mueve
	ld (ix+001h),001h		;be9d   ; el paso en que va la cosa = 0x01
	ret			;bea1
L_BEA2:
	ld (ix+001h),002h		;bea2   ; el paso en que va la cosa = 0x02
L_BEA6:
	ld a,(0c425h)		;bea6   ; lee la Y de Simon
	sub 030h		;bea9
	ld b,030h		;beab
	jr c,L_BEB0		;bead
	ld b,a			;beaf
L_BEB0:
	ld (ix+011h),b		;beb0
	ld a,(ix+014h)		;beb3
	and 001h		;beb6
	ld a,048h		;beb8
	jr z,L_BEBE		;beba
	neg		;bebc
L_BEBE:
	ld c,a			;bebe
	ld a,(0c427h)		;bebf   ; lee la X de Simon
	add a,c			;bec2
	ld c,a			;bec3
	ld (ix+012h),c		;bec4
	ld a,(0c427h)		;bec7   ; lee la X de Simon
	ld h,a			;beca
	ld a,(0c425h)		;becb   ; lee la Y de Simon
	ld l,a			;bece
	push hl			;becf
	ld a,c			;bed0
	ld (0c427h),a		;bed1   ; guarda la X de Simon
	ld a,b			;bed4
	ld (0c425h),a		;bed5   ; guarda la Y de Simon
	call L_A0E5		;bed8
	call pon_velocidad_x		;bedb   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ex de,hl			;bede
	call pon_velocidad_y		;bedf   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	pop hl			;bee2
	ld a,l			;bee3
	ld (0c425h),a		;bee4   ; guarda la Y de Simon
	ld a,h			;bee7
	ld (0c427h),a		;bee8   ; guarda la X de Simon
	ld (ix+001h),003h		;beeb   ; el paso en que va la cosa = 0x03
	ret			;beef
L_BEF0:
	bit 7,(ix+008h)		;bef0   ; mira el bit 7 de la velocidad vertical
	ld a,(ix+003h)		;bef4   ; lee la y de la cosa
	jr z,L_BEFD		;bef7
	cp 030h		;bef9
	jr c,L_BF29		;befb
L_BEFD:
	cp 090h		;befd
	jr nc,L_BF29		;beff
	ld a,(ix+005h)		;bf01   ; lee la x de la cosa
	sub 020h		;bf04
	cp 0b0h		;bf06
	jr nc,L_BF29		;bf08
	ld a,(ix+003h)		;bf0a   ; lee la y de la cosa
	add a,008h		;bf0d
	sub (ix+011h)		;bf0f
	cp 010h		;bf12
	ret nc			;bf14
	ld a,(ix+005h)		;bf15   ; lee la x de la cosa
	add a,008h		;bf18
	sub (ix+012h)		;bf1a
	cp 010h		;bf1d
	jr c,L_BF29		;bf1f
	ld a,(ix+005h)		;bf21   ; lee la x de la cosa
	sub 020h		;bf24
	cp 0c0h		;bf26
	ret c			;bf28
L_BF29:
	ld de,00000h		;bf29
	call pon_velocidad_x		;bf2c   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	call pon_velocidad_y		;bf2f   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld a,r		;bf32
	srl a		;bf34
	srl a		;bf36
	neg		;bf38
	add a,040h		;bf3a
	ld (ix+010h),a		;bf3c
	ld (ix+001h),004h		;bf3f   ; el paso en que va la cosa = 0x04
	ret			;bf43
L_BF44:
	call L_A0E5		;bf44
	jp 09f61h		;bf47
L_BF4A:
	ld a,(ix+010h)		;bf4a
	cp 018h		;bf4d
	call z,L_BF44		;bf4f
	dec (ix+010h)		;bf52
	ret nz			;bf55
	ld de,00280h		;bf56
	call pon_velocidad_y		;bf59   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld a,(0c427h)		;bf5c   ; lee la X de Simon
	ld b,(ix+005h)		;bf5f   ; lee la x de la cosa
	cp b			;bf62
	jr nc,L_BF68		;bf63
	ld c,a			;bf65
	ld a,b			;bf66
	ld b,c			;bf67
L_BF68:
	sub b			;bf68
	ld d,a			;bf69
	ld e,000h		;bf6a
	srl d		;bf6c
	rr e		;bf6e
	srl d		;bf70
	rr e		;bf72
	srl d		;bf74
	rr e		;bf76
	srl d		;bf78
	rr e		;bf7a
	srl d		;bf7c
	rr e		;bf7e
	ld a,(0c427h)		;bf80   ; lee la X de Simon
	ld b,(ix+005h)		;bf83   ; lee la x de la cosa
	cp b			;bf86
	call c,niega_de		;bf87   ; niega_de: DE = -DE
	call pon_velocidad_x		;bf8a   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+001h),005h		;bf8d   ; el paso en que va la cosa = 0x05
	ret			;bf91
L_BF92:
	ld de,0fff0h		;bf92
	call suma_a_la_velocidad_y		;bf95   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
	ld a,(ix+005h)		;bf98   ; lee la x de la cosa
	cp 019h		;bf9b
	ld b,002h		;bf9d
	jr c,L_BFA7		;bf9f
	cp 0e7h		;bfa1
	ld b,0feh		;bfa3
	jr c,L_BFAE		;bfa5
L_BFA7:
	ld (ix+009h),000h		;bfa7   ; la velocidad horizontal (parte baja) = 0x00
	ld (ix+00ah),b		;bfab   ; guarda la velocidad horizontal (el bit 7, hacia la izquierda)
L_BFAE:
	bit 7,(ix+008h)		;bfae   ; mira el bit 7 de la velocidad vertical
	ret z			;bfb2
	ld a,(ix+003h)		;bfb3   ; lee la y de la cosa
	cp 041h		;bfb6
	ret nc			;bfb8
	ld (ix+001h),002h		;bfb9   ; el paso en que va la cosa = 0x02
	jp L_BEA6		;bfbd

; ----------------------------------------------------------------------
; DATOS relleno_p03: 64 bytes a 0xFF hasta el final del banco: espacio libre;
;   lo leen nadie (64 bytes)
;   0xbfc0..0xc000  (64 bytes)
DATA_relleno_p03:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff0  ................
