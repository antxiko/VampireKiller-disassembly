; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l8928h:	equ 0x08928
l9b33h:	equ 0x09b33

; ----------------------------------------------------------------------
; DATOS cola_del_ld: el tercer byte (0xC4) de `ld (0xC433),a`, que empieza en
;   p01:7FFE; el codigo sigue en 0x8001
;   0x8000..0x8001  (1 bytes)
DATA_cola_del_ld:
	defb 0c4h	; 8000

; ======================================================================
; CODIGO 0x8001..0x8048  (71 bytes)
; ======================================================================


L_8001:
	inc l			;8001
	ld a,(hl)			;8002
	cp 01bh		;8003
	jr nz,L_8015		;8005
	ld a,0e0h		;8007
	ld (0d618h),a		;8009
	ld (0d61ch),a		;800c
	ld (0d620h),a		;800f
	ld (0d624h),a		;8012
L_8015:
	pop hl			;8015
	pop bc			;8016
	ld a,010h		;8017
	add a,l			;8019
	ld l,a			;801a
	djnz $-47		;801b
	ret			;801d
L_801E:
	ld a,(0c450h)		;801e
	ld b,a			;8021
	ld a,(0c460h)		;8022
	or b			;8025
	ret z			;8026
	ld ix,0c800h		;8027
	ld b,007h		;802b
L_802D:
	ld a,(ix+000h)		;802d   ; lee el tipo de la cosa
	and a			;8030
	jr z,L_8040		;8031
	ld a,(ix+00eh)		;8033
	rra			;8036
	jr nc,L_8040		;8037
	push bc			;8039
	call L_82A4		;803a
	pop bc			;803d
	jr c,$+14		;803e
L_8040:
	ld de,00080h		;8040
	add ix,de		;8043
	djnz L_802D		;8045
	ret			;8047

; ----------------------------------------------------------------------
; DATOS cuatro_valores: cuatro bytes que p02:805F elige con (iy+1) - 2; los
;   mismos bytes los usan como coordenadas de VRAM p00:58E7, p00:592A y
;   p01:662B
;   0x8048..0x804c  (4 bytes)
DATA_cuatro_valores:
	defb 001h,004h,002h,002h	; 8048

; ======================================================================
; CODIGO 0x804c..0x81ce  (386 bytes)
; ======================================================================


L_804C:
	ld a,00ch		;804c
	call 0509fh		;804e   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,(ix+000h)		;8051   ; lee el tipo de la cosa
	sub 011h		;8054
	cp 007h		;8056
	jr c,L_8088		;8058
L_805A:
	ld a,(iy+001h)		;805a
	sub 002h		;805d
	ld hl,08048h		;805f
	call 04061h		;8062   ; hl_mas_a: HL += A
	ld b,(hl)			;8065
	ld a,(ix+00dh)		;8066
	sub b			;8069
	ld (ix+00dh),a		;806a
	jr z,L_8072		;806d
	jp p,L_8078		;806f
L_8072:
	call L_81AB		;8072
	call L_9A3E		;8075
L_8078:
	ld a,(iy+001h)		;8078
	cp 002h		;807b
	push iy		;807d
	pop hl			;807f
	jp z,074ech		;8080
	res 0,(ix+00eh)		;8083
	ret			;8087
L_8088:
	ld a,(ix+000h)		;8088   ; lee el tipo de la cosa
	cp 012h		;808b
	jr nz,L_8095		;808d
	ld a,(0ce00h)		;808f
	and a			;8092
	jr z,L_805A		;8093
L_8095:
	call 07e2ch		;8095
	ld a,(0c418h)		;8098   ; lee la vida del enemigo (barra ENEMY)
	and a			;809b
	jr z,L_80A1		;809c
	rla			;809e
	jr nc,L_8078		;809f
L_80A1:
	call 07e17h		;80a1
	jr L_8078		;80a4
L_80A6:
	ld ix,0c470h		;80a6
	ld b,008h		;80aa
L_80AC:
	ld a,(ix+000h)		;80ac   ; lee el tipo de la cosa
	and a			;80af
	jr z,L_80D4		;80b0
	push bc			;80b2
	call L_8460		;80b3
	pop bc			;80b6
	jr nc,L_80D4		;80b7
	inc (ix+003h)		;80b9   ; sube la y de la cosa
	ld a,(ix+004h)		;80bc   ; lee la fraccion de la x de la cosa
	ld (0c433h),a		;80bf
	ld a,(iy+001h)		;80c2
	dec a			;80c5
	dec a			;80c6
	jr nz,L_80CF		;80c7
	push iy		;80c9
	pop hl			;80cb
	call z,074ech		;80cc
L_80CF:
	ld a,00ch		;80cf
	jp 0509fh		;80d1   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_80D4:
	ld de,00010h		;80d4
	add ix,de		;80d7
	djnz L_80AC		;80d9
	ret			;80db
L_80DC:
	ld hl,0c5b5h		;80dc
	call L_80E5		;80df
	ld hl,0c5c5h		;80e2
L_80E5:
	ld a,(hl)			;80e5
	rla			;80e6
	ret nc			;80e7
	ld a,(0c416h)		;80e8   ; lee el arma que lleva Simon (0, ninguna)
	cp 002h		;80eb
	jr nc,L_80FD		;80ed
	ld a,(0c422h)		;80ef
	cp 003h		;80f2
	jr nz,L_80FD		;80f4
	push hl			;80f6
	call L_83A1		;80f7
	pop hl			;80fa
	jr c,L_8112		;80fb
L_80FD:
	push hl			;80fd
	call L_83B3		;80fe
	pop hl			;8101
	ret nc			;8102
	ld a,(iy+001h)		;8103
	cp 002h		;8106
	jr nz,L_8112		;8108
	push hl			;810a
	push iy		;810b
	pop hl			;810d
	call 074ech		;810e
	pop hl			;8111
L_8112:
	inc l			;8112
	inc l			;8113
	inc l			;8114
	inc (hl)			;8115
	ld a,00ch		;8116
	jp 0509fh		;8118   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_811B:
	ld hl,0c500h		;811b
	ld b,008h		;811e
L_8120:
	push bc			;8120
	push hl			;8121
	ld a,(hl)			;8122
	rla			;8123
	jr nc,L_8163		;8124
	push hl			;8126
	ld a,004h		;8127
	add a,l			;8129
	ld l,a			;812a
	ld a,(hl)			;812b
	pop hl			;812c
	cp 00ah		;812d
	jr z,L_8135		;812f
	cp 00bh		;8131
	jr nz,L_8163		;8133
L_8135:
	ld a,(0c416h)		;8135   ; lee el arma que lleva Simon (0, ninguna)
	cp 002h		;8138
	jr nc,L_814A		;813a
	ld a,(0c422h)		;813c
	cp 003h		;813f
	jr nz,L_814A		;8141
	push hl			;8143
	call L_839C		;8144
	pop hl			;8147
	jr c,L_8159		;8148
L_814A:
	push hl			;814a
	call L_83AE		;814b
	pop hl			;814e
	jr nc,L_8163		;814f
	push hl			;8151
	push iy		;8152
	pop hl			;8154
	call 074ech		;8155
	pop hl			;8158
L_8159:
	inc l			;8159
	inc l			;815a
	inc l			;815b
	ld (hl),002h		;815c
	ld a,00ch		;815e
	call 0509fh		;8160   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_8163:
	pop hl			;8163
	pop bc			;8164
	ld a,010h		;8165
	add a,l			;8167
	ld l,a			;8168
	djnz L_8120		;8169
	ret			;816b
L_816C:
	ld a,(ix+000h)		;816c   ; lee el tipo de la cosa
	dec a			;816f
	add a,a			;8170
	ld hl,081ceh		;8171
	call 04061h		;8174   ; hl_mas_a: HL += A
	inc hl			;8177
	ld b,(hl)			;8178
	ld a,(0c701h)		;8179
	bit 4,a		;817c
	jr z,L_8193		;817e
	ld a,(0c427h)		;8180   ; lee la X de Simon
	sub (ix+005h)		;8183   ; le resta la x de la cosa
	ld a,(0c42ch)		;8186   ; lee el lado al que mira Simon
	jr nc,L_8190		;8189
	and a			;818b
	jr z,L_8198		;818c
	jr L_8193		;818e
L_8190:
	and a			;8190
	jr nz,L_8198		;8191
L_8193:
	ld a,b			;8193
	add a,a			;8194
	ld b,a			;8195
	jr L_81A8		;8196
L_8198:
	ld hl,0c441h		;8198
	dec (hl)			;819b
	jr nz,L_81A8		;819c
	ld hl,0c701h		;819e
	res 4,(hl)		;81a1
	push bc			;81a3
	call L_8EE6		;81a4
	pop bc			;81a7
L_81A8:
	jp 0462bh		;81a8
L_81AB:
	ld a,(ix+000h)		;81ab   ; lee el tipo de la cosa
	ld b,a			;81ae
	dec a			;81af
	add a,a			;81b0
	ld hl,081ceh		;81b1
	call 04061h		;81b4   ; hl_mas_a: HL += A
	ld e,000h		;81b7
	ld d,(hl)			;81b9
	ld a,b			;81ba
	cp 011h		;81bb
	ld c,003h		;81bd
	jp z,044eeh		;81bf
	ld c,005h		;81c2
	cp 017h		;81c4
	jp z,044eeh		;81c6
	ld c,000h		;81c9
	jp 044eeh		;81cb

; ----------------------------------------------------------------------
; DATOS puntos_y_dano_de_cada_tipo: 46 pares, uno por tipo de cosa (1-46):
;   [puntos que da al morir, en BCD, que p02:81B9 pasa a 0x44EE][dano que hace
;   al tocar a Simon, que p02:8178 pasa a 0x462B]
;   0x81ce..0x822a  (92 bytes)
DATA_puntos_y_dano_de_cada_tipo:
	defb 001h,001h,002h,002h,002h,002h,001h,001h,001h,003h,002h,002h,002h,001h,002h,002h	; 81ce  ................
	defb 002h,001h,003h,001h,002h,001h,001h,001h,002h,001h,010h,003h,004h,002h,003h,003h	; 81de  ................
	defb 000h,003h,020h,002h,020h,002h,020h,002h,030h,003h,070h,003h,000h,000h,002h,001h	; 81ee  .. . . .0.p.....
	defb 001h,002h,001h,002h,001h,002h,001h,002h,000h,000h,000h,000h,001h,001h,000h,000h	; 81fe  ................
	defb 002h,001h,000h,000h,002h,001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 820e  ................
	defb 000h,000h,000h,000h,000h,000h,001h,001h,000h,000h,000h,000h	; 821e  ............

; ======================================================================
; CODIGO 0x822a..0x8252  (40 bytes)
; ======================================================================


L_822A:
	ld de,00100h		;822a
	jp 044ech		;822d
L_8230:
	inc l			;8230
	ld a,(hl)			;8231
	add a,010h		;8232
	ld e,a			;8234
	inc l			;8235
	ld a,(hl)			;8236
	add a,008h		;8237
	ld d,a			;8239
	ld hl,01008h		;823a
	jp L_847A		;823d
L_8240:
	ld d,(ix+005h)		;8240   ; lee la x de la cosa
	ld e,(ix+004h)		;8243   ; lee la fraccion de la x de la cosa
	ld hl,01008h		;8246
	jp L_847A		;8249
L_824C:
	call L_82FB		;824c
	call 0406bh		;824f   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8252: 3 destinos del despachador de 0x406B (call en p02:824F):
;   0x8318, 0x8338, 0x8358; lo leen p02:824F (6 bytes)
;   0x8252..0x8258  (6 bytes)
DATA_tabla_8252:
	defb 018h,083h	; 8252
	defb 038h,083h	; 8254
	defb 058h,083h	; 8256

; ======================================================================
; CODIGO 0x8258..0x825e  (6 bytes)
; ======================================================================


L_8258:
	call L_82FB		;8258
	call 0406bh		;825b   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_825E: 3 destinos del despachador de 0x406B (call en p02:825B):
;   0x8328, 0x8348, 0x8368; lo leen p02:825B (6 bytes)
;   0x825e..0x8264  (6 bytes)
DATA_tabla_825E:
	defb 028h,083h	; 825e
	defb 048h,083h	; 8260
	defb 068h,083h	; 8262

; ======================================================================
; CODIGO 0x8264..0x826a  (6 bytes)
; ======================================================================


L_8264:
	call L_82FB		;8264
	call 0406bh		;8267   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_826A: 3 destinos del despachador de 0x406B (call en p02:8267):
;   0x8330, 0x8350, 0x8370; lo leen p02:8267 (6 bytes)
;   0x826a..0x8270  (6 bytes)
DATA_tabla_826A:
	defb 030h,083h	; 826a
	defb 050h,083h	; 826c
	defb 070h,083h	; 826e

; ======================================================================
; CODIGO 0x8270..0x8276  (6 bytes)
; ======================================================================


L_8270:
	call L_82FB		;8270
	call 0406bh		;8273   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8276: 3 destinos del despachador de 0x406B (call en p02:8273):
;   0x8320, 0x8340, 0x8360; lo leen p02:8273 (6 bytes)
;   0x8276..0x827c  (6 bytes)
DATA_tabla_8276:
	defb 020h,083h	; 8276
	defb 040h,083h	; 8278
	defb 060h,083h	; 827a

; ======================================================================
; CODIGO 0x827c..0x8282  (6 bytes)
; ======================================================================


L_827C:
	call L_82B8		;827c
	call 0406bh		;827f   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8282: 7 destinos del despachador de 0x406B (call en p02:827F):
;   0x8380, 0x8398, 0x83DA, 0x83F2, 0x840A, 0x8428, 0x8440; lo leen p02:827F
;   (14 bytes)
;   0x8282..0x8290  (14 bytes)
DATA_tabla_8282:
	defb 080h,083h	; 8282
	defb 098h,083h	; 8284
	defb 0dah,083h	; 8286
	defb 0f2h,083h	; 8288
	defb 00ah,084h	; 828a
	defb 028h,084h	; 828c
	defb 040h,084h	; 828e

; ======================================================================
; CODIGO 0x8290..0x8296  (6 bytes)
; ======================================================================


L_8290:
	call L_82B8		;8290
	call 0406bh		;8293   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8296: 7 destinos del despachador de 0x406B (call en p02:8293):
;   0x8378, 0x8390, 0x83D2, 0x83EA, 0x8402, 0x8420, 0x8438; lo leen p02:8293
;   (14 bytes)
;   0x8296..0x82a4  (14 bytes)
DATA_tabla_8296:
	defb 078h,083h	; 8296
	defb 090h,083h	; 8298
	defb 0d2h,083h	; 829a
	defb 0eah,083h	; 829c
	defb 002h,084h	; 829e
	defb 020h,084h	; 82a0
	defb 038h,084h	; 82a2

; ======================================================================
; CODIGO 0x82a4..0x82aa  (6 bytes)
; ======================================================================


L_82A4:
	call L_82B8		;82a4
	call 0406bh		;82a7   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_82AA: 7 destinos del despachador de 0x406B (call en p02:82A7):
;   0x8388, 0x83AA, 0x83E2, 0x83FA, 0x8415, 0x8430, 0x8448; lo leen p02:82A7
;   (14 bytes)
;   0x82aa..0x82b8  (14 bytes)
DATA_tabla_82AA:
	defb 088h,083h	; 82aa
	defb 0aah,083h	; 82ac
	defb 0e2h,083h	; 82ae
	defb 0fah,083h	; 82b0
	defb 015h,084h	; 82b2
	defb 030h,084h	; 82b4
	defb 048h,084h	; 82b6

; ======================================================================
; CODIGO 0x82b8..0x82cb  (19 bytes)
; ======================================================================


L_82B8:
	ld a,(ix+000h)		;82b8   ; lee el tipo de la cosa
	dec a			;82bb
	ld hl,082cbh		;82bc
	call 04061h		;82bf   ; hl_mas_a: HL += A
	ld a,(hl)			;82c2
	dec a			;82c3
	ld b,(ix+005h)		;82c4   ; lee la x de la cosa
	ld c,(ix+003h)		;82c7   ; lee la y de la cosa
	ret			;82ca

; ----------------------------------------------------------------------
; DATOS un_byte_de_cada_tipo: 48 bytes, uno por tipo de cosa (desde el 1), que
;   lee p02:82BC
;   0x82cb..0x82fb  (48 bytes)
DATA_un_byte_de_cada_tipo:
	defb 001h,001h,001h,002h,003h,001h,002h,002h,001h,001h,001h,002h,002h,002h,004h,004h	; 82cb  ................
	defb 005h,004h,004h,006h,006h,007h,002h,002h,002h,002h,002h,002h,001h,001h,002h,001h	; 82db  ................
	defb 001h,002h,002h,002h,001h,002h,001h,001h,001h,001h,001h,002h,001h,001h,001h,001h	; 82eb  ................

; ======================================================================
; CODIGO 0x82fb..0x830d  (18 bytes)
; ======================================================================


L_82FB:
	ld a,(ix+000h)		;82fb   ; lee el tipo de la cosa
	dec a			;82fe
	ld hl,0830dh		;82ff
	call 04061h		;8302   ; hl_mas_a: HL += A
	ld a,(hl)			;8305
	ld b,(ix+005h)		;8306   ; lee la x de la cosa
	ld c,(ix+003h)		;8309   ; lee la y de la cosa
	ret			;830c

; ----------------------------------------------------------------------
; DATOS once_valores: once bytes, uno por tipo de cosa (desde el 1), que
;   p02:82FF devuelve en A junto a la posicion (ix+5) y (ix+3)
;   0x830d..0x8318  (11 bytes)
DATA_once_valores:
	defb 000h,000h,000h,002h,000h,001h,001h,002h,002h,000h,002h	; 830d  ...........

; ======================================================================
; CODIGO 0x8318..0x8792  (1146 bytes)
; ======================================================================


L_8318:
	ld hl,00603h		;8318
	ld d,b			;831b
	ld e,c			;831c
	jp L_847A		;831d
L_8320:
	ld hl,00603h		;8320
	ld d,b			;8323
	ld e,c			;8324
	jp L_84A7		;8325
L_8328:
	ld hl,00603h		;8328
	ld d,b			;832b
	ld e,c			;832c
	jp L_84F0		;832d
L_8330:
	ld hl,00603h		;8330
	ld d,b			;8333
	ld e,c			;8334
	jp L_864B		;8335
L_8338:
	ld hl,00606h		;8338
	ld d,b			;833b
	ld e,c			;833c
	jp L_847A		;833d
L_8340:
	ld hl,00606h		;8340
	ld d,b			;8343
	ld e,c			;8344
	jp L_84A7		;8345
L_8348:
	ld hl,00606h		;8348
	ld d,b			;834b
	ld e,c			;834c
	jp L_84F0		;834d
L_8350:
	ld hl,00606h		;8350
	ld d,b			;8353
	ld e,c			;8354
	jp L_864B		;8355
L_8358:
	ld hl,00c06h		;8358
	ld d,b			;835b
	ld e,c			;835c
	jp L_847A		;835d
L_8360:
	ld hl,00c06h		;8360
	ld d,b			;8363
	ld e,c			;8364
	jp L_84A7		;8365
L_8368:
	ld hl,00c06h		;8368
	ld d,b			;836b
	ld e,c			;836c
	jp L_84F0		;836d
L_8370:
	ld hl,00c06h		;8370
	ld d,b			;8373
	ld e,c			;8374
	jp L_864B		;8375
L_8378:
	ld hl,01805h		;8378
	ld d,b			;837b
	ld e,c			;837c
	jp L_847A		;837d
L_8380:
	ld hl,01805h		;8380
	ld d,b			;8383
	ld e,c			;8384
	jp L_84A7		;8385
L_8388:
	ld hl,01805h		;8388
	ld d,b			;838b
	ld e,c			;838c
	jp L_84F0		;838d
L_8390:
	ld hl,01008h		;8390
	ld d,b			;8393
	ld e,c			;8394
	jp L_847A		;8395
L_8398:
	ld d,b			;8398
	ld e,c			;8399
	jr L_83A4		;839a
L_839C:
	call L_83C7		;839c
	jr L_83A4		;839f
L_83A1:
	call L_83BC		;83a1
L_83A4:
	ld hl,01008h		;83a4
	jp L_84A7		;83a7
L_83AA:
	ld d,b			;83aa
	ld e,c			;83ab
	jr L_83B6		;83ac
L_83AE:
	call L_83C7		;83ae
	jr L_83B6		;83b1
L_83B3:
	call L_83BC		;83b3
L_83B6:
	ld hl,01008h		;83b6
	jp L_84F0		;83b9
L_83BC:
	inc l			;83bc
	ld a,(hl)			;83bd
	add a,020h		;83be
	ld e,a			;83c0
	inc l			;83c1
	ld a,(hl)			;83c2
	add a,010h		;83c3
	ld d,a			;83c5
	ret			;83c6
L_83C7:
	inc l			;83c7
	ld a,(hl)			;83c8
	add a,010h		;83c9
	ld e,a			;83cb
	inc l			;83cc
	ld a,(hl)			;83cd
	add a,008h		;83ce
	ld d,a			;83d0
	ret			;83d1
L_83D2:
	ld hl,00a0ch		;83d2
	ld d,b			;83d5
	ld e,c			;83d6
	jp L_847A		;83d7
L_83DA:
	ld hl,00a0ch		;83da
	ld d,b			;83dd
	ld e,c			;83de
	jp L_84A7		;83df
L_83E2:
	ld hl,00a0ch		;83e2
	ld d,b			;83e5
	ld e,c			;83e6
	jp L_84F0		;83e7
