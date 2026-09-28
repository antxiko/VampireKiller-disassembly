; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS tabla_5FCC_cola: 46 destinos del despachador de 0x406B (call en
;   p00:5FC9): 0xA934, 0xA2E0, 0xA2E0, 0xB0CA, 0xA85C, 0xA573, 0xB061, 0xA4FB
;   ... (sigue del banco anterior, 0x5FCC); lo leen p00:5FC9 (40 bytes)
;   0x6000..0x6028  (40 bytes)
DATA_tabla_5FCC_cola:
	defb 0d2h,0b4h	; 6000
	defb 0d2h,0b4h	; 6002
	defb 028h,060h	; 6004
	defb 060h,09bh	; 6006
	defb 0ceh,0b0h	; 6008
	defb 066h,09ch	; 600a
	defb 0c7h,0a2h	; 600c
	defb 077h,0b7h	; 600e
	defb 012h,0b2h	; 6010
	defb 09bh,09bh	; 6012
	defb 028h,060h	; 6014
	defb 0c4h,09bh	; 6016
	defb 0a7h,04eh	; 6018
	defb 0d0h,04eh	; 601a
	defb 0d0h,04eh	; 601c
	defb 01fh,04fh	; 601e
	defb 028h,060h	; 6020
	defb 05dh,06ah	; 6022
	defb 0e8h,0ach	; 6024
	defb 0bch,069h	; 6026

; ======================================================================
; CODIGO 0x6028..0x6058  (48 bytes)
; ======================================================================


L_6028:
	ret			;6028
L_6029:
	ld a,(ix+020h)		;6029   ; lee cuantos sprites lleva la cosa
	and a			;602c
	ret z			;602d
	ld a,(ix+000h)		;602e   ; lee el tipo de la cosa
	call palabra_de_la_tabla		;6031   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld hl,(0cff3h)		;6034   ; lee la ficha de la cosa que se crea
	set 5,l		;6037
	ld b,(hl)			;6039
	ld a,005h		;603a
	add a,l			;603c
	ld l,a			;603d
L_603E:
	ld a,(de)			;603e
	inc de			;603f
	ld (hl),a			;6040
	ld a,l			;6041
	add a,005h		;6042
	ld l,a			;6044
	djnz L_603E		;6045
	ret			;6047
L_6048:
	push hl			;6048
	ld hl,(0cff3h)		;6049   ; lee la ficha de la cosa que se crea
	ld a,e			;604c
	add a,a			;604d
	add a,a			;604e
	add a,e			;604f
	add a,021h		;6050
	call 04061h		;6052   ; hl_mas_a: HL += A
	ld (hl),d			;6055
	pop hl			;6056
	ret			;6057

; ----------------------------------------------------------------------
; DATOS sprites_de_cada_tipo: 46 bytes, uno por tipo de cosa (1-46): cuantos
;   sprites lleva; p00:5F4B lo lee con 0x6057 + tipo y lo deja en (ix+0x20).
;   Los dos ultimos son tambien la entrada 0, sin usar, de la tabla de al lado
;   0x6058..0x6086  (46 bytes)
DATA_sprites_de_cada_tipo:
	defb 004h,004h,004h,002h,004h,004h,002h,002h,004h,004h,004h,002h,002h,008h,006h,004h	; 6058  ................
	defb 008h,008h,008h,006h,006h,00ch,000h,002h,002h,002h,002h,002h,001h,002h,002h,002h	; 6068  ................
	defb 004h,006h,002h,002h,002h,002h,008h,001h,001h,004h,004h,002h,002h,002h	; 6078  ..............

