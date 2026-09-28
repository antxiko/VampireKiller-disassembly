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
colorea_los_sprites:
	ld a,(ix+020h)		;6029   ; lee cuantos sprites lleva la cosa
	and a			;602c   ; sin sprites
	ret z			;602d   ; nada que colorear
	ld a,(ix+000h)		;602e   ; lee el tipo de la cosa
	call palabra_de_la_tabla		;6031   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld hl,(0cff3h)		;6034   ; lee la ficha de la cosa que se crea
	set 5,l		;6037   ; los sprites de la ficha, desde +0x20
	ld b,(hl)			;6039   ; cuantos
	ld a,005h		;603a   ; el color va 5 mas alla
	add a,l			;603c
	ld l,a			;603d
L_603E:
	ld a,(de)			;603e   ; el color del sprite
	inc de			;603f
	ld (hl),a			;6040
	ld a,l			;6041
	add a,005h		;6042   ; el siguiente sprite, 5 bytes mas alla
	ld l,a			;6044
	djnz L_603E		;6045   ; uno por sprite
	ret			;6047
apunta_el_sprite:
	push hl			;6048   ; apunta el hueco de sprite D en el sprite E de la ficha
	ld hl,(0cff3h)		;6049   ; lee la ficha de la cosa que se crea
	ld a,e			;604c   ; E * 5...
	add a,a			;604d
	add a,a			;604e
	add a,e			;604f
	add a,021h		;6050   ; ... + 0x21
	call 04061h		;6052   ; hl_mas_a: HL += A
	ld (hl),d			;6055   ; el hueco
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


las_cosas_del_bloque:
	di			;6154   ; LAS COSAS DE LAS HABITACIONES del bloque, con el banco 14
	ld a,00eh		;6155   ; el banco 14
	ld (08000h),a		;6157   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;615a   ; guarda la copia del banco de 0x8000
	ei			;615d
	call listas_en_blanco		;615e   ; las tres listas, en blanco
	call listas_del_bloque		;6161   ; las del bloque de 0xD002
	ld de,0db00h		;6164   ; la de la primera fase del bloque
	call copia_una_lista		;6167
	ld de,0dc00h		;616a   ; la de la segunda
	call copia_una_lista		;616d
	ld de,0dd00h		;6170   ; la de la tercera
	call copia_una_lista		;6173
	di			;6176   ; vuelve el banco 2
	ld a,002h		;6177
	ld (08000h),a		;6179   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;617c   ; guarda la copia del banco de 0x8000
	ei			;617f
	ret			;6180
copia_una_lista:
	ld (0cff0h),de		;6181   ; el principio de la habitacion (0xCFF0 de temporal)
un_tipo_de_la_lista:
	ld a,(hl)			;6185   ; el tipo
	inc hl			;6186
	inc a			;6187   ; 0xFF: acabo la lista
	ret z			;6188
	dec a			;6189
	jr z,lista_habitacion_siguiente		;618a   ; 0x00: la habitacion siguiente
	ld (de),a			;618c   ; el tipo
	inc de			;618d
	ldi		;618e   ; y la posicion
	inc de			;6190   ; salta los otros dos bytes
	inc de			;6191
	jr un_tipo_de_la_lista		;6192
lista_habitacion_siguiente:
	ld de,(0cff0h)		;6194   ; la habitacion siguiente...
	ld a,e			;6198
	add a,010h		;6199   ; ... 16 bytes mas alla
	ld e,a			;619b
	jr copia_una_lista		;619c
listas_del_bloque:
	ld a,(0d002h)		;619e   ; el bloque
	ld de,08668h		;61a1   ; la tabla de las tres listas de cada bloque
	call palabra_de_la_tabla		;61a4   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ex de,hl			;61a7   ; HL = sus listas
	ret			;61a8
listas_en_blanco:
	ld hl,0db00h		;61a9   ; las tres listas en blanco: 0xC0 cosas
	ld c,001h		;61ac   ; numeradas desde 1
	ld b,0c0h		;61ae
L_61B0:
	ld (hl),000h		;61b0   ; sin tipo
	inc hl			;61b2
	inc hl			;61b3
	inc hl			;61b4
	ld (hl),c			;61b5   ; el cuarto byte, su numero
	inc c			;61b6   ; (cada cosa lleva el suyo)
	inc hl			;61b7
	djnz L_61B0		;61b8
	ret			;61ba
crea_las_cosas_de_la_habitacion:
	ld a,(0d002h)		;61bb   ; CREA LAS COSAS DE LA HABITACION: el bloque...
	ld c,a			;61be
	add a,a			;61bf   ; ... por tres
	add a,c			;61c0
	ld c,a			;61c1
	ld a,(0d000h)		;61c2   ; lee la FASE (0 el patio, 1-18)
	dec a			;61c5   ; la fase, desde 1
	ret m			;61c6   ; el patio no tiene
	sub c			;61c7   ; la fase dentro del bloque
	ld h,a			;61c8   ; 256 bytes por fase
	ld l,000h		;61c9
	ld de,0db00h		;61cb   ; en las listas
	add hl,de			;61ce
	ld a,(0d001h)		;61cf   ; lee la HABITACION dentro de la fase
	add a,a			;61d2   ; 16 bytes por habitacion
	add a,a			;61d3
	add a,a			;61d4
	add a,a			;61d5
	call 04061h		;61d6   ; hl_mas_a: HL += A
	ld b,004h		;61d9   ; cuatro cosas
L_61DB:
	push bc			;61db
	push hl			;61dc
	ld a,(hl)			;61dd   ; el tipo
	and a			;61de
	jr z,L_61F9		;61df   ; no hay
	ld b,000h		;61e1
	and 07fh		;61e3   ; sin la bandera
	ld c,a			;61e5   ; C = el tipo
	inc hl			;61e6
	ld a,(hl)			;61e7   ; la posicion:
	and 0f0h		;61e8   ; la y, el nibble alto
	ld e,a			;61ea
	ld a,(hl)			;61eb   ; la x...
	and 00fh		;61ec
	add a,a			;61ee   ; ... por 16
	add a,a			;61ef
	add a,a			;61f0
	add a,a			;61f1
	ld d,a			;61f2   ; D
	inc hl			;61f3
	inc hl			;61f4
	ld a,(hl)			;61f5   ; su numero
	call 05f1fh		;61f6   ; crea la cosa
L_61F9:
	pop hl			;61f9
	pop bc			;61fa
	inc hl			;61fb   ; la siguiente, 4 bytes mas alla
	inc hl			;61fc
	inc hl			;61fd
	inc hl			;61fe
	djnz L_61DB		;61ff   ; cuatro
	ret			;6201
logotipo_de_konami:
	call 047d4h		;6202   ; EL LOGOTIPO DE KONAMI
	call 05727h		;6205
	ld hl,0623ch		;6208   ; su paleta
	call 0483eh		;620b   ; pon_paleta: lista de [color][RB][G] hasta 0xFF
	ld b,00fh		;620e   ; el borde...
	ld c,007h		;6210   ; ... registro 7 = 0x0F
	call 00047h		;6212   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,02840h		;6215   ; un rectangulo...
	ld bc,0a848h		;6218   ; ... de 0xA8 x 0x48 en (0x28, 0x40)...
	xor a			;621b   ; ... de color 0...
	ld d,001h		;621c   ; ... en la pagina 1
	call 0490ah		;621e   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	call 0530fh		;6221
	ld de,04040h		;6224   ; en (0x40, 0x40)...
	ld hl,0628fh		;6227   ; ... el logotipo, del guion de 0x628F
	call monta_el_logotipo		;622a
	call 047c7h		;622d   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	ld hl,0c420h		;6230   ; la cuenta del telon
	ld (hl),03ch		;6233
	inc hl			;6235
	ld (hl),031h		;6236   ; 0x31 lineas
	inc hl			;6238
	ld (hl),000h		;6239   ; sin acabar
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


el_telon:
	ld hl,0c420h		;624c   ; EL TELON DEL LOGOTIPO: la cuenta
	dec (hl)			;624f
	ld a,(hl)			;6250   ; un cuadro de cada dos
	and 001h		;6251
	ret nz			;6253
	inc hl			;6254   ; una linea menos
	dec (hl)			;6255
	jr nz,L_625E		;6256   ; quedan
	ld a,001h		;6258   ; se acabo:
	ld (0c422h),a		;625a   ; el logotipo, listo
	ret			;625d
L_625E:
	ld a,031h		;625e   ; 0x31 menos las que quedan
	sub (hl)			;6260
	ld c,a			;6261   ; C = las lineas que se ven
	ld b,0a8h		;6262   ; 0xA8 de ancho
	ld hl,02840h		;6264   ; de (0x28, 0x40) de la pagina 1...
	ld de,02840h		;6267   ; ... a (0x28, 0x40) de la 0
	ld a,001h		;626a
	jp 04946h		;626c   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
monta_el_logotipo:
	push de			;626f   ; la posicion de la fila
L_6270:
	ld a,(hl)			;6270   ; el dibujo
	inc hl			;6271
	ld c,a			;6272
	inc a			;6273   ; 0xFF acaba
	jr z,L_628D		;6274
	inc a			;6276   ; 0xFE: fila nueva
	jr nz,L_6284		;6277
	pop de			;6279   ; vuelve al principio de la fila...
	ld a,(hl)			;627a   ; ... corrida dx
	inc hl			;627b
	add a,d			;627c
	ld d,a			;627d
	ld a,008h		;627e   ; y 8 puntos mas abajo
	add a,e			;6280
	ld e,a			;6281
	jr monta_el_logotipo		;6282
L_6284:
	ld a,c			;6284   ; el dibujo
	call 04b2fh		;6285   ; lo pinta
	call 04b4fh		;6288   ; la posicion siguiente
	jr L_6270		;628b
L_628D:
	pop de			;628d
	ret			;628e

; ----------------------------------------------------------------------
; DATOS logotipo: como se monta el logotipo de Konami: numeros de dibujo que
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


empieza_una_vida:
	ld a,020h		;62d0   ; EMPIEZA UNA VIDA: vida llena...
	ld (0c415h),a		;62d2   ; guarda la vida de Simon
barra_del_enemigo_llena:
	ld a,080h		;62d5   ; ... y la barra del enemigo llena
	ld (0c418h),a		;62d7   ; guarda la vida del enemigo (barra ENEMY)
	call pierde_lo_que_lleva		;62da   ; fuera armas y cuentas
	call 0548dh		;62dd   ; los dibujos de las armas
	call 05768h		;62e0   ; y los de la fase
	jp 053b6h		;62e3   ; y los de la pantalla
monta_la_fase:
	call 0564ch		;62e6   ; sube_los_dibujos_de_la_fase: los 191 dibujos del decorado de la fase de 0xD000
	call 0570dh		;62e9   ; la paleta de la fase
	call borra_lo_de_simon		;62ec   ; borra lo de Simon (0xC420-0xC46F)
	call simon_a_la_salida		;62ef   ; Simon a la salida de la fase
	call 05a49h		;62f2   ; la lista de cosas de la fase
monta_la_habitacion_entera:
	call sprites_fuera		;62f5   ; todos los sprites fuera
	call vacia_la_habitacion		;62f8   ; vacia las listas de la habitacion
	call 05780h		;62fb   ; la carga de la habitacion
	call 056e1h		;62fe   ; los dibujos de su decorado
	call 04f83h		;6301   ; monta la habitacion
	call 047d4h		;6304   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call mira_la_habitacion_especial		;6307   ; mira si es la habitacion especial
	call 04f91h		;630a   ; la pinta
	call 091beh		;630d   ; los vendedores
	call 08671h		;6310   ; los bloques que se rompen
	call 09147h		;6313   ; la puerta de la fase
	call 08ee6h		;6316   ; lo que lleva, en el marcador
	ld a,(0ce00h)		;6319   ; la especial 6...
	cp 006h		;631c
	call z,trae_lo_de_dracula		;631e   ; ... trae lo suyo
	call 047c7h		;6321   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	call 09ca9h		;6324   ; los plazos de las siete cosas
	call las_cosas_del_bloque		;6327   ; las cosas de las habitaciones
	jp crea_las_cosas_de_la_habitacion		;632a   ; y las de esta
trae_lo_de_dracula:
	call cuadro_primero		;632d
	jp dos_trozos_segundos		;6330
mira_la_habitacion_especial:
	xor a			;6333   ; a cero lo de la habitacion especial
	ld (0ce40h),a		;6334
	ld (0ce00h),a		;6337
	ld (0ce0bh),a		;633a
	ld (0ce08h),a		;633d
	ld (0ce15h),a		;6340
	ld a,(0d000h)		;6343   ; lee la FASE (0 el patio, 1-18)
	ld hl,0636fh		;6346   ; la habitacion especial de cada fase
	call 04061h		;6349   ; hl_mas_a: HL += A
	ld a,(0d001h)		;634c   ; lee la HABITACION dentro de la fase
	ld c,a			;634f   ; C = la habitacion en la que se esta
	ld a,(hl)			;6350   ; el byte de la fase
	ld b,a			;6351
	rra			;6352   ; la habitacion, el nibble alto
	rra			;6353
	rra			;6354
	rra			;6355
	and 00fh		;6356
	cp c			;6358   ; es esta?
	ret nz			;6359   ; no
	ld a,b			;635a   ; si: el nibble bajo...
	and 00fh		;635b
	ld l,a			;635d   ; ... a 0xCE00
	ld h,000h		;635e
	ld (0ce00h),hl		;6360
	cp 006h		;6363   ; vale 6?
	ret nz			;6365
	call 059ech		;6366   ; si: la paleta de Dracula, su sala y su cuerpo
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


vacia_la_habitacion:
	ld hl,0c470h		;6382   ; apunta a los bloques que se rompen (ocho de 16 bytes)
	ld de,0c471h		;6385   ; vacia las listas de la habitacion...
	ld (hl),000h		;6388
	ld bc,0028fh		;638a   ; ... 0x290 bytes
	ldir		;638d
	call 05b1bh		;638f   ; los bloques que se rompen
	call 05a40h		;6392   ; la puerta de la fase
	call 0902dh		;6395   ; las plataformas...
	call 0909bh		;6398   ; ... en su sitio
	call 05a37h		;639b   ; las salidas
	call quita_las_armas		;639e   ; fuera las armas
	ld hl,0c800h		;63a1   ; las siete fichas de 0xC800...
	ld de,00080h		;63a4   ; de 0x80 en 0x80
	ld b,007h		;63a7
	call vacia_fichas		;63a9   ; vacias
	ld hl,0d700h		;63ac   ; y las ocho de 0xD700
	ld b,008h		;63af
vacia_fichas:
	ld (hl),000h		;63b1   ; tipo 0: vacia
	add hl,de			;63b3   ; la siguiente
	djnz vacia_fichas		;63b4
	ret			;63b6
borra_lo_de_simon:
	ld hl,0c420h		;63b7   ; borra lo de Simon: 0xC420 a 0xC46F
	ld d,h			;63ba
	ld e,l			;63bb
	inc de			;63bc
	ld (hl),000h		;63bd
	ld bc,0004fh		;63bf
	ldir		;63c2
	ret			;63c4
sprites_fuera:
	ld hl,0d600h		;63c5   ; los 32 sprites de 0xD600...
	ld b,020h		;63c8
L_63CA:
	ld (hl),0e0h		;63ca   ; ... con la y a 0xE0: fuera de la pantalla
	inc l			;63cc   ; 4 bytes cada uno
	inc l			;63cd
	inc l			;63ce
	inc l			;63cf
	djnz L_63CA		;63d0
	ret			;63d2
pantalla_de_una_escena:
	call 047b9h		;63d3   ; LA PANTALLA DE UNA ESCENA:
	ld a,080h		;63d6   ; Simon en el centro (0x80, 0x80)
	ld (0c425h),a		;63d8   ; guarda la Y de Simon
	ld (0c427h),a		;63db   ; guarda la X de Simon
	call 05670h		;63de   ; los 191 dibujos del banco 9
	call 05733h		;63e1
	call 05678h		;63e4
	call sprites_fuera		;63e7
	call 04e9fh		;63ea
	call 04ec0h		;63ed
	call 04f17h		;63f0
	call 047d4h		;63f3   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 04513h		;63f6   ; el marcador
	call 04f83h		;63f9   ; monta la habitacion
	call 04f91h		;63fc   ; la pinta
	jp 047c7h		;63ff   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
simon_a_la_salida:
	ld a,(0d000h)		;6402   ; lee la FASE (0 el patio, 1-18)
	ld hl,0641fh		;6405   ; la salida de Simon en cada fase
	add a,a			;6408   ; dos bytes por fase
	call 04061h		;6409   ; hl_mas_a: HL += A
	ld a,(hl)			;640c   ; la y (el bit 0 es el lado)
	inc hl			;640d
	ld c,a			;640e
	and 0feh		;640f
	ld (0c425h),a		;6411   ; guarda la Y de Simon
	ld a,(hl)			;6414   ; la x
	ld (0c427h),a		;6415   ; guarda la X de Simon
	ld a,c			;6418
	and 001h		;6419   ; el lado
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


compone_los_sprites:
	ld a,(ix+000h)		;6445   ; COMPONE LOS SPRITES DE LA COSA: el tipo 0x0E...
	cp 00eh		;6448
	ret z			;644a
	cp 017h		;644b   ; ... y el 0x17 no
	ret z			;644d
	di			;644e
	ld a,006h		;644f   ; el banco 6 en 0xA000
	ld (0a000h),a		;6451   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6454   ; guarda la copia del banco de 0xA000
	ei			;6457
	ld a,(ix+00bh)		;6458   ; lee el dibujo de la cosa
	ld de,0b473h		;645b   ; como se compone cada dibujo
	call palabra_de_la_tabla		;645e   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	push ix		;6461   ; los sprites de la ficha
	pop hl			;6463
	set 5,l		;6464   ; +0x20
	ld b,(hl)			;6466   ; cuantos
	inc l			;6467   ; a la y del primero (+0x22)
	inc l			;6468
	ld a,(de)			;6469   ; 0x80, 0x81 y 0x82...
	cp 080h		;646a
	jr z,composicion_80		;646c
	cp 081h		;646e
	jr z,composicion_81		;6470
	cp 082h		;6472   ; ... son composiciones fijas
	jr z,composicion_82		;6474
sprite_a_sprite:
	ld a,(de)			;6476   ; dy
	inc de			;6477
	add a,(ix+003h)		;6478   ; le suma la y de la cosa
	ld (hl),a			;647b   ; la y del sprite
	inc l			;647c
	ld a,(de)			;647d   ; dx
	add a,(ix+005h)		;647e   ; le suma la x de la cosa
	ld (hl),a			;6481   ; la x del sprite
	inc de			;6482
	inc l			;6483
	ld a,(de)			;6484   ; el patron
	ld (hl),a			;6485
	inc de			;6486
	inc l			;6487
	inc l			;6488   ; al siguiente sprite (5 bytes)
	inc l			;6489
	djnz sprite_a_sprite		;648a   ; uno por sprite
	di			;648c
	ld a,003h		;648d   ; vuelve el banco 3
	ld (0a000h),a		;648f   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6492   ; guarda la copia del banco de 0xA000
	ei			;6495
	ret			;6496
composicion_82:
	exx			;6497   ; la 0x82: posiciones de 0x64D9
	ld hl,064d9h		;6498
	jr composicion_fija		;649b
composicion_81:
	exx			;649d   ; la 0x81: de 0x64D5
	ld hl,064d5h		;649e
	jr composicion_fija		;64a1
composicion_80:
	exx			;64a3   ; la 0x80: de 0x64CD
	ld hl,064cdh		;64a4
composicion_fija:
	exx			;64a7