L_83EA:
	ld hl,0180ch		;83ea
	ld d,b			;83ed
	ld e,c			;83ee
	jp L_847A		;83ef
L_83F2:
	ld hl,0180ch		;83f2
	ld d,b			;83f5
	ld e,c			;83f6
	jp L_84A7		;83f7
L_83FA:
	ld hl,0180ch		;83fa
	ld d,b			;83fd
	ld e,c			;83fe
	jp L_84F0		;83ff
L_8402:
	ld hl,03010h		;8402
	ld d,b			;8405
	ld e,c			;8406
	jp L_847A		;8407
L_840A:
	ld hl,01805h		;840a
	ld d,b			;840d
	ld a,c			;840e
	sub 020h		;840f
	ld e,a			;8411
	jp L_84A7		;8412
L_8415:
	ld hl,01805h		;8415
	ld d,b			;8418
	ld a,c			;8419
	sub 020h		;841a
	ld e,a			;841c
	jp L_84F0		;841d
L_8420:
	ld hl,02805h		;8420
	ld d,b			;8423
	ld e,c			;8424
	jp L_847A		;8425
L_8428:
	ld hl,02805h		;8428
	ld d,b			;842b
	ld e,c			;842c
	jp L_84A7		;842d
L_8430:
	ld hl,02805h		;8430
	ld d,b			;8433
	ld e,c			;8434
	jp L_84F0		;8435
L_8438:
	ld hl,03008h		;8438
	ld d,b			;843b
	ld e,c			;843c
	jp L_847A		;843d
L_8440:
	ld hl,03008h		;8440
	ld d,b			;8443
	ld e,c			;8444
	jp L_84A7		;8445
L_8448:
	ld hl,03008h		;8448
	ld d,b			;844b
	ld e,c			;844c
	jp L_84F0		;844d
L_8450:
	inc hl			;8450
	ld a,(hl)			;8451
	add a,010h		;8452
	ld e,a			;8454
	inc hl			;8455
	ld a,(hl)			;8456
	add a,008h		;8457
	ld d,a			;8459
	ld hl,01008h		;845a
	jp L_84A7		;845d
L_8460:
	ld a,(ix+004h)		;8460   ; lee la fraccion de la x de la cosa
	cp 002h		;8463
	ld hl,01008h		;8465
	jr c,L_846D		;8468
	ld hl,02010h		;846a
L_846D:
	ld a,(ix+001h)		;846d   ; lee el paso en que va la cosa
	add a,h			;8470
	ld e,a			;8471
	ld a,(ix+002h)		;8472   ; lee la fraccion de la y de la cosa
	add a,l			;8475
	ld d,a			;8476
	jp L_84F0		;8477
L_847A:
	ld a,005h		;847a
	add a,l			;847c
	ld l,a			;847d
	ld a,(0c427h)		;847e   ; lee la X de Simon
	sub d			;8481
	jr nc,L_8486		;8482
	neg		;8484
L_8486:
	cp l			;8486
	ret nc			;8487
	ld c,h			;8488
	ld a,(0c420h)		;8489
	ld b,a			;848c
	dec a			;848d
	cp 002h		;848e
	ld a,012h		;8490
	jr c,L_8496		;8492
	ld a,01ah		;8494
L_8496:
	add a,h			;8496
	ld h,a			;8497
	ld a,b			;8498
	dec a			;8499
	ld a,(0c425h)		;849a   ; lee la Y de Simon
	jr nz,L_84A1		;849d
	sub 008h		;849f
L_84A1:
	sub 002h		;84a1
	sub e			;84a3
	add a,c			;84a4
	cp h			;84a5
	ret			;84a6
L_84A7:
	ld a,(0c416h)		;84a7   ; lee el arma que lleva Simon (0, ninguna)
	dec a			;84aa
	ld a,00ch		;84ab
	jr nz,L_84B1		;84ad
	ld a,010h		;84af
L_84B1:
	add a,l			;84b1
	ld l,a			;84b2
	call L_84D9		;84b3
	jr nc,L_84BA		;84b6
	xor a			;84b8
	ret			;84b9
L_84BA:
	sub d			;84ba
	jr nc,L_84BF		;84bb
	neg		;84bd
L_84BF:
	cp l			;84bf
	ret nc			;84c0
	ld a,(0c420h)		;84c1
	cp 002h		;84c4
	ld b,012h		;84c6
	jr nz,L_84CC		;84c8
	ld b,00ah		;84ca
L_84CC:
	ld c,h			;84cc
	ld a,004h		;84cd
	add a,h			;84cf
	ld h,a			;84d0
	ld a,(0c425h)		;84d1   ; lee la Y de Simon
	sub b			;84d4
	sub e			;84d5
	add a,c			;84d6
	cp h			;84d7
	ret			;84d8
L_84D9:
	ld a,(0c416h)		;84d9   ; lee el arma que lleva Simon (0, ninguna)
	dec a			;84dc
	ld b,014h		;84dd
	jr nz,L_84E3		;84df
	ld b,018h		;84e1
L_84E3:
	ld a,(0c42ch)		;84e3   ; lee el lado al que mira Simon
	and a			;84e6
	ld a,(0c427h)		;84e7   ; lee la X de Simon
	jr z,L_84EE		;84ea
	sub b			;84ec
	ret			;84ed
L_84EE:
	add a,b			;84ee
	ret			;84ef
L_84F0:
	ld iy,0c450h		;84f0
	call L_8500		;84f4
	ret c			;84f7
	ld iy,0c460h		;84f8
	call L_8500		;84fc
	ret			;84ff
L_8500:
	ld a,006h		;8500
	add a,l			;8502
	ld l,a			;8503
	ld a,(iy+005h)		;8504
	sub d			;8507
	jr nc,L_850C		;8508
	neg		;850a
L_850C:
	cp l			;850c
	ret nc			;850d
	ld a,(iy+001h)		;850e
	cp 002h		;8511
	ld b,00ch		;8513
	jr nz,L_8519		;8515
	ld b,006h		;8517
L_8519:
	ld c,h			;8519
	ld a,b			;851a
	add a,h			;851b
	ld h,a			;851c
	ld a,(iy+004h)		;851d
	sub e			;8520
	add a,c			;8521
	cp h			;8522
	ret			;8523
L_8524:
	ld a,(0c420h)		;8524
	cp 004h		;8527
	jr nz,L_8531		;8529
	ld a,(0c428h)		;852b
	cp 003h		;852e
	ret c			;8530
L_8531:
	ld hl,0c598h		;8531
	ld de,00000h		;8534
	ld b,002h		;8537
L_8539:
	ld a,(hl)			;8539
	and a			;853a
	push hl			;853b
	push bc			;853c
	call nz,L_854F		;853d
	pop bc			;8540
	pop hl			;8541
	ld a,007h		;8542
	call 04061h		;8544   ; hl_mas_a: HL += A
	djnz L_8539		;8547
	ld a,d			;8549
	or e			;854a
	ld (0c439h),a		;854b
	ret			;854e
L_854F:
	ld c,(hl)			;854f
	inc hl			;8550
	ld a,(0c425h)		;8551   ; lee la Y de Simon
	sub (hl)			;8554
	cp 008h		;8555
	jr nc,L_856E		;8557
	ld b,007h		;8559
	inc hl			;855b
	ld a,(0c427h)		;855c   ; lee la X de Simon
	sub b			;855f
	sub (hl)			;8560
	cp 020h		;8561
	jr c,L_8578		;8563
	ld a,(0c427h)		;8565   ; lee la X de Simon
	add a,b			;8568
	sub (hl)			;8569
	cp 020h		;856a
	jr c,L_8578		;856c
L_856E:
	ld a,c			;856e
	rra			;856f
	jr c,L_8575		;8570
	ld d,000h		;8572
	ret			;8574
L_8575:
	ld e,000h		;8575
	ret			;8577
L_8578:
	ld a,c			;8578
	rra			;8579
	jr c,L_857E		;857a
	ld d,c			;857c
	ret			;857d
L_857E:
	ld e,c			;857e
	ret			;857f
L_8580:
	ld a,(0c42ch)		;8580   ; lee el lado al que mira Simon
	and a			;8583
	jr z,L_858C		;8584
	ld a,c			;8586
	sub 008h		;8587
	ld c,a			;8589
	jr L_8590		;858a
L_858C:
	ld a,c			;858c
	add a,008h		;858d
	ld c,a			;858f
L_8590:
	dec b			;8590
	dec b			;8591
	ld a,(0c5adh)		;8592   ; lee donde esta la puerta de la fase
	sub 008h		;8595
	ld d,a			;8597
	ld a,b			;8598
	sub d			;8599
	cp 038h		;859a
	ret nc			;859c
	ld a,(0c5aeh)		;859d
	ld d,a			;85a0
	ld a,c			;85a1
	sub d			;85a2
	cp 008h		;85a3
	ret			;85a5
L_85A6:
	ld a,(0c420h)		;85a6
	cp 006h		;85a9
	ret z			;85ab
	ld a,(0c42dh)		;85ac
	and a			;85af
	ret nz			;85b0
	ld a,(0c43ah)		;85b1
	and a			;85b4
	ret nz			;85b5
	ld hl,0c580h		;85b6
	ld b,003h		;85b9
L_85BB:
	ld a,(hl)			;85bb
	and a			;85bc
	jr z,L_85D6		;85bd
	push hl			;85bf
	call L_85DE		;85c0
	pop hl			;85c3
	jr nc,L_85D6		;85c4
	ld a,005h		;85c6
	ld (0c420h),a		;85c8
	ld a,(hl)			;85cb
	rra			;85cc
	ld b,008h		;85cd
	jr nc,L_85D3		;85cf
	ld b,010h		;85d1
L_85D3:
	jp 0462bh		;85d3
L_85D6:
	ld a,008h		;85d6
	call 04061h		;85d8   ; hl_mas_a: HL += A
	djnz L_85BB		;85db
	ret			;85dd
L_85DE:
	inc hl			;85de
	ld a,(hl)			;85df
	ld d,a			;85e0
	ld a,(0c425h)		;85e1   ; lee la Y de Simon
	sub 01ch		;85e4
	sub d			;85e6
	cp 008h		;85e7
	ret nc			;85e9
	inc hl			;85ea
	ld a,(hl)			;85eb
	ld d,a			;85ec
	ld a,(0c427h)		;85ed   ; lee la X de Simon
	sub d			;85f0
	cp 020h		;85f1
	ret			;85f3
L_85F4:
	ld hl,0c5b1h		;85f4
	ld a,(hl)			;85f7
	and a			;85f8
	ret z			;85f9
	inc hl			;85fa
	ld a,(hl)			;85fb
	ld d,a			;85fc
	ld a,(0c425h)		;85fd   ; lee la Y de Simon
	sub 004h		;8600
	sub d			;8602
	cp 010h		;8603
	ret nc			;8605
	inc hl			;8606
	ld a,(hl)			;8607
	ld d,a			;8608
	ld a,(0c427h)		;8609   ; lee la X de Simon
	sub d			;860c
	cp 010h		;860d
	ret			;860f
L_8610:
	ld a,(0c701h)		;8610
	and 020h		;8613
	ret z			;8615
	ld ix,0d700h		;8616
	ld b,008h		;861a
L_861C:
	push bc			;861c
	ld a,(ix+000h)		;861d   ; lee el tipo de la cosa
	and a			;8620
	jr z,L_8642		;8621
	cp 00ch		;8623
	jr z,L_8642		;8625
	call L_8264		;8627
	jr nc,L_8642		;862a
	call L_9A1A		;862c
	ld a,00bh		;862f
	call 0509fh		;8631   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld hl,0c441h		;8634
	dec (hl)			;8637
	jr nz,L_8642		;8638
	ld hl,0c701h		;863a
	res 5,(hl)		;863d
	call L_8EE6		;863f
L_8642:
	pop bc			;8642
	ld de,00080h		;8643
	add ix,de		;8646
	djnz L_861C		;8648
	ret			;864a
L_864B:
	ld a,004h		;864b
	add a,l			;864d
	ld l,a			;864e
	ld a,(0c42ch)		;864f   ; lee el lado al que mira Simon
	and a			;8652
	ld a,008h		;8653
	jr z,L_8659		;8655
	neg		;8657
L_8659:
	ld b,a			;8659
	ld a,(0c427h)		;865a   ; lee la X de Simon
	add a,b			;865d
	sub d			;865e
	jr nc,L_8663		;865f
	neg		;8661
L_8663:
	cp l			;8663
	ret nc			;8664
	ld c,h			;8665
	ld a,020h		;8666
	add a,h			;8668
	ld h,a			;8669
	ld a,(0c425h)		;866a   ; lee la Y de Simon
	sub e			;866d
	add a,c			;866e
	cp h			;866f
	ret			;8670
L_8671:
	ld bc,00800h		;8671
	ld hl,0c470h		;8674
L_8677:
	push bc			;8677
	push hl			;8678
	push hl			;8679
	pop ix		;867a
	ld a,(hl)			;867c
	ld b,a			;867d
	or a			;867e
	call nz,L_868C		;867f
	pop hl			;8682
	pop bc			;8683
	inc c			;8684
	ld a,l			;8685
	add a,010h		;8686
	ld l,a			;8688
	djnz L_8677		;8689
	ret			;868b
L_868C:
	ld (hl),002h		;868c
	inc l			;868e
	ld e,(hl)			;868f
	inc l			;8690
	ld d,(hl)			;8691
	inc l			;8692
	ld a,(hl)			;8693
	or a			;8694
	jp nz,L_87BA		;8695
	inc l			;8698
	ld a,(hl)			;8699
	ex af,af'			;869a
	inc l			;869b
	inc l			;869c
	inc (hl)			;869d
	ld a,b			;869e
	cp 001h		;869f
	jr nz,L_86B3		;86a1
	ex af,af'			;86a3
	push af			;86a4
	push de			;86a5
	call L_873A		;86a6
	pop de			;86a9
	pop af			;86aa
	cp 002h		;86ab
	jp c,L_86BB		;86ad
	jp L_86CA		;86b0
L_86B3:
	ld a,(hl)			;86b3
	and 003h		;86b4
	ret nz			;86b6
	ex af,af'			;86b7
	cp 002h		;86b8
	ret nc			;86ba
L_86BB:
	or a			;86bb
	ld a,000h		;86bc
	jr z,L_86C2		;86be
	ld a,002h		;86c0
L_86C2:
	bit 3,(hl)		;86c2
	jr z,L_86C7		;86c4
	inc a			;86c6
L_86C7:
	jp L_898A		;86c7
L_86CA:
	ld b,a			;86ca
	ld a,(0d002h)		;86cb   ; lee el bloque de tres fases (0-5)
	or a			;86ce
	ld hl,08792h		;86cf
	jr z,L_86D7		;86d2
	ld hl,087a6h		;86d4
L_86D7:
	ld a,b			;86d7
	ld bc,01002h		;86d8
	cp 002h		;86db
	jr z,L_86E7		;86dd
	ld bc,02004h		;86df
	ld a,004h		;86e2
	call 04061h		;86e4   ; hl_mas_a: HL += A
L_86E7:
	push bc			;86e7
	push de			;86e8
	ld b,c			;86e9
	push bc			;86ea
	push hl			;86eb
	push de			;86ec
	call L_877C		;86ed
	pop de			;86f0
	call 07d2fh		;86f1   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	pop de			;86f4
	pop bc			;86f5
	ex de,hl			;86f6
	call L_88B7		;86f7
	pop hl			;86fa
	pop de			;86fb
	ld e,d			;86fc
	ld a,(0c702h)		;86fd
	rra			;8700
	ret nc			;8701
L_8702:
	ld c,00eh		;8702
	jp 048dch		;8704
L_8707:
	ld a,(0c702h)		;8707
	rra			;870a
	ret nc			;870b
L_870C:
	ld bc,00800h		;870c
	ld hl,0c470h		;870f
L_8712:
	push bc			;8712
	push hl			;8713
	ld a,(hl)			;8714
	cp 002h		;8715
	jr nz,L_8730		;8717
	inc l			;8719
	ld e,(hl)			;871a
	inc l			;871b
	ld d,(hl)			;871c
	inc l			;871d
	inc l			;871e
	ld a,(hl)			;871f
	cp 002h		;8720
	jr c,L_8730		;8722
	ex de,hl			;8724
	ld de,01010h		;8725
	jr z,L_872D		;8728
	ld de,02020h		;872a
L_872D:
	call L_8702		;872d
L_8730:
	pop hl			;8730
	pop bc			;8731
	inc c			;8732
	ld a,l			;8733
	add a,010h		;8734
	ld l,a			;8736
	djnz L_8712		;8737
	ret			;8739
L_873A:
	cp 003h		;873a
	ld hl,0e4a0h		;873c
	jr z,L_8757		;873f
	ld hl,0e480h		;8741
L_8744:
	push hl			;8744
	push bc			;8745
	call 07d2fh		;8746   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	pop bc			;8749
	pop de			;874a
	ld a,c			;874b
	add a,a			;874c
	add a,a			;874d
	call 04066h		;874e   ; de_mas_a: DE += A
	ld bc,00202h		;8751
	jp L_876C		;8754
L_8757:
	push hl			;8757
	push bc			;8758
	call 07d2fh		;8759   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	pop bc			;875c
	pop de			;875d
	ld a,c			;875e
	add a,a			;875f
	add a,a			;8760
	add a,a			;8761
	add a,a			;8762
	call 04066h		;8763   ; de_mas_a: DE += A
	ld bc,00404h		;8766
	jp L_876C		;8769
L_876C:
	push bc			;876c
	ld b,000h		;876d
	push hl			;876f
	ldir		;8770
	pop hl			;8772
	pop bc			;8773
	ld a,020h		;8774
	call 04061h		;8776   ; hl_mas_a: HL += A
	djnz L_876C		;8779
	ret			;877b
L_877C:
	push bc			;877c
	push de			;877d
	ld b,c			;877e
L_877F:
	ld a,(hl)			;877f
	inc hl			;8780
	call 04b0bh		;8781
	call 04b4fh		;8784
	djnz L_877F		;8787
	pop de			;8789
	ld a,e			;878a
	add a,008h		;878b
	ld e,a			;878d
	pop bc			;878e
	djnz L_877C		;878f
	ret			;8791

; ----------------------------------------------------------------------
; DATOS dos_tablas_de_veinte: dos tablas de 20 bytes que elige p02:86CB: la de
;   0x8792 en el primer bloque de fases (0xD002 = 0) y la de 0x87A6 en los
;   demas
;   0x8792..0x87ba  (40 bytes)
DATA_dos_tablas_de_veinte:
	defb 001h,002h,009h,00bh,001h,002h,001h,002h,009h,00bh,00ah,009h,001h,002h,001h,002h	; 8792  ................
	defb 009h,00bh,00ah,009h,001h,002h,00ah,00bh,001h,002h,001h,002h,00ah,00bh,00ah,00bh	; 87a2  ................
	defb 001h,002h,001h,002h,00ah,00bh,00ah,00bh	; 87b2  ........

; ======================================================================
; CODIGO 0x87ba..0x892a  (368 bytes)
; ======================================================================


L_87BA:
	ld (hl),000h		;87ba
	inc l			;87bc
	ld (ix+000h),000h		;87bd   ; el tipo de la cosa = 0x00
	ld a,(hl)			;87c1
	inc l			;87c2
	ld b,(hl)			;87c3
	cp 002h		;87c4
	jp nc,L_87D2		;87c6
	call L_884A		;87c9
	call L_8874		;87cc
	jp L_898F		;87cf
L_87D2:
	push bc			;87d2
	push de			;87d3
	push bc			;87d4
	ld c,a			;87d5
	ld a,00eh		;87d6
	call 0509fh		;87d8   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,c			;87db
	pop bc			;87dc
	cp 002h		;87dd
	jr z,L_87E9		;87df
	call L_885E		;87e1
	call L_8899		;87e4
	jr L_87EF		;87e7
L_87E9:
	call L_884A		;87e9
	call L_887D		;87ec
L_87EF:
	ld a,(ix+005h)		;87ef   ; lee la x de la cosa
	cp 01fh		;87f2
	jr z,L_8814		;87f4
	cp 018h		;87f6
	jr z,L_883E		;87f8
	call L_8874		;87fa
	pop de			;87fd
	pop bc			;87fe
	ld a,b			;87ff
	or a			;8800
	jr z,L_8811		;8801
	ld a,(ix+004h)		;8803   ; lee la fraccion de la x de la cosa
	cp 003h		;8806
	jr nz,L_880E		;8808
	ld a,e			;880a
	add a,010h		;880b
	ld e,a			;880d
L_880E:
	call L_89E3		;880e
L_8811:
	jp L_88C7		;8811
L_8814:
	pop de			;8814
	pop bc			;8815
	ld a,(ix+009h)		;8816   ; lee la velocidad horizontal (parte baja)
	ld b,a			;8819
	ld h,(ix+007h)		;881a   ; lee la velocidad vertical (parte baja)
	ld l,(ix+008h)		;881d   ; lee la velocidad vertical
	and 0c0h		;8820
	cp 0c0h		;8822
	ld a,b			;8824
	jr z,L_8831		;8825
	and 01fh		;8827
	ld b,a			;8829
	ld a,e			;882a
	add a,010h		;882b
	ld e,a			;882d
	jp L_8A13		;882e
L_8831:
	ld c,a			;8831
	and 03ch		;8832
	rrca			;8834
	rrca			;8835
	ld b,a			;8836
	ld a,c			;8837
	and 003h		;8838
	ld c,a			;883a
	jp L_9179		;883b