; ----------------------------------------------------------------------
; DATOS colores_de_cada_tipo: 46 punteros, uno por tipo (1-46), a la lista de
;   colores de sus sprites: p00:5FB2 llama a 0x6029 con DE = 0x6084, que copia
;   un color por sprite a (ix+0x25), (ix+0x2A)...; el ultimo byte, 0x60E1, es
;   a la vez la entrada 0 (sin usar) de la tabla siguiente
;   0x6086..0x60e2  (92 bytes)
DATA_colores_de_cada_tipo:
	defb 012h,061h,012h,061h,028h,061h,012h,061h,012h,061h,028h,061h,03eh,061h,028h,061h	; 6086  .a.a(a.a.a(a>a(a
	defb 028h,061h,03eh,061h,03eh,061h,016h,061h,028h,061h,03eh,061h,020h,061h,028h,061h	; 6096  (a>a>a.a(a>a a(a
	defb 018h,061h,020h,061h,028h,061h,03eh,061h,028h,061h,028h,061h,034h,061h,028h,061h	; 60a6  .a a(a>a(a(a4a(a
	defb 052h,061h,04ch,061h,04eh,061h,050h,061h,047h,061h,034h,061h,012h,061h,036h,061h	; 60b6  RaLaNaPaGa4a.a6a
	defb 028h,061h,038h,061h,028h,061h,048h,061h,057h,060h,04ah,061h,03eh,061h,046h,061h	; 60c6  (a8a(aHaW`Ja>aFa
	defb 046h,061h,020h,061h,020h,061h,052h,061h,052h,061h,052h,061h	; 60d6  Fa a aRaRaRa

; ----------------------------------------------------------------------
; DATOS vida_de_cada_tipo: 46 bytes, uno por tipo (1-46): la vida con la que
;   nace cada cosa; p00:5FB8 la pone en (ix+0x0D) y p02:8069 le resta lo que
;   quita el arma
;   0x60e2..0x6110  (46 bytes)
DATA_vida_de_cada_tipo:
	defb 001h,001h,002h,001h,001h,004h,002h,001h,002h,008h,004h,001h,001h,00ch,008h,008h	; 60e2  ................
	defb 020h,010h,010h,010h,020h,020h,004h,001h,001h,001h,001h,001h,001h,001h,001h,001h	; 60f2   ...  ..........
	defb 002h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h	; 6102  ..............

; ----------------------------------------------------------------------
; DATOS listas_de_colores: las listas de colores de sprite a las que apuntan
;   los punteros de 0x6086: un byte por sprite
;   0x6110..0x6154  (68 bytes)
DATA_listas_de_colores:
	defb 001h,001h,002h,044h,002h,044h,002h,041h,002h,048h,000h,000h,000h,000h,000h,000h	; 6110  ...D.D.A.H......
	defb 001h,042h,001h,042h,001h,042h,001h,042h,002h,045h,002h,045h,002h,045h,002h,045h	; 6120  .B.B.B.B.E.E.E.E
	defb 002h,045h,002h,045h,008h,000h,006h,000h,002h,006h,008h,00eh,000h,000h,002h,04ch	; 6130  .E.E...........L
	defb 002h,04ch,002h,04ch,002h,04ch,002h,008h,008h,000h,00eh,000h,00fh,042h,008h,042h	; 6140  .L.L.L.......B.B
	defb 00eh,042h,002h,048h	; 6150

; ======================================================================
; CODIGO 0x6154..0x623c  (232 bytes)
; ======================================================================


L_6154:
	di			;6154
	ld a,00eh		;6155
	ld (08000h),a		;6157   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;615a   ; guarda la copia del banco de 0x8000
	ei			;615d
	call L_61A9		;615e
	call L_619E		;6161
	ld de,0db00h		;6164
	call L_6181		;6167
	ld de,0dc00h		;616a
	call L_6181		;616d
	ld de,0dd00h		;6170
	call L_6181		;6173
	di			;6176
	ld a,002h		;6177
	ld (08000h),a		;6179   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;617c   ; guarda la copia del banco de 0x8000
	ei			;617f
	ret			;6180
L_6181:
	ld (0cff0h),de		;6181   ; guarda el tipo de la cosa que se crea
L_6185:
	ld a,(hl)			;6185
	inc hl			;6186
	inc a			;6187
	ret z			;6188
	dec a			;6189
	jr z,L_6194		;618a
	ld (de),a			;618c
	inc de			;618d
	ldi		;618e
	inc de			;6190
	inc de			;6191
	jr L_6185		;6192
L_6194:
	ld de,(0cff0h)		;6194   ; lee el tipo de la cosa que se crea
	ld a,e			;6198
	add a,010h		;6199
	ld e,a			;619b
	jr L_6181		;619c
L_619E:
	ld a,(0d002h)		;619e   ; lee el bloque de tres fases (0-5)
	ld de,08668h		;61a1
	call palabra_de_la_tabla		;61a4   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ex de,hl			;61a7
	ret			;61a8
L_61A9:
	ld hl,0db00h		;61a9
	ld c,001h		;61ac
	ld b,0c0h		;61ae
L_61B0:
	ld (hl),000h		;61b0
	inc hl			;61b2
	inc hl			;61b3
	inc hl			;61b4
	ld (hl),c			;61b5
	inc c			;61b6
	inc hl			;61b7
	djnz L_61B0		;61b8
	ret			;61ba
L_61BB:
	ld a,(0d002h)		;61bb   ; lee el bloque de tres fases (0-5)
	ld c,a			;61be
	add a,a			;61bf
	add a,c			;61c0
	ld c,a			;61c1
	ld a,(0d000h)		;61c2   ; lee la FASE (0 el patio, 1-18)
	dec a			;61c5
	ret m			;61c6
	sub c			;61c7
	ld h,a			;61c8
	ld l,000h		;61c9
	ld de,0db00h		;61cb
	add hl,de			;61ce
	ld a,(0d001h)		;61cf   ; lee la HABITACION dentro de la fase
	add a,a			;61d2
	add a,a			;61d3
	add a,a			;61d4
	add a,a			;61d5
	call 04061h		;61d6   ; hl_mas_a: HL += A
	ld b,004h		;61d9
L_61DB:
	push bc			;61db
	push hl			;61dc
	ld a,(hl)			;61dd
	and a			;61de
	jr z,L_61F9		;61df
	ld b,000h		;61e1
	and 07fh		;61e3
	ld c,a			;61e5
	inc hl			;61e6
	ld a,(hl)			;61e7
	and 0f0h		;61e8
	ld e,a			;61ea
	ld a,(hl)			;61eb
	and 00fh		;61ec
	add a,a			;61ee
	add a,a			;61ef
	add a,a			;61f0
	add a,a			;61f1
	ld d,a			;61f2
	inc hl			;61f3
	inc hl			;61f4
	ld a,(hl)			;61f5
	call 05f1fh		;61f6
L_61F9:
	pop hl			;61f9
	pop bc			;61fa
	inc hl			;61fb
	inc hl			;61fc
	inc hl			;61fd
	inc hl			;61fe
	djnz L_61DB		;61ff
	ret			;6201
L_6202:
	call 047d4h		;6202   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 05727h		;6205
	ld hl,0623ch		;6208
	call 0483eh		;620b   ; pon_paleta: lista de [color][RB][G] hasta 0xFF
	ld b,00fh		;620e
	ld c,007h		;6210
	call 00047h		;6212   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,02840h		;6215
	ld bc,0a848h		;6218
	xor a			;621b
	ld d,001h		;621c
	call 0490ah		;621e   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	call 0530fh		;6221
	ld de,04040h		;6224
	ld hl,0628fh		;6227
	call L_626F		;622a
	call 047c7h		;622d   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	ld hl,0c420h		;6230
	ld (hl),03ch		;6233
	inc hl			;6235
	ld (hl),031h		;6236
	inc hl			;6238
	ld (hl),000h		;6239
	ret			;623b

; ----------------------------------------------------------------------
; DATOS paleta_623C: cambios de paleta ([color][RB][G], 0xFF acaba) que
;   escribe 0x483E en el registro 16 del V9938 y en la copia de 0xF680; lo
;   leen p01:620B (16 bytes)
;   0x623c..0x624c  (16 bytes)
DATA_paleta_623C:
	defb 000h,000h,000h	; 623c
	defb 001h,070h,003h	; 623f
	defb 002h,060h,001h	; 6242
	defb 003h,044h,004h	; 6245
	defb 00fh,077h,007h	; 6248
	defb 0ffh	; 624b

; ======================================================================
; CODIGO 0x624c..0x628f  (67 bytes)
; ======================================================================


L_624C:
	ld hl,0c420h		;624c
	dec (hl)			;624f
	ld a,(hl)			;6250
	and 001h		;6251
	ret nz			;6253
	inc hl			;6254
	dec (hl)			;6255
	jr nz,L_625E		;6256
	ld a,001h		;6258
	ld (0c422h),a		;625a
	ret			;625d
L_625E:
	ld a,031h		;625e
	sub (hl)			;6260
	ld c,a			;6261
	ld b,0a8h		;6262
	ld hl,02840h		;6264
	ld de,02840h		;6267
	ld a,001h		;626a
	jp 04946h		;626c   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_626F:
	push de			;626f
L_6270:
	ld a,(hl)			;6270
	inc hl			;6271
	ld c,a			;6272
	inc a			;6273
	jr z,L_628D		;6274
	inc a			;6276
	jr nz,L_6284		;6277
	pop de			;6279
	ld a,(hl)			;627a
	inc hl			;627b
	add a,d			;627c
	ld d,a			;627d
	ld a,008h		;627e
	add a,e			;6280
	ld e,a			;6281
	jr L_626F		;6282
L_6284:
	ld a,c			;6284
	call 04b2fh		;6285
	call 04b4fh		;6288
	jr L_6270		;628b
L_628D:
	pop de			;628d
	ret			;628e

; ----------------------------------------------------------------------
; DATOS logotipo: como se monta el logotipo del titulo: numeros de dibujo que
;   p01:626F coloca de izquierda a derecha; 0xFE [dx] baja una fila y corre
;   dx, 0xFF acaba (p01:6227, con DE = 0x4040)
;   0x628f..0x62d0  (65 bytes)
DATA_logotipo:
	defb 001h,002h,003h,0feh,0f8h,004h,005h,006h,007h,0feh,0f0h,008h,009h,00ah,00bh,00eh	; 628f  ................
	defb 00fh,010h,011h,01bh,01ch,01dh,01eh,01fh,020h,021h,022h,023h,024h,025h,026h,0feh	; 629f  ........ !"#$%&.
	defb 000h,00ch,002h,00dh,012h,013h,014h,015h,027h,028h,029h,02ah,02bh,02ch,02dh,02eh	; 62af  ........'()*+,-.
	defb 02fh,030h,031h,032h,033h,034h,0feh,010h,016h,019h,017h,0feh,0f8h,018h,019h,01ah	; 62bf  /01234..........
	defb 0ffh	; 62cf

; ======================================================================
; CODIGO 0x62d0..0x636f  (159 bytes)
; ======================================================================


L_62D0:
	ld a,020h		;62d0
	ld (0c415h),a		;62d2   ; guarda la vida de Simon
L_62D5:
	ld a,080h		;62d5
	ld (0c418h),a		;62d7   ; guarda la vida del enemigo (barra ENEMY)
	call L_70DC		;62da
	call 0548dh		;62dd
	call 05768h		;62e0
	jp 053b6h		;62e3
L_62E6:
	call 0564ch		;62e6   ; sube_los_dibujos_de_la_fase: los 191 dibujos del decorado de la fase de 0xD000
	call 0570dh		;62e9
	call L_63B7		;62ec
	call L_6402		;62ef
	call 05a49h		;62f2
L_62F5:
	call L_63C5		;62f5
	call L_6382		;62f8
	call 05780h		;62fb
	call 056e1h		;62fe
	call 04f83h		;6301
	call 047d4h		;6304   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call L_6333		;6307
	call 04f91h		;630a
	call 091beh		;630d
	call 08671h		;6310
	call 09147h		;6313
	call 08ee6h		;6316
	ld a,(0ce00h)		;6319
	cp 006h		;631c
	call z,L_632D		;631e
	call 047c7h		;6321   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	call 09ca9h		;6324
	call L_6154		;6327
	jp L_61BB		;632a
L_632D:
	call L_6914		;632d
	jp L_69A0		;6330
L_6333:
	xor a			;6333
	ld (0ce40h),a		;6334
	ld (0ce00h),a		;6337
	ld (0ce0bh),a		;633a
	ld (0ce08h),a		;633d
	ld (0ce15h),a		;6340
	ld a,(0d000h)		;6343   ; lee la FASE (0 el patio, 1-18)
	ld hl,0636fh		;6346
	call 04061h		;6349   ; hl_mas_a: HL += A
	ld a,(0d001h)		;634c   ; lee la HABITACION dentro de la fase
	ld c,a			;634f
	ld a,(hl)			;6350
	ld b,a			;6351
	rra			;6352
	rra			;6353
	rra			;6354
	rra			;6355
	and 00fh		;6356
	cp c			;6358
	ret nz			;6359
	ld a,b			;635a
	and 00fh		;635b
	ld l,a			;635d
	ld h,000h		;635e
	ld (0ce00h),hl		;6360
	cp 006h		;6363
	ret nz			;6365
	call 059ech		;6366
	call 05880h		;6369
	jp 057dfh		;636c

; ----------------------------------------------------------------------
; DATOS habitacion_especial_de_cada_fase: 19 bytes, uno por fase: la
;   habitacion (nibble alto) en la que p01:6343 pone el nibble bajo en 0xCE00
;   al entrar; si vale 6, llama ademas a 0x59EC
;   0x636f..0x6382  (19 bytes)
DATA_habitacion_especial_de_cada_fase:
	defb 0ffh,0ffh,0ffh,051h,0ffh,0ffh,052h,0ffh,0ffh,073h,0ffh,0ffh,064h,0ffh,0ffh,095h	; 636f  ...Q..R..s..d...
	defb 0ffh,0ffh,096h	; 637f

; ======================================================================
; CODIGO 0x6382..0x641f  (157 bytes)
; ======================================================================


L_6382:
	ld hl,0c470h		;6382   ; apunta a los bloques que se rompen (ocho de 16 bytes)
	ld de,0c471h		;6385
	ld (hl),000h		;6388
	ld bc,0028fh		;638a
	ldir		;638d
	call 05b1bh		;638f
	call 05a40h		;6392
	call 0902dh		;6395
	call 0909bh		;6398
	call 05a37h		;639b
	call L_7513		;639e
	ld hl,0c800h		;63a1
	ld de,00080h		;63a4
	ld b,007h		;63a7
	call L_63B1		;63a9
	ld hl,0d700h		;63ac
	ld b,008h		;63af
L_63B1:
	ld (hl),000h		;63b1
	add hl,de			;63b3
	djnz L_63B1		;63b4
	ret			;63b6
L_63B7:
	ld hl,0c420h		;63b7
	ld d,h			;63ba
	ld e,l			;63bb
	inc de			;63bc
	ld (hl),000h		;63bd
	ld bc,0004fh		;63bf
	ldir		;63c2
	ret			;63c4
L_63C5:
	ld hl,0d600h		;63c5
	ld b,020h		;63c8
L_63CA:
	ld (hl),0e0h		;63ca
	inc l			;63cc
	inc l			;63cd
	inc l			;63ce
	inc l			;63cf
	djnz L_63CA		;63d0
	ret			;63d2
L_63D3:
	call 047b9h		;63d3
	ld a,080h		;63d6
	ld (0c425h),a		;63d8   ; guarda la Y de Simon
	ld (0c427h),a		;63db   ; guarda la X de Simon
	call 05670h		;63de
	call 05733h		;63e1
	call 05678h		;63e4
	call L_63C5		;63e7
	call 04e9fh		;63ea
	call 04ec0h		;63ed
	call 04f17h		;63f0
	call 047d4h		;63f3   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 04513h		;63f6
	call 04f83h		;63f9
	call 04f91h		;63fc
	jp 047c7h		;63ff   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
L_6402:
	ld a,(0d000h)		;6402   ; lee la FASE (0 el patio, 1-18)
	ld hl,0641fh		;6405
	add a,a			;6408
	call 04061h		;6409   ; hl_mas_a: HL += A
	ld a,(hl)			;640c
	inc hl			;640d
	ld c,a			;640e
	and 0feh		;640f
	ld (0c425h),a		;6411   ; guarda la Y de Simon
	ld a,(hl)			;6414
	ld (0c427h),a		;6415   ; guarda la X de Simon
	ld a,c			;6418
	and 001h		;6419
	ld (0c42ch),a		;641b   ; guarda el lado al que mira Simon (0 derecha)
	ret			;641e

; ----------------------------------------------------------------------
; DATOS salida_de_simon: 19 pares, uno por fase: donde aparece Simon; p01:6402
;   pone el primero (sin el bit 0) en 0xC425, el segundo en 0xC427, y el bit 0
;   en 0xC42C (hacia donde mira)
;   0x641f..0x6445  (38 bytes)
DATA_salida_de_simon:
	defb 0b0h,010h,0c0h,010h,060h,010h,060h,010h,0c0h,010h,061h,0e8h,081h,0e8h,0b1h,0e8h	; 641f  ....`.`...a.....
	defb 090h,010h,070h,010h,090h,020h,0b0h,010h,0b0h,010h,0b0h,038h,0b1h,0c8h,0b1h,0e8h	; 642f  ..p.. .....8....
	defb 0b1h,0e8h,051h,0e8h,0b1h,0e8h	; 643f

; ======================================================================
; CODIGO 0x6445..0x64cd  (136 bytes)
; ======================================================================


L_6445:
	ld a,(ix+000h)		;6445   ; lee el tipo de la cosa
	cp 00eh		;6448
	ret z			;644a
	cp 017h		;644b
	ret z			;644d
	di			;644e
	ld a,006h		;644f
	ld (0a000h),a		;6451   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6454   ; guarda la copia del banco de 0xA000
	ei			;6457
	ld a,(ix+00bh)		;6458   ; lee el dibujo de la cosa
	ld de,0b473h		;645b
	call palabra_de_la_tabla		;645e   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	push ix		;6461
	pop hl			;6463
	set 5,l		;6464
	ld b,(hl)			;6466
	inc l			;6467
	inc l			;6468
	ld a,(de)			;6469
	cp 080h		;646a
	jr z,L_64A3		;646c
	cp 081h		;646e
	jr z,L_649D		;6470
	cp 082h		;6472
	jr z,L_6497		;6474
L_6476:
	ld a,(de)			;6476
	inc de			;6477
	add a,(ix+003h)		;6478   ; le suma la y de la cosa
	ld (hl),a			;647b
	inc l			;647c
	ld a,(de)			;647d
	add a,(ix+005h)		;647e   ; le suma la x de la cosa
	ld (hl),a			;6481
	inc de			;6482
	inc l			;6483
	ld a,(de)			;6484
	ld (hl),a			;6485
	inc de			;6486
	inc l			;6487
	inc l			;6488
	inc l			;6489
	djnz L_6476		;648a
	di			;648c
	ld a,003h		;648d
	ld (0a000h),a		;648f   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6492   ; guarda la copia del banco de 0xA000
	ei			;6495
	ret			;6496
L_6497:
	exx			;6497
	ld hl,064d9h		;6498
	jr L_64A7		;649b
L_649D:
	exx			;649d
	ld hl,064d5h		;649e
	jr L_64A7		;64a1
L_64A3:
	exx			;64a3
	ld hl,064cdh		;64a4
L_64A7:
	exx			;64a7
L_64A8:
	exx			;64a8
	ld a,(hl)			;64a9
	inc hl			;64aa
	add a,(ix+003h)		;64ab   ; le suma la y de la cosa
	exx			;64ae
	ld (hl),a			;64af
	inc l			;64b0
	exx			;64b1
	ld a,(hl)			;64b2
	inc hl			;64b3
	add a,(ix+005h)		;64b4   ; le suma la x de la cosa
	exx			;64b7
	ld (hl),a			;64b8
	inc l			;64b9
	inc de			;64ba
	ld a,(de)			;64bb
	ld (hl),a			;64bc
	inc l			;64bd
	inc l			;64be
	inc l			;64bf
	djnz L_64A8		;64c0
	di			;64c2
	ld a,003h		;64c3
	ld (0a000h),a		;64c5   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;64c8   ; guarda la copia del banco de 0xA000
	ei			;64cb
	ret			;64cc

; ----------------------------------------------------------------------
; DATOS posiciones_fijas: las posiciones [dy][dx] que usan las composiciones
;   0x80, 0x81 y 0x82 de la tabla de sprites (p01:64A4, 649E y 6498: 0x64CD,
;   0x64D5 y 0x64D9)
;   0x64cd..0x64e5  (24 bytes)
DATA_posiciones_fijas:
	defb 0e0h,0f8h,0e0h,0f8h,0f0h,0f8h,0f0h,0f8h,0f1h,0f8h,0f1h,0f8h,0d1h,0f8h,0d1h,0f8h	; 64cd  ................
	defb 0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h	; 64dd  ........

; ======================================================================
; CODIGO 0x64e5..0x65b6  (209 bytes)
; ======================================================================


L_64E5:
	ld hl,0d700h		;64e5
	ld b,008h		;64e8
	jr L_64F1		;64ea
L_64EC:
	ld hl,0c800h		;64ec
	ld b,007h		;64ef
L_64F1:
	push bc			;64f1
	push hl			;64f2
	ld a,(hl)			;64f3
	and a			;64f4
	call nz,L_6501		;64f5
	pop hl			;64f8
	pop bc			;64f9
	ld de,00080h		;64fa
	add hl,de			;64fd
	djnz L_64F1		;64fe
	ret			;6500
L_6501:
	set 5,l		;6501
	ld b,(hl)			;6503
	ld a,b			;6504
	and a			;6505
	ret z			;6506
	inc l			;6507
L_6508:
	push bc			;6508
	ld a,(hl)			;6509
	ld b,a			;650a
	inc l			;650b
	add a,a			;650c
	add a,a			;650d
	ld de,0d638h		;650e
	add a,e			;6511
	ld e,a			;6512
	ld c,0ffh		;6513
	ldi		;6515
	ldi		;6517
	ldi		;6519
	ld a,(hl)			;651b
	and a			;651c
	jr nz,L_6528		;651d
	dec e			;651f
	dec e			;6520
	dec e			;6521
	ld a,0e1h		;6522
	ld (de),a			;6524
	inc e			;6525
	inc e			;6526
	inc e			;6527
L_6528:
	ex de,hl			;6528
	ld hl,06a70h		;6529
	ld a,b			;652c
	add a,a			;652d
	add a,a			;652e
	add a,a			;652f
	ld c,a			;6530
	ld b,000h		;6531
	add hl,bc			;6533
	add hl,hl			;6534
	ex de,hl			;6535
	ld a,(hl)			;6536
	ld b,010h		;6537
L_6539:
	ld (de),a			;6539
	inc e			;653a
	djnz L_6539		;653b
	pop bc			;653d
	inc l			;653e
	djnz L_6508		;653f
	ret			;6541
palabra_de_la_tabla:
	ld l,a			;6542
	ld h,000h		;6543
	add hl,hl			;6545
	add hl,de			;6546
	ld e,(hl)			;6547
	inc hl			;6548
	ld d,(hl)			;6549
	ret			;654a
L_654B:
	ld a,(0ce0ch)		;654b
	or a			;654e
	jp nz,L_65A4		;654f
	ld a,(0ce00h)		;6552
	cp 005h		;6555
	jr z,L_65A4		;6557
	ld a,(0c5ach)		;6559   ; lee el estado de la puerta de la fase
	cp 005h		;655c
	jr z,L_65A4		;655e
	ld hl,0c00fh		;6560
	ld a,(hl)			;6563
	add a,068h		;6564
	and 078h		;6566
	ld (hl),a			;6568
	ld a,(00007h)		;6569
	ld c,a			;656c
	call L_658A		;656d
	ld hl,0f600h		;6570
	call 046afh		;6573   ; vram_para_escribir: prepara el V9938 para escribir en la direccion HL
	ld a,(0c00fh)		;6576
	ld d,010h		;6579
	ld h,0d6h		;657b
L_657D:
	ld b,008h		;657d
	ld l,a			;657f
	otir		;6580
	add a,048h		;6582
	and 078h		;6584
	dec d			;6586
	jr nz,L_657D		;6587
	ret			;6589
L_658A:
	ld hl,0f400h		;658a
	call 046afh		;658d   ; vram_para_escribir: prepara el V9938 para escribir en la direccion HL
	ld a,(0c00fh)		;6590
	ld d,010h		;6593
	add a,a			;6595
L_6596:
	ld h,06ah		;6596
	ld l,a			;6598
	add hl,hl			;6599
	ld b,020h		;659a
	otir		;659c
	add a,090h		;659e
	dec d			;65a0
	jr nz,L_6596		;65a1
	ret			;65a3
L_65A4:
	ld hl,0d400h		;65a4
	ld de,0f400h		;65a7
	ld bc,00280h		;65aa
	jp 04675h		;65ad   ; copia_a_la_vram: BC bytes de HL a la VRAM de DE
L_65B0:
	ld a,(0ce01h)		;65b0   ; lee el paso de la escena
	call 0406bh		;65b3   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_65B6: 11 destinos del despachador de 0x406B (call en p01:65B3):
;   0x65CC, 0x65DE, 0x65F3, 0x6602, 0x6619, 0x663E, 0x6655, 0x6677 ...; lo
;   leen p01:65B3 (22 bytes)
;   0x65b6..0x65cc  (22 bytes)
DATA_tabla_65B6:
	defb 0cch,065h	; 65b6
	defb 0deh,065h	; 65b8
	defb 0f3h,065h	; 65ba
	defb 002h,066h	; 65bc
	defb 019h,066h	; 65be
	defb 03eh,066h	; 65c0
	defb 055h,066h	; 65c2
	defb 077h,066h	; 65c4
	defb 08ch,066h	; 65c6
	defb 097h,066h	; 65c8
	defb 0a9h,066h	; 65ca

; ======================================================================
; CODIGO 0x65cc..0x66c1  (245 bytes)
; ======================================================================


L_65CC:
	xor a			;65cc
	ld (0ce16h),a		;65cd
	ld (0ce0eh),a		;65d0
	ld de,0c0d0h		;65d3
	ld c,011h		;65d6
	call 05f1dh		;65d8   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	jp 0be3dh		;65db   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_65DE:
	call 0ad93h		;65de
	ld a,(0ce16h)		;65e1
	and a			;65e4
	ret z			;65e5
	xor a			;65e6
	ld (0ce15h),a		;65e7
	ld (0ce0eh),a		;65ea
	call 0ad93h		;65ed
	jp 0be3dh		;65f0   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_65F3:
	xor a			;65f3
	ld (0ce12h),a		;65f4
	call L_684F		;65f7
	ld a,078h		;65fa
	ld (0ce02h),a		;65fc
	jp 0be3dh		;65ff   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_6602:
	ld hl,0ce02h		;6602
	ld a,(hl)			;6605
	and a			;6606
	jr z,L_660A		;6607
	dec a			;6609
L_660A:
	ld (hl),a			;660a
	ret nz			;660b
	ld a,(0c800h)		;660c
	and a			;660f
	ret nz			;6610
	ld a,000h		;6611
	call 0509fh		;6613   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jp 0be3dh		;6616   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_6619:
	ld a,088h		;6619
	call 0509fh		;661b   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,080h		;661e
	ld (0c418h),a		;6620   ; guarda la vida del enemigo (barra ENEMY)
	call 045e5h		;6623
	call L_6984		;6626
	ld c,017h		;6629
	ld de,08049h		;662b
	call 05f1dh		;662e   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	call 057b4h		;6631
	xor a			;6634
	ld (0ce36h),a		;6635
	ld (0ce37h),a		;6638
	jp 0be3dh		;663b   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_663E:
	call L_68C4		;663e
	ld a,(0ce36h)		;6641
	sub 002h		;6644
	ret nz			;6646
	ld (0ce38h),a		;6647
	ld (0ce39h),a		;664a   ; guarda la cuenta del destello
	ld a,0c0h		;664d
	ld (0ce37h),a		;664f
	jp 0be3dh		;6652   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_6655:
	ld a,(0ce15h)		;6655
	and a			;6658
	jr nz,L_6667		;6659
	call L_67E4		;665b
	call L_686E		;665e
	call L_6818		;6661
	jp L_6A49		;6664
L_6667:
	call L_69A0		;6667
	call L_6810		;666a
	call L_7806		;666d
	xor a			;6670
	ld (0ce37h),a		;6671
	jp 0be3dh		;6674   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_6677:
	call L_68A8		;6677
	ld a,(0ce36h)		;667a
	and a			;667d
	ret nz			;667e
	ld a,08dh		;667f
	call 0509fh		;6681   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,0b4h		;6684
	ld (0ce02h),a		;6686
	jp 0be3dh		;6689   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_668C:
	ld hl,0ce02h		;668c
	dec (hl)			;668f
	ret nz			;6690
	call L_69FC		;6691
	jp 0be3dh		;6694   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_6697:
	call L_6A0E		;6697
	ret nz			;669a
	call 047b1h		;669b
	call 047feh		;669e
	ld a,008h		;66a1
	ld (0ce02h),a		;66a3
	jp 0be3dh		;66a6   ; siguiente_paso: sube el paso de la escena (0xCE01)
L_66A9:
	ld hl,0ce02h		;66a9
	dec (hl)			;66ac
	ret nz			;66ad
	ld hl,00000h		;66ae
	ld (0ce00h),hl		;66b1
	ld a,001h		;66b4
	ld (0ce40h),a		;66b6
	ret			;66b9
L_66BA:
	ld a,(0ce40h)		;66ba
	dec a			;66bd
	call 0406bh		;66be   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_66C1: 4 destinos del despachador de 0x406B (call en p01:66BE):
;   0x66C9, 0x66D6, 0x66E0, 0x66F1; lo leen p01:66BE (8 bytes)
;   0x66c1..0x66c9  (8 bytes)
DATA_tabla_66C1:
	defb 0c9h,066h	; 66c1
	defb 0d6h,066h	; 66c3
	defb 0e0h,066h	; 66c5
	defb 0f1h,066h	; 66c7

; ======================================================================
; CODIGO 0x66c9..0x678e  (197 bytes)
; ======================================================================


L_66C9:
	ld a,08eh		;66c9
	call 0509fh		;66cb   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	call L_6712		;66ce
L_66D1:
	ld hl,0ce40h		;66d1
	inc (hl)			;66d4
	ret			;66d5
L_66D6:
	call L_672F		;66d6
	ld a,(0ce32h)		;66d9
	and a			;66dc
	ret z			;66dd
	jr L_66D1		;66de
L_66E0:
	call 05309h		;66e0
	ret nz			;66e3
	ld a,01eh		;66e4
	ld (0ce02h),a		;66e6
	call 047b1h		;66e9
	call 047d4h		;66ec   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	jr L_66D1		;66ef
L_66F1:
	ld hl,0ce02h		;66f1
	dec (hl)			;66f4
	ret nz			;66f5
	xor a			;66f6
	ld (0ce34h),a		;66f7
	ld (0ce40h),a		;66fa
	inc a			;66fd
	ld (0c409h),a		;66fe
	ld hl,0d012h		;6701
	ld a,(hl)			;6704
	inc a			;6705
	cp 003h		;6706
	jr nc,L_670B		;6708
	ld (hl),a			;670a
L_670B:
	ld b,000h		;670b
	ld c,017h		;670d
	jp 00047h		;670f   ; BIOS WRTVDP - Writes data in the VDP-register
L_6712:
	call 053deh		;6712
	xor a			;6715
	ld (0ce30h),a		;6716
	ld (0ce33h),a		;6719   ; guarda la cuenta del texto del final
	ld (0ce31h),a		;671c   ; guarda el renglon del final que toca
	ld (0ce32h),a		;671f
	inc a			;6722
	ld (0ce34h),a		;6723
	ld a,00eh		;6726
	ld d,0ffh		;6728
	ld e,00fh		;672a
	jp 04814h		;672c   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
L_672F:
	call L_6738		;672f
	call L_6743		;6732
	jp L_682A		;6735
L_6738:
	ld a,(0c003h)		;6738   ; lee el contador de cuadros
	and 003h		;673b
	ret nz			;673d
	ld hl,0ce33h		;673e   ; apunta a la cuenta del texto del final
	inc (hl)			;6741
	ret			;6742
L_6743:
	di			;6743
	ld a,008h		;6744
	ld (0a000h),a		;6746   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6749   ; guarda la copia del banco de 0xA000
	ei			;674c
	di			;674d
	ld a,005h		;674e
	ld (08000h),a		;6750   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;6753   ; guarda la copia del banco de 0x8000
	ei			;6756
	ld a,(0ce31h)		;6757   ; lee el renglon del final que toca
	ld de,0678eh		;675a
	call palabra_de_la_tabla		;675d   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ex de,hl			;6760
	ld a,(0ce33h)		;6761   ; lee la cuenta del texto del final
	cp (hl)			;6764
	jp nz,05336h		;6765   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
	inc hl			;6768
	ld a,(hl)			;6769
	inc hl			;676a
	inc a			;676b
	jr z,L_6781		;676c
	ld d,a			;676e
	ld a,(0ce33h)		;676f   ; lee la cuenta del texto del final
	add a,0d8h		;6772
	ld e,a			;6774
	ld c,0ffh		;6775
	call 04ad5h		;6777
	ld hl,0ce31h		;677a   ; apunta a el renglon del final que toca
	inc (hl)			;677d
	jp 05336h		;677e   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
L_6781:
	ld a,001h		;6781
	ld (0ce32h),a		;6783
	ld a,0ffh		;6786
	call 0509fh		;6788   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jp 05336h		;678b   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; DATOS renglones_del_final: 43 punteros a los renglones del texto del final y
;   de los creditos (bancos 5 y 8); lo leen p01:675A (86 bytes)
;   0x678e..0x67e4  (86 bytes)
DATA_renglones_del_final:
	defb 020h,0bfh	; 678e
	defb 039h,0bfh	; 6790
	defb 051h,0bfh	; 6792
	defb 06ch,0bfh	; 6794
	defb 082h,0bfh	; 6796
	defb 09dh,0bfh	; 6798
	defb 0b8h,0bfh	; 679a
	defb 0c0h,082h	; 679c
	defb 0d6h,082h	; 679e
	defb 0deh,082h	; 67a0
	defb 0eeh,082h	; 67a2
	defb 0f9h,082h	; 67a4
	defb 006h,083h	; 67a6
	defb 011h,083h	; 67a8
	defb 01bh,083h	; 67aa
	defb 025h,083h	; 67ac
	defb 038h,083h	; 67ae
	defb 044h,083h	; 67b0
	defb 057h,083h	; 67b2
	defb 063h,083h	; 67b4
	defb 06eh,083h	; 67b6
	defb 07bh,083h	; 67b8
	defb 088h,083h	; 67ba
	defb 09ah,083h	; 67bc
	defb 0a5h,083h	; 67be
	defb 0b0h,083h	; 67c0
	defb 0beh,083h	; 67c2
	defb 0cch,083h	; 67c4
	defb 0dbh,083h	; 67c6
	defb 0e8h,083h	; 67c8
	defb 0ffh,083h	; 67ca
	defb 00ch,084h	; 67cc
	defb 014h,084h	; 67ce
	defb 01ch,084h	; 67d0
	defb 028h,084h	; 67d2
	defb 033h,084h	; 67d4
	defb 044h,084h	; 67d6
	defb 050h,084h	; 67d8
	defb 05ah,084h	; 67da
	defb 068h,084h	; 67dc
	defb 07ah,084h	; 67de
	defb 091h,084h	; 67e0
	defb 091h,084h	; 67e2

; ======================================================================
; CODIGO 0x67e4..0x67fd  (25 bytes)
; ======================================================================


L_67E4:
	ld hl,0ce39h		;67e4   ; apunta a la cuenta del destello
	ld a,(hl)			;67e7
	inc a			;67e8
	cp 013h		;67e9
	jr c,L_67EE		;67eb
	xor a			;67ed
L_67EE:
	ld (hl),a			;67ee
	ld hl,067fdh		;67ef
	call 04061h		;67f2   ; hl_mas_a: HL += A
	ld d,(hl)			;67f5
	ld e,005h		;67f6
	ld a,006h		;67f8
	jp 04814h		;67fa   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)

; ----------------------------------------------------------------------
; DATOS destello: 19 valores que p01:67EF va poniendo, uno por cuadro, en el
;   color 6 de la paleta (0x4814 con E = 5): la cuenta de 0xCE39 vuelve a cero
;   al llegar a 19
;   0x67fd..0x6810  (19 bytes)
DATA_destello:
	defb 065h,075h,085h,095h,0a5h,0b5h,0c5h,0d5h,0e5h,0f5h,0e5h,0d5h,0c5h,0b5h,0a5h,095h	; 67fd  eu..............
	defb 085h,075h,065h	; 680d

; ======================================================================
; CODIGO 0x6810..0x6874  (100 bytes)
; ======================================================================


L_6810:
	ld de,00000h		;6810
	ld a,006h		;6813
	jp 04814h		;6815   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
L_6818:
	ld hl,0ce38h		;6818
	inc (hl)			;681b
	ld a,(hl)			;681c
	and 01fh		;681d
	cp 01ch		;681f
	jp z,L_69A0		;6821
	cp 01fh		;6824
	ret nz			;6826
	jp L_6984		;6827
L_682A:
	ld a,(0ce33h)		;682a   ; lee la cuenta del texto del final
	sub 002h		;682d
	ld h,a			;682f
	ld l,000h		;6830
	srl h		;6832
	rr l		;6834
	ld de,00000h		;6836
	add hl,de			;6839
	ld bc,00080h		;683a
	xor a			;683d
	jp 00056h		;683e   ; BIOS FILVRM - Fills VRAM with value
L_6841:
	ld a,(0ce34h)		;6841
	and a			;6844
	ret z			;6845
	ld a,(0ce33h)		;6846   ; lee la cuenta del texto del final
	ld b,a			;6849
	ld c,017h		;684a
	jp 00047h		;684c   ; BIOS WRTVDP - Writes data in the VDP-register
L_684F:
	ld b,006h		;684f
L_6851:
	push bc			;6851
	ld c,02eh		;6852
	ld a,r		;6854
	and 00fh		;6856
	sub 008h		;6858
	ld d,a			;685a
	ld a,(0ce0fh)		;685b
	add a,d			;685e
	ld d,a			;685f
	ld a,r		;6860
	and 00fh		;6862
	add a,098h		;6864
	ld e,a			;6866
	call 05f1dh		;6867   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	pop bc			;686a
	djnz L_6851		;686b
L_686D:
	ret			;686d
L_686E:
	ld a,(0ce35h)		;686e
	call 0406bh		;6871   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_6874: 4 destinos del despachador de 0x406B (call en p01:6871):
;   0x687C, 0x6886, 0x687C, 0x6895; lo leen p01:6871 (8 bytes)
;   0x6874..0x687c  (8 bytes)
DATA_tabla_6874:
	defb 07ch,068h	; 6874
	defb 086h,068h	; 6876
	defb 07ch,068h	; 6878
	defb 095h,068h	; 687a

; ======================================================================
; CODIGO 0x687c..0x69e4  (360 bytes)
; ======================================================================


L_687C:
	ld hl,0ce37h		;687c
	dec (hl)			;687f
	ret nz			;6880
L_6881:
	ld hl,0ce35h		;6881
	inc (hl)			;6884
	ret			;6885
L_6886:
	call L_68A8		;6886
	ld a,(0ce36h)		;6889
	and a			;688c
	ret nz			;688d
	ld a,040h		;688e
	ld (0ce37h),a		;6890
	jr L_6881		;6893
L_6895:
	call L_68C4		;6895
	ld a,(0ce36h)		;6898
	cp 002h		;689b
	ret nz			;689d
	xor a			;689e
	ld (0ce35h),a		;689f
	ld a,0c0h		;68a2
	ld (0ce37h),a		;68a4
	ret			;68a7
L_68A8:
	ld hl,0ce37h		;68a8
	inc (hl)			;68ab
	cp 010h		;68ac
	jr z,L_68B9		;68ae
	ld a,(hl)			;68b0
	sub 010h		;68b1
	ret nz			;68b3
	ld (0ce36h),a		;68b4
	jr L_6914		;68b7
L_68B9:
	ld hl,0ce36h		;68b9
	ld a,(hl)			;68bc
	ld (hl),001h		;68bd
	cp 002h		;68bf
	ret nz			;68c1
	jr L_68DC		;68c2
L_68C4:
	ld hl,0ce37h		;68c4
	inc (hl)			;68c7
	ld a,(hl)			;68c8
	cp 010h		;68c9
	jr z,L_68D7		;68cb
	cp 020h		;68cd
	ret nz			;68cf
	ld a,002h		;68d0
	ld (0ce36h),a		;68d2
	jr L_694C		;68d5
L_68D7:
	ld a,001h		;68d7
	ld (0ce36h),a		;68d9
L_68DC:
	ld hl,060a0h		;68dc
	ld de,07080h		;68df
	ld bc,01010h		;68e2
	ld a,001h		;68e5
	call 04946h		;68e7   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,0a0a0h		;68ea
	ld de,08080h		;68ed
	ld bc,01010h		;68f0
	ld a,001h		;68f3
	call 04946h		;68f5   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,050a0h		;68f8
	ld de,07090h		;68fb
	ld bc,01010h		;68fe
	ld a,001h		;6901
	call 04946h		;6903   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,090a0h		;6906
	ld de,08090h		;6909
	ld bc,01010h		;690c
	ld a,001h		;690f
	jp 04946h		;6911   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_6914:
	ld hl,040a0h		;6914
	ld de,07080h		;6917
	ld bc,01010h		;691a
	ld a,001h		;691d
	call 04946h		;691f   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,080a0h		;6922
	ld de,08080h		;6925
	ld bc,01010h		;6928
	ld a,001h		;692b
	call 04946h		;692d   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,050a0h		;6930
	ld de,07090h		;6933
	ld bc,01010h		;6936
	ld a,001h		;6939
	call 04946h		;693b   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,090a0h		;693e
	ld de,08090h		;6941
	ld bc,01010h		;6944
	ld a,001h		;6947
	jp 04946h		;6949   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_694C:
	ld hl,060a0h		;694c
	ld de,07080h		;694f
	ld bc,01010h		;6952
	ld a,001h		;6955
	call 04946h		;6957   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,0a0a0h		;695a
	ld de,08080h		;695d
	ld bc,01010h		;6960
	ld a,001h		;6963
	call 04946h		;6965   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,070a0h		;6968
	ld de,07090h		;696b
	ld bc,01010h		;696e
	ld a,001h		;6971
	call 04946h		;6973   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,0b0a0h		;6976
	ld de,08090h		;6979
	ld bc,01010h		;697c
	ld a,001h		;697f
	jp 04946h		;6981   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_6984:
	ld hl,000a0h		;6984
	ld de,06858h		;6987
	ld bc,01010h		;698a
	ld a,001h		;698d
	call 04946h		;698f   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,010a0h		;6992
	ld de,08858h		;6995
	ld bc,01010h		;6998
	ld a,001h		;699b
	jp 04946h		;699d   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_69A0:
	ld hl,020a0h		;69a0
	ld de,06858h		;69a3
	ld bc,01010h		;69a6
	ld a,001h		;69a9
	call 04946h		;69ab   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,030a0h		;69ae
	ld de,08858h		;69b1
	ld bc,01010h		;69b4
	ld a,001h		;69b7
	jp 04946h		;69b9   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_69BC:
	xor a			;69bc
	ld (ix+07eh),a		;69bd
	ld (ix+00eh),a		;69c0
	ld (ix+006h),001h		;69c3   ; la cosa se mueve
	ld (ix+00bh),05ah		;69c7   ; el dibujo de la cosa = 0x5A
	ld hl,0ce12h		;69cb
	ld a,(hl)			;69ce
	inc (hl)			;69cf
	add a,a			;69d0
	ld de,069e4h		;69d1
	call palabra_de_la_tabla		;69d4   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	call 0a55dh		;69d7   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	inc hl			;69da
	ld e,(hl)			;69db
	inc hl			;69dc
	ld d,(hl)			;69dd
	call 0a56ch		;69de   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	jp palabra_de_la_tabla		;69e1   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE

; ----------------------------------------------------------------------
; DATOS seis_pares_de_velocidades: seis entradas de dos palabras que p01:69D1
;   recorre con la cuenta de 0xCE12 y pasa a 0xA55D y 0xA56C
;   0x69e4..0x69fc  (24 bytes)
DATA_seis_pares_de_velocidades:
	defb 040h,0fbh,000h,001h,080h,0fdh,000h,002h,080h,001h,020h,003h,000h,004h,000h,0ffh	; 69e4  @......... .....
	defb 080h,0ffh,000h,0fch,000h,0feh,040h,0fdh	; 69f4  ......@.

; ======================================================================
; CODIGO 0x69fc..0x6a8c  (144 bytes)
; ======================================================================


L_69FC:
	ld hl,0f680h		;69fc
	ld de,0ce60h		;69ff
	ld bc,00020h		;6a02
	call 0465ah		;6a05
	ld a,080h		;6a08
	ld (0ce13h),a		;6a0a
	ret			;6a0d
L_6A0E:
	ld hl,0ce13h		;6a0e
	dec (hl)			;6a11
	ld a,(hl)			;6a12
	and 00fh		;6a13
	ld c,a			;6a15
	add a,a			;6a16
	ld hl,0ce60h		;6a17
	call 04061h		;6a1a   ; hl_mas_a: HL += A
	ld a,(hl)			;6a1d
	and 0f0h		;6a1e
	jr z,L_6A24		;6a20
	sub 010h		;6a22
L_6A24:
	ld d,a			;6a24
	ld a,(hl)			;6a25
	and 00fh		;6a26
	jr z,L_6A2B		;6a28
	dec a			;6a2a
L_6A2B:
	or d			;6a2b
	ld (hl),a			;6a2c
	ld d,a			;6a2d
	inc hl			;6a2e
	ld a,(hl)			;6a2f
	and a			;6a30
	jr z,L_6A34		;6a31
	dec a			;6a33
L_6A34:
	ld (hl),a			;6a34
	inc hl			;6a35
	ld e,a			;6a36
	ld a,c			;6a37
	call 04814h		;6a38   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
	ld a,(0ce13h)		;6a3b
	and a			;6a3e
	ret			;6a3f
L_6A40:
	ld (ix+00eh),005h		;6a40
	ld (ix+006h),000h		;6a44   ; la cosa se queda quieta
L_6A48:
	ret			;6a48
L_6A49:
	ld a,(0ce36h)		;6a49
	cp 002h		;6a4c
	ret nz			;6a4e
	ld a,(0c003h)		;6a4f   ; lee el contador de cuadros
	and 007h		;6a52
	ret nz			;6a54
	ld c,02ch		;6a55
	ld de,08098h		;6a57
	jp 05f1dh		;6a5a   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
L_6A5D:
	ld (ix+006h),001h		;6a5d   ; la cosa se mueve
	ld (ix+00ch),008h		;6a61   ; la cuenta de cuadros del paso = 0x08
	ld (ix+011h),000h		;6a65
	ld (ix+00bh),002h		;6a69   ; el dibujo de la cosa = 0x02
	ld de,00300h		;6a6d
	call 0a55dh		;6a70   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld hl,0cf32h		;6a73
	inc (hl)			;6a76
	ld a,(hl)			;6a77
	and 007h		;6a78
	ld de,06a8ch		;6a7a
	call palabra_de_la_tabla		;6a7d   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld a,(0c427h)		;6a80   ; lee la X de Simon
	sub (ix+005h)		;6a83   ; le resta la x de la cosa
	call c,0a17ch		;6a86   ; niega_de: DE = -DE
	jp 0a56ch		;6a89   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE

; ----------------------------------------------------------------------
; DATOS ocho_palabras: ocho palabras que p01:6A7A elige con los tres bits
;   bajos de lo que lee
;   0x6a8c..0x6a9c  (16 bytes)
DATA_ocho_palabras:
	defb 000h,001h,080h,002h,080h,001h,000h,002h,040h,002h,040h,001h,000h,003h,0c0h,001h	; 6a8c  ........@.@.....

; ======================================================================
; CODIGO 0x6a9c..0x6aad  (17 bytes)
; ======================================================================


L_6A9C:
	ld a,(ix+001h)		;6a9c   ; lee el paso en que va la cosa
	cp 004h		;6a9f
	ld de,0ffd0h		;6aa1
	call nz,0a549h		;6aa4   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
	ld a,(ix+001h)		;6aa7   ; lee el paso en que va la cosa
	call 0406bh		;6aaa   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_6AAD: 5 destinos del despachador de 0x406B (call en p01:6AAA):
;   0x6AB7, 0x6AC7, 0x6ADF, 0x6AEB, 0x6AF9; lo leen p01:6AAA (10 bytes)
;   0x6aad..0x6ab7  (10 bytes)
DATA_tabla_6AAD:
	defb 0b7h,06ah	; 6aad
	defb 0c7h,06ah	; 6aaf
	defb 0dfh,06ah	; 6ab1
	defb 0ebh,06ah	; 6ab3
	defb 0f9h,06ah	; 6ab5

; ======================================================================
; CODIGO 0x6ab7..0x6b42  (139 bytes)
; ======================================================================


L_6AB7:
	dec (ix+00ch)		;6ab7   ; baja la cuenta de cuadros del paso
	ret nz			;6aba
	ld (ix+00bh),0a5h		;6abb   ; el dibujo de la cosa = 0xA5
	ld (ix+00ch),008h		;6abf   ; la cuenta de cuadros del paso = 0x08
	inc (ix+001h)		;6ac3   ; sube el paso en que va la cosa
	ret			;6ac6
L_6AC7:
	dec (ix+00ch)		;6ac7   ; baja la cuenta de cuadros del paso
	ret nz			;6aca
	bit 7,(ix+00ah)		;6acb   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	ld a,0a6h		;6acf
	jr nz,L_6AD4		;6ad1
	inc a			;6ad3
L_6AD4:
	ld (ix+00bh),a		;6ad4   ; guarda el dibujo de la cosa
	ld (ix+00ch),008h		;6ad7   ; la cuenta de cuadros del paso = 0x08
	inc (ix+001h)		;6adb   ; sube el paso en que va la cosa
	ret			;6ade
L_6ADF:
	dec (ix+00ch)		;6adf   ; baja la cuenta de cuadros del paso
	ret nz			;6ae2
	ld (ix+00ch),018h		;6ae3   ; la cuenta de cuadros del paso = 0x18
	inc (ix+001h)		;6ae7   ; sube el paso en que va la cosa
	ret			;6aea
L_6AEB:
	ld a,(ix+011h)		;6aeb
	call L_6AF9		;6aee
	dec (ix+00ch)		;6af1   ; baja la cuenta de cuadros del paso
	ret nz			;6af4
	inc (ix+001h)		;6af5   ; sube el paso en que va la cosa
	ret			;6af8
L_6AF9:
	ld a,(ix+011h)		;6af9
	jp 0b15dh		;6afc
L_6AFF:
	ld a,(0ce11h)		;6aff
	and a			;6b02
	jr z,L_6B0C		;6b03
	xor a			;6b05
	ld (0c007h),a		;6b06
	ld (0c006h),a		;6b09
L_6B0C:
	call L_7718		;6b0c
	call L_6B39		;6b0f
	ld a,(0c5ach)		;6b12   ; lee el estado de la puerta de la fase
	cp 002h		;6b15
	jr z,L_6B24		;6b17
	cp 003h		;6b19
	jr z,L_6B24		;6b1b
	cp 005h		;6b1d
	jr z,L_6B24		;6b1f
	call L_710D		;6b21
L_6B24:
	call L_767B		;6b24
	call L_75C0		;6b27
	call L_75E2		;6b2a
	call L_75F2		;6b2d
	call L_75D4		;6b30
	call L_7604		;6b33
	jp L_7618		;6b36
L_6B39:
	call 08524h		;6b39
	ld a,(0c420h)		;6b3c
	call 0406bh		;6b3f   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_6B42: 8 destinos del despachador de 0x406B (call en p01:6B3F):
;   0x6B52, 0x6CC0, 0x6DA9, 0x6DDD, 0x6F3D, 0x6F85, 0x7093, 0x70FB; lo leen
;   p01:6B3F (16 bytes)
;   0x6b42..0x6b52  (16 bytes)
DATA_tabla_6B42:
	defb 052h,06bh	; 6b42
	defb 0c0h,06ch	; 6b44
	defb 0a9h,06dh	; 6b46
	defb 0ddh,06dh	; 6b48
	defb 03dh,06fh	; 6b4a
	defb 085h,06fh	; 6b4c
	defb 093h,070h	; 6b4e
	defb 0fbh,070h	; 6b50

; ======================================================================
; CODIGO 0x6b52..0x6cc6  (372 bytes)
; ======================================================================


L_6B52:
	call mira_el_suelo		;6b52   ; mira_el_suelo: mira el decorado bajo los pies de Simon (y de 0xC425, x de 0xC427)
	jr c,L_6B5D		;6b55
	ld a,(0c439h)		;6b57
	and a			;6b5a
	jr z,L_6BA5		;6b5b
L_6B5D:
	ld a,(0c5ach)		;6b5d   ; lee el estado de la puerta de la fase
	cp 004h		;6b60
	jr z,L_6B67		;6b62
	cp 002h		;6b64
	ret nc			;6b66
L_6B67:
	ld a,(0c439h)		;6b67
	and a			;6b6a
	call nz,L_6BAF		;6b6b
	ld a,(0c422h)		;6b6e
	and a			;6b71
	ret nz			;6b72
	ld de,00000h		;6b73
	ld (0c42eh),de		;6b76   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	call pose_segun_el_lado		;6b7a   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	ld a,(0c007h)		;6b7d
	rra			;6b80
	jr c,L_6BDA		;6b81
L_6B83:
	rra			;6b83
	jp c,L_6C10		;6b84
	rra			;6b87
	push af			;6b88
	call c,L_6C2F		;6b89
	pop af			;6b8c
	rra			;6b8d
	call c,L_6C53		;6b8e
	ld a,(0c006h)		;6b91
	and 020h		;6b94
	ret z			;6b96
	call L_7B78		;6b97
	ret c			;6b9a
	ld a,001h		;6b9b
	ld (0c420h),a		;6b9d
	xor a			;6ba0
	ld (0c421h),a		;6ba1
	ret			;6ba4
L_6BA5:
	ld a,004h		;6ba5
	ld (0c420h),a		;6ba7
	xor a			;6baa
	ld (0c421h),a		;6bab
	ret			;6bae
L_6BAF:
	dec a			;6baf
	ld a,007h		;6bb0
	jr nz,L_6BB5		;6bb2
	xor a			;6bb4
L_6BB5:
	ld hl,0c598h		;6bb5
	call 04061h		;6bb8   ; hl_mas_a: HL += A
	inc hl			;6bbb
	inc hl			;6bbc
	inc hl			;6bbd
	ld a,(hl)			;6bbe
	rla			;6bbf
	ld d,000h		;6bc0
	jr c,L_6BCC		;6bc2
	call L_7BA9		;6bc4
	ret c			;6bc7
	ld d,001h		;6bc8
	jr L_6BD2		;6bca
L_6BCC:
	call L_7C05		;6bcc
	ret c			;6bcf
	ld d,0ffh		;6bd0
L_6BD2:
	ld a,(0c427h)		;6bd2   ; lee la X de Simon
	add a,d			;6bd5
	ld (0c427h),a		;6bd6   ; guarda la X de Simon
	ret			;6bd9
L_6BDA:
	ex af,af'			;6bda
	call L_7CDB		;6bdb
	ld bc,00001h		;6bde
	jr z,L_6BEE		;6be1
	call L_7D05		;6be3
	ld bc,00101h		;6be6
	jr z,L_6BEE		;6be9
	ex af,af'			;6beb
	jr L_6B83		;6bec
L_6BEE:
	ld a,003h		;6bee
	ld (0c420h),a		;6bf0
	ld a,c			;6bf3
	ld (0c435h),a		;6bf4
	ld a,b			;6bf7
	ld (0c421h),a		;6bf8
	rra			;6bfb
	ld a,(0c427h)		;6bfc   ; lee la X de Simon
	jr nc,L_6C03		;6bff
	add a,008h		;6c01
L_6C03:
	and 0f8h		;6c03
	ld (0c427h),a		;6c05   ; guarda la X de Simon
	xor a			;6c08
	ld (0c424h),a		;6c09   ; guarda la fraccion de la y de Simon
	ld (0c426h),a		;6c0c   ; guarda la fraccion de la x de Simon
	ret			;6c0f
L_6C10:
	call L_7C8B		;6c10
	ld bc,00002h		;6c13
	jr z,L_6BEE		;6c16
	call L_7CB3		;6c18
	ld bc,00102h		;6c1b
	jr z,L_6BEE		;6c1e
	ld a,002h		;6c20
	ld (0c420h),a		;6c22
	ld de,00006h		;6c25
	ld (0c42eh),de		;6c28   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	jp pose_segun_el_lado		;6c2c   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
L_6C2F:
	ld a,001h		;6c2f
	ld (0c42ch),a		;6c31   ; guarda el lado al que mira Simon (0 derecha)
	ld a,(0c41eh)		;6c34
	inc a			;6c37
	jr nz,L_6C40		;6c38
	ld a,(0c427h)		;6c3a   ; lee la X de Simon
	cp 010h		;6c3d
	ret c			;6c3f
L_6C40:
	call L_7C05		;6c40
	ret c			;6c43
	ld a,(0c431h)		;6c44
	and 008h		;6c47
	ld bc,0fe00h		;6c49
	jr z,L_6C51		;6c4c
	ld bc,0fd80h		;6c4e
L_6C51:
	jr L_6C73		;6c51
L_6C53:
	xor a			;6c53
	ld (0c42ch),a		;6c54   ; guarda el lado al que mira Simon (0 derecha)
	ld a,(0c41fh)		;6c57
	inc a			;6c5a
	jr nz,L_6C63		;6c5b
	ld a,(0c427h)		;6c5d   ; lee la X de Simon
	cp 0f0h		;6c60
	ret nc			;6c62
L_6C63:
	call L_7BA9		;6c63
	ret c			;6c66
	ld a,(0c431h)		;6c67
	and 008h		;6c6a
	ld bc,00200h		;6c6c
	jr z,L_6C73		;6c6f
	ld c,080h		;6c71
L_6C73:
	push bc			;6c73
	ld a,(0c425h)		;6c74   ; lee la Y de Simon
	ld b,a			;6c77
	ld a,(0c427h)		;6c78   ; lee la X de Simon
	ld c,a			;6c7b
	call 08580h		;6c7c
	pop bc			;6c7f
	ret c			;6c80
	ld a,(0c5ach)		;6c81   ; lee el estado de la puerta de la fase
	dec a			;6c84
	dec a			;6c85
	cp 002h		;6c86
	ret c			;6c88
	ld a,(0c420h)		;6c89
	cp 005h		;6c8c
	jr z,L_6C94		;6c8e
	dec a			;6c90
	call nz,L_6C9C		;6c91
L_6C94:
	ld hl,(0c426h)		;6c94   ; lee la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	add hl,bc			;6c97
	ld (0c426h),hl		;6c98   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	ret			;6c9b
L_6C9C:
	ld a,(0c007h)		;6c9c
	and 00ch		;6c9f
	cp 00ch		;6ca1
	ret z			;6ca3
L_6CA4:
	ld a,(0c003h)		;6ca4   ; lee el contador de cuadros
	rra			;6ca7
	rra			;6ca8
	rra			;6ca9
	ld de,00101h		;6caa
	jr c,L_6CB8		;6cad
	rra			;6caf
	ld de,00000h		;6cb0
	jr c,L_6CB8		;6cb3
	ld de,00202h		;6cb5
L_6CB8:
	ld hl,(0c42eh)		;6cb8   ; lee las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	add hl,de			;6cbb
	ld (0c42eh),hl		;6cbc   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	ret			;6cbf
L_6CC0:
	ld a,(0c421h)		;6cc0
	call 0406bh		;6cc3   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_6CC6: 4 destinos del despachador de 0x406B (call en p01:6CC3):
;   0x6CCE, 0x6CE7, 0x6D61, 0x6D67; lo leen p01:6CC3 (8 bytes)
;   0x6cc6..0x6cce  (8 bytes)
DATA_tabla_6CC6:
	defb 0ceh,06ch	; 6cc6
	defb 0e7h,06ch	; 6cc8
	defb 061h,06dh	; 6cca
	defb 067h,06dh	; 6ccc

; ======================================================================
; CODIGO 0x6cce..0x6d94  (198 bytes)
; ======================================================================


L_6CCE:
	ld b,001h		;6cce
	ld a,(0c007h)		;6cd0
	and 00ch		;6cd3
	jr z,L_6CE2		;6cd5
	rra			;6cd7
	rra			;6cd8
	cp 003h		;6cd9
	jr nc,L_6CE2		;6cdb
	rra			;6cdd
	inc b			;6cde
	jr c,L_6CE2		;6cdf
	inc b			;6ce1
L_6CE2:
	ld hl,0c421h		;6ce2
	ld (hl),b			;6ce5
	ret			;6ce6
L_6CE7:
	ld a,(0c431h)		;6ce7
	and 010h		;6cea
	ld bc,06d95h		;6cec
	ld d,013h		;6cef
	jr z,L_6CF8		;6cf1
	ld bc,06d94h		;6cf3
	ld d,015h		;6cf6
L_6CF8:
	ld hl,0c428h		;6cf8
	push hl			;6cfb
	call aplica_la_curva		;6cfc   ; aplica_la_curva: sube la cuenta de (HL) hasta D y suma a la y de Simon el paso de la curva de BC
	pop hl			;6cff
	ld a,(0c422h)		;6d00
	and a			;6d03
	jr nz,L_6D13		;6d04
	ld d,000h		;6d06
	ld e,006h		;6d08
	ld (0c42eh),de		;6d0a   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	push hl			;6d0e
	call pose_segun_el_lado		;6d0f   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	pop hl			;6d12
L_6D13:
	ld a,(hl)			;6d13
	cp 009h		;6d14
	ret c			;6d16
	ld de,0cff0h		;6d17   ; apunta a el tipo de la cosa que se crea
	xor a			;6d1a
	ld (de),a			;6d1b
	ld a,(hl)			;6d1c
	dec a			;6d1d
	dec a			;6d1e
	cp 013h		;6d1f
	push hl			;6d21
	call nc,L_6D6D		;6d22
	pop hl			;6d25
	call mira_el_suelo		;6d26   ; mira_el_suelo: mira el decorado bajo los pies de Simon (y de 0xC425, x de 0xC427)
	jr c,L_6D30		;6d29
	ld a,(0c439h)		;6d2b
	and a			;6d2e
	ret z			;6d2f
L_6D30:
	ld a,(0cff0h)		;6d30   ; lee el tipo de la cosa que se crea
	and a			;6d33
	jr z,L_6D3B		;6d34
	ld a,007h		;6d36
	call 0509fh		;6d38   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_6D3B:
	ld hl,0c425h		;6d3b   ; apunta a la Y de Simon
	ld a,(hl)			;6d3e
	and 0f8h		;6d3f
	ld (hl),a			;6d41
	xor a			;6d42
	ld (0c420h),a		;6d43
	ld (0c421h),a		;6d46
	ld (0c428h),a		;6d49
	ret			;6d4c
aplica_la_curva:
	inc (hl)			;6d4d
	ld a,(hl)			;6d4e
	cp d			;6d4f
	jr c,L_6D53		;6d50
	ld a,d			;6d52
L_6D53:
	dec a			;6d53
	ld h,b			;6d54
	ld l,c			;6d55
	call 04061h		;6d56   ; hl_mas_a: HL += A
	ld a,(0c425h)		;6d59   ; lee la Y de Simon
	add a,(hl)			;6d5c
	ld (0c425h),a		;6d5d   ; guarda la Y de Simon
	ret			;6d60
L_6D61:
	call L_6C2F		;6d61
	jp L_6CE7		;6d64
L_6D67:
	call L_6C53		;6d67
	jp L_6CE7		;6d6a
L_6D6D:
	ld a,001h		;6d6d
	ld (de),a			;6d6f
	ld a,(0c420h)		;6d70
	dec a			;6d73
	ret z			;6d74
	push af			;6d75
	ld a,(hl)			;6d76
	sub 013h		;6d77
	add a,a			;6d79
	add a,a			;6d7a
	add a,a			;6d7b
	ld e,a			;6d7c
	pop af			;6d7d
	dec a			;6d7e
	jr z,L_6D8A		;6d7f
	dec a			;6d81
	ld a,e			;6d82
	neg		;6d83
	ld d,0ffh		;6d85
	ld e,a			;6d87
	jr L_6D8C		;6d88
L_6D8A:
	ld d,000h		;6d8a
L_6D8C:
	ld hl,(0c426h)		;6d8c   ; lee la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	add hl,de			;6d8f
	ld (0c426h),hl		;6d90   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	ret			;6d93

; ----------------------------------------------------------------------
; DATOS curva_del_salto: la curva del salto de Simon: 21 desplazamientos
;   verticales por cuadro (negativos subiendo, positivos cayendo); p01:6CEC
;   entra en 0x6D95 o 0x6D94 (un paso antes) con D = 19 o 21 pasos
;   0x6d94..0x6da9  (21 bytes)
DATA_curva_del_salto:
	defb 0fah,0fah,0fah,0fbh,0fbh,000h,0fch,0fdh,0feh,0ffh,000h,000h,001h,002h,003h,004h	; 6d94  ................
	defb 005h,005h,006h,006h,006h	; 6da4

; ======================================================================
; CODIGO 0x6da9..0x6f81  (472 bytes)
; ======================================================================


L_6DA9:
	call 085f4h		;6da9
	jr nc,L_6DC8		;6dac
	ld a,(0c006h)		;6dae
	and 020h		;6db1
	jr z,L_6DC8		;6db3
	ld a,007h		;6db5
	ld (0c420h),a		;6db7
	xor a			;6dba
	ld (0c421h),a		;6dbb
	ld a,040h		;6dbe
	ld (0c42dh),a		;6dc0
	ld a,015h		;6dc3
	jp 0509fh		;6dc5   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_6DC8:
	ld a,(0c439h)		;6dc8
	and a			;6dcb
	call nz,L_6BAF		;6dcc
	ld a,(0c422h)		;6dcf
	and a			;6dd2
	ret nz			;6dd3
	ld a,(0c007h)		;6dd4
	rra			;6dd7
	rra			;6dd8
	ret c			;6dd9
	jp L_6EF5		;6dda
L_6DDD:
	ld a,(0c422h)		;6ddd
	and a			;6de0
	ret nz			;6de1
	ld a,(0c435h)		;6de2
	and a			;6de5
	jr nz,L_6DEB		;6de6
	ld a,(0c007h)		;6de8
L_6DEB:
	ld b,a			;6deb
	ld de,00100h		;6dec
	ld a,(0c421h)		;6def
	and a			;6df2
	ld a,b			;6df3
	jr nz,L_6E07		;6df4
	rra			;6df6
	jp c,L_6EBC		;6df7
	rra			;6dfa
	jp c,L_6E14		;6dfb
	rra			;6dfe
	jp c,L_6EBC		;6dff
	rra			;6e02
	jp c,L_6E14		;6e03
	ret			;6e06
L_6E07:
	rra			;6e07
	jr c,L_6E84		;6e08
	rra			;6e0a
	jr c,L_6E4B		;6e0b
	rra			;6e0d
	jr c,L_6E4B		;6e0e
	rra			;6e10
	jr c,L_6E84		;6e11
	ret			;6e13
L_6E14:
	ld hl,(0c424h)		;6e14   ; lee la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	add hl,de			;6e17
	ld (0c424h),hl		;6e18   ; guarda la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	ld hl,(0c426h)		;6e1b   ; lee la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	add hl,de			;6e1e
	ld (0c426h),hl		;6e1f   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	xor a			;6e22
	ld (0c42ch),a		;6e23   ; guarda el lado al que mira Simon (0 derecha)
	ld de,00103h		;6e26
	ld (0c42eh),de		;6e29   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	call L_6F09		;6e2d
	ld hl,0c42bh		;6e30
	inc (hl)			;6e33
	ld a,(hl)			;6e34
	ld b,a			;6e35
	and 007h		;6e36
	ld a,008h		;6e38
	jr nz,L_6E3D		;6e3a
	xor a			;6e3c
L_6E3D:
	ld (0c435h),a		;6e3d
	ld a,b			;6e40
	cp 008h		;6e41
	ret c			;6e43
	call mira_el_suelo		;6e44   ; mira_el_suelo: mira el decorado bajo los pies de Simon (y de 0xC425, x de 0xC427)
	ret nc			;6e47
	jp L_6EF5		;6e48
L_6E4B:
	or a			;6e4b
	ld hl,(0c424h)		;6e4c   ; lee la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	add hl,de			;6e4f
	ld (0c424h),hl		;6e50   ; guarda la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	ld hl,(0c426h)		;6e53   ; lee la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	sbc hl,de		;6e56
	ld (0c426h),hl		;6e58   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	ld a,001h		;6e5b
	ld (0c42ch),a		;6e5d   ; guarda el lado al que mira Simon (0 derecha)
	ld de,0100dh		;6e60
	ld (0c42eh),de		;6e63   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	call L_6F09		;6e67
	ld hl,0c42bh		;6e6a
	inc (hl)			;6e6d
	ld a,(hl)			;6e6e
	ld b,a			;6e6f
	and 007h		;6e70
	ld a,004h		;6e72
	jr nz,L_6E77		;6e74
	xor a			;6e76
L_6E77:
	ld (0c435h),a		;6e77
	ld a,b			;6e7a
	cp 008h		;6e7b
	ret c			;6e7d
	call mira_el_suelo		;6e7e   ; mira_el_suelo: mira el decorado bajo los pies de Simon (y de 0xC425, x de 0xC427)
	ret nc			;6e81
	jr L_6EF5		;6e82
L_6E84:
	or a			;6e84
	ld hl,(0c424h)		;6e85   ; lee la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	sbc hl,de		;6e88
	ld (0c424h),hl		;6e8a   ; guarda la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	ld hl,(0c426h)		;6e8d   ; lee la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	add hl,de			;6e90
	ld (0c426h),hl		;6e91   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	xor a			;6e94
	ld (0c42ch),a		;6e95   ; guarda el lado al que mira Simon (0 derecha)
	ld de,00103h		;6e98
	ld (0c42eh),de		;6e9b   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	call L_6F24		;6e9f
	ld hl,0c42bh		;6ea2
	inc (hl)			;6ea5
	ld a,(hl)			;6ea6
	ld b,a			;6ea7
	and 007h		;6ea8
	ld a,008h		;6eaa
	jr nz,L_6EAF		;6eac
	xor a			;6eae
L_6EAF:
	ld (0c435h),a		;6eaf
	ld a,b			;6eb2
	cp 008h		;6eb3
	ret c			;6eb5
	call L_7B68		;6eb6
	ret nc			;6eb9
	jr L_6EF5		;6eba
L_6EBC:
	or a			;6ebc
	ld hl,(0c424h)		;6ebd   ; lee la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	sbc hl,de		;6ec0
	ld (0c424h),hl		;6ec2   ; guarda la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	or a			;6ec5
	ld hl,(0c426h)		;6ec6   ; lee la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	sbc hl,de		;6ec9
	ld (0c426h),hl		;6ecb   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	ld a,001h		;6ece
	ld (0c42ch),a		;6ed0   ; guarda el lado al que mira Simon (0 derecha)
	ld de,0100dh		;6ed3
	ld (0c42eh),de		;6ed6   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	call L_6F24		;6eda
	ld hl,0c42bh		;6edd
	inc (hl)			;6ee0
	ld a,(hl)			;6ee1
	ld b,a			;6ee2
	and 007h		;6ee3
	ld a,004h		;6ee5
	jr nz,L_6EEA		;6ee7
	xor a			;6ee9
L_6EEA:
	ld (0c435h),a		;6eea
	ld a,b			;6eed
	cp 008h		;6eee
	ret c			;6ef0
	call L_7B68		;6ef1
	ret nc			;6ef4
L_6EF5:
	ld de,00000h		;6ef5
	ld (0c42eh),de		;6ef8   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	xor a			;6efc
	ld (0c435h),a		;6efd
	ld (0c42bh),a		;6f00
	call pose_segun_el_lado		;6f03   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	jp L_6D3B		;6f06
L_6F09:
	ld a,(0c42bh)		;6f09
	rra			;6f0c
	rra			;6f0d
	and 001h		;6f0e
	ld c,a			;6f10
	neg		;6f11
	inc a			;6f13
	ld b,a			;6f14
	ld a,(0c42eh)		;6f15   ; lee la pose de arriba de Simon
	add a,b			;6f18
	ld (0c42eh),a		;6f19   ; guarda la pose de arriba de Simon
	ld a,(0c42fh)		;6f1c   ; lee la pose de abajo de Simon
	add a,c			;6f1f
	ld (0c42fh),a		;6f20   ; guarda la pose de abajo de Simon
	ret			;6f23
L_6F24:
	ld a,(0c42bh)		;6f24
	rra			;6f27
	rra			;6f28
	and 001h		;6f29
	ld c,a			;6f2b
	inc a			;6f2c
	ld b,a			;6f2d
	ld a,(0c42eh)		;6f2e   ; lee la pose de arriba de Simon
	add a,b			;6f31
	ld (0c42eh),a		;6f32   ; guarda la pose de arriba de Simon
	ld a,(0c42fh)		;6f35   ; lee la pose de abajo de Simon
	add a,c			;6f38
	ld (0c42fh),a		;6f39   ; guarda la pose de abajo de Simon
	ret			;6f3c
L_6F3D:
	ld a,(0c439h)		;6f3d
	and a			;6f40
	jr nz,L_6F6A		;6f41
	call mira_el_suelo		;6f43   ; mira_el_suelo: mira el decorado bajo los pies de Simon (y de 0xC425, x de 0xC427)
	jr c,L_6F6A		;6f46
	ld de,00000h		;6f48
	ld (0c42eh),de		;6f4b   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	call pose_segun_el_lado		;6f4f   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	ld hl,0c428h		;6f52
	ld a,(hl)			;6f55
	inc (hl)			;6f56
	cp 003h		;6f57
	jr c,L_6F5C		;6f59
	dec (hl)			;6f5b
L_6F5C:
	ld hl,06f81h		;6f5c
	call 04061h		;6f5f   ; hl_mas_a: HL += A
	ld a,(0c425h)		;6f62   ; lee la Y de Simon
	add a,(hl)			;6f65
	ld (0c425h),a		;6f66   ; guarda la Y de Simon
	ret			;6f69
L_6F6A:
	ld a,(0c425h)		;6f6a   ; lee la Y de Simon
	and 0f8h		;6f6d
	ld (0c425h),a		;6f6f   ; guarda la Y de Simon
	xor a			;6f72
	ld (0c428h),a		;6f73
	ld (0c420h),a		;6f76
	ld (0c421h),a		;6f79
	ld a,007h		;6f7c
	jp 0509fh		;6f7e   ; sonido: arranca la musica o el efecto A (bit 7 = musica)

; ----------------------------------------------------------------------
; DATOS cuatro_ajustes: cuatro valores que p01:6F5C suma a 0xC425 segun el
;   indice
;   0x6f81..0x6f85  (4 bytes)
DATA_cuatro_ajustes:
	defb 002h,004h,006h,006h	; 6f81

; ======================================================================
; CODIGO 0x6f85..0x6f8b  (6 bytes)
; ======================================================================


L_6F85:
	ld a,(0c423h)		;6f85
	call 0406bh		;6f88   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_6F8B: 4 destinos del despachador de 0x406B (call en p01:6F88):
;   0x6F93, 0x6FD4, 0x7017, 0x701D; lo leen p01:6F88 (8 bytes)
;   0x6f8b..0x6f93  (8 bytes)
DATA_tabla_6F8B:
	defb 093h,06fh	; 6f8b
	defb 0d4h,06fh	; 6f8d
	defb 017h,070h	; 6f8f
	defb 01dh,070h	; 6f91

; ======================================================================
; CODIGO 0x6f93..0x707d  (234 bytes)
; ======================================================================


L_6F93:
	ld a,(0c002h)		;6f93   ; lee las banderas de la partida (bit 7: de verdad, no la demostracion)
	and 040h		;6f96
	ld a,013h		;6f98
	call nz,0509fh		;6f9a   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,05ah		;6f9d
	ld (0c42dh),a		;6f9f
	ld a,(0c42bh)		;6fa2
	and a			;6fa5
	jp z,L_6FBC		;6fa6
	ld a,(0c415h)		;6fa9   ; lee la vida de Simon
	and a			;6fac
	jr z,L_6FBC		;6fad
	ld a,003h		;6faf
	ld (0c420h),a		;6fb1
	ld a,002h		;6fb4
	ld (0c42fh),a		;6fb6   ; guarda la pose de abajo de Simon
	jp pose_segun_el_lado		;6fb9   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
L_6FBC:
	ld a,(0c43ch)		;6fbc
	ld (0c42ch),a		;6fbf   ; guarda el lado al que mira Simon (0 derecha)
	inc a			;6fc2
	ld (0c423h),a		;6fc3
	xor a			;6fc6
	ld (0c42ah),a		;6fc7
	ld de,00307h		;6fca
	ld (0c42eh),de		;6fcd   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	jp pose_segun_el_lado		;6fd1   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
L_6FD4:
	call L_6C2F		;6fd4
L_6FD7:
	ld bc,0707dh		;6fd7
	ld d,015h		;6fda
	ld hl,0c42ah		;6fdc
	push hl			;6fdf
	call aplica_la_curva		;6fe0   ; aplica_la_curva: sube la cuenta de (HL) hasta D y suma a la y de Simon el paso de la curva de BC
	pop hl			;6fe3
	ld a,(hl)			;6fe4
	cp 00bh		;6fe5
	ret c			;6fe7
	call mira_el_suelo		;6fe8   ; mira_el_suelo: mira el decorado bajo los pies de Simon (y de 0xC425, x de 0xC427)
	jr c,L_6FF2		;6feb
	ld a,(0c439h)		;6fed
	and a			;6ff0
	ret z			;6ff1
L_6FF2:
	ld a,(0c425h)		;6ff2   ; lee la Y de Simon
	and 0f8h		;6ff5
	ld (0c425h),a		;6ff7   ; guarda la Y de Simon
	ld a,003h		;6ffa
	ld (0c423h),a		;6ffc
	ld a,(0c415h)		;6fff   ; lee la vida de Simon
	and a			;7002
	ld a,004h		;7003
	jr nz,L_7009		;7005
	ld a,010h		;7007
L_7009:
	ld (0c42ah),a		;7009
	ld de,(0c42eh)		;700c   ; lee las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	inc d			;7010
	inc e			;7011
	ld (0c42eh),de		;7012   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	ret			;7016
L_7017:
	call L_6C53		;7017
	jp L_6FD7		;701a
L_701D:
	ld a,(0c439h)		;701d
	and a			;7020
	call nz,L_6BAF		;7021
	ld hl,0c42ah		;7024
	dec (hl)			;7027
	ret nz			;7028
	xor a			;7029
	ld (0c420h),a		;702a
	ld (0c421h),a		;702d
	ld (0c423h),a		;7030
	ld (0c422h),a		;7033
	ld (0c42ah),a		;7036
	ld (0c428h),a		;7039
	ld a,(0c5ach)		;703c   ; lee el estado de la puerta de la fase
	cp 002h		;703f
	jr z,L_7053		;7041
	cp 003h		;7043
	jr z,L_7053		;7045
	cp 005h		;7047
	jr z,L_7053		;7049
	ld a,(0c42ch)		;704b   ; lee el lado al que mira Simon (0 derecha)
	xor 001h		;704e
	ld (0c42ch),a		;7050   ; guarda el lado al que mira Simon (0 derecha)
L_7053:
	ld a,(0c415h)		;7053   ; lee la vida de Simon
	and a			;7056
	ret nz			;7057
	ld hl,0c427h		;7058   ; apunta a la X de Simon
	ld a,(hl)			;705b
	cp 010h		;705c
	jr nc,L_7063		;705e
	add a,008h		;7060
	ld (hl),a			;7062
L_7063:
	xor a			;7063
	ld (0c42dh),a		;7064
	ld (0c421h),a		;7067
	inc a			;706a
	ld (0c428h),a		;706b
	ld a,006h		;706e
	ld (0c420h),a		;7070
	ld bc,00509h		;7073
	ld (0c42eh),bc		;7076   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	jp pose_segun_el_lado		;707a   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon

; ----------------------------------------------------------------------
; DATOS curva_de_caida: 22 desplazamientos por cuadro de otra curva (p01:6FD7
;   con D = 21, y p01:73E1 indexada por (ix+7))
;   0x707d..0x7093  (22 bytes)
DATA_curva_de_caida:
	defb 0fdh,0fdh,0feh,0feh,0feh,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,001h,001h,001h	; 707d  ................
	defb 001h,002h,002h,002h,003h,003h	; 708d

; ======================================================================
; CODIGO 0x7093..0x71f2  (351 bytes)
; ======================================================================


L_7093:
	ld a,(0c421h)		;7093
	ld hl,0c428h		;7096
	and a			;7099
	jr nz,L_70AF		;709a
	dec (hl)			;709c
	ret nz			;709d
	ld (hl),05ah		;709e
	ld a,001h		;70a0
	ld (0c421h),a		;70a2
	ld a,000h		;70a5
	call 0509fh		;70a7   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,089h		;70aa
	jp 0509fh		;70ac   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_70AF:
	ld hl,0c428h		;70af
	dec (hl)			;70b2
	ret nz			;70b3
	ld de,0c417h		;70b4   ; apunta a los corazones, en BCD
	ld a,(de)			;70b7
	cp 005h		;70b8
	jr c,L_70BF		;70ba
	ld a,005h		;70bc
	ld (de),a			;70be
L_70BF:
	xor a			;70bf
	ld (hl),a			;70c0
	ld (0c421h),a		;70c1
	ld (0c422h),a		;70c4
	ld (0c434h),a		;70c7
	ld (0c43ah),a		;70ca
	ld (0c43bh),a		;70cd
	ld (0c440h),a		;70d0
	ld (0d010h),a		;70d3
	ld (0d001h),a		;70d6   ; guarda la HABITACION dentro de la fase
	ld (0c413h),a		;70d9
L_70DC:
	ld a,(0c701h)		;70dc
	and 080h		;70df
	ld (0c701h),a		;70e1
	xor a			;70e4
	ld (0c416h),a		;70e5   ; guarda el arma que lleva Simon (0, ninguna)
	ld (0c431h),a		;70e8
	ld (0c432h),a		;70eb
	ld (0c441h),a		;70ee   ; guarda los usos que le quedan a lo que para golpes
	ld (0c442h),a		;70f1
	ld (0c702h),a		;70f4
	ld (0c700h),a		;70f7
	ret			;70fa
L_70FB:
	ld a,(0c42dh)		;70fb
	and a			;70fe
	ret nz			;70ff
	xor a			;7100
	ld (0c420h),a		;7101
	ld (0c43dh),a		;7104
	ld a,0ffh		;7107
	ld (0c41bh),a		;7109   ; guarda el lado por el que se sale de la habitacion
	ret			;710c
L_710D:
	call L_7116		;710d
	call L_71E0		;7110
	jp L_72B2		;7113
L_7116:
	ld a,(0c006h)		;7116
	and 010h		;7119
	jr z,L_7136		;711b
	ld hl,0c422h		;711d
	ld a,(hl)			;7120
	and a			;7121
	ret nz			;7122
	ld a,(0c416h)		;7123   ; lee el arma que lleva Simon (0, ninguna)
	ld (0c436h),a		;7126
	cp 002h		;7129
	jr c,L_7133		;712b
	call L_71BE		;712d
	ld a,b			;7130
	and a			;7131
	ret z			;7132
L_7133:
	ld (hl),001h		;7133
	ret			;7135
L_7136:
	ld a,(0c420h)		;7136
	dec a			;7139
	ret nz			;713a
	ld a,(0c701h)		;713b
	push af			;713e
	rra			;713f
	rra			;7140
	rra			;7141
	rra			;7142
	call c,L_714D		;7143
	pop af			;7146
	rla			;7147
	rla			;7148
	call c,L_715F		;7149
	ret			;714c
L_714D:
	ld a,(0c417h)		;714d   ; lee los corazones, en BCD
	cp 005h		;7150
	ret c			;7152
	ld a,(0c006h)		;7153
	rra			;7156
	rra			;7157
	rra			;7158
	jr c,L_7194		;7159
	rra			;715b
	jr c,L_71A1		;715c
	ret			;715e
L_715F:
	ld a,(0c43bh)		;715f
	and a			;7162
	ret nz			;7163
	ld a,(0c417h)		;7164   ; lee los corazones, en BCD
	cp 005h		;7167
	ret c			;7169
	ld a,(0c006h)		;716a
	rra			;716d
	rra			;716e
	ret nc			;716f
	ld a,(0c417h)		;7170   ; lee los corazones, en BCD
	sub 005h		;7173
	daa			;7175
	ld (0c417h),a		;7176   ; guarda los corazones, en BCD
	call 04566h		;7179
	ld a,(0c431h)		;717c
	and 004h		;717f
	ld a,096h		;7181
	jr nz,L_7187		;7183
	ld a,05ah		;7185
L_7187:
	ld (0c43bh),a		;7187
	ld hl,0d010h		;718a
	set 0,(hl)		;718d
	ld a,0fbh		;718f
	jp 0509fh		;7191   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7194:
	ld a,(0c461h)		;7194
	and a			;7197
	ret nz			;7198
	ld a,001h		;7199
	ld (0c468h),a		;719b
	jp L_71AA		;719e
L_71A1:
	ld a,(0c461h)		;71a1
	and a			;71a4
	ret nz			;71a5
	xor a			;71a6
	ld (0c468h),a		;71a7
L_71AA:
	call 0999fh		;71aa
	ld a,005h		;71ad
	ld (0c461h),a		;71af
	ld a,(0c417h)		;71b2   ; lee los corazones, en BCD
	sub 005h		;71b5
	daa			;71b7
	ld (0c417h),a		;71b8   ; guarda los corazones, en BCD
	jp 04566h		;71bb
L_71BE:
	ld a,(0c436h)		;71be
	cp 002h		;71c1
	ld b,002h		;71c3
	jr z,L_71C8		;71c5
	dec b			;71c7
L_71C8:
	ld ix,0c450h		;71c8
L_71CC:
	ld a,(ix+001h)		;71cc
	and a			;71cf
	jr nz,L_71D8		;71d0
	ld a,001h		;71d2
	ld (ix+000h),a		;71d4
	ret			;71d7
L_71D8:
	ld de,00010h		;71d8
	add ix,de		;71db
	djnz L_71CC		;71dd
	ret			;71df
L_71E0:
	ld a,(0c422h)		;71e0
	and a			;71e3
	ret z			;71e4
	ld a,(0c420h)		;71e5
	cp 004h		;71e8
	ret nc			;71ea
	ld a,(0c422h)		;71eb
	dec a			;71ee
	call 0406bh		;71ef   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_71F2: 4 destinos del despachador de 0x406B (call en p01:71EF):
;   0x71FA, 0x7240, 0x7250, 0x7262; lo leen p01:71EF (8 bytes)
;   0x71f2..0x71fa  (8 bytes)
DATA_tabla_71F2:
	defb 0fah,071h	; 71f2
	defb 040h,072h	; 71f4
	defb 050h,072h	; 71f6
	defb 062h,072h	; 71f8

; ======================================================================
; CODIGO 0x71fa..0x7237  (61 bytes)
; ======================================================================


L_71FA:
	ld a,(0c420h)		;71fa
	cp 003h		;71fd
	jr z,L_720C		;71ff
	cp 002h		;7201
	ld a,000h		;7203
	jr nz,L_7209		;7205
	ld a,006h		;7207
L_7209:
	ld (0c42eh),a		;7209   ; guarda la pose de arriba de Simon
L_720C:
	ld a,(0c436h)		;720c
	cp 002h		;720f
	jr nc,L_722A		;7211
	ld a,(0c436h)		;7213
	dec a			;7216
	ld a,006h		;7217
	jr nz,L_721D		;7219
	ld a,009h		;721b
L_721D:
	ld (0c42fh),a		;721d   ; guarda la pose de abajo de Simon
	call pose_segun_el_lado		;7220   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	ld a,005h		;7223
	call 0509fh		;7225   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jr $+19		;7228
L_722A:
	call 05593h		;722a
	ld a,00ch		;722d
	ld (0c42fh),a		;722f   ; guarda la pose de abajo de Simon
	call pose_segun_el_lado		;7232   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	jr $+6		;7235

; ----------------------------------------------------------------------
; DATOS xor_a_suelto: un 0xAF (`xor a`) al que no llega ningun camino: el
;   codigo de al lado entra en 0x7238, que ya es la instruccion siguiente
;   0x7237..0x7238  (1 bytes)
DATA_xor_a_suelto:
	defb 0afh	; 7237

; ======================================================================
; CODIGO 0x7238..0x72d6  (158 bytes)
; ======================================================================


L_7238:
	ld (0c429h),a		;7238
L_723B:
	ld hl,0c422h		;723b
	inc (hl)			;723e
	ret			;723f
L_7240:
	ld hl,0c42fh		;7240   ; apunta a la pose de abajo de Simon
	inc (hl)			;7243
	call L_723B		;7244
	ld a,(0c436h)		;7247
	cp 002h		;724a
	ret c			;724c
	jp 05593h		;724d
L_7250:
	ld a,(0c436h)		;7250
	cp 002h		;7253
	jr nc,L_7240		;7255
	call 0999fh		;7257
	ld hl,0c42fh		;725a   ; apunta a la pose de abajo de Simon
	inc (hl)			;725d
	ld a,004h		;725e
	jr L_7238		;7260
L_7262:
	ld a,(0c436h)		;7262
	cp 002h		;7265
	jr nc,L_7286		;7267
	ld hl,0c429h		;7269
	dec (hl)			;726c
	ret nz			;726d
L_726E:
	xor a			;726e
	ld (0c422h),a		;726f
	ld (0c429h),a		;7272
	ld a,(0c420h)		;7275
	cp 003h		;7278
	ld a,000h		;727a
	jr nz,L_7280		;727c
	ld a,002h		;727e
L_7280:
	ld (0c42fh),a		;7280   ; guarda la pose de abajo de Simon
	jp pose_segun_el_lado		;7283   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
L_7286:
	call 0999fh		;7286
	call L_726E		;7289
	ld ix,0c450h		;728c
	ld b,002h		;7290
L_7292:
	ld a,(ix+000h)		;7292
	dec a			;7295
	jr nz,L_72AA		;7296
	ld a,018h		;7298
	ld (ix+006h),a		;729a
	ld a,(0c42ch)		;729d   ; lee el lado al que mira Simon (0 derecha)
	ld (ix+008h),a		;72a0
	ld a,(0c436h)		;72a3
	ld (ix+001h),a		;72a6
	ret			;72a9
L_72AA:
	ld de,00010h		;72aa
	add ix,de		;72ad
	djnz L_7292		;72af
	ret			;72b1
L_72B2:
	ld ix,0c450h		;72b2
	call L_72BD		;72b6
	ld ix,0c460h		;72b9
L_72BD:
	ld a,(ix+001h)		;72bd
	and a			;72c0
	ret z			;72c1
	call L_72CE		;72c2
	call L_74BB		;72c5
	call L_74CE		;72c8
	jp L_7535		;72cb
L_72CE:
	ld a,(ix+001h)		;72ce
	dec a			;72d1
	dec a			;72d2
	call 0406bh		;72d3   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_72D6: 4 destinos del despachador de 0x406B (call en p01:72D3):
;   0x7436, 0x7473, 0x72DE, 0x73A4; lo leen p01:72D3 (8 bytes)
;   0x72d6..0x72de  (8 bytes)
DATA_tabla_72D6:
	defb 036h,074h	; 72d6
	defb 073h,074h	; 72d8
	defb 0deh,072h	; 72da
	defb 0a4h,073h	; 72dc

; ======================================================================
; CODIGO 0x72de..0x72ff  (33 bytes)
; ======================================================================


L_72DE:
	ld a,(0c003h)		;72de   ; lee el contador de cuadros
	ld c,a			;72e1
	rra			;72e2
	rra			;72e3
	and 003h		;72e4
	add a,a			;72e6
	add a,a			;72e7
	add a,a			;72e8
	add a,018h		;72e9
	ld (ix+006h),a		;72eb
	ld a,c			;72ee
	and 007h		;72ef
	jr nz,L_72F8		;72f1
	ld a,003h		;72f3
	call 0509fh		;72f5   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_72F8:
	ld a,(ix+000h)		;72f8
	dec a			;72fb
	call 0406bh		;72fc   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_72FF: 4 destinos del despachador de 0x406B (call en p01:72FC):
;   0x7307, 0x733D, 0x7373, 0x739D; lo leen p01:72FC (8 bytes)
;   0x72ff..0x7307  (8 bytes)
DATA_tabla_72FF:
	defb 007h,073h	; 72ff
	defb 03dh,073h	; 7301
	defb 073h,073h	; 7303
	defb 09dh,073h	; 7305

; ======================================================================
; CODIGO 0x7307..0x749d  (406 bytes)
; ======================================================================


L_7307:
	ld a,(0c420h)		;7307
	cp 002h		;730a
	ld a,(0c425h)		;730c   ; lee la Y de Simon
	ld b,0f0h		;730f
	jr nz,L_7315		;7311
	ld b,0f6h		;7313
L_7315:
	add a,b			;7315
	ld (ix+004h),a		;7316   ; guarda la fraccion de la x de la cosa
	xor a			;7319
	ld (ix+002h),a		;731a   ; guarda la fraccion de la y de la cosa
	ld a,(ix+001h)		;731d   ; lee el paso en que va la cosa
	cp 003h		;7320
	ld b,003h		;7322
	jr z,L_7328		;7324
	ld b,005h		;7326
L_7328:
	ld a,(ix+008h)		;7328   ; lee la velocidad vertical
	and a			;732b
	ld a,b			;732c
	jr z,L_7331		;732d
	neg		;732f
L_7331:
	ld (ix+003h),a		;7331   ; guarda la y de la cosa
	ld a,(0c427h)		;7334   ; lee la X de Simon
	ld (ix+005h),a		;7337   ; guarda la x de la cosa
	jp L_734F		;733a
L_733D:
	ld a,(ix+005h)		;733d   ; lee la x de la cosa
	sub 00ah		;7340
	cp 0ech		;7342
	jr nc,L_7359		;7344
	inc (ix+007h)		;7346   ; sube la velocidad vertical (parte baja)
	ld a,(ix+007h)		;7349   ; lee la velocidad vertical (parte baja)
	cp 018h		;734c
	ret c			;734e
L_734F:
	inc (ix+000h)		;734f   ; sube el tipo de la cosa
	ld (ix+007h),000h		;7352   ; la velocidad vertical (parte baja) = 0x00
	jp 0999fh		;7356
L_7359:
	inc (ix+000h)		;7359   ; sube el tipo de la cosa
L_735C:
	inc (ix+000h)		;735c   ; sube el tipo de la cosa
	ld a,(ix+008h)		;735f   ; lee la velocidad vertical
	and a			;7362
	ld a,005h		;7363
	jr nz,L_7369		;7365
	ld a,0fbh		;7367
L_7369:
	ld (ix+003h),a		;7369   ; guarda la y de la cosa
	ld (ix+007h),000h		;736c   ; la velocidad vertical (parte baja) = 0x00
	jp 0999fh		;7370
L_7373:
	call 08240h		;7373
	jp c,L_74E9		;7376
	ld a,(ix+005h)		;7379   ; lee la x de la cosa
	sub 00ah		;737c
	cp 0ech		;737e
	jr nc,L_735C		;7380
	inc (ix+007h)		;7382   ; sube la velocidad vertical (parte baja)
	ld a,(ix+007h)		;7385   ; lee la velocidad vertical (parte baja)
	cp 017h		;7388
	jp nc,L_734F		;738a
	rra			;738d
	ret nc			;738e
	ld a,(ix+008h)		;738f   ; lee la velocidad vertical
	and a			;7392
	jr nz,L_7399		;7393
	dec (ix+003h)		;7395   ; baja la y de la cosa
	ret			;7398
L_7399:
	inc (ix+003h)		;7399   ; sube la y de la cosa
	ret			;739c
L_739D:
	call 08240h		;739d
	ret nc			;73a0
	jp L_74E9		;73a1
L_73A4:
	ld a,(ix+000h)		;73a4   ; lee el tipo de la cosa
	dec a			;73a7
	dec a			;73a8
	jr z,L_73DE		;73a9
	dec a			;73ab
	jr z,L_7419		;73ac
	ld a,(0c420h)		;73ae
	cp 002h		;73b1
	ld a,(0c425h)		;73b3   ; lee la Y de Simon
	ld b,0f0h		;73b6
	jr nz,L_73BC		;73b8
	ld b,0f6h		;73ba
L_73BC:
	add a,b			;73bc
	ld (ix+004h),a		;73bd   ; guarda la fraccion de la x de la cosa
	xor a			;73c0
	ld (ix+002h),a		;73c1   ; guarda la fraccion de la y de la cosa
	ld a,(ix+008h)		;73c4   ; lee la velocidad vertical
	and a			;73c7
	ld a,002h		;73c8
	jr z,L_73CE		;73ca
	ld a,0feh		;73cc
L_73CE:
	ld (ix+003h),a		;73ce   ; guarda la y de la cosa
	ld a,(0c427h)		;73d1   ; lee la X de Simon
	ld (ix+005h),a		;73d4   ; guarda la x de la cosa
	ld (ix+006h),038h		;73d7   ; la cosa se mueve
	jp L_734F		;73db
L_73DE:
	ld a,(ix+007h)		;73de   ; lee la velocidad vertical (parte baja)
	ld hl,0707dh		;73e1
	call 04061h		;73e4   ; hl_mas_a: HL += A
	ld c,(ix+004h)		;73e7   ; lee la fraccion de la x de la cosa
	ld a,(hl)			;73ea
	add a,a			;73eb
	add a,c			;73ec
	ld (ix+004h),a		;73ed   ; guarda la fraccion de la x de la cosa
	inc (ix+007h)		;73f0   ; sube la velocidad vertical (parte baja)
	ld a,(ix+007h)		;73f3   ; lee la velocidad vertical (parte baja)
	cp 016h		;73f6
	jr c,L_73FD		;73f8
	dec (ix+007h)		;73fa   ; baja la velocidad vertical (parte baja)
L_73FD:
	ld d,(ix+005h)		;73fd   ; lee la x de la cosa
	ld e,(ix+004h)		;7400   ; lee la fraccion de la x de la cosa
	call choca_con_el_decorado		;7403   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;7406
	inc (ix+000h)		;7407   ; sube el tipo de la cosa
	xor a			;740a
	ld (ix+002h),a		;740b   ; guarda la fraccion de la y de la cosa
	ld (ix+003h),a		;740e   ; guarda la y de la cosa
	ld (ix+007h),a		;7411   ; guarda la velocidad vertical (parte baja)
	ld a,018h		;7414
	jp 0509fh		;7416   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7419:
	ld a,(0c003h)		;7419   ; lee el contador de cuadros
	and 004h		;741c
	ld a,0f4h		;741e
	jr z,L_7427		;7420
	call 0999fh		;7422
	ld a,0f8h		;7425
L_7427:
	ld (ix+006h),a		;7427   ; guarda si la cosa se mueve
	inc (ix+007h)		;742a   ; sube la velocidad vertical (parte baja)
	ld a,(ix+007h)		;742d   ; lee la velocidad vertical (parte baja)
	cp 018h		;7430
	ret c			;7432
	jp L_74E9		;7433
L_7436:
	ld a,(ix+000h)		;7436   ; lee el tipo de la cosa
	dec a			;7439
	ret nz			;743a
	ld a,(0c420h)		;743b
	cp 002h		;743e
	ld a,(0c425h)		;7440   ; lee la Y de Simon
	ld b,0f0h		;7443
	jr nz,L_7449		;7445
	ld b,0f6h		;7447
L_7449:
	add a,b			;7449
	ld (ix+004h),a		;744a   ; guarda la fraccion de la x de la cosa
	xor a			;744d
	ld (ix+002h),a		;744e   ; guarda la fraccion de la y de la cosa
	ld a,(ix+008h)		;7451   ; lee la velocidad vertical
	and a			;7454
	ld a,005h		;7455
	ld b,020h		;7457
	jr z,L_745F		;7459
	ld a,0fbh		;745b
	ld b,018h		;745d
L_745F:
	ld (ix+003h),a		;745f   ; guarda la y de la cosa
	ld (ix+006h),b		;7462   ; guarda si la cosa se mueve
	ld a,(0c427h)		;7465   ; lee la X de Simon
	ld (ix+005h),a		;7468   ; guarda la x de la cosa
	inc (ix+000h)		;746b   ; sube el tipo de la cosa
	ld a,004h		;746e
	jp 0509fh		;7470   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7473:
	ld a,(0c003h)		;7473   ; lee el contador de cuadros
	ld c,a			;7476
	rra			;7477
	and 003h		;7478
	add a,a			;747a
	add a,a			;747b
	add a,a			;747c
	add a,018h		;747d
	ld (ix+006h),a		;747f   ; guarda si la cosa se mueve
	ld a,c			;7482
	and 007h		;7483
	jr nz,L_748C		;7485
	ld a,006h		;7487
	call 0509fh		;7489   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_748C:
	ld hl,0c433h		;748c
	ld a,(hl)			;748f
	sub 002h		;7490
	cp 002h		;7492
	jr c,$+17		;7494
	ld a,(ix+000h)		;7496   ; lee el tipo de la cosa
	dec a			;7499
	call 0406bh		;749a   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_749D: 4 destinos del despachador de 0x406B (call en p01:749A):
;   0x7307, 0x733D, 0x7373, 0x739D; lo leen p01:749A (8 bytes)
;   0x749d..0x74a5  (8 bytes)
DATA_tabla_749D:
	defb 007h,073h	; 749d
	defb 03dh,073h	; 749f
	defb 073h,073h	; 74a1
	defb 09dh,073h	; 74a3

; ======================================================================
; CODIGO 0x74a5..0x771e  (633 bytes)
; ======================================================================


L_74A5:
	ld (hl),000h		;74a5
	ld b,01ch		;74a7
	ld d,(ix+005h)		;74a9   ; lee la x de la cosa
	ld a,(ix+004h)		;74ac   ; lee la fraccion de la x de la cosa
	sub 010h		;74af
	ld e,a			;74b1
	call 08992h		;74b2
	call L_74E9		;74b5
	jp 08e93h		;74b8
L_74BB:
	ld a,(ix+004h)		;74bb   ; lee la fraccion de la x de la cosa
	add a,(ix+002h)		;74be   ; le suma la fraccion de la y de la cosa
	ld (ix+004h),a		;74c1   ; guarda la fraccion de la x de la cosa
	ld a,(ix+005h)		;74c4   ; lee la x de la cosa
	add a,(ix+003h)		;74c7   ; le suma la y de la cosa
	ld (ix+005h),a		;74ca   ; guarda la x de la cosa
	ret			;74cd
L_74CE:
	ld a,(ix+004h)		;74ce   ; lee la fraccion de la x de la cosa
	sub 0d8h		;74d1
	cp 010h		;74d3
	jr c,L_74E9		;74d5
	ld a,(ix+005h)		;74d7   ; lee la x de la cosa
	sub 0fbh		;74da
	cp 00ah		;74dc
	ret nc			;74de
	ld a,(0c416h)		;74df   ; lee el arma que lleva Simon (0, ninguna)
	sub 003h		;74e2
	cp 002h		;74e4
	call c,08e93h		;74e6
L_74E9:
	push ix		;74e9
	pop hl			;74eb
L_74EC:
	push hl			;74ec
	ld (hl),000h		;74ed
	ld d,h			;74ef
	ld e,l			;74f0
	inc de			;74f1
	ld bc,0000fh		;74f2
	ldir		;74f5
	pop hl			;74f7
	ld a,l			;74f8
	cp 050h		;74f9
	ld a,0e0h		;74fb
	jr nz,L_7507		;74fd
	ld (0d618h),a		;74ff
	ld (0d61ch),a		;7502
	jr L_750D		;7505
L_7507:
	ld (0d620h),a		;7507
	ld (0d624h),a		;750a
L_750D:
	inc l			;750d
	inc l			;750e
	inc l			;750f
	inc l			;7510
	ld (hl),a			;7511
	ret			;7512
L_7513:
	ld hl,0c450h		;7513
	ld (hl),000h		;7516
	ld d,h			;7518
	ld e,l			;7519
	inc de			;751a
	ld bc,0001fh		;751b
	ldir		;751e
	ld a,0e0h		;7520
	ld (0c454h),a		;7522
	ld (0c464h),a		;7525
	ld (0d618h),a		;7528
	ld (0d61ch),a		;752b
	ld (0d620h),a		;752e
	ld (0d624h),a		;7531
	ret			;7534
L_7535:
	ld a,(ix+000h)		;7535   ; lee el tipo de la cosa
	and a			;7538
	ret z			;7539
	push ix		;753a
	pop hl			;753c
	ld a,l			;753d
	cp 050h		;753e
	ld hl,0d618h		;7540
	jr z,L_7548		;7543
	ld hl,0d620h		;7545
L_7548:
	ld a,(ix+004h)		;7548   ; lee la fraccion de la x de la cosa
	sub 010h		;754b
	ld (hl),a			;754d
	inc hl			;754e
	ld a,(ix+005h)		;754f   ; lee la x de la cosa
	sub 008h		;7552
	ld (hl),a			;7554
	inc hl			;7555
	ld a,(ix+006h)		;7556   ; lee si la cosa se mueve
	ld (hl),a			;7559
	inc hl			;755a
	inc hl			;755b
	ld a,(ix+004h)		;755c   ; lee la fraccion de la x de la cosa
	sub 010h		;755f
	ld (hl),a			;7561
	inc hl			;7562
	ld a,(ix+005h)		;7563   ; lee la x de la cosa
	sub 008h		;7566
	ld (hl),a			;7568
	inc hl			;7569
	ld a,(ix+006h)		;756a   ; lee si la cosa se mueve
	add a,004h		;756d
	ld (hl),a			;756f
	push ix		;7570
	pop hl			;7572
	ld a,l			;7573
	cp 050h		;7574
	ld hl,0d460h		;7576
	jr z,L_757E		;7579
	ld hl,0d480h		;757b
L_757E:
	ld a,(ix+001h)		;757e   ; lee el paso en que va la cosa
	cp 004h		;7581
	jr nz,L_7595		;7583
	ld a,00fh		;7585
	ld b,010h		;7587
	call L_7590		;7589
	ld a,00eh		;758c
	ld b,010h		;758e
L_7590:
	ld (hl),a			;7590
	inc hl			;7591
	djnz L_7590		;7592
	ret			;7594
L_7595:
	ld a,002h		;7595
	ld b,010h		;7597
	call L_7590		;7599
	ld a,04ch		;759c
	ld b,010h		;759e
	call L_7590		;75a0
	ld a,(ix+001h)		;75a3   ; lee el paso en que va la cosa
	cp 005h		;75a6
	ret nz			;75a8
	ld a,(ix+000h)		;75a9   ; lee el tipo de la cosa
	cp 003h		;75ac
	ret nz			;75ae
	ld hl,0d480h		;75af
	ld de,0d490h		;75b2
	ld b,010h		;75b5
L_75B7:
	ld (hl),008h		;75b7
	xor a			;75b9
	ld (de),a			;75ba
	inc hl			;75bb
	inc de			;75bc
	djnz L_75B7		;75bd
	ret			;75bf
L_75C0:
	ld hl,0c440h		;75c0
	call L_75CF		;75c3
	ld hl,0c434h		;75c6
	call L_75CF		;75c9
	ld hl,0c42dh		;75cc
L_75CF:
	ld a,(hl)			;75cf
	and a			;75d0
	ret z			;75d1
	dec (hl)			;75d2
	ret			;75d3
L_75D4:
	ld hl,0c445h		;75d4
	ld a,(hl)			;75d7
	and a			;75d8
	ret z			;75d9
	dec (hl)			;75da
	ret nz			;75db
	ld a,018h		;75dc
	ld (0c43eh),a		;75de
	ret			;75e1
L_75E2:
	ld hl,0c43ah		;75e2
	ld a,(hl)			;75e5
	and a			;75e6
	ret z			;75e7
	dec (hl)			;75e8
	ld a,(hl)			;75e9
	cp 010h		;75ea
	ret nz			;75ec
	ld a,017h		;75ed
	jp 0509fh		;75ef   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_75F2:
	ld hl,0c43bh		;75f2
	ld a,(hl)			;75f5
	and a			;75f6
	ret z			;75f7
	dec (hl)			;75f8
	ret nz			;75f9
	ld hl,0d010h		;75fa
	res 0,(hl)		;75fd
	ld a,0fch		;75ff
	jp 0509fh		;7601   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7604:
	ld hl,0c43eh		;7604
	ld a,(hl)			;7607
	and a			;7608
	ret z			;7609
	dec (hl)			;760a
	and 002h		;760b
	ld a,00eh		;760d
	jr nz,L_7612		;760f
	xor a			;7611
L_7612:
	ld (0f3ebh),a		;7612
	jp 00062h		;7615   ; BIOS CHGCLR - Changes the screen colors
L_7618:
	ld a,(0c422h)		;7618
	and a			;761b
	jr nz,L_764E		;761c
	ld a,(0c701h)		;761e
	and 030h		;7621
	ret z			;7623
	ld hl,0c42eh		;7624   ; apunta a la pose de arriba de Simon
	ld a,(hl)			;7627
	cp 014h		;7628
	jr nc,L_762F		;762a
	add a,014h		;762c
	ld (hl),a			;762e
L_762F:
	inc hl			;762f
	ld a,(hl)			;7630
	ld b,01eh		;7631
	and a			;7633
	jr z,L_764C		;7634
	inc b			;7636
	dec a			;7637
	jr z,L_764C		;7638
	inc b			;763a
	dec a			;763b
	jr z,L_764C		;763c
	ld a,(hl)			;763e
	ld b,021h		;763f
	sub 00fh		;7641
	jr z,L_764C		;7643
	inc b			;7645
	dec a			;7646
	jr z,L_764C		;7647
	inc b			;7649
	dec a			;764a
	ret nz			;764b
L_764C:
	ld (hl),b			;764c
	ret			;764d
L_764E:
	ld a,(0c420h)		;764e
	cp 003h		;7651
	ret nz			;7653
	ld hl,0c42eh		;7654   ; apunta a la pose de arriba de Simon
	ld a,(hl)			;7657
	cp 014h		;7658
	ret c			;765a
	sub 014h		;765b
	ld (hl),a			;765d
	ret			;765e
pose_segun_el_lado:
	ld a,(0c42ch)		;765f   ; lee el lado al que mira Simon (0 derecha)
	and a			;7662
	ret z			;7663
	ld hl,(0c42eh)		;7664   ; lee las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	ld a,l			;7667
	cp 00ah		;7668
	jr nc,L_766F		;766a
	add a,00ah		;766c
	ld l,a			;766e
L_766F:
	ld a,h			;766f
	cp 00fh		;7670
	jr nc,L_7677		;7672
	add a,00fh		;7674
	ld h,a			;7676
L_7677:
	ld (0c42eh),hl		;7677   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	ret			;767a
L_767B:
	ld a,(0c420h)		;767b
	cp 006h		;767e
	ret z			;7680
	ld hl,0c41bh		;7681   ; apunta a el lado por el que se sale de la habitacion
	ld de,0c425h		;7684   ; apunta a la Y de Simon
	ld bc,0c427h		;7687   ; apunta a la X de Simon
	ld a,(0c420h)		;768a
	cp 003h		;768d
	ld a,(de)			;768f
	jr nz,L_7696		;7690
	cp 030h		;7692
	jr c,L_76A4		;7694
L_7696:
	cp 0e1h		;7696
	jr nc,L_76BC		;7698
	ld a,(bc)			;769a
	cp 008h		;769b
	jr c,L_7702		;769d
	cp 0f8h		;769f
	jr nc,L_770D		;76a1
	ret			;76a3
L_76A4:
	ld a,(0c420h)		;76a4
	dec a			;76a7
	ret z			;76a8
	ld a,0e0h		;76a9
	ld (de),a			;76ab
	ld a,(0c42ch)		;76ac   ; lee el lado al que mira Simon (0 derecha)
	and a			;76af
	ld d,0f0h		;76b0
	jr z,L_76B6		;76b2
	ld d,010h		;76b4
L_76B6:
	ld a,(bc)			;76b6
	add a,d			;76b7
	ld (bc),a			;76b8
	ld (hl),001h		;76b9
	ret			;76bb
L_76BC:
	ld a,(0c41dh)		;76bc
	inc a			;76bf
	jr nz,L_76E8		;76c0
	xor a			;76c2
	ld (0c421h),a		;76c3
	ld a,006h		;76c6
	ld (0c420h),a		;76c8
	ld a,0fah		;76cb
	ld (de),a			;76cd
	ld hl,0c428h		;76ce
	ld a,01eh		;76d1
	ld (hl),a			;76d3
	ld a,(0d000h)		;76d4   ; lee la FASE (0 el patio, 1-18)
	cp 002h		;76d7
	jr z,L_76E3		;76d9
	cp 00ah		;76db
	jr z,L_76E3		;76dd
	ld a,001h		;76df
	ld (hl),a			;76e1
	ret			;76e2
L_76E3:
	ld a,009h		;76e3
	jp 0509fh		;76e5   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_76E8:
	ld a,030h		;76e8
	ld (de),a			;76ea
	ld a,(0c420h)		;76eb
	cp 003h		;76ee
	jr nz,L_76FF		;76f0
	ld a,(0c42ch)		;76f2   ; lee el lado al que mira Simon (0 derecha)
	and a			;76f5
	ld d,0f0h		;76f6
	jr z,L_76FC		;76f8
	ld d,010h		;76fa
L_76FC:
	ld a,(bc)			;76fc
	add a,d			;76fd
	ld (bc),a			;76fe
L_76FF:
	ld (hl),002h		;76ff
	ret			;7701
L_7702:
	ld a,(0c41eh)		;7702
	inc a			;7705
	ret z			;7706
	ld a,0f6h		;7707
	ld (bc),a			;7709
	ld (hl),003h		;770a
	ret			;770c
L_770D:
	ld a,(0c41fh)		;770d
	inc a			;7710
	ret z			;7711
	ld a,00ah		;7712
	ld (bc),a			;7714
	ld (hl),004h		;7715
	ret			;7717
L_7718:
	ld a,(0c5ach)		;7718   ; lee el estado de la puerta de la fase
	call 0406bh		;771b   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_771E: 6 destinos del despachador de 0x406B (call en p01:771B):
;   0x7805, 0x772A, 0x7805, 0x778A, 0x772A, 0x778A; lo leen p01:771B (12
;   bytes)
;   0x771e..0x772a  (12 bytes)
DATA_tabla_771E:
	defb 005h,078h	; 771e
	defb 02ah,077h	; 7720
	defb 005h,078h	; 7722
	defb 08ah,077h	; 7724
	defb 02ah,077h	; 7726
	defb 08ah,077h	; 7728

; ======================================================================
; CODIGO 0x772a..0x7777  (77 bytes)
; ======================================================================


L_772A:
	ld de,0c425h		;772a   ; apunta a la Y de Simon
	ld a,(de)			;772d
	ld b,a			;772e
	inc e			;772f
	inc e			;7730
	ld a,(de)			;7731
	ld c,a			;7732
	call 08580h		;7733
	ret nc			;7736
	ld hl,0c701h		;7737
	ld a,(0d000h)		;773a   ; lee la FASE (0 el patio, 1-18)
	and a			;773d
	jr z,L_7743		;773e
	ld a,(hl)			;7740
	rra			;7741
	ret nc			;7742
L_7743:
	res 0,(hl)		;7743
	call 08ebah		;7745
	xor a			;7748
	ld (0c422h),a		;7749
	call L_7806		;774c
	call L_7513		;774f
	ld hl,0c5ach		;7752   ; apunta a el estado de la puerta de la fase
	inc (hl)			;7755
	ld a,(0d000h)		;7756   ; lee la FASE (0 el patio, 1-18)
	ld de,07777h		;7759
	call 04066h		;775c   ; de_mas_a: DE += A
	ld a,(de)			;775f
	and a			;7760
	jr z,L_7768		;7761
	ld a,0ffh		;7763
	call 0509fh		;7765   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7768:
	ld a,(hl)			;7768
	cp 005h		;7769
	jr z,L_7772		;776b
	ld a,01ah		;776d
	jp 0509fh		;776f   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7772:
	ld a,015h		;7772
	jp 0509fh		;7774   ; sonido: arranca la musica o el efecto A (bit 7 = musica)

; ----------------------------------------------------------------------
; DATOS una_bandera_por_fase: 19 bytes, uno por fase, que miran p01:7759 y
;   p01:795C: 1 en las fases 3, 6, 9, 10, 12, 15, 17 y 18
;   0x7777..0x778a  (19 bytes)
DATA_una_bandera_por_fase:
	defb 000h,000h,000h,001h,000h,000h,001h,000h,000h,001h,001h,000h,001h,000h,000h,001h	; 7777  ................
	defb 000h,001h,001h	; 7787

; ======================================================================
; CODIGO 0x778a..0x7972  (488 bytes)
; ======================================================================


L_778A:
	ld a,(0c5ach)		;778a   ; lee el estado de la puerta de la fase
	cp 005h		;778d
	call z,055ech		;778f
	ld a,(0c420h)		;7792
	and a			;7795
	ret nz			;7796
	ld bc,00000h		;7797
	ld (0c42eh),bc		;779a   ; guarda las dos poses de Simon (0xC42E arriba, 0xC42F abajo)
	call pose_segun_el_lado		;779e   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	ld a,(0c42ch)		;77a1   ; lee el lado al que mira Simon (0 derecha)
	and a			;77a4
	ld bc,00080h		;77a5
	jr z,L_77AD		;77a8
	ld bc,0ff80h		;77aa
L_77AD:
	call L_6C94		;77ad
	call L_6CA4		;77b0
	ld a,(0c5ach)		;77b3   ; lee el estado de la puerta de la fase
	cp 005h		;77b6
	jr z,L_77C4		;77b8
	ld a,(0c427h)		;77ba   ; lee la X de Simon
	sub 008h		;77bd
	cp 0f0h		;77bf
	ret c			;77c1
	jr L_77D1		;77c2
L_77C4:
	ld a,(0c5aeh)		;77c4
	add a,008h		;77c7
	ld b,a			;77c9
	ld a,(0c427h)		;77ca   ; lee la X de Simon
	sub b			;77cd
	cp 008h		;77ce
	ret nc			;77d0
L_77D1:
	ld hl,0c41eh		;77d1
	ld de,0c427h		;77d4   ; apunta a la X de Simon
	ld a,(de)			;77d7
	rla			;77d8
	jr c,L_77E4		;77d9
	ld a,(hl)			;77db
	inc a			;77dc
	jr z,L_7800		;77dd
	ld bc,003f6h		;77df
	jr L_77EC		;77e2
L_77E4:
	inc hl			;77e4
	ld a,(hl)			;77e5
	inc a			;77e6
	jr z,L_7800		;77e7
	ld bc,0040ah		;77e9
L_77EC:
	ld a,b			;77ec
	ld (0c41bh),a		;77ed   ; guarda el lado por el que se sale de la habitacion
	ld a,c			;77f0
	ld (de),a			;77f1
	ld a,(0d000h)		;77f2   ; lee la FASE (0 el patio, 1-18)
	cp 012h		;77f5
	ld a,087h		;77f7
	jr nz,L_77FD		;77f9
	ld a,086h		;77fb
L_77FD:
	jp 0509fh		;77fd   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7800:
	ld a,001h		;7800
	ld (0c408h),a		;7802
L_7805:
	ret			;7805
L_7806:
	ld ix,0c800h		;7806
	ld b,007h		;780a
L_780C:
	ld a,(ix+000h)		;780c   ; lee el tipo de la cosa
	and a			;780f
	push bc			;7810
	push ix		;7811
	call nz,09a3ah		;7813
	pop ix		;7816
	pop bc			;7818
	ld de,00080h		;7819
	add ix,de		;781c
	djnz L_780C		;781e
	ld ix,0d700h		;7820
	ld b,008h		;7824
L_7826:
	ld a,(ix+000h)		;7826   ; lee el tipo de la cosa
	and a			;7829
	push bc			;782a
	call nz,09a1ah		;782b
	pop bc			;782e
	ld de,00080h		;782f
	add ix,de		;7832
	djnz L_7826		;7834
	ret			;7836
L_7837:
	call L_790C		;7837
	ld a,(0c5ach)		;783a   ; lee el estado de la puerta de la fase
	cp 005h		;783d
	jr z,L_7858		;783f
	ld de,0d610h		;7841
	ld a,(0c416h)		;7844   ; lee el arma que lleva Simon (0, ninguna)
	cp 002h		;7847
	ld b,004h		;7849
	jr c,L_784F		;784b
	ld b,002h		;784d
L_784F:
	ld a,0e0h		;784f
L_7851:
	ld (de),a			;7851
	inc de			;7852
	inc de			;7853
	inc de			;7854
	inc de			;7855
	djnz L_7851		;7856
L_7858:
	ld a,(0c42eh)		;7858   ; lee la pose de arriba de Simon
	add a,a			;785b
	ld hl,07985h		;785c
	call 04061h		;785f   ; hl_mas_a: HL += A
	ld e,(hl)			;7862
	inc hl			;7863
	ld d,(hl)			;7864
	ex de,hl			;7865
	ld c,000h		;7866
	ld a,(0c5ach)		;7868   ; lee el estado de la puerta de la fase
	cp 005h		;786b
	ld de,0d600h		;786d
	jr nz,L_7875		;7870
	ld de,0d620h		;7872
L_7875:
	ld b,(hl)			;7875
	inc hl			;7876
	call L_7899		;7877
	ld a,(0c42fh)		;787a   ; lee la pose de abajo de Simon
	add a,a			;787d
	ld hl,079d5h		;787e
	call 04061h		;7881   ; hl_mas_a: HL += A
	ld e,(hl)			;7884
	inc hl			;7885
	ld d,(hl)			;7886
	ex de,hl			;7887
	ld c,002h		;7888
	ld a,(0c5ach)		;788a   ; lee el estado de la puerta de la fase
	cp 005h		;788d
	ld de,0d608h		;788f
	jr nz,L_7897		;7892
	ld de,0d628h		;7894
L_7897:
	ld b,(hl)			;7897
	inc hl			;7898
L_7899:
	ld a,(0c425h)		;7899   ; lee la Y de Simon
	add a,(hl)			;789c
	push bc			;789d
	ld b,a			;789e
	ld a,(0c42eh)		;789f   ; lee la pose de arriba de Simon
	cp 006h		;78a2
	jr z,L_78B2		;78a4
	cp 010h		;78a6
	jr z,L_78B2		;78a8
	cp 01ah		;78aa
	jr z,L_78B2		;78ac
	cp 024h		;78ae
	jr nz,L_78CC		;78b0
L_78B2:
	ld a,(0c420h)		;78b2
	dec a			;78b5
	jr nz,L_78C3		;78b6
	ld a,c			;78b8
	cp 002h		;78b9
	jr nc,L_78CC		;78bb
	ld a,b			;78bd
	sub 006h		;78be
	ld b,a			;78c0
	jr L_78CC		;78c1
L_78C3:
	ld a,c			;78c3
	cp 002h		;78c4
	jr c,L_78CC		;78c6
	ld a,b			;78c8
	add a,006h		;78c9
	ld b,a			;78cb
L_78CC:
	ld a,(0c42dh)		;78cc
	and a			;78cf
	jr z,L_78DB		;78d0
	ld a,(0c003h)		;78d2   ; lee el contador de cuadros
	and 002h		;78d5
	jr z,L_78DB		;78d7
	ld b,0e0h		;78d9
L_78DB:
	ld a,b			;78db
	pop bc			;78dc
	sub 002h		;78dd
	ld (de),a			;78df
	inc hl			;78e0
	inc de			;78e1
	push bc			;78e2
	ld b,(hl)			;78e3
	ld a,(0c427h)		;78e4   ; lee la X de Simon
	ld c,a			;78e7
	rl b		;78e8
	jr nc,L_78F6		;78ea
	rr b		;78ec
	ld a,b			;78ee
	neg		;78ef
	ld b,a			;78f1
	ld a,c			;78f2
	sub b			;78f3
	jr L_78F7		;78f4
L_78F6:
	add a,(hl)			;78f6
L_78F7:
	jr nc,L_78FE		;78f7
	dec de			;78f9
	ld a,0e0h		;78fa
	ld (de),a			;78fc
	inc de			;78fd
L_78FE:
	ld (de),a			;78fe
	pop bc			;78ff
	inc hl			;7900
	inc de			;7901
	ld a,c			;7902
	add a,a			;7903
	add a,a			;7904
	ld (de),a			;7905
	inc c			;7906
	inc de			;7907
	inc de			;7908
	djnz L_7899		;7909
	ret			;790b
L_790C:
	ld a,(0c416h)		;790c   ; lee el arma que lleva Simon (0, ninguna)
	cp 002h		;790f
	ld b,080h		;7911
	jr c,L_7917		;7913
	ld b,040h		;7915
L_7917:
	ld a,(0c5ach)		;7917   ; lee el estado de la puerta de la fase
	cp 005h		;791a
	ld hl,0d400h		;791c
	jr nz,L_7924		;791f
	ld hl,0d480h		;7921
L_7924:
	ld a,(0c43ah)		;7924
	and a			;7927
	jr z,L_7932		;7928
	ld a,(0c003h)		;792a   ; lee el contador de cuadros
	rra			;792d
	ld a,00eh		;792e
	jr c,L_794A		;7930
L_7932:
	ld a,(0c434h)		;7932
	and a			;7935
	jr z,L_7940		;7936
	ld a,(0c003h)		;7938   ; lee el contador de cuadros
	rra			;793b
	ld a,008h		;793c
	jr c,L_794A		;793e
L_7940:
	ld a,b			;7940
	dec a			;7941
	and 010h		;7942
	ld a,001h		;7944
	jr nz,L_794A		;7946
	ld a,042h		;7948
L_794A:
	ld (hl),a			;794a
	inc hl			;794b
	djnz L_7924		;794c
	ret			;794e
L_794F:
	ld a,(0c40dh)		;794f
	and a			;7952
	jr nz,L_7965		;7953
	ld a,(0d000h)		;7955   ; lee la FASE (0 el patio, 1-18)
	and a			;7958
	jr z,L_7965		;7959
	dec a			;795b
	ld hl,07777h		;795c
	call 04061h		;795f   ; hl_mas_a: HL += A
	ld a,(hl)			;7962
	and a			;7963
	ret z			;7964
L_7965:
	ld a,(0d000h)		;7965   ; lee la FASE (0 el patio, 1-18)
	ld hl,07972h		;7968
	call 04061h		;796b   ; hl_mas_a: HL += A
	ld a,(hl)			;796e
	jp 0509fh		;796f   ; sonido: arranca la musica o el efecto A (bit 7 = musica)

; ----------------------------------------------------------------------
; DATOS musica_de_cada_fase: 19 bytes, uno por fase: la musica que suena
;   (p01:7968 lo pasa a 0x509F): 0x80 en el patio y el bloque 1, 0x81 en el 2
;   y en las fases 11-12, 0x82 en el 3, 0x84 en el 5, 0x83 en las fases 16-17
;   y 0x85 en la 10 y la 18
;   0x7972..0x7985  (19 bytes)
DATA_musica_de_cada_fase:
	defb 080h,080h,080h,080h,081h,081h,081h,082h,082h,082h,085h,081h,081h,084h,084h,084h	; 7972  ................
	defb 083h,083h,085h	; 7982

; ----------------------------------------------------------------------
; DATOS poses_de_simon_arriba: 40 punteros, uno por pose (0xC42E), a la lista
;   de sprites de la parte de arriba de Simon (p01:785C)
;   0x7985..0x79d5  (80 bytes)
DATA_poses_de_simon_arriba:
	defb 01dh,07ah,01dh,07ah,01dh,07ah,01dh,07ah,01dh,07ah,01dh,07ah,022h,07ah,027h,07ah	; 7985  .z.z.z.z.z.z"z'z
	defb 027h,07ah,02ch,07ah,031h,07ah,031h,07ah,031h,07ah,031h,07ah,031h,07ah,031h,07ah	; 7995  'z,z1z1z1z1z1z1z
	defb 036h,07ah,03bh,07ah,03bh,07ah,040h,07ah,01dh,07ah,01dh,07ah,01dh,07ah,01dh,07ah	; 79a5  6z;z;z@z.z.z.z.z
	defb 01dh,07ah,01dh,07ah,022h,07ah,027h,07ah,027h,07ah,02ch,07ah,031h,07ah,031h,07ah	; 79b5  .z.z"z'z'z,z1z1z
	defb 031h,07ah,031h,07ah,031h,07ah,031h,07ah,036h,07ah,03bh,07ah,03bh,07ah,040h,07ah	; 79c5  1z1z1z1z6z;z;z@z

; ----------------------------------------------------------------------
; DATOS poses_de_simon_abajo: 36 punteros, uno por pose (0xC42F), a la lista
;   de sprites de la parte de abajo (p01:787E)
;   0x79d5..0x7a1d  (72 bytes)
DATA_poses_de_simon_abajo:
	defb 045h,07ah,045h,07ah,045h,07ah,04fh,07ah,04fh,07ah,054h,07ah,059h,07ah,066h,07ah	; 79d5  EzEzEzOzOzTzYzfz
	defb 06fh,07ah,059h,07ah,066h,07ah,06fh,07ah,07ch,07ah,07ch,07ah,081h,07ah,08ah,07ah	; 79e5  ozYzfzoz|z|z.z.z
	defb 08ah,07ah,08ah,07ah,094h,07ah,094h,07ah,099h,07ah,09eh,07ah,0abh,07ah,0b4h,07ah	; 79f5  .z.z.z.z.z.z.z.z
	defb 09eh,07ah,0abh,07ah,0b4h,07ah,0c1h,07ah,0c1h,07ah,0c6h,07ah,045h,07ah,045h,07ah	; 7a05  .z.z.z.z.z.zEzEz
	defb 045h,07ah,08ah,07ah,08ah,07ah,08ah,07ah	; 7a15  Ez.z.z.z

; ----------------------------------------------------------------------
; DATOS sprites_de_las_poses: las listas de sprites de las poses de Simon:
;   [cuantos] y, por sprite, lo que p01:7899 suma a su posicion
;   0x7a1d..0x7acf  (178 bytes)
DATA_sprites_de_las_poses:
	defb 002h,0f2h,0f8h,0f2h,0f8h,002h,0f8h,0f8h,0f8h,0f8h,002h,0f1h,0f8h,0f1h,0f8h,002h	; 7a1d  ................
	defb 0f1h,0f0h,0f1h,0f0h,002h,0f2h,0f9h,0f2h,0f9h,002h,0f8h,0f9h,0f8h,0f9h,002h,0f1h	; 7a2d  ................
	defb 0f9h,0f1h,0f9h,002h,0f1h,001h,0f1h,001h,002h,0e2h,0f8h,0e2h,0f8h,002h,0e8h,0f8h	; 7a3d  ................
	defb 0e8h,0f8h,002h,0e1h,0f8h,0e1h,0f8h,002h,0f1h,000h,0f1h,000h,006h,0e2h,0f0h,0e2h	; 7a4d  ................
	defb 0f0h,0e2h,0e0h,0e2h,0e0h,0f2h,0e0h,0f2h,0e0h,004h,0e2h,0f0h,0e2h,0f0h,0e9h,0e0h	; 7a5d  ................
	defb 0e9h,0e0h,006h,0e2h,0f8h,0e2h,0f8h,0e2h,018h,0e2h,018h,0e2h,008h,0e2h,008h,002h	; 7a6d  ................
	defb 0e2h,0f0h,0e2h,0f0h,004h,0e2h,0f8h,0e2h,0f8h,0e2h,008h,0e2h,008h,002h,0e2h,0f9h	; 7a7d  ................
	defb 0e2h,0f9h,002h,0e8h,0f9h,0e8h,0f9h,002h,0e1h,0f9h,0e1h,0f9h,002h,0f1h,0f1h,0f1h	; 7a8d  ................
	defb 0f1h,006h,0e2h,001h,0e2h,001h,0e2h,011h,0e2h,011h,0f2h,011h,0f2h,011h,004h,0e2h	; 7a9d  ................
	defb 001h,0e2h,001h,0e9h,011h,0e9h,011h,006h,0e2h,0f9h,0e2h,0f9h,0e2h,0d9h,0e2h,0d9h	; 7aad  ................
	defb 0e2h,0e9h,0e2h,0e9h,002h,0e2h,001h,0e2h,001h,004h,0e2h,0f9h,0e2h,0f9h,0e2h,0e9h	; 7abd  ................
	defb 0e2h,0e9h	; 7acd

; ======================================================================
; CODIGO 0x7acf..0x7b52  (131 bytes)
; ======================================================================


L_7ACF:
	ld e,010h		;7acf
L_7AD1:
	ld a,002h		;7ad1
	ld d,000h		;7ad3
	ld bc,00709h		;7ad5
	push hl			;7ad8
	push de			;7ad9
	call 0490ah		;7ada   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	pop de			;7add
	pop hl			;7ade
	ld a,010h		;7adf
	add a,h			;7ae1
	ld h,a			;7ae2
	dec e			;7ae3
	jr nz,L_7AD1		;7ae4
	ret			;7ae6
L_7AE7:
	ld a,002h		;7ae7
	ld de,01101h		;7ae9
	jp 04814h		;7aec   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
L_7AEF:
	ld de,0d600h		;7aef
	ld hl,07b52h		;7af2
	ld b,00bh		;7af5
	ld a,0fch		;7af7
L_7AF9:
	push bc			;7af9
	ld b,002h		;7afa
L_7AFC:
	push bc			;7afc
	ld bc,00002h		;7afd
	ldir		;7b00
	pop bc			;7b02
	dec hl			;7b03
	dec hl			;7b04
	add a,004h		;7b05
	ld (de),a			;7b07
	inc de			;7b08
	inc de			;7b09
	djnz L_7AFC		;7b0a
	inc hl			;7b0c
	inc hl			;7b0d
	pop bc			;7b0e
	djnz L_7AF9		;7b0f
	ld hl,0d400h		;7b11
	ld c,00bh		;7b14
L_7B16:
	ld b,010h		;7b16
L_7B18:
	ld (hl),008h		;7b18
	inc hl			;7b1a
	djnz L_7B18		;7b1b
	ld b,010h		;7b1d
L_7B1F:
	ld (hl),002h		;7b1f
	inc hl			;7b21
	djnz L_7B1F		;7b22
	dec c			;7b24
	jr nz,L_7B16		;7b25
	ld a,002h		;7b27
	ld de,00000h		;7b29
	call 04814h		;7b2c   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
	jp L_65A4		;7b2f
rotulo_por_filas:
	push de			;7b32
L_7B33:
	ld a,(hl)			;7b33
	inc hl			;7b34
	ld c,a			;7b35
	inc a			;7b36
	jr z,L_7B50		;7b37
	inc a			;7b39
	jr nz,L_7B47		;7b3a
	pop de			;7b3c
	ld a,(hl)			;7b3d
	inc hl			;7b3e
	add a,d			;7b3f
	ld d,a			;7b40
	ld a,008h		;7b41
	add a,e			;7b43
	ld e,a			;7b44
	jr rotulo_por_filas		;7b45
L_7B47:
	ld a,c			;7b47
	call 04b1dh		;7b48
	call 04b4fh		;7b4b
	jr L_7B33		;7b4e
L_7B50:
	pop de			;7b50
	ret			;7b51

; ----------------------------------------------------------------------
; DATOS once_pares: once pares que p01:7AF2 copia a la tabla de atributos de
;   sprites de 0xD600, con el patron subiendo de 4 en 4 desde 0xFC
;   0x7b52..0x7b68  (22 bytes)
DATA_once_pares:
	defb 027h,038h,027h,04ch,027h,060h,03fh,030h,03fh,040h,04fh,030h,04fh,040h,03fh,070h	; 7b52  '8'L'`?0?@O0O@?p
	defb 03fh,080h,04fh,070h,04fh,080h	; 7b62

; ======================================================================
; CODIGO 0x7b68..0x7c78  (272 bytes)
; ======================================================================


L_7B68:
	ld a,(0c425h)		;7b68   ; lee la Y de Simon
	add a,007h		;7b6b
	ld e,a			;7b6d
	ld a,(0c427h)		;7b6e   ; lee la X de Simon
	ld d,a			;7b71
	call celda_del_mapa		;7b72   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	jp es_pared		;7b75   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
L_7B78:
	ld a,(0c425h)		;7b78   ; lee la Y de Simon
	sub 02ch		;7b7b
	ld e,a			;7b7d
	ld a,(0c427h)		;7b7e   ; lee la X de Simon
	ld d,a			;7b81
	call celda_del_mapa		;7b82   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	jp es_pared		;7b85   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
mira_el_suelo:
	ld a,(0c425h)		;7b88   ; lee la Y de Simon
	ld e,a			;7b8b
	cp 0d0h		;7b8c
	jr c,L_7B92		;7b8e
	or a			;7b90
	ret			;7b91
L_7B92:
	ld a,(0c427h)		;7b92   ; lee la X de Simon
	add a,005h		;7b95
	ld d,a			;7b97
choca_con_el_decorado:
	call celda_del_mapa		;7b98   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7b9b   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7b9e
	ld a,d			;7b9f
	sub 00ah		;7ba0
	ld d,a			;7ba2
L_7BA3:
	call celda_del_mapa		;7ba3   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	jp es_pared		;7ba6   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
L_7BA9:
	ld a,(0c425h)		;7ba9   ; lee la Y de Simon
	ld e,a			;7bac
	ld a,(0c427h)		;7bad   ; lee la X de Simon
	ld d,a			;7bb0
	ld bc,00802h		;7bb1
	xor a			;7bb4
	jr L_7BC0		;7bb5
L_7BB7:
	ld bc,01004h		;7bb7
	ld a,002h		;7bba
	jr L_7BC0		;7bbc
L_7BBE:
	ld a,001h		;7bbe
L_7BC0:
	ld (0cff0h),a		;7bc0   ; guarda el tipo de la cosa que se crea
	ld a,e			;7bc3
	sub c			;7bc4
	ld e,a			;7bc5
	ld a,d			;7bc6
	add a,b			;7bc7
	ld d,a			;7bc8
	call celda_del_mapa		;7bc9   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7bcc   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7bcf
	ld a,e			;7bd0
	sub 008h		;7bd1
	ld e,a			;7bd3
	call celda_del_mapa		;7bd4   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7bd7   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7bda
	ld a,(0cff0h)		;7bdb   ; lee el tipo de la cosa que se crea
	cp 002h		;7bde
	ret z			;7be0
	ld a,e			;7be1
	sub 008h		;7be2
	ld e,a			;7be4
	call celda_del_mapa		;7be5   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7be8   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7beb
	ld a,(0cff0h)		;7bec   ; lee el tipo de la cosa que se crea
	and a			;7bef
	jr nz,L_7BFB		;7bf0
	ld a,(0c420h)		;7bf2
	cp 002h		;7bf5
	jr nz,L_7BFB		;7bf7
	xor a			;7bf9
	ret			;7bfa
L_7BFB:
	ld a,e			;7bfb
	sub 008h		;7bfc
	ld e,a			;7bfe
	call celda_del_mapa		;7bff   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	jp es_pared		;7c02   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
L_7C05:
	ld a,(0c425h)		;7c05   ; lee la Y de Simon
	ld e,a			;7c08
	ld a,(0c427h)		;7c09   ; lee la X de Simon
	ld d,a			;7c0c
	ld bc,00802h		;7c0d
	xor a			;7c10
	jr L_7C1C		;7c11
L_7C13:
	ld bc,01004h		;7c13
	ld a,002h		;7c16
	jr L_7C1C		;7c18
L_7C1A:
	ld a,001h		;7c1a
L_7C1C:
	ld (0cff0h),a		;7c1c   ; guarda el tipo de la cosa que se crea
	ld a,e			;7c1f
	sub c			;7c20
	ld e,a			;7c21
	ld a,d			;7c22
	sub b			;7c23
	ld d,a			;7c24
	call celda_del_mapa		;7c25   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7c28   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7c2b
	ld a,e			;7c2c
	sub 008h		;7c2d
	ld e,a			;7c2f
	call celda_del_mapa		;7c30   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7c33   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7c36
	ld a,(0cff0h)		;7c37   ; lee el tipo de la cosa que se crea
	cp 002h		;7c3a
	ret z			;7c3c
	ld a,e			;7c3d
	sub 008h		;7c3e
	ld e,a			;7c40
	call celda_del_mapa		;7c41   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7c44   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7c47
	ld a,(0cff0h)		;7c48   ; lee el tipo de la cosa que se crea
	and a			;7c4b
	jr nz,L_7C57		;7c4c
	ld a,(0c420h)		;7c4e
	cp 002h		;7c51
	jr nz,L_7C57		;7c53
	xor a			;7c55
	ret			;7c56
L_7C57:
	ld a,e			;7c57
	sub 008h		;7c58
	ld e,a			;7c5a
	call celda_del_mapa		;7c5b   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
es_pared:
	ld c,a			;7c5e
	ld a,(0ce00h)		;7c5f
	cp 006h		;7c62
	jr z,L_7C73		;7c64
	ld a,(0d000h)		;7c66   ; lee la FASE (0 el patio, 1-18)
	ld hl,07c78h		;7c69
	call 04061h		;7c6c   ; hl_mas_a: HL += A
	ld a,c			;7c6f
	dec a			;7c70
	cp (hl)			;7c71
	ret			;7c72
L_7C73:
	ld a,c			;7c73
	dec a			;7c74
	cp 006h		;7c75
	ret			;7c77

; ----------------------------------------------------------------------
; DATOS un_valor_por_fase: 19 bytes, uno por fase, que lee p01:7C69 (2 en el
;   patio, 4 casi siempre, 9 en las fases 10-12 y 16-17, 8 en la 18)
;   0x7c78..0x7c8b  (19 bytes)
DATA_un_valor_por_fase:
	defb 002h,004h,004h,004h,004h,004h,004h,004h,004h,004h,009h,009h,009h,004h,004h,004h	; 7c78  ................
	defb 009h,009h,008h	; 7c88

; ======================================================================
; CODIGO 0x7c8b..0x7e59  (462 bytes)
; ======================================================================


L_7C8B:
	ld a,(0ce00h)		;7c8b
	cp 006h		;7c8e
	jr nz,L_7C94		;7c90
	and a			;7c92
	ret			;7c93
L_7C94:
	ld bc,0c425h		;7c94   ; apunta a la Y de Simon
	ld a,(bc)			;7c97
	ld e,a			;7c98
	inc c			;7c99
	inc c			;7c9a
	ld a,(bc)			;7c9b
	ld d,a			;7c9c
	call celda_del_mapa		;7c9d   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 004h		;7ca0
	ret z			;7ca2
	ld a,(bc)			;7ca3
	add a,008h		;7ca4
	ld d,a			;7ca6
	call celda_del_mapa		;7ca7   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 004h		;7caa
	ret nz			;7cac
	ld a,(bc)			;7cad
	add a,008h		;7cae
	ld (bc),a			;7cb0
	xor a			;7cb1
	ret			;7cb2
L_7CB3:
	ld a,(0ce00h)		;7cb3
	cp 006h		;7cb6
	jr nz,L_7CBC		;7cb8
	and a			;7cba
	ret			;7cbb
L_7CBC:
	ld bc,0c425h		;7cbc   ; apunta a la Y de Simon
	ld a,(bc)			;7cbf
	ld e,a			;7cc0
	inc c			;7cc1
	inc c			;7cc2
	ld a,(bc)			;7cc3
	ld d,a			;7cc4
	call celda_del_mapa		;7cc5   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 003h		;7cc8
	ret z			;7cca
	ld a,(bc)			;7ccb
	sub 008h		;7ccc
	ld d,a			;7cce
	call celda_del_mapa		;7ccf   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 003h		;7cd2
	ret nz			;7cd4
	ld a,(bc)			;7cd5
	sub 008h		;7cd6
	ld (bc),a			;7cd8
	xor a			;7cd9
	ret			;7cda
L_7CDB:
	ld a,(0ce00h)		;7cdb
	cp 006h		;7cde
	jr nz,L_7CE4		;7ce0
	and a			;7ce2
	ret			;7ce3
L_7CE4:
	ld bc,0c425h		;7ce4   ; apunta a la Y de Simon
	ld a,(bc)			;7ce7
	sub 008h		;7ce8
	ld e,a			;7cea
	inc c			;7ceb
	inc c			;7cec
	ld a,(bc)			;7ced
	sub 008h		;7cee
	ld d,a			;7cf0
	call celda_del_mapa		;7cf1   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 00dh		;7cf4
	ret z			;7cf6
	ld a,(bc)			;7cf7
	ld d,a			;7cf8
	call celda_del_mapa		;7cf9   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 00dh		;7cfc
	ret nz			;7cfe
	ld a,(bc)			;7cff
	add a,008h		;7d00
	ld (bc),a			;7d02
	xor a			;7d03
	ret			;7d04
L_7D05:
	ld a,(0ce00h)		;7d05
	cp 006h		;7d08
	jr nz,L_7D0E		;7d0a
	and a			;7d0c
	ret			;7d0d
L_7D0E:
	ld bc,0c425h		;7d0e   ; apunta a la Y de Simon
	ld a,(bc)			;7d11
	sub 008h		;7d12
	ld e,a			;7d14
	inc c			;7d15
	inc c			;7d16
	ld a,(bc)			;7d17
	add a,008h		;7d18
	ld d,a			;7d1a
	call celda_del_mapa		;7d1b   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 00ch		;7d1e
	ret z			;7d20
	ld a,(bc)			;7d21
	ld d,a			;7d22
	call celda_del_mapa		;7d23   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 00ch		;7d26
	ret nz			;7d28
	ld a,(bc)			;7d29
	sub 008h		;7d2a
	ld (bc),a			;7d2c
	xor a			;7d2d
	ret			;7d2e
celda_del_mapa:
	ld a,e			;7d2f
	sub 010h		;7d30
	and 0f8h		;7d32
	rrca			;7d34
	rrca			;7d35
	rrca			;7d36
	add a,a			;7d37
	add a,a			;7d38
	add a,a			;7d39
	ld h,000h		;7d3a
	ld l,a			;7d3c
	add hl,hl			;7d3d
	add hl,hl			;7d3e
	ld a,d			;7d3f
	and 0f8h		;7d40
	rrca			;7d42
	rrca			;7d43
	rrca			;7d44
	call 04061h		;7d45   ; hl_mas_a: HL += A
	push de			;7d48
	ld de,0d100h		;7d49
	add hl,de			;7d4c
	ld a,(hl)			;7d4d
	ld e,a			;7d4e
	ld a,h			;7d4f
	cp 0d4h		;7d50
	ld a,000h		;7d52
	jr nc,L_7D57		;7d54
	ld a,e			;7d56
L_7D57:
	ld e,a			;7d57
	ld a,h			;7d58
	ld a,0d4h		;7d59
	inc a			;7d5b
	cp h			;7d5c
	jr nc,L_7D65		;7d5d
	cp 000h		;7d5f
	ld a,000h		;7d61
	jr c,L_7D66		;7d63
L_7D65:
	ld a,e			;7d65
L_7D66:
	pop de			;7d66
	ret			;7d67
L_7D68:
	ld a,(0c41bh)		;7d68   ; lee el lado por el que se sale de la habitacion
	and a			;7d6b
	ret nz			;7d6c
	call L_7E67		;7d6d
	call L_7EE4		;7d70
	call L_7FE2		;7d73
	call 085a6h		;7d76
	ld a,(0c416h)		;7d79   ; lee el arma que lleva Simon (0, ninguna)
	cp 002h		;7d7c
	jr nc,L_7D8B		;7d7e
	call L_7DAD		;7d80
	call L_7F49		;7d83
	call L_7FB7		;7d86
	jr L_7D8E		;7d89
L_7D8B:
	call L_7DA0		;7d8b
L_7D8E:
	call 0801eh		;7d8e
	call L_7F79		;7d91
	call 080a6h		;7d94
	call 080dch		;7d97
	call 0811bh		;7d9a
	jp 08610h		;7d9d
L_7DA0:
	ld b,064h		;7da0
L_7DA2:
	push bc			;7da2
	ld b,004h		;7da3
L_7DA5:
	push bc			;7da5
	pop bc			;7da6
	djnz L_7DA5		;7da7
	pop bc			;7da9
	djnz L_7DA2		;7daa
	ret			;7dac
L_7DAD:
	ld a,(0c422h)		;7dad
	cp 003h		;7db0
	ret nz			;7db2
	ld ix,0c800h		;7db3
	ld b,007h		;7db7
L_7DB9:
	ld a,(ix+000h)		;7db9   ; lee el tipo de la cosa
	and a			;7dbc
	jr z,L_7DCC		;7dbd
	ld a,(ix+00eh)		;7dbf
	rra			;7dc2
	jr nc,L_7DCC		;7dc3
	push bc			;7dc5
	call 0827ch		;7dc6
	pop bc			;7dc9
	jr c,L_7DD4		;7dca
L_7DCC:
	ld de,00080h		;7dcc
	add ix,de		;7dcf
	djnz L_7DB9		;7dd1
	ret			;7dd3
L_7DD4:
	ld a,00ch		;7dd4
	call 0509fh		;7dd6   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	res 0,(ix+00eh)		;7dd9
	ld a,(ix+000h)		;7ddd   ; lee el tipo de la cosa
	sub 011h		;7de0
	cp 007h		;7de2
	jr c,L_7DFF		;7de4
L_7DE6:
	ld a,(0c416h)		;7de6   ; lee el arma que lleva Simon (0, ninguna)
	and a			;7de9
	jr z,L_7DEF		;7dea
	dec (ix+00dh)		;7dec   ; baja la vida de la cosa
L_7DEF:
	dec (ix+00dh)		;7def   ; baja la vida de la cosa
	jr z,L_7DF9		;7df2
	ld a,(ix+00dh)		;7df4   ; lee la vida de la cosa
	rla			;7df7
	ret nc			;7df8
L_7DF9:
	call 081abh		;7df9
	jp 09a3eh		;7dfc
L_7DFF:
	ld a,(ix+000h)		;7dff   ; lee el tipo de la cosa
	cp 012h		;7e02
	jr nz,L_7E0C		;7e04
	ld a,(0ce00h)		;7e06
	and a			;7e09
	jr z,L_7DE6		;7e0a
L_7E0C:
	call L_7E2C		;7e0c
	ld a,(0c418h)		;7e0f   ; lee la vida del enemigo (barra ENEMY)
	and a			;7e12
	jr z,L_7E17		;7e13
	rla			;7e15
	ret nc			;7e16
L_7E17:
	ld a,014h		;7e17
	ld (0c445h),a		;7e19
	ld a,01ch		;7e1c
	call 0509fh		;7e1e   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	call 081abh		;7e21
	ld a,001h		;7e24
	ld (0ce15h),a		;7e26
	jp L_7806		;7e29
L_7E2C:
	ld hl,07e59h		;7e2c
	ld a,(0c416h)		;7e2f   ; lee el arma que lleva Simon (0, ninguna)
	and a			;7e32
	jr z,L_7E3C		;7e33
	cp 002h		;7e35
	jr z,L_7E3C		;7e37
	ld hl,07e60h		;7e39
L_7E3C:
	ld a,(ix+000h)		;7e3c   ; lee el tipo de la cosa
	ld c,a			;7e3f
	sub 011h		;7e40
	call 04061h		;7e42   ; hl_mas_a: HL += A
	ld b,(hl)			;7e45
	ld a,c			;7e46
	cp 017h		;7e47
	jr nz,L_7E56		;7e49
	ld a,(0c416h)		;7e4b   ; lee el arma que lleva Simon (0, ninguna)
	cp 002h		;7e4e
	jr c,L_7E56		;7e50
	srl b		;7e52
	srl b		;7e54
L_7E56:
	jp 0463ch		;7e56

; ----------------------------------------------------------------------
; DATOS dos_tablas_de_siete: dos tablas de siete bytes que p01:7E2C (o 7E39,
;   segun 0xC416) indexa con el tipo de (ix+0) menos 0x11
;   0x7e59..0x7e67  (14 bytes)
DATA_dos_tablas_de_siete:
	defb 004h,008h,008h,004h,004h,004h,010h,006h,00ch,00ch,006h,006h,006h,018h	; 7e59  ..............

; ======================================================================
; CODIGO 0x7e67..0x7ffe  (407 bytes)
; ======================================================================


L_7E67:
	ld a,(0c434h)		;7e67
	and a			;7e6a
	jr nz,L_7E7D		;7e6b
	ld a,(0c42dh)		;7e6d
	and a			;7e70
	ret nz			;7e71
	ld a,(0c43ah)		;7e72
	and a			;7e75
	ret nz			;7e76
	ld a,(0c420h)		;7e77
	cp 005h		;7e7a
	ret nc			;7e7c
L_7E7D:
	ld ix,0c800h		;7e7d
	ld b,007h		;7e81
L_7E83:
	ld a,(ix+000h)		;7e83   ; lee el tipo de la cosa
	and a			;7e86
	jr z,L_7EDC		;7e87
	ld a,(ix+00eh)		;7e89
	rra			;7e8c
	rra			;7e8d
	jr nc,L_7EDC		;7e8e
	push bc			;7e90
	call 08290h		;7e91
	pop bc			;7e94
	jr nc,L_7EDC		;7e95
	ld a,(ix+000h)		;7e97   ; lee el tipo de la cosa
	cp 024h		;7e9a
	jp z,09a3eh		;7e9c
	cp 026h		;7e9f
	jp z,09a3eh		;7ea1
	cp 022h		;7ea4
	jr nz,L_7EB0		;7ea6
	ld a,001h		;7ea8
	ld (0ce11h),a		;7eaa
	jp 09a3eh		;7ead
L_7EB0:
	ld a,(0c434h)		;7eb0
	and a			;7eb3
	jr z,L_7EC1		;7eb4
	call 081abh		;7eb6
	call 09a3eh		;7eb9
	ld a,00dh		;7ebc
	jp 0509fh		;7ebe   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7EC1:
	ld a,005h		;7ec1
	ld (0c420h),a		;7ec3
	xor a			;7ec6
	ld (0c423h),a		;7ec7
	ld (0c422h),a		;7eca
	ld a,(ix+00ah)		;7ecd   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	rla			;7ed0
	ld a,001h		;7ed1
	jr nc,L_7ED6		;7ed3
	xor a			;7ed5
L_7ED6:
	ld (0c43ch),a		;7ed6
	jp 0816ch		;7ed9
L_7EDC:
	ld de,00080h		;7edc
	add ix,de		;7edf
	djnz L_7E83		;7ee1
	ret			;7ee3
L_7EE4:
	ld a,(0c434h)		;7ee4
	and a			;7ee7
	jr nz,L_7EFA		;7ee8
	ld a,(0c42dh)		;7eea
	and a			;7eed
	ret nz			;7eee
	ld a,(0c43ah)		;7eef
	and a			;7ef2
	ret nz			;7ef3
	ld a,(0c420h)		;7ef4
	cp 005h		;7ef7
	ret nc			;7ef9
L_7EFA:
	ld ix,0d700h		;7efa
	ld b,008h		;7efe
L_7F00:
	push bc			;7f00
	ld a,(ix+000h)		;7f01   ; lee el tipo de la cosa
	and a			;7f04
	jr z,L_7F40		;7f05
	cp 00ch		;7f07
	jr z,L_7F40		;7f09
	call 0824ch		;7f0b
	jr nc,L_7F40		;7f0e
	call 099f6h		;7f10   ; borra_la_cosa: tipo a cero y sus sprites libres
	pop bc			;7f13
	ld a,(0c434h)		;7f14
	and a			;7f17
	jp nz,0822ah		;7f18
	ld a,005h		;7f1b
	ld (0c420h),a		;7f1d
	xor a			;7f20
	ld (0c423h),a		;7f21
	ld (0c422h),a		;7f24
	ld a,(ix+00ah)		;7f27   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	rla			;7f2a
	ld a,001h		;7f2b
	jr nc,L_7F30		;7f2d
	xor a			;7f2f
L_7F30:
	ld (0c43ch),a		;7f30
	ld a,(ix+000h)		;7f33   ; lee el tipo de la cosa
	cp 009h		;7f36
	ld b,001h		;7f38
	jr nz,L_7F3D		;7f3a
	inc b			;7f3c
L_7F3D:
	jp 0462bh		;7f3d
L_7F40:
	pop bc			;7f40
	ld de,00080h		;7f41
	add ix,de		;7f44
	djnz L_7F00		;7f46
	ret			;7f48
L_7F49:
	ld a,(0c422h)		;7f49
	cp 003h		;7f4c
	ret nz			;7f4e
	ld ix,0d700h		;7f4f
	ld b,008h		;7f53
L_7F55:
	push bc			;7f55
	ld a,(ix+000h)		;7f56   ; lee el tipo de la cosa
	and a			;7f59
	jr z,L_7F70		;7f5a
	cp 00ch		;7f5c
	jr z,L_7F70		;7f5e
	call 08270h		;7f60
	jr nc,L_7F70		;7f63
	ld a,00ch		;7f65
	call 0509fh		;7f67   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	call 0822ah		;7f6a
	call 09a1ah		;7f6d
L_7F70:
	pop bc			;7f70
	ld de,00080h		;7f71
	add ix,de		;7f74
	djnz L_7F55		;7f76
	ret			;7f78
L_7F79:
	ld a,(0c450h)		;7f79
	ld b,a			;7f7c
	ld a,(0c460h)		;7f7d
	or b			;7f80
	ret z			;7f81
	ld ix,0d700h		;7f82
	ld b,008h		;7f86
L_7F88:
	ld a,(ix+000h)		;7f88   ; lee el tipo de la cosa
	and a			;7f8b
	jr z,L_7FAF		;7f8c
	cp 00ch		;7f8e
	jr z,L_7FAF		;7f90
	push bc			;7f92
	call 08258h		;7f93
	pop bc			;7f96
	jr nc,L_7FAF		;7f97
	ld a,00ch		;7f99
	call 0509fh		;7f9b   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,(iy+001h)		;7f9e
	cp 002h		;7fa1
	push iy		;7fa3
	pop hl			;7fa5
	call z,L_74EC		;7fa6
	call 0822ah		;7fa9
	jp 09a1ah		;7fac
L_7FAF:
	ld de,00080h		;7faf
	add ix,de		;7fb2
	djnz L_7F88		;7fb4
	ret			;7fb6
L_7FB7:
	ld a,(0c422h)		;7fb7
	cp 003h		;7fba
	ret nz			;7fbc
	ld hl,0c470h		;7fbd   ; apunta a los bloques que se rompen (ocho de 16 bytes)
	ld b,008h		;7fc0
L_7FC2:
	ld a,(hl)			;7fc2
	and a			;7fc3
	jr z,L_7FDB		;7fc4
	push hl			;7fc6
	push bc			;7fc7
	call 08450h		;7fc8
	pop bc			;7fcb
	pop hl			;7fcc
	jr nc,L_7FDB		;7fcd
	inc l			;7fcf
	inc l			;7fd0
	inc l			;7fd1
	inc (hl)			;7fd2
	dec l			;7fd3
	dec l			;7fd4
	dec l			;7fd5
	ld a,00ch		;7fd6
	call 0509fh		;7fd8   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_7FDB:
	ld a,010h		;7fdb
	add a,l			;7fdd
	ld l,a			;7fde
	djnz L_7FC2		;7fdf
	ret			;7fe1
L_7FE2:
	ld a,(0c422h)		;7fe2
	and a			;7fe5
	ret nz			;7fe6
	ld hl,0c500h		;7fe7
	ld b,008h		;7fea
L_7FEC:
	push bc			;7fec
	push hl			;7fed
	ld a,(hl)			;7fee
	rla			;7fef
	jr nc,$+37		;7ff0
	push hl			;7ff2
	call 08230h		;7ff3
	pop hl			;7ff6
	jr nc,$+30		;7ff7
	inc l			;7ff9
	inc l			;7ffa
	inc l			;7ffb
	inc (hl)			;7ffc
	xor a			;7ffd

; ----------------------------------------------------------------------
; DATOS medio_ld: los dos primeros bytes de `ld (0xC433),a` (32 33), partido
;   entre el banco 1 y el 2: el 0xC4 es el primer byte del banco 2, que va
;   detras en 0x8000. Un listado por banco no puede escribir una instruccion a
;   caballo (tools/bancos.py, `partidas`)
;   0x7ffe..0x8000  (2 bytes)
DATA_medio_ld:
	defb 032h,033h	; 7ffe