sprite_fijo:
	exx			;64a8
	ld a,(hl)			;64a9   ; dy fijo
	inc hl			;64aa
	add a,(ix+003h)		;64ab   ; le suma la y de la cosa
	exx			;64ae
	ld (hl),a			;64af   ; la y del sprite
	inc l			;64b0
	exx			;64b1
	ld a,(hl)			;64b2   ; dx fijo
	inc hl			;64b3
	add a,(ix+005h)		;64b4   ; le suma la x de la cosa
	exx			;64b7
	ld (hl),a			;64b8   ; la x del sprite
	inc l			;64b9
	inc de			;64ba   ; el patron
	ld a,(de)			;64bb
	ld (hl),a			;64bc
	inc l			;64bd   ; al siguiente sprite
	inc l			;64be
	inc l			;64bf
	djnz sprite_fijo		;64c0   ; uno por sprite
	di			;64c2
	ld a,003h		;64c3   ; vuelve el banco 3
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


sprites_de_lo_que_lanzan_a_la_copia:
	ld hl,0d700h		;64e5   ; LOS SPRITES A LA TABLA: las ocho de 0xD700
	ld b,008h		;64e8
	jr una_ficha_a_la_copia		;64ea
sprites_de_los_enemigos_a_la_copia:
	ld hl,0c800h		;64ec   ; o las siete de 0xC800
	ld b,007h		;64ef
una_ficha_a_la_copia:
	push bc			;64f1
	push hl			;64f2
	ld a,(hl)			;64f3   ; vacia?
	and a			;64f4
	call nz,sprites_de_una_cosa		;64f5   ; sus sprites
	pop hl			;64f8
	pop bc			;64f9
	ld de,00080h		;64fa   ; la siguiente ficha
	add hl,de			;64fd
	djnz una_ficha_a_la_copia		;64fe
	ret			;6500
sprites_de_una_cosa:
	set 5,l		;6501   ; +0x20: cuantos
	ld b,(hl)			;6503
	ld a,b			;6504
	and a			;6505   ; ninguno
	ret z			;6506
	inc l			;6507   ; el primero
un_sprite_de_la_cosa:
	push bc			;6508
	ld a,(hl)			;6509   ; su hueco en la tabla
	ld b,a			;650a
	inc l			;650b
	add a,a			;650c   ; cuatro bytes por hueco
	add a,a			;650d
	ld de,0d638h		;650e   ; en la copia de la tabla de atributos (0xD638)
	add a,e			;6511
	ld e,a			;6512
	ld c,0ffh		;6513
	ldi		;6515   ; y, x y patron
	ldi		;6517
	ldi		;6519
	ld a,(hl)			;651b   ; el color
	and a			;651c
	jr nz,colores_del_hueco		;651d   ; si es 0...
	dec e			;651f
	dec e			;6520
	dec e			;6521
	ld a,0e1h		;6522   ; ... la y a 0xE1: no se ve
	ld (de),a			;6524
	inc e			;6525
	inc e			;6526
	inc e			;6527
colores_del_hueco:
	ex de,hl			;6528
	ld hl,06a70h		;6529   ; los colores de linea de ese hueco:
	ld a,b			;652c
	add a,a			;652d
	add a,a			;652e
	add a,a			;652f
	ld c,a			;6530   ; (0x6A70 + 8 * hueco) * 2 = 0xD4E0 + 16 * hueco
	ld b,000h		;6531
	add hl,bc			;6533
	add hl,hl			;6534
	ex de,hl			;6535
	ld a,(hl)			;6536   ; el color
	ld b,010h		;6537   ; en las 16 lineas del sprite (modo 2)
L_6539:
	ld (de),a			;6539
	inc e			;653a
	djnz L_6539		;653b
	pop bc			;653d
	inc l			;653e   ; el siguiente sprite de la ficha
	djnz un_sprite_de_la_cosa		;653f
	ret			;6541
palabra_de_la_tabla:
	ld l,a			;6542   ; HL = A...
	ld h,000h		;6543
	add hl,hl			;6545   ; ... por dos
	add hl,de			;6546   ; + la tabla
	ld e,(hl)			;6547   ; la palabra
	inc hl			;6548
	ld d,(hl)			;6549
	ret			;654a
sprites_a_la_vram:
	ld a,(0ce0ch)		;654b   ; LOS SPRITES A LA VRAM, cada cuadro. Sin 0xCE0C...
	or a			;654e
	jp nz,sprites_sin_rotar		;654f   ; ... tal cual
	ld a,(0ce00h)		;6552   ; en la habitacion especial 5...
	cp 005h		;6555
	jr z,sprites_sin_rotar		;6557   ; ... tal cual
	ld a,(0c5ach)		;6559   ; lee el estado de la puerta de la fase
	cp 005h		;655c   ; y con la puerta en 5...
	jr z,sprites_sin_rotar		;655e   ; ... tal cual
	ld hl,0c00fh		;6560   ; si no, el orden se rota cada cuadro...
	ld a,(hl)			;6563
	add a,068h		;6564   ; ... 0x68 posiciones...
	and 078h		;6566   ; ... (multiplo de 8)
	ld (hl),a			;6568
	ld a,(00007h)		;6569   ; el puerto de datos
	ld c,a			;656c
	call colores_rotados		;656d   ; los colores, en ese orden
	ld hl,0f600h		;6570   ; la tabla de atributos de la VRAM
	call 046afh		;6573   ; vram_para_escribir: prepara el V9938 para escribir en la direccion HL
	ld a,(0c00fh)		;6576   ; desde el sprite que toque
	ld d,010h		;6579   ; 16 tandas...
	ld h,0d6h		;657b   ; ... de la copia de 0xD600
tanda_de_atributos:
	ld b,008h		;657d   ; de dos sprites (8 bytes)
	ld l,a			;657f
	otir		;6580
	add a,048h		;6582   ; la tanda siguiente, rotando
	and 078h		;6584
	dec d			;6586
	jr nz,tanda_de_atributos		;6587
	ret			;6589
colores_rotados:
	ld hl,0f400h		;658a   ; la tabla de colores de sprite de la VRAM
	call 046afh		;658d   ; vram_para_escribir: prepara el V9938 para escribir en la direccion HL
	ld a,(0c00fh)		;6590   ; el mismo orden
	ld d,010h		;6593   ; 16 tandas
	add a,a			;6595   ; de la copia de 0xD400...
tanda_de_colores:
	ld h,06ah		;6596
	ld l,a			;6598
	add hl,hl			;6599
	ld b,020h		;659a   ; ... dos sprites de 16 lineas
	otir		;659c
	add a,090h		;659e   ; rotando
	dec d			;65a0
	jr nz,tanda_de_colores		;65a1
	ret			;65a3
sprites_sin_rotar:
	ld hl,0d400h		;65a4   ; sin rotar: la copia de 0xD400...
	ld de,0f400h		;65a7   ; ... a 0xF400 de la VRAM...
	ld bc,00280h		;65aa   ; ... colores y atributos de golpe
	jp 04675h		;65ad   ; copia_a_la_vram: BC bytes de HL a la VRAM de DE
la_sala_de_dracula:
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


dracula_paso_0:
	xor a			;65cc   ; LA SALA DE DRACULA (la clase 6, p03:B6B9), paso 0
	ld (0ce16h),a		;65cd
	ld (0ce0eh),a		;65d0
	ld de,0c0d0h		;65d3   ; en (0xC0, 0xD0)...
	ld c,011h		;65d6   ; ... Dracula (la cosa 0x11)
	call 05f1dh		;65d8   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	jp 0be3dh		;65db   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_1:
	call 0ad93h		;65de   ; paso 1
	ld a,(0ce16h)		;65e1   ; espera...
	and a			;65e4
	ret z			;65e5
	xor a			;65e6
	ld (0ce15h),a		;65e7
	ld (0ce0eh),a		;65ea
	call 0ad93h		;65ed
	jp 0be3dh		;65f0   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_2:
	xor a			;65f3   ; paso 2
	ld (0ce12h),a		;65f4
	call crea_seis_del_0x2e		;65f7
	ld a,078h		;65fa   ; 0x78 cuadros
	ld (0ce02h),a		;65fc
	jp 0be3dh		;65ff   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_3:
	ld hl,0ce02h		;6602   ; paso 3: la cuenta
	ld a,(hl)			;6605
	and a			;6606
	jr z,L_660A		;6607
	dec a			;6609
L_660A:
	ld (hl),a			;660a
	ret nz			;660b
	ld a,(0c800h)		;660c   ; y que no quede nadie en 0xC800
	and a			;660f
	ret nz			;6610
	ld a,000h		;6611   ; silencio
	call 0509fh		;6613   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jp 0be3dh		;6616   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_4:
	ld a,088h		;6619   ; paso 4: la musica 0x88
	call 0509fh		;661b   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,080h		;661e   ; la barra del enemigo, llena
	ld (0c418h),a		;6620   ; guarda la vida del enemigo (barra ENEMY)
	call 045e5h		;6623
	call dos_trozos_primeros		;6626
	ld c,017h		;6629   ; la cosa 0x17...
	ld de,08049h		;662b   ; ... en (0x49, 0x80)
	call 05f1dh		;662e   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	call 057b4h		;6631
	xor a			;6634
	ld (0ce36h),a		;6635
	ld (0ce37h),a		;6638
	jp 0be3dh		;663b   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_5:
	call cuenta_hacia_el_tercero		;663e   ; paso 5
	ld a,(0ce36h)		;6641   ; espera a que 0xCE36 llegue a 2
	sub 002h		;6644
	ret nz			;6646
	ld (0ce38h),a		;6647
	ld (0ce39h),a		;664a   ; guarda la cuenta del destello
	ld a,0c0h		;664d
	ld (0ce37h),a		;664f
	jp 0be3dh		;6652   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_6:
	ld a,(0ce15h)		;6655   ; paso 6
	and a			;6658
	jr nz,dracula_paso_6_cae		;6659
	call el_destello		;665b   ; el destello
	call animacion_de_la_escena		;665e
	call cuenta_de_la_escena		;6661
	jp crea_un_0x2c		;6664
dracula_paso_6_cae:
	call dos_trozos_segundos		;6667
	call destello_a_negro		;666a
	call mueren_las_cosas		;666d   ; borra todas las cosas
	xor a			;6670
	ld (0ce37h),a		;6671
	jp 0be3dh		;6674   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_7:
	call cuenta_hacia_el_primero		;6677   ; paso 7
	ld a,(0ce36h)		;667a
	and a			;667d
	ret nz			;667e
	ld a,08dh		;667f   ; la musica 0x8D
	call 0509fh		;6681   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,0b4h		;6684   ; 0xB4 cuadros
	ld (0ce02h),a		;6686
	jp 0be3dh		;6689   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_8:
	ld hl,0ce02h		;668c   ; paso 8: la cuenta
	dec (hl)			;668f
	ret nz			;6690
	call guarda_la_paleta		;6691
	jp 0be3dh		;6694   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_9:
	call apaga_la_paleta_un_paso		;6697   ; paso 9
	ret nz			;669a
	call 047b1h		;669b
	call 047feh		;669e
	ld a,008h		;66a1   ; 8 cuadros
	ld (0ce02h),a		;66a3
	jp 0be3dh		;66a6   ; siguiente_paso: sube el paso de la escena (0xCE01)
dracula_paso_10:
	ld hl,0ce02h		;66a9   ; paso 10: la cuenta
	dec (hl)			;66ac
	ret nz			;66ad
	ld hl,00000h		;66ae
	ld (0ce00h),hl		;66b1
	ld a,001h		;66b4   ; y a los textos del final
	ld (0ce40h),a		;66b6
	ret			;66b9
el_texto_del_final:
	ld a,(0ce40h)		;66ba   ; EL TEXTO DEL FINAL, por pasos (0xCE40)
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


final_empieza:
	ld a,08eh		;66c9   ; la musica 0x8E
	call 0509fh		;66cb   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	call prepara_el_texto		;66ce   ; prepara la pantalla del texto
final_paso_siguiente:
	ld hl,0ce40h		;66d1   ; el paso siguiente
	inc (hl)			;66d4
	ret			;66d5
final_renglones:
	call texto_cada_cuadro		;66d6   ; los renglones
	ld a,(0ce32h)		;66d9   ; hasta el ultimo
	and a			;66dc
	ret z			;66dd
	jr final_paso_siguiente		;66de
final_espera:
	call 05309h		;66e0
	ret nz			;66e3
	ld a,01eh		;66e4   ; 0x1E cuadros
	ld (0ce02h),a		;66e6
	call 047b1h		;66e9
	call 047d4h		;66ec   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	jr final_paso_siguiente		;66ef
final_acaba:
	ld hl,0ce02h		;66f1   ; la cuenta
	dec (hl)			;66f4
	ret nz			;66f5
	xor a			;66f6   ; se acabo:
	ld (0ce34h),a		;66f7
	ld (0ce40h),a		;66fa
	inc a			;66fd
	ld (0c409h),a		;66fe
	ld hl,0d012h		;6701   ; LA VUELTA: una mas...
	ld a,(hl)			;6704
	inc a			;6705
	cp 003h		;6706   ; ... hasta la 2
	jr nc,L_670B		;6708
	ld (hl),a			;670a
L_670B:
	ld b,000h		;670b   ; y el desplazamiento vertical...
	ld c,017h		;670d   ; ... (registro 23) a cero
	jp 00047h		;670f   ; BIOS WRTVDP - Writes data in the VDP-register
prepara_el_texto:
	call 053deh		;6712   ; la pantalla del texto
	xor a			;6715   ; todo a cero
	ld (0ce30h),a		;6716
	ld (0ce33h),a		;6719   ; guarda la cuenta del texto del final
	ld (0ce31h),a		;671c   ; guarda el renglon del final que toca
	ld (0ce32h),a		;671f
	inc a			;6722
	ld (0ce34h),a		;6723
	ld a,00eh		;6726   ; el color 14...
	ld d,0ffh		;6728   ; ... blanco (0xFF, 0x0F)
	ld e,00fh		;672a
	jp 04814h		;672c   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
texto_cada_cuadro:
	call cuenta_del_texto		;672f   ; cada cuadro: la cuenta
	call renglon_del_texto		;6732   ; el renglon
	jp borra_la_linea_de_arriba		;6735   ; y lo demas
cuenta_del_texto:
	ld a,(0c003h)		;6738   ; lee el contador de cuadros
	and 003h		;673b   ; cada cuatro cuadros...
	ret nz			;673d
	ld hl,0ce33h		;673e   ; apunta a la cuenta del texto del final
	inc (hl)			;6741   ; ... sube la cuenta del texto
	ret			;6742
renglon_del_texto:
	di			;6743   ; los bancos 8 y 5, donde estan los renglones
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
	jr z,ultimo_renglon		;676c
	ld d,a			;676e
	ld a,(0ce33h)		;676f   ; lee la cuenta del texto del final
	add a,0d8h		;6772   ; la columna
	ld e,a			;6774
	ld c,0ffh		;6775   ; se pinta
	call 04ad5h		;6777   ; el texto del renglon
	ld hl,0ce31h		;677a   ; apunta a el renglon del final que toca
	inc (hl)			;677d   ; el siguiente
	jp 05336h		;677e   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
ultimo_renglon:
	ld a,001h		;6781   ; el ultimo: se acabo el texto
	ld (0ce32h),a		;6783
	ld a,0ffh		;6786   ; la musica se funde
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


el_destello:
	ld hl,0ce39h		;67e4   ; apunta a la cuenta del destello
	ld a,(hl)			;67e7   ; la cuenta...
	inc a			;67e8
	cp 013h		;67e9   ; ... de 0 a 18
	jr c,L_67EE		;67eb
	xor a			;67ed
L_67EE:
	ld (hl),a			;67ee
	ld hl,067fdh		;67ef   ; el color del destello
	call 04061h		;67f2   ; hl_mas_a: HL += A
	ld d,(hl)			;67f5   ; rojo y azul
	ld e,005h		;67f6   ; verde 5
	ld a,006h		;67f8   ; al color 6
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


destello_a_negro:
	ld de,00000h		;6810   ; el color 6 a negro
	ld a,006h		;6813
	jp 04814h		;6815   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
cuenta_de_la_escena:
	ld hl,0ce38h		;6818   ; otra cuenta de la escena
	inc (hl)			;681b
	ld a,(hl)			;681c
	and 01fh		;681d   ; cada 32:
	cp 01ch		;681f   ; en la 28...
	jp z,dos_trozos_segundos		;6821   ; ... un dibujo
	cp 01fh		;6824   ; en la 31...
	ret nz			;6826
	jp dos_trozos_primeros		;6827   ; ... el otro
borra_la_linea_de_arriba:
	ld a,(0ce33h)		;682a   ; EL TEXTO SUBE: la linea que se va por arriba...
	sub 002h		;682d
	ld h,a			;682f   ; ... por 128 bytes
	ld l,000h		;6830
	srl h		;6832
	rr l		;6834
	ld de,00000h		;6836   ; en la pagina 0
	add hl,de			;6839
	ld bc,00080h		;683a   ; una linea
	xor a			;683d   ; se borra
	jp 00056h		;683e   ; BIOS FILVRM - Fills VRAM with value
sube_la_pantalla:
	ld a,(0ce34h)		;6841   ; hay desplazamiento?
	and a			;6844
	ret z			;6845   ; no
	ld a,(0ce33h)		;6846   ; lee la cuenta del texto del final
	ld b,a			;6849   ; la cuenta del texto...
	ld c,017h		;684a   ; ... al registro 23: la pantalla sube
	jp 00047h		;684c   ; BIOS WRTVDP - Writes data in the VDP-register
crea_seis_del_0x2e:
	ld b,006h		;684f   ; seis cosas...
crea_uno_del_0x2e:
	push bc			;6851
	ld c,02eh		;6852   ; ... de tipo 0x2E
	ld a,r		;6854   ; una x al azar, +-8...
	and 00fh		;6856
	sub 008h		;6858
	ld d,a			;685a
	ld a,(0ce0fh)		;685b   ; ... de 0xCE0F
	add a,d			;685e
	ld d,a			;685f
	ld a,r		;6860   ; una y al azar, de 0x98 a 0xA7
	and 00fh		;6862
	add a,098h		;6864
	ld e,a			;6866
	call 05f1dh		;6867   ; la crea
	pop bc			;686a
	djnz crea_uno_del_0x2e		;686b   ; seis
L_686D:
	ret			;686d
animacion_de_la_escena:
	ld a,(0ce35h)		;686e   ; una animacion por pasos (0xCE35)
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


animacion_espera:
	ld hl,0ce37h		;687c   ; la cuenta
	dec (hl)			;687f
	ret nz			;6880
animacion_paso_siguiente:
	ld hl,0ce35h		;6881   ; el paso siguiente
	inc (hl)			;6884
	ret			;6885
animacion_sube:
	call cuenta_hacia_el_primero		;6886
	ld a,(0ce36h)		;6889
	and a			;688c
	ret nz			;688d
	ld a,040h		;688e   ; 0x40 cuadros
	ld (0ce37h),a		;6890
	jr animacion_paso_siguiente		;6893
animacion_baja:
	call cuenta_hacia_el_tercero		;6895
	ld a,(0ce36h)		;6898   ; hasta que 0xCE36 sea 2
	cp 002h		;689b
	ret nz			;689d
	xor a			;689e   ; vuelve al paso 0
	ld (0ce35h),a		;689f
	ld a,0c0h		;68a2   ; 0xC0 cuadros
	ld (0ce37h),a		;68a4
	ret			;68a7
cuenta_hacia_el_primero:
	ld hl,0ce37h		;68a8   ; la cuenta
	inc (hl)			;68ab
	cp 010h		;68ac   ; a los 16...
	jr z,cuenta_a_los_16		;68ae
	ld a,(hl)			;68b0   ; ... a los 32:
	sub 010h		;68b1
	ret nz			;68b3
	ld (0ce36h),a		;68b4
	jr cuadro_primero		;68b7   ; el primer cuadro
cuenta_a_los_16:
	ld hl,0ce36h		;68b9
	ld a,(hl)			;68bc
	ld (hl),001h		;68bd
	cp 002h		;68bf
	ret nz			;68c1
	jr cuadro_segundo		;68c2   ; el segundo cuadro