L_883E:
	ld b,a			;883e
	pop de			;883f
	pop bc			;8840
	ld h,(ix+007h)		;8841   ; lee la velocidad vertical (parte baja)
	ld l,(ix+008h)		;8844   ; lee la velocidad vertical
	jp L_89FD		;8847
L_884A:
	ld hl,0e480h		;884a
L_884D:
	push bc			;884d
	push de			;884e
	ld a,c			;884f
	add a,a			;8850
	add a,a			;8851
	call 04061h		;8852   ; hl_mas_a: HL += A
	ld bc,00202h		;8855
	call L_877C		;8858
	pop de			;885b
	pop bc			;885c
	ret			;885d
L_885E:
	ld hl,0e4a0h		;885e
L_8861:
	push bc			;8861
	push de			;8862
	ld a,c			;8863
	add a,a			;8864
	add a,a			;8865
	add a,a			;8866
	add a,a			;8867
	call 04061h		;8868   ; hl_mas_a: HL += A
	ld bc,00404h		;886b
	call L_877C		;886e
	pop de			;8871
	pop bc			;8872
	ret			;8873
L_8874:
	ld h,(ix+007h)		;8874   ; lee la velocidad vertical (parte baja)
	ld l,(ix+008h)		;8877   ; lee la velocidad vertical
	ld (hl),000h		;887a
	ret			;887c
L_887D:
	ld hl,0e480h		;887d
	push bc			;8880
	push de			;8881
	push hl			;8882
	push bc			;8883
	call 07d2fh		;8884   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	pop bc			;8887
	pop de			;8888
	ld a,c			;8889
	add a,a			;888a
	add a,a			;888b
	call 04066h		;888c   ; de_mas_a: DE += A
	ex de,hl			;888f
	ld bc,00202h		;8890
	call L_88B7		;8893
	pop de			;8896
	pop bc			;8897
	ret			;8898
L_8899:
	ld hl,0e4a0h		;8899
L_889C:
	push bc			;889c
	push de			;889d
	push hl			;889e
	push bc			;889f
	call 07d2fh		;88a0   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	pop bc			;88a3
	pop de			;88a4
	ld a,c			;88a5
	add a,a			;88a6
	add a,a			;88a7
	add a,a			;88a8
	add a,a			;88a9
	call 04066h		;88aa   ; de_mas_a: DE += A
	ex de,hl			;88ad
	ld bc,00404h		;88ae
	call L_88B7		;88b1
	pop de			;88b4
	pop bc			;88b5
	ret			;88b6
L_88B7:
	push bc			;88b7
	ld b,000h		;88b8
	push de			;88ba
	ldir		;88bb
	pop de			;88bd
	pop bc			;88be
	ld a,020h		;88bf
	call 04066h		;88c1   ; de_mas_a: DE += A
	djnz L_88B7		;88c4
	ret			;88c6
L_88C7:
	ld hl,0c5a6h		;88c7
	ld bc,00201h		;88ca
L_88CD:
	ld (hl),c			;88cd
	inc l			;88ce
	ld (hl),e			;88cf
	inc l			;88d0
	ld (hl),d			;88d1
	inc l			;88d2
	ld c,084h		;88d3
	djnz L_88CD		;88d5
	ret			;88d7
L_88D8:
	ld b,002h		;88d8
	ld hl,0c5a6h		;88da
L_88DD:
	push bc			;88dd
	push hl			;88de
	ld a,(hl)			;88df
	ld b,a			;88e0
	or a			;88e1
	jr z,L_88EA		;88e2
	call L_88F2		;88e4
	call L_893B		;88e7
L_88EA:
	pop hl			;88ea
	inc l			;88eb
	inc l			;88ec
	inc l			;88ed
	pop bc			;88ee
	djnz L_88DD		;88ef
	ret			;88f1
L_88F2:
	and 07fh		;88f2
	ld c,a			;88f4
	inc l			;88f5
	inc l			;88f6
	ld a,(hl)			;88f7
	bit 7,b		;88f8
	jr nz,L_8903		;88fa
	add a,002h		;88fc
	jr c,L_8922		;88fe
	ld (hl),a			;8900
	jr L_8908		;8901
L_8903:
	sub 002h		;8903
	jr c,L_8922		;8905
	ld (hl),a			;8907
L_8908:
	dec l			;8908
	dec l			;8909
	ld a,c			;890a
	inc a			;890b
	ld de,l8928h		;890c
	call 04066h		;890f   ; de_mas_a: DE += A
	ld a,(de)			;8912
	inc (hl)			;8913
	or a			;8914
	jr nz,L_891A		;8915
	dec (hl)			;8917
	ld a,00ah		;8918
L_891A:
	inc l			;891a
	add a,(hl)			;891b
	ld (hl),a			;891c
	cp 0d4h		;891d
	jr nc,L_8923		;891f
	ret			;8921
L_8922:
	dec l			;8922
L_8923:
	ld (hl),0e0h		;8923
	dec l			;8925
	ld (hl),000h		;8926
L_8928:
	inc l			;8928
	ret			;8929

; ----------------------------------------------------------------------
; DATOS curva_sin_usar: 17 desplazamientos (-6, -4, ... +6 y un 0) con forma
;   de curva de salto que no nombra ninguna instruccion; su direccion no
;   aparece como palabra en el cartucho
;   0x892a..0x893b  (17 bytes)
DATA_curva_sin_usar:
	defb 0fah,0fch,0fch,0fch,0feh,0feh,0ffh,0ffh,001h,001h,002h,002h,004h,004h,004h,006h	; 892a  ................
	defb 000h	; 893a

; ======================================================================
; CODIGO 0x893b..0x8a8d  (338 bytes)
; ======================================================================


L_893B:
	ld hl,0c5a7h		;893b
	ld de,0d628h		;893e
	ld b,002h		;8941
L_8943:
	push bc			;8943
	push hl			;8944
	ld bc,002ffh		;8945
	ld a,0e0h		;8948
L_894A:
	push hl			;894a
	ldi		;894b
	ldi		;894d
	ld (de),a			;894f
	inc de			;8950
	inc de			;8951
	ld a,0e4h		;8952
	pop hl			;8954
	djnz L_894A		;8955
	pop hl			;8957
	inc hl			;8958
	inc hl			;8959
	inc hl			;895a
	pop bc			;895b
	djnz L_8943		;895c
	ld hl,0d4a0h		;895e
	ld a,002h		;8961
	call L_8972		;8963
	ld a,04ch		;8966
	call L_8972		;8968
	ld a,002h		;896b
	call L_8972		;896d
	ld a,04ch		;8970
L_8972:
	ld b,010h		;8972
L_8974:
	ld (hl),a			;8974
	inc hl			;8975
	djnz L_8974		;8976
	ret			;8978
L_8979:
	ld a,005h		;8979
	ld l,070h		;897b
L_897D:
	add a,a			;897d
	add a,a			;897e
	add a,a			;897f
	add a,a			;8980
	ld h,a			;8981
	ld bc,01010h		;8982
	ld a,001h		;8985
	jp 04946h		;8987   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_898A:
	ld l,070h		;898a
	jp L_8CCB		;898c
L_898F:
	call L_8A29		;898f
L_8992:
	ld a,b			;8992
	or a			;8993
	jr z,L_899E		;8994
	cp 015h		;8996
	jr z,L_899E		;8998
	call L_89BF		;899a
	ret z			;899d
L_899E:
	call L_8A37		;899e
	ret nz			;89a1
	ld (hl),001h		;89a2
	inc l			;89a4
	ld (hl),e			;89a5
	inc l			;89a6
	ld (hl),d			;89a7
	inc l			;89a8
	ld (hl),000h		;89a9
	inc l			;89ab
	ld (hl),b			;89ac
	inc l			;89ad
	ld (hl),000h		;89ae
	ld a,b			;89b0
	cp 015h		;89b1
	jr z,L_89BB		;89b3
	cp 002h		;89b5
	jr c,L_89BB		;89b7
	ld (hl),002h		;89b9
L_89BB:
	inc l			;89bb
	ld (hl),000h		;89bc
	ret			;89be
L_89BF:
	push bc			;89bf
	push de			;89c0
	push ix		;89c1
	ld a,e			;89c3
	add a,010h		;89c4
	ld e,a			;89c6
	ld a,d			;89c7
	add a,008h		;89c8
	ld d,a			;89ca
	ld a,b			;89cb
	cp 001h		;89cc
	jr nz,L_89D4		;89ce
	ld c,01eh		;89d0
	jr L_89D6		;89d2
L_89D4:
	ld c,026h		;89d4
L_89D6:
	xor a			;89d6
	call 05f1fh		;89d7
	ld a,(0cf31h)		;89da
	dec a			;89dd
	pop ix		;89de
	pop de			;89e0
	pop bc			;89e1
	ret			;89e2
L_89E3:
	ld a,b			;89e3
	cp 015h		;89e4
	jp z,L_8992		;89e6
	call L_8A29		;89e9
	call L_8A37		;89ec
	ret nz			;89ef
L_89F0:
	ld (hl),083h		;89f0
	inc l			;89f2
	ld (hl),e			;89f3
	inc l			;89f4
	ld (hl),d			;89f5
	inc l			;89f6
	inc l			;89f7
	ld (hl),b			;89f8
	inc l			;89f9
	ld (hl),0ffh		;89fa
	ret			;89fc
L_89FD:
	ld (0c70dh),hl		;89fd
	call L_8A37		;8a00
	ret nz			;8a03
	call L_89F0		;8a04
	ld a,l			;8a07
	add a,009h		;8a08
	ld l,a			;8a0a
L_8A0B:
	ld de,(0c70dh)		;8a0b
	ld (hl),d			;8a0f
	inc l			;8a10
	ld (hl),e			;8a11
	ret			;8a12
L_8A13:
	ld (0c70dh),hl		;8a13
	call L_8A37		;8a16
	ret nz			;8a19
	push bc			;8a1a
	ld b,019h		;8a1b
	call L_89F0		;8a1d
	pop bc			;8a20
	ld a,l			;8a21
	add a,008h		;8a22
	ld l,a			;8a24
	ld (hl),b			;8a25
	inc l			;8a26
	jr L_8A0B		;8a27
L_8A29:
	ld a,b			;8a29
	cp 01ah		;8a2a
	ret c			;8a2c
	ld a,(0c416h)		;8a2d   ; lee el arma que lleva Simon (0, ninguna)
	add a,019h		;8a30
	cp b			;8a32
	ret nz			;8a33
	ld b,001h		;8a34
	ret			;8a36
L_8A37:
	push bc			;8a37
	ld hl,0c500h		;8a38
	ld b,008h		;8a3b
L_8A3D:
	ld a,(hl)			;8a3d
	or a			;8a3e
	jr z,L_8A48		;8a3f
	ld a,010h		;8a41
	add a,l			;8a43
	ld l,a			;8a44
	djnz L_8A3D		;8a45
	or a			;8a47
L_8A48:
	pop bc			;8a48
	ret			;8a49
L_8A4A:
	call L_8F55		;8a4a
	ld bc,00800h		;8a4d
	ld hl,0c500h		;8a50
L_8A53:
	push hl			;8a53
	pop ix		;8a54
	push bc			;8a56
	push hl			;8a57
	ld a,(hl)			;8a58
	ld b,a			;8a59
	or a			;8a5a
	jr z,L_8A63		;8a5b
	call L_8A6D		;8a5d
	call L_8C60		;8a60
L_8A63:
	pop hl			;8a63
	pop bc			;8a64
	ld a,010h		;8a65
	add a,l			;8a67
	ld l,a			;8a68
	inc c			;8a69
	djnz L_8A53		;8a6a
	ret			;8a6c
L_8A6D:
	ld e,(ix+001h)		;8a6d   ; lee el paso en que va la cosa
	ld d,(ix+002h)		;8a70   ; lee la fraccion de la y de la cosa
	ex af,af'			;8a73
	ld a,(ix+003h)		;8a74   ; lee la y de la cosa
	dec a			;8a77
	jp z,L_8BDF		;8a78
	ex af,af'			;8a7b
	dec a			;8a7c
	and 07fh		;8a7d
	exx			;8a7f
	ld hl,08a8dh		;8a80
	add a,a			;8a83
	call 04061h		;8a84   ; hl_mas_a: HL += A
	ld e,(hl)			;8a87
	inc hl			;8a88
	ld d,(hl)			;8a89
	push de			;8a8a
	exx			;8a8b
	ret			;8a8c

; ----------------------------------------------------------------------
; DATOS tabla_de_p02_8A80: seis destinos del despachador hecho a mano de
;   p02:8A80 (`push de / exx / ret`): 0x8A99, 0x8AF8, 0x8B70, 0x8BA2, 0x8BCC y
;   otra vez 0x8A99
;   0x8a8d..0x8a99  (12 bytes)
DATA_tabla_de_p02_8A80:
	defb 099h,08ah,0f8h,08ah,070h,08bh,0a2h,08bh,0cch,08bh,099h,08ah	; 8a8d  ....p.......

; ======================================================================
; CODIGO 0x8a99..0x8af0  (87 bytes)
; ======================================================================


L_8A99:
	inc (ix+006h)		;8a99   ; sube si la cosa se mueve
	ld a,(ix+006h)		;8a9c   ; lee si la cosa se mueve
	and 00fh		;8a9f
	ret nz			;8aa1
	inc (hl)			;8aa2
	ld a,(ix+004h)		;8aa3   ; lee la fraccion de la x de la cosa
	or a			;8aa6
	jp z,L_8B1B		;8aa7
	cp 015h		;8aaa
	jr z,L_8AD0		;8aac
	set 7,(hl)		;8aae
	dec a			;8ab0
	ld a,001h		;8ab1
	jr z,L_8AB7		;8ab3
	ld a,002h		;8ab5
L_8AB7:
	ld (ix+005h),a		;8ab7   ; guarda la x de la cosa
	ret nz			;8aba
	ld (ix+006h),000h		;8abb   ; la cosa se queda quieta
	ld (ix+009h),002h		;8abf   ; la velocidad horizontal (parte baja) = 0x02
	ld (ix+00ah),000h		;8ac3   ; la velocidad horizontal (el bit 7, hacia la izquierda) = 0x00
	ld (ix+00bh),000h		;8ac7   ; el dibujo de la cosa = 0x00
	ld (ix+00ch),020h		;8acb   ; la cuenta de cuadros del paso = 0x20
	ret			;8acf
L_8AD0:
	ld a,(0d002h)		;8ad0   ; lee el bloque de tres fases (0-5)
	or a			;8ad3
	ld b,a			;8ad4
	jr z,L_8AED		;8ad5
	ld a,b			;8ad7
	dec a			;8ad8
	and 007h		;8ad9
	ld hl,08af0h		;8adb
	call 04061h		;8ade   ; hl_mas_a: HL += A
	ld c,(hl)			;8ae1
	push ix		;8ae2
	ld a,e			;8ae4
	add a,010h		;8ae5
	ld e,a			;8ae7
	call 05f1dh		;8ae8   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	pop ix		;8aeb
L_8AED:
	jp L_8B1B		;8aed

; ----------------------------------------------------------------------
; DATOS ocho_valores: ocho bytes que lee p02:8ADB, dentro del primer destino
;   del despachador de p02:8A80
;   0x8af0..0x8af8  (8 bytes)
DATA_ocho_valores:
	defb 01ah,01ch,01bh,01bh,01bh,01bh,01ch,01ch	; 8af0  ........

; ======================================================================
; CODIGO 0x8af8..0x8cbd  (453 bytes)
; ======================================================================


L_8AF8:
	ld hl,00810h		;8af8
	add hl,de			;8afb
	ld a,0dbh		;8afc
	cp l			;8afe
	jr c,L_8B1B		;8aff
	ex de,hl			;8b01
	call 07d2fh		;8b02   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	sub 001h		;8b05
	cp 009h		;8b07
	jr c,L_8B68		;8b09
	ld a,(ix+004h)		;8b0b   ; lee la fraccion de la x de la cosa
	dec a			;8b0e
	jp z,L_8B22		;8b0f
	ld a,(ix+001h)		;8b12   ; lee el paso en que va la cosa
	add a,008h		;8b15
	ld (ix+001h),a		;8b17   ; guarda el paso en que va la cosa
	ret			;8b1a
L_8B1B:
	ld (ix+005h),0ffh		;8b1b   ; la x de la cosa = 0xFF
	jp L_8BC7		;8b1f
L_8B22:
	push ix		;8b22
	pop hl			;8b24
	inc l			;8b25
	inc (ix+006h)		;8b26   ; sube si la cosa se mueve
	ld a,(0c003h)		;8b29   ; lee el contador de cuadros
	rra			;8b2c
	jr nc,L_8B30		;8b2d
	inc (hl)			;8b2f
L_8B30:
	inc l			;8b30
	ld d,(hl)			;8b31
	ld e,(ix+008h)		;8b32   ; lee la velocidad vertical
	ex de,hl			;8b35
	ld b,(ix+009h)		;8b36   ; lee la velocidad horizontal (parte baja)
	ld c,(ix+00ah)		;8b39   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	add hl,bc			;8b3c
	ex de,hl			;8b3d
	ld (ix+008h),e		;8b3e   ; guarda la velocidad vertical
	ld (hl),d			;8b41
	ld h,b			;8b42
	ld l,c			;8b43
	ld b,(ix+00bh)		;8b44   ; lee el dibujo de la cosa
	ld c,(ix+00ch)		;8b47   ; lee la cuenta de cuadros del paso
	and a			;8b4a
	sbc hl,bc		;8b4b
	ld (ix+009h),h		;8b4d   ; guarda la velocidad horizontal (parte baja)
	ld (ix+00ah),l		;8b50   ; guarda la velocidad horizontal (el bit 7, hacia la izquierda)
	ld a,(ix+006h)		;8b53   ; lee si la cosa se mueve
	sub 020h		;8b56
	ret nz			;8b58
	ld (ix+006h),a		;8b59   ; guarda si la cosa se mueve
	ld a,b			;8b5c
	cpl			;8b5d
	ld (ix+00bh),a		;8b5e   ; guarda el dibujo de la cosa
	ld a,c			;8b61
	neg		;8b62
	ld (ix+00ch),a		;8b64   ; guarda la cuenta de cuadros del paso
	ret			;8b67
L_8B68:
	ld (ix+005h),0ffh		;8b68   ; la x de la cosa = 0xFF
	inc (ix+000h)		;8b6c   ; sube el tipo de la cosa
	ret			;8b6f
L_8B70:
	ld a,e			;8b70
	add a,004h		;8b71
	and 0f8h		;8b73
	ld e,a			;8b75
	ld a,d			;8b76
	add a,004h		;8b77
	and 0f8h		;8b79
	ld d,a			;8b7b
	ld (ix+001h),e		;8b7c   ; guarda el paso en que va la cosa
	ld (ix+002h),d		;8b7f   ; guarda la fraccion de la y de la cosa
	push de			;8b82
	call L_8CD8		;8b83
	pop de			;8b86
	ld a,(ix+004h)		;8b87   ; lee la fraccion de la x de la cosa
	dec a			;8b8a
	call L_8CC1		;8b8b
	ld a,(ix+004h)		;8b8e   ; lee la fraccion de la x de la cosa
	sub 017h		;8b91
	cp 003h		;8b93
	ld a,008h		;8b95
	jr nc,L_8B9B		;8b97
	ld a,0ffh		;8b99
L_8B9B:
	ld (ix+006h),a		;8b9b   ; guarda si la cosa se mueve
	inc (ix+000h)		;8b9e   ; sube el tipo de la cosa
	ret			;8ba1
L_8BA2:
	set 7,(hl)		;8ba2
	ld a,(ix+003h)		;8ba4   ; lee la y de la cosa
	cp 002h		;8ba7
	jp z,L_8C44		;8ba9
	push de			;8bac
	ld a,(ix+004h)		;8bad   ; lee la fraccion de la x de la cosa
	dec a			;8bb0
	call L_8CC1		;8bb1
	pop de			;8bb4
	ld a,(ix+006h)		;8bb5   ; lee si la cosa se mueve
	inc a			;8bb8
	ret z			;8bb9
	ld a,(0c003h)		;8bba   ; lee el contador de cuadros
	and 00fh		;8bbd
	ret nz			;8bbf
	dec (ix+006h)		;8bc0   ; baja si la cosa se mueve
	ret nz			;8bc3
	call L_8CE6		;8bc4
L_8BC7:
	ld (ix+000h),000h		;8bc7   ; el tipo de la cosa = 0x00
	ret			;8bcb
L_8BCC:
	inc (ix+006h)		;8bcc   ; sube si la cosa se mueve
	ld a,(ix+006h)		;8bcf   ; lee si la cosa se mueve
	and 01fh		;8bd2
	ret nz			;8bd4
	ld (hl),002h		;8bd5
	ld a,(ix+004h)		;8bd7   ; lee la fraccion de la x de la cosa
	or a			;8bda
	jp z,L_8B1B		;8bdb
	ret			;8bde
L_8BDF:
	ld (ix+003h),000h		;8bdf   ; la y de la cosa = 0x00
	call L_8F68		;8be3
	ret nz			;8be6
	ld a,(hl)			;8be7
	and 07fh		;8be8
	ld (hl),000h		;8bea
	cp 004h		;8bec
	jr nz,L_8BF3		;8bee
	call L_8CE6		;8bf0
L_8BF3:
	ld a,(ix+004h)		;8bf3   ; lee la fraccion de la x de la cosa
	cp 019h		;8bf6
	jr z,L_8C14		;8bf8
	ld (ix+005h),0ffh		;8bfa   ; la x de la cosa = 0xFF
	call L_8D29		;8bfe
	ld a,(ix+004h)		;8c01   ; lee la fraccion de la x de la cosa
	cp 017h		;8c04
	jr z,L_8C0B		;8c06
	cp 018h		;8c08
	ret nz			;8c0a
L_8C0B:
	ld h,(ix+00eh)		;8c0b
	ld l,(ix+00fh)		;8c0e
	ld (hl),000h		;8c11
	ret			;8c13
L_8C14:
	ld a,(ix+00dh)		;8c14
	ld (ix+004h),a		;8c17   ; guarda la fraccion de la x de la cosa
	call L_8C2F		;8c1a
	ld a,(0c700h)		;8c1d
	or a			;8c20
	jr nz,L_8C0B		;8c21
	ld hl,0c701h		;8c23
	ld a,(hl)			;8c26
	and 0f9h		;8c27
	ld (hl),a			;8c29
	call L_8EC9		;8c2a
	jr L_8C0B		;8c2d
L_8C2F:
	ld a,(ix+001h)		;8c2f   ; lee el paso en que va la cosa
	sub 008h		;8c32
	ld (ix+001h),a		;8c34   ; guarda el paso en que va la cosa
	ld (ix+000h),005h		;8c37   ; el tipo de la cosa = 0x05
	ld (ix+006h),000h		;8c3b   ; la cosa se queda quieta
	ld (ix+005h),002h		;8c3f   ; la x de la cosa = 0x02
	ret			;8c43
L_8C44:
	ld (ix+003h),000h		;8c44   ; la y de la cosa = 0x00
	ld a,(ix+004h)		;8c48   ; lee la fraccion de la x de la cosa
	cp 00ah		;8c4b
	jr nz,L_8C58		;8c4d
	ld (ix+004h),00bh		;8c4f   ; la fraccion de la x de la cosa = 0x0B
	call L_8CE6		;8c53
	jr L_8C2F		;8c56
L_8C58:
	cp 00bh		;8c58
	ret nz			;8c5a
	ld (ix+006h),001h		;8c5b   ; la cosa se mueve
	ret			;8c5f
L_8C60:
	ld a,(ix+004h)		;8c60   ; lee la fraccion de la x de la cosa
	cp 019h		;8c63
	ret z			;8c65
	ld a,(ix+000h)		;8c66   ; lee el tipo de la cosa
	and 00fh		;8c69
	cp 004h		;8c6b
	ret z			;8c6d
	ld a,(ix+005h)		;8c6e   ; lee la x de la cosa
	or a			;8c71
	jr z,L_8C7E		;8c72
	dec a			;8c74
	jr z,L_8C91		;8c75
	dec a			;8c77
	jr z,L_8C96		;8c78
	ld a,0e0h		;8c7a
	jr L_8CA8		;8c7c
L_8C7E:
	ld a,(0c003h)		;8c7e   ; lee el contador de cuadros
	ld b,a			;8c81
	and 001h		;8c82
	ret nz			;8c84
	bit 2,b		;8c85
	ld b,0f4h		;8c87
	jr nz,L_8C8D		;8c89
	ld b,0f8h		;8c8b
L_8C8D:
	ld c,008h		;8c8d
	jr L_8CA5		;8c8f
L_8C91:
	ld bc,0e808h		;8c91
	jr L_8CA5		;8c94
L_8C96:
	ld bc,0ec0eh		;8c96
	ld a,(0c003h)		;8c99   ; lee el contador de cuadros
	and 003h		;8c9c
	ld hl,08cbdh		;8c9e
	call 04061h		;8ca1   ; hl_mas_a: HL += A
	ld c,(hl)			;8ca4
L_8CA5:
	ld a,(ix+001h)		;8ca5   ; lee el paso en que va la cosa
L_8CA8:
	ld hl,0d628h		;8ca8
	ld (hl),a			;8cab
	inc hl			;8cac
	ld a,(ix+002h)		;8cad   ; lee la fraccion de la y de la cosa
	ld (hl),a			;8cb0
	inc hl			;8cb1
	ld (hl),b			;8cb2
	ld hl,0d4a0h		;8cb3
	ld b,010h		;8cb6
L_8CB8:
	ld (hl),c			;8cb8
	inc hl			;8cb9
	djnz L_8CB8		;8cba
	ret			;8cbc

; ----------------------------------------------------------------------
; DATOS cuatro_valores_por_cuadro: cuatro bytes que p02:8C9E elige con los dos
;   bits bajos del contador de cuadros (0xC003)
;   0x8cbd..0x8cc1  (4 bytes)
DATA_cuatro_valores_por_cuadro:
	defb 008h,001h,00eh,001h	; 8cbd

; ======================================================================
; CODIGO 0x8cc1..0x8d3e  (125 bytes)
; ======================================================================


L_8CC1:
	ld l,050h		;8cc1
	cp 010h		;8cc3
	jr c,L_8CCB		;8cc5
	sub 010h		;8cc7
	ld l,060h		;8cc9
L_8CCB:
	add a,a			;8ccb
	add a,a			;8ccc
	add a,a			;8ccd
	add a,a			;8cce
	ld h,a			;8ccf
	ld bc,01010h		;8cd0
	ld a,048h		;8cd3
	jp 049dbh		;8cd5
L_8CD8:
	push bc			;8cd8
	call 07d2fh		;8cd9   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	pop bc			;8cdc
	ld (ix+007h),c		;8cdd   ; guarda la velocidad vertical (parte baja)
	ld hl,0e520h		;8ce0
	jp L_8744		;8ce3
L_8CE6:
	push ix		;8ce6
	push de			;8ce8
	push de			;8ce9
	ld c,(ix+007h)		;8cea   ; lee la velocidad vertical (parte baja)
	ld hl,0e520h		;8ced
	push bc			;8cf0
	push hl			;8cf1
	call 07d2fh		;8cf2   ; celda_del_mapa: de una posicion en puntos (E, D) a su celda en el mapa de la habitacion
	ld de,0e800h		;8cf5
	ld bc,00202h		;8cf8
	call L_876C		;8cfb
	pop hl			;8cfe
	pop bc			;8cff
	push bc			;8d00
	push hl			;8d01
	ld a,c			;8d02
	add a,a			;8d03
	add a,a			;8d04
	call 04061h		;8d05   ; hl_mas_a: HL += A
	ld b,004h		;8d08
	ld de,0e800h		;8d0a
L_8D0D:
	ld a,(de)			;8d0d
	cp (hl)			;8d0e
	jr z,L_8D12		;8d0f
	ld (hl),a			;8d11
L_8D12:
	inc hl			;8d12
	inc de			;8d13
	djnz L_8D0D		;8d14
	pop hl			;8d16
	pop bc			;8d17
	pop de			;8d18
	call L_884D		;8d19
	call L_926C		;8d1c
	call L_916E		;8d1f
	call L_8707		;8d22
	pop de			;8d25
	pop ix		;8d26
	ret			;8d28
L_8D29:
	ld a,(ix+004h)		;8d29   ; lee la fraccion de la x de la cosa
L_8D2C:
	ld hl,0509fh		;8d2c
	push hl			;8d2f
L_8D30:
	ld (0c419h),a		;8d30
	call L_8F23		;8d33
	cp 01ah		;8d36
	jr nc,$+56		;8d38
	dec a			;8d3a
	call 0406bh		;8d3b   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8D3E: 25 destinos del despachador de 0x406B (call en p02:8D3B):
;   0x8DAF, 0x8DB7, 0x8D98, 0x8DA1, 0x8DBB, 0x8D7C, 0x8DDE, 0x8DCD ...; lo
;   leen p02:8D3B (50 bytes)
;   0x8d3e..0x8d70  (50 bytes)
DATA_tabla_8D3E:
	defb 0afh,08dh	; 8d3e
	defb 0b7h,08dh	; 8d40
	defb 098h,08dh	; 8d42
	defb 0a1h,08dh	; 8d44
	defb 0bbh,08dh	; 8d46
	defb 07ch,08dh	; 8d48
	defb 0deh,08dh	; 8d4a
	defb 0cdh,08dh	; 8d4c
	defb 0e5h,08dh	; 8d4e
	defb 094h,08dh	; 8d50
	defb 0f5h,08dh	; 8d52
	defb 0fch,08dh	; 8d54
	defb 003h,08eh	; 8d56
	defb 016h,08eh	; 8d58
	defb 033h,08eh	; 8d5a
	defb 01dh,08eh	; 8d5c
	defb 026h,08eh	; 8d5e
	defb 079h,08eh	; 8d60
	defb 042h,08eh	; 8d62
	defb 04bh,08eh	; 8d64
	defb 014h,08eh	; 8d66
	defb 00dh,08eh	; 8d68
	defb 050h,08eh	; 8d6a
	defb 060h,08eh	; 8d6c
	defb 014h,08eh	; 8d6e

; ======================================================================
; CODIGO 0x8d70..0x8e6b  (251 bytes)
; ======================================================================


L_8D70:
	sub 019h		;8d70
	cp 005h		;8d72
	jr z,L_8D8D		;8d74
	ld (0c416h),a		;8d76   ; guarda el arma que lleva Simon (0, ninguna)
	call L_8E9A		;8d79
L_8D7C:
	ld a,(0c431h)		;8d7c
	and 004h		;8d7f
	ld a,0f0h		;8d81
	jr nz,L_8D87		;8d83
	ld a,096h		;8d85
L_8D87:
	ld (0c440h),a		;8d87
L_8D8A:
	ld a,012h		;8d8a
	ret			;8d8c
L_8D8D:
	ld b,008h		;8d8d
L_8D8F:
	call L_8E6D		;8d8f
	jr L_8D8A		;8d92
L_8D94:
	ld b,040h		;8d94
	jr L_8D8F		;8d96
L_8D98:
	ld hl,0c701h		;8d98
	res 5,(hl)		;8d9b
	ld b,010h		;8d9d
	jr L_8DA8		;8d9f
L_8DA1:
	ld hl,0c701h		;8da1
	res 4,(hl)		;8da4
	ld b,020h		;8da6
L_8DA8:
	ld a,010h		;8da8
	ld (0c441h),a		;8daa
	jr L_8D8F		;8dad
L_8DAF:
	ld b,001h		;8daf
L_8DB1:
	call 04594h		;8db1
	ld a,00fh		;8db4
	ret			;8db6
L_8DB7:
	ld b,005h		;8db7
	jr L_8DB1		;8db9
L_8DBB:
	push ix		;8dbb
	call 07806h		;8dbd
	pop ix		;8dc0
	call L_928D		;8dc2
	ld a,018h		;8dc5
	ld (0c43eh),a		;8dc7
	ld a,01bh		;8dca
	ret			;8dcc
L_8DCD:
	ld a,(0c431h)		;8dcd
	and 004h		;8dd0
	ld a,0f0h		;8dd2
	jr nz,L_8DD8		;8dd4
	ld a,096h		;8dd6
L_8DD8:
	ld (0c43ah),a		;8dd8
	ld a,016h		;8ddb
	ret			;8ddd
L_8DDE:
	ld b,008h		;8dde
	call 04605h		;8de0
	jr L_8E0A		;8de3
L_8DE5:
	ld a,(0c431h)		;8de5
	and 004h		;8de8
	ld a,0f0h		;8dea
	jr nz,L_8DF0		;8dec
	ld a,096h		;8dee
L_8DF0:
	ld (0c434h),a		;8df0
	jr L_8E0A		;8df3
L_8DF5:
	ld hl,0c431h		;8df5
	set 2,(hl)		;8df8
	jr L_8E0A		;8dfa
L_8DFC:
	ld hl,0c431h		;8dfc
	set 3,(hl)		;8dff
	jr L_8E0A		;8e01
L_8E03:
	ld hl,0c431h		;8e03
	set 4,(hl)		;8e06
	jr L_8E0A		;8e08
L_8E0A:
	jp L_8D8A		;8e0a
L_8E0D:
	ld b,020h		;8e0d
	call 04605h		;8e0f
	jr L_8E0A		;8e12
L_8E14:
	pop hl			;8e14
	ret			;8e15
L_8E16:
	call L_870C		;8e16
	ld b,001h		;8e19
	jr L_8E2D		;8e1b
L_8E1D:
	ld hl,0c702h		;8e1d
	res 7,(hl)		;8e20
	ld b,040h		;8e22
	jr L_8E2D		;8e24
L_8E26:
	ld hl,0c702h		;8e26
	res 6,(hl)		;8e29
	ld b,080h		;8e2b
L_8E2D:
	call L_8E72		;8e2d
	ld a,012h		;8e30
	ret			;8e32
L_8E33:
	ld hl,0c431h		;8e33
	set 6,(hl)		;8e36
	ld a,003h		;8e38
	ld (0c70fh),a		;8e3a
	ld b,080h		;8e3d
	jp L_8D8F		;8e3f
L_8E42:
	ld de,05000h		;8e42
L_8E45:
	call 044ech		;8e45
	ld a,010h		;8e48
	ret			;8e4a
L_8E4B:
	ld de,01000h		;8e4b
	jr L_8E45		;8e4e
L_8E50:
	ld b,002h		;8e50
	call L_8E6D		;8e52
	ld hl,0c700h		;8e55
	ld (hl),001h		;8e58
	call L_8EC9		;8e5a
	ld a,014h		;8e5d
	ret			;8e5f
L_8E60:
	ld b,001h		;8e60
	call L_8E6D		;8e62
	call L_8EBA		;8e65
	ld a,014h		;8e68
	ret			;8e6a

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_8E6B: instrucciones que no alcanza nadie:
;   desensamblan enteras hasta un ret justo en el borde y su direccion no
;   aparece como palabra en el cartucho; lo leen nadie (2 bytes)
;   0x8e6b..0x8e6d  (2 bytes)
DATA_codigo_sin_llamar_8E6B:
	defb 0e1h,0c9h	; 8e6b

; ======================================================================
; CODIGO 0x8e6d..0x8ef9  (140 bytes)
; ======================================================================


L_8E6D:
	ld hl,0c701h		;8e6d
	jr L_8E75		;8e70
L_8E72:
	ld hl,0c702h		;8e72
L_8E75:
	ld a,b			;8e75
	or (hl)			;8e76
	ld (hl),a			;8e77
	ret			;8e78
L_8E79:
	ld hl,0c431h		;8e79
	set 1,(hl)		;8e7c
	ld hl,0c701h		;8e7e
	res 1,(hl)		;8e81
	ld b,004h		;8e83
	call L_8E6D		;8e85
	ld a,003h		;8e88
	ld (0c700h),a		;8e8a
	call L_8EC9		;8e8d
	ld a,00fh		;8e90
	ret			;8e92
L_8E93:
	xor a			;8e93
	ld (0c416h),a		;8e94   ; guarda el arma que lleva Simon (0, ninguna)
	jp L_8E9A		;8e97
L_8E9A:
	ld a,(0c416h)		;8e9a   ; lee el arma que lleva Simon (0, ninguna)
	ld de,0800ch		;8e9d
	or a			;8ea0
	jp z,L_8979		;8ea1
	add a,019h		;8ea4
L_8EA6:
	dec a			;8ea6
	ld l,050h		;8ea7
	cp 010h		;8ea9
	jr c,L_8EB1		;8eab
	sub 010h		;8ead
	ld l,060h		;8eaf
L_8EB1:
	jp L_897D		;8eb1
L_8EB4:
	call L_8EC9		;8eb4
	jp L_8EBA		;8eb7
L_8EBA:
	ld de,0a40ch		;8eba
	ld a,(0c701h)		;8ebd
	and 001h		;8ec0
	jp z,L_8979		;8ec2
	ld a,018h		;8ec5
	jr L_8EA6		;8ec7
L_8EC9:
	ld de,0940ch		;8ec9
	ld a,(0c701h)		;8ecc
	ld b,a			;8ecf
	and 006h		;8ed0
	jp z,L_8979		;8ed2
	ld a,(0c700h)		;8ed5
	or a			;8ed8
	jp z,L_8979		;8ed9
	bit 2,b		;8edc
	ld a,012h		;8ede
	jr nz,L_8EE4		;8ee0
	ld a,017h		;8ee2
L_8EE4:
	jr L_8EA6		;8ee4
L_8EE6:
	call L_8F4A		;8ee6
	ld a,(0c701h)		;8ee9
	ld c,a			;8eec
	ld b,005h		;8eed
	xor a			;8eef
L_8EF0:
	rl c		;8ef0
	call c,L_8F05		;8ef2
	inc a			;8ef5
	djnz L_8EF0		;8ef6
	ret			;8ef8

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_8EF9: instrucciones que no alcanza nadie:
;   desensamblan enteras hasta un ret justo en el borde y su direccion no
;   aparece como palabra en el cartucho; lo leen nadie (12 bytes)
;   0x8ef9..0x8f05  (12 bytes)
DATA_codigo_sin_llamar_8EF9:
	defb 048h,006h,005h,0afh,0cbh,011h,038h,004h,03ch,010h,0f9h,0c9h	; 8ef9  H.....8.<...

; ======================================================================
; CODIGO 0x8f05..0x8f19  (20 bytes)
; ======================================================================


L_8F05:
	push af			;8f05
	push bc			;8f06
	ld hl,08f19h		;8f07
	add a,a			;8f0a
	call 04061h		;8f0b   ; hl_mas_a: HL += A
	ld d,(hl)			;8f0e
	ld e,00ch		;8f0f
	inc hl			;8f11
	ld a,(hl)			;8f12
	call L_8EA6		;8f13
	pop bc			;8f16
	pop af			;8f17
	ret			;8f18

; ----------------------------------------------------------------------
; DATOS cinco_pares: cinco pares que p02:8F07 indexa con A * 2
;   0x8f19..0x8f23  (10 bytes)
DATA_cinco_pares:
	defb 0e8h,00fh,0d8h,00ah,0c8h,004h,0c8h,003h,0b8h,01eh	; 8f19  ..........

; ======================================================================
; CODIGO 0x8f23..0x8fbd  (154 bytes)
; ======================================================================


L_8F23:
	cp 001h		;8f23
	ret z			;8f25
	cp 01eh		;8f26
	jr z,L_8F2D		;8f28
	cp 017h		;8f2a
	ret nc			;8f2c
L_8F2D:
	push ix		;8f2d
	push af			;8f2f
	ld a,0ffh		;8f30
	ld (0c5e5h),a		;8f32
	ld a,020h		;8f35
	ld (0c5e6h),a		;8f37
	call L_8F4A		;8f3a
	ld de,0d00ch		;8f3d
	ld a,(0c419h)		;8f40
	call L_8EA6		;8f43
	pop af			;8f46
	pop ix		;8f47
	ret			;8f49
L_8F4A:
	ld hl,0b80ch		;8f4a
	ld bc,04010h		;8f4d
	xor a			;8f50
	ld d,a			;8f51
	jp 0490ah		;8f52   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
L_8F55:
	ld a,(0c5e5h)		;8f55
	inc a			;8f58
	ret nz			;8f59
	ld a,(0c003h)		;8f5a   ; lee el contador de cuadros
	and 03fh		;8f5d
	ret z			;8f5f
	ld hl,0c5e6h		;8f60
	dec (hl)			;8f63
	ret nz			;8f64
	jp L_8EE6		;8f65
L_8F68:
	push hl			;8f68
	ld a,(ix+004h)		;8f69   ; lee la fraccion de la x de la cosa
	cp 019h		;8f6c
	jr nz,L_8F83		;8f6e
	ld hl,0c700h		;8f70
	ld a,(hl)			;8f73
	or a			;8f74
	jr nz,L_8F7A		;8f75
	inc a			;8f77
	pop hl			;8f78
	ret			;8f79
L_8F7A:
	dec (hl)			;8f7a
	ld a,011h		;8f7b
	call 0509fh		;8f7d   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_8F80:
	xor a			;8f80
	pop hl			;8f81
	ret			;8f82
L_8F83:
	cp 017h		;8f83
	ld b,006h		;8f85
	jr z,L_8F8F		;8f87
	cp 018h		;8f89
	ld b,001h		;8f8b
	jr nz,L_8F80		;8f8d
L_8F8F:
	call L_8F94		;8f8f
	pop hl			;8f92
	ret			;8f93
L_8F94:
	ld hl,0c701h		;8f94
	ld a,(hl)			;8f97
	and b			;8f98
	ret			;8f99
L_8F9A:
	ld a,(0c580h)		;8f9a
	or a			;8f9d
	ret nz			;8f9e
L_8F9F:
	ld hl,(0d000h)		;8f9f   ; lee la fase (0xD000) y la habitacion (0xD001) de un tiron
	ld de,00106h		;8fa2
	rst 20h			;8fa5
	ret nz			;8fa6
	ld hl,08fbdh		;8fa7
	ld de,0c580h		;8faa
	ld b,003h		;8fad
L_8FAF:
	push bc			;8faf
	ld bc,00006h		;8fb0
	ldir		;8fb3
	xor a			;8fb5
	ld (de),a			;8fb6
	inc e			;8fb7
	inc e			;8fb8
	pop bc			;8fb9
	djnz L_8FAF		;8fba
	ret			;8fbc