cuenta_hacia_el_tercero:
	ld hl,0ce37h		;68c4   ; la cuenta
	inc (hl)			;68c7
	ld a,(hl)			;68c8
	cp 010h		;68c9   ; a los 16...
	jr z,cuenta_a_1		;68cb
	cp 020h		;68cd   ; ... a los 32:
	ret nz			;68cf
	ld a,002h		;68d0
	ld (0ce36h),a		;68d2
	jr cuadro_tercero		;68d5   ; el tercer cuadro
cuenta_a_1:
	ld a,001h		;68d7
	ld (0ce36h),a		;68d9
cuadro_segundo:
	ld hl,060a0h		;68dc   ; un cuadro de la animacion: cuatro trozos de 16 x 16 de la fila 0xA0 de la pagina 1...
	ld de,07080h		;68df   ; ... a (0x70, 0x80)
	ld bc,01010h		;68e2
	ld a,001h		;68e5
	call 04946h		;68e7   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,0a0a0h		;68ea
	ld de,08080h		;68ed   ; a (0x80, 0x80)
	ld bc,01010h		;68f0
	ld a,001h		;68f3
	call 04946h		;68f5   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,050a0h		;68f8
	ld de,07090h		;68fb   ; a (0x70, 0x90)
	ld bc,01010h		;68fe
	ld a,001h		;6901
	call 04946h		;6903   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,090a0h		;6906
	ld de,08090h		;6909   ; a (0x80, 0x90)
	ld bc,01010h		;690c
	ld a,001h		;690f
	jp 04946h		;6911   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
cuadro_primero:
	ld hl,040a0h		;6914   ; otro cuadro
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
cuadro_tercero:
	ld hl,060a0h		;694c   ; otro cuadro
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
dos_trozos_primeros:
	ld hl,000a0h		;6984   ; dos trozos de 16 x 16...
	ld de,06858h		;6987   ; ... a (0x68, 0x58)...
	ld bc,01010h		;698a
	ld a,001h		;698d
	call 04946h		;698f   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,010a0h		;6992
	ld de,08858h		;6995   ; ... y (0x88, 0x58)
	ld bc,01010h		;6998
	ld a,001h		;699b
	jp 04946h		;699d   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
dos_trozos_segundos:
	ld hl,020a0h		;69a0   ; los otros dos
	ld de,06858h		;69a3
	ld bc,01010h		;69a6
	ld a,001h		;69a9
	call 04946h		;69ab   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	ld hl,030a0h		;69ae
	ld de,08858h		;69b1
	ld bc,01010h		;69b4
	ld a,001h		;69b7
	jp 04946h		;69b9   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
nace_el_0x2e:
	xor a			;69bc   ; las cosas que saltan en la escena:
	ld (ix+07eh),a		;69bd
	ld (ix+00eh),a		;69c0
	ld (ix+006h),001h		;69c3   ; la cosa se mueve
	ld (ix+00bh),05ah		;69c7   ; el dibujo de la cosa = 0x5A
	ld hl,0ce12h		;69cb   ; la cuenta de 0xCE12...
	ld a,(hl)			;69ce
	inc (hl)			;69cf
	add a,a			;69d0   ; dos palabras por cosa
	ld de,069e4h		;69d1   ; de la tabla de 0x69E4
	call palabra_de_la_tabla		;69d4   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	call 0a55dh		;69d7   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	inc hl			;69da   ; la segunda
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


guarda_la_paleta:
	ld hl,0f680h		;69fc   ; LA PALETA SE APAGA: la copia de la VRAM (0xF680)...
	ld de,0ce60h		;69ff   ; ... a 0xCE60
	ld bc,00020h		;6a02   ; los 16 colores
	call 0465ah		;6a05
	ld a,080h		;6a08   ; 0x80 cuadros
	ld (0ce13h),a		;6a0a
	ret			;6a0d
apaga_la_paleta_un_paso:
	ld hl,0ce13h		;6a0e   ; un paso: la cuenta
	dec (hl)			;6a11
	ld a,(hl)			;6a12
	and 00fh		;6a13   ; el color que toca (uno por cuadro)
	ld c,a			;6a15
	add a,a			;6a16   ; dos bytes por color
	ld hl,0ce60h		;6a17
	call 04061h		;6a1a   ; hl_mas_a: HL += A
	ld a,(hl)			;6a1d   ; el rojo...
	and 0f0h		;6a1e
	jr z,L_6A24		;6a20   ; ... a cero ya?
	sub 010h		;6a22   ; ... baja uno
L_6A24:
	ld d,a			;6a24
	ld a,(hl)			;6a25   ; el azul...
	and 00fh		;6a26
	jr z,L_6A2B		;6a28
	dec a			;6a2a   ; ... baja uno
L_6A2B:
	or d			;6a2b
	ld (hl),a			;6a2c
	ld d,a			;6a2d
	inc hl			;6a2e
	ld a,(hl)			;6a2f   ; el verde...
	and a			;6a30
	jr z,L_6A34		;6a31
	dec a			;6a33   ; ... baja uno
L_6A34:
	ld (hl),a			;6a34
	inc hl			;6a35
	ld e,a			;6a36
	ld a,c			;6a37   ; y el color, al VDP
	call 04814h		;6a38   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
	ld a,(0ce13h)		;6a3b   ; hasta que la cuenta acabe
	and a			;6a3e
	ret			;6a3f
quieta_con_0x0e_a_5:
	ld (ix+00eh),005h		;6a40
	ld (ix+006h),000h		;6a44   ; la cosa se queda quieta
L_6A48:
	ret			;6a48
crea_un_0x2c:
	ld a,(0ce36h)		;6a49   ; con 0xCE36 a 2...
	cp 002h		;6a4c
	ret nz			;6a4e
	ld a,(0c003h)		;6a4f   ; ... cada ocho cuadros...
	and 007h		;6a52
	ret nz			;6a54
	ld c,02ch		;6a55   ; ... una cosa 0x2C...
	ld de,08098h		;6a57   ; ... en (0x98, 0x80)
	jp 05f1dh		;6a5a   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
nace_el_0x2c:
	ld (ix+006h),001h		;6a5d   ; EL TIPO 0x2C (p01:6A49), al nacer: se mueve...
	ld (ix+00ch),008h		;6a61   ; la cuenta de cuadros del paso = 0x08
	ld (ix+011h),000h		;6a65
	ld (ix+00bh),002h		;6a69   ; el dibujo de la cosa = 0x02
	ld de,00300h		;6a6d   ; ... cae a 0x300...
	call 0a55dh		;6a70   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld hl,0cf32h		;6a73   ; ... y de lado, una de las ocho de 0x6A8C por turno...
	inc (hl)			;6a76
	ld a,(hl)			;6a77
	and 007h		;6a78
	ld de,06a8ch		;6a7a
	call palabra_de_la_tabla		;6a7d   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld a,(0c427h)		;6a80   ; ... hacia Simon
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


el_0x2c:
	ld a,(ix+001h)		;6a9c   ; EL TIPO 0x2C, cada cuadro: salvo en el paso 4...
	cp 004h		;6a9f
	ld de,0ffd0h		;6aa1   ; ... sube a -0x30 por cuadro
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


el_0x2c_paso_0:
	dec (ix+00ch)		;6ab7   ; paso 0: al acabar la cuenta, el dibujo 0xA5
	ret nz			;6aba
	ld (ix+00bh),0a5h		;6abb   ; el dibujo de la cosa = 0xA5
	ld (ix+00ch),008h		;6abf   ; la cuenta de cuadros del paso = 0x08
	inc (ix+001h)		;6ac3   ; sube el paso en que va la cosa
	ret			;6ac6
el_0x2c_paso_1:
	dec (ix+00ch)		;6ac7   ; paso 1: al acabar, el 0xA6 o, a la derecha, el 0xA7
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
el_0x2c_paso_2:
	dec (ix+00ch)		;6adf   ; paso 2: 0x18 cuadros
	ret nz			;6ae2
	ld (ix+00ch),018h		;6ae3   ; la cuenta de cuadros del paso = 0x18
	inc (ix+001h)		;6ae7   ; sube el paso en que va la cosa
	ret			;6aea
el_0x2c_paso_3:
	ld a,(ix+011h)		;6aeb   ; paso 3: su color (byte 0x11)...
	call color_del_0x2c		;6aee
	dec (ix+00ch)		;6af1   ; ... hasta acabar la cuenta
	ret nz			;6af4
	inc (ix+001h)		;6af5   ; sube el paso en que va la cosa
	ret			;6af8
color_del_0x2c:
	ld a,(ix+011h)		;6af9
	jp 0b15dh		;6afc

; ----------------------------------------------------------------------
; SIMON, cada cuadro (p00:5C5F). Con la bola del jefe cogida (0xCE11) no hay mandos. Luego lo de 0x7718, su estado (0x6B39), y fuera de los estados 2, 3 y 5 de la puerta de la fase, lo de 0x710D; y el latigo, las armas y lo demas (0x767B-0x7618). Los mandos (0xC007, recien pulsados en 0xC006): bit 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 y 5 los disparos.
; ----------------------------------------------------------------------
simon_cada_cuadro:
	ld a,(0ce11h)		;6aff   ; la bola cogida (0xCE11)?
	and a			;6b02
	jr z,L_6B0C		;6b03
	xor a			;6b05   ; si: sin mandos
	ld (0c007h),a		;6b06
	ld (0c006h),a		;6b09
L_6B0C:
	call la_puerta_de_la_fase		;6b0c
	call el_estado_de_simon		;6b0f
	ld a,(0c5ach)		;6b12   ; la puerta de la fase...
	cp 002h		;6b15
	jr z,L_6B24		;6b17
	cp 003h		;6b19
	jr z,L_6B24		;6b1b
	cp 005h		;6b1d
	jr z,L_6B24		;6b1f
	call latigo_y_armas		;6b21   ; ... si no esta abriendose
L_6B24:
	call los_bordes		;6b24
	call cuentas_de_simon		;6b27
	call cuenta_de_la_invencibilidad		;6b2a
	call cuenta_del_reloj		;6b2d
	call cuenta_de_0xc445		;6b30
	call destello_del_borde		;6b33
	jp poses_con_escudo		;6b36

; ----------------------------------------------------------------------
; LOS ESTADOS DE SIMON (0xC420, subestado en 0xC421): 0 de pie o andando, 1 saltando, 2 agachado, 3 en la escalera, 4 cayendo, 5-7 los de 0x6F85, 0x7093 y 0x70FB.
; ----------------------------------------------------------------------
el_estado_de_simon:
	call 08524h		;6b39
	ld a,(0c420h)		;6b3c   ; por su estado
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


simon_de_pie:
	call mira_el_suelo		;6b52   ; ESTADO 0: suelo bajo los pies?
	jr c,L_6B5D		;6b55
	ld a,(0c439h)		;6b57   ; ... o una plataforma (0xC439)?
	and a			;6b5a
	jr z,a_caer		;6b5b   ; nada: a caer
L_6B5D:
	ld a,(0c5ach)		;6b5d   ; con la puerta de la fase en 4...
	cp 004h		;6b60
	jr z,L_6B67		;6b62
	cp 002h		;6b64   ; ... o en 0 o 1, sigue
	ret nc			;6b66
L_6B67:
	ld a,(0c439h)		;6b67   ; sobre una plataforma...
	and a			;6b6a
	call nz,con_la_plataforma		;6b6b   ; ... se mueve con ella
	ld a,(0c422h)		;6b6e   ; dando un latigazo (0xC422): nada mas
	and a			;6b71
	ret nz			;6b72
	ld de,00000h		;6b73   ; de pie (poses 0 y 0)
	ld (0c42eh),de		;6b76   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	call pose_segun_el_lado		;6b7a   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	ld a,(0c007h)		;6b7d   ; arriba: a la escalera?
	rra			;6b80
	jr c,arriba		;6b81
abajo_y_a_los_lados:
	rra			;6b83   ; abajo: a la escalera o agachado
	jp c,abajo		;6b84
	rra			;6b87   ; izquierda...
	push af			;6b88
	call c,anda_a_la_izquierda		;6b89
	pop af			;6b8c
	rra			;6b8d   ; ... derecha
	call c,anda_a_la_derecha		;6b8e
	ld a,(0c006h)		;6b91   ; el segundo disparo recien pulsado...
	and 020h		;6b94
	ret z			;6b96
	call techo_encima		;6b97   ; ... sin techo encima...
	ret c			;6b9a
	ld a,001h		;6b9b   ; ... al estado 1: salta
	ld (0c420h),a		;6b9d
	xor a			;6ba0
	ld (0c421h),a		;6ba1
	ret			;6ba4
a_caer:
	ld a,004h		;6ba5   ; al estado 4: cae
	ld (0c420h),a		;6ba7
	xor a			;6baa
	ld (0c421h),a		;6bab
	ret			;6bae

; ----------------------------------------------------------------------
; CON LA PLATAFORMA: la 1 o la 2 (0xC439) de 0xC598; se mueve un punto con ella, a su lado (el bit 7 de su tercer byte), si no hay pared.
; ----------------------------------------------------------------------
con_la_plataforma:
	dec a			;6baf   ; la 1: la ficha de 0xC598...
	ld a,007h		;6bb0   ; ... la 2, siete bytes mas alla
	jr nz,hacia_donde_va		;6bb2
	xor a			;6bb4
hacia_donde_va:
	ld hl,0c598h		;6bb5
	call 04061h		;6bb8   ; hl_mas_a: HL += A
	inc hl			;6bbb
	inc hl			;6bbc
	inc hl			;6bbd
	ld a,(hl)			;6bbe   ; hacia la izquierda (bit 7)?
	rla			;6bbf
	ld d,000h		;6bc0
	jr c,plataforma_a_la_izquierda		;6bc2
	call pared_a_la_derecha		;6bc4   ; no: pared a la derecha?
	ret c			;6bc7
	ld d,001h		;6bc8   ; un punto a la derecha
	jr mueve_con_la_plataforma		;6bca
plataforma_a_la_izquierda:
	call pared_a_la_izquierda		;6bcc   ; pared a la izquierda?
	ret c			;6bcf
	ld d,0ffh		;6bd0   ; un punto a la izquierda
mueve_con_la_plataforma:
	ld a,(0c427h)		;6bd2   ; la x de Simon, mas D
	add a,d			;6bd5
	ld (0c427h),a		;6bd6   ; guarda la X de Simon
	ret			;6bd9

; ----------------------------------------------------------------------
; ARRIBA: si hay escalera que sube (0x7CDB hacia la izquierda, 0x7D05 hacia la derecha), al estado 3 con la x en la rejilla de 8; si no, lo demas.
; ----------------------------------------------------------------------
arriba:
	ex af,af'			;6bda
	call escalera_que_sube_a_la_izquierda		;6bdb   ; sube a la izquierda?
	ld bc,00001h		;6bde   ; (subestado 0, tecla 1: arriba)
	jr z,a_la_escalera		;6be1
	call escalera_que_sube_a_la_derecha		;6be3   ; sube a la derecha?
	ld bc,00101h		;6be6   ; (subestado 1)
	jr z,a_la_escalera		;6be9
	ex af,af'			;6beb   ; no hay: lo demas
	jr abajo_y_a_los_lados		;6bec
a_la_escalera:
	ld a,003h		;6bee   ; ESTADO 3...
	ld (0c420h),a		;6bf0
	ld a,c			;6bf3   ; ... con la tecla que sigue (0xC435)...
	ld (0c435h),a		;6bf4
	ld a,b			;6bf7   ; ... hacia donde va la escalera...
	ld (0c421h),a		;6bf8
	rra			;6bfb
	ld a,(0c427h)		;6bfc   ; ... y la x en la rejilla de 8 (mas 8 en la de la derecha)
	jr nc,L_6C03		;6bff
	add a,008h		;6c01
L_6C03:
	and 0f8h		;6c03
	ld (0c427h),a		;6c05   ; guarda la X de Simon
	xor a			;6c08   ; sin fracciones
	ld (0c424h),a		;6c09   ; guarda la fraccion de la y de Simon
	ld (0c426h),a		;6c0c   ; guarda la fraccion de la x de Simon
	ret			;6c0f

; ----------------------------------------------------------------------
; ABAJO: si hay escalera que baja (0x7C8B, 0x7CB3), al estado 3; si no, agachado (estado 2, poses 6 y 0).
; ----------------------------------------------------------------------
abajo:
	call escalera_que_baja_a_la_derecha		;6c10   ; baja a la derecha?
	ld bc,00002h		;6c13   ; (tecla 2: abajo)
	jr z,a_la_escalera		;6c16
	call escalera_que_baja_a_la_izquierda		;6c18   ; baja a la izquierda?
	ld bc,00102h		;6c1b
	jr z,a_la_escalera		;6c1e
	ld a,002h		;6c20   ; no: ESTADO 2, agachado
	ld (0c420h),a		;6c22
	ld de,00006h		;6c25   ; las piernas en la pose 6
	ld (0c42eh),de		;6c28   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	jp pose_segun_el_lado		;6c2c   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon

; ----------------------------------------------------------------------
; ANDA A LA IZQUIERDA (0x6C53 a la derecha): sin pared, a 0x200 por cuadro, o a 0x280 con las botas (bit 3 de 0xC431); sin pasar de 0x10 (o de 0xF0) si 0xC41E (0xC41F a la derecha) vale 0xFF, sin meterse en la puerta de la fase y sin moverse con ella en los estados 2 y 3.
; ----------------------------------------------------------------------
anda_a_la_izquierda:
	ld a,001h		;6c2f   ; mira a la izquierda
	ld (0c42ch),a		;6c31   ; guarda el lado al que mira Simon (0 derecha)
	ld a,(0c41eh)		;6c34   ; con 0xC41E a 0xFF...
	inc a			;6c37
	jr nz,izquierda_sin_pared		;6c38
	ld a,(0c427h)		;6c3a   ; ... no pasa de 0x10
	cp 010h		;6c3d
	ret c			;6c3f
izquierda_sin_pared:
	call pared_a_la_izquierda		;6c40   ; pared?
	ret c			;6c43
	ld a,(0c431h)		;6c44   ; con las botas...
	and 008h		;6c47
	ld bc,0fe00h		;6c49   ; ... -0x200...
	jr z,L_6C51		;6c4c
	ld bc,0fd80h		;6c4e   ; ... o -0x280
L_6C51:
	jr anda		;6c51
anda_a_la_derecha:
	xor a			;6c53   ; mira a la derecha
	ld (0c42ch),a		;6c54   ; guarda el lado al que mira Simon (0 derecha)
	ld a,(0c41fh)		;6c57   ; con 0xC41F a 0xFF...
	inc a			;6c5a
	jr nz,derecha_sin_pared		;6c5b
	ld a,(0c427h)		;6c5d   ; ... no pasa de 0xF0
	cp 0f0h		;6c60
	ret nc			;6c62
derecha_sin_pared:
	call pared_a_la_derecha		;6c63   ; pared?
	ret c			;6c66
	ld a,(0c431h)		;6c67   ; con las botas...
	and 008h		;6c6a
	ld bc,00200h		;6c6c   ; ... 0x200...
	jr z,anda		;6c6f
	ld c,080h		;6c71   ; ... o 0x280
anda:
	push bc			;6c73
	ld a,(0c425h)		;6c74   ; en la puerta de la fase?
	ld b,a			;6c77
	ld a,(0c427h)		;6c78   ; lee la X de Simon
	ld c,a			;6c7b
	call 08580h		;6c7c
	pop bc			;6c7f
	ret c			;6c80   ; si: no pasa
	ld a,(0c5ach)		;6c81   ; la puerta de la fase en 2 o 3...
	dec a			;6c84
	dec a			;6c85
	cp 002h		;6c86
	ret c			;6c88   ; ... tampoco
	ld a,(0c420h)		;6c89   ; en el estado 5...
	cp 005h		;6c8c
	jr z,suma_la_velocidad		;6c8e
	dec a			;6c90   ; ... o de pie, con las poses de andar
	call nz,poses_de_andar		;6c91
suma_la_velocidad:
	ld hl,(0c426h)		;6c94   ; x += BC
	add hl,bc			;6c97
	ld (0c426h),hl		;6c98   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	ret			;6c9b