; ----------------------------------------------------------------------
; DATOS tres_registros_de_seis: tres registros de seis bytes que p02:8FA7
;   copia a 0xC580 (`ld b,3`)
;   0x8fbd..0x8fcf  (18 bytes)
DATA_tres_registros_de_seis:
	defb 001h,060h,03ch,000h,000h,00bh,001h,060h,07ch,000h,001h,00ah,001h,060h,0bch,001h	; 8fbd  .`<....`|....`..
	defb 002h,00bh	; 8fcd

; ======================================================================
; CODIGO 0x8fcf..0x906c  (157 bytes)
; ======================================================================


L_8FCF:
	call L_8F9A		;8fcf
L_8FD2:
	ld hl,0c580h		;8fd2
	ld b,003h		;8fd5
L_8FD7:
	push hl			;8fd7
	pop ix		;8fd8
	push bc			;8fda
	push hl			;8fdb
	ld a,(hl)			;8fdc
	or a			;8fdd
	call nz,L_8FEA		;8fde
	pop hl			;8fe1
	pop bc			;8fe2
	ld a,008h		;8fe3
	add a,l			;8fe5
	ld l,a			;8fe6
	djnz L_8FD7		;8fe7
	ret			;8fe9
L_8FEA:
	inc hl			;8fea
	ld e,(hl)			;8feb
	inc hl			;8fec
	ld d,(hl)			;8fed
	inc hl			;8fee
	ld c,(hl)			;8fef
	inc hl			;8ff0
	inc (hl)			;8ff1
	ld b,(hl)			;8ff2
	inc hl			;8ff3
	dec a			;8ff4
	jr nz,L_8FFE		;8ff5
	ld a,c			;8ff7
	and b			;8ff8
	ret nz			;8ff9
	ld a,004h		;8ffa
	jr L_9004		;8ffc
L_8FFE:
	ld a,003h		;8ffe
	and b			;9000
	ret nz			;9001
	ld a,0fch		;9002
L_9004:
	add a,e			;9004
	ld e,a			;9005
	ld a,(hl)			;9006
	inc hl			;9007
	inc (hl)			;9008
	sub (hl)			;9009
	jr nz,L_9015		;900a
	ld (hl),a			;900c
	ld a,(ix+000h)		;900d   ; lee el tipo de la cosa
	xor 003h		;9010
	ld (ix+000h),a		;9012   ; guarda el tipo de la cosa
L_9015:
	ld (ix+001h),e		;9015   ; guarda el paso en que va la cosa
	ld a,e			;9018
	sub 004h		;9019
	ld e,a			;901b
	ld hl,08070h		;901c
	ld bc,02010h		;901f
	ld a,001h		;9022
	jp 04946h		;9024   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_9027:
	call L_8F9F		;9027
	jp L_8FD2		;902a
L_902D:
	ld hl,0c598h		;902d
	ld a,(hl)			;9030
	or a			;9031
	ret nz			;9032
	ld hl,0906ch		;9033
L_9036:
	ld a,(hl)			;9036
	inc a			;9037
	ret z			;9038
	dec a			;9039
	push hl			;903a
	ld de,(0d000h)		;903b   ; lee la fase (0xD000) y la habitacion (0xD001) de un tiron
	cp e			;903f
	jr nz,L_9060		;9040
	inc hl			;9042
	ld a,(hl)			;9043
	cp d			;9044
	jr nz,L_9060		;9045
	inc hl			;9047
	ld b,(hl)			;9048
	inc hl			;9049
	ld de,0c598h		;904a
	ld c,001h		;904d
L_904F:
	push bc			;904f
	ld a,c			;9050
	ld (de),a			;9051
	inc de			;9052
	ld bc,00004h		;9053
	ldir		;9056
	inc de			;9058
	inc de			;9059
	pop bc			;905a
	inc c			;905b
	djnz L_904F		;905c
	pop hl			;905e
	ret			;905f
L_9060:
	pop hl			;9060
	inc hl			;9061
	inc hl			;9062
	ld a,(hl)			;9063
	inc hl			;9064
	add a,a			;9065
	add a,a			;9066
	call 04061h		;9067   ; hl_mas_a: HL += A
	jr L_9036		;906a

; ----------------------------------------------------------------------
; DATOS dos_listas: dos listas que termina un 0xFF: la de 0x906C la recorre
;   p02:9033; la de 0x9090 se la pasa p03:BCF9 a 0x5F1D
;   0x906c..0x909b  (47 bytes)
DATA_dos_listas:
	defb 005h,001h,001h,05fh,060h,001h,040h,005h,004h,002h,05fh,020h,001h,030h,05fh,0b8h	; 906c  ..._`.@..._ .0_.
	defb 0ffh,038h,00ah,000h,001h,08fh,060h,001h,060h,00ah,002h,001h,0a7h,040h,001h,080h	; 907c  .8....`.`....@..
	defb 00ah,003h,001h,08fh,020h,001h,0a0h,00ah,004h,001h,0a7h,080h,001h,040h,0ffh	; 908c  .... ........@.

; ======================================================================
; CODIGO 0x909b..0x913f  (164 bytes)
; ======================================================================


L_909B:
	ld hl,0c598h		;909b
	ld b,002h		;909e
L_90A0:
	push bc			;90a0
	push hl			;90a1
	ld a,(hl)			;90a2
	or a			;90a3
	jr z,L_90AE		;90a4
	push hl			;90a6
	call L_90B8		;90a7
	pop hl			;90aa
	call L_90D8		;90ab
L_90AE:
	pop hl			;90ae
	pop bc			;90af
	ld de,00007h		;90b0
	add hl,de			;90b3
	inc c			;90b4
	djnz L_90A0		;90b5
	ret			;90b7
L_90B8:
	inc hl			;90b8
	inc hl			;90b9
	ld d,(hl)			;90ba
	inc hl			;90bb
	ld e,(hl)			;90bc
	inc hl			;90bd
	ld c,(hl)			;90be
	inc hl			;90bf
	inc (hl)			;90c0
	ld a,(hl)			;90c1
	inc hl			;90c2
	inc (hl)			;90c3
	ld a,c			;90c4
	sub (hl)			;90c5
	jr nz,L_90C9		;90c6
	ld (hl),a			;90c8
L_90C9:
	dec hl			;90c9
	dec hl			;90ca
	dec hl			;90cb
	jr nz,L_90D3		;90cc
	ld a,(hl)			;90ce
	neg		;90cf
	ld (hl),a			;90d1
	ret			;90d2
L_90D3:
	dec hl			;90d3
	ld a,d			;90d4
	add a,e			;90d5
	ld (hl),a			;90d6
	ret			;90d7
L_90D8:
	ld a,(hl)			;90d8
	push af			;90d9
	inc hl			;90da
	ld de,0d638h		;90db
	dec a			;90de
	jr z,L_90E4		;90df
	ld de,0d648h		;90e1
L_90E4:
	call L_9112		;90e4
	pop af			;90e7
	ld hl,0d4e0h		;90e8
	dec a			;90eb
	jr z,L_90F1		;90ec
	ld hl,0d520h		;90ee
L_90F1:
	ld de,00244h		;90f1
	ld a,(0d000h)		;90f4   ; lee la FASE (0 el patio, 1-18)
	cp 005h		;90f7
	jr z,L_90FE		;90f9
	ld de,0094ch		;90fb
L_90FE:
	ld a,d			;90fe
	call L_910B		;90ff
	ld a,e			;9102
	call L_910B		;9103
	ld a,d			;9106
	call L_910B		;9107
	ld a,e			;910a
L_910B:
	ld b,010h		;910b
L_910D:
	ld (hl),a			;910d
	inc hl			;910e
	djnz L_910D		;910f
	ret			;9111
L_9112:
	ld ix,0913fh		;9112
	ld b,004h		;9116
L_9118:
	push bc			;9118
	push hl			;9119
	ld a,(hl)			;911a
	dec a			;911b
	ld (de),a			;911c
	inc hl			;911d
	inc de			;911e
	ld a,(ix+000h)		;911f
	add a,(hl)			;9122
	ld (de),a			;9123
	inc hl			;9124
	inc de			;9125
	ld c,(ix+001h)		;9126
	ld a,(0d000h)		;9129   ; lee la FASE (0 el patio, 1-18)
	cp 005h		;912c
	ld a,c			;912e
	jr z,L_9133		;912f
	add a,008h		;9131
L_9133:
	ld (de),a			;9133
	inc de			;9134
	inc de			;9135
	inc ix		;9136
	inc ix		;9138
	pop hl			;913a
	pop bc			;913b
	djnz L_9118		;913c
	ret			;913e

; ----------------------------------------------------------------------
; DATOS cuatro_pares: cuatro pares que p02:9112 recorre con IX (`ld b,4`)
;   0x913f..0x9147  (8 bytes)
DATA_cuatro_pares:
	defb 000h,0d0h,000h,0d4h,010h,0d0h,010h,0d4h	; 913f  ........

; ======================================================================
; CODIGO 0x9147..0x92ad  (358 bytes)
; ======================================================================


L_9147:
	ld hl,0c5ach		;9147   ; apunta a el estado de la puerta de la fase
	ld a,(hl)			;914a
	inc a			;914b
	jp z,053fch		;914c
	cp 003h		;914f
	ret nz			;9151
	inc l			;9152
	ld e,(hl)			;9153
	inc l			;9154
	ld d,(hl)			;9155
	inc l			;9156
	inc (hl)			;9157
	ld a,(hl)			;9158
	cp 02ch		;9159
	jr nc,L_9168		;915b
	ld h,d			;915d
	ld l,e			;915e
	inc l			;915f
	ld bc,0082fh		;9160
	ld a,000h		;9163
	jp 04946h		;9165   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
L_9168:
	ld a,003h		;9168
	ld (0c5ach),a		;916a   ; guarda el estado de la puerta de la fase
	ret			;916d
L_916E:
	ld hl,0c5ach		;916e   ; apunta a el estado de la puerta de la fase
	ld a,(hl)			;9171
	dec a			;9172
	ret nz			;9173
	ld (hl),0ffh		;9174
	jp L_9147		;9176
L_9179:
	ld (0c70dh),hl		;9179
	call L_91A2		;917c
	ret nz			;917f
	ld hl,0c5b5h		;9180
	dec a			;9183
	jr nz,L_9189		;9184
	ld hl,0c5c5h		;9186
L_9189:
	ld (hl),001h		;9189
	inc l			;918b
	ld (hl),e			;918c
	inc l			;918d
	ld (hl),d			;918e
	inc l			;918f
	ld (hl),000h		;9190
	inc l			;9192
	ld (hl),b			;9193
	inc l			;9194
	ld (hl),c			;9195
	inc l			;9196
	ld (hl),000h		;9197
	inc l			;9199
	ld de,(0c70dh)		;919a
	ld (hl),d			;919e
	inc l			;919f
	ld (hl),e			;91a0
	ret			;91a1
L_91A2:
	ld a,b			;91a2
	exx			;91a3
	ld hl,05b0bh		;91a4
	call 04061h		;91a7   ; hl_mas_a: HL += A
	ld c,(hl)			;91aa
	ld b,002h		;91ab
L_91AD:
	push bc			;91ad
	ld a,002h		;91ae
	sub b			;91b0
	call L_944F		;91b1
	ld a,(hl)			;91b4
	pop bc			;91b5
	cp c			;91b6
	jr z,L_91BB		;91b7
	djnz L_91AD		;91b9
L_91BB:
	ld a,b			;91bb
	exx			;91bc
	ret			;91bd
L_91BE:
	ld hl,0c5b5h		;91be
	ld bc,00200h		;91c1
L_91C4:
	push bc			;91c4
	push hl			;91c5
	push hl			;91c6
	pop ix		;91c7
	ld a,(hl)			;91c9
	or a			;91ca
	call nz,L_91D8		;91cb
	pop hl			;91ce
	ld a,010h		;91cf
	add a,l			;91d1
	ld l,a			;91d2
	pop bc			;91d3
	inc c			;91d4
	djnz L_91C4		;91d5
	ret			;91d7
L_91D8:
	inc l			;91d8
	ld e,(hl)			;91d9
	inc l			;91da
	ld d,(hl)			;91db
	dec l			;91dc
	dec l			;91dd
	and 00fh		;91de
	dec a			;91e0
	jr z,L_91EA		;91e1
	dec a			;91e3
	jr z,L_91F2		;91e4
	dec a			;91e6
	jr z,L_9229		;91e7
	ret			;91e9
L_91EA:
	ld (ix+009h),c		;91ea   ; guarda la velocidad horizontal (parte baja)
	ld (hl),082h		;91ed
	jp L_924C		;91ef
L_91F2:
	inc l			;91f2
	inc l			;91f3
	inc l			;91f4
	ld a,(hl)			;91f5
	or a			;91f6
	ret z			;91f7
	ld (hl),000h		;91f8
	inc l			;91fa
	ld b,(hl)			;91fb
	inc l			;91fc
	ld c,(hl)			;91fd
	inc l			;91fe
	cp 0ffh		;91ff
	jr z,L_9215		;9201
	call L_9221		;9203
	res 7,(hl)		;9206
	inc (hl)			;9208
	call L_92BB		;9209
L_920C:
	ld (ix+00ah),020h		;920c   ; la velocidad horizontal (el bit 7, hacia la izquierda) = 0x20
	ld (ix+000h),003h		;9210   ; el tipo de la cosa = 0x03
	ret			;9214
L_9215:
	ld a,006h		;9215
	ld (0c70ch),a		;9217
	ld a,003h		;921a
	ld (0c70bh),a		;921c
	jr L_920C		;921f
L_9221:
	ld a,(ix+009h)		;9221   ; lee la velocidad horizontal (parte baja)
	call L_944F		;9224
	inc hl			;9227
	ret			;9228
L_9229:
	dec (ix+00ah)		;9229   ; baja la velocidad horizontal (el bit 7, hacia la izquierda)
	ld a,(ix+00ah)		;922c   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	push af			;922f
	rra			;9230
	ld a,002h		;9231
	jr c,L_9238		;9233
	ld a,(0c70bh)		;9235
L_9238:
	push de			;9238
	call L_925E		;9239
	pop de			;923c
	pop af			;923d
	ret nz			;923e
	ld a,(0c70bh)		;923f
	call L_925E		;9242
	ld (ix+000h),082h		;9245   ; el tipo de la cosa = 0x82
	jp L_92A7		;9249
L_924C:
	push de			;924c
	ld hl,0e580h		;924d
	call L_8757		;9250
	pop de			;9253
	call L_9221		;9254
	bit 7,(hl)		;9257
	jr z,L_925C		;9259
	dec (hl)			;925b
L_925C:
	ld a,003h		;925c
L_925E:
	rrca			;925e
	rrca			;925f
	rrca			;9260
	ld h,a			;9261
	ld l,0a0h		;9262
	ld a,048h		;9264
	ld bc,02020h		;9266
	jp 049dbh		;9269
L_926C:
	ld hl,0c5b5h		;926c
	ld bc,00200h		;926f
L_9272:
	push bc			;9272
	push hl			;9273
	push hl			;9274
	pop ix		;9275
	ld a,(hl)			;9277
	or a			;9278
	call nz,L_9286		;9279
	pop hl			;927c
	ld a,010h		;927d
	add a,l			;927f
	ld l,a			;9280
	pop bc			;9281
	inc c			;9282
	djnz L_9272		;9283
	ret			;9285
L_9286:
	inc l			;9286
	ld e,(hl)			;9287
	inc l			;9288
	ld d,(hl)			;9289
	jp L_925C		;928a
L_928D:
	ld hl,0c5b5h		;928d
	ld b,002h		;9290
L_9292:
	push hl			;9292
	ld a,(hl)			;9293
	or a			;9294
	jr z,L_929F		;9295
	add a,a			;9297
	jr nc,L_929F		;9298
	inc l			;929a
	inc l			;929b
	inc l			;929c
	ld (hl),0ffh		;929d
L_929F:
	pop hl			;929f
	ld a,010h		;92a0
	add a,l			;92a2
	ld l,a			;92a3
	djnz L_9292		;92a4
	ret			;92a6
L_92A7:
	ld a,(0c70ch)		;92a7
	call 0406bh		;92aa   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_92AD: 7 destinos del despachador de 0x406B (call en p02:92AA):
;   0x9327, 0x9333, 0x933C, 0x9344, 0x934E, 0x9343, 0x9358; lo leen p02:92AA
;   (14 bytes)
;   0x92ad..0x92bb  (14 bytes)
DATA_tabla_92AD:
	defb 027h,093h	; 92ad
	defb 033h,093h	; 92af
	defb 03ch,093h	; 92b1
	defb 044h,093h	; 92b3
	defb 04eh,093h	; 92b5
	defb 043h,093h	; 92b7
	defb 058h,093h	; 92b9

; ======================================================================
; CODIGO 0x92bb..0x9300  (69 bytes)
; ======================================================================


L_92BB:
	ld de,09300h		;92bb
	ld a,(ix+005h)		;92be   ; lee la x de la cosa
	add a,a			;92c1
	add a,a			;92c2
	add a,a			;92c3
	call 04066h		;92c4   ; de_mas_a: DE += A
	ld a,(hl)			;92c7
	dec a			;92c8
	cp 008h		;92c9
	jr c,L_92CF		;92cb
	ld a,007h		;92cd
L_92CF:
	call 04066h		;92cf   ; de_mas_a: DE += A
	ld a,(de)			;92d2
	ld (0c70ch),a		;92d3
	sub 007h		;92d6
	jr c,L_92F2		;92d8
	ld hl,00305h		;92da
	jr z,L_92E8		;92dd
	dec a			;92df
	ld hl,00405h		;92e0
	jr z,L_92E8		;92e3
	ld hl,00304h		;92e5
L_92E8:
	ld a,r		;92e8
	rra			;92ea
	ld a,h			;92eb
	jr c,L_92EF		;92ec
	ld a,l			;92ee
L_92EF:
	ld (0c70ch),a		;92ef
L_92F2:
	ld a,(0c70ch)		;92f2
	ld hl,09320h		;92f5
	call 04061h		;92f8   ; hl_mas_a: HL += A
	ld a,(hl)			;92fb
	ld (0c70bh),a		;92fc
	ret			;92ff

; ----------------------------------------------------------------------
; DATOS tres_tablas_pequenas: la de 0x9300 la lee p02:92BB con (ix+5) * 4; la
;   de 0x930B la pasa p00:4550 a 0x48DC con C = 14; la de 0x9320 la indexa
;   p02:92F5 con 0xC70C
;   0x9300..0x9327  (39 bytes)
DATA_tres_tablas_pequenas:
	defb 000h,007h,007h,007h,008h,008h,005h,006h,000h,003h,003h,001h,005h,005h,005h,006h	; 9300  ................
	defb 009h,009h,000h,005h,005h,005h,002h,006h,005h,005h,005h,005h,000h,003h,005h,006h	; 9310  ................
	defb 001h,004h,004h,000h,000h,003h,003h	; 9320

; ======================================================================
; CODIGO 0x9327..0x9428  (257 bytes)
; ======================================================================


L_9327:
	ld a,0ffh		;9327
	ld (0c40ch),a		;9329
	ld a,(ix+009h)		;932c   ; lee la velocidad horizontal (parte baja)
	ld (0c703h),a		;932f
	ret			;9332
L_9333:
	ld hl,0d012h		;9333
	ld a,(hl)			;9336
	cp 003h		;9337
	ret z			;9339
	inc (hl)			;933a
	ret			;933b
L_933C:
	ld hl,0d012h		;933c
	ld a,(hl)			;933f
	or a			;9340
	ret z			;9341
	dec (hl)			;9342
L_9343:
	ret			;9343
L_9344:
	ld a,00fh		;9344
	call 0509fh		;9346   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld b,005h		;9349
	jp 04594h		;934b
L_934E:
	ld a,01dh		;934e
	call 0509fh		;9350   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld b,005h		;9353
	jp 045a0h		;9355
L_9358:
	ld (ix+000h),000h		;9358   ; el tipo de la cosa = 0x00
	call L_9378		;935c
	ld hl,0e580h		;935f
	call L_889C		;9362
	ld h,(ix+007h)		;9365   ; lee la velocidad vertical (parte baja)
	ld l,(ix+008h)		;9368   ; lee la velocidad vertical
	ld (hl),000h		;936b
	ld a,010h		;936d
	call 0509fh		;936f   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld de,05000h		;9372
	jp 044ech		;9375
L_9378:
	ld e,(ix+001h)		;9378   ; lee el paso en que va la cosa
	ld d,(ix+002h)		;937b   ; lee la fraccion de la y de la cosa
	ld c,(ix+009h)		;937e   ; lee la velocidad horizontal (parte baja)
	ld hl,0e580h		;9381
	jp L_8861		;9384
L_9387:
	call L_93FF		;9387
	ld a,014h		;938a
	ld (0c706h),a		;938c
	ld a,019h		;938f
	call 0509fh		;9391   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jp L_9397		;9394
L_9397:
	ld a,(0c703h)		;9397
	ld hl,0c5b5h		;939a
	add a,a			;939d
	add a,a			;939e
	add a,a			;939f
	add a,a			;93a0
	call 04061h		;93a1   ; hl_mas_a: HL += A
	inc hl			;93a4
	ld e,(hl)			;93a5
	inc hl			;93a6
	ld d,(hl)			;93a7
	ld a,d			;93a8
	cp 080h		;93a9
	jr nc,L_93B1		;93ab
	sub 010h		;93ad
	jr L_93B3		;93af
L_93B1:
	sub 020h		;93b1
L_93B3:
	ld h,a			;93b3
	ld a,e			;93b4
	sub 018h		;93b5
	ld l,a			;93b7
	ld (0c704h),hl		;93b8
	ld de,0b080h		;93bb
	ld bc,05020h		;93be
	ld a,004h		;93c1
	push hl			;93c3
	push bc			;93c4
	call 04946h		;93c5   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	pop bc			;93c8
	pop hl			;93c9
	call 05d0eh		;93ca
	ld bc,03806h		;93cd
	call L_94AF		;93d0
	ld hl,01314h		;93d3
	ex de,hl			;93d6
	ld c,00eh		;93d7
	call 048dch		;93d9
	ld bc,00804h		;93dc
	ld hl,09485h		;93df
	call L_949F		;93e2
	ld bc,00810h		;93e5
	ld hl,0948ah		;93e8
	call L_949F		;93eb
	call L_9491		;93ee
	ld bc,03908h		;93f1
	call L_94AF		;93f4
	ld a,(0c708h)		;93f7
	dec a			;93fa
	call L_8CC1		;93fb
	ret			;93fe