poses_de_andar:
	ld a,(0c007h)		;6c9c   ; izquierda y derecha a la vez...
	and 00ch		;6c9f
	cp 00ch		;6ca1   ; ... nada
	ret z			;6ca3
poses_por_el_cuadro:
	ld a,(0c003h)		;6ca4   ; cada ocho cuadros, uno de tres pasos:
	rra			;6ca7
	rra			;6ca8
	rra			;6ca9
	ld de,00101h		;6caa   ; 1 y 1...
	jr c,L_6CB8		;6cad
	rra			;6caf
	ld de,00000h		;6cb0   ; ... 0 y 0...
	jr c,L_6CB8		;6cb3
	ld de,00202h		;6cb5   ; ... o 2 y 2
L_6CB8:
	ld hl,(0c42eh)		;6cb8   ; se suman a las poses
	add hl,de			;6cbb
	ld (0c42eh),hl		;6cbc   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	ret			;6cbf
simon_salta:
	ld a,(0c421h)		;6cc0   ; ESTADO 1, por su subestado
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


salto_empieza:
	ld b,001h		;6cce   ; subestado 0: hacia donde, 1 recto...
	ld a,(0c007h)		;6cd0   ; ... con izquierda o derecha...
	and 00ch		;6cd3
	jr z,salto_subestado		;6cd5
	rra			;6cd7
	rra			;6cd8
	cp 003h		;6cd9   ; (las dos: recto)
	jr nc,salto_subestado		;6cdb
	rra			;6cdd   ; ... 2 a la izquierda...
	inc b			;6cde
	jr c,salto_subestado		;6cdf
	inc b			;6ce1   ; ... 3 a la derecha
salto_subestado:
	ld hl,0c421h		;6ce2   ; al subestado
	ld (hl),b			;6ce5
	ret			;6ce6

; ----------------------------------------------------------------------
; LA CURVA DEL SALTO: la cuenta de 0xC428 sube hasta 0x13 (0x15 con las alas, bit 4 de 0xC431, que empiezan un paso antes en 0x6D94) y cada paso suma a la y lo de 0x6D95; las piernas en la pose 6 si no da un latigazo. Desde el paso 9 mira el suelo; al caer pasado el final, 0xCFF0 = 1 para el efecto 7 al aterrizar. En el suelo: la y en la rejilla de 8 y al estado 0.
; ----------------------------------------------------------------------
salto_recto:
	ld a,(0c431h)		;6ce7   ; con las alas...
	and 010h		;6cea
	ld bc,06d95h		;6cec   ; ... la curva de 0x6D95, 0x13 pasos...
	ld d,013h		;6cef
	jr z,L_6CF8		;6cf1
	ld bc,06d94h		;6cf3   ; ... o de 0x6D94, 0x15
	ld d,015h		;6cf6
L_6CF8:
	ld hl,0c428h		;6cf8   ; la cuenta del salto
	push hl			;6cfb
	call aplica_la_curva		;6cfc   ; aplica_la_curva: sube la cuenta de (HL) hasta D y suma a la y de Simon el paso de la curva de BC
	pop hl			;6cff
	ld a,(0c422h)		;6d00   ; dando un latigazo?
	and a			;6d03
	jr nz,salto_mira_el_suelo		;6d04
	ld d,000h		;6d06   ; no: la pose del salto
	ld e,006h		;6d08
	ld (0c42eh),de		;6d0a   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	push hl			;6d0e
	call pose_segun_el_lado		;6d0f   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	pop hl			;6d12
salto_mira_el_suelo:
	ld a,(hl)			;6d13   ; antes del paso 9...
	cp 009h		;6d14
	ret c			;6d16   ; ... sube: nada mas
	ld de,0cff0h		;6d17   ; sin aterrizaje fuerte, de momento
	xor a			;6d1a
	ld (de),a			;6d1b
	ld a,(hl)			;6d1c   ; pasado el final de la curva...
	dec a			;6d1d
	dec a			;6d1e
	cp 013h		;6d1f
	push hl			;6d21
	call nc,cae_de_verdad		;6d22   ; ... cae de verdad
	pop hl			;6d25
	call mira_el_suelo		;6d26   ; suelo?
	jr c,aterriza		;6d29
	ld a,(0c439h)		;6d2b   ; plataforma?
	and a			;6d2e
	ret z			;6d2f   ; nada: sigue
aterriza:
	ld a,(0cff0h)		;6d30   ; tras caer de verdad...
	and a			;6d33
	jr z,de_pie_otra_vez		;6d34
	ld a,007h		;6d36   ; ... el efecto 7
	call 0509fh		;6d38   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
de_pie_otra_vez:
	ld hl,0c425h		;6d3b   ; la y en la rejilla de 8...
	ld a,(hl)			;6d3e
	and 0f8h		;6d3f
	ld (hl),a			;6d41
	xor a			;6d42   ; ... y al estado 0
	ld (0c420h),a		;6d43
	ld (0c421h),a		;6d46
	ld (0c428h),a		;6d49
	ret			;6d4c
aplica_la_curva:
	inc (hl)			;6d4d   ; APLICA LA CURVA: la cuenta sube...
	ld a,(hl)			;6d4e
	cp d			;6d4f   ; ... hasta D
	jr c,L_6D53		;6d50
	ld a,d			;6d52
L_6D53:
	dec a			;6d53   ; el paso de la tabla de BC...
	ld h,b			;6d54
	ld l,c			;6d55
	call 04061h		;6d56   ; hl_mas_a: HL += A
	ld a,(0c425h)		;6d59   ; ... a la y de Simon
	add a,(hl)			;6d5c
	ld (0c425h),a		;6d5d   ; guarda la Y de Simon
	ret			;6d60
salto_a_la_izquierda:
	call anda_a_la_izquierda		;6d61   ; subestado 2: anda a la izquierda y sigue la curva
	jp salto_recto		;6d64
salto_a_la_derecha:
	call anda_a_la_derecha		;6d67   ; subestado 3: a la derecha
	jp salto_recto		;6d6a
cae_de_verdad:
	ld a,001h		;6d6d   ; se apunta (0xCFF0 = 1)
	ld (de),a			;6d6f
	ld a,(0c420h)		;6d70   ; en el estado 1, nada mas
	dec a			;6d73
	ret z			;6d74
	push af			;6d75   ; en los otros: de lado...
	ld a,(hl)			;6d76   ; ... (la cuenta - 0x13) * 8...
	sub 013h		;6d77
	add a,a			;6d79
	add a,a			;6d7a
	add a,a			;6d7b
	ld e,a			;6d7c
	pop af			;6d7d
	dec a			;6d7e   ; ... en el 2, a la derecha...
	jr z,de_lado_a_la_derecha		;6d7f
	dec a			;6d81
	ld a,e			;6d82   ; ... y en el 3, a la izquierda
	neg		;6d83
	ld d,0ffh		;6d85
	ld e,a			;6d87
	jr suma_de_lado		;6d88
de_lado_a_la_derecha:
	ld d,000h		;6d8a
suma_de_lado:
	ld hl,(0c426h)		;6d8c   ; x += DE
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


simon_agachado:
	call 085f4h		;6da9   ; ESTADO 2: con 0x85F4...
	jr nc,sigue_agachado		;6dac
	ld a,(0c006h)		;6dae   ; ... y el segundo disparo recien pulsado...
	and 020h		;6db1
	jr z,sigue_agachado		;6db3
	ld a,007h		;6db5   ; ... al estado 7...
	ld (0c420h),a		;6db7
	xor a			;6dba
	ld (0c421h),a		;6dbb
	ld a,040h		;6dbe   ; ... 0x40 cuadros...
	ld (0c42dh),a		;6dc0
	ld a,015h		;6dc3   ; ... y el efecto 0x15
	jp 0509fh		;6dc5   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
sigue_agachado:
	ld a,(0c439h)		;6dc8   ; sobre una plataforma...
	and a			;6dcb   ; ... se mueve con ella
	call nz,con_la_plataforma		;6dcc
	ld a,(0c422h)		;6dcf   ; dando un latigazo: nada mas
	and a			;6dd2
	ret nz			;6dd3
	ld a,(0c007h)		;6dd4   ; abajo aun pulsado...
	rra			;6dd7
	rra			;6dd8
	ret c			;6dd9   ; ... sigue agachado
	jp fuera_de_la_escalera		;6dda   ; si no, de pie

; ----------------------------------------------------------------------
; LA ESCALERA (estado 3). El subestado dice como va: 0, subiendo a la izquierda; 1, subiendo a la derecha. Cada cuadro un punto en diagonal (0x100 en y y en x) por la tecla que se pulse (o la que sigue en 0xC435 hasta completar ocho puntos); poses 3 y 1 hacia la derecha, 0x0D y 0x10 hacia la izquierda; al cabo de ocho, si hay suelo, se sale (estado 0).
; ----------------------------------------------------------------------
simon_en_la_escalera:
	ld a,(0c422h)		;6ddd   ; dando un latigazo: nada
	and a			;6de0
	ret nz			;6de1
	ld a,(0c435h)		;6de2   ; un paso a medias (0xC435)...
	and a			;6de5
	jr nz,la_tecla_de_la_escalera		;6de6
	ld a,(0c007h)		;6de8   ; ... si no, los mandos
la_tecla_de_la_escalera:
	ld b,a			;6deb
	ld de,00100h		;6dec   ; un punto por cuadro
	ld a,(0c421h)		;6def   ; subiendo a la derecha?
	and a			;6df2
	ld a,b			;6df3
	jr nz,escalera_a_la_derecha		;6df4
	rra			;6df6   ; subiendo a la izquierda: arriba...
	jp c,sube_a_la_izquierda		;6df7   ; ... sube a la izquierda
	rra			;6dfa   ; abajo...
	jp c,baja_a_la_derecha		;6dfb   ; ... baja a la derecha
	rra			;6dfe   ; izquierda: sube
	jp c,sube_a_la_izquierda		;6dff
	rra			;6e02   ; derecha: baja
	jp c,baja_a_la_derecha		;6e03
	ret			;6e06
escalera_a_la_derecha:
	rra			;6e07   ; arriba: sube a la derecha
	jr c,sube_a_la_derecha		;6e08
	rra			;6e0a   ; abajo: baja a la izquierda
	jr c,baja_a_la_izquierda		;6e0b
	rra			;6e0d   ; izquierda: baja
	jr c,baja_a_la_izquierda		;6e0e
	rra			;6e10   ; derecha: sube
	jr c,sube_a_la_derecha		;6e11
	ret			;6e13
baja_a_la_derecha:
	ld hl,(0c424h)		;6e14   ; y + 1...
	add hl,de			;6e17
	ld (0c424h),hl		;6e18   ; guarda la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	ld hl,(0c426h)		;6e1b   ; ... x + 1
	add hl,de			;6e1e
	ld (0c426h),hl		;6e1f   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	xor a			;6e22   ; mira a la derecha
	ld (0c42ch),a		;6e23   ; guarda el lado al que mira Simon (0 derecha)
	ld de,00103h		;6e26   ; poses 3 y 1
	ld (0c42eh),de		;6e29   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	call paso_de_bajada		;6e2d   ; el paso
	ld hl,0c42bh		;6e30   ; un punto mas
	inc (hl)			;6e33
	ld a,(hl)			;6e34
	ld b,a			;6e35
	and 007h		;6e36   ; a mitad de los ocho...
	ld a,008h		;6e38   ; ... sigue a la derecha (0xC435 = 8)
	jr nz,L_6E3D		;6e3a
	xor a			;6e3c   ; ... y al completarlos, libre
L_6E3D:
	ld (0c435h),a		;6e3d
	ld a,b			;6e40   ; tras ocho puntos...
	cp 008h		;6e41
	ret c			;6e43
	call mira_el_suelo		;6e44   ; ... con suelo, fuera
	ret nc			;6e47
	jp fuera_de_la_escalera		;6e48
baja_a_la_izquierda:
	or a			;6e4b
	ld hl,(0c424h)		;6e4c   ; y + 1...
	add hl,de			;6e4f
	ld (0c424h),hl		;6e50   ; guarda la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	ld hl,(0c426h)		;6e53   ; ... x - 1
	sbc hl,de		;6e56
	ld (0c426h),hl		;6e58   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	ld a,001h		;6e5b   ; mira a la izquierda
	ld (0c42ch),a		;6e5d   ; guarda el lado al que mira Simon (0 derecha)
	ld de,0100dh		;6e60   ; poses 0x0D y 0x10
	ld (0c42eh),de		;6e63   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	call paso_de_bajada		;6e67
	ld hl,0c42bh		;6e6a   ; un punto mas
	inc (hl)			;6e6d
	ld a,(hl)			;6e6e
	ld b,a			;6e6f
	and 007h		;6e70
	ld a,004h		;6e72   ; sigue a la izquierda (0xC435 = 4)
	jr nz,L_6E77		;6e74
	xor a			;6e76
L_6E77:
	ld (0c435h),a		;6e77
	ld a,b			;6e7a   ; tras ocho...
	cp 008h		;6e7b
	ret c			;6e7d
	call mira_el_suelo		;6e7e   ; ... con suelo, fuera
	ret nc			;6e81
	jr fuera_de_la_escalera		;6e82
sube_a_la_derecha:
	or a			;6e84
	ld hl,(0c424h)		;6e85   ; y - 1...
	sbc hl,de		;6e88
	ld (0c424h),hl		;6e8a   ; guarda la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	ld hl,(0c426h)		;6e8d   ; ... x + 1
	add hl,de			;6e90
	ld (0c426h),hl		;6e91   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	xor a			;6e94   ; mira a la derecha
	ld (0c42ch),a		;6e95   ; guarda el lado al que mira Simon (0 derecha)
	ld de,00103h		;6e98   ; poses 3 y 1
	ld (0c42eh),de		;6e9b   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	call paso_de_subida		;6e9f
	ld hl,0c42bh		;6ea2   ; un punto mas
	inc (hl)			;6ea5
	ld a,(hl)			;6ea6
	ld b,a			;6ea7
	and 007h		;6ea8
	ld a,008h		;6eaa   ; sigue a la derecha
	jr nz,escalera_libre_1		;6eac
	xor a			;6eae
escalera_libre_1:
	ld (0c435h),a		;6eaf
	ld a,b			;6eb2   ; tras ocho...
	cp 008h		;6eb3
	ret c			;6eb5
	call pared_bajo_los_pies		;6eb6   ; ... arriba del todo, fuera
	ret nc			;6eb9
	jr fuera_de_la_escalera		;6eba
sube_a_la_izquierda:
	or a			;6ebc
	ld hl,(0c424h)		;6ebd   ; y - 1...
	sbc hl,de		;6ec0
	ld (0c424h),hl		;6ec2   ; guarda la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)
	or a			;6ec5
	ld hl,(0c426h)		;6ec6   ; ... x - 1
	sbc hl,de		;6ec9
	ld (0c426h),hl		;6ecb   ; guarda la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)
	ld a,001h		;6ece   ; mira a la izquierda
	ld (0c42ch),a		;6ed0   ; guarda el lado al que mira Simon (0 derecha)
	ld de,0100dh		;6ed3   ; poses 0x0D y 0x10
	ld (0c42eh),de		;6ed6   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	call paso_de_subida		;6eda
	ld hl,0c42bh		;6edd   ; un punto mas
	inc (hl)			;6ee0
	ld a,(hl)			;6ee1
	ld b,a			;6ee2
	and 007h		;6ee3
	ld a,004h		;6ee5   ; sigue a la izquierda
	jr nz,escalera_libre_2		;6ee7
	xor a			;6ee9
escalera_libre_2:
	ld (0c435h),a		;6eea
	ld a,b			;6eed   ; tras ocho...
	cp 008h		;6eee
	ret c			;6ef0
	call pared_bajo_los_pies		;6ef1   ; ... arriba del todo, fuera
	ret nc			;6ef4
fuera_de_la_escalera:
	ld de,00000h		;6ef5   ; de pie...
	ld (0c42eh),de		;6ef8   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	xor a			;6efc   ; sin tecla que siga...
	ld (0c435h),a		;6efd
	ld (0c42bh),a		;6f00   ; ... ni puntos contados
	call pose_segun_el_lado		;6f03   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	jp de_pie_otra_vez		;6f06
paso_de_bajada:
	ld a,(0c42bh)		;6f09   ; cada cuatro puntos...
	rra			;6f0c
	rra			;6f0d
	and 001h		;6f0e   ; ... uno de dos pasos: las piernas +1 o +0...
	ld c,a			;6f10
	neg		;6f11
	inc a			;6f13
	ld b,a			;6f14
	ld a,(0c42eh)		;6f15   ; lee la pose de las piernas de Simon
	add a,b			;6f18
	ld (0c42eh),a		;6f19   ; guarda la pose de las piernas de Simon
	ld a,(0c42fh)		;6f1c   ; ... y el cuerpo +0 o +1
	add a,c			;6f1f
	ld (0c42fh),a		;6f20   ; guarda la pose del cuerpo de Simon
	ret			;6f23
paso_de_subida:
	ld a,(0c42bh)		;6f24   ; cada cuatro puntos...
	rra			;6f27
	rra			;6f28
	and 001h		;6f29   ; ... las piernas +1 o +2...
	ld c,a			;6f2b
	inc a			;6f2c
	ld b,a			;6f2d
	ld a,(0c42eh)		;6f2e   ; lee la pose de las piernas de Simon
	add a,b			;6f31
	ld (0c42eh),a		;6f32   ; guarda la pose de las piernas de Simon
	ld a,(0c42fh)		;6f35   ; ... y el cuerpo +0 o +1
	add a,c			;6f38
	ld (0c42fh),a		;6f39   ; guarda la pose del cuerpo de Simon
	ret			;6f3c
simon_cae:
	ld a,(0c439h)		;6f3d   ; ESTADO 4: sobre una plataforma...
	and a			;6f40
	jr nz,aterriza_de_la_caida		;6f41
	call mira_el_suelo		;6f43   ; ... o con suelo, aterriza
	jr c,aterriza_de_la_caida		;6f46
	ld de,00000h		;6f48   ; de pie mientras cae
	ld (0c42eh),de		;6f4b   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	call pose_segun_el_lado		;6f4f   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	ld hl,0c428h		;6f52   ; la cuenta, hasta 3...
	ld a,(hl)			;6f55
	inc (hl)			;6f56
	cp 003h		;6f57
	jr c,L_6F5C		;6f59
	dec (hl)			;6f5b
L_6F5C:
	ld hl,06f81h		;6f5c   ; ... elige cuanto baja, de 0x6F81
	call 04061h		;6f5f   ; hl_mas_a: HL += A
	ld a,(0c425h)		;6f62   ; lee la Y de Simon
	add a,(hl)			;6f65
	ld (0c425h),a		;6f66   ; guarda la Y de Simon
	ret			;6f69
aterriza_de_la_caida:
	ld a,(0c425h)		;6f6a   ; la y en la rejilla de 8...
	and 0f8h		;6f6d
	ld (0c425h),a		;6f6f   ; guarda la Y de Simon
	xor a			;6f72   ; ... al estado 0...
	ld (0c428h),a		;6f73
	ld (0c420h),a		;6f76
	ld (0c421h),a		;6f79
	ld a,007h		;6f7c   ; ... y el efecto 7
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



; ----------------------------------------------------------------------
; GOLPEADO (estado 5, por el paso de 0xC423): 0, el efecto 0x13 y 0x5A cuadros de respiro (0xC42D); en la escalera y con vida, sigue en ella con el cuerpo en la pose 2; si no, sale despedido hacia atras (1 a la izquierda, 2 a la derecha, por el lado del golpe 0xC43C) con la curva de 0x707D; 3, en el suelo 4 cuadros (0x10 sin vida) y vuelve de pie mirando al otro lado; sin vida, al estado 6.
; ----------------------------------------------------------------------
simon_golpeado:
	ld a,(0c423h)		;6f85   ; por su paso
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