L_93FF:
	call L_944C		;93ff
	ld a,(hl)			;9402
	ld (0c708h),a		;9403
	inc hl			;9406
	set 7,(hl)		;9407
	ld hl,09428h		;9409
	ld b,009h		;940c
L_940E:
	cp (hl)			;940e
	inc hl			;940f
	jr z,L_9418		;9410
	inc hl			;9412
	inc hl			;9413
	inc hl			;9414
	djnz L_940E		;9415
	ret			;9417
L_9418:
	ld a,(0c702h)		;9418
	add a,a			;941b
	jr c,L_9422		;941c
	add a,a			;941e
	jr nc,L_9423		;941f
	inc hl			;9421
L_9422:
	inc hl			;9422
L_9423:
	ld a,(hl)			;9423
	ld (0c707h),a		;9424
	ret			;9427

; ----------------------------------------------------------------------
; DATOS nueve_pares_y_mas: lo que compara p02:9409 (`ld b,9`, `cp (hl)` y `inc
;   hl`)
;   0x9428..0x944c  (36 bytes)
DATA_nueve_pares_y_mas:
	defb 00eh,020h,015h,060h,012h,030h,020h,060h,003h,020h,010h,060h,004h,020h,010h,080h	; 9428  . .`.0 `. .`. ..
	defb 00ah,040h,020h,080h,016h,040h,015h,080h,01eh,030h,010h,050h,01dh,020h,010h,080h	; 9438  .@ ..@...0.P. ..
	defb 01bh,050h,030h,090h	; 9448

; ======================================================================
; CODIGO 0x944c..0x9473  (39 bytes)
; ======================================================================


L_944C:
	ld a,(0c703h)		;944c
L_944F:
	push af			;944f
	ld bc,00000h		;9450
	ld a,(0d000h)		;9453   ; lee la FASE (0 el patio, 1-18)
	or a			;9456
	jr z,L_9461		;9457
	dec a			;9459
	ld hl,09473h		;945a
	call 04061h		;945d   ; hl_mas_a: HL += A
	ld c,(hl)			;9460
L_9461:
	ld hl,0de00h		;9461
	add hl,bc			;9464
	ld a,(0d001h)		;9465   ; lee la HABITACION dentro de la fase
	add a,a			;9468
	add a,a			;9469
	call 04061h		;946a   ; hl_mas_a: HL += A
	pop af			;946d
	or a			;946e
	ret z			;946f
	inc hl			;9470
	inc hl			;9471
	ret			;9472

; ----------------------------------------------------------------------
; DATOS columna_y_dos_rotulos: 18 bytes, uno por fase (1-18), que p02:945A usa
;   de columna (0x00, 0x40 o 0x80); detras, los dos trozos de 0x9485 y 0x948A
;   que p02:93DF y 93E8 pasan a 0x949F
;   0x9473..0x9491  (30 bytes)
DATA_columna_y_dos_rotulos:
	defb 000h,040h,080h,000h,040h,080h,000h,040h,080h,000h,040h,080h,000h,040h,080h,000h	; 9473  .@..@..@..@..@..
	defb 040h,080h,03fh,03bh,000h,04ch,0ffh,050h,04dh,000h,000h,04eh,04fh,0ffh	; 9483  @.?;.L.PM..NO.

; ======================================================================
; CODIGO 0x9491..0x95f6  (357 bytes)
; ======================================================================


L_9491:
	ld bc,01810h		;9491
	call L_94AF		;9494
	ld hl,0c707h		;9497
	ld b,001h		;949a
	jp 04578h		;949c
L_949F:
	call L_94AF		;949f
L_94A2:
	ld a,(hl)			;94a2
	inc a			;94a3
	ret z			;94a4
	dec a			;94a5
	call 04ae7h		;94a6
	call 04b4fh		;94a9
	inc hl			;94ac
	jr L_94A2		;94ad
L_94AF:
	ld de,(0c704h)		;94af
	ld a,d			;94b3
	add a,b			;94b4
	ld d,a			;94b5
	ld a,e			;94b6
	add a,c			;94b7
	ld e,a			;94b8
	ret			;94b9
L_94BA:
	ld a,(0c003h)		;94ba   ; lee el contador de cuadros
	and 01fh		;94bd
	jr nz,L_94C7		;94bf
	ld hl,0c706h		;94c1
	dec (hl)			;94c4
	jr z,L_94FC		;94c5
L_94C7:
	call L_951F		;94c7
	jr z,L_9503		;94ca
	rra			;94cc
	jr nc,L_94FC		;94cd
	ld a,(0c707h)		;94cf
	ld b,a			;94d2
	ld a,(0c417h)		;94d3   ; lee los corazones, en BCD
	cp b			;94d6
	jr c,L_94FC		;94d7
	ld a,(0c704h)		;94d9
	cp 020h		;94dc
	push af			;94de
	call c,L_950D		;94df
	call 045a0h		;94e2
	ld a,(0c708h)		;94e5
	call L_8D30		;94e8
	pop af			;94eb
	call c,L_9397		;94ec
	ld a,012h		;94ef
	call 0509fh		;94f1   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	call L_944C		;94f4
	inc hl			;94f7
	res 7,(hl)		;94f8
	xor a			;94fa
	ret			;94fb
L_94FC:
	ld a,002h		;94fc
	call 0509fh		;94fe   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	xor a			;9501
	ret			;9502
L_9503:
	ld a,0ffh		;9503
	or a			;9505
	ret			;9506
L_9507:
	call L_950D		;9507
	jp L_8707		;950a
L_950D:
	push bc			;950d
	ld hl,0b080h		;950e
	ld de,(0c704h)		;9511
	ld bc,05020h		;9515
	ld a,001h		;9518
	call 04946h		;951a   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	pop bc			;951d
	ret			;951e
L_951F:
	ld e,08fh		;951f
	ld a,00fh		;9521
	call 00093h		;9523   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;9526
	di			;9528
	call 00096h		;9529   ; BIOS RDPSG - Reads value from PSG-register
	ei			;952c
	cpl			;952d
	and 030h		;952e
	rrca			;9530
	rrca			;9531
	rrca			;9532
	rrca			;9533
	ld d,a			;9534
	ld a,006h		;9535
	call L_954B		;9537
	add a,a			;953a
	or d			;953b
	ld d,a			;953c
	ld a,008h		;953d
	call L_954B		;953f
	or d			;9542
	ld hl,0c709h		;9543
	ld c,(hl)			;9546
	ld (hl),a			;9547
	xor c			;9548
	and (hl)			;9549
	ret			;954a
L_954B:
	call 00141h		;954b   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;954e
	and 001h		;954f
	ret			;9551
L_9552:
	ld a,(0c002h)		;9552
	and 040h		;9555
	ret z			;9557
	ld a,(0ce00h)		;9558
	and a			;955b
	ret nz			;955c
	ld a,(0cf38h)		;955d
	dec a			;9560
	jr z,L_95A8		;9561
	dec a			;9563
	jr z,L_95B3		;9564
	ld a,(0c00bh)		;9566
	bit 1,a		;9569
	ret z			;956b
	ld a,(0c701h)		;956c
	add a,a			;956f
	ret nc			;9570
	ld hl,0c70fh		;9571
	ld a,(hl)			;9574
	and a			;9575
	ret z			;9576
	dec (hl)			;9577
	jr nz,L_9582		;9578
	ld hl,0c701h		;957a
	res 7,(hl)		;957d
	call L_8EE6		;957f
L_9582:
	call 047feh		;9582
	ld hl,00020h		;9585
	ld bc,000b4h		;9588
	xor a			;958b
	ld d,000h		;958c
	call 0490ah		;958e   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	ld hl,01830h		;9591
	ld bc,0d07eh		;9594
	ld a,033h		;9597
	ld d,000h		;9599
	call 0490ah		;959b   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	ld a,019h		;959e
	call 0509fh		;95a0   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
L_95A3:
	ld hl,0cf38h		;95a3
	inc (hl)			;95a6
	ret			;95a7
L_95A8:
	call L_95D0		;95a8
	call L_9815		;95ab
	call L_9853		;95ae
	jr L_95A3		;95b1
L_95B3:
	ld a,(0c00bh)		;95b3
	bit 1,a		;95b6
	ret z			;95b8
	call 04f91h		;95b9
	call L_9027		;95bc
	call L_916E		;95bf
	call L_926C		;95c2
	call L_8707		;95c5
	call 04809h		;95c8
	xor a			;95cb
	ld (0cf38h),a		;95cc
	ret			;95cf
L_95D0:
	xor a			;95d0
	ld (0cffdh),a		;95d1
L_95D4:
	call L_9609		;95d4
	call L_967A		;95d7
	call L_9793		;95da
	call L_9807		;95dd
	ld a,(0cffdh)		;95e0
	inc a			;95e3
	ld (0cffdh),a		;95e4
	ld c,a			;95e7
	ld a,(0d000h)		;95e8   ; lee la FASE (0 el patio, 1-18)
	ld hl,095f6h		;95eb
	call 04061h		;95ee   ; hl_mas_a: HL += A
	ld a,c			;95f1
	cp (hl)			;95f2
	jr nz,L_95D4		;95f3
	ret			;95f5

; ----------------------------------------------------------------------
; DATOS un_tope_por_fase: 19 bytes, uno por fase, contra los que p02:95F2
;   compara
;   0x95f6..0x9609  (19 bytes)
DATA_un_tope_por_fase:
	defb 003h,008h,006h,006h,006h,006h,006h,009h,008h,009h,009h,006h,00ch,00ch,008h,00ah	; 95f6  ................
	defb 00ah,00ch,00ah	; 9606

; ======================================================================
; CODIGO 0x9609..0x9695  (140 bytes)
; ======================================================================


L_9609:
	ld hl,0e800h		;9609
	ld a,(0d000h)		;960c   ; lee la FASE (0 el patio, 1-18)
	ld b,a			;960f
	ld a,(0cffdh)		;9610
	ld c,a			;9613
	call 04fafh		;9614
	ld a,(0cffdh)		;9617
	call 05bd2h		;961a
	ld de,0eb00h		;961d
	call 05b21h		;9620
	ld ix,0eb00h		;9623
	ld a,(0d001h)		;9627   ; lee la HABITACION dentro de la fase
	ld hl,0cffdh		;962a
	cp (hl)			;962d
	jr nz,L_9634		;962e
	ld ix,0c470h		;9630
L_9634:
	ld b,008h		;9634
L_9636:
	ld a,(ix+000h)		;9636   ; lee el tipo de la cosa
	and a			;9639
	jr z,L_9644		;963a
	ld a,(ix+004h)		;963c   ; lee la fraccion de la x de la cosa
	cp 003h		;963f
	call z,L_964C		;9641
L_9644:
	ld de,00010h		;9644
	add ix,de		;9647
	djnz L_9636		;9649
	ret			;964b
L_964C:
	ld a,(ix+001h)		;964c   ; lee el paso en que va la cosa
	sub 010h		;964f
	ld h,(ix+002h)		;9651   ; lee la fraccion de la y de la cosa
	rra			;9654
	rra			;9655
	rra			;9656
	rra			;9657
	rr h		;9658
	rra			;965a
	rr h		;965b
	rra			;965d
	rr h		;965e
	ld l,h			;9660
	and 003h		;9661
	add a,0e8h		;9663
	ld h,a			;9665
	ld c,004h		;9666
L_9668:
	ld a,001h		;9668
	ld (hl),a			;966a
	inc hl			;966b
	ld (hl),a			;966c
	inc hl			;966d
	ld (hl),a			;966e
	inc hl			;966f
	ld (hl),a			;9670
	ld a,01dh		;9671
	call 04061h		;9673   ; hl_mas_a: HL += A
	dec c			;9676
	jr nz,L_9668		;9677
	ret			;9679
L_967A:
	ld a,(0d000h)		;967a   ; lee la FASE (0 el patio, 1-18)
	ld de,09695h		;967d
	call 06542h		;9680   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld a,(0cffdh)		;9683
	call 04066h		;9686   ; de_mas_a: DE += A
	ld a,(de)			;9689
	ld de,09757h		;968a
	call 06542h		;968d   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld (0cff2h),de		;9690
	ret			;9694

; ----------------------------------------------------------------------
; DATOS casilla_de_cada_habitacion: 19 punteros, uno por fase, a un byte por
;   habitacion: su casilla en una rejilla de 6 x 5; p02:968A la convierte con
;   la tabla de 30 palabras de 0x9757 en una posicion (x de 0x20 a 0xC0, y de
;   0x38 a 0x8C) y la deja en 0xCFF2
;   0x9695..0x9793  (254 bytes)
DATA_casilla_de_cada_habitacion:
	defb 0bbh,096h,0beh,096h,0c6h,096h,0cch,096h,0d2h,096h,0d8h,096h,0deh,096h,0e4h,096h	; 9695  ................
	defb 0edh,096h,0f5h,096h,0feh,096h,007h,097h,00dh,097h,019h,097h,025h,097h,02dh,097h	; 96a5  ............%.-.
	defb 037h,097h,041h,097h,04dh,097h,00dh,00eh,00fh,00dh,00eh,00fh,010h,007h,008h,009h	; 96b5  7.A.M...........
	defb 00ah,00eh,00fh,008h,009h,014h,015h,007h,008h,009h,00ah,00dh,00eh,00dh,00eh,00fh	; 96c5  ................
	defb 007h,008h,009h,00fh,00eh,00dh,009h,008h,007h,00fh,00eh,00dh,009h,008h,007h,015h	; 96d5  ................
	defb 014h,013h,00fh,00eh,00dh,009h,008h,007h,00ch,00dh,00eh,00fh,010h,008h,009h,00ah	; 96e5  ................
	defb 00ch,00dh,00eh,00fh,010h,011h,00bh,016h,017h,00ch,00dh,00eh,00fh,010h,011h,007h	; 96f5  ................
	defb 008h,00bh,00ch,00dh,00eh,00fh,010h,011h,007h,008h,009h,00dh,00eh,00fh,010h,014h	; 9705  ................
	defb 015h,019h,01ah,01bh,007h,008h,009h,001h,002h,003h,004h,00fh,014h,015h,016h,01ch	; 9715  ................
	defb 010h,00fh,00eh,00ah,009h,008h,007h,006h,015h,014h,00fh,00eh,009h,008h,004h,003h	; 9725  ................
	defb 002h,001h,00bh,00ah,009h,008h,007h,006h,011h,010h,00fh,00eh,016h,015h,014h,010h	; 9735  ................
	defb 00fh,00eh,008h,007h,006h,002h,001h,000h,01ch,01bh,01ah,014h,00fh,00eh,009h,003h	; 9745  ................
	defb 002h,001h,038h,020h,038h,040h,038h,060h,038h,080h,038h,0a0h,038h,0c0h,04dh,020h	; 9755  ..8 8@8`8.8.8.M
	defb 04dh,040h,04dh,060h,04dh,080h,04dh,0a0h,04dh,0c0h,062h,020h,062h,040h,062h,060h	; 9765  M@M`M.M.M.b b@b`
	defb 062h,080h,062h,0a0h,062h,0c0h,077h,020h,077h,040h,077h,060h,077h,080h,077h,0a0h	; 9775  b.b.b.w w@w`w.w.
	defb 077h,0c0h,08ch,020h,08ch,040h,08ch,060h,08ch,080h,08ch,0a0h,08ch,0c0h	; 9785  w.. .@.`......

; ======================================================================
; CODIGO 0x9793..0x97ec  (89 bytes)
; ======================================================================


L_9793:
	ld de,0e840h		;9793
	ld hl,0eb00h		;9796
	ld bc,002c0h		;9799
L_979C:
	call L_97AE		;979c
	call L_97FA		;979f
	bit 0,c		;97a2
	jr z,L_97A7		;97a4
	inc hl			;97a6
L_97A7:
	inc de			;97a7
	dec bc			;97a8
	ld a,c			;97a9
	or b			;97aa
	jr nz,L_979C		;97ab
	ret			;97ad
L_97AE:
	ld a,(de)			;97ae
	exx			;97af
	cp 00eh		;97b0
	jr nc,L_97D0		;97b2
	ld hl,097ech		;97b4
	ld e,a			;97b7
	ld d,000h		;97b8
	add hl,de			;97ba
	ld a,(hl)			;97bb
	ld c,a			;97bc
	dec a			;97bd
	jp m,L_97D0		;97be
	jr z,L_97D3		;97c1
	dec a			;97c3
	jr z,L_97D7		;97c4
	ld a,(0d002h)		;97c6   ; lee el bloque de tres fases (0-5)
	cp 005h		;97c9
	jr z,L_97E2		;97cb
	and a			;97cd
	jr z,L_97DB		;97ce
L_97D0:
	xor a			;97d0
	exx			;97d1
	ret			;97d2
L_97D3:
	ld a,00eh		;97d3
	exx			;97d5
	ret			;97d6
L_97D7:
	ld a,00eh		;97d7
	exx			;97d9
	ret			;97da
L_97DB:
	ld a,c			;97db
	cp 003h		;97dc
	jr z,L_97D3		;97de
	jr L_97D0		;97e0
L_97E2:
	ld a,c			;97e2
	sub 003h		;97e3
	jr z,L_97D3		;97e5
	dec a			;97e7
	jr z,L_97D3		;97e8
	jr L_97D0		;97ea

; ----------------------------------------------------------------------
; DATOS catorce_valores: 14 bytes que p02:97B4 indexa con A (menor que 14)
;   0x97ec..0x97fa  (14 bytes)
DATA_catorce_valores:
	defb 000h,001h,001h,002h,002h,004h,004h,004h,004h,003h,001h,001h,002h,002h	; 97ec  ..............

; ======================================================================
; CODIGO 0x97fa..0x984b  (81 bytes)
; ======================================================================


L_97FA:
	bit 0,c		;97fa
	jr z,L_9801		;97fc
	or (hl)			;97fe
	ld (hl),a			;97ff
	ret			;9800
L_9801:
	add a,a			;9801
	add a,a			;9802
	add a,a			;9803
	add a,a			;9804
	ld (hl),a			;9805
	ret			;9806
L_9807:
	ld de,(0cff2h)		;9807
	ld hl,0eb00h		;980b
	ld bc,02016h		;980e
	xor a			;9811
	jp 0498ah		;9812   ; hmmc: orden HMMC del V9938: puntos de HL a la VRAM
L_9815:
	ld a,(0d001h)		;9815   ; lee la HABITACION dentro de la fase
	ld (0cffdh),a		;9818
	call L_967A		;981b
	ld hl,(0cff2h)		;981e
	ld a,(0c425h)		;9821   ; lee la Y de Simon
	sub 040h		;9824
	call c,L_9844		;9826
	rra			;9829
	rra			;982a
	rra			;982b
	and 01fh		;982c
	add a,l			;982e
	ld e,a			;982f
	ld a,(0c427h)		;9830   ; lee la X de Simon
	rra			;9833
	rra			;9834
	rra			;9835
	and 01fh		;9836
	add a,h			;9838
	ld d,a			;9839
	ld bc,00404h		;983a
	ld hl,0984bh		;983d
	xor a			;9840
	jp 0498ah		;9841   ; hmmc: orden HMMC del V9938: puntos de HL a la VRAM
L_9844:
	ex af,af'			;9844
	ld a,l			;9845
	sub 020h		;9846
	ld l,a			;9848
	ex af,af'			;9849
	ret			;984a

; ----------------------------------------------------------------------
; DATOS hmmc_984B: 4x4 puntos a 4 bits (8 bytes) que 0x498A manda al V9938 con
;   una orden HMMC; lo leen p02:9841 (8 bytes)
;   0x984b..0x9853  (8 bytes)
DATA_hmmc_984B:
	defb 008h,080h,088h,088h,088h,088h,008h,080h	; 984b  ........

; ======================================================================
; CODIGO 0x9853..0x9874  (33 bytes)
; ======================================================================


L_9853:
	ld a,(0d000h)		;9853   ; lee la FASE (0 el patio, 1-18)
	ld c,a			;9856
	add a,a			;9857
	add a,c			;9858
	ld hl,098ach		;9859
	call 04061h		;985c   ; hl_mas_a: HL += A
	ld e,(hl)			;985f
	inc hl			;9860
	ld d,(hl)			;9861
	inc hl			;9862
	bit 0,(hl)		;9863
	ld hl,09874h		;9865
	jr z,L_986D		;9868
	ld hl,09890h		;986a
L_986D:
	ld bc,00807h		;986d
	xor a			;9870
	jp 0498ah		;9871   ; hmmc: orden HMMC del V9938: puntos de HL a la VRAM

; ----------------------------------------------------------------------
; DATOS dibujo_de_8x7: 28 bytes, 8 x 7 puntos a 4 bits, que p02:9865 manda por
;   HMMC (`ld bc,0x0807`) si el bit 0 esta a cero
;   0x9874..0x9890  (28 bytes)
DATA_dibujo_de_8x7:
	defb 000h,008h,000h,000h,000h,008h,080h,000h,088h,088h,088h,000h,088h,088h,088h,080h	; 9874  ................
	defb 088h,088h,088h,000h,000h,008h,080h,000h,000h,008h,000h,000h	; 9884  ............