golpe_empieza:
	ld a,(0c002h)		;6f93   ; en una partida...
	and 040h		;6f96
	ld a,013h		;6f98   ; ... el efecto 0x13
	call nz,0509fh		;6f9a   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,05ah		;6f9d   ; 0x5A cuadros de respiro
	ld (0c42dh),a		;6f9f
	ld a,(0c42bh)		;6fa2   ; en la escalera...
	and a			;6fa5
	jp z,despedido		;6fa6
	ld a,(0c415h)		;6fa9   ; ... y con vida...
	and a			;6fac
	jr z,despedido		;6fad
	ld a,003h		;6faf   ; ... sigue en ella...
	ld (0c420h),a		;6fb1
	ld a,002h		;6fb4   ; ... con el cuerpo en la pose 2
	ld (0c42fh),a		;6fb6   ; guarda la pose del cuerpo de Simon
	jp pose_segun_el_lado		;6fb9   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
despedido:
	ld a,(0c43ch)		;6fbc   ; mira al lado del golpe...
	ld (0c42ch),a		;6fbf   ; guarda el lado al que mira Simon (0 derecha)
	inc a			;6fc2   ; ... y sale hacia atras: paso 1 o 2
	ld (0c423h),a		;6fc3
	xor a			;6fc6   ; desde el principio de la curva
	ld (0c42ah),a		;6fc7
	ld de,00307h		;6fca   ; poses 7 y 3
	ld (0c42eh),de		;6fcd   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	jp pose_segun_el_lado		;6fd1   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
despedido_a_la_izquierda:
	call anda_a_la_izquierda		;6fd4   ; paso 1: hacia la izquierda
curva_del_golpe:
	ld bc,0707dh		;6fd7   ; la curva de 0x707D, 0x15 pasos
	ld d,015h		;6fda
	ld hl,0c42ah		;6fdc
	push hl			;6fdf
	call aplica_la_curva		;6fe0   ; aplica_la_curva: sube la cuenta de (HL) hasta D y suma a la y de Simon el paso de la curva de BC
	pop hl			;6fe3
	ld a,(hl)			;6fe4   ; hasta el paso 0x0B...
	cp 00bh		;6fe5
	ret c			;6fe7   ; ... sube: nada mas
	call mira_el_suelo		;6fe8   ; suelo?
	jr c,cae_del_golpe		;6feb
	ld a,(0c439h)		;6fed   ; plataforma?
	and a			;6ff0
	ret z			;6ff1
cae_del_golpe:
	ld a,(0c425h)		;6ff2   ; la y en la rejilla de 8
	and 0f8h		;6ff5
	ld (0c425h),a		;6ff7   ; guarda la Y de Simon
	ld a,003h		;6ffa   ; paso 3...
	ld (0c423h),a		;6ffc
	ld a,(0c415h)		;6fff   ; ... 4 cuadros en el suelo...
	and a			;7002
	ld a,004h		;7003
	jr nz,L_7009		;7005
	ld a,010h		;7007   ; ... o 0x10 sin vida
L_7009:
	ld (0c42ah),a		;7009
	ld de,(0c42eh)		;700c   ; las poses siguientes
	inc d			;7010
	inc e			;7011
	ld (0c42eh),de		;7012   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	ret			;7016
despedido_a_la_derecha:
	call anda_a_la_derecha		;7017   ; paso 2: hacia la derecha
	jp curva_del_golpe		;701a
golpe_en_el_suelo:
	ld a,(0c439h)		;701d   ; paso 3: sobre una plataforma, con ella
	and a			;7020
	call nz,con_la_plataforma		;7021
	ld hl,0c42ah		;7024   ; al acabar la cuenta...
	dec (hl)			;7027
	ret nz			;7028
	xor a			;7029   ; ... todo a cero: estado 0
	ld (0c420h),a		;702a
	ld (0c421h),a		;702d
	ld (0c423h),a		;7030
	ld (0c422h),a		;7033
	ld (0c42ah),a		;7036
	ld (0c428h),a		;7039
	ld a,(0c5ach)		;703c   ; con la puerta de la fase en 2, 3 o 5...
	cp 002h		;703f
	jr z,sin_vida		;7041
	cp 003h		;7043
	jr z,sin_vida		;7045
	cp 005h		;7047
	jr z,sin_vida		;7049
	ld a,(0c42ch)		;704b   ; ... no; si no, mira al otro lado
	xor 001h		;704e
	ld (0c42ch),a		;7050   ; guarda el lado al que mira Simon (0 derecha)
sin_vida:
	ld a,(0c415h)		;7053   ; le queda vida?
	and a			;7056
	ret nz			;7057
	ld hl,0c427h		;7058   ; no: separado del borde izquierdo...
	ld a,(hl)			;705b
	cp 010h		;705c
	jr nc,a_morir		;705e
	add a,008h		;7060
	ld (hl),a			;7062
a_morir:
	xor a			;7063   ; ... al estado 6
	ld (0c42dh),a		;7064
	ld (0c421h),a		;7067
	inc a			;706a
	ld (0c428h),a		;706b
	ld a,006h		;706e
	ld (0c420h),a		;7070
	ld bc,00509h		;7073   ; poses 9 y 5
	ld (0c42eh),bc		;7076   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
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



; ----------------------------------------------------------------------
; MUERE (estado 6): subestado 0, al acabar la cuenta, silencio, la musica 0x89 y 0x5A cuadros; subestado 1, al acabarlos, los corazones a 5 como mucho, todo lo de Simon a cero, la habitacion 0 y la vida acabada (0xC413); y pierde las armas y lo que lleva, salvo el pergamino (bit 7 de 0xC701).
; ----------------------------------------------------------------------
simon_muere:
	ld a,(0c421h)		;7093   ; subestado 1?
	ld hl,0c428h		;7096
	and a			;7099
	jr nz,se_acabo_la_vida		;709a
	dec (hl)			;709c   ; subestado 0: la cuenta
	ret nz			;709d
	ld (hl),05ah		;709e   ; 0x5A cuadros...
	ld a,001h		;70a0   ; ... subestado 1...
	ld (0c421h),a		;70a2
	ld a,000h		;70a5   ; ... silencio...
	call 0509fh		;70a7   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,089h		;70aa   ; ... y la musica 0x89
	jp 0509fh		;70ac   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
se_acabo_la_vida:
	ld hl,0c428h		;70af   ; al acabar la cuenta...
	dec (hl)			;70b2
	ret nz			;70b3
	ld de,0c417h		;70b4   ; ... los corazones, como mucho 5
	ld a,(de)			;70b7
	cp 005h		;70b8
	jr c,todo_a_cero		;70ba
	ld a,005h		;70bc
	ld (de),a			;70be
todo_a_cero:
	xor a			;70bf   ; la cuenta, los estados...
	ld (hl),a			;70c0
	ld (0c421h),a		;70c1
	ld (0c422h),a		;70c4
	ld (0c434h),a		;70c7
	ld (0c43ah),a		;70ca   ; guarda la cuenta de la INVENCIBILIDAD
	ld (0c43bh),a		;70cd
	ld (0c440h),a		;70d0
	ld (0d010h),a		;70d3
	ld (0d001h),a		;70d6   ; la habitacion 0
	ld (0c413h),a		;70d9   ; y la vida acabada
pierde_lo_que_lleva:
	ld a,(0c701h)		;70dc   ; solo se queda el pergamino
	and 080h		;70df
	ld (0c701h),a		;70e1   ; guarda lo que lleva Simon (un bit por objeto)
	xor a			;70e4   ; sin arma...
	ld (0c416h),a		;70e5   ; guarda el arma que lleva Simon (0, ninguna)
	ld (0c431h),a		;70e8   ; ... sin botas, alas ni lazo (0xC431)...
	ld (0c432h),a		;70eb
	ld (0c441h),a		;70ee   ; guarda los usos que le quedan a lo que para golpes
	ld (0c442h),a		;70f1
	ld (0c702h),a		;70f4   ; ... ni lo de 0xC702 ni 0xC700
	ld (0c700h),a		;70f7
	ret			;70fa

; ----------------------------------------------------------------------
; POR UN PASO (estado 7, desde agachado sobre un paso con el salto, p01:6DA9): al acabar los cuadros de 0xC42D, de pie y a la habitacion del paso (0xC41B = 0xFF, que p13:B963 manda a la de 0xC5B4).
; ----------------------------------------------------------------------
simon_por_un_paso:
	ld a,(0c42dh)		;70fb   ; espera
	and a			;70fe
	ret nz			;70ff
	xor a			;7100   ; de pie
	ld (0c420h),a		;7101
	ld (0c43dh),a		;7104
	ld a,0ffh		;7107   ; y se va por el paso
	ld (0c41bh),a		;7109   ; guarda el lado por el que se sale de la habitacion
	ret			;710c

; ----------------------------------------------------------------------
; EL LATIGO Y LAS ARMAS, cada cuadro: el primer disparo, el golpe en marcha y las armas lanzadas.
; ----------------------------------------------------------------------
latigo_y_armas:
	call mandos_del_golpe		;710d   ; los mandos
	call el_golpe		;7110   ; el golpe
	jp las_armas_lanzadas		;7113   ; las armas lanzadas
mandos_del_golpe:
	ld a,(0c006h)		;7116   ; el primer disparo recien pulsado?
	and 010h		;7119
	jr z,saltando_con_objetos		;711b
	ld hl,0c422h		;711d   ; ya golpeando: nada
	ld a,(hl)			;7120
	and a			;7121
	ret nz			;7122
	ld a,(0c416h)		;7123   ; con que arma
	ld (0c436h),a		;7126
	cp 002h		;7129   ; el latigo (0 y 1)...
	jr c,empieza_el_golpe		;712b
	call sitio_para_el_arma		;712d   ; ... si no, hay sitio para lanzarla?
	ld a,b			;7130
	and a			;7131   ; no: nada
	ret z			;7132
empieza_el_golpe:
	ld (hl),001h		;7133   ; 0xC422 = 1: golpeando
	ret			;7135
saltando_con_objetos:
	ld a,(0c420h)		;7136   ; solo saltando (estado 1)
	dec a			;7139
	ret nz			;713a
	ld a,(0c701h)		;713b   ; lo que lleva...
	push af			;713e
	rra			;713f   ; ... el bit 3 (el frasco, p02:8D8D)...
	rra			;7140
	rra			;7141
	rra			;7142
	call c,con_el_bit_3		;7143
	pop af			;7146
	rla			;7147   ; ... el bit 6
	rla			;7148
	call c,el_reloj		;7149
	ret			;714c

; ----------------------------------------------------------------------
; CON EL BIT 3 DE 0xC701, saltando y con 5 corazones: izquierda o derecha recien pulsadas gastan 5 corazones, ponen el bit 0 en las cosas con el bit 2 (0x999F) y 0xC461 a 5 (0xC468: 1 a la izquierda, 0 a la derecha).
; ----------------------------------------------------------------------
con_el_bit_3:
	ld a,(0c417h)		;714d   ; 5 corazones?
	cp 005h		;7150
	ret c			;7152
	ld a,(0c006h)		;7153   ; izquierda recien pulsada...
	rra			;7156
	rra			;7157
	rra			;7158
	jr c,bit_3_a_la_izquierda		;7159
	rra			;715b   ; ... o derecha
	jr c,bit_3_a_la_derecha		;715c
	ret			;715e

; ----------------------------------------------------------------------
; EL RELOJ (bit 6 de 0xC701): saltando, abajo recien pulsado y 5 corazones: los gasta y para el tiempo (0xD010) 0x5A cuadros (0x96 con el lazo), efecto 0xFB; p01:75F2 lo devuelve.
; ----------------------------------------------------------------------
el_reloj:
	ld a,(0c43bh)		;715f   ; ya parado?
	and a			;7162
	ret nz			;7163
	ld a,(0c417h)		;7164   ; 5 corazones?
	cp 005h		;7167
	ret c			;7169
	ld a,(0c006h)		;716a   ; abajo recien pulsado?
	rra			;716d
	rra			;716e
	ret nc			;716f
	ld a,(0c417h)		;7170   ; 5 corazones menos
	sub 005h		;7173
	daa			;7175
	ld (0c417h),a		;7176   ; guarda los corazones, en BCD
	call 04566h		;7179
	ld a,(0c431h)		;717c   ; con el lazo...
	and 004h		;717f
	ld a,096h		;7181   ; ... 0x96 cuadros...
	jr nz,L_7187		;7183
	ld a,05ah		;7185   ; ... si no, 0x5A
L_7187:
	ld (0c43bh),a		;7187
	ld hl,0d010h		;718a   ; el tiempo parado
	set 0,(hl)		;718d
	ld a,0fbh		;718f   ; efecto 0xFB
	jp 0509fh		;7191   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
bit_3_a_la_izquierda:
	ld a,(0c461h)		;7194   ; en marcha ya (0xC461)?
	and a			;7197
	ret nz			;7198
	ld a,001h		;7199   ; a la izquierda
	ld (0c468h),a		;719b
	jp bit_3_gasta		;719e
bit_3_a_la_derecha:
	ld a,(0c461h)		;71a1
	and a			;71a4
	ret nz			;71a5
	xor a			;71a6   ; a la derecha
	ld (0c468h),a		;71a7
bit_3_gasta:
	call 0999fh		;71aa   ; el bit 0 en las cosas
	ld a,005h		;71ad   ; 0xC461 a 5
	ld (0c461h),a		;71af
	ld a,(0c417h)		;71b2   ; 5 corazones menos
	sub 005h		;71b5
	daa			;71b7
	ld (0c417h),a		;71b8   ; guarda los corazones, en BCD
	jp 04566h		;71bb
sitio_para_el_arma:
	ld a,(0c436h)		;71be   ; el arma 2 deja dos a la vez...
	cp 002h		;71c1
	ld b,002h		;71c3
	jr z,L_71C8		;71c5
	dec b			;71c7   ; ... las demas, una
L_71C8:
	ld ix,0c450h		;71c8   ; las dos fichas de 0xC450
ficha_de_arma_libre:
	ld a,(ix+001h)		;71cc   ; libre?
	and a			;71cf
	jr nz,ficha_de_arma_siguiente		;71d0
	ld a,001h		;71d2   ; si: apartada (1)
	ld (ix+000h),a		;71d4
	ret			;71d7
ficha_de_arma_siguiente:
	ld de,00010h		;71d8   ; la siguiente, 16 bytes mas
	add ix,de		;71db
	djnz ficha_de_arma_libre		;71dd
	ret			;71df
el_golpe:
	ld a,(0c422h)		;71e0   ; golpeando?
	and a			;71e3
	ret z			;71e4
	ld a,(0c420h)		;71e5   ; no cayendo ni golpeado (estados 0-3)
	cp 004h		;71e8
	ret nc			;71ea
	ld a,(0c422h)		;71eb   ; por su paso
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


golpe_paso_1:
	ld a,(0c420h)		;71fa   ; paso 1: en la escalera, las piernas como van
	cp 003h		;71fd
	jr z,golpe_el_cuerpo		;71ff
	cp 002h		;7201   ; agachado, la 6; si no, la 0
	ld a,000h		;7203
	jr nz,L_7209		;7205
	ld a,006h		;7207
L_7209:
	ld (0c42eh),a		;7209   ; guarda la pose de las piernas de Simon
golpe_el_cuerpo:
	ld a,(0c436h)		;720c   ; con el latigo...
	cp 002h		;720f
	jr nc,golpe_con_arma		;7211
	ld a,(0c436h)		;7213   ; ... sin arma (el de cuero), el cuerpo en la 6...
	dec a			;7216
	ld a,006h		;7217
	jr nz,L_721D		;7219
	ld a,009h		;721b   ; ... con el de cadena (el arma 1), en la 9
L_721D:
	ld (0c42fh),a		;721d   ; guarda la pose del cuerpo de Simon
	call pose_segun_el_lado		;7220   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	ld a,005h		;7223   ; el efecto 5
	call 0509fh		;7225   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jr $+19		;7228
golpe_con_arma:
	call 05593h		;722a   ; los patrones del arma...
	ld a,00ch		;722d   ; ... y el cuerpo en la 0x0C
	ld (0c42fh),a		;722f   ; guarda la pose del cuerpo de Simon
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


golpe_cuenta:
	ld (0c429h),a		;7238   ; la cuenta del golpe
golpe_paso_siguiente:
	ld hl,0c422h		;723b   ; el paso siguiente del golpe
	inc (hl)			;723e
	ret			;723f
golpe_paso_2:
	ld hl,0c42fh		;7240   ; paso 2: el cuerpo, la pose siguiente
	inc (hl)			;7243
	call golpe_paso_siguiente		;7244
	ld a,(0c436h)		;7247
	cp 002h		;724a
	ret c			;724c
	jp 05593h		;724d
golpe_paso_3:
	ld a,(0c436h)		;7250   ; paso 3: con arma, como el 2
	cp 002h		;7253
	jr nc,golpe_paso_2		;7255
	call 0999fh		;7257   ; con el latigo: el bit 0 en las cosas...
	ld hl,0c42fh		;725a   ; ... la pose siguiente...
	inc (hl)			;725d
	ld a,004h		;725e   ; ... y 4 cuadros
	jr golpe_cuenta		;7260
golpe_paso_4:
	ld a,(0c436h)		;7262   ; paso 4: con arma, a lanzarla
	cp 002h		;7265
	jr nc,lanza_el_arma		;7267
	ld hl,0c429h		;7269   ; con el latigo, la cuenta
	dec (hl)			;726c
	ret nz			;726d
acaba_el_golpe:
	xor a			;726e   ; sin golpe
	ld (0c422h),a		;726f
	ld (0c429h),a		;7272
	ld a,(0c420h)		;7275   ; el cuerpo: en la escalera la 2...
	cp 003h		;7278
	ld a,000h		;727a   ; ... si no, la 0
	jr nz,L_7280		;727c
	ld a,002h		;727e
L_7280:
	ld (0c42fh),a		;7280   ; guarda la pose del cuerpo de Simon
	jp pose_segun_el_lado		;7283   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
lanza_el_arma:
	call 0999fh		;7286   ; el bit 0 en las cosas
	call acaba_el_golpe		;7289   ; acaba el golpe
	ld ix,0c450h		;728c   ; la ficha apartada...
	ld b,002h		;7290
busca_la_apartada:
	ld a,(ix+000h)		;7292   ; apartada (1)?
	dec a			;7295
	jr nz,arma_siguiente		;7296
	ld a,018h		;7298   ; 0x18...
	ld (ix+006h),a		;729a
	ld a,(0c42ch)		;729d   ; ... el lado...
	ld (ix+008h),a		;72a0
	ld a,(0c436h)		;72a3   ; ... y el arma
	ld (ix+001h),a		;72a6
	ret			;72a9
arma_siguiente:
	ld de,00010h		;72aa
	add ix,de		;72ad
	djnz busca_la_apartada		;72af
	ret			;72b1

; ----------------------------------------------------------------------
; LAS ARMAS LANZADAS: dos fichas de 16 bytes en 0xC450 y 0xC460 ([0] el paso, 1 apartada; [1] el arma; [2] y [3] lo que se suma cada cuadro a la y y a la x; [4] la y; [5] la x; [6] el patron; [7] la cuenta; [8] el lado), cada una con dos sprites (6-7 y 8-9 en la copia de 0xD600) y sus colores en 0xD460/0xD480. El hacha (3) y la cruz (4) van y vuelven por la misma tabla (0x72FF = 0x749D).
; ----------------------------------------------------------------------
las_armas_lanzadas:
	ld ix,0c450h		;72b2   ; las dos fichas de 0xC450 y 0xC460
	call un_arma_lanzada		;72b6
	ld ix,0c460h		;72b9
un_arma_lanzada:
	ld a,(ix+001h)		;72bd   ; lanzada?
	and a			;72c0
	ret z			;72c1
	call mueve_el_arma		;72c2   ; se mueve...
	call mueve_el_arma_lanzada		;72c5   ; ... lo de 0x74BB...
	call fuera_si_se_sale_el_arma		;72c8   ; ... lo de 0x74CE...
	jp sprites_del_arma		;72cb   ; ... y lo de 0x7535
mueve_el_arma:
	ld a,(ix+001h)		;72ce   ; por el arma: 2 la daga (0x7436), 3 el hacha (0x7473), 4 la cruz (0x72DE), 5 el frasco (0x73A4)
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


la_cruz:
	ld a,(0c003h)		;72de   ; LA CRUZ: cada cuatro cuadros, el patron: 0x18, 0x20...
	ld c,a			;72e1
	rra			;72e2
	rra			;72e3
	and 003h		;72e4
	add a,a			;72e6
	add a,a			;72e7
	add a,a			;72e8
	add a,018h		;72e9
	ld (ix+006h),a		;72eb
	ld a,c			;72ee   ; cada ocho...
	and 007h		;72ef
	jr nz,L_72F8		;72f1
	ld a,003h		;72f3   ; ... el efecto 3
	call 0509fh		;72f5   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_72F8:
	ld a,(ix+000h)		;72f8   ; por su paso
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


la_cruz_sale:
	ld a,(0c420h)		;7307   ; paso 0: la altura...
	cp 002h		;730a
	ld a,(0c425h)		;730c   ; ... de pie, 0x10 por encima de Simon...
	ld b,0f0h		;730f
	jr nz,L_7315		;7311
	ld b,0f6h		;7313   ; ... agachado, 0x0A
L_7315:
	add a,b			;7315
	ld (ix+004h),a		;7316   ; a su y (byte 4)
	xor a			;7319
	ld (ix+002h),a		;731a   ; (byte 2 a 0)
	ld a,(ix+001h)		;731d   ; el arma (byte 1)...
	cp 003h		;7320
	ld b,003h		;7322   ; ... la 3, 3 por cuadro; la 4, 5...
	jr z,L_7328		;7324
	ld b,005h		;7326
L_7328:
	ld a,(ix+008h)		;7328   ; hacia donde (byte 8)
	and a			;732b
	ld a,b			;732c
	jr z,L_7331		;732d
	neg		;732f
L_7331:
	ld (ix+003h),a		;7331   ; a la velocidad horizontal (byte 3)
	ld a,(0c427h)		;7334   ; la x de Simon (byte 5)
	ld (ix+005h),a		;7337
	jp paso_siguiente_del_arma		;733a
va:
	ld a,(ix+005h)		;733d   ; paso 1: la x, lejos del borde?
	sub 00ah		;7340
	cp 0ech		;7342
	jr nc,salta_un_paso		;7344   ; no: se da la vuelta ya
	inc (ix+007h)		;7346   ; la cuenta...
	ld a,(ix+007h)		;7349
	cp 018h		;734c   ; ... hasta 0x18
	ret c			;734e
paso_siguiente_del_arma:
	inc (ix+000h)		;734f   ; el paso siguiente...
	ld (ix+007h),000h		;7352   ; ... la cuenta a 0...
	jp 0999fh		;7356   ; ... y el bit 0 en las cosas
salta_un_paso:
	inc (ix+000h)		;7359   ; dos pasos mas
da_la_vuelta:
	inc (ix+000h)		;735c   ; un paso mas: vuelve...
	ld a,(ix+008h)		;735f   ; ... hacia el otro lado, 5 por cuadro
	and a			;7362
	ld a,005h		;7363
	jr nz,L_7369		;7365
	ld a,0fbh		;7367
L_7369:
	ld (ix+003h),a		;7369   ; a la velocidad horizontal
	ld (ix+007h),000h		;736c   ; la cuenta a 0
	jp 0999fh		;7370
vuelve:
	call 08240h		;7373   ; paso 2: Simon la coge?
	jp c,quita_el_arma		;7376   ; si: se quita
	ld a,(ix+005h)		;7379   ; la x, lejos del borde?
	sub 00ah		;737c   ; (si no, da la vuelta)
	cp 0ech		;737e
	jr nc,da_la_vuelta		;7380
	inc (ix+007h)		;7382   ; la cuenta...
	ld a,(ix+007h)		;7385
	cp 017h		;7388   ; ... hasta 0x17
	jp nc,paso_siguiente_del_arma		;738a
	rra			;738d   ; uno de cada dos cuadros...
	ret nc			;738e
	ld a,(ix+008h)		;738f   ; ... sube o baja un punto segun el lado
	and a			;7392
	jr nz,baja_un_punto		;7393
	dec (ix+003h)		;7395
	ret			;7398
baja_un_punto:
	inc (ix+003h)		;7399
	ret			;739c
vuelve_y_se_coge:
	call 08240h		;739d   ; paso 3: Simon la coge?
	ret nc			;73a0
	jp quita_el_arma		;73a1   ; si: se quita
el_frasco:
	ld a,(ix+000h)		;73a4   ; EL FRASCO (arma 5), por su paso:
	dec a			;73a7   ; 2, cae...
	dec a			;73a8
	jr z,el_frasco_cae		;73a9
	dec a			;73ab   ; 3, arde
	jr z,el_frasco_arde		;73ac
	ld a,(0c420h)		;73ae   ; 1, sale: de pie...
	cp 002h		;73b1
	ld a,(0c425h)		;73b3   ; lee la Y de Simon
	ld b,0f0h		;73b6   ; ... 0x10 por encima de Simon...
	jr nz,L_73BC		;73b8
	ld b,0f6h		;73ba   ; ... agachado, 0x0A
L_73BC:
	add a,b			;73bc
	ld (ix+004h),a		;73bd   ; la y (byte 4)
	xor a			;73c0   ; sin velocidad vertical
	ld (ix+002h),a		;73c1
	ld a,(ix+008h)		;73c4   ; 2 por cuadro...
	and a			;73c7
	ld a,002h		;73c8
	jr z,L_73CE		;73ca   ; ... segun el lado
	ld a,0feh		;73cc
L_73CE:
	ld (ix+003h),a		;73ce   ; a la velocidad horizontal
	ld a,(0c427h)		;73d1   ; la x de Simon
	ld (ix+005h),a		;73d4
	ld (ix+006h),038h		;73d7   ; el patron 0x38
	jp paso_siguiente_del_arma		;73db
el_frasco_cae:
	ld a,(ix+007h)		;73de   ; la curva de 0x707D, por la cuenta...
	ld hl,0707dh		;73e1
	call 04061h		;73e4   ; hl_mas_a: HL += A
	ld c,(ix+004h)		;73e7
	ld a,(hl)			;73ea   ; ... por dos, a la y
	add a,a			;73eb
	add a,c			;73ec
	ld (ix+004h),a		;73ed
	inc (ix+007h)		;73f0   ; la cuenta, hasta 0x16
	ld a,(ix+007h)		;73f3
	cp 016h		;73f6
	jr c,L_73FD		;73f8
	dec (ix+007h)		;73fa
L_73FD:
	ld d,(ix+005h)		;73fd   ; en el decorado?
	ld e,(ix+004h)		;7400
	call choca_con_el_decorado		;7403   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
	ret nc			;7406   ; no: sigue
	inc (ix+000h)		;7407   ; si: paso 3, quieto...
	xor a			;740a
	ld (ix+002h),a		;740b
	ld (ix+003h),a		;740e
	ld (ix+007h),a		;7411
	ld a,018h		;7414   ; ... y el efecto 0x18
	jp 0509fh		;7416   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
el_frasco_arde:
	ld a,(0c003h)		;7419   ; cada cuatro cuadros...
	and 004h		;741c
	ld a,0f4h		;741e   ; ... el patron 0xF4...
	jr z,L_7427		;7420
	call 0999fh		;7422   ; ... o el bit 0 en las cosas y el 0xF8
	ld a,0f8h		;7425
L_7427:
	ld (ix+006h),a		;7427
	inc (ix+007h)		;742a   ; la cuenta...
	ld a,(ix+007h)		;742d
	cp 018h		;7430   ; ... hasta 0x18, y se quita
	ret c			;7432
	jp quita_el_arma		;7433
la_daga:
	ld a,(ix+000h)		;7436   ; LA DAGA (arma 2): solo al salir (paso 1)
	dec a			;7439
	ret nz			;743a
	ld a,(0c420h)		;743b   ; de pie...
	cp 002h		;743e
	ld a,(0c425h)		;7440   ; ... 0x10 por encima de Simon...
	ld b,0f0h		;7443
	jr nz,L_7449		;7445
	ld b,0f6h		;7447   ; ... agachado, 0x0A
L_7449:
	add a,b			;7449
	ld (ix+004h),a		;744a   ; la y
	xor a			;744d   ; sin velocidad vertical
	ld (ix+002h),a		;744e
	ld a,(ix+008h)		;7451   ; 5 por cuadro con el patron 0x20...
	and a			;7454
	ld a,005h		;7455
	ld b,020h		;7457
	jr z,L_745F		;7459
	ld a,0fbh		;745b   ; ... o -5 con el 0x18, segun el lado
	ld b,018h		;745d
L_745F:
	ld (ix+003h),a		;745f
	ld (ix+006h),b		;7462
	ld a,(0c427h)		;7465   ; la x de Simon
	ld (ix+005h),a		;7468
	inc (ix+000h)		;746b   ; paso 2...
	ld a,004h		;746e   ; ... y el efecto 4
	jp 0509fh		;7470   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
el_hacha:
	ld a,(0c003h)		;7473   ; EL HACHA (arma 3): cada dos cuadros, el patron: 0x18, 0x20, 0x28 o 0x30...
	ld c,a			;7476
	rra			;7477
	and 003h		;7478
	add a,a			;747a
	add a,a			;747b
	add a,a			;747c
	add a,018h		;747d
	ld (ix+006h),a		;747f
	ld a,c			;7482   ; ... cada ocho...
	and 007h		;7483
	jr nz,el_hacha_mira		;7485
	ld a,006h		;7487   ; ... el efecto 6
	call 0509fh		;7489   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
el_hacha_mira:
	ld hl,0c433h		;748c   ; con 0xC433 en 2 o 3...
	ld a,(hl)			;748f
	sub 002h		;7490
	cp 002h		;7492
	jr c,$+17		;7494
	ld a,(ix+000h)		;7496   ; si no, por su paso (la tabla de la cruz)
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


el_hacha_suelta:
	ld (hl),000h		;74a5   ; 0xC433 a 0
	ld b,01ch		;74a7   ; el hacha cae como objeto (0x1C)...
	ld d,(ix+005h)		;74a9   ; ... en su sitio...
	ld a,(ix+004h)		;74ac
	sub 010h		;74af
	ld e,a			;74b1
	call 08992h		;74b2   ; ... sale
	call quita_el_arma		;74b5   ; y el arma se quita
	jp 08e93h		;74b8
mueve_el_arma_lanzada:
	ld a,(ix+004h)		;74bb   ; y += byte 2
	add a,(ix+002h)		;74be
	ld (ix+004h),a		;74c1
	ld a,(ix+005h)		;74c4   ; x += byte 3
	add a,(ix+003h)		;74c7
	ld (ix+005h),a		;74ca
	ret			;74cd
fuera_si_se_sale_el_arma:
	ld a,(ix+004h)		;74ce   ; la y, de 0xD8 a 0xE7...
	sub 0d8h		;74d1
	cp 010h		;74d3
	jr c,quita_el_arma		;74d5   ; ... fuera
	ld a,(ix+005h)		;74d7   ; la x, de 0xFB a 0x04...
	sub 0fbh		;74da
	cp 00ah		;74dc
	ret nc			;74de   ; (si no, sigue)
	ld a,(0c416h)		;74df   ; con el hacha o la cruz...
	sub 003h		;74e2
	cp 002h		;74e4   ; ... lo de 0x8E93
	call c,08e93h		;74e6
quita_el_arma:
	push ix		;74e9   ; la ficha...
	pop hl			;74eb
quita_la_ficha:
	push hl			;74ec   ; ... a cero, 16 bytes
	ld (hl),000h		;74ed
	ld d,h			;74ef
	ld e,l			;74f0
	inc de			;74f1
	ld bc,0000fh		;74f2
	ldir		;74f5
	pop hl			;74f7
	ld a,l			;74f8   ; la de 0xC450...
	cp 050h		;74f9
	ld a,0e0h		;74fb   ; ... sus sprites 6 y 7 fuera...
	jr nz,sprites_8_y_9_fuera		;74fd
	ld (0d618h),a		;74ff
	ld (0d61ch),a		;7502
	jr y_fuera		;7505
sprites_8_y_9_fuera:
	ld (0d620h),a		;7507   ; ... o, la de 0xC460, los 8 y 9
	ld (0d624h),a		;750a
y_fuera:
	inc l			;750d   ; y la y 0xE0 en la ficha (byte 4)
	inc l			;750e
	inc l			;750f
	inc l			;7510
	ld (hl),a			;7511
	ret			;7512
quita_las_armas:
	ld hl,0c450h		;7513   ; las dos fichas a cero
	ld (hl),000h		;7516
	ld d,h			;7518
	ld e,l			;7519
	inc de			;751a
	ld bc,0001fh		;751b
	ldir		;751e
	ld a,0e0h		;7520   ; la y 0xE0 en las dos...
	ld (0c454h),a		;7522
	ld (0c464h),a		;7525
	ld (0d618h),a		;7528   ; ... y los cuatro sprites fuera
	ld (0d61ch),a		;752b
	ld (0d620h),a		;752e
	ld (0d624h),a		;7531
	ret			;7534

; ----------------------------------------------------------------------
; LOS DOS SPRITES DEL ARMA en la copia de 0xD600 (6 y 7 para 0xC450, 8 y 9 para 0xC460): en (y - 0x10, x - 8), con el patron y el siguiente (+4); y sus colores de linea, 0x0F y 0x0E con la cruz (arma 4), si no 2 y 0x4C, y 8 y 0 para el segundo sprite del frasco ardiendo.
; ----------------------------------------------------------------------
sprites_del_arma:
	ld a,(ix+000h)		;7535   ; lanzada?
	and a			;7538
	ret z			;7539
	push ix		;753a
	pop hl			;753c
	ld a,l			;753d   ; la de 0xC450...
	cp 050h		;753e
	ld hl,0d618h		;7540   ; ... en los sprites 6 y 7...
	jr z,sprite_del_arma		;7543
	ld hl,0d620h		;7545   ; ... la otra, 8 y 9
sprite_del_arma:
	ld a,(ix+004h)		;7548   ; la y, menos 0x10
	sub 010h		;754b
	ld (hl),a			;754d
	inc hl			;754e
	ld a,(ix+005h)		;754f   ; la x, menos 8
	sub 008h		;7552
	ld (hl),a			;7554
	inc hl			;7555
	ld a,(ix+006h)		;7556   ; el patron
	ld (hl),a			;7559
	inc hl			;755a
	inc hl			;755b
	ld a,(ix+004h)		;755c   ; el segundo: la misma y...
	sub 010h		;755f
	ld (hl),a			;7561
	inc hl			;7562
	ld a,(ix+005h)		;7563   ; ... la x...
	sub 008h		;7566
	ld (hl),a			;7568
	inc hl			;7569
	ld a,(ix+006h)		;756a   ; ... y el patron siguiente
	add a,004h		;756d
	ld (hl),a			;756f
	push ix		;7570   ; sus colores: 0xD460...
	pop hl			;7572
	ld a,l			;7573
	cp 050h		;7574
	ld hl,0d460h		;7576
	jr z,colores_del_arma		;7579
	ld hl,0d480h		;757b   ; ... o 0xD480
colores_del_arma:
	ld a,(ix+001h)		;757e   ; la cruz (arma 4)...
	cp 004h		;7581
	jr nz,colores_2_y_0x4c		;7583
	ld a,00fh		;7585   ; ... 0x0F en las 16 lineas del primero...
	ld b,010h		;7587
	call color_en_b_lineas		;7589
	ld a,00eh		;758c   ; ... y 0x0E en las del segundo
	ld b,010h		;758e
color_en_b_lineas:
	ld (hl),a			;7590
	inc hl			;7591
	djnz color_en_b_lineas		;7592
	ret			;7594
colores_2_y_0x4c:
	ld a,002h		;7595   ; las demas: 2...
	ld b,010h		;7597
	call color_en_b_lineas		;7599
	ld a,04ch		;759c   ; ... y 0x4C
	ld b,010h		;759e
	call color_en_b_lineas		;75a0
	ld a,(ix+001h)		;75a3   ; el frasco...
	cp 005h		;75a6
	ret nz			;75a8
	ld a,(ix+000h)		;75a9   ; ... ardiendo (paso 3)...
	cp 003h		;75ac
	ret nz			;75ae
	ld hl,0d480h		;75af   ; ... el primero 8 y el segundo 0
	ld de,0d490h		;75b2
	ld b,010h		;75b5
colores_del_frasco:
	ld (hl),008h		;75b7
	xor a			;75b9
	ld (de),a			;75ba
	inc hl			;75bb
	inc de			;75bc
	djnz colores_del_frasco		;75bd
	ret			;75bf
cuentas_de_simon:
	ld hl,0c440h		;75c0   ; las cuentas de 0xC440...
	call baja_una_cuenta		;75c3
	ld hl,0c434h		;75c6   ; ... 0xC434...
	call baja_una_cuenta		;75c9
	ld hl,0c42dh		;75cc   ; ... y 0xC42D (el respiro)
baja_una_cuenta:
	ld a,(hl)			;75cf   ; hasta 0
	and a			;75d0
	ret z			;75d1
	dec (hl)			;75d2
	ret			;75d3
cuenta_de_0xc445:
	ld hl,0c445h		;75d4   ; 0xC445, al acabar...
	ld a,(hl)			;75d7
	and a			;75d8
	ret z			;75d9
	dec (hl)			;75da
	ret nz			;75db
	ld a,018h		;75dc   ; ... 0x18 cuadros en 0xC43E
	ld (0c43eh),a		;75de
	ret			;75e1
cuenta_de_la_invencibilidad:
	ld hl,0c43ah		;75e2   ; la invencibilidad...
	ld a,(hl)			;75e5
	and a			;75e6
	ret z			;75e7
	dec (hl)			;75e8
	ld a,(hl)			;75e9
	cp 010h		;75ea   ; ... al quedar 0x10...
	ret nz			;75ec
	ld a,017h		;75ed   ; ... el efecto 0x17
	jp 0509fh		;75ef   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
cuenta_del_reloj:
	ld hl,0c43bh		;75f2   ; el tiempo parado...
	ld a,(hl)			;75f5
	and a			;75f6
	ret z			;75f7
	dec (hl)			;75f8
	ret nz			;75f9
	ld hl,0d010h		;75fa   ; ... al acabar, sigue...
	res 0,(hl)		;75fd
	ld a,0fch		;75ff   ; ... con el efecto 0xFC
	jp 0509fh		;7601   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
destello_del_borde:
	ld hl,0c43eh		;7604   ; 0xC43E cuadros...
	ld a,(hl)			;7607
	and a			;7608
	ret z			;7609
	dec (hl)			;760a
	and 002h		;760b   ; ... uno si y otro no...
	ld a,00eh		;760d   ; ... el color del borde 0x0E...
	jr nz,L_7612		;760f
	xor a			;7611   ; ... o 0
L_7612:
	ld (0f3ebh),a		;7612   ; (por CHGCLR)
	jp 00062h		;7615   ; BIOS CHGCLR - Changes the screen colors

; ----------------------------------------------------------------------
; LAS POSES CON ESCUDO: con uno de los dos escudos (bits 4 y 5 de 0xC701, p02:8D98 y 8DA1) y sin golpear, las piernas 0x14 mas alla y el cuerpo de pie (0, 1, 2) o hacia la izquierda (0x0F, 0x10, 0x11) pasa a 0x1E-0x23; golpeando en la escalera, las piernas vuelven a las de siempre.
; ----------------------------------------------------------------------
poses_con_escudo:
	ld a,(0c422h)		;7618   ; golpeando?
	and a			;761b
	jr nz,golpe_en_la_escalera_con_escudo		;761c
	ld a,(0c701h)		;761e   ; con un escudo?
	and 030h		;7621
	ret z			;7623
	ld hl,0c42eh		;7624   ; las piernas...
	ld a,(hl)			;7627
	cp 014h		;7628   ; ... 0x14 mas alla
	jr nc,cuerpo_con_escudo		;762a
	add a,014h		;762c
	ld (hl),a			;762e