; ----------------------------------------------------------------------
; DATOS hmmc_9890: 8x7 puntos a 4 bits (28 bytes) que 0x498A manda al V9938
;   con una orden HMMC; lo leen p02:9871 (28 bytes)
;   0x9890..0x98ac  (28 bytes)
DATA_hmmc_9890:
	defb 000h,000h,080h,000h,000h,008h,080h,000h	; 9890  ........
	defb 000h,088h,088h,088h,008h,088h,088h,088h	; 9898  ........
	defb 000h,088h,088h,088h,000h,008h,080h,000h	; 98a0  ........
	defb 000h,000h,080h,000h	; 98a8

; ----------------------------------------------------------------------
; DATOS tres_bytes_por_fase: 19 registros de tres bytes, uno por fase, que
;   p02:9859 indexa con fase * 3
;   0x98ac..0x98e5  (57 bytes)
DATA_tres_bytes_por_fase:
	defb 06ch,092h,000h,04eh,0b4h,000h,063h,094h,000h,06eh,054h,000h,04eh,045h,001h,052h	; 98ac  l..N..c..nT.NE.R
	defb 043h,001h,052h,065h,001h,054h,094h,000h,050h,0b4h,000h,082h,0c3h,001h,058h,0d4h	; 98bc  C.Re.T..P.....X.
	defb 000h,06dh,0d4h,000h,06dh,094h,000h,082h,063h,001h,058h,024h,001h,043h,065h,001h	; 98cc  .m..m...c.X$.Ce.
	defb 050h,025h,001h,03ah,025h,001h,043h,065h,001h	; 98dc  P%.:%.Ce.

; ======================================================================
; CODIGO 0x98e5..0x9942  (93 bytes)
; ======================================================================


L_98E5:
	ld a,(0d010h)		;98e5
	and a			;98e8
	call z,05eb8h		;98e9
L_98EC:
	ld ix,0c800h		;98ec
	ld b,007h		;98f0
L_98F2:
	ld a,(ix+000h)		;98f2   ; lee el tipo de la cosa
	and a			;98f5
	jr z,L_9908		;98f6
	push bc			;98f8
	call L_992F		;98f9
	jr c,L_9904		;98fc
	call L_993B		;98fe
	call L_99B9		;9901
L_9904:
	call L_99E5		;9904
	pop bc			;9907
L_9908:
	ld de,00080h		;9908
	add ix,de		;990b
	djnz L_98F2		;990d
	ret			;990f
L_9910:
	ld ix,0d700h		;9910
	ld b,008h		;9914
	jr L_991E		;9916
L_9918:
	ld ix,0c800h		;9918
	ld b,007h		;991c
L_991E:
	push bc			;991e
	ld a,(ix+000h)		;991f   ; lee el tipo de la cosa
	and a			;9922
	call nz,06445h		;9923
	ld de,00080h		;9926
	add ix,de		;9929
	pop bc			;992b
	djnz L_991E		;992c
	ret			;992e
L_992F:
	ld a,(0d010h)		;992f
	and a			;9932
	ret z			;9933
	ld a,(ix+07eh)		;9934
	and a			;9937
	ret z			;9938
	scf			;9939
	ret			;993a
L_993B:
	ld a,(ix+000h)		;993b   ; lee el tipo de la cosa
	dec a			;993e
	call 0406bh		;993f   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9942: 46 destinos del despachador de 0x406B (call en p02:993F):
;   0xA964, 0xA310, 0xA310, 0xB0F8, 0xA87D, 0xA592, 0xB07B, 0xA51B ...; lo
;   leen p02:993F (92 bytes)
;   0x9942..0x999e  (92 bytes)
DATA_tabla_9942:
	defb 064h,0a9h	; 9942
	defb 010h,0a3h	; 9944
	defb 010h,0a3h	; 9946
	defb 0f8h,0b0h	; 9948
	defb 07dh,0a8h	; 994a
	defb 092h,0a5h	; 994c
	defb 07bh,0b0h	; 994e
	defb 01bh,0a5h	; 9950
	defb 05fh,0afh	; 9952
	defb 02eh,0a2h	; 9954
	defb 07eh,0b3h	; 9956
	defb 07dh,0a6h	; 9958
	defb 048h,0b2h	; 995a
	defb 0b7h,0a9h	; 995c
	defb 0c3h,0b1h	; 995e
	defb 0f8h,0adh	; 9960
	defb 042h,0abh	; 9962
	defb 070h,0beh	; 9964
	defb 019h,0bdh	; 9966
	defb 093h,0b8h	; 9968
	defb 064h,0bah	; 996a
	defb 06dh,0bch	; 996c
	defb 048h,06ah	; 996e
	defb 0f6h,0bah	; 9970
	defb 0eah,0b4h	; 9972
	defb 0eah,0b4h	; 9974
	defb 0eah,0b4h	; 9976
	defb 0eah,0b4h	; 9978
	defb 09eh,099h	; 997a
	defb 071h,09bh	; 997c
	defb 0f8h,0b0h	; 997e
	defb 0a3h,09ch	; 9980
	defb 010h,0a3h	; 9982
	defb 0a1h,0b7h	; 9984
	defb 048h,0b2h	; 9986
	defb 0d9h,09bh	; 9988
	defb 09eh,099h	; 998a
	defb 01eh,09ch	; 998c
	defb 0b3h,04eh	; 998e
	defb 0f9h,04eh	; 9990
	defb 0f9h,04eh	; 9992
	defb 035h,04fh	; 9994
	defb 09eh,099h	; 9996
	defb 09ch,06ah	; 9998
	defb 012h,0adh	; 999a
	defb 06dh,068h	; 999c

; ======================================================================
; CODIGO 0x999e..0x9b34  (406 bytes)
; ======================================================================


L_999E:
	ret			;999e
L_999F:
	ld de,00080h		;999f
	ld hl,0c80eh		;99a2
	ld b,007h		;99a5
	call L_99AF		;99a7
	ld hl,0d70eh		;99aa
	ld b,008h		;99ad
L_99AF:
	bit 2,(hl)		;99af
	jr z,L_99B5		;99b1
	set 0,(hl)		;99b3
L_99B5:
	add hl,de			;99b5
	djnz L_99AF		;99b6
	ret			;99b8
L_99B9:
	ld a,(ix+006h)		;99b9   ; lee si la cosa se mueve
	and a			;99bc
	ret z			;99bd
	ld e,(ix+007h)		;99be   ; lee la velocidad vertical (parte baja)
	ld d,(ix+008h)		;99c1   ; lee la velocidad vertical
	ld l,(ix+002h)		;99c4   ; lee la fraccion de la y de la cosa
	ld h,(ix+003h)		;99c7   ; lee la y de la cosa
	add hl,de			;99ca
	ld (ix+002h),l		;99cb   ; guarda la fraccion de la y de la cosa
	ld (ix+003h),h		;99ce   ; guarda la y de la cosa
	ld e,(ix+009h)		;99d1   ; lee la velocidad horizontal (parte baja)
	ld d,(ix+00ah)		;99d4   ; lee la velocidad horizontal (el bit 7, hacia la izquierda)
	ld l,(ix+004h)		;99d7   ; lee la fraccion de la x de la cosa
	ld h,(ix+005h)		;99da   ; lee la x de la cosa
	add hl,de			;99dd
	ld (ix+004h),l		;99de   ; guarda la fraccion de la x de la cosa
	ld (ix+005h),h		;99e1   ; guarda la x de la cosa
	ret			;99e4
L_99E5:
	ld a,(ix+003h)		;99e5   ; lee la y de la cosa
	cp 0e4h		;99e8
	jr nc,borra_la_cosa		;99ea
	ld a,(ix+005h)		;99ec   ; lee la x de la cosa
	cp 0f1h		;99ef
	jr nc,borra_la_cosa		;99f1
	cp 007h		;99f3
	ret nc			;99f5
borra_la_cosa:
	xor a			;99f6
	ld (ix+000h),a		;99f7   ; guarda el tipo de la cosa
	ld (ix+00eh),a		;99fa
	push ix		;99fd
	pop hl			;99ff
	set 5,l		;9a00
	ld c,(hl)			;9a02
	ld a,c			;9a03
	and a			;9a04
	ret z			;9a05
	inc l			;9a06
L_9A07:
	ld a,(hl)			;9a07
	ld de,0d638h		;9a08
	add a,a			;9a0b
	add a,a			;9a0c
	add a,e			;9a0d
	ld e,a			;9a0e
	ld a,0e0h		;9a0f
	ld (de),a			;9a11
	ld a,l			;9a12
	add a,005h		;9a13
	ld l,a			;9a15
	dec c			;9a16
	jr nz,L_9A07		;9a17
	ret			;9a19
L_9A1A:
	call borra_la_cosa		;9a1a   ; borra_la_cosa: tipo a cero y sus sprites libres
	ld c,(ix+003h)		;9a1d   ; lee la y de la cosa
	ld b,(ix+005h)		;9a20   ; lee la x de la cosa
	ld hl,00000h		;9a23
	ld e,l			;9a26
	ld d,h			;9a27
	ld a,0ffh		;9a28
	push ix		;9a2a
	call crea_con_parametros		;9a2c   ; crea_con_parametros: guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa
	ld (ix+01fh),000h		;9a2f
	ld (ix+07eh),000h		;9a33
	pop ix		;9a37
	ret			;9a39
L_9A3A:
	ld a,001h		;9a3a
	jr L_9A3F		;9a3c
L_9A3E:
	xor a			;9a3e
L_9A3F:
	ld (0cfffh),a		;9a3f
	push ix		;9a42
	call L_9A4A		;9a44
	pop ix		;9a47
	ret			;9a49
L_9A4A:
	call L_9A6B		;9a4a
	ret c			;9a4d
	call borra_la_cosa		;9a4e   ; borra_la_cosa: tipo a cero y sus sprites libres
	call L_9ABE		;9a51
	ret c			;9a54
	call L_9B22		;9a55
L_9A58:
	ld c,01eh		;9a58
	push ix		;9a5a
	push bc			;9a5c
	call 05f1dh		;9a5d   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	pop bc			;9a60
	ld (ix+01fh),b		;9a61
	pop ix		;9a64
	ld hl,0ce08h		;9a66
	inc (hl)			;9a69
	ret			;9a6a
L_9A6B:
	ld a,(ix+000h)		;9a6b   ; lee el tipo de la cosa
	ld (0cff0h),a		;9a6e   ; guarda el tipo de la cosa que se crea
	cp 022h		;9a71
	jp z,L_9A8D		;9a73
	cp 024h		;9a76
	jr z,L_9A97		;9a78
	cp 026h		;9a7a
	jr z,L_9A92		;9a7c
	cp 011h		;9a7e
	jp z,L_9AA3		;9a80
	cp 009h		;9a83
	jr z,L_9AA9		;9a85
	cp 018h		;9a87
	jr z,L_9AB3		;9a89
	xor a			;9a8b
	ret			;9a8c
L_9A8D:
	call borra_la_cosa		;9a8d   ; borra_la_cosa: tipo a cero y sus sprites libres
	scf			;9a90
	ret			;9a91
L_9A92:
	ld a,(ix+01fh)		;9a92
	jr L_9A99		;9a95
L_9A97:
	ld a,001h		;9a97
L_9A99:
	push af			;9a99
	call borra_la_cosa		;9a9a   ; borra_la_cosa: tipo a cero y sus sprites libres
	pop af			;9a9d
	call L_8D2C		;9a9e
	scf			;9aa1
	ret			;9aa2
L_9AA3:
	ld (ix+001h),008h		;9aa3   ; el paso en que va la cosa = 0x08
	scf			;9aa7
	ret			;9aa8
L_9AA9:
	ld a,(0cfffh)		;9aa9
	and a			;9aac
	ret nz			;9aad
	call 0b048h		;9aae
	scf			;9ab1
	ret			;9ab2
L_9AB3:
	ld a,(0ce0bh)		;9ab3
	and a			;9ab6
	ret nz			;9ab7
	ld (ix+010h),008h		;9ab8
	scf			;9abc
	ret			;9abd
L_9ABE:
	ld b,000h		;9abe
	ld a,(0ce00h)		;9ac0
	and a			;9ac3
	ret nz			;9ac4
	ld a,(0cff0h)		;9ac5   ; lee el tipo de la cosa que se crea
	cp 00eh		;9ac8
	jr z,L_9AF3		;9aca
	ld a,(0cfffh)		;9acc
	and a			;9acf
	ret nz			;9ad0
	ld a,(ix+01fh)		;9ad1
	ld c,a			;9ad4
	and a			;9ad5
	jp nz,L_9B13		;9ad6
	ld hl,0cf40h		;9ad9
	inc (hl)			;9adc
	ld a,(hl)			;9add
	and 01fh		;9ade
	ld c,013h		;9ae0
	jp z,L_9B13		;9ae2
	ld a,r		;9ae5
	and 03fh		;9ae7
	ld c,002h		;9ae9
	jr z,L_9B13		;9aeb
	and 003h		;9aed
	ret nz			;9aef
	ld b,001h		;9af0
	ret			;9af2
L_9AF3:
	ld e,(ix+003h)		;9af3   ; lee la y de la cosa
	ld d,(ix+005h)		;9af6   ; lee la x de la cosa
	ld b,004h		;9af9
L_9AFB:
	push bc			;9afb
	push de			;9afc
	ld b,001h		;9afd
	ld a,(0cfffh)		;9aff
	and a			;9b02
	jr z,L_9B06		;9b03
	dec b			;9b05
L_9B06:
	call L_9A58		;9b06
	pop de			;9b09
	pop bc			;9b0a
	ld a,d			;9b0b
	add a,010h		;9b0c
	ld d,a			;9b0e
	djnz L_9AFB		;9b0f
	scf			;9b11
	ret			;9b12
L_9B13:
	push bc			;9b13
	call L_9B22		;9b14
	ld c,026h		;9b17
	call 05f1dh		;9b19   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	pop bc			;9b1c
	ld (ix+01fh),c		;9b1d
	scf			;9b20
	ret			;9b21
L_9B22:
	ld a,(0cff0h)		;9b22   ; lee el tipo de la cosa que se crea
	ld hl,l9b33h		;9b25
	call 04061h		;9b28   ; hl_mas_a: HL += A
	ld a,(ix+003h)		;9b2b   ; lee la y de la cosa
	sub (hl)			;9b2e
	ld e,a			;9b2f
	ld d,(ix+005h)		;9b30   ; lee la x de la cosa
L_9B33:
	ret			;9b33

; ----------------------------------------------------------------------
; DATOS tabla_sin_usar: 44 bytes (0x00, 0x10, 0x18, 0x20) que no nombra
;   ninguna instruccion; su direccion no aparece como palabra en el cartucho
;   0x9b34..0x9b60  (44 bytes)
DATA_tabla_sin_usar:
	defb 010h,010h,010h,000h,000h,010h,000h,000h,010h,010h,010h,000h,000h,000h,018h,010h	; 9b34  ................
	defb 020h,018h,018h,018h,018h,018h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 9b44   ...............
	defb 010h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 9b54  ............

; ======================================================================
; CODIGO 0x9b60..0x9c59  (249 bytes)
; ======================================================================


L_9B60:
	ld (ix+00bh),085h		;9b60   ; el dibujo de la cosa = 0x85
	ld (ix+00ch),010h		;9b64   ; la cuenta de cuadros del paso = 0x10
	ld (ix+00eh),000h		;9b68
	ld (ix+07eh),000h		;9b6c
	ret			;9b70
L_9B71:
	ld a,(ix+000h)		;9b71   ; lee el tipo de la cosa
	ld (0cff0h),a		;9b74   ; guarda el tipo de la cosa que se crea
	ld a,(ix+00ch)		;9b77   ; lee la cuenta de cuadros del paso
	and 004h		;9b7a
	ld c,085h		;9b7c
	jr z,L_9B81		;9b7e
	inc c			;9b80
L_9B81:
	ld (ix+00bh),c		;9b81   ; guarda el dibujo de la cosa
	dec (ix+00ch)		;9b84   ; baja la cuenta de cuadros del paso
	ret nz			;9b87
	call borra_la_cosa		;9b88   ; borra_la_cosa: tipo a cero y sus sprites libres
	ld a,(ix+01fh)		;9b8b
	and a			;9b8e
	ret z			;9b8f
	ld c,024h		;9b90
	ld e,(ix+003h)		;9b92   ; lee la y de la cosa
	ld d,(ix+005h)		;9b95   ; lee la x de la cosa
	jp 05f1dh		;9b98   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
L_9B9B:
	ld (ix+00eh),002h		;9b9b
	ld (ix+00ch),001h		;9b9f   ; la cuenta de cuadros del paso = 0x01
	ld (ix+006h),001h		;9ba3   ; la cosa se mueve
	ld de,00080h		;9ba7
	call 0a55dh		;9baa   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld de,00200h		;9bad
	call 0a56ch		;9bb0   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+011h),0ffh		;9bb3
	ld (ix+010h),0e0h		;9bb7
	ld (ix+00bh),000h		;9bbb   ; el dibujo de la cosa = 0x00
	ld (ix+07eh),000h		;9bbf
	ret			;9bc3
L_9BC4:
	ld (ix+00ch),014h		;9bc4   ; la cuenta de cuadros del paso = 0x14
	ld (ix+006h),000h		;9bc8   ; la cosa se queda quieta
	ld (ix+00eh),002h		;9bcc
	ld (ix+00bh),001h		;9bd0   ; el dibujo de la cosa = 0x01
	ld (ix+07eh),000h		;9bd4
	ret			;9bd8
L_9BD9:
	call L_9C5D		;9bd9
	jr c,L_9C03		;9bdc
	inc (ix+00ch)		;9bde   ; sube la cuenta de cuadros del paso
	ld e,(ix+010h)		;9be1
	ld d,(ix+011h)		;9be4
	call 0a564h		;9be7
	ld a,(ix+00ch)		;9bea   ; lee la cuenta de cuadros del paso
	sub 020h		;9bed
	ret nz			;9bef
	ld (ix+00ch),a		;9bf0   ; guarda la cuenta de cuadros del paso
	ld e,(ix+010h)		;9bf3
	ld d,(ix+011h)		;9bf6
	call 0a17ch		;9bf9   ; niega_de: DE = -DE
	ld (ix+010h),e		;9bfc
	ld (ix+011h),d		;9bff
	ret			;9c02
L_9C03:
	call borra_la_cosa		;9c03   ; borra_la_cosa: tipo a cero y sus sprites libres
	ld b,001h		;9c06
	ld hl,00410h		;9c08
L_9C0B:
	ld a,(ix+003h)		;9c0b   ; lee la y de la cosa
	sub l			;9c0e
	and 0f8h		;9c0f
	ld e,a			;9c11
	ld a,(ix+005h)		;9c12   ; lee la x de la cosa
	sub h			;9c15
	add a,004h		;9c16
	and 0f8h		;9c18
	ld d,a			;9c1a
	jp L_89E3		;9c1b
L_9C1E:
	ld hl,09c59h		;9c1e
	ld a,(0c003h)		;9c21   ; lee el contador de cuadros
	and 003h		;9c24
	call 04061h		;9c26   ; hl_mas_a: HL += A
	ld a,(hl)			;9c29
	ld (ix+025h),a		;9c2a
	ld a,(ix+001h)		;9c2d   ; lee el paso en que va la cosa
	and a			;9c30
	jr nz,L_9C46		;9c31
	dec (ix+00ch)		;9c33   ; baja la cuenta de cuadros del paso
	ret nz			;9c36
	inc (ix+001h)		;9c37   ; sube el paso en que va la cosa
	ld de,00000h		;9c3a
	call 0a56ch		;9c3d   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld de,00800h		;9c40
	jp 0a55dh		;9c43   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_9C46:
	ld (ix+006h),001h		;9c46   ; la cosa se mueve
	call L_9C5D		;9c4a
	ret nc			;9c4d
	call borra_la_cosa		;9c4e   ; borra_la_cosa: tipo a cero y sus sprites libres
	ld b,(ix+01fh)		;9c51
	ld hl,00810h		;9c54
	jr L_9C0B		;9c57

; ----------------------------------------------------------------------
; DATOS cuatro_valores_por_cuadro_2: cuatro bytes que p02:9C1E elige con los
;   dos bits bajos del contador de cuadros; son los mismos cuatro que 0x8CBD
;   0x9c59..0x9c5d  (4 bytes)
DATA_cuatro_valores_por_cuadro_2:
	defb 008h,001h,00eh,001h	; 9c59

; ======================================================================
; CODIGO 0x9c5d..0x9cbb  (94 bytes)
; ======================================================================


L_9C5D:
	ld e,(ix+003h)		;9c5d   ; lee la y de la cosa
	ld d,(ix+005h)		;9c60   ; lee la x de la cosa
	jp 07b98h		;9c63   ; choca_con_el_decorado: mira las dos celdas del decorado en (E, D) y (E, D-10)
L_9C66:
	ld (ix+00eh),000h		;9c66
	ld c,00eh		;9c6a
	ld a,(0d000h)		;9c6c   ; lee la FASE (0 el patio, 1-18)
	cp 00ah		;9c6f
	jr nz,L_9C79		;9c71
	ld c,015h		;9c73
	ld (ix+025h),00bh		;9c75