cuerpo_con_escudo:
	inc hl			;762f   ; el cuerpo: 0, 1 o 2...
	ld a,(hl)			;7630
	ld b,01eh		;7631   ; ... a 0x1E, 0x1F o 0x20...
	and a			;7633
	jr z,pon_el_cuerpo		;7634
	inc b			;7636
	dec a			;7637
	jr z,pon_el_cuerpo		;7638
	inc b			;763a
	dec a			;763b
	jr z,pon_el_cuerpo		;763c
	ld a,(hl)			;763e   ; ... 0x0F, 0x10 o 0x11...
	ld b,021h		;763f   ; ... a 0x21, 0x22 o 0x23
	sub 00fh		;7641
	jr z,pon_el_cuerpo		;7643
	inc b			;7645
	dec a			;7646
	jr z,pon_el_cuerpo		;7647
	inc b			;7649
	dec a			;764a
	ret nz			;764b   ; (los demas, igual)
pon_el_cuerpo:
	ld (hl),b			;764c
	ret			;764d
golpe_en_la_escalera_con_escudo:
	ld a,(0c420h)		;764e   ; en la escalera...
	cp 003h		;7651
	ret nz			;7653
	ld hl,0c42eh		;7654   ; ... las piernas de siempre
	ld a,(hl)			;7657
	cp 014h		;7658
	ret c			;765a
	sub 014h		;765b
	ld (hl),a			;765d
	ret			;765e
pose_segun_el_lado:
	ld a,(0c42ch)		;765f   ; POSE SEGUN EL LADO: mirando a la izquierda...
	and a			;7662
	ret z			;7663
	ld hl,(0c42eh)		;7664   ; ... las piernas 0x0A mas alla...
	ld a,l			;7667
	cp 00ah		;7668
	jr nc,L_766F		;766a
	add a,00ah		;766c
	ld l,a			;766e
L_766F:
	ld a,h			;766f   ; ... y el cuerpo 0x0F
	cp 00fh		;7670
	jr nc,L_7677		;7672
	add a,00fh		;7674
	ld h,a			;7676
L_7677:
	ld (0c42eh),hl		;7677   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	ret			;767a

; ----------------------------------------------------------------------
; LOS BORDES DE LA HABITACION: Simon sale por arriba (en la escalera, y menos de 0x30: 0xC41B = 1, abajo del todo), por abajo (y 0xE1 o mas: 0xC41B = 2 arriba del todo, o, si no hay salida por abajo en 0xC41D, muere: estado 6, y el efecto 9 en las fases 2 y 10), por la izquierda (x menos de 8: 0xC41B = 3) o por la derecha (x 0xF8 o mas: 0xC41B = 4), si 0xC41E o 0xC41F no son 0xFF.
; ----------------------------------------------------------------------
los_bordes:
	ld a,(0c420h)		;767b   ; muerto: nada
	cp 006h		;767e
	ret z			;7680
	ld hl,0c41bh		;7681   ; el lado por el que sale...
	ld de,0c425h		;7684   ; ... la y...
	ld bc,0c427h		;7687   ; ... y la x
	ld a,(0c420h)		;768a   ; en la escalera...
	cp 003h		;768d
	ld a,(de)			;768f
	jr nz,bordes_abajo_y_lados		;7690
	cp 030h		;7692   ; ... por arriba?
	jr c,sale_por_arriba		;7694
bordes_abajo_y_lados:
	cp 0e1h		;7696   ; por abajo?
	jr nc,sale_por_abajo		;7698
	ld a,(bc)			;769a   ; por la izquierda?
	cp 008h		;769b
	jr c,sale_por_la_izquierda		;769d
	cp 0f8h		;769f   ; por la derecha?
	jr nc,sale_por_la_derecha		;76a1
	ret			;76a3
sale_por_arriba:
	ld a,(0c420h)		;76a4   ; saltando, no
	dec a			;76a7
	ret z			;76a8
	ld a,0e0h		;76a9   ; abajo del todo, y = 0xE0...
	ld (de),a			;76ab
	ld a,(0c42ch)		;76ac   ; ... y un poco mas alla, por donde mira
	and a			;76af
	ld d,0f0h		;76b0
	jr z,L_76B6		;76b2
	ld d,010h		;76b4
L_76B6:
	ld a,(bc)			;76b6
	add a,d			;76b7
	ld (bc),a			;76b8
	ld (hl),001h		;76b9   ; 0xC41B = 1: arriba
	ret			;76bb
sale_por_abajo:
	ld a,(0c41dh)		;76bc   ; hay salida por abajo?
	inc a			;76bf
	jr nz,baja_de_habitacion		;76c0
	xor a			;76c2   ; no: muere...
	ld (0c421h),a		;76c3
	ld a,006h		;76c6
	ld (0c420h),a		;76c8
	ld a,0fah		;76cb   ; ... fuera de la pantalla (0xFA)...
	ld (de),a			;76cd
	ld hl,0c428h		;76ce   ; ... 0x1E cuadros...
	ld a,01eh		;76d1
	ld (hl),a			;76d3
	ld a,(0d000h)		;76d4   ; ... en las fases 2 y 10...
	cp 002h		;76d7
	jr z,al_agua		;76d9
	cp 00ah		;76db
	jr z,al_agua		;76dd
	ld a,001h		;76df   ; ... (en las demas, uno)
	ld (hl),a			;76e1
	ret			;76e2
al_agua:
	ld a,009h		;76e3   ; ... con el efecto 9
	jp 0509fh		;76e5   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
baja_de_habitacion:
	ld a,030h		;76e8   ; arriba del todo, y = 0x30
	ld (de),a			;76ea
	ld a,(0c420h)		;76eb   ; en la escalera...
	cp 003h		;76ee
	jr nz,sale_por_abajo_fin		;76f0
	ld a,(0c42ch)		;76f2   ; ... un poco mas alla, por donde mira
	and a			;76f5
	ld d,0f0h		;76f6
	jr z,L_76FC		;76f8
	ld d,010h		;76fa
L_76FC:
	ld a,(bc)			;76fc
	add a,d			;76fd
	ld (bc),a			;76fe
sale_por_abajo_fin:
	ld (hl),002h		;76ff   ; 0xC41B = 2: abajo
	ret			;7701
sale_por_la_izquierda:
	ld a,(0c41eh)		;7702   ; hay salida?
	inc a			;7705
	ret z			;7706
	ld a,0f6h		;7707   ; a la derecha del todo, x = 0xF6...
	ld (bc),a			;7709
	ld (hl),003h		;770a   ; ... 0xC41B = 3
	ret			;770c
sale_por_la_derecha:
	ld a,(0c41fh)		;770d   ; hay salida?
	inc a			;7710
	ret z			;7711
	ld a,00ah		;7712   ; a la izquierda del todo, x = 0x0A...
	ld (bc),a			;7714
	ld (hl),004h		;7715   ; ... 0xC41B = 4
	ret			;7717

; ----------------------------------------------------------------------
; LA PUERTA DE LA FASE, por su estado (0xC5AC; 0, 2 nada): 1 y 4, con Simon delante y la llave blanca (bit 0 de 0xC701; en el patio no hace falta) la gasta, mueren las cosas, fuera las armas, el estado siguiente y el efecto 0x1A (0x15 al llegar al 5), y en las fases 3, 6, 9, 10, 12, 15, 17 y 18 (0x7777) la musica se funde; 3 y 5, Simon anda solo (0x80 por cuadro) y, al llegar al borde (en el 3) o al marco (en el 5), sale por ese lado (efecto 0x87; 0x86 en la fase 18) o, sin salida, la fase se acaba (0xC408).
; ----------------------------------------------------------------------
la_puerta_de_la_fase:
	ld a,(0c5ach)		;7718   ; por su estado
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


llega_a_la_puerta:
	ld de,0c425h		;772a   ; ESTADOS 1 y 4: la y...
	ld a,(de)			;772d
	ld b,a			;772e
	inc e			;772f
	inc e			;7730
	ld a,(de)			;7731   ; ... y la x de Simon...
	ld c,a			;7732
	call 08580h		;7733   ; ... en la puerta?
	ret nc			;7736
	ld hl,0c701h		;7737   ; lo que lleva...
	ld a,(0d000h)		;773a   ; ... en el patio no hace falta llave...
	and a			;773d
	jr z,abre_con_la_llave		;773e
	ld a,(hl)			;7740   ; ... si no, la blanca (bit 0)
	rra			;7741
	ret nc			;7742
abre_con_la_llave:
	res 0,(hl)		;7743   ; se gasta...
	call 08ebah		;7745   ; ... y se borra del marcador
	xor a			;7748   ; sin golpe
	ld (0c422h),a		;7749
	call mueren_las_cosas		;774c   ; mueren las cosas
	call quita_las_armas		;774f   ; fuera las armas
	ld hl,0c5ach		;7752   ; el estado siguiente de la puerta
	inc (hl)			;7755
	ld a,(0d000h)		;7756   ; en las fases de 0x7777...
	ld de,07777h		;7759
	call 04066h		;775c   ; de_mas_a: DE += A
	ld a,(de)			;775f
	and a			;7760
	jr z,efecto_de_la_puerta		;7761
	ld a,0ffh		;7763   ; ... la musica se funde
	call 0509fh		;7765   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
efecto_de_la_puerta:
	ld a,(hl)			;7768   ; el efecto 0x1A...
	cp 005h		;7769
	jr z,efecto_del_5		;776b
	ld a,01ah		;776d
	jp 0509fh		;776f   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
efecto_del_5:
	ld a,015h		;7772   ; ... o, en el 5, el 0x15
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


simon_anda_a_la_puerta:
	ld a,(0c5ach)		;778a   ; ESTADOS 3 y 5: en el 5, los sprites de la puerta
	cp 005h		;778d
	call z,055ech		;778f
	ld a,(0c420h)		;7792   ; de pie?
	and a			;7795
	ret nz			;7796
	ld bc,00000h		;7797   ; de pie...
	ld (0c42eh),bc		;779a   ; guarda las dos poses de Simon (0xC42E las piernas, 0xC42F el cuerpo)
	call pose_segun_el_lado		;779e   ; pose_segun_el_lado: ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon
	ld a,(0c42ch)		;77a1   ; ... y andando, 0x80 por cuadro...
	and a			;77a4
	ld bc,00080h		;77a5
	jr z,L_77AD		;77a8
	ld bc,0ff80h		;77aa   ; ... hacia donde mira
L_77AD:
	call suma_la_velocidad		;77ad
	call poses_por_el_cuadro		;77b0
	ld a,(0c5ach)		;77b3   ; en el 5, al marco...
	cp 005h		;77b6
	jr z,llega_a_la_puerta_abierta		;77b8
	ld a,(0c427h)		;77ba   ; en el 3, aun dentro (x de 8 a 0xF7): sigue
	sub 008h		;77bd
	cp 0f0h		;77bf
	ret c			;77c1
	jr sale_por_la_puerta		;77c2
llega_a_la_puerta_abierta:
	ld a,(0c5aeh)		;77c4   ; en el 5: a menos de 8 del marco?
	add a,008h		;77c7
	ld b,a			;77c9
	ld a,(0c427h)		;77ca   ; lee la X de Simon
	sub b			;77cd
	cp 008h		;77ce
	ret nc			;77d0
sale_por_la_puerta:
	ld hl,0c41eh		;77d1   ; a la izquierda (x menos de 0x80)...
	ld de,0c427h		;77d4   ; apunta a la X de Simon
	ld a,(de)			;77d7
	rla			;77d8
	jr c,sale_por_la_puerta_derecha		;77d9
	ld a,(hl)			;77db   ; ... si hay salida...
	inc a			;77dc
	jr z,fase_acabada		;77dd
	ld bc,003f6h		;77df   ; ... sale por la izquierda (3), x = 0xF6
	jr la_salida_de_la_puerta		;77e2
sale_por_la_puerta_derecha:
	inc hl			;77e4   ; a la derecha: si hay salida...
	ld a,(hl)			;77e5
	inc a			;77e6
	jr z,fase_acabada		;77e7
	ld bc,0040ah		;77e9   ; ... sale por la derecha (4), x = 0x0A
la_salida_de_la_puerta:
	ld a,b			;77ec
	ld (0c41bh),a		;77ed   ; guarda el lado por el que se sale de la habitacion
	ld a,c			;77f0
	ld (de),a			;77f1
	ld a,(0d000h)		;77f2   ; el efecto 0x87...
	cp 012h		;77f5
	ld a,087h		;77f7
	jr nz,L_77FD		;77f9
	ld a,086h		;77fb   ; ... o, en la fase 18, el 0x86
L_77FD:
	jp 0509fh		;77fd   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
fase_acabada:
	ld a,001h		;7800   ; sin salida: la fase se acaba (0xC408)
	ld (0c408h),a		;7802
L_7805:
	ret			;7805
mueren_las_cosas:
	ld ix,0c800h		;7806   ; las siete de 0xC800...
	ld b,007h		;780a
L_780C:
	ld a,(ix+000h)		;780c   ; lee el tipo de la cosa
	and a			;780f
	push bc			;7810
	push ix		;7811
	call nz,09a3ah		;7813   ; ... se van (sin soltar nada)
	pop ix		;7816
	pop bc			;7818
	ld de,00080h		;7819
	add ix,de		;781c
	djnz L_780C		;781e
	ld ix,0d700h		;7820   ; y las ocho de 0xD700...
	ld b,008h		;7824
L_7826:
	ld a,(ix+000h)		;7826   ; lee el tipo de la cosa
	and a			;7829
	push bc			;782a
	call nz,09a1ah		;782b   ; ... se vuelven llamas
	pop bc			;782e
	ld de,00080h		;782f
	add ix,de		;7832
	djnz L_7826		;7834
	ret			;7836

; ----------------------------------------------------------------------
; LOS SPRITES DE SIMON: sus colores (0x790C), los sprites 4 a 7 fuera (4 y 5 solo, si lleva un arma que se lanza, que usa los 6-9), y las piernas (0x7985, sprites 0 y 1) y el cuerpo (0x79D5, sprites 2 y 3) de sus poses; con la puerta de la fase en 5, en los sprites 8-11 (los 0-7 son de la puerta). Agachado o saltando encogido, las piernas suben 6 al saltar y el cuerpo baja 6 si no; con el respiro (0xC42D) parpadea.
; ----------------------------------------------------------------------
sprites_de_simon:
	call colores_de_simon		;7837   ; los colores
	ld a,(0c5ach)		;783a   ; con la puerta en 5, sin borrar
	cp 005h		;783d
	jr z,sprites_de_las_piernas		;783f
	ld de,0d610h		;7841   ; desde el sprite 4...
	ld a,(0c416h)		;7844   ; ... con un arma que se lanza, 2...
	cp 002h		;7847
	ld b,004h		;7849
	jr c,fuera_desde_el_4		;784b
	ld b,002h		;784d   ; ... si no, 4
fuera_desde_el_4:
	ld a,0e0h		;784f
un_sprite_fuera:
	ld (de),a			;7851
	inc de			;7852
	inc de			;7853
	inc de			;7854
	inc de			;7855
	djnz un_sprite_fuera		;7856
sprites_de_las_piernas:
	ld a,(0c42eh)		;7858   ; la lista de las piernas...
	add a,a			;785b
	ld hl,07985h		;785c   ; ... de 0x7985 por la pose
	call 04061h		;785f   ; hl_mas_a: HL += A
	ld e,(hl)			;7862
	inc hl			;7863
	ld d,(hl)			;7864
	ex de,hl			;7865
	ld c,000h		;7866   ; patrones desde el 0
	ld a,(0c5ach)		;7868   ; lee el estado de la puerta de la fase
	cp 005h		;786b
	ld de,0d600h		;786d   ; en los sprites 0 y 1...
	jr nz,L_7875		;7870
	ld de,0d620h		;7872   ; ... o, con la puerta en 5, 8 y 9
L_7875:
	ld b,(hl)			;7875   ; cuantos
	inc hl			;7876
	call un_sprite_de_simon		;7877
	ld a,(0c42fh)		;787a   ; la lista del cuerpo, de 0x79D5
	add a,a			;787d
	ld hl,079d5h		;787e
	call 04061h		;7881   ; hl_mas_a: HL += A
	ld e,(hl)			;7884
	inc hl			;7885
	ld d,(hl)			;7886
	ex de,hl			;7887
	ld c,002h		;7888   ; patrones desde el 2 (8)
	ld a,(0c5ach)		;788a   ; lee el estado de la puerta de la fase
	cp 005h		;788d
	ld de,0d608h		;788f   ; en los sprites 2 y 3...
	jr nz,cuantos_sprites		;7892
	ld de,0d628h		;7894   ; ... o 10 y 11
cuantos_sprites:
	ld b,(hl)			;7897
	inc hl			;7898
un_sprite_de_simon:
	ld a,(0c425h)		;7899   ; la y de Simon mas dy
	add a,(hl)			;789c
	push bc			;789d
	ld b,a			;789e
	ld a,(0c42eh)		;789f   ; las poses encogidas (6, 0x10, 0x1A, 0x24)...
	cp 006h		;78a2
	jr z,encogido		;78a4
	cp 010h		;78a6
	jr z,encogido		;78a8
	cp 01ah		;78aa
	jr z,encogido		;78ac
	cp 024h		;78ae
	jr nz,parpadea		;78b0
encogido:
	ld a,(0c420h)		;78b2   ; saltando...
	dec a			;78b5
	jr nz,encogido_de_pie		;78b6
	ld a,c			;78b8   ; ... las piernas...
	cp 002h		;78b9
	jr nc,parpadea		;78bb
	ld a,b			;78bd   ; ... 6 mas arriba
	sub 006h		;78be
	ld b,a			;78c0
	jr parpadea		;78c1
encogido_de_pie:
	ld a,c			;78c3   ; si no, el cuerpo...
	cp 002h		;78c4
	jr c,parpadea		;78c6
	ld a,b			;78c8   ; ... 6 mas abajo
	add a,006h		;78c9
	ld b,a			;78cb
parpadea:
	ld a,(0c42dh)		;78cc   ; con el respiro...
	and a			;78cf
	jr z,la_y_del_sprite		;78d0
	ld a,(0c003h)		;78d2   ; ... uno de cada dos cuadros...
	and 002h		;78d5
	jr z,la_y_del_sprite		;78d7
	ld b,0e0h		;78d9   ; ... fuera de la pantalla
la_y_del_sprite:
	ld a,b			;78db
	pop bc			;78dc
	sub 002h		;78dd   ; menos 2
	ld (de),a			;78df
	inc hl			;78e0
	inc de			;78e1
	push bc			;78e2
	ld b,(hl)			;78e3   ; dx, con signo en el bit 7...
	ld a,(0c427h)		;78e4   ; lee la X de Simon
	ld c,a			;78e7
	rl b		;78e8
	jr nc,dx_positivo		;78ea
	rr b		;78ec
	ld a,b			;78ee
	neg		;78ef
	ld b,a			;78f1
	ld a,c			;78f2
	sub b			;78f3
	jr fuera_si_se_sale		;78f4
dx_positivo:
	add a,(hl)			;78f6   ; ... sumado a la x
fuera_si_se_sale:
	jr nc,la_x_del_sprite		;78f7   ; se sale por el borde: fuera
	dec de			;78f9
	ld a,0e0h		;78fa
	ld (de),a			;78fc
	inc de			;78fd
la_x_del_sprite:
	ld (de),a			;78fe
	pop bc			;78ff
	inc hl			;7900
	inc de			;7901
	ld a,c			;7902   ; el patron: el numero por 4
	add a,a			;7903
	add a,a			;7904
	ld (de),a			;7905
	inc c			;7906   ; el siguiente
	inc de			;7907
	inc de			;7908
	djnz un_sprite_de_simon		;7909
	ret			;790b