L_9C79:
	ld (ix+00bh),c		;9c79   ; guarda el dibujo de la cosa
	ld (ix+00ch),01eh		;9c7c   ; la cuenta de cuadros del paso = 0x1E
	ld (ix+006h),001h		;9c80   ; la cosa se mueve
	ld (ix+07eh),000h		;9c84
	ld hl,0cf30h		;9c88
	inc (hl)			;9c8b
	ld a,(hl)			;9c8c
	ld hl,0fb00h		;9c8d
	ld de,00100h		;9c90
	rra			;9c93
	jr c,L_9C9C		;9c94
	ld de,0ff00h		;9c96
	ld hl,0fa00h		;9c99
L_9C9C:
	call 0a56ch		;9c9c   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ex de,hl			;9c9f
	jp 0a55dh		;9ca0   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
L_9CA3:
	ld de,00080h		;9ca3
	jp 0a549h		;9ca6   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
L_9CA9:
	ld hl,0cf00h		;9ca9   ; apunta a los plazos de las siete cosas de la habitacion
	ld de,09cbbh		;9cac
	ld b,007h		;9caf
L_9CB1:
	ld a,(de)			;9cb1
	ld (hl),a			;9cb2
	inc de			;9cb3
	inc l			;9cb4
	ld (hl),000h		;9cb5
	inc l			;9cb7
	djnz L_9CB1		;9cb8
	ret			;9cba

; ----------------------------------------------------------------------
; DATOS cuentas_iniciales: siete cuentas que p02:9CA9 copia a 0xCF00: el
;   primer plazo de cada una de las siete cosas que puede soltar una
;   habitacion
;   0x9cbb..0x9cc3  (8 bytes)
DATA_cuentas_iniciales:
	defb 004h,004h,004h,008h,008h,008h,008h,008h	; 9cbb  ........

; ======================================================================
; CODIGO 0x9cc3..0x9d43  (128 bytes)
; ======================================================================


L_9CC3:
	exx			;9cc3
	ld hl,0cf10h		;9cc4   ; apunta a el reloj de los plazos
	dec (hl)			;9cc7
	ld a,(hl)			;9cc8
	exx			;9cc9
	and 003h		;9cca
	ret nz			;9ccc
	dec (hl)			;9ccd
	ret nz			;9cce
	inc l			;9ccf
	ld a,(hl)			;9cd0
	inc (hl)			;9cd1
	dec l			;9cd2
	and 007h		;9cd3
	call 04066h		;9cd5   ; de_mas_a: DE += A
	ld a,(0d012h)		;9cd8
	add a,a			;9cdb
	ld c,a			;9cdc
	ld a,(de)			;9cdd
	sub c			;9cde
	jr nc,L_9CE2		;9cdf
	xor a			;9ce1
L_9CE2:
	inc a			;9ce2
	ld (hl),a			;9ce3
	xor a			;9ce4
	ret			;9ce5
L_9CE6:
	ld hl,0cf00h		;9ce6   ; apunta a los plazos de las siete cosas de la habitacion
	ld de,09d43h		;9ce9
	call L_9CC3		;9cec
	ret nz			;9cef
	call L_9CFC		;9cf0
	call L_9E16		;9cf3
	ret c			;9cf6
	ld c,001h		;9cf7
	jp 05f1dh		;9cf9   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
L_9CFC:
	ld a,(0c425h)		;9cfc   ; lee la Y de Simon
	ld c,a			;9cff
	ld hl,(0d000h)		;9d00   ; lee la fase (0xD000) y la habitacion (0xD001) de un tiron
	ld a,l			;9d03
	dec a			;9d04
	jr z,L_9D28		;9d05
	dec a			;9d07
	jr z,L_9D1B		;9d08
	dec a			;9d0a
	jr z,L_9D17		;9d0b
	cp 008h		;9d0d
	jr z,L_9D13		;9d0f
	jr L_9D2C		;9d11
L_9D13:
	ld e,0b0h		;9d13
	jr L_9D1D		;9d15
L_9D17:
	ld e,0c0h		;9d17
	jr L_9D1D		;9d19
L_9D1B:
	ld e,0a0h		;9d1b
L_9D1D:
	ld d,0f0h		;9d1d
	ld a,(0cf01h)		;9d1f
	bit 1,a		;9d22
	ret z			;9d24
	ld d,010h		;9d25
	ret			;9d27
L_9D28:
	ld a,h			;9d28
	dec a			;9d29
	jr z,L_9D38		;9d2a
L_9D2C:
	ld e,0c0h		;9d2c
L_9D2E:
	ld d,0f0h		;9d2e
	ld a,(0c42ch)		;9d30   ; lee el lado al que mira Simon
	and a			;9d33
	ret z			;9d34
	ld d,010h		;9d35
	ret			;9d37
L_9D38:
	ld e,0c0h		;9d38
	ld a,c			;9d3a
	cp 088h		;9d3b
	jr nc,L_9D2E		;9d3d
	ld de,0f060h		;9d3f
	ret			;9d42

; ----------------------------------------------------------------------
; DATOS plazos_de_la_cosa_1: ocho plazos (en cuatro cuadros) que 0x9CC3
;   recorre en bucle entre una salida y la siguiente de la cosa del bit 0
;   (p02:9CE6); 0xD012 los acorta
;   0x9d43..0x9d4b  (8 bytes)
DATA_plazos_de_la_cosa_1:
	defb 00ch,012h,00ch,00ch,00ch,012h,00ch,00ch	; 9d43  ........

; ======================================================================
; CODIGO 0x9d4b..0x9d87  (60 bytes)
; ======================================================================


L_9D4B:
	ld hl,0cf02h		;9d4b
	ld c,002h		;9d4e
	jr L_9D57		;9d50
L_9D52:
	ld hl,0cf02h		;9d52
	ld c,003h		;9d55
L_9D57:
	ld de,09d8fh		;9d57
	push bc			;9d5a
	call L_9CC3		;9d5b
	pop bc			;9d5e
	ret nz			;9d5f
	ld e,0c8h		;9d60
	ld a,(0cf03h)		;9d62
	and 007h		;9d65
	ld hl,09d87h		;9d67
	call 04061h		;9d6a   ; hl_mas_a: HL += A
	ld d,(hl)			;9d6d
	ld a,(0c427h)		;9d6e   ; lee la X de Simon
	sub d			;9d71
	add a,018h		;9d72
	cp 030h		;9d74
	jp nc,05f1dh		;9d76   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	ld a,d			;9d79
	ld d,020h		;9d7a
	cp 080h		;9d7c
	jr c,L_9D82		;9d7e
	ld d,0e0h		;9d80
L_9D82:
	add a,d			;9d82
	ld d,a			;9d83
	jp 05f1dh		;9d84   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE

; ----------------------------------------------------------------------
; DATOS plazos_de_la_cosa_3: la tabla de p02:9D67 (ocho bytes, con los tres
;   bits bajos de 0xCF03) y los ocho plazos de 0x9D8F de la cosa de p02:9D52
;   0x9d87..0x9d97  (16 bytes)
DATA_plazos_de_la_cosa_3:
	defb 060h,0d0h,030h,090h,0a0h,040h,060h,0b0h,001h,018h,018h,018h,018h,018h,018h,018h	; 9d87  `.0..@`.........

; ======================================================================
; CODIGO 0x9d97..0x9dbb  (36 bytes)
; ======================================================================


L_9D97:
	ld hl,0cf06h		;9d97
	ld de,09dbbh		;9d9a
	ld c,004h		;9d9d
L_9D9F:
	push bc			;9d9f
	call L_9CC3		;9da0
	pop bc			;9da3
	ret nz			;9da4
	inc hl			;9da5
	ld a,(hl)			;9da6
	rr a		;9da7
	ld d,0f0h		;9da9
	jr c,L_9DAF		;9dab
	ld d,010h		;9dad
L_9DAF:
	call L_9E16		;9daf
	ld a,(0c425h)		;9db2   ; lee la Y de Simon
	sub 008h		;9db5
	ld e,a			;9db7
	jp 05f1dh		;9db8   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE

; ----------------------------------------------------------------------
; DATOS plazos_de_la_cosa_4: ocho plazos de la cosa de p02:9D97
;   0x9dbb..0x9dc3  (8 bytes)
DATA_plazos_de_la_cosa_4:
	defb 014h,014h,014h,028h,014h,014h,014h,028h	; 9dbb  ...(...(

; ======================================================================
; CODIGO 0x9dc3..0x9dcd  (10 bytes)
; ======================================================================


L_9DC3:
	ld hl,0cf08h		;9dc3
	ld de,09dcdh		;9dc6
	ld c,007h		;9dc9
	jr $-44		;9dcb

; ----------------------------------------------------------------------
; DATOS plazos_de_la_cosa_5: ocho plazos de la cosa de p02:9DC3
;   0x9dcd..0x9dd5  (8 bytes)
DATA_plazos_de_la_cosa_5:
	defb 01ch,01ch,01ch,048h,01ch,01ch,01ch,048h	; 9dcd  ...H...H

; ======================================================================
; CODIGO 0x9dd5..0x9ddf  (10 bytes)
; ======================================================================


L_9DD5:
	ld hl,0cf0ah		;9dd5
	ld de,09ddfh		;9dd8
	ld c,008h		;9ddb
	jr $-62		;9ddd

; ----------------------------------------------------------------------
; DATOS plazos_de_la_cosa_6: ocho plazos de la cosa de p02:9DD5
;   0x9ddf..0x9de7  (8 bytes)
DATA_plazos_de_la_cosa_6:
	defb 00ch,00ch,00ch,018h,00ch,00ch,00ch,018h	; 9ddf  ........

; ======================================================================
; CODIGO 0x9de7..0x9e0e  (39 bytes)
; ======================================================================


L_9DE7:
	ld hl,0cf0ch		;9de7
	ld de,09e0eh		;9dea
	call L_9CC3		;9ded
	ret nz			;9df0
	ld a,(0c427h)		;9df1   ; lee la X de Simon
	cp 0c0h		;9df4
	jr c,L_9DFE		;9df6
	ld a,001h		;9df8
	ld (0cf0ch),a		;9dfa
	ret			;9dfd
L_9DFE:
	ld de,0e030h		;9dfe
	ld a,(0cf0dh)		;9e01
	rra			;9e04
	jr c,L_9E09		;9e05
	ld e,040h		;9e07
L_9E09:
	ld c,00fh		;9e09
	jp 05f1dh		;9e0b   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE

; ----------------------------------------------------------------------
; DATOS plazos_de_la_cosa_7: ocho plazos de la cosa de p02:9DE7
;   0x9e0e..0x9e16  (8 bytes)
DATA_plazos_de_la_cosa_7:
	defb 018h,018h,018h,018h,018h,018h,018h,018h	; 9e0e  ........

; ======================================================================
; CODIGO 0x9e16..0x9e5f  (73 bytes)
; ======================================================================


L_9E16:
	ld a,(0c427h)		;9e16   ; lee la X de Simon
	cp 0c0h		;9e19
	jr nc,L_9E29		;9e1b
	cp 040h		;9e1d
	jr c,L_9E22		;9e1f
	ret			;9e21
L_9E22:
	ld a,d			;9e22
	cp 040h		;9e23
	ret nc			;9e25
	ld d,0f0h		;9e26
	ret			;9e28
L_9E29:
	ld a,d			;9e29
	cp 0c0h		;9e2a
	ccf			;9e2c
	ret nc			;9e2d
	ld d,010h		;9e2e
	ret			;9e30
L_9E31:
	ld ix,0d700h		;9e31
	ld b,008h		;9e35
L_9E37:
	ld a,(ix+000h)		;9e37   ; lee el tipo de la cosa
	and a			;9e3a
	jr z,L_9E50		;9e3b
	push bc			;9e3d
	call L_992F		;9e3e
	jr c,L_9E49		;9e41
	call L_9E58		;9e43
	call L_99B9		;9e46
L_9E49:
	call 06445h		;9e49
	call L_99E5		;9e4c
	pop bc			;9e4f
L_9E50:
	ld de,00080h		;9e50
	add ix,de		;9e53
	djnz L_9E37		;9e55
	ret			;9e57
L_9E58:
	ld a,(ix+000h)		;9e58   ; lee el tipo de la cosa
	dec a			;9e5b
	call 0406bh		;9e5c   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9E5F: 12 destinos del despachador de 0x406B (call en p02:9E5C):
;   0x9E77, 0x9E77, 0x9E77, 0x9F07, 0x9E77, 0x9E78, 0x9E90, 0x9F22 ...; lo
;   leen p02:9E5C (24 bytes)
;   0x9e5f..0x9e77  (24 bytes)
DATA_tabla_9E5F:
	defb 077h,09eh	; 9e5f
	defb 077h,09eh	; 9e61
	defb 077h,09eh	; 9e63
	defb 007h,09fh	; 9e65
	defb 077h,09eh	; 9e67
	defb 078h,09eh	; 9e69
	defb 090h,09eh	; 9e6b
	defb 022h,09fh	; 9e6d
	defb 0c5h,09eh	; 9e6f
	defb 077h,09eh	; 9e71
	defb 0c4h,09eh	; 9e73
	defb 071h,09bh	; 9e75

; ======================================================================
; CODIGO 0x9e77..0xa000  (393 bytes)
; ======================================================================


L_9E77:
	ret			;9e77
L_9E78:
	inc (ix+00ch)		;9e78   ; sube la cuenta de cuadros del paso
	bit 1,(ix+00ch)		;9e7b   ; mira el bit 1 de la cuenta de cuadros del paso
	ld a,027h		;9e7f
	jr z,L_9E84		;9e81
	inc a			;9e83
L_9E84:
	bit 7,(ix+00ah)		;9e84   ; va hacia la izquierda? (bit 7 de la velocidad horizontal)
	jr nz,L_9E8C		;9e88
	add a,002h		;9e8a
L_9E8C:
	ld (ix+00bh),a		;9e8c   ; guarda el dibujo de la cosa
	ret			;9e8f
L_9E90:
	ld e,(ix+012h)		;9e90
	ld d,(ix+013h)		;9e93
	ld l,(ix+010h)		;9e96
	ld h,(ix+011h)		;9e99
	add hl,de			;9e9c
	ld (ix+010h),l		;9e9d
	ld (ix+011h),h		;9ea0
	ld a,(ix+00ch)		;9ea3   ; lee la cuenta de cuadros del paso
	inc (ix+00ch)		;9ea6   ; sube la cuenta de cuadros del paso
	and 004h		;9ea9
	ld c,039h		;9eab
	jr z,L_9EB0		;9ead
	inc c			;9eaf
L_9EB0:
	ld (ix+00bh),c		;9eb0   ; guarda el dibujo de la cosa
	ld de,00030h		;9eb3
	ld a,(ix+003h)		;9eb6   ; lee la y de la cosa
	cp (ix+011h)		;9eb9
	jr c,L_9EC1		;9ebc
	ld de,0ffd0h		;9ebe
L_9EC1:
	jp 0a549h		;9ec1   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
L_9EC4:
	ret			;9ec4
L_9EC5:
	inc (ix+00ch)		;9ec5   ; sube la cuenta de cuadros del paso
	ld a,(ix+00ch)		;9ec8   ; lee la cuenta de cuadros del paso
	rra			;9ecb
	rra			;9ecc
	and 003h		;9ecd
	add a,063h		;9ecf
	ld (ix+00bh),a		;9ed1   ; guarda el dibujo de la cosa
	bit 7,(ix+010h)		;9ed4
	ld de,00018h		;9ed8
	jr nz,L_9EE0		;9edb
	ld de,0ffe8h		;9edd
L_9EE0:
	call 0a564h		;9ee0
	ld a,(ix+013h)		;9ee3
	and a			;9ee6
	jr z,L_9EED		;9ee7
	dec (ix+013h)		;9ee9
	ret			;9eec
L_9EED:
	ld l,(ix+011h)		;9eed
	ld h,(ix+012h)		;9ef0
	ld a,(hl)			;9ef3
	cp 010h		;9ef4
	ret nz			;9ef6
	ld a,005h		;9ef7
	add a,l			;9ef9
	ld l,a			;9efa
	ld a,(hl)			;9efb
	sub (ix+005h)		;9efc   ; le resta la x de la cosa
	add a,010h		;9eff
	cp 020h		;9f01
	ret nc			;9f03
	jp borra_la_cosa		;9f04   ; borra_la_cosa: tipo a cero y sus sprites libres
L_9F07:
	ld a,(ix+00ch)		;9f07   ; lee la cuenta de cuadros del paso
	inc a			;9f0a
	cp 00ch		;9f0b
	jr c,L_9F10		;9f0d
	xor a			;9f0f
L_9F10:
	ld (ix+00ch),a		;9f10   ; guarda la cuenta de cuadros del paso
	rra			;9f13
	rra			;9f14
	and 003h		;9f15
	add a,04bh		;9f17
	ld (ix+00bh),a		;9f19   ; guarda el dibujo de la cosa
	ld de,00050h		;9f1c
	jp 0a549h		;9f1f   ; suma_a_la_velocidad_y: la gravedad: DE a la velocidad vertical, con tope 0x07FF
L_9F22:
	ld a,(ix+00ch)		;9f22   ; lee la cuenta de cuadros del paso
	rra			;9f25
	rra			;9f26
	and 003h		;9f27
	add a,07dh		;9f29
	ld (ix+00bh),a		;9f2b   ; guarda el dibujo de la cosa
	ld a,(ix+001h)		;9f2e   ; lee el paso en que va la cosa
	dec a			;9f31
	jr z,L_9F4C		;9f32
	dec (ix+00ch)		;9f34   ; baja la cuenta de cuadros del paso
	ret nz			;9f37
	ld a,040h		;9f38
	call 0a0e7h		;9f3a
	call 0a56ch		;9f3d   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ex de,hl			;9f40
	call 0a55dh		;9f41   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+00ch),01eh		;9f44   ; la cuenta de cuadros del paso = 0x1E
	inc (ix+001h)		;9f48   ; sube el paso en que va la cosa
	ret			;9f4b
L_9F4C:
	dec (ix+00ch)		;9f4c   ; baja la cuenta de cuadros del paso
	ret nz			;9f4f
	ld de,00000h		;9f50
	call 0a56ch		;9f53   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	call 0a55dh		;9f56   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ld (ix+00ch),03ch		;9f59   ; la cuenta de cuadros del paso = 0x3C
	ld (ix+001h),e		;9f5d   ; guarda el paso en que va la cosa
	ret			;9f60
L_9F61:
	ld a,(ix+003h)		;9f61   ; lee la y de la cosa
	sub 010h		;9f64
	ld c,a			;9f66
	ld b,(ix+005h)		;9f67   ; lee la x de la cosa
	ld a,(ix+000h)		;9f6a   ; lee el tipo de la cosa
crea_con_parametros:
	ld (0cff9h),a		;9f6d
	ld (0cff1h),bc		;9f70   ; guarda la posicion de la cosa que se crea
	ld (0cff5h),hl		;9f74
	ld (0cff7h),de		;9f77
	push ix		;9f7b
	call L_9F83		;9f7d
	pop ix		;9f80
	ret			;9f82
L_9F83:
	ld a,(0cff9h)		;9f83
	cp 0ffh		;9f86
	ld c,00ch		;9f88
	jr z,L_9F93		;9f8a
	ld hl,0a08eh		;9f8c
	call 04061h		;9f8f   ; hl_mas_a: HL += A
	ld c,(hl)			;9f92
L_9F93:
	ld a,c			;9f93
	ld (0cff0h),a		;9f94   ; guarda el tipo de la cosa que se crea
	ld hl,0d700h		;9f97
	ld b,008h		;9f9a
	xor a			;9f9c
	ld de,00080h		;9f9d
L_9FA0:
	cp (hl)			;9fa0
	jr z,L_9FA7		;9fa1
	add hl,de			;9fa3
	djnz L_9FA0		;9fa4
	ret			;9fa6
L_9FA7:
	push hl			;9fa7
	pop ix		;9fa8
	ld (0cff3h),hl		;9faa   ; guarda la ficha de la cosa que se crea
	ld c,002h		;9fad
	ld (ix+020h),c		;9faf   ; guarda cuantos sprites lleva la cosa
	ld (ix+07fh),001h		;9fb2
	ld (ix+07eh),001h		;9fb6
	ld de,01100h		;9fba
	ld hl,0d67ch		;9fbd
	ld b,008h		;9fc0
	ld a,(0ce03h)		;9fc2
	and a			;9fc5
	jr z,L_9FCA		;9fc6
	ld b,002h		;9fc8
L_9FCA:
	ld a,(hl)			;9fca
	cp 0e0h		;9fcb
	jr nz,L_9FD8		;9fcd
	ld (hl),0e1h		;9fcf
	call 06048h		;9fd1
	inc e			;9fd4
	dec c			;9fd5
	jr z,L_9FE0		;9fd6
L_9FD8:
	dec d			;9fd8
	dec l			;9fd9
	dec l			;9fda
	dec l			;9fdb
	dec l			;9fdc
	djnz L_9FCA		;9fdd
	ret			;9fdf
L_9FE0:
	ld hl,(0cff3h)		;9fe0   ; lee la ficha de la cosa que se crea
	ld a,(0cff0h)		;9fe3   ; lee el tipo de la cosa que se crea
	ld (hl),a			;9fe6
	inc l			;9fe7
	ld (hl),000h		;9fe8
	ld de,(0cff1h)		;9fea   ; lee la posicion de la cosa que se crea
	inc l			;9fee
	ld (hl),000h		;9fef
	inc l			;9ff1
	ld (hl),e			;9ff2
	inc l			;9ff3
	ld (hl),000h		;9ff4
	inc l			;9ff6
	ld (hl),d			;9ff7
	inc l			;9ff8
	ld (hl),001h		;9ff9
	inc l			;9ffb
	ld de,(0cff5h)		;9ffc