; ----------------------------------------------------------------------
; LOS COLORES DE SIMON, en 0xD400 (0xD480 con la puerta en 5), 16 lineas por sprite: invencible, 0x0E uno de cada dos cuadros; con la cuenta de 0xC434, 8 uno de cada dos; si no, 0x42 (con CC) y 1, un sprite si y otro no. Ocho sprites, o cuatro con un arma que se lanza.
; ----------------------------------------------------------------------
colores_de_simon:
	ld a,(0c416h)		;790c   ; ocho sprites...
	cp 002h		;790f
	ld b,080h		;7911
	jr c,donde_los_colores		;7913
	ld b,040h		;7915   ; ... o cuatro
donde_los_colores:
	ld a,(0c5ach)		;7917   ; 0xD400...
	cp 005h		;791a
	ld hl,0d400h		;791c
	jr nz,color_de_una_linea_de_simon		;791f
	ld hl,0d480h		;7921   ; ... o 0xD480
color_de_una_linea_de_simon:
	ld a,(0c43ah)		;7924   ; invencible...
	and a			;7927
	jr z,con_la_cuenta_de_0xc434		;7928
	ld a,(0c003h)		;792a   ; ... uno de cada dos cuadros...
	rra			;792d
	ld a,00eh		;792e   ; ... 0x0E
	jr c,pon_el_color		;7930
con_la_cuenta_de_0xc434:
	ld a,(0c434h)		;7932   ; con 0xC434...
	and a			;7935
	jr z,color_normal		;7936
	ld a,(0c003h)		;7938   ; ... uno de cada dos...
	rra			;793b
	ld a,008h		;793c   ; ... 8
	jr c,pon_el_color		;793e
color_normal:
	ld a,b			;7940   ; de 16 en 16 lineas...
	dec a			;7941
	and 010h		;7942
	ld a,001h		;7944   ; ... 1...
	jr nz,pon_el_color		;7946
	ld a,042h		;7948   ; ... o 0x42
pon_el_color:
	ld (hl),a			;794a
	inc hl			;794b
	djnz color_de_una_linea_de_simon		;794c
	ret			;794e
la_musica_de_la_fase:
	ld a,(0c40dh)		;794f   ; al empezar la vida (0xC40D)...
	and a			;7952
	jr nz,suena_la_de_la_fase		;7953
	ld a,(0d000h)		;7955   ; ... o en el patio...
	and a			;7958
	jr z,suena_la_de_la_fase		;7959
	dec a			;795b   ; ... o en las fases de 0x7777...
	ld hl,07777h		;795c
	call 04061h		;795f   ; hl_mas_a: HL += A
	ld a,(hl)			;7962
	and a			;7963
	ret z			;7964   ; (en las demas, la que sonaba)
suena_la_de_la_fase:
	ld a,(0d000h)		;7965   ; la de 0x7972, por la fase
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
; DATOS poses_de_las_piernas: 40 punteros, uno por pose (0xC42E), a la lista
;   de sprites de las piernas de Simon (p01:785C)
;   0x7985..0x79d5  (80 bytes)
DATA_poses_de_las_piernas:
	defb 01dh,07ah,01dh,07ah,01dh,07ah,01dh,07ah,01dh,07ah,01dh,07ah,022h,07ah,027h,07ah	; 7985  .z.z.z.z.z.z"z'z
	defb 027h,07ah,02ch,07ah,031h,07ah,031h,07ah,031h,07ah,031h,07ah,031h,07ah,031h,07ah	; 7995  'z,z1z1z1z1z1z1z
	defb 036h,07ah,03bh,07ah,03bh,07ah,040h,07ah,01dh,07ah,01dh,07ah,01dh,07ah,01dh,07ah	; 79a5  6z;z;z@z.z.z.z.z
	defb 01dh,07ah,01dh,07ah,022h,07ah,027h,07ah,027h,07ah,02ch,07ah,031h,07ah,031h,07ah	; 79b5  .z.z"z'z'z,z1z1z
	defb 031h,07ah,031h,07ah,031h,07ah,031h,07ah,036h,07ah,03bh,07ah,03bh,07ah,040h,07ah	; 79c5  1z1z1z1z6z;z;z@z

; ----------------------------------------------------------------------
; DATOS poses_del_cuerpo: 36 punteros, uno por pose (0xC42F), a la lista de
;   sprites del cuerpo y el latigo (p01:787E)
;   0x79d5..0x7a1d  (72 bytes)
DATA_poses_del_cuerpo:
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


rayas_del_titulo:
	ld e,010h		;7acf   ; dieciseis...
una_raya_del_titulo:
	ld a,002h		;7ad1   ; ... rectangulos del byte 2...
	ld d,000h		;7ad3
	ld bc,00709h		;7ad5   ; ... de 7 x 9 puntos...
	push hl			;7ad8
	push de			;7ad9
	call 0490ah		;7ada   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	pop de			;7add
	pop hl			;7ade
	ld a,010h		;7adf   ; ... de 16 en 16 puntos
	add a,h			;7ae1
	ld h,a			;7ae2
	dec e			;7ae3
	jr nz,una_raya_del_titulo		;7ae4
	ret			;7ae6
color_2_del_titulo:
	ld a,002h		;7ae7   ; el color 2 a 0x1101
	ld de,01101h		;7ae9
	jp 04814h		;7aec   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)

; ----------------------------------------------------------------------
; LOS SPRITES DEL TITULO JAPONES: once pares en la copia de 0xD600, cada par con la posicion de 0x7B52 y dos patrones seguidos (desde el 0), de los colores 8 y 2 (el 2, negro), sin rotar.
; ----------------------------------------------------------------------
sprites_del_titulo:
	ld de,0d600h		;7aef
	ld hl,07b52h		;7af2
	ld b,00bh		;7af5   ; once pares
	ld a,0fch		;7af7
un_par_del_titulo:
	push bc			;7af9
	ld b,002h		;7afa
un_sprite_del_titulo:
	push bc			;7afc
	ld bc,00002h		;7afd   ; y y x...
	ldir		;7b00
	pop bc			;7b02
	dec hl			;7b03
	dec hl			;7b04
	add a,004h		;7b05   ; ... y el patron, cuatro mas
	ld (de),a			;7b07
	inc de			;7b08
	inc de			;7b09
	djnz un_sprite_del_titulo		;7b0a
	inc hl			;7b0c
	inc hl			;7b0d
	pop bc			;7b0e
	djnz un_par_del_titulo		;7b0f
	ld hl,0d400h		;7b11   ; los colores: 16 lineas del 8...
	ld c,00bh		;7b14
L_7B16:
	ld b,010h		;7b16
L_7B18:
	ld (hl),008h		;7b18
	inc hl			;7b1a
	djnz L_7B18		;7b1b
	ld b,010h		;7b1d   ; ... y 16 del 2, once veces
L_7B1F:
	ld (hl),002h		;7b1f
	inc hl			;7b21
	djnz L_7B1F		;7b22
	dec c			;7b24
	jr nz,L_7B16		;7b25
	ld a,002h		;7b27   ; el color 2, negro
	ld de,00000h		;7b29
	call 04814h		;7b2c   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
	jp sprites_sin_rotar		;7b2f
rotulo_por_filas:
	push de			;7b32   ; ROTULO POR FILAS: [dibujo], 0xFE [dx] fila nueva, 0xFF acaba
L_7B33:
	ld a,(hl)			;7b33
	inc hl			;7b34
	ld c,a			;7b35
	inc a			;7b36   ; 0xFF: acaba
	jr z,rotulo_acabado		;7b37
	inc a			;7b39   ; 0xFE: fila nueva...
	jr nz,un_dibujo_del_rotulo		;7b3a
	pop de			;7b3c
	ld a,(hl)			;7b3d   ; ... dx...
	inc hl			;7b3e
	add a,d			;7b3f
	ld d,a			;7b40
	ld a,008h		;7b41   ; ... y 8 mas abajo
	add a,e			;7b43
	ld e,a			;7b44
	jr rotulo_por_filas		;7b45
un_dibujo_del_rotulo:
	ld a,c			;7b47   ; el dibujo, con transparencia...
	call 04b1dh		;7b48
	call 04b4fh		;7b4b   ; ... y la posicion siguiente
	jr L_7B33		;7b4e
rotulo_acabado:
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


pared_bajo_los_pies:
	ld a,(0c425h)		;7b68   ; la celda 7 por debajo de Simon: pared?
	add a,007h		;7b6b
	ld e,a			;7b6d
	ld a,(0c427h)		;7b6e   ; lee la X de Simon
	ld d,a			;7b71
	call celda_del_mapa		;7b72   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	jp es_pared		;7b75   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
techo_encima:
	ld a,(0c425h)		;7b78   ; la celda 0x2C por encima de Simon: pared?
	sub 02ch		;7b7b
	ld e,a			;7b7d
	ld a,(0c427h)		;7b7e   ; lee la X de Simon
	ld d,a			;7b81
	call celda_del_mapa		;7b82   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	jp es_pared		;7b85   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
mira_el_suelo:
	ld a,(0c425h)		;7b88   ; MIRA EL SUELO: por debajo de 0xD0...
	ld e,a			;7b8b
	cp 0d0h		;7b8c
	jr c,suelo_bajo_los_pies		;7b8e
	or a			;7b90   ; ... no hay (NC)
	ret			;7b91
suelo_bajo_los_pies:
	ld a,(0c427h)		;7b92   ; x + 5...
	add a,005h		;7b95
	ld d,a			;7b97
choca_con_el_decorado:
	call celda_del_mapa		;7b98   ; CHOCA CON EL DECORADO: (E, D) pared?
	call es_pared		;7b9b   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7b9e
	ld a,d			;7b9f   ; ... o (E, D - 10)
	sub 00ah		;7ba0
	ld d,a			;7ba2
pared_en_de:
	call celda_del_mapa		;7ba3   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	jp es_pared		;7ba6   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)

; ----------------------------------------------------------------------
; PARED A LA DERECHA de Simon (0x7C05 a la izquierda): las celdas a 8 de su x, desde su y - 2 hacia arriba de 8 en 8: cuatro, o tres agachado; 0x7BB7 mira a 0x10 desde y - 4, solo dos; 0x7BBE, con B y C de quien llama, siempre cuatro. Carry si hay.
; ----------------------------------------------------------------------
pared_a_la_derecha:
	ld a,(0c425h)		;7ba9   ; lee la Y de Simon
	ld e,a			;7bac
	ld a,(0c427h)		;7bad   ; lee la X de Simon
	ld d,a			;7bb0
	ld bc,00802h		;7bb1   ; 8 a la derecha, desde y - 2
	xor a			;7bb4
	jr mira_la_derecha		;7bb5
pared_a_la_derecha_lejos:
	ld bc,01004h		;7bb7   ; 0x10 a la derecha, desde y - 4, dos celdas
	ld a,002h		;7bba
	jr mira_la_derecha		;7bbc
pared_a_la_derecha_alta:
	ld a,001h		;7bbe   ; siempre cuatro, desde donde diga BC
mira_la_derecha:
	ld (0cff0h),a		;7bc0   ; el modo, a 0xCFF0 de temporal
	ld a,e			;7bc3   ; y - C...
	sub c			;7bc4
	ld e,a			;7bc5
	ld a,d			;7bc6   ; ... x + B
	add a,b			;7bc7
	ld d,a			;7bc8
	call celda_del_mapa		;7bc9   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7bcc   ; pared?
	ret c			;7bcf
	ld a,e			;7bd0   ; 8 mas arriba
	sub 008h		;7bd1
	ld e,a			;7bd3
	call celda_del_mapa		;7bd4   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7bd7   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7bda
	ld a,(0cff0h)		;7bdb   ; en el modo 2, dos celdas
	cp 002h		;7bde
	ret z			;7be0
	ld a,e			;7be1   ; 8 mas arriba
	sub 008h		;7be2
	ld e,a			;7be4
	call celda_del_mapa		;7be5   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7be8   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7beb
	ld a,(0cff0h)		;7bec   ; en el modo 0...
	and a			;7bef
	jr nz,la_cuarta_celda		;7bf0
	ld a,(0c420h)		;7bf2   ; ... agachado, tres
	cp 002h		;7bf5
	jr nz,la_cuarta_celda		;7bf7
	xor a			;7bf9
	ret			;7bfa
la_cuarta_celda:
	ld a,e			;7bfb   ; 8 mas arriba
	sub 008h		;7bfc
	ld e,a			;7bfe
	call celda_del_mapa		;7bff   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	jp es_pared		;7c02   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
pared_a_la_izquierda:
	ld a,(0c425h)		;7c05   ; lee la Y de Simon
	ld e,a			;7c08
	ld a,(0c427h)		;7c09   ; lee la X de Simon
	ld d,a			;7c0c
	ld bc,00802h		;7c0d   ; 8 a la izquierda, desde y - 2
	xor a			;7c10
	jr mira_la_izquierda		;7c11
pared_a_la_izquierda_lejos:
	ld bc,01004h		;7c13
	ld a,002h		;7c16
	jr mira_la_izquierda		;7c18
pared_a_la_izquierda_alta:
	ld a,001h		;7c1a
mira_la_izquierda:
	ld (0cff0h),a		;7c1c   ; el modo
	ld a,e			;7c1f   ; y - C...
	sub c			;7c20
	ld e,a			;7c21
	ld a,d			;7c22   ; ... x - B
	sub b			;7c23
	ld d,a			;7c24
	call celda_del_mapa		;7c25   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7c28   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7c2b
	ld a,e			;7c2c   ; 8 mas arriba
	sub 008h		;7c2d
	ld e,a			;7c2f
	call celda_del_mapa		;7c30   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7c33   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7c36
	ld a,(0cff0h)		;7c37   ; en el modo 2, dos
	cp 002h		;7c3a
	ret z			;7c3c
	ld a,e			;7c3d   ; 8 mas arriba
	sub 008h		;7c3e
	ld e,a			;7c40
	call celda_del_mapa		;7c41   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	call es_pared		;7c44   ; es_pared: carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)
	ret c			;7c47
	ld a,(0cff0h)		;7c48   ; en el modo 0, agachado, tres
	and a			;7c4b
	jr nz,la_cuarta_celda_izquierda		;7c4c
	ld a,(0c420h)		;7c4e
	cp 002h		;7c51
	jr nz,la_cuarta_celda_izquierda		;7c53
	xor a			;7c55
	ret			;7c56
la_cuarta_celda_izquierda:
	ld a,e			;7c57
	sub 008h		;7c58
	ld e,a			;7c5a
	call celda_del_mapa		;7c5b   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
es_pared:
	ld c,a			;7c5e   ; ES PARED la celda A? En la sala de Dracula, de la 1 a la 6...
	ld a,(0ce00h)		;7c5f
	cp 006h		;7c62
	jr z,pared_en_la_sala_de_dracula		;7c64
	ld a,(0d000h)		;7c66   ; ... si no, de la 1 al tope de la fase (0x7C78)
	ld hl,07c78h		;7c69
	call 04061h		;7c6c   ; hl_mas_a: HL += A
	ld a,c			;7c6f
	dec a			;7c70
	cp (hl)			;7c71
	ret			;7c72
pared_en_la_sala_de_dracula:
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



; ----------------------------------------------------------------------
; LAS ESCALERAS: celdas 4 y 3 al pie (bajan a la derecha y a la izquierda: 0x7C8B y 0x7CB3), 0x0D y 0x0C arriba (suben a la izquierda y a la derecha: 0x7CDB y 0x7D05), bajo Simon o a 8 puntos, que se le suman a su x para ponerlo en la escalera. Z si la hay; en la sala de Dracula no hay ninguna.
; ----------------------------------------------------------------------
escalera_que_baja_a_la_derecha:
	ld a,(0ce00h)		;7c8b   ; en la sala de Dracula...
	cp 006h		;7c8e
	jr nz,celda_4		;7c90
	and a			;7c92   ; ... no (NZ)
	ret			;7c93
celda_4:
	ld bc,0c425h		;7c94   ; la celda bajo Simon...
	ld a,(bc)			;7c97
	ld e,a			;7c98
	inc c			;7c99
	inc c			;7c9a
	ld a,(bc)			;7c9b
	ld d,a			;7c9c
	call celda_del_mapa		;7c9d   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 004h		;7ca0   ; ... la 4?
	ret z			;7ca2
	ld a,(bc)			;7ca3   ; o 8 a la derecha...
	add a,008h		;7ca4
	ld d,a			;7ca6
	call celda_del_mapa		;7ca7   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 004h		;7caa
	ret nz			;7cac
	ld a,(bc)			;7cad   ; ... y alli se pone
	add a,008h		;7cae
	ld (bc),a			;7cb0
	xor a			;7cb1
	ret			;7cb2
escalera_que_baja_a_la_izquierda:
	ld a,(0ce00h)		;7cb3
	cp 006h		;7cb6
	jr nz,celda_3		;7cb8
	and a			;7cba
	ret			;7cbb
celda_3:
	ld bc,0c425h		;7cbc   ; la celda bajo Simon...
	ld a,(bc)			;7cbf
	ld e,a			;7cc0
	inc c			;7cc1
	inc c			;7cc2
	ld a,(bc)			;7cc3
	ld d,a			;7cc4
	call celda_del_mapa		;7cc5   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 003h		;7cc8   ; ... la 3?
	ret z			;7cca
	ld a,(bc)			;7ccb   ; o 8 a la izquierda...
	sub 008h		;7ccc
	ld d,a			;7cce
	call celda_del_mapa		;7ccf   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 003h		;7cd2
	ret nz			;7cd4
	ld a,(bc)			;7cd5   ; ... y alli se pone
	sub 008h		;7cd6
	ld (bc),a			;7cd8
	xor a			;7cd9
	ret			;7cda
escalera_que_sube_a_la_izquierda:
	ld a,(0ce00h)		;7cdb
	cp 006h		;7cde
	jr nz,celda_0x0d		;7ce0
	and a			;7ce2
	ret			;7ce3
celda_0x0d:
	ld bc,0c425h		;7ce4   ; 8 por encima y 8 a la izquierda...
	ld a,(bc)			;7ce7
	sub 008h		;7ce8
	ld e,a			;7cea
	inc c			;7ceb
	inc c			;7cec
	ld a,(bc)			;7ced
	sub 008h		;7cee
	ld d,a			;7cf0
	call celda_del_mapa		;7cf1   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 00dh		;7cf4   ; ... la 0x0D?
	ret z			;7cf6
	ld a,(bc)			;7cf7   ; o encima...
	ld d,a			;7cf8
	call celda_del_mapa		;7cf9   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 00dh		;7cfc
	ret nz			;7cfe
	ld a,(bc)			;7cff   ; ... y 8 a la derecha
	add a,008h		;7d00
	ld (bc),a			;7d02
	xor a			;7d03
	ret			;7d04
escalera_que_sube_a_la_derecha:
	ld a,(0ce00h)		;7d05
	cp 006h		;7d08
	jr nz,celda_0x0c		;7d0a
	and a			;7d0c
	ret			;7d0d
celda_0x0c:
	ld bc,0c425h		;7d0e   ; 8 por encima y 8 a la derecha...
	ld a,(bc)			;7d11
	sub 008h		;7d12
	ld e,a			;7d14
	inc c			;7d15
	inc c			;7d16
	ld a,(bc)			;7d17
	add a,008h		;7d18
	ld d,a			;7d1a
	call celda_del_mapa		;7d1b   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 00ch		;7d1e   ; ... la 0x0C?
	ret z			;7d20
	ld a,(bc)			;7d21   ; o encima...
	ld d,a			;7d22
	call celda_del_mapa		;7d23   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	cp 00ch		;7d26
	ret nz			;7d28
	ld a,(bc)			;7d29   ; ... y 8 a la izquierda
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
	jp mueren_las_cosas		;7e29
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
	ld a,(0c43ah)		;7e72   ; lee la cuenta de la INVENCIBILIDAD
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
	ld a,(0c43ah)		;7eef   ; lee la cuenta de la INVENCIBILIDAD
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
	call z,quita_la_ficha		;7fa6
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
	ld hl,0c500h		;7fe7   ; apunta a los objetos que salen (ocho de 16 bytes)
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
