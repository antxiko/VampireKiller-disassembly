; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l509eh:	equ 0x0509e

; ----------------------------------------------------------------------
; DATOS cabecera_ab: la cabecera del cartucho: 'AB', INIT (0x4075) y
;   STATEMENT, DEVICE y TEXT a cero; lo leen la BIOS (16 bytes)
;   0x4000..0x4010  (16 bytes)
DATA_cabecera_ab:
	defb 041h,042h,075h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  ABu@............

; ----------------------------------------------------------------------
; DATOS cabecera_de_konami: la cabecera de Konami que empieza por 'CD' y lee
;   el Game Master; lo leen el Game Master (24 bytes)
;   0x4010..0x4028  (24 bytes)
DATA_cabecera_de_konami:
	defb 043h,000h,044h,000h,007h,000h,044h,000h	; 4010  C.D...D.
	defb 0e8h,000h,0c0h,004h,000h,011h,0c4h,000h	; 4018  ........
	defb 0d0h,012h,010h,0c4h,000h,000h,005h,0c4h	; 4020  ........

; ======================================================================
; CODIGO 0x4028..0x4161  (313 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LA INTERRUPCION (H.TIMI). INIT deja el Z80 en un `jr $` y todo el juego corre desde aqui, una vez por cuadro: primero la pausa, luego el sonido con los bancos 14 y 15, y despues, si no se esta ya dentro (semaforo de 0xC005), la maquina de estados.
; ----------------------------------------------------------------------
interrupcion:
	di			;4028   ; sin interrupciones mientras se cambian bancos
	ld a,(0e600h)		;4029   ; lee si hay un GAME MASTER en otra ranura
	or a			;402c   ; sin Game Master, no hay pausa
	jp nz,L_40C5		;402d   ; con el: a mirar STOP
sonido_del_cuadro:
	di			;4030   ; el sonido: bancos 14 y 15 sin tocar la copia de 0xF0F2/0xF0F3
	ld a,00eh		;4031   ; el banco 14 (el reproductor)
	ld (08000h),a		;4033   ; el mapper: pone en 0x8000 el banco de A
	ld a,00fh		;4036   ; el banco 15 (las partituras)
	ld (0a000h),a		;4038   ; el mapper: pone en 0xA000 el banco de A
	call 08964h		;403b   ; reproductor: un cuadro de sonido
	di			;403e   ; y se devuelven los bancos que habia, leyendo la copia
	ld a,(0f0f2h)		;403f   ; lee la copia del banco de 0x8000
	ld (08000h),a		;4042   ; el mapper: pone en 0x8000 el banco de A
	ld a,(0f0f3h)		;4045   ; lee la copia del banco de 0xA000
	ld (0a000h),a		;4048   ; el mapper: pone en 0xA000 el banco de A
	ld hl,0c005h		;404b   ; apunta a el semaforo de la interrupcion
	bit 0,(hl)		;404e   ; ya estamos dentro (un cuadro que no acabo a tiempo)?
	jp nz,L_405F		;4050   ; si: no se entra dos veces
	inc (hl)			;4053   ; el semaforo, puesto
	ei			;4054   ; ya se pueden anidar interrupciones: el sonido no se para
	call lee_los_mandos		;4055   ; lee los mandos
	call maquina_de_estados		;4058   ; maquina_de_estados: sube el contador de cuadros y despacha por el estado de 0xC000
	xor a			;405b   ; el semaforo, quitado
	ld (0c005h),a		;405c   ; guarda el semaforo de la interrupcion
L_405F:
	ei			;405f
	ret			;4060
hl_mas_a:
	add a,l			;4061   ; suma A a L
	ld l,a			;4062
	ret nc			;4063   ; sin acarreo, listo
	inc h			;4064   ; con acarreo, sube H
	ret			;4065
de_mas_a:
	add a,e			;4066   ; suma A a E
	ld e,a			;4067
	ret nc			;4068   ; sin acarreo, listo
	inc d			;4069   ; con acarreo, sube D
	ret			;406a

; ----------------------------------------------------------------------
; EL DESPACHADOR DE KONAMI. La tabla de destinos va pegada detras del `call`: la direccion de vuelta que se saca de la pila es la base de la tabla, y A el indice.
; ----------------------------------------------------------------------
despacha:
	pop hl			;406b   ; HL = la vuelta, o sea la tabla
	add a,a			;406c   ; dos bytes por entrada
	call hl_mas_a		;406d   ; hl_mas_a: HL += A
	ld e,(hl)			;4070   ; el destino, en DE
	inc hl			;4071
	ld d,(hl)			;4072
	ex de,hl			;4073   ; a HL
	jp (hl)			;4074   ; y alla que va (sin volver aqui)
init:
	di			;4075   ; INIT: sin interrupciones
	ld sp,0f0f0h		;4076   ; la pila justo debajo de la copia del mapper
	call 00138h		;4079   ; BIOS RSLREG - Reads the primary slot register
	rrca			;407c   ; los dos bits de la pagina 1 (donde esta el cartucho)
	rrca			;407d
	and 003h		;407e
	ld c,a			;4080   ; C = la ranura primaria del cartucho
	ld b,000h		;4081
	ld hl,0fcc1h		;4083   ; EXPTBL: si esa ranura esta expandida
	add hl,bc			;4086
	ld a,(hl)			;4087
	and 080h		;4088   ; el bit de expandida
	or c			;408a
	ld c,a			;408b
	inc hl			;408c   ; SLTTBL de esa ranura (0xFCC5 + ranura)
	inc hl			;408d
	inc hl			;408e
	inc hl			;408f
	ld a,(hl)			;4090
	and 00ch		;4091   ; los bits de la subranura de la pagina 1
	or c			;4093   ; A = el identificador de ranura del cartucho
	ld h,080h		;4094   ; y se pone tambien en la pagina 2 (0x8000-0xBFFF)
	call 00024h		;4096   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,0c000h		;4099   ; apunta a el ESTADO del juego
	ld de,0c001h		;409c   ; apunta a el subestado
	ld bc,030efh		;409f   ; borra 0xC000-0xF0EF: toda la RAM del juego
	ld (hl),000h		;40a2   ; el primer byte a cero, y ldir lo arrastra
	ldir		;40a4
	call bancos_1_2_3		;40a6   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
	call busca_el_game_master		;40a9   ; inicia el sonido
	call bancos_1_2_3		;40ac   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
	call prepara_la_pantalla		;40af   ; inicia el VDP
	di			;40b2   ; y se engancha la interrupcion:
	ld a,0c3h		;40b3   ; un `jp`
	ld (0fd9fh),a		;40b5   ; en H.TIMI
	ld hl,interrupcion		;40b8   ; a la interrupcion de 0x4028
	ld (0fda0h),hl		;40bb
	xor a			;40be   ; CLIKSW a cero: sin el clic de las teclas
	ld (0f3dbh),a		;40bf
	ei			;40c2
L_40C3:
	jr L_40C3		;40c3   ; y aqui se queda para siempre: el juego va por interrupcion

; ----------------------------------------------------------------------
; LA PAUSA, solo con un Game Master en otra ranura (0xE600). STOP (fila 7, bit 4) pone y quita la pausa; con el juego pausado, la tecla de la fila 1, bit 7 (el ';' del teclado internacional) avanza UN cuadro: devuelve los volumenes, corre el sonido y el juego una vez y sigue en pausa. Solo cuenta la pulsacion nueva (0xE610 guarda las teclas del cuadro anterior).
; ----------------------------------------------------------------------
L_40C5:
	ld a,007h		;40c5   ; fila 7 del teclado
	call 00141h		;40c7   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;40ca   ; a uno lo pulsado
	and 010h		;40cb   ; STOP
	ld b,a			;40cd
	ld a,001h		;40ce   ; fila 1
	call 00141h		;40d0   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;40d3
	and 080h		;40d4   ; el bit 7: avanzar un cuadro
	or b			;40d6   ; las dos teclas juntas en A
	ld hl,0e610h		;40d7   ; las del cuadro anterior
	ld c,(hl)			;40da
	ld (hl),a			;40db   ; guarda las de ahora
	xor c			;40dc   ; C = solo las que se acaban de pulsar
	and (hl)			;40dd
	ld c,a			;40de
	ld hl,0e601h		;40df   ; la pausa puesta?
	ld a,(hl)			;40e2
	or a			;40e3
	jr nz,L_40F1		;40e4   ; si: a ver que se pulsa
	bit 4,c		;40e6   ; no hay pausa: se ha pulsado STOP?
	jp z,sonido_del_cuadro		;40e8   ; sonido_del_cuadro: pone los bancos 14 y 15, llama al reproductor y los devuelve
	ld (hl),c			;40eb   ; se pone la pausa (0xE601 distinto de cero)
	call guarda_y_calla_el_psg		;40ec   ; guarda los volumenes y calla el PSG
	ei			;40ef   ; y este cuadro no corre el juego
	ret			;40f0
L_40F1:
	bit 7,c		;40f1   ; en pausa: se pide avanzar un cuadro?
	jp nz,L_40FC		;40f3   ; si: un cuadro sin quitar la pausa
	bit 4,c		;40f6   ; STOP otra vez?
	jr z,L_4102		;40f8   ; no: sigue en pausa y callado
	xor a			;40fa   ; si: se quita la pausa
	ld (hl),a			;40fb
L_40FC:
	call devuelve_los_volumenes		;40fc   ; devuelve los volumenes
	jp sonido_del_cuadro		;40ff   ; sonido_del_cuadro: pone los bancos 14 y 15, llama al reproductor y los devuelve
L_4102:
	call calla_el_psg		;4102   ; en pausa: el PSG callado
	ei			;4105
	ret			;4106
guarda_y_calla_el_psg:
	ld a,008h		;4107   ; guarda el volumen del canal A (registro 8)
	call 00096h		;4109   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e611h),a		;410c   ; en 0xE611
	ld a,009h		;410f   ; el del canal B (registro 9)
	call 00096h		;4111   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e612h),a		;4114   ; en 0xE612
	ld a,00ah		;4117   ; el del canal C (registro 10)
	call 00096h		;4119   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e613h),a		;411c   ; en 0xE613
calla_el_psg:
	ld e,000h		;411f   ; y los tres volumenes a cero
	ld a,008h		;4121
	call 00093h		;4123   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,000h		;4126   ; registro 9
	inc a			;4128
	call 00093h		;4129   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,000h		;412c   ; registro 10
	inc a			;412e
	jp 00093h		;412f   ; BIOS WRTPSG - Writes data to PSG-register
devuelve_los_volumenes:
	ld a,(0e611h)		;4132   ; devuelve el volumen del canal A
	ld e,a			;4135
	ld a,008h		;4136
	call 00093h		;4138   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e612h)		;413b   ; el del canal B
	ld e,a			;413e
	ld a,009h		;413f
	call 00093h		;4141   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e613h)		;4144   ; el del canal C
	ld e,a			;4147
	ld a,00ah		;4148
	jp 00093h		;414a   ; BIOS WRTPSG - Writes data to PSG-register
maquina_de_estados:
	ld hl,0c003h		;414d   ; apunta a el contador de cuadros
	inc (hl)			;4150   ; un cuadro mas
	ld bc,(0c000h)		;4151   ; lee el estado (0xC000) y el subestado (0xC001) de un tiron
	ld a,c			;4155   ; los estados 0, 1 y 2 (la presentacion)
	cp 003h		;4156
	jr nc,L_415E		;4158
	ld hl,04391h		;415a   ; vuelven a 0x4391 en vez de aqui
	push hl			;415d   ; (la vuelta, metida en la pila)
L_415E:
	call despacha		;415e   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_4161: 14 destinos del despachador de 0x406B (call en p00:415E):
;   0x417D, 0x41A0, 0x41AB, 0x41D1, 0x422C, 0x4257, 0x4294, 0x42B2 ...; lo
;   leen p00:415E (28 bytes)
;   0x4161..0x417d  (28 bytes)
DATA_tabla_4161:
	defb 07dh,041h	; 4161
	defb 0a0h,041h	; 4163
	defb 0abh,041h	; 4165
	defb 0d1h,041h	; 4167
	defb 02ch,042h	; 4169
	defb 057h,042h	; 416b
	defb 094h,042h	; 416d
	defb 0b2h,042h	; 416f
	defb 024h,043h	; 4171
	defb 077h,043h	; 4173
	defb 087h,043h	; 4175
	defb 0dah,043h	; 4177
	defb 0f0h,043h	; 4179
	defb 014h,044h	; 417b

; ======================================================================
; CODIGO 0x417d..0x4300  (387 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LOS ESTADOS DEL JUEGO (0xC000, por la tabla de 0x4161; el subestado 0xC001 va en B y cada `djnz` salta al siguiente, asi que lo primero tras el primer `djnz` es el subestado 1 y lo ultimo, el 0). 0 la presentacion, 1 el titulo, 2 la demostracion, 3 empieza la partida, 4 empieza una vida, 5 el juego, 6 Simon muere, 7 GAME OVER, 8 bloque acabado (tras el jefe), 9 cambio de habitacion, 0x0A fase acabada (la puerta), 0x0B la pausa del juego, 0x0C la tienda y 0x0D el menu del Game Master. En los estados 0, 1 y 2 se vuelve por 0x4391, que mira las teclas.
; ----------------------------------------------------------------------
estado_0_la_presentacion:
	djnz presentacion_espera		;417d
	call 0624ch		;417f   ; subestado 1: la presentacion, cada cuadro...
	ld a,(0c422h)		;4182   ; ... hasta 0xC422
	or a			;4185
	ret z			;4186
	xor a			;4187   ; y espera 0 cuadros
	jr espera_y_al_subestado_siguiente		;4188
presentacion_espera:
	djnz presentacion_empieza		;418a
	ld hl,0c004h		;418c   ; subestado 2: al acabar la espera...
	dec (hl)			;418f
	ret nz			;4190
	call pinta_el_titulo		;4191   ; ... el titulo...
	xor a			;4194   ; ... y al estado 1, sin espera
	jp L_424B		;4195
presentacion_empieza:
	call pantalla_en_negro		;4198   ; subestado 0: pantalla en negro...
	call 06202h		;419b   ; ... y empieza la presentacion
	jr al_subestado_siguiente		;419e
estado_1_el_titulo:
	ld hl,0c004h		;41a0   ; al acabar la espera...
	dec (hl)			;41a3
	ret nz			;41a4
	call 07ae7h		;41a5   ; ... lo de 0x7AE7 y al estado 2
	jp al_estado_siguiente		;41a8
estado_2_la_demostracion:
	djnz empieza_la_demostracion		;41ab
	call un_cuadro_de_la_demostracion		;41ad   ; subestado 1: un cuadro de la demostracion
	ld a,(0c413h)		;41b0   ; mientras dure...
	or a			;41b3
	ret nz			;41b4   ; ... sigue
al_estado_0:
	xor a			;41b5   ; al estado 0
cambia_de_estado:
	ld (0c000h),a		;41b6   ; guarda el ESTADO del juego
	ld a,020h		;41b9   ; 0x20 cuadros de espera
	ld (0c004h),a		;41bb   ; guarda la espera del estado, en cuadros
	jp subestado_0		;41be   ; y subestado 0
empieza_la_demostracion:
	call pantalla_en_negro		;41c1   ; subestado 0: pantalla en negro...
	call prepara_la_demostracion		;41c4   ; ... y la demostracion
	ld a,020h		;41c7   ; 0x20 cuadros
espera_y_al_subestado_siguiente:
	ld (0c004h),a		;41c9   ; A cuadros de espera
al_subestado_siguiente:
	ld hl,0c001h		;41cc   ; el subestado siguiente
	inc (hl)			;41cf
	ret			;41d0
estado_3_empieza_la_partida:
	djnz estado_3_a_cero		;41d1   ; subestado 1: PLAY START...
	ld hl,0c004h		;41d3   ; apunta a la espera del estado, en cuadros
	dec (hl)			;41d6
	jr z,al_subestado_siguiente		;41d7   ; ... hasta acabar la espera...
	bit 2,(hl)		;41d9   ; ... pintado cuatro cuadros y borrado cuatro
	ld hl,04d29h		;41db
	jp z,rotulo		;41de   ; rotulo: pinta un rotulo ([x][y] y texto; 0xFE otra posicion, 0xFF acaba)
	jp borra_rotulo		;41e1   ; borra_rotulo: lo mismo que 0x4ACB pero borrando
estado_3_a_cero:
	djnz estado_3_prepara		;41e4
	call partida_a_cero		;41e6   ; subestado 2: marcador, vidas y vida a cero
	jp al_subestado_siguiente		;41e9
estado_3_prepara:
	djnz estado_3_mueve_las_cosas		;41ec
	ld a,001h		;41ee   ; subestado 3: 0xC41A a 1...
	ld (0c41ah),a		;41f0   ; guarda la habitacion especial
	call 063d3h		;41f3   ; ... lo de 0x63D3...
	ld a,0a0h		;41f6   ; ... 0xA0 cuadros
	jp espera_y_al_subestado_siguiente		;41f8
estado_3_mueve_las_cosas:
	djnz suena_la_partida		;41fb
	call mueve_la_escena		;41fd   ; subestado 4: las cosas se mueven...
	ld hl,0c004h		;4200   ; apunta a la espera del estado, en cuadros
	ld a,(0c003h)		;4203   ; ... y cada dos cuadros...
	rra			;4206
	ret c			;4207
	dec (hl)			;4208   ; ... la espera baja
	ret nz			;4209
	call esconde_los_sprites		;420a   ; al acabar: sin sprites...
	xor a			;420d
	ld (0c41ah),a		;420e   ; ... fuera la habitacion especial...
	call 062d0h		;4211   ; ... lo de 0x62D0...
	ld hl,0e604h		;4214   ; ... y con 0xE604 puesto...
	ld a,(hl)			;4217
	or a			;4218
	jr z,L_4220		;4219
	ld (hl),000h		;421b   ; ... se gasta y lo de 0x5E31
	call lo_que_da_el_game_master		;421d
L_4220:
	jr al_estado_siguiente		;4220   ; al estado 4
suena_la_partida:
	ld a,08ah		;4222   ; subestado 0: la musica 0x8A...
	call sonido		;4224   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,050h		;4227   ; ... y 0x50 cuadros
	jp espera_y_al_subestado_siguiente		;4229
estado_4_empieza_una_vida:
	ld hl,0c410h		;422c   ; una vida menos
	ld a,(hl)			;422f
	sub 001h		;4230
	daa			;4232
	ld (hl),a			;4233
	call apaga_la_pantalla		;4234   ; pantalla apagada
	call pinta_el_marcador		;4237   ; el marcador
	call 062e6h		;423a   ; la habitacion
	ld hl,0c413h		;423d   ; la vida en marcha
	ld (hl),001h		;4240
	call 0794fh		;4242   ; lo de 0x794F
	xor a			;4245
	ld (0c40dh),a		;4246
al_estado_siguiente:
	ld a,020h		;4249   ; 0x20 cuadros...
L_424B:
	ld (0c004h),a		;424b   ; guarda la espera del estado, en cuadros
	ld hl,0c000h		;424e   ; ... en el estado siguiente...
	inc (hl)			;4251
subestado_0:
	xor a			;4252   ; ... desde el subestado 0
	ld (0c001h),a		;4253   ; guarda el subestado
	ret			;4256
estado_5_el_juego:
	call un_cuadro_del_juego		;4257   ; un cuadro del juego
	ld a,(0c40ch)		;425a   ; la tienda (0xC40C)?
	or a			;425d
	ld a,00ch		;425e   ; si: al estado 0x0C
	jp nz,cambia_de_estado		;4260   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
	ld a,(0c40ah)		;4263   ; la pausa (0xC40A)?
	and a			;4266
	jp nz,a_la_pausa		;4267
	ld a,(0c41bh)		;426a   ; se sale de la habitacion?
	and a			;426d
	ld a,009h		;426e   ; si: al estado 9
	jp nz,cambia_de_estado		;4270   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
	ld a,(0c408h)		;4273   ; la puerta de la fase (0xC408)?
	or a			;4276
	ld a,00ah		;4277   ; si: al estado 0x0A
	jp nz,cambia_de_estado		;4279   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
	ld a,(0c409h)		;427c   ; el jefe rematado (0xC409)?
	and a			;427f
	ld a,008h		;4280   ; si: al estado 8
	jp nz,cambia_de_estado		;4282   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
	ld a,(0c413h)		;4285   ; la vida sigue?
	or a			;4288
	ret nz			;4289   ; si: sigue el juego
	jr al_estado_siguiente		;428a   ; no: al estado 6
a_la_pausa:
	call la_ventana_de_pause		;428c   ; la ventana de PAUSE...
	ld a,00bh		;428f   ; ... y al estado 0x0B
	jp cambia_de_estado		;4291   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
estado_6_simon_muere:
	ld hl,0c410h		;4294   ; le quedan vidas?
	ld a,(hl)			;4297
	or a			;4298
	jr z,sin_vidas		;4299
otra_vida:
	call 062d0h		;429b   ; si: la habitacion de nuevo...
	xor a			;429e   ; ... Simon de pie...
	ld (0c420h),a		;429f
	inc a			;42a2
	ld (0c40dh),a		;42a3   ; ... 0xC40D a 1...
	ld a,004h		;42a6   ; ... y al estado 4
	jp cambia_de_estado		;42a8   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
sin_vidas:
	ld a,08bh		;42ab   ; no: la musica 0x8B...
	call sonido		;42ad   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jr al_estado_siguiente		;42b0   ; ... y al estado 7
estado_7_game_over:
	djnz pinta_el_game_over		;42b2
	ld a,(0e600h)		;42b4   ; subestado 1: con un Game Master...
	or a			;42b7
	jr z,L_42BF		;42b8
	call f5_recien_pulsada		;42ba   ; ... y F5 recien pulsada...
	jr nz,continua		;42bd   ; ... se continua
L_42BF:
	ld a,(0c0a7h)		;42bf   ; mientras suena la musica (0xC0A7)...
	and a			;42c2
	ret nz			;42c3   ; ... nada
	ld hl,0c004h		;42c4   ; al acabar la espera...
	dec (hl)			;42c7
	ret nz			;42c8
	ld hl,0c002h		;42c9   ; ... fuera el bit 6 de 0xC002...
	ld a,(hl)			;42cc
	and 0bfh		;42cd
	ld (hl),a			;42cf
	jp al_estado_0		;42d0   ; ... y al estado 0
continua:
	ld a,003h		;42d3   ; tres vidas...
	ld (0c410h),a		;42d5   ; guarda las vidas
	xor a			;42d8   ; ... y el marcador a cero
	ld h,a			;42d9
	ld l,a			;42da
	ld (0c405h),hl		;42db   ; guarda el MARCADOR, tres bytes en BCD
	ld (0c407h),a		;42de
	jr otra_vida		;42e1   ; y otra vida
pinta_el_game_over:
	call pantalla_en_negro		;42e3   ; subestado 0: pantalla en negro...
	ld hl,04d3ah		;42e6   ; ... GAME OVER...
	call rotulo		;42e9   ; rotulo: pinta un rotulo ([x][y] y texto; 0xFE otra posicion, 0xFF acaba)
	ld a,(0e600h)		;42ec   ; ... y con un Game Master...
	or a			;42ef
	jr z,L_42F8		;42f0
	ld hl,04300h		;42f2   ; ... F5 CONTINUE
	call rotulo		;42f5   ; rotulo: pinta un rotulo ([x][y] y texto; 0xFE otra posicion, 0xFF acaba)
L_42F8:
	call pinta_el_marcador		;42f8   ; el marcador
	ld a,078h		;42fb   ; 0x78 cuadros
	jp espera_y_al_subestado_siguiente		;42fd

; ----------------------------------------------------------------------
; DATOS rotulo_4300: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "F{25} / {4F} / CONTINUE"; lo leen p00:42F5 (20
;   bytes)
;   0x4300..0x4314  (20 bytes)
DATA_rotulo_4300:
	defb 050h,068h,036h,025h,0feh,064h,068h,04fh,0feh,070h,068h,033h,03fh,03eh,044h,039h	; 4300  Ph6%.dhO.ph3?>D9
	defb 03eh,045h,035h,0ffh	; 4310

; ======================================================================
; CODIGO 0x4314..0x4369  (85 bytes)
; ======================================================================


f5_recien_pulsada:
	ld a,007h		;4314   ; la fila 7 del teclado...
	call 00141h		;4316   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4319   ; ... su bit 1, F5, a 1 si esta pulsada
	and 002h		;431a
	ld hl,0e614h		;431c   ; lo del cuadro anterior...
	ld c,(hl)			;431f
	ld (hl),a			;4320   ; ... y el de este
	xor c			;4321   ; NZ si se acaba de pulsar
	and (hl)			;4322
	ret			;4323
estado_8_bloque_acabado:
	djnz $+76		;4324
	ld hl,0d002h		;4326   ; subestado 1: el bloque de tres fases siguiente
	inc (hl)			;4329
	ld a,006h		;432a   ; tras el sexto...
	sub (hl)			;432c
	jr nz,bloque_siguiente		;432d
	ld (hl),a			;432f   ; ... el primero...
	ld a,0ffh		;4330   ; ... la fase 0xFF (la siguiente sera la 0)...
	ld (0d000h),a		;4332   ; guarda la FASE (0 el patio, 1-18)
	ld a,020h		;4335   ; ... la vida llena...
	ld (0c415h),a		;4337   ; guarda la vida de Simon
	ld hl,0cf34h		;433a   ; ... 0xCF34 uno mas...
	inc (hl)			;433d
	ld a,(hl)			;433e
	cp 002h		;433f   ; ... y con la segunda, al estado 0
	jp z,al_estado_0		;4341
bloque_siguiente:
	call 062d5h		;4344   ; lo de 0x62D5
fase_siguiente:
	ld hl,0c410h		;4347   ; una vida mas (el estado 4 la quita)
	ld a,(hl)			;434a
	add a,001h		;434b
	daa			;434d
	ld (hl),a			;434e
	ld hl,0c411h		;434f   ; la fase del marcador, mas uno
	ld a,(hl)			;4352
	add a,001h		;4353
	daa			;4355
	ld (hl),a			;4356
	ld hl,0d000h		;4357   ; la fase siguiente...
	inc (hl)			;435a
	inc hl			;435b   ; ... desde la habitacion 0
	xor a			;435c
	ld (hl),a			;435d
	ld (0c409h),a		;435e   ; fuera las banderas del jefe y de la puerta
	ld (0c408h),a		;4361
	ld a,004h		;4364   ; al estado 4
	jp cambia_de_estado		;4366   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_4369: instrucciones que no alcanza nadie:
;   desensamblan enteras hasta un ret justo en el borde y su direccion no
;   aparece como palabra en el cartucho; lo leen nadie (7 bytes)
;   0x4369..0x4370  (7 bytes)
DATA_codigo_sin_llamar_4369:
	defb 021h,000h,000h,022h,000h,0c0h,0c9h	; 4369

; ======================================================================
; CODIGO 0x4370..0x44b0  (320 bytes)
; ======================================================================


bloque_acabado_empieza:
	call pantalla_en_negro		;4370   ; subestado 0: pantalla en negro
	xor a			;4373
	jp espera_y_al_subestado_siguiente		;4374
estado_9_cambio_de_habitacion:
	call a_que_habitacion_se_sale		;4377   ; a cual se va
	ld a,006h		;437a   ; ninguna: al estado 6
	jp nc,cambia_de_estado		;437c   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
	call 062f5h		;437f   ; si no, se monta...
	ld a,005h		;4382   ; ... y al estado 5
	jp cambia_de_estado		;4384   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
estado_10_fase_acabada:
	ld hl,0c701h		;4387   ; fuera la llave blanca (bit 0)...
	ld a,(hl)			;438a
	and 0feh		;438b
	ld (hl),a			;438d
	jp fase_siguiente		;438e   ; ... y a la fase siguiente
teclas_del_titulo:
	call el_mando_y_el_teclado		;4391   ; los mandos...
	ld hl,0c401h		;4394   ; ... los de 0xC401
	call recien_pulsado		;4397
	or a			;439a
	ret z			;439b   ; ninguno: nada
	ld hl,0c004h		;439c   ; sin espera
	ld (hl),000h		;439f
	ld hl,0c000h		;43a1   ; apunta a el ESTADO del juego
	ld b,(hl)			;43a4
	djnz al_titulo		;43a5   ; en el estado 1:
	and 030h		;43a7   ; los bits 4 o 5?
	ret z			;43a9
	ld a,040h		;43aa   ; 0xC002 = 0x40 (el bit 6)
	ld (0c002h),a		;43ac   ; guarda las banderas de la partida (bit 7: de verdad, no la demostracion)
	ld a,(0e600h)		;43af   ; con un Game Master...
	or a			;43b2
	jr nz,al_menu_del_game_master		;43b3   ; ... a su menu
	ld (hl),003h		;43b5   ; si no, al estado 3
	inc hl			;43b7
	ld (hl),b			;43b8
	ret			;43b9
al_titulo:
	ld (hl),001h		;43ba   ; en el 0 y el 2: al estado 1...
	ld a,000h		;43bc   ; ... callado...
	call sonido		;43be   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	jp pinta_el_titulo		;43c1   ; ... y el titulo
al_menu_del_game_master:
	xor a			;43c4   ; lo que da el Game Master, de partida: nada...
	ld (0e604h),a		;43c5
	ld a,001h		;43c8   ; ... la fase 1...
	ld (0e605h),a		;43ca   ; guarda la fase del marcador que da el Game Master
	ld (0e606h),a		;43cd   ; guarda la fase que da el Game Master
	ld a,003h		;43d0   ; ... tres vidas...
	ld (0e607h),a		;43d2   ; guarda las vidas que da el Game Master
	ld a,00dh		;43d5   ; ... y al estado 0x0D
	jp cambia_de_estado		;43d7   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
estado_11_la_pausa:
	ld a,(0c00bh)		;43da   ; la tecla de la pausa otra vez (bit 0 de 0xC00B)?
	rra			;43dd
	ret nc			;43de
	xor a			;43df   ; si: fuera la pausa...
	ld (0c40ah),a		;43e0
	call quita_la_ventana_de_pause		;43e3   ; ... la ventana...
	ld a,0feh		;43e6   ; ... el efecto 0xFE...
	call sonido		;43e8   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
	ld a,005h		;43eb   ; ... y al estado 5
	jp cambia_de_estado		;43ed   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
estado_12_la_tienda:
	djnz tienda_se_cierra		;43f0
	call 094bah		;43f2   ; subestado 1: la tienda, cada cuadro
	ret nz			;43f5   ; abierta: sigue
	ld a,00fh		;43f6   ; cerrada: 0x0F cuadros
	jp espera_y_al_subestado_siguiente		;43f8
tienda_se_cierra:
	djnz tienda_se_abre		;43fb
	ld hl,0c004h		;43fd   ; subestado 2: al acabar la espera...
	dec (hl)			;4400
	ret nz			;4401
	call 09507h		;4402   ; ... se quita la ventana...
	ld a,005h		;4405   ; ... y al estado 5
	jp cambia_de_estado		;4407   ; cambia_de_estado: estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004
tienda_se_abre:
	xor a			;440a   ; subestado 0: se gasta 0xC40C...
	ld (0c40ch),a		;440b
	call 09387h		;440e   ; ... y se abre la tienda
	jp al_subestado_siguiente		;4411
estado_13_el_game_master:
	djnz game_master_elige		;4414
	ld a,(0c006h)		;4416   ; subestado 1: las teclas...
	and 033h		;4419
	ret z			;441b
	and 003h		;441c   ; las de los bits 0 y 1: a 0x5E7D
	jp nz,mueve_el_cursor		;441e
	ld a,(0e60bh)		;4421   ; la opcion 0...
	or a			;4424
	jp nz,otra_opcion		;4425
	call borra_la_ventana_del_game_master		;4428   ; ... empieza la partida...
	ld hl,00003h		;442b   ; ... estado 3, subestado 0
	ld (0c000h),hl		;442e   ; guarda el estado (0xC000) y el subestado (0xC001) de un tiron
	ret			;4431
otra_opcion:
	dec a			;4432   ; la 1...
	jr z,opcion_1		;4433
	ld hl,0b8b8h		;4435   ; ... o la 2
	ld (0e602h),hl		;4438
	call opcion_2_las_vidas		;443b
	jr L_4449		;443e   ; y al subestado 2
opcion_1:
	ld hl,0b0b8h		;4440
	ld (0e602h),hl		;4443
	call opcion_1_la_fase		;4446   ; la opcion 1
L_4449:
	jp al_subestado_siguiente		;4449
game_master_elige:
	djnz empieza_el_game_master		;444c
	call return_recien_pulsada		;444e   ; subestado 2
	jr nz,L_4456		;4451
	jp una_cifra		;4453
L_4456:
	ld a,(0e60bh)		;4456   ; apunta la opcion en 0xE604
	ld b,a			;4459
	ld hl,0e604h		;445a
	or (hl)			;445d
	ld (hl),a			;445e
	ld a,(0e615h)		;445f   ; con 0xE615...
	or a			;4462
	jr z,vuelve_al_subestado_0		;4463
	ld a,(0e60eh)		;4465
	ld d,a			;4468
	ld a,(0e60fh)		;4469
	bit 0,b		;446c   ; ... la opcion 1 da la fase...
	jr z,game_master_da_vidas		;446e
	ld (0e605h),a		;4470   ; ... del marcador...
	ld a,d			;4473
	ld (0e606h),a		;4474   ; ... y de verdad
vuelve_al_subestado_0:
	xor a			;4477   ; subestado 0
	ld (0c001h),a		;4478   ; guarda el subestado
	ret			;447b
game_master_da_vidas:
	ld (0e607h),a		;447c   ; la opcion 2 da las vidas
	jr vuelve_al_subestado_0		;447f
empieza_el_game_master:
	call la_ventana_del_game_master		;4481   ; subestado 0: su pantalla...
	xor a			;4484   ; ... y 0xE608-0xE616 a cero
	ld hl,0e608h		;4485
	ld de,0e609h		;4488
	ld bc,0000eh		;448b
	ld (hl),000h		;448e
	ldir		;4490
	jp al_subestado_siguiente		;4492
la_ventana_de_pause:
	ld hl,06854h		;4495   ; guarda el fondo: de (0x68, 0x54)...
	ld bc,03010h		;4498   ; ... 0x30 x 0x10...
	ld de,0d070h		;449b   ; ... a (0xD0, 0x70) de la pagina 1
	ld a,004h		;449e
	push hl			;44a0
	push bc			;44a1
	call copia_rectangulo		;44a2   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	pop bc			;44a5
	pop hl			;44a6
	call recuadro		;44a7   ; el recuadro
	ld hl,044b0h		;44aa   ; y PAUSE
	jp rotulo		;44ad   ; rotulo: pinta un rotulo ([x][y] y texto; 0xFE otra posicion, 0xFF acaba)

; ----------------------------------------------------------------------
; DATOS rotulo_44B0: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "PAUSE"; lo leen p00:44AD (8 bytes)
;   0x44b0..0x44b8  (8 bytes)
DATA_rotulo_44B0:
	defb 06ch,058h,040h,031h,045h,043h,035h,0ffh	; 44b0  lX@1EC5.

; ======================================================================
; CODIGO 0x44b8..0x44e9  (49 bytes)
; ======================================================================


quita_la_ventana_de_pause:
	ld de,06854h		;44b8   ; el fondo de vuelta, de la pagina 1 a la 0
	ld bc,03010h		;44bb
	ld hl,0d070h		;44be
	ld a,001h		;44c1
	jp copia_rectangulo		;44c3   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
partida_a_cero:
	ld hl,0c405h		;44c6   ; del MARCADOR en adelante...
	ld bc,01bfbh		;44c9   ; ... 0x1BFB bytes a cero
	ld d,h			;44cc
	ld e,l			;44cd
	inc e			;44ce
	ld (hl),000h		;44cf
	ldir		;44d1
	ld hl,044e9h		;44d3   ; las vidas, la fase del marcador y 0xC412, de 0x44E9
	ld de,0c410h		;44d6   ; apunta a las vidas
	ld bc,00003h		;44d9
	ldir		;44dc
	ld a,020h		;44de   ; la vida llena...
	ld (0c415h),a		;44e0   ; guarda la vida de Simon
	ld a,080h		;44e3   ; ... y la barra del enemigo
	ld (0c418h),a		;44e5   ; guarda la vida del enemigo (barra ENEMY)
	ret			;44e8

; ----------------------------------------------------------------------
; DATOS valores_iniciales_de_la_partida: los tres bytes que p00:44D3 copia a
;   0xC410-0xC412 al empezar la partida: 3 (las vidas que marca P-), 0 (la
;   fase en BCD) y 1
;   0x44e9..0x44ec  (3 bytes)
DATA_valores_iniciales_de_la_partida:
	defb 003h,000h,001h	; 44e9

; ======================================================================
; CODIGO 0x44ec..0x4618  (300 bytes)
; ======================================================================


L_44EC:
	ld c,000h		;44ec

; ----------------------------------------------------------------------
; SUMA AL MARCADOR C D E, en BCD (decenas de millar, centenas, unidades), solo en una partida de verdad (bit 7 de 0xC002); se planta en 999999.
; ----------------------------------------------------------------------
L_44EE:
	ld a,(0c002h)		;44ee   ; en la demostracion...
	add a,a			;44f1   ; ... (bit 7 a cero)...
	ret p			;44f2   ; ... no se cuentan puntos
	ld hl,0c405h		;44f3   ; el marcador, tres bytes en BCD
	ld a,(hl)			;44f6
	add a,e			;44f7   ; las unidades y decenas
	daa			;44f8   ; 
	ld (hl),a			;44f9   ; 
	inc l			;44fa
	ld a,(hl)			;44fb   ; centenas y millares, con el acarreo
	adc a,d			;44fc
	daa			;44fd   ; 
	ld (hl),a			;44fe   ; 
	inc hl			;44ff
	ld a,(hl)			;4500   ; decenas y centenas de millar
	adc a,c			;4501
	daa			;4502   ; 
	ld (hl),a			;4503   ; 
	jr nc,pinta_los_puntos		;4504   ; sin desbordar: listo
	ld bc,09999h		;4506   ; se paso de 999999: se queda ahi
	ld (0c402h),bc		;4509
	ld (0c403h),bc		;450d
	jr pinta_los_puntos		;4511

; ----------------------------------------------------------------------
; EL MARCADOR ENTERO (la franja de arriba, y de 0 a 0x1F): los rotulos de 0x4C00, la fase, los corazones, las vidas, las dos barras de vida, los tres recuadros (el arma, las llaves y lo que lleva) y lo de dentro, y los puntos.
; ----------------------------------------------------------------------
pinta_el_marcador:
	ld hl,04c00h		;4513   ; el marcador de arriba: SCORE-, PLAYER, ENEMY, corazones, P- y STAGE-
	call rotulo		;4516   ; rotulo: pinta un rotulo ([x][y] y texto; 0xFE otra posicion, 0xFF acaba)
	call pinta_la_fase		;4519   ; la fase
	call pinta_los_corazones		;451c   ; los corazones
	call pinta_las_vidas		;451f   ; las vidas
	call pinta_las_dos_barras		;4522   ; las dos barras de vida
	call pinta_los_recuadros		;4525   ; los tres recuadros
	call 08e9ah		;4528   ; el arma
	call 08eb4h		;452b   ; la llave
	call 08ee6h		;452e   ; lo que lleva
pinta_los_puntos:
	ld hl,0c407h		;4531   ; los puntos, tres bytes BCD desde el alto...
	ld de,03800h		;4534   ; ... en (0x38, 0)
	ld b,003h		;4537
	jr pinta_en_bcd		;4539
pinta_la_fase:
	ld de,09c00h		;453b   ; en (0x9C, 0)...
	ld hl,0c411h		;453e   ; ... un byte BCD
	ld b,001h		;4541
	jr pinta_en_bcd		;4543
pinta_los_recuadros:
	ld hl,07f0bh		;4545   ; el del arma, en (0x7F, 0x0B)...
	ld de,01212h		;4548   ; ... de 0x12 x 0x12...
	ld c,008h		;454b   ; ... del color 8
	call un_marco		;454d
	ld hl,0930bh		;4550   ; el de las llaves, en (0x93, 0x0B), 0x22 x 0x12...
	ld de,02212h		;4553
	ld c,00eh		;4556   ; ... del color 0x0E
	call un_marco		;4558
	ld hl,0b70bh		;455b   ; el de lo que lleva, en (0xB7, 0x0B), 0x42 x 0x12...
	ld de,04212h		;455e
	ld c,00eh		;4561   ; ... del color 0x0E
	jp un_marco		;4563
pinta_los_corazones:
	ld hl,0c417h		;4566   ; apunta a los corazones, en BCD
	ld de,0c000h		;4569   ; en (0xC0, 0)
	jr L_4574		;456c
pinta_las_vidas:
	ld hl,0c410h		;456e   ; apunta a las vidas
	ld de,0e400h		;4571   ; en (0xE4, 0)
L_4574:
	ld b,001h		;4574   ; un byte BCD
	jr pinta_en_bcd		;4576

; ----------------------------------------------------------------------
; PINTA B BYTES BCD, desde HL hacia atras, dos cifras cada uno, en (D, E): cada cifra es la letra 0x20 + cifra, de 8 en 8 puntos.
; ----------------------------------------------------------------------
pinta_en_bcd:
	ld a,(hl)			;4578   ; la cifra alta...
	rra			;4579
	rra			;457a
	rra			;457b
	rra			;457c
	call pinta_una_cifra		;457d
	ld a,(hl)			;4580   ; ... y la baja
	call pinta_una_cifra		;4581
	dec hl			;4584   ; el byte anterior
	djnz pinta_en_bcd		;4585
	ret			;4587
pinta_una_cifra:
	and 00fh		;4588   ; la cifra...
	add a,020h		;458a   ; ... es la letra 0x20 + cifra
	call pinta_una_letra		;458c
	ld a,d			;458f   ; la x, 8 mas
	add a,008h		;4590
	ld d,a			;4592
	ret			;4593
mas_corazones:
	ld hl,0c417h		;4594   ; B corazones mas...
	ld a,(hl)			;4597
	add a,b			;4598
	daa			;4599
	jr nc,L_459E		;459a   ; ... hasta 99
	ld a,099h		;459c
L_459E:
	jr corazones_y_repinta		;459e
menos_corazones:
	ld hl,0c417h		;45a0   ; B corazones menos...
	ld a,(hl)			;45a3
	cp b			;45a4   ; ... si hay...
	jr c,sin_corazones		;45a5
	sub b			;45a7
	daa			;45a8
corazones_y_repinta:
	ld (hl),a			;45a9   ; se guardan y se pintan
	jp pinta_los_corazones		;45aa
sin_corazones:
	xor a			;45ad   ; si no, cero
	jr corazones_y_repinta		;45ae
pinta_las_dos_barras:
	call pinta_la_barra_de_simon		;45b0   ; la de Simon...
pinta_la_barra_del_enemigo:
	call borra_la_barra_del_enemigo		;45b3   ; la del enemigo: se borra...
	jp la_vida_del_enemigo		;45b6   ; ... y se pinta
pinta_la_barra_de_simon:
	call borra_la_barra_de_simon		;45b9   ; se borra...
	jp la_vida_de_simon		;45bc   ; ... y se pinta
borra_la_barra_del_enemigo:
	ld hl,03b16h		;45bf   ; desde (0x3B, 0x16)...
	ld bc,04206h		;45c2   ; ... 0x42 x 6
L_45C5:
	jp recuadro		;45c5
borra_la_barra_de_simon:
	ld hl,03b0dh		;45c8   ; desde (0x3B, 0x0D), 0x42 x 6
	ld bc,04206h		;45cb
	jp L_45C5		;45ce
la_vida_de_simon:
	ld hl,0c415h		;45d1   ; apunta a la vida de Simon
	ld a,(hl)			;45d4
	ld hl,03c0eh		;45d5   ; desde (0x3C, 0x0E)...
	add a,a			;45d8   ; ... dos puntos por punto de vida
	or a			;45d9
	ret z			;45da   ; ninguno: nada
	ld b,a			;45db
	ld c,004h		;45dc   ; ... 4 de alto...
	ld d,000h		;45de
	ld a,011h		;45e0   ; ... del color 1
	jp rellena_rectangulo		;45e2   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
la_vida_del_enemigo:
	ld hl,0c418h		;45e5   ; apunta a la vida del enemigo (barra ENEMY)
	ld a,(hl)			;45e8
	ld hl,03c17h		;45e9   ; desde (0x3C, 0x17)...
	ld b,a			;45ec
	and 003h		;45ed   ; ... lo que sobra de cuatro...
	ld c,a			;45ef
	ld a,b			;45f0
	and 0fch		;45f1   ; ... y medio punto por cada punto de vida
	rrca			;45f3
	or a			;45f4
	jr nz,pinta_la_barra		;45f5   ; algo?
	or c			;45f7   ; solo lo que sobra...
	ret z			;45f8
	ld a,002h		;45f9   ; ... se pinta como 2
pinta_la_barra:
	ld b,a			;45fb   ; B de ancho...
	ld c,004h		;45fc   ; ... 4 de alto...
	ld d,000h		;45fe
	ld a,088h		;4600   ; ... del color 8
	jp rellena_rectangulo		;4602   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
mas_vida:
	ld hl,0c415h		;4605   ; B de vida mas...
	ld a,(hl)			;4608
	add a,b			;4609
	cp 021h		;460a   ; ... hasta 0x20
	jr c,vida_y_repinta		;460c
	ld a,020h		;460e   ; (B, lo que de verdad sube)
	sub (hl)			;4610
	ld b,a			;4611
	ld a,020h		;4612
vida_y_repinta:
	ld (hl),a			;4614   ; se guarda y se pinta
	jp pinta_la_barra_de_simon		;4615

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_4618: instrucciones a las que no llega nadie (`ld
;   hl,0xC418 / ld a,(hl) / add a,b / cp 0x81 ... jp 0x45B3`); la palabra
;   0x4618 solo aparece en p03:A31E, y ahi es parte de `bit 0,(ix+0x18)` (DD
;   CB 18 46)
;   0x4618..0x462b  (19 bytes)
DATA_codigo_sin_llamar_4618:
	defb 021h,018h,0c4h,07eh,080h,0feh,081h,038h,006h,03eh,080h,096h,047h,03eh,080h,077h	; 4618  !..~...8.>..G>.w
	defb 0c3h,0b3h,045h	; 4628

; ======================================================================
; CODIGO 0x462b..0x464d  (34 bytes)
; ======================================================================


menos_vida:
	ld hl,0c415h		;462b   ; B de vida menos...
	ld a,(hl)			;462e
	cp b			;462f   ; ... no mas de la que hay
	jr nc,quita_b_de_vida		;4630
	ld b,a			;4632
quita_b_de_vida:
	ld a,b			;4633   ; nada que quitar: nada
	or a			;4634
	ret z			;4635
	ld a,(hl)			;4636   ; la vida menos B...
	sub b			;4637
	ld (hl),a			;4638
	jp pinta_la_barra_de_simon		;4639   ; ... y se pinta
menos_vida_del_enemigo:
	ld hl,0c418h		;463c   ; B de vida menos al enemigo...
	ld a,(hl)			;463f
	cp b			;4640   ; ... no mas de la que hay
	jr nc,quita_b_al_enemigo		;4641
	ld b,a			;4643
quita_b_al_enemigo:
	ld a,b			;4644   ; nada que quitar: nada
	or a			;4645
	ret z			;4646
	ld a,(hl)			;4647   ; la vida menos B...
	sub b			;4648
	ld (hl),a			;4649
	jp pinta_la_barra_del_enemigo		;464a   ; ... y se pinta

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_464D: instrucciones que no alcanza nadie:
;   desensamblan enteras hasta un jr justo en el borde y su direccion no
;   aparece como palabra en el cartucho; lo leen nadie (4 bytes)
;   0x464d..0x4651  (4 bytes)
DATA_codigo_sin_llamar_464D:
	defb 006h,001h,018h,0dah	; 464d

; ======================================================================
; CODIGO 0x4651..0x4656  (5 bytes)
; ======================================================================


un_punto_de_vida_mas:
	ld b,001h		;4651
	jp mas_vida		;4653

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_4656: instrucciones que no alcanza nadie:
;   desensamblan enteras hasta un jr justo en el borde y su direccion no
;   aparece como palabra en el cartucho; lo leen nadie (4 bytes)
;   0x4656..0x465a  (4 bytes)
DATA_codigo_sin_llamar_4656:
	defb 006h,001h,018h,0e2h	; 4656

; ======================================================================
; CODIGO 0x465a..0x46a1  (71 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LEE DE LA VRAM: BC bytes de HL a DE (la RAM), por el puerto de lectura del VDP.
; ----------------------------------------------------------------------
lee_de_la_vram:
	call vram_para_leer		;465a   ; vram_para_leer: prepara el V9938 para leer de la direccion HL
	call cuenta_para_otir		;465d   ; B y A, las vueltas
	ex af,af'			;4660
	ld a,(00006h)		;4661   ; el puerto de datos del VDP (0x0006)
	ld c,a			;4664
	ex af,af'			;4665
lee_bloques:
	inir		;4666   ; B bytes...
	dec a			;4668   ; ... A veces
	jr nz,lee_bloques		;4669
	ex de,hl			;466b
	ret			;466c

; ----------------------------------------------------------------------
; DE BC A DOS CONTADORES para OTIR/INIR: B = C (0 son 256) y A = las vueltas de 256 (B + 1 si C no es cero).
; ----------------------------------------------------------------------
cuenta_para_otir:
	ex de,hl			;466d   ; (y HL y DE cambiados)
	ld a,c			;466e
	or a			;466f
	ld a,b			;4670
	ld b,c			;4671   ; B = los bytes de la primera vuelta
	ret z			;4672   ; sin resto: B vueltas
	inc a			;4673   ; con resto: una mas
	ret			;4674
copia_a_la_vram:
	ex de,hl			;4675   ; COPIA A LA VRAM: BC bytes de HL a DE
	call vram_para_escribir		;4676   ; vram_para_escribir: prepara el V9938 para escribir en la direccion HL
	call cuenta_para_otir		;4679
	ex af,af'			;467c
	ld a,(00007h)		;467d   ; el puerto de datos (0x0007)
	ld c,a			;4680
	ex af,af'			;4681
escribe_bloques:
	otir		;4682   ; B bytes...
	dec a			;4684   ; ... A veces
	jr nz,escribe_bloques		;4685
	ret			;4687

; ----------------------------------------------------------------------
; RELLENA LA VRAM: BC bytes desde HL con el byte A.
; ----------------------------------------------------------------------
rellena_la_vram:
	push de			;4688
	push af			;4689
	call vram_para_escribir		;468a   ; vram_para_escribir: prepara el V9938 para escribir en la direccion HL
	ld d,c			;468d   ; D = los de la primera vuelta
	ld a,c			;468e
	or a			;468f
	jr z,L_4693		;4690   ; sin resto...
	inc b			;4692   ; ... con resto, una vuelta mas
L_4693:
	ld a,(00007h)		;4693   ; el puerto de datos
	ld c,a			;4696
	pop af			;4697
rellena_bloques:
	out (c),a		;4698   ; el byte...
	dec d			;469a   ; ... D veces...
	jr nz,rellena_bloques		;469b
	djnz rellena_bloques		;469d   ; ... B vueltas (D a 0 da 256)
	pop de			;469f
	ret			;46a0

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_46A1: instrucciones que no alcanza nadie:
;   desensamblan enteras hasta un ret justo en el borde y su direccion no
;   aparece como palabra en el cartucho; lo leen nadie (14 bytes)
;   0x46a1..0x46af  (14 bytes)
DATA_codigo_sin_llamar_46A1:
	defb 0c5h,0f5h,0cdh,0afh,046h,03ah,007h,000h,04fh,0f1h,0edh,079h,0c1h,0c9h	; 46a1  ....F:..O..y..

; ======================================================================
; CODIGO 0x46af..0x4b00  (1105 bytes)
; ======================================================================


vram_para_escribir:
	push bc			;46af   ; VRAM PARA ESCRIBIR: el puerto de registros (0x0007 + 1)
	ld a,(00007h)		;46b0
	inc a			;46b3
	ld c,a			;46b4
	ld a,h			;46b5   ; los bits 14-16 de la direccion...
	rlca			;46b6
	rlca			;46b7
	and 003h		;46b8
	di			;46ba
	out (c),a		;46bb   ; ... al registro 14
	ld a,08eh		;46bd
	out (c),a		;46bf
	ld a,l			;46c1   ; los ocho de abajo...
	out (c),a		;46c2
	ld a,h			;46c4   ; ... y los seis de arriba, con el bit 6: escribir
	and 03fh		;46c5
	or 040h		;46c7
	out (c),a		;46c9
	pop bc			;46cb
	ei			;46cc
	ret			;46cd
vram_para_leer:
	push bc			;46ce   ; VRAM PARA LEER: lo mismo...
	ld a,(00007h)		;46cf
	inc a			;46d2
	ld c,a			;46d3
	ld a,h			;46d4
	rlca			;46d5
	rlca			;46d6
	and 003h		;46d7
	di			;46d9
	out (c),a		;46da
	ld a,08eh		;46dc
	out (c),a		;46de
	ld a,l			;46e0
	out (c),a		;46e1
	ld a,h			;46e3   ; ... sin el bit 6: leer
	and 03fh		;46e4
	out (c),a		;46e6
	pop bc			;46e8
	ei			;46e9
	ret			;46ea
rle_con_destino:
	ex de,hl			;46eb   ; RLE CON EL DESTINO DELANTE: los dos primeros bytes...
	ld e,(hl)			;46ec
	inc hl			;46ed
	ld d,(hl)			;46ee
	inc hl			;46ef
	ex de,hl			;46f0   ; ... son el destino
rle_a_la_vram:
	call vram_para_escribir		;46f1   ; RLE A LA VRAM de HL desde DE
	ld a,(00007h)		;46f4
	ld c,a			;46f7
rle_mando:
	ld a,(de)			;46f8   ; el mando...
	and a			;46f9
	ret z			;46fa   ; ... 0: acaba
	inc de			;46fb
	ld b,a			;46fc   ; bit 7 puesto?
	and 07fh		;46fd
	cp b			;46ff
	jr z,rle_repite		;4700   ; no: se repite el siguiente
	and a			;4702   ; 0x80: otro destino
	jr z,rle_con_destino		;4703
	ex de,hl			;4705   ; si: los siete de abajo...
	ld b,a			;4706
	otir		;4707   ; ... tal cual
	ex de,hl			;4709
	jr rle_mando		;470a
rle_repite:
	ld a,(de)			;470c   ; el byte...
	inc de			;470d
rle_otra_vez:
	out (c),a		;470e   ; ... B veces
	djnz rle_otra_vez		;4710
	jr rle_mando		;4712
guion_de_carga:
	ld a,(hl)			;4714   ; EL GUION DE CARGA: el mando...
	inc hl			;4715
	inc a			;4716   ; ... 0xFF acaba
	ret z			;4717
	dec a			;4718
	or a			;4719   ; 0: un rle aparte
	jr z,guion_rle		;471a
	dec a			;471c   ; 1: dar la vuelta a dibujos
	jr z,guion_voltea		;471d
	call copia_del_guion		;471f   ; lo demas: una copia en crudo
	jr guion_de_carga		;4722
guion_rle:
	call rle_del_guion		;4724
	jr guion_de_carga		;4727
guion_voltea:
	call voltea_dibujos		;4729   ; voltea_dibujos: da la vuelta a dibujos que ya estan en la VRAM
	jr guion_de_carga		;472c
rle_del_guion:
	ld e,(hl)			;472e   ; DE = la fuente...
	inc hl			;472f
	ld d,(hl)			;4730
	inc hl			;4731
	ld a,(hl)			;4732   ; ... HL = el destino...
	inc hl			;4733
	ld b,(hl)			;4734
	inc hl			;4735
	push hl			;4736
	ld l,a			;4737
	ld h,b			;4738
	call rle_a_la_vram		;4739   ; ... y se descomprime
	pop hl			;473c
	ret			;473d
voltea_dibujos:
	ld e,(hl)			;473e   ; VOLTEA DIBUJOS: DE = donde estan...
	inc hl			;473f
	ld d,(hl)			;4740
	inc hl			;4741
	ld a,(hl)			;4742   ; ... A = cuantos...
	inc hl			;4743
	push hl			;4744
	ld l,a			;4745   ; ... de 32 bytes: BC = A * 32
	ld h,000h		;4746
	add hl,hl			;4748
	add hl,hl			;4749
	add hl,hl			;474a
	add hl,hl			;474b
	add hl,hl			;474c
	ld c,l			;474d
	ld b,h			;474e
	ex de,hl			;474f
	push bc			;4750
	push af			;4751
	ld de,0e800h		;4752   ; a 0xE800
	call lee_de_la_vram		;4755
	pop af			;4758
	call voltea_patrones		;4759   ; volteados a 0xEC00
	pop bc			;475c
	pop hl			;475d
	ld e,(hl)			;475e   ; y al destino, DE
	inc hl			;475f
	ld d,(hl)			;4760
	inc hl			;4761
	push hl			;4762
	ld hl,0ec00h		;4763
	call copia_a_la_vram		;4766   ; copia_a_la_vram: BC bytes de HL a la VRAM de DE
	pop hl			;4769
	ret			;476a
copia_del_guion:
	ld e,(hl)			;476b   ; DE = la fuente...
	inc hl			;476c
	ld d,(hl)			;476d
	inc hl			;476e
	ld c,(hl)			;476f   ; ... BC = cuantos...
	inc hl			;4770
	ld b,(hl)			;4771
	inc hl			;4772
	ld a,(hl)			;4773   ; ... HL = el destino...
	inc hl			;4774
	push hl			;4775
	ld h,(hl)			;4776
	ld l,a			;4777
	ex de,hl			;4778
	call copia_a_la_vram		;4779   ; ... en crudo
	pop hl			;477c
	inc hl			;477d
	ret			;477e

; ----------------------------------------------------------------------
; DA LA VUELTA A A PATRONES DE SPRITE de 16 x 16 (de 0xE800 a 0xEC00): cada byte con los bits al reves y las dos mitades de 16 bytes cambiadas.
; ----------------------------------------------------------------------
voltea_patrones:
	ld hl,0e800h		;477f   ; de 0xE800...
	ld de,0ec10h		;4782   ; ... a la mitad derecha de 0xEC00
	ld c,a			;4785
voltea_un_patron:
	call voltea_16_bytes		;4786   ; la mitad izquierda, a la derecha
	ld a,0e0h		;4789   ; 0x20 bytes atras...
	add a,e			;478b
	ld e,a			;478c
	jr c,L_4790		;478d
	dec d			;478f
L_4790:
	call voltea_16_bytes		;4790   ; ... la derecha, a la izquierda
	ld a,020h		;4793   ; el patron siguiente
	call de_mas_a		;4795   ; de_mas_a: DE += A
	dec c			;4798
	jp nz,voltea_un_patron		;4799
	ret			;479c
voltea_16_bytes:
	ld b,010h		;479d   ; dieciseis
L_479F:
	ld a,(hl)			;479f
	inc hl			;47a0
	exx			;47a1
	ld c,a			;47a2
	ld a,001h		;47a3   ; A = 1: la marca
bits_al_reves:
	rr c		;47a5   ; un bit de C...
	rla			;47a7   ; ... entra por la derecha de A...
	jp nc,bits_al_reves		;47a8   ; ... hasta que sale la marca
	exx			;47ab
	ld (de),a			;47ac
	inc de			;47ad
	djnz L_479F		;47ae
	ret			;47b0
pantalla_en_negro_entera:
	call esconde_los_sprites		;47b1   ; sin sprites y todas las lineas
	ld bc,00000h		;47b4
	jr borra_con_la_pantalla_apagada		;47b7
pantalla_en_negro:
	call esconde_los_sprites		;47b9   ; sin sprites...
	ld bc,000d4h		;47bc   ; ... 0xD4 lineas
borra_con_la_pantalla_apagada:
	push bc			;47bf
	call apaga_la_pantalla		;47c0   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	pop bc			;47c3
	call borra_c_lineas		;47c4   ; se borran
enciende_la_pantalla:
	ld a,(0f3e0h)		;47c7   ; ENCIENDE LA PANTALLA: el bit 6 del registro 1
	or 040h		;47ca
	ld b,a			;47cc
	ld c,001h		;47cd
	call 00047h		;47cf   ; BIOS WRTVDP - Writes data in the VDP-register
	jr enciende_los_sprites		;47d2
apaga_la_pantalla:
	ld a,(0f3e0h)		;47d4   ; APAGA LA PANTALLA
	and 0bfh		;47d7
	ld b,a			;47d9
	ld c,001h		;47da
	call 00047h		;47dc   ; BIOS WRTVDP - Writes data in the VDP-register
	jr apaga_los_sprites		;47df
borra_c_lineas:
	ld hl,00000h		;47e1   ; desde (0, 0), C lineas enteras del color 0
	xor a			;47e4
	ld d,a			;47e5
	call rellena_rectangulo		;47e6   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	ld b,000h		;47e9   ; y el desplazamiento vertical (registro 23) a 0
	ld c,017h		;47eb
	jp 00047h		;47ed   ; BIOS WRTVDP - Writes data in the VDP-register
esconde_los_sprites:
	ld hl,0f600h		;47f0   ; la tabla de atributos de sprites (VRAM 0xF600)...
	ld a,0e0h		;47f3   ; ... 0x80 bytes con 0xE0
	ld bc,00080h		;47f5
	call rellena_la_vram		;47f8
	jp 063c5h		;47fb   ; y lo de 0x63C5
apaga_los_sprites:
	ld a,(0ffe7h)		;47fe   ; el registro 8...
	or 002h		;4801   ; ... con el bit 1 (SPD): sin sprites
	ld b,a			;4803
	ld c,008h		;4804
	jp 00047h		;4806   ; BIOS WRTVDP - Writes data in the VDP-register
enciende_los_sprites:
	ld a,(0ffe7h)		;4809   ; el registro 8 sin el bit 1
	and 0fdh		;480c
	ld b,a			;480e
	ld c,008h		;480f
	jp 00047h		;4811   ; BIOS WRTVDP - Writes data in the VDP-register

; ----------------------------------------------------------------------
; PON UN COLOR: el color A de la paleta pasa a valer D (rojo y azul) y E (verde). Se escribe en el V9938 por el registro 16 y el puerto 0x9A, y en la copia que se guarda en la VRAM, en 0xF680 (dos bytes por color).
; ----------------------------------------------------------------------
pon_un_color:
	push bc			;4814
	push hl			;4815
	ld b,a			;4816   ; B = el color
	ld a,(00007h)		;4817   ; el puerto de escritura del VDP (0x98 en un MSX2) sale de la BIOS
	inc a			;481a   ; +1: el de registros
	ld c,a			;481b
	di			;481c
	out (c),b		;481d   ; el numero de color
	ld a,090h		;481f   ; al registro 16 (0x80 + 16): el puntero de la paleta
	out (c),a		;4821
	inc c			;4823   ; +1: el puerto de la paleta
	out (c),d		;4824   ; rojo y azul
	push af			;4826   ; una pausa para el VDP
	pop af			;4827
	out (c),e		;4828   ; verde
	dec c			;482a   ; vuelve al puerto de registros
	ld hl,0f680h		;482b   ; la copia de la paleta en la VRAM, en 0xF680
	ld a,b			;482e
	add a,a			;482f   ; dos bytes por color
	add a,l			;4830
	ld l,a			;4831
	call vram_para_escribir		;4832   ; vram_para_escribir: a esa direccion de la copia
	dec c			;4835   ; el puerto de datos (0x98)
	out (c),d		;4836   ; rojo y azul, a la copia en VRAM
	out (c),e		;4838   ; verde, a la copia en VRAM
	pop hl			;483a
	pop bc			;483b
	ei			;483c
	ret			;483d
pon_paleta:
	ld a,(hl)			;483e   ; el color
	inc hl			;483f
	inc a			;4840   ; 0xFF acaba
	ret z			;4841
	dec a			;4842
	ld d,(hl)			;4843   ; rojo y azul
	inc hl			;4844
	ld e,(hl)			;4845   ; verde
	inc hl			;4846
	call pon_un_color		;4847   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
	jr pon_paleta		;484a   ; y el siguiente
espera_al_vdp:
	ld a,002h		;484c   ; el registro de estado 2
	call lee_estado_del_vdp		;484e   ; lee_estado_del_vdp: lee el registro de estado A del V9938
	rra			;4851   ; el bit 0 (CE): el VDP aun esta con la orden
	jr c,espera_al_vdp		;4852   ; pues a esperar
	ret			;4854
lee_estado_del_vdp:
	push bc			;4855
	push hl			;4856
	ld hl,(00006h)		;4857   ; los dos puertos de la BIOS, en H y L
	inc h			;485a   ; H = el de registros
	inc l			;485b   ; L = el de estado (lectura)
	ld c,h			;485c
	di			;485d
	out (c),a		;485e   ; el numero de registro de estado
	ld a,08fh		;4860   ; al registro 15
	out (c),a		;4862
	ld c,l			;4864
	in a,(c)		;4865   ; lee ese registro de estado
	push af			;4867
	xor a			;4868   ; y deja el 15 como estaba, en el 0
	ld c,h			;4869
	out (c),a		;486a
	ld a,08fh		;486c   ; (el que usa la BIOS)
	out (c),a		;486e
	pop af			;4870
	pop hl			;4871
	pop bc			;4872
	ei			;4873
	ret			;4874

; ----------------------------------------------------------------------
; UNA RAYA HORIZONTAL: orden LINE (0x70) del V9938 desde (H, L), de B - 1 puntos, del color C. 0x48A8 es la misma con ARG = 1: vertical.
; ----------------------------------------------------------------------
raya_horizontal:
	call espera_al_vdp		;4875   ; espera_al_vdp: espera a que el V9938 acabe la orden (bit 0 de S#2)
	push bc			;4878
	ld a,(00007h)		;4879   ; el puerto de registros
	inc a			;487c
	ld c,a			;487d
	ld a,024h		;487e   ; desde el registro 36 (DX)
	di			;4880
	out (c),a		;4881
	ld a,091h		;4883
	out (c),a		;4885   ; al 17, con autoincremento: se escriben seguidos
	inc c			;4887   ; +2: el puerto de registros indirectos (0x9B)
	inc c			;4888
	out (c),h		;4889   ; DX = H
	xor a			;488b
	out (c),a		;488c
	out (c),l		;488e   ; DY = L
	out (c),a		;4890
	pop hl			;4892   ; H = B, L = C
	dec h			;4893   ; NX = B - 1: el largo
	out (c),h		;4894
	xor a			;4896
	out (c),a		;4897
	xor a			;4899   ; NY = 0
	out (c),a		;489a
	out (c),a		;489c
	out (c),l		;489e   ; el color
	out (c),a		;48a0   ; ARG = 0: horizontal
	ld a,070h		;48a2   ; LINE
	out (c),a		;48a4   ; arranca la orden
	ei			;48a6
	ret			;48a7
raya_vertical:
	call espera_al_vdp		;48a8   ; espera_al_vdp: espera a que el V9938 acabe la orden (bit 0 de S#2)
	push bc			;48ab
	ld a,(00007h)		;48ac   ; el puerto de registros
	inc a			;48af
	ld c,a			;48b0
	ld a,024h		;48b1   ; desde el registro 36 (DX)
	di			;48b3
	out (c),a		;48b4
	ld a,091h		;48b6
	out (c),a		;48b8   ; al 17, con autoincremento: se escriben seguidos
	inc c			;48ba   ; +2: el puerto de registros indirectos (0x9B)
	inc c			;48bb
	out (c),h		;48bc   ; DX = H
	xor a			;48be
	out (c),a		;48bf
	out (c),l		;48c1   ; DY = L
	out (c),a		;48c3
	pop hl			;48c5   ; H = B, L = C
	dec h			;48c6   ; NX = B - 1: el largo
	out (c),h		;48c7
	xor a			;48c9
	out (c),a		;48ca
	xor a			;48cc
	out (c),a		;48cd
	out (c),a		;48cf
	out (c),l		;48d1   ; el color
	inc a			;48d3   ; ARG = 1: vertical
	out (c),a		;48d4
	ld a,070h		;48d6   ; LINE
	out (c),a		;48d8   ; arranca la orden
	ei			;48da
	ret			;48db

; ----------------------------------------------------------------------
; UN MARCO: cuatro rayas, desde (H, L), de D de ancho y E de alto (los recuadros del marcador).
; ----------------------------------------------------------------------
un_marco:
	ld b,e			;48dc   ; el alto
	call raya_vertical_sin_tocar		;48dd   ; la raya de la izquierda (vertical)
	ld b,d			;48e0   ; el ancho
	call raya_horizontal_sin_tocar		;48e1   ; la de arriba (horizontal)
	push hl			;48e4
	ld a,l			;48e5   ; L + E - 1: la fila de abajo
	dec a			;48e6
	add a,e			;48e7
	ld l,a			;48e8
	ld b,d			;48e9   ; el ancho
	call raya_horizontal_sin_tocar		;48ea   ; la de abajo
	pop hl			;48ed
	ld a,h			;48ee   ; H + D - 1: la columna de la derecha
	dec a			;48ef
	add a,d			;48f0
	ld h,a			;48f1
	ld b,e			;48f2   ; el alto
	jp raya_vertical_sin_tocar		;48f3   ; y la de la derecha
raya_vertical_sin_tocar:
	push hl			;48f6
	push de			;48f7
	push bc			;48f8
	call raya_vertical		;48f9   ; vertical, sin tocar registros
	pop bc			;48fc
	pop de			;48fd
	pop hl			;48fe
	ret			;48ff
raya_horizontal_sin_tocar:
	push hl			;4900
	push de			;4901
	push bc			;4902
	call raya_horizontal		;4903   ; horizontal, sin tocar registros
	pop bc			;4906
	pop de			;4907
	pop hl			;4908
	ret			;4909

; ----------------------------------------------------------------------
; RELLENA UN RECTANGULO: orden HMMV (0xC0) del V9938 en (H, L) de la pagina D, de B x C puntos (0 es 256), con el byte de A.
; ----------------------------------------------------------------------
rellena_rectangulo:
	ex af,af'			;490a   ; el color, a guardar
	call espera_al_vdp		;490b   ; espera_al_vdp: espera a que el V9938 acabe la orden (bit 0 de S#2)
	push bc			;490e
	ld a,(00007h)		;490f
	inc a			;4912
	ld c,a			;4913
	ld a,024h		;4914   ; desde el registro 36 (DX)
	di			;4916
	out (c),a		;4917
	ld a,091h		;4919
	out (c),a		;491b   ; al 17, con autoincremento
	inc c			;491d
	inc c			;491e
	out (c),h		;491f   ; DX = H
	xor a			;4921
	out (c),a		;4922
	out (c),l		;4924   ; DY = L
	out (c),d		;4926   ; la pagina (DY alta)
	pop hl			;4928   ; H = B, L = C
	out (c),h		;4929   ; NX
	cp h			;492b   ; cero?
	jr nz,L_492F		;492c
	inc a			;492e   ; es 256
L_492F:
	out (c),a		;492f
	xor a			;4931
	out (c),l		;4932   ; NY
	cp l			;4934
	jr nz,L_4938		;4935
	inc a			;4937   ; es 256
L_4938:
	out (c),a		;4938
	ex af,af'			;493a   ; el color
	out (c),a		;493b
	xor a			;493d   ; ARG = 0
	out (c),a		;493e
	ld a,0c0h		;4940   ; HMMV
	out (c),a		;4942   ; arranca la orden
	ei			;4944
	ret			;4945

; ----------------------------------------------------------------------
; COPIA UN RECTANGULO de VRAM a VRAM: orden HMMM (0xD0) desde (H, L) a (D, E), de B x C puntos; A lleva las dos paginas, la de origen en los bits 0-1 y la de destino en los 2-3.
; ----------------------------------------------------------------------
copia_rectangulo:
	ex af,af'			;4946   ; las paginas, a guardar
	call espera_al_vdp		;4947   ; espera_al_vdp: espera a que el V9938 acabe la orden (bit 0 de S#2)
	push bc			;494a
	ld a,(00007h)		;494b
	inc a			;494e
	ld c,a			;494f
	ld a,020h		;4950   ; desde el registro 32 (SX)
	di			;4952
	out (c),a		;4953
	ld a,091h		;4955   ; al 17, con autoincremento
	out (c),a		;4957
	inc c			;4959
	inc c			;495a
	out (c),h		;495b   ; SX = H
	xor a			;495d
	out (c),a		;495e
	out (c),l		;4960   ; SY = L
	ex af,af'			;4962
	ld l,a			;4963
	and 003h		;4964   ; la pagina de origen
	out (c),a		;4966
	out (c),d		;4968   ; DX = D
	xor a			;496a
	out (c),a		;496b
	out (c),e		;496d   ; DY = E
	ld a,l			;496f
	rra			;4970   ; la pagina de destino
	rra			;4971
	and 003h		;4972
	out (c),a		;4974
	pop hl			;4976   ; H = B, L = C
	out (c),h		;4977   ; NX
	xor a			;4979
	out (c),a		;497a
	out (c),l		;497c   ; NY
	out (c),a		;497e
	out (c),a		;4980   ; el color no cuenta
	out (c),a		;4982   ; ARG = 0
	ld a,0d0h		;4984   ; HMMM
	out (c),a		;4986   ; arranca la orden
	ei			;4988
	ret			;4989

; ----------------------------------------------------------------------
; HMMC: B x C puntos que van de la CPU a la VRAM en (D, E), pagina A. El primer byte va con la orden (registro 44); los demas, uno a uno por el mismo registro cuando el VDP levanta TR (bit 7 de S#2), hasta que acaba (CE, bit 0, a cero).
; ----------------------------------------------------------------------
hmmc:
	ex af,af'			;498a   ; la pagina, a guardar
	call espera_al_vdp		;498b   ; espera_al_vdp: espera a que el V9938 acabe la orden (bit 0 de S#2)
	push bc			;498e
	ld a,(00007h)		;498f
	inc a			;4992
	ld c,a			;4993
	ld a,024h		;4994   ; desde el registro 36 (DX)
	di			;4996
	out (c),a		;4997
	ld a,091h		;4999
	out (c),a		;499b   ; al 17, con autoincremento
	inc c			;499d
	inc c			;499e
	out (c),d		;499f   ; DX = D
	xor a			;49a1
	out (c),a		;49a2
	out (c),e		;49a4   ; DY = E
	ex af,af'			;49a6
	out (c),a		;49a7   ; la pagina
	pop de			;49a9   ; D = B, E = C
	out (c),d		;49aa   ; NX
	xor a			;49ac
	out (c),a		;49ad
	out (c),e		;49af   ; NY
	out (c),a		;49b1
	ld a,(hl)			;49b3   ; el primer byte
	inc hl			;49b4
	out (c),a		;49b5   ; va en el 44 (CLR)
	xor a			;49b7   ; ARG = 0
	out (c),a		;49b8
	ld a,0f0h		;49ba   ; HMMC
	out (c),a		;49bc   ; arranca la orden
	dec c			;49be
	dec c			;49bf
	ld a,0ach		;49c0   ; el registro 44, sin autoincremento (0x80 | 44)
	out (c),a		;49c2
	ld a,091h		;49c4
	out (c),a		;49c6   ; al 17
	inc c			;49c8
	inc c			;49c9
L_49CA:
	ld a,002h		;49ca   ; lee S#2
	call lee_estado_del_vdp		;49cc   ; lee_estado_del_vdp: lee el registro de estado A del V9938
	rra			;49cf   ; CE: sigue la orden?
	ret nc			;49d0   ; no: acabo
	add a,a			;49d1   ; TR, el bit 7, al acarreo
	add a,a			;49d2
	jr nc,L_49CA		;49d3   ; no pide byte todavia
	ld a,(hl)			;49d5   ; el siguiente byte
	inc hl			;49d6
	out (c),a		;49d7   ; al registro 44
	jr L_49CA		;49d9

; ----------------------------------------------------------------------
; COPIA CON OPERACION LOGICA: orden LMMM (0x90 + la operacion) de (H, L) a (D, E), de B x C puntos. A lleva empaquetadas la pagina de origen (bits 6-7), la de destino (bits 4-5) y la operacion logica (bits 0-3; con 8, TIMP, el color 0 no se copia y hace de transparente).
; ----------------------------------------------------------------------
copia_con_operacion:
	ex af,af'			;49db   ; lo empaquetado, a guardar
	call espera_al_vdp		;49dc   ; espera_al_vdp: espera a que el V9938 acabe la orden (bit 0 de S#2)
	push bc			;49df
	ld a,(00007h)		;49e0
	inc a			;49e3
	ld c,a			;49e4
	ld a,020h		;49e5   ; desde el registro 32 (SX)
	di			;49e7
	out (c),a		;49e8
	ld a,091h		;49ea   ; al 17, con autoincremento
	out (c),a		;49ec
	inc c			;49ee
	inc c			;49ef
	out (c),h		;49f0   ; SX = H
	xor a			;49f2
	out (c),a		;49f3
	out (c),l		;49f5   ; SY = L
	ex af,af'			;49f7
	rlca			;49f8   ; los bits 6-7 abajo
	rlca			;49f9
	ld l,a			;49fa
	and 003h		;49fb   ; la pagina de origen
	out (c),a		;49fd
	out (c),d		;49ff   ; DX = D
	xor a			;4a01
	out (c),a		;4a02
	out (c),e		;4a04   ; DY = E
	ld a,l			;4a06
	ld e,a			;4a07
	rlca			;4a08   ; los bits 4-5 abajo
	rlca			;4a09
	and 003h		;4a0a   ; la pagina de destino
	out (c),a		;4a0c
	pop hl			;4a0e   ; H = B, L = C
	out (c),h		;4a0f   ; NX
	xor a			;4a11
	out (c),a		;4a12
	out (c),l		;4a14   ; NY
	out (c),a		;4a16
	out (c),a		;4a18
	out (c),a		;4a1a   ; ARG = 0
	ld a,e			;4a1c
	rra			;4a1d   ; la operacion logica
	rra			;4a1e
	and 00fh		;4a1f
	or 090h		;4a21   ; LMMM
	out (c),a		;4a23   ; arranca la orden
	ei			;4a25
	ret			;4a26
sube_letras:
	call sube_una_letra		;4a27   ; sube_una_letra: un caracter de 1 bit de HL
	call la_posicion_siguiente		;4a2a   ; la siguiente posicion
	djnz sube_letras		;4a2d   ; B caracteres
	ret			;4a2f
sube_una_letra:
	push bc			;4a30
	push de			;4a31
	push hl			;4a32
	push de			;4a33   ; la posicion, a guardar
	call colorea_una_letra		;4a34   ; el caracter, de 1 bit a 4 bits en 0xC110
	pop de			;4a37
	ld b,d			;4a38   ; D es la x y E la y: se cambian
	ld d,e			;4a39
	ld e,b			;4a3a
	srl d		;4a3b   ; (y * 256 + x) / 2 = y * 128 + x / 2
	rr e		;4a3d
	ld a,d			;4a3f
	add a,080h		;4a40   ; en la pagina 1 (0x8000)
	ld d,a			;4a42
	ld hl,0c110h		;4a43   ; el caracter ya coloreado
	call sube_un_dibujo		;4a46   ; sube_un_dibujo: un dibujo de 8x8 a 4 bits (32 bytes) de HL a la VRAM de DE
	pop hl			;4a49
	ld bc,00008h		;4a4a   ; el siguiente caracter de la fuente
	add hl,bc			;4a4d
	pop de			;4a4e
	pop bc			;4a4f
	ret			;4a50
sube_un_dibujo:
	push de			;4a51
	ld b,008h		;4a52   ; ocho filas
L_4A54:
	push bc			;4a54
	ld bc,00004h		;4a55   ; de cuatro bytes (ocho puntos)
	call copia_a_la_vram		;4a58   ; copia_a_la_vram: BC bytes de HL a la VRAM de DE
	ex de,hl			;4a5b
	ld bc,00080h		;4a5c   ; la fila siguiente de la VRAM, 128 bytes mas alla
	add hl,bc			;4a5f
	ex de,hl			;4a60
	pop bc			;4a61
	djnz L_4A54		;4a62   ; ocho filas
	pop de			;4a64
	ret			;4a65
sube_dibujos:
	push bc			;4a66
	call sube_un_dibujo		;4a67   ; sube_un_dibujo: un dibujo de 8x8 a 4 bits (32 bytes) de HL a la VRAM de DE
	ld a,004h		;4a6a   ; cuatro bytes (ocho puntos) a la derecha
	add a,e			;4a6c
	cp 080h		;4a6d   ; se llego al borde (128 bytes por linea)?
	jr nz,L_4A76		;4a6f
	ld a,004h		;4a71   ; si: ocho lineas mas abajo (0x400)
	add a,d			;4a73
	ld d,a			;4a74
	xor a			;4a75   ; y desde la izquierda
L_4A76:
	ld e,a			;4a76
	pop bc			;4a77
	djnz sube_dibujos		;4a78   ; B dibujos
	ret			;4a7a
sube_un_dibujo_de_16:
	push de			;4a7b
	ld b,010h		;4a7c   ; dieciseis filas
L_4A7E:
	push bc			;4a7e
	ld bc,00008h		;4a7f   ; de ocho bytes (dieciseis puntos)
	call copia_a_la_vram		;4a82   ; copia_a_la_vram: BC bytes de HL a la VRAM de DE
	ex de,hl			;4a85
	ld bc,00080h		;4a86   ; la fila siguiente, 128 bytes mas alla
	add hl,bc			;4a89
	ex de,hl			;4a8a
	pop bc			;4a8b
	djnz L_4A7E		;4a8c   ; dieciseis filas
	pop de			;4a8e
	ret			;4a8f
sube_dibujos_de_16:
	push bc			;4a90
	call sube_un_dibujo_de_16		;4a91
	ld a,008h		;4a94   ; ocho bytes (dieciseis puntos) a la derecha
	add a,e			;4a96
	cp 080h		;4a97   ; se llego al borde?
	jr nz,L_4AA0		;4a99
	ld a,008h		;4a9b   ; si: dieciseis lineas mas abajo (0x800)
	add a,d			;4a9d
	ld d,a			;4a9e
	xor a			;4a9f   ; y desde la izquierda
L_4AA0:
	ld e,a			;4aa0
	pop bc			;4aa1
	djnz sube_dibujos_de_16		;4aa2   ; B dibujos
	ret			;4aa4
colorea_una_letra:
	ld b,008h		;4aa5   ; ocho filas
	ld de,0c110h		;4aa7   ; al bufer de 0xC110
L_4AAA:
	push bc			;4aaa
	push hl			;4aab
	ex de,hl			;4aac
	ld a,(de)			;4aad   ; la fila, de 1 bit por punto
	ld d,a			;4aae
	ld b,004h		;4aaf   ; cuatro bytes de salida (dos puntos cada uno)
L_4AB1:
	ld a,c			;4ab1   ; el color
	rl d		;4ab2   ; el punto de la izquierda
	jr c,L_4AB7		;4ab4
	xor a			;4ab6   ; apagado: color 0
L_4AB7:
	rld		;4ab7   ; entra en el nibble alto...
	ld a,c			;4ab9   ; el color
	rl d		;4aba   ; el punto de la derecha
	jr c,L_4ABF		;4abc
	xor a			;4abe   ; apagado: color 0
L_4ABF:
	rld		;4abf   ; ... y el byte queda con los dos puntos
	inc hl			;4ac1
	djnz L_4AB1		;4ac2   ; cuatro bytes por fila
	ex de,hl			;4ac4
	pop hl			;4ac5
	inc hl			;4ac6   ; la fila siguiente del caracter
	pop bc			;4ac7
	djnz L_4AAA		;4ac8   ; ocho filas
	ret			;4aca
rotulo:
	ld c,0ffh		;4acb   ; C = 0xFF: se pinta
	jr L_4AD1		;4acd
borra_rotulo:
	ld c,000h		;4acf   ; C = 0: se borra (todo sale como el caracter 0)
L_4AD1:
	ld d,(hl)			;4ad1   ; la x
	inc hl			;4ad2
	ld e,(hl)			;4ad3   ; la y
	inc hl			;4ad4
L_4AD5:
	ld a,(hl)			;4ad5   ; el caracter
	inc hl			;4ad6
	ld b,a			;4ad7
	inc b			;4ad8   ; 0xFF acaba
	ret z			;4ad9
	inc b			;4ada   ; 0xFE: otra posicion...
	jr z,rotulo		;4adb   ; ...y vuelve a pintar: tras un 0xFE, borra_rotulo PINTA
	and c			;4add   ; al borrar, el caracter 0
	call pinta_una_letra		;4ade   ; pinta el caracter en (D, E)
	ld a,d			;4ae1   ; ocho puntos a la derecha
	add a,008h		;4ae2
	ld d,a			;4ae4
	jr L_4AD5		;4ae5
pinta_una_letra:
	push bc			;4ae7
	push hl			;4ae8
	push de			;4ae9
	or a			;4aea   ; el 0 es el espacio
	ld h,a			;4aeb   ; H = 0 para el espacio
	jr z,L_4AF3		;4aec
	call sitio_del_dibujo		;4aee   ; la columna del caracter en la fuente
	add a,038h		;4af1   ; y su fila: la fuente empieza en la linea 0x38
L_4AF3:
	ld l,a			;4af3
	ld bc,00808h		;4af4   ; 8 x 8 puntos
	ld a,001h		;4af7   ; de la pagina 1 a la 0
	call copia_rectangulo		;4af9   ; copia la letra de la fuente a la pantalla
	pop de			;4afc
	pop hl			;4afd
	pop bc			;4afe
	ret			;4aff

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_4B00: un bucle al que no llega nadie (`push af /
;   call 0x4AE7 / call 0x4B4F / pop af / djnz / ret`); la palabra 0x4B00 solo
;   aparece dentro de los dibujos de los bancos 4, 5 y 9
;   0x4b00..0x4b0b  (11 bytes)
DATA_codigo_sin_llamar_4B00:
	defb 0f5h,0cdh,0e7h,04ah,0cdh,04fh,04bh,0f1h,010h,0f6h,0c9h	; 4b00  ...J.OK....

; ======================================================================
; CODIGO 0x4b0b..0x4b95  (138 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; PINTA EL DIBUJO A de la pagina 1 (el de (A % 32 * 8, A / 32 * 8), 8 x 8) en (D, E): 0x4B0B tal cual en la pagina 0 (HMMM), 0x4B1D con transparencia (LMMM y TIMP) y 0x4B2F dentro de la pagina 1.
; ----------------------------------------------------------------------
pinta_el_dibujo:
	push bc			;4b0b
	push hl			;4b0c
	push de			;4b0d
	call sitio_del_dibujo		;4b0e   ; su sitio en la pagina 1
	ld bc,00808h		;4b11   ; 8 x 8...
	ld a,001h		;4b14   ; ... de la pagina 1 a la 0
	call copia_rectangulo		;4b16   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	pop de			;4b19
	pop hl			;4b1a
	pop bc			;4b1b
	ret			;4b1c
pinta_el_dibujo_con_transparencia:
	push bc			;4b1d
	push hl			;4b1e
	push de			;4b1f
	call sitio_del_dibujo		;4b20   ; su sitio en la pagina 1
	ld bc,00808h		;4b23   ; 8 x 8...
	ld a,048h		;4b26   ; ... con TIMP, de la 1 a la 0
	call copia_con_operacion		;4b28
	pop de			;4b2b
	pop hl			;4b2c
	pop bc			;4b2d
	ret			;4b2e
copia_el_dibujo_en_la_pagina_1:
	push bc			;4b2f
	push hl			;4b30
	push de			;4b31
	call sitio_del_dibujo		;4b32   ; su sitio en la pagina 1
	ld bc,00808h		;4b35   ; 8 x 8...
	ld a,005h		;4b38   ; ... de la pagina 1 a la 1
	call copia_rectangulo		;4b3a   ; copia_rectangulo: orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)
	pop de			;4b3d
	pop hl			;4b3e
	pop bc			;4b3f
	ret			;4b40
sitio_del_dibujo:
	ld b,a			;4b41   ; el dibujo A...
	and 01fh		;4b42   ; ... su columna (A % 32)...
	add a,a			;4b44   ; ... por 8: H
	add a,a			;4b45
	add a,a			;4b46
	ld h,a			;4b47
	ld a,b			;4b48   ; su fila (A / 32)...
	and 0e0h		;4b49
	rrca			;4b4b   ; ... por 8: L
	rrca			;4b4c
	ld l,a			;4b4d
	ret			;4b4e
la_posicion_siguiente:
	ld a,d			;4b4f   ; ocho a la derecha...
	add a,008h		;4b50
	ld d,a			;4b52
	ret nz			;4b53   ; ... y al pasar del borde...
	ld a,e			;4b54   ; ... ocho mas abajo
	add a,008h		;4b55
	ld e,a			;4b57
	ret			;4b58

; ----------------------------------------------------------------------
; PREPARA LA PANTALLA: el sonido, sin sprites, SCREEN 5 por la BIOS, la pantalla apagada, las paginas 0 y 1 enteras a cero, cuatro registros del VDP de 0x4B95, los sprites escondidos y la pantalla encendida.
; ----------------------------------------------------------------------
prepara_la_pantalla:
	call inicia_el_sonido		;4b59   ; el sonido
	call apaga_los_sprites		;4b5c   ; sin sprites
	ld a,005h		;4b5f   ; SCREEN 5
	call 0005fh		;4b61   ; BIOS CHGMOD - Switches to given screen mode
	call apaga_la_pantalla		;4b64   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	xor a			;4b67   ; la pagina 0 entera...
	ld h,a			;4b68
	ld l,a			;4b69
	ld b,a			;4b6a
	ld c,a			;4b6b
	ld d,a			;4b6c
	call rellena_rectangulo		;4b6d   ; ... a cero
	xor a			;4b70   ; y la 1
	ld h,a			;4b71
	ld l,a			;4b72
	ld b,a			;4b73
	ld c,a			;4b74
	ld d,001h		;4b75
	call rellena_rectangulo		;4b77   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	call espera_al_vdp		;4b7a   ; cuando acabe...
	ld b,004h		;4b7d   ; ... los cuatro registros de 0x4B95
	ld hl,04b95h		;4b7f
L_4B82:
	push bc			;4b82
	ld c,(hl)			;4b83   ; C = el registro...
	inc hl			;4b84
	ld b,(hl)			;4b85   ; ... B = el valor
	inc hl			;4b86
	push hl			;4b87
	call 00047h		;4b88   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;4b8b
	pop bc			;4b8c
	djnz L_4B82		;4b8d
	call esconde_los_sprites		;4b8f
	jp enciende_la_pantalla		;4b92   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno

; ----------------------------------------------------------------------
; DATOS registros_del_vdp: cuatro pares [registro][valor] que p00:4B7F escribe
;   con WRTVDP: R1 = 0x62, R5 = 0xEF, R6 = 0x1F y R11 = 0x01 (la pantalla y
;   las tablas de sprites)
;   0x4b95..0x4b9d  (8 bytes)
DATA_registros_del_vdp:
	defb 001h,062h,005h,0efh,006h,01fh,00bh,001h	; 4b95  .b......

; ======================================================================
; CODIGO 0x4b9d..0x4c00  (99 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LOS MANDOS DE CADA CUADRO: en una partida (bit 6 de 0xC002), las teclas F1-F3 a 0xC00C (las recien pulsadas en 0xC00B: F1 la pausa, F2 el mapa del pergamino) y el mando y el teclado a 0xC007 (recien pulsados en 0xC006); si no, las pulsaciones de la demostracion.
; ----------------------------------------------------------------------
lee_los_mandos:
	ld a,(0c002h)		;4b9d   ; en una partida?
	and 040h		;4ba0
	jp z,pulsacion_de_la_demostracion		;4ba2   ; no: las de la demostracion
	call f1_a_f3		;4ba5   ; F1-F3...
	ld hl,0c00ch		;4ba8   ; ... a 0xC00C
	call recien_pulsado		;4bab
	call el_mando_y_el_teclado		;4bae   ; el mando y el teclado...
a_los_mandos:
	ld hl,0c007h		;4bb1   ; ... a 0xC007

; ----------------------------------------------------------------------
; GUARDA A EN (HL) y en (HL - 1) lo recien pulsado: lo que esta a 1 ahora y no lo estaba antes.
; ----------------------------------------------------------------------
recien_pulsado:
	ld c,(hl)			;4bb4   ; lo de antes
	ld (hl),a			;4bb5   ; lo de ahora
	xor c			;4bb6   ; lo que cambia...
	and (hl)			;4bb7   ; ... y esta a 1
	dec hl			;4bb8
	ld (hl),a			;4bb9   ; a (HL - 1)
	ret			;4bba

; ----------------------------------------------------------------------
; EL MANDO Y EL TECLADO: el mando 1 (registro 14 del PSG con el 15 a 0x8F: las cuatro direcciones y los dos disparos, bits 0-5, a 1 si se pulsan) mezclado con la fila 8 del teclado (los cursores y el espacio) repartida en los mismos bits.
; ----------------------------------------------------------------------
el_mando_y_el_teclado:
	ld e,08fh		;4bbb   ; el registro 15 a 0x8F...
	ld a,00fh		;4bbd
	call 00093h		;4bbf   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;4bc2   ; ... y el 14: el mando 1
	di			;4bc4
	call 00096h		;4bc5   ; BIOS RDPSG - Reads value from PSG-register
	ei			;4bc8
	cpl			;4bc9   ; (a 1, pulsado)
	and 03fh		;4bca   ; sus seis bits
	push af			;4bcc
	ld a,008h		;4bcd   ; la fila 8 del teclado...
	call 00141h		;4bcf   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4bd2
	ld e,a			;4bd3
	and 020h		;4bd4   ; ... su bit 5
	ld e,a			;4bd6
	ld a,008h		;4bd7   ; otra vez la fila 8...
	call 00141h		;4bd9   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4bdc
	rrca			;4bdd
	rrca			;4bde
	ld b,a			;4bdf
	and 004h		;4be0   ; ... su bit 4 al 2
	or e			;4be2
	ld c,a			;4be3
	ld a,b			;4be4
	rrca			;4be5
	rrca			;4be6
	ld b,a			;4be7
	and 018h		;4be8   ; ... dos mas a los bits 3 y 4
	or c			;4bea
	ld c,a			;4beb
	ld a,b			;4bec
	rrca			;4bed
	and 003h		;4bee   ; ... y dos a los bits 0 y 1
	or c			;4bf0
	pop bc			;4bf1
	or b			;4bf2   ; junto con el mando
	ret			;4bf3
f1_a_f3:
	ld a,006h		;4bf4   ; la fila 6 del teclado...
	call 00141h		;4bf6   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4bf9   ; (a 1, pulsada)
	rlca			;4bfa   ; ... sus bits 5-7, F1, F2 y F3...
	rlca			;4bfb
	rlca			;4bfc
	and 007h		;4bfd   ; ... a los bits 0-2
	ret			;4bff

; ----------------------------------------------------------------------
; DATOS rotulo_4C00: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "SCORE- / PLAYER / ENEMY / {50}- / P- / STAGE-"; lo
;   leen p00:4516 (45 bytes)
;   0x4c00..0x4c2d  (45 bytes)
DATA_rotulo_4C00:
	defb 008h,000h,043h,033h,03fh,042h,035h,030h,0feh,008h,00ch,040h,03ch,031h,049h,035h	; 4c00  ..C3?B50...@<1I5
	defb 042h,0feh,008h,014h,035h,03eh,035h,03dh,049h,0feh,0b0h,000h,050h,030h,0feh,0d4h	; 4c10  B...5>5=I...P0..
	defb 000h,040h,030h,0feh,06ch,000h,043h,044h,031h,037h,035h,030h,0ffh	; 4c20  .@0.l.CD1750.

; ----------------------------------------------------------------------
; DATOS rotulo_sin_usar_4C2D: rotulo para 0x4ACB que no lee nadie y cierra
;   clavado: "STAGE   "; lo leen nadie (11 bytes)
;   0x4c2d..0x4c38  (11 bytes)
DATA_rotulo_sin_usar_4C2D:
	defb 060h,038h,043h,044h,031h,037h,035h,000h,000h,000h,0ffh	; 4c2d  `8CD175....

; ----------------------------------------------------------------------
; DATOS rotulo_4C38: rotulo para p01:7B32 (0xFE [dx] baja una fila, 0xFF
;   acaba): "{02} / {03}{04} / {05}{06}{07}{08} / {09}{0A}{0B}{0C}{0D} /
;   {0E}{0F}{01}{01}{10}{11}"; lo leen p00:4DAB, p00:4DCB (27 bytes)
;   0x4c38..0x4c53  (27 bytes)
DATA_rotulo_4C38:
	defb 002h,0feh,0f8h,003h,004h,0feh,0f8h,005h,006h,007h,008h,0feh,000h,009h,00ah,00bh	; 4c38  ................
	defb 00ch,00dh,0feh,0f8h,00eh,00fh,001h,001h,010h,011h,0ffh	; 4c48  ...........

; ----------------------------------------------------------------------
; DATOS rotulo_4C53: rotulo para p01:7B32 (0xFE [dx] baja una fila, 0xFF
;   acaba): "{2F}{2F} /
;   {16}{17}{18}{15}{01}{01}{01}{01}{28}{2F}{2F}{12}{13}{14}{15} /
;   {26}{23}{24}{25}{01}{01}{01}{01}{19}{1A}{1B}{22}{23}{24}{25} /
;   {1C}{1D}{1E}{1F}{01}{01}{01}{01}{29}{2A}{2B}{1C}{1D}{1E}{1F} /
;   {20}{21}{2C}{01}{01}{01}{01}{01}{2D}{2E}{27}{20}{21}{2C}"; lo leen
;   p00:4DB4 (70 bytes)
;   0x4c53..0x4c99  (70 bytes)
DATA_rotulo_4C53:
	defb 02fh,02fh,0feh,0b0h,016h,017h,018h,015h,001h,001h,001h,001h,028h,02fh,02fh,012h	; 4c53  //..........(//.
	defb 013h,014h,015h,0feh,000h,026h,023h,024h,025h,001h,001h,001h,001h,019h,01ah,01bh	; 4c63  .....&#$%.......
	defb 022h,023h,024h,025h,0feh,000h,01ch,01dh,01eh,01fh,001h,001h,001h,001h,029h,02ah	; 4c73  "#$%..........)*
	defb 02bh,01ch,01dh,01eh,01fh,0feh,000h,020h,021h,02ch,001h,001h,001h,001h,001h,02dh	; 4c83  +...... !,.....-
	defb 02eh,027h,020h,021h,02ch,0ffh	; 4c93

; ----------------------------------------------------------------------
; DATOS rotulo_4C99: rotulo para p01:7B32 (0xFE [dx] baja una fila, 0xFF
;   acaba):
;   "{67}{12}{13}{14}{15}{16}{17}{18}{19}{1A}{1B}{1C}{1D}{1E}{1F}{20}{21} /
;   {22}{23}{24}{25}{26}{27}{28}{29}{2A}{2B}{2C}{2D}{2E}{2F}-A /
;   BCDEFGHIJKLMNOPQ /  / RSTUVWXWYZ{4B}{4C}{4D} /
;   {52}{53}{54}{55}{56}{57}{60}{57}{60}{61}{5B}{5C}{5D}  {65}{65} /
;   {4E}{4F}{50}{51}{58}{59}{5A}{59}{68}{69}{6A}{5E}{5F}{62}{63}{64}{63}{64}{66}";
;   lo leen p00:4DC2 (111 bytes)
;   0x4c99..0x4d08  (111 bytes)
DATA_rotulo_4C99:
	defb 067h,012h,013h,014h,015h,016h,017h,018h,019h,01ah,01bh,01ch,01dh,01eh,01fh,020h	; 4c99  g..............
	defb 021h,0feh,008h,022h,023h,024h,025h,026h,027h,028h,029h,02ah,02bh,02ch,02dh,02eh	; 4ca9  !.."#$%&'()*+,-.
	defb 02fh,030h,031h,0feh,000h,032h,033h,034h,035h,036h,037h,038h,039h,03ah,03bh,03ch	; 4cb9  /01..23456789:;<
	defb 03dh,03eh,03fh,040h,041h,0feh,000h,0feh,0f8h,042h,043h,044h,045h,046h,047h,048h	; 4cc9  =>?@A....BCDEFGH
	defb 047h,049h,04ah,04bh,04ch,04dh,0feh,000h,052h,053h,054h,055h,056h,057h,060h,057h	; 4cd9  GIJKLM..RSTUVW`W
	defb 060h,061h,05bh,05ch,05dh,000h,000h,065h,065h,0feh,000h,04eh,04fh,050h,051h,058h	; 4ce9  `a[\]..ee..NOPQX
	defb 059h,05ah,059h,068h,069h,06ah,05eh,05fh,062h,063h,064h,063h,064h,066h,0ffh	; 4cf9  YZYhij^_bcdcdf.

; ----------------------------------------------------------------------
; DATOS rotulo_4D08: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "{2A} KONAMI {21}{29}{28}{26} / PUSH SPACE KEY"; lo
;   leen p00:4DD1 (33 bytes)
;   0x4d08..0x4d29  (33 bytes)
DATA_rotulo_4D08:
	defb 048h,088h,02ah,000h,03bh,03fh,03eh,031h,03dh,039h,000h,021h,029h,028h,026h,0feh	; 4d08  H.*.;?>1=9.!)(&.
	defb 048h,0a0h,040h,045h,043h,038h,000h,043h,040h,031h,033h,035h,000h,03bh,035h,049h	; 4d18  H.@EC8.C@135.;5I
	defb 0ffh	; 4d28

; ----------------------------------------------------------------------
; DATOS rotulo_4D29: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "  PLAY START  "; lo leen p00:41DE, p00:41E1 (17
;   bytes)
;   0x4d29..0x4d3a  (17 bytes)
DATA_rotulo_4D29:
	defb 048h,0a0h,000h,000h,040h,03ch,031h,049h,000h,043h,044h,031h,042h,044h,000h,000h	; 4d29  H...@<1I.CD1BD..
	defb 0ffh	; 4d39

; ----------------------------------------------------------------------
; DATOS rotulo_4D3A: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "GAME  OVER"; lo leen p00:42E9 (13 bytes)
;   0x4d3a..0x4d47  (13 bytes)
DATA_rotulo_4D3A:
	defb 058h,058h,037h,031h,03dh,035h,000h,000h,03fh,046h,035h,042h,0ffh	; 4d3a  XX71=5..?F5B.

; ======================================================================
; CODIGO 0x4d47..0x4dd7  (144 bytes)
; ======================================================================


pinta_el_titulo:
	call apaga_la_pantalla		;4d47   ; EL TITULO: pantalla apagada...
	call borra_la_pagina_0		;4d4a   ; ... la pagina 0 a cero...
	call espera_al_vdp		;4d4d   ; espera_al_vdp: espera a que el V9938 acabe la orden (bit 0 de S#2)
	call pon_la_paleta_base		;4d50   ; ... lo de 0x5727...
	ld b,003h		;4d53   ; ... y el color 0x0F en tres pasos...
	ld de,06606h		;4d55   ; ... 0x6606, 0x4404 y 0x2202...
L_4D58:
	ld a,00fh		;4d58
	call pon_un_color		;4d5a   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
	dec e			;4d5d
	dec e			;4d5e
	ld a,d			;4d5f
	sub 022h		;4d60
	ld d,a			;4d62
	ld hl,00800h		;4d63   ; ... con una espera de 0x800 vueltas
L_4D66:
	dec hl			;4d66
	ld a,h			;4d67
	or l			;4d68
	jr nz,L_4D66		;4d69
	djnz L_4D58		;4d6b
	ld b,000h		;4d6d   ; el color del borde (registro 7) a 0...
	ld c,007h		;4d6f
	call 00047h		;4d71   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,00fh		;4d74   ; ... y el 0x0F, 0x0700
	ld de,00700h		;4d76
	call pon_un_color		;4d79   ; pon_un_color: color A de la paleta = DE (y su copia en la VRAM, en 0xF680)
	call esconde_los_sprites		;4d7c   ; sin sprites
	call sube_la_fuente		;4d7f
	call sube_los_dibujos_del_titulo		;4d82
	ld hl,00010h		;4d85   ; desde (0, 0x10), 256 x 0x68...
	ld bc,00068h		;4d88
	ld a,0ffh		;4d8b   ; ... del byte 0xFF
	ld d,000h		;4d8d
	call rellena_rectangulo		;4d8f   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	ld hl,00516h		;4d92   ; lo de 0x7ACF, con 0x0516...
	call 07acfh		;4d95
	ld hl,00569h		;4d98   ; ... y con 0x0569
	call 07acfh		;4d9b
	ld a,(0002bh)		;4d9e   ; la BIOS en 0x002B: el juego de caracteres...
	and 00fh		;4da1
	jr nz,titulo_de_fuera		;4da3   ; ... 0, el japones:
	ld de,0a818h		;4da5   ; el rotulo de 0x4C38 en (0xA8, 0x18)...
	ld hl,04c38h		;4da8
	call 07b32h		;4dab   ; rotulo_por_filas: pinta caracteres; 0xFE [dx] baja una fila, 0xFF acaba
	ld de,0a038h		;4dae   ; ... el de 0x4C53 en (0xA0, 0x38)...
	ld hl,04c53h		;4db1
	call 07b32h		;4db4   ; rotulo_por_filas: pinta caracteres; 0xFE [dx] baja una fila, 0xFF acaba
	call 07aefh		;4db7   ; ... y lo de 0x7AEF
	jr titulo_rotulo		;4dba
titulo_de_fuera:
	ld de,03828h		;4dbc   ; los demas: el de 0x4C99 en (0x38, 0x28)...
	ld hl,04c99h		;4dbf
	call 07b32h		;4dc2   ; rotulo_por_filas: pinta caracteres; 0xFE [dx] baja una fila, 0xFF acaba
	ld de,0b830h		;4dc5   ; ... y el de 0x4C38 en (0xB8, 0x30)
	ld hl,04c38h		;4dc8
	call 07b32h		;4dcb   ; rotulo_por_filas: pinta caracteres; 0xFE [dx] baja una fila, 0xFF acaba
titulo_rotulo:
	ld hl,04d08h		;4dce   ; el rotulo de 0x4D08...
	call rotulo		;4dd1   ; ... y la pantalla encendida
	jp enciende_la_pantalla		;4dd4   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_4DD7: instrucciones que no alcanza nadie:
;   desensamblan enteras hasta un jr justo en el borde y su direccion no
;   aparece como palabra en el cartucho; lo leen nadie (4 bytes)
;   0x4dd7..0x4ddb  (4 bytes)
DATA_codigo_sin_llamar_4DD7:
	defb 016h,001h,018h,002h	; 4dd7

; ======================================================================
; CODIGO 0x4ddb..0x4e5d  (130 bytes)
; ======================================================================


borra_la_pagina_0:
	ld d,000h		;4ddb   ; pagina 0
	ld hl,00000h		;4ddd   ; desde (0, 0)
	ld bc,00000h		;4de0   ; 256 x 256: toda
	xor a			;4de3   ; color 0
	jp rellena_rectangulo		;4de4   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)

; ----------------------------------------------------------------------
; EMPIEZA LA DEMOSTRACION: todo a cero, la fase 1 con la vida en marcha (0xC413) y las pulsaciones de la tabla de 0x4E5D en lugar de los mandos.
; ----------------------------------------------------------------------
prepara_la_demostracion:
	ld hl,0c420h		;4de7   ; borra de 0xC420...
	ld de,0c421h		;4dea
	ld bc,01bdfh		;4ded   ; ... 0x1BE0 bytes
	xor a			;4df0
	ld (hl),a			;4df1
	ldir		;4df2
	ld (0c007h),a		;4df4   ; sin teclas
	ld (0cf3dh),a		;4df7
	ld (0d001h),a		;4dfa   ; guarda la HABITACION dentro de la fase
	ld (0d002h),a		;4dfd   ; guarda el bloque de tres fases (0-5)
	inc a			;4e00
	ld (0c413h),a		;4e01   ; la vida en marcha (0xC413 = 1)
	ld (0c411h),a		;4e04   ; guarda la fase en BCD, la del marcador
	ld (0d000h),a		;4e07   ; guarda la FASE (0 el patio, 1-18)
	ld (0cf3ah),a		;4e0a   ; el primer par, ya
	ld a,020h		;4e0d   ; vida llena
	ld (0c415h),a		;4e0f   ; guarda la vida de Simon
	ld a,080h		;4e12   ; y la del enemigo
	ld (0c418h),a		;4e14   ; guarda la vida del enemigo (barra ENEMY)
	call 062d0h		;4e17   ; empieza una vida
	call 062e6h		;4e1a   ; monta la fase
	jp pinta_el_marcador		;4e1d   ; y el marcador
un_cuadro_de_la_demostracion:
	call un_cuadro_del_juego		;4e20
	ld a,(0c41bh)		;4e23   ; lee el lado por el que se sale de la habitacion
	and a			;4e26   ; se sale de la habitacion?
	ret z			;4e27   ; no
	call a_que_habitacion_se_sale		;4e28   ; si: a cual
	jp 062f5h		;4e2b   ; y se monta

; ----------------------------------------------------------------------
; UN CUADRO DE LA DEMOSTRACION: se entregan las teclas del par que toca hasta que se acaba su cuenta, y se pasa al siguiente. Unas teclas 0xFF la terminan.
; ----------------------------------------------------------------------
pulsacion_de_la_demostracion:
	ld hl,0cf3ah		;4e2e   ; la cuenta del par
	dec (hl)			;4e31
	jr z,L_4E46		;4e32   ; se acabo: el siguiente
L_4E34:
	ld a,(0cf3bh)		;4e34   ; las teclas del par
	cp 0ffh		;4e37   ; 0xFF...
	jr z,L_4E41		;4e39   ; ... acaba la demostracion
	ld hl,0c007h		;4e3b   ; se entregan como mandos
	jp a_los_mandos		;4e3e
L_4E41:
	xor a			;4e41   ; fin de la demostracion
	ld (0c413h),a		;4e42   ; guarda la VIDA en marcha
	ret			;4e45
L_4E46:
	inc hl			;4e46   ; el numero de par
	inc hl			;4e47
	ld c,(hl)			;4e48
	inc (hl)			;4e49   ; el siguiente
	ld de,04e5dh		;4e4a   ; la tabla de pulsaciones
	ld l,c			;4e4d
	ld h,000h		;4e4e
	add hl,hl			;4e50   ; dos bytes por par
	add hl,de			;4e51
	ld a,(hl)			;4e52   ; cuantos cuadros
	ld (0cf3ah),a		;4e53   ; guarda la cuenta de la pulsacion de la demostracion
	inc hl			;4e56
	ld a,(hl)			;4e57   ; las teclas
	ld (0cf3bh),a		;4e58   ; guarda las teclas de la demostracion
	jr L_4E34		;4e5b

; ----------------------------------------------------------------------
; DATOS teclas_de_la_demostracion: LAS PULSACIONES DE LA DEMOSTRACION: 27
;   pares [cuantos cuadros][teclas] que p00:4E48 va sacando por orden (0xCF3A
;   la cuenta, 0xCF3B las teclas) y p00:4E3E entrega como si fueran los mandos
;   (0xC007); unas teclas 0xFF acaban la demostracion (p00:4E41, que quita la
;   vida en marcha)
;   0x4e5d..0x4e93  (54 bytes)
DATA_teclas_de_la_demostracion:
	defb 016h,000h,02bh,008h,007h,018h,017h,008h,008h,018h,055h,008h,004h,000h,010h,004h	; 4e5d  ..+.......U.....
	defb 009h,000h,041h,021h,022h,029h,007h,039h,025h,029h,02ah,008h,004h,029h,04dh,008h	; 4e6d  ..A!").9%)*..)M.
	defb 00fh,000h,01ah,004h,009h,014h,00fh,004h,007h,000h,05eh,008h,00eh,000h,014h,004h	; 4e7d  ..........^.....
	defb 00fh,000h,04ch,021h,001h,0ffh	; 4e8d

; ======================================================================
; CODIGO 0x4e93..0x4f7f  (236 bytes)
; ======================================================================


mueve_la_escena:
	call 098ech		;4e93   ; las siete cosas...
	call 09918h		;4e96   ; ... sus sprites...
	call 064ech		;4e99   ; ... y los de Simon
	jp 065a4h		;4e9c
crea_el_tipo_0x27:
	ld c,027h		;4e9f   ; EL TIPO 0x27, de la escena del estado 3...
	ld de,0e048h		;4ea1   ; ... en (0xE0, 0x48)
	jp crea_una_cosa		;4ea4   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
nace_el_tipo_0x27:
	ld (ix+006h),001h		;4ea7   ; al nacer: se mueve...
	ld (ix+00bh),094h		;4eab   ; ... con el dibujo 0x94
	ld (ix+00eh),a		;4eaf
	ret			;4eb2
el_tipo_0x27:
	xor a			;4eb3   ; cada cuadro: sin velocidad vertical...
	ld (ix+008h),a		;4eb4   ; guarda la velocidad vertical
	ld (ix+007h),a		;4eb7   ; guarda la velocidad vertical (parte baja)
	ld de,0ffe0h		;4eba   ; ... y a -0x20, a la izquierda
	jp 0a56ch		;4ebd   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
crea_los_tipos_0x28_y_0x29:
	ld c,028h		;4ec0   ; el 0x28 en (0x90, 0x38)...
	ld de,09038h		;4ec2
	call crea_una_cosa		;4ec5   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
	ld c,029h		;4ec8   ; ... y el 0x29 en (0x30, 0x68)
	ld de,03068h		;4eca
	jp crea_una_cosa		;4ecd   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
nacen_los_tipos_0x28_y_0x29:
	ld hl,0ffe0h		;4ed0   ; el 0x28: -0x20 en horizontal...
	ld de,00000h		;4ed3   ; ... y nada en vertical
	bit 0,(ix+000h)		;4ed6   ; el 0x29 (bit 0 del tipo)...
	jr z,L_4EE2		;4eda
	ld hl,00020h		;4edc   ; ... 0x20 en horizontal y -0x10 en vertical
	ld de,0fff0h		;4edf
L_4EE2:
	call 0a55dh		;4ee2   ; pon_velocidad_y: velocidad vertical de la cosa ((ix+7), (ix+8)) = DE
	ex de,hl			;4ee5
	call 0a56ch		;4ee6   ; pon_velocidad_x: velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE
	ld (ix+006h),001h		;4ee9   ; se mueve...
	ld (ix+00bh),092h		;4eed   ; ... con el dibujo 0x92
	xor a			;4ef1
	ld (ix+010h),a		;4ef2
	ld (ix+00eh),a		;4ef5
	ret			;4ef8
los_tipos_0x28_y_0x29:
	inc (ix+010h)		;4ef9   ; cada cuatro cuadros...
	ld a,(ix+010h)		;4efc
	cp 004h		;4eff
	ret nz			;4f01
	ld (ix+010h),000h		;4f02
	inc (ix+011h)		;4f06   ; ... el dibujo 0x92...
	ld (ix+00bh),092h		;4f09   ; el dibujo de la cosa = 0x92
	bit 0,(ix+011h)		;4f0d   ; ... o el 0x93
	ret z			;4f11
	ld (ix+00bh),093h		;4f12   ; el dibujo de la cosa = 0x93
	ret			;4f16
crea_el_tipo_0x2a:
	ld c,02ah		;4f17   ; EL TIPO 0x2A en (0xF0, 0xC0)
	ld de,0f0c0h		;4f19
	jp crea_una_cosa		;4f1c   ; crea_una_cosa: crea una cosa del tipo C en la posicion DE
nace_el_tipo_0x2a:
	ld (ix+00bh),098h		;4f1f   ; al nacer: el dibujo 0x98...
	xor a			;4f23
	ld (ix+001h),a		;4f24   ; ... paso 0...
	ld (ix+013h),a		;4f27
	ld (ix+014h),a		;4f2a
	ld (ix+00eh),a		;4f2d
	ld (ix+006h),001h		;4f30   ; ... y se mueve
	ret			;4f34
el_tipo_0x2a:
	ld a,(ix+001h)		;4f35   ; paso 1?
	dec a			;4f38
	jr z,el_tipo_0x2a_quieto		;4f39
	call anda_el_tipo_0x2a		;4f3b   ; paso 0: anda...
	xor a			;4f3e
	ld (ix+00ah),0ffh		;4f3f   ; ... a -0x80, a la izquierda...
	ld (ix+009h),080h		;4f43   ; la velocidad horizontal (parte baja) = 0x80
	ld (ix+008h),a		;4f47   ; guarda la velocidad vertical
	ld (ix+007h),a		;4f4a   ; guarda la velocidad vertical (parte baja)
	ld a,(ix+005h)		;4f4d   ; ... hasta la x 0x80
	cp 080h		;4f50
	ret nc			;4f52
	inc (ix+001h)		;4f53   ; entonces, el paso 1
	ret			;4f56
el_tipo_0x2a_quieto:
	ld (ix+006h),000h		;4f57   ; paso 1: quieto con el dibujo 0x97
	ld (ix+00bh),097h		;4f5b   ; el dibujo de la cosa = 0x97
	ret			;4f5f
anda_el_tipo_0x2a:
	ld a,(ix+014h)		;4f60   ; 0x90 mas en la cuenta de pasos...
	add a,090h		;4f63
	ld (ix+014h),a		;4f65
	jr nc,L_4F6D		;4f68   ; ... y con el acarreo, un paso
	inc (ix+013h)		;4f6a
L_4F6D:
	ld a,(ix+013h)		;4f6d   ; uno de los cuatro dibujos de 0x4F7F, por el paso
	rra			;4f70
	rra			;4f71
	and 003h		;4f72
	ld hl,04f7fh		;4f74
	call hl_mas_a		;4f77   ; hl_mas_a: HL += A
	ld a,(hl)			;4f7a
	ld (ix+00bh),a		;4f7b   ; guarda el dibujo de la cosa
	ret			;4f7e

; ----------------------------------------------------------------------
; DATOS cuatro_pasos: los cuatro dibujos por los que pasa (ix+0x0B): p00:4F74
;   los elige con los bits 2-3 de la cuenta de (ix+0x13)
;   0x4f7f..0x4f83  (4 bytes)
DATA_cuatro_pasos:
	defb 098h,099h,09ah,099h	; 4f7f

; ======================================================================
; CODIGO 0x4f83..0x5156  (467 bytes)
; ======================================================================


monta_esta_habitacion:
	ld hl,0d100h		;4f83   ; al bufer de 0xD100...
	ld a,(0d000h)		;4f86   ; ... la fase...
	ld b,a			;4f89
	ld a,(0d001h)		;4f8a   ; ... y la habitacion de ahora
	ld c,a			;4f8d
	jp monta_la_habitacion_bc		;4f8e

; ----------------------------------------------------------------------
; PINTA LA HABITACION del bufer (desde 0xD140: 22 filas de 32 celdas) en la pantalla, desde (0, 0x20), dibujo a dibujo.
; ----------------------------------------------------------------------
pinta_la_habitacion:
	ld hl,0d140h		;4f91   ; desde la fila 2 del bufer...
	ld de,00020h		;4f94   ; ... en (0, 0x20)...
	ld b,016h		;4f97   ; ... 22 filas
L_4F99:
	push bc			;4f99
	ld b,020h		;4f9a   ; de 32 celdas
pinta_una_celda:
	ld a,(hl)			;4f9c   ; el dibujo de la celda...
	call pinta_el_dibujo		;4f9d   ; ... a la pantalla
	inc hl			;4fa0
	ld a,d			;4fa1   ; ocho puntos a la derecha
	add a,008h		;4fa2
	ld d,a			;4fa4
	djnz pinta_una_celda		;4fa5
	pop bc			;4fa7
	ld a,e			;4fa8   ; la fila siguiente, ocho mas abajo
	add a,008h		;4fa9
	ld e,a			;4fab
	djnz L_4F99		;4fac
	ret			;4fae
monta_la_habitacion_bc:
	ld (0c5d5h),hl		;4faf   ; guarda el destino del montaje de la habitacion
	ld (0c5d7h),bc		;4fb2   ; guarda la habitacion que se monta

; ----------------------------------------------------------------------
; MONTA LA HABITACION en el bufer de DE (0xC5D5): la habitacion son 8 x 6 bloques de 32 x 32 puntos, y cada bloque, 4 x 4 celdas de dibujo. El bufer tiene 32 celdas por fila: tras cada fila de ocho bloques se saltan 0x60 (tres filas de celdas mas). Con 0xC41A puesto la habitacion es la de 0x614B y los bloques los de 0xA041.
; ----------------------------------------------------------------------
monta_la_habitacion:
	di			;4fb6   ; los bancos del mapa, 11-12-13, con su copia
	ld hl,0f0f1h		;4fb7   ; apunta a la copia del banco de 0x6000
	ld a,00bh		;4fba   ; el 11
	ld (06000h),a		;4fbc   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4fbf
	inc l			;4fc0
	inc a			;4fc1   ; el 12
	ld (08000h),a		;4fc2   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;4fc5
	inc l			;4fc6
	inc a			;4fc7   ; el 13
	ld (0a000h),a		;4fc8   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;4fcb
	ei			;4fcc
	ld a,(0c41ah)		;4fcd   ; lee la habitacion especial
	ld hl,0614bh		;4fd0   ; la habitacion especial
	and a			;4fd3   ; puesta?
	jr nz,L_4FF0		;4fd4   ; si: esa
	ld a,(0c5d8h)		;4fd6   ; lee la fase de la habitacion que se monta
	ld hl,06000h		;4fd9   ; la primera habitacion de cada fase
	call hl_mas_a		;4fdc   ; hl_mas_a: HL += A
	ld l,(hl)			;4fdf   ; la de esta fase
	ld a,(0c5d7h)		;4fe0   ; lee la habitacion que se monta
	add a,l			;4fe3   ; + la habitacion
	ld h,000h		;4fe4
	ld l,a			;4fe6   ; su numero en el castillo
	add hl,hl			;4fe7   ; dos bytes por habitacion
	ld de,06013h		;4fe8   ; la tabla de habitaciones
	add hl,de			;4feb
	ld e,(hl)			;4fec   ; sus 8 x 6 bloques
	inc hl			;4fed
	ld d,(hl)			;4fee
	ex de,hl			;4fef
L_4FF0:
	ld de,(0c5d5h)		;4ff0   ; lee el destino del montaje de la habitacion
	ld a,006h		;4ff4   ; seis filas de bloques
L_4FF6:
	ex af,af'			;4ff6
	ld b,008h		;4ff7   ; ocho bloques por fila
L_4FF9:
	ld a,(hl)			;4ff9   ; el bloque
	push de			;4ffa
	exx			;4ffb   ; (los registros de la habitacion, a un lado)
	push af			;4ffc   ; el numero de bloque, a guardar
	ld a,(0c41ah)		;4ffd   ; lee la habitacion especial
	and a			;5000   ; habitacion especial?
	ld bc,0a041h		;5001   ; sus bloques
	jr nz,L_5013		;5004
	ld a,(0c5d8h)		;5006   ; lee la fase de la habitacion que se monta
	add a,a			;5009   ; los de la fase:
	ld hl,07ebbh		;500a   ; el juego de bloques de cada fase
	call hl_mas_a		;500d   ; hl_mas_a: HL += A
	ld c,(hl)			;5010
	inc hl			;5011
	ld b,(hl)			;5012
L_5013:
	pop af			;5013   ; el numero de bloque
	ld h,000h		;5014
	ld l,a			;5016
	add hl,hl			;5017   ; 16 bytes por bloque
	add hl,hl			;5018
	add hl,hl			;5019
	add hl,hl			;501a
	add hl,bc			;501b   ; HL = el bloque
	ld bc,01cffh		;501c   ; B = 0x1C: de una fila a la siguiente del bufer (32 - 4)
	pop de			;501f
	ldi		;5020   ; la primera fila del bloque, cuatro celdas
	ldi		;5022
	ldi		;5024
	ldi		;5026
	ld a,b			;5028   ; la fila siguiente del bufer
	add a,e			;5029
	ld e,a			;502a
	ldi		;502b   ; la segunda
	ldi		;502d
	ldi		;502f
	ldi		;5031
	ld a,b			;5033
	add a,e			;5034
	ld e,a			;5035
	ldi		;5036   ; la tercera
	ldi		;5038
	ldi		;503a
	ldi		;503c
	ld a,b			;503e
	add a,e			;503f
	ld e,a			;5040
	ldi		;5041   ; la cuarta
	ldi		;5043
	ldi		;5045
	ldi		;5047
	exx			;5049   ; (los registros de la habitacion)
	inc hl			;504a   ; el bloque siguiente
	inc e			;504b   ; cuatro celdas a la derecha en el bufer
	inc e			;504c
	inc e			;504d
	inc de			;504e
	djnz L_4FF9		;504f   ; ocho bloques
	ex de,hl			;5051
	ld bc,00060h		;5052   ; la fila de bloques siguiente: 0x60 mas (tres filas de celdas)
	add hl,bc			;5055
	ex de,hl			;5056
	ex af,af'			;5057
	dec a			;5058   ; seis filas de bloques
	jp nz,L_4FF6		;5059
	di			;505c   ; y vuelven los bancos 1, 2 y 3
	push hl			;505d
	ld hl,0f0f1h		;505e   ; apunta a la copia del banco de 0x6000
	ld a,001h		;5061   ; el 1
	ld (06000h),a		;5063   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;5066
	inc a			;5067   ; el 2
	ld (08000h),a		;5068   ; el mapper: pone en 0x8000 el banco de A
	inc hl			;506b
	ld (hl),a			;506c
	inc a			;506d   ; el 3
	ld (0a000h),a		;506e   ; el mapper: pone en 0xA000 el banco de A
	inc hl			;5071
	ld (hl),a			;5072
	pop hl			;5073
	ei			;5074
	ret			;5075

; ----------------------------------------------------------------------
; INICIA EL SONIDO: el mezclador con los tres tonos abiertos (0xBC) y todos los canales a la rutina de reposo. 0x5085 es la parte que se usa tambien para callarlo todo (sonido 0).
; ----------------------------------------------------------------------
inicia_el_sonido:
	ld a,0bch		;5076   ; 0xBC: tonos abiertos, ruidos cerrados, el puerto A de entrada (los mandos)
	ld (0c097h),a		;5078   ; guarda la copia del registro 7 del PSG (el mezclador)
	xor a			;507b   ; sin fundido
	ld (0c0a5h),a		;507c   ; guarda la cuenta del fundido de la musica
	ld (0c0a6h),a		;507f   ; guarda el volumen que se le resta a la musica
	ld (0c0a7h),a		;5082
sonido_en_reposo:
	xor a			;5085   ; sin efecto sonando
	ld (0c096h),a		;5086   ; guarda la prioridad del efecto que suena
	ld (0c098h),a		;5089   ; guarda las banderas del sonido (bit 0 pausa, bit 1 ...)
	ld (0c0a8h),a		;508c
	ld hl,089ceh		;508f   ; los cuatro manejadores a canal_en_reposo
	ld (0c010h),hl		;5092   ; guarda el manejador del canal A del sonido
	ld (0c012h),hl		;5095   ; guarda el manejador del canal B
	ld (0c014h),hl		;5098   ; guarda el manejador del canal C
	ld (0c016h),hl		;509b   ; guarda el manejador del efecto de sonido
L_509E:
	ret			;509e   ; (este `ret` hace tambien de manejador vacio: p00:511C lo pone en el canal de los efectos)

; ----------------------------------------------------------------------
; SONIDO: el numero en A. 0 lo calla todo; 0x80-0xFA es una musica (tres canales, tabla de 0x8DC9); 1-0x7F un efecto, que solo suena si su numero no es menor que el del que ya suena (0xC096 hace de prioridad); 0xFB y 0xFC ponen y quitan el segundo efecto (0x948B) guardando lo que habia; 0xFD y 0xFE hacen lo mismo con la musica de la pausa (0x9463); 0xFF funde la musica. Todo con los bancos 14 y 15, que al final se cambian por 1, 2 y 3.
; ----------------------------------------------------------------------
sonido:
	push hl			;509f   ; lo guarda todo
	push de			;50a0
	push bc			;50a1
	push af			;50a2
	di			;50a3   ; los bancos del sonido, con su copia
	ld a,00eh		;50a4   ; el 14
	ld (08000h),a		;50a6   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;50a9   ; guarda la copia del banco de 0x8000
	ei			;50ac
	di			;50ad
	ld a,00fh		;50ae   ; el 15
	ld (0a000h),a		;50b0   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;50b3   ; guarda la copia del banco de 0xA000
	ei			;50b6
	pop af			;50b7   ; el numero
	di			;50b8
	or a			;50b9   ; 0: callarlo todo
	jp z,L_51A4		;50ba
	cp 0fbh		;50bd   ; 0xFB en adelante: las ordenes especiales
	jp nc,L_51AA		;50bf
	or a			;50c2
	jp p,L_516A		;50c3   ; bit 7 a cero: un efecto
	ld de,0c01ch		;50c6   ; una MUSICA: los tres canales, limpios
	ld hl,05156h		;50c9   ; con los 20 bytes del canal en reposo
	ld bc,00014h		;50cc
	ldir		;50cf
	ld hl,05156h		;50d1   ; el segundo canal (0xC030)
	ld bc,00014h		;50d4
	ldir		;50d7
	ld hl,05156h		;50d9   ; el tercero (0xC044)
	ld bc,00014h		;50dc
	ldir		;50df
	and 07fh		;50e1   ; el numero de musica
	rlca			;50e3   ; por dos...
	ld e,a			;50e4
	rlca			;50e5   ; ... y por cuatro: por seis
	add a,e			;50e6
	ld hl,08dc9h		;50e7   ; la tabla de musicas
	add a,l			;50ea
	ld l,a			;50eb
	jr nc,L_50EF		;50ec
	inc h			;50ee
L_50EF:
	ld e,(hl)			;50ef   ; la partitura del canal A
	inc hl			;50f0
	ld d,(hl)			;50f1
	inc hl			;50f2
	ld (0c01ch),de		;50f3   ; a su ficha
	ld e,(hl)			;50f7   ; la del canal B
	inc hl			;50f8
	ld d,(hl)			;50f9
	inc hl			;50fa
	ld (0c030h),de		;50fb   ; a su ficha
	ld e,(hl)			;50ff   ; la del canal C
	inc hl			;5100
	ld d,(hl)			;5101
	ld (0c044h),de		;5102   ; a su ficha
	ld hl,08a64h		;5106   ; los manejadores de los tres canales
	ld (0c010h),hl		;5109   ; guarda el manejador del canal A del sonido
	ld hl,08a6bh		;510c
	ld (0c012h),hl		;510f   ; guarda el manejador del canal B
	ld hl,08a72h		;5112
	ld (0c014h),hl		;5115   ; guarda el manejador del canal C
	xor a			;5118   ; ningun efecto
	ld (0c096h),a		;5119   ; guarda la prioridad del efecto que suena
	ld hl,l509eh		;511c   ; y el de los efectos, a un `ret`
	ld (0c016h),hl		;511f   ; guarda el manejador del efecto de sonido
	ld a,(0c098h)		;5122   ; quita el bit 1 de las banderas
	and 0fdh		;5125
	ld (0c098h),a		;5127   ; guarda las banderas del sonido (bit 0 pausa, bit 1 ...)
L_512A:
	xor a			;512a   ; sin fundido
	ld (0c0a5h),a		;512b   ; guarda la cuenta del fundido de la musica
	ld (0c0a6h),a		;512e   ; guarda el volumen que se le resta a la musica
	ld (0c0a8h),a		;5131
	ld a,007h		;5134   ; la cuenta de 0xC0A7 a 7
	ld (0c0a7h),a		;5136
L_5139:
	di			;5139   ; y se vuelven a poner los bancos 1, 2 y 3
	push hl			;513a
	ld hl,0f0f1h		;513b   ; apunta a la copia del banco de 0x6000
	ld a,001h		;513e   ; el 1 en 0x6000
	ld (06000h),a		;5140   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;5143   ; y en su copia
	inc a			;5144   ; el 2 en 0x8000
	ld (08000h),a		;5145   ; el mapper: pone en 0x8000 el banco de A
	inc hl			;5148
	ld (hl),a			;5149   ; y en su copia
	inc a			;514a   ; el 3 en 0xA000
	ld (0a000h),a		;514b   ; el mapper: pone en 0xA000 el banco de A
	inc hl			;514e
	ld (hl),a			;514f   ; y en su copia
	pop hl			;5150
	ei			;5151
	pop bc			;5152   ; lo que se guardo al entrar
	pop de			;5153
	pop hl			;5154
	ret			;5155

; ----------------------------------------------------------------------
; DATOS canal_en_reposo: los 20 bytes con los que se limpia un canal de
;   sonido: p00:50C9, 50D1, 50D9, 5183, 521C y 52B8 los copian a 0xC01C,
;   0xC030, 0xC044, 0xC058, 0xC080 y 0xC06C antes de arrancar una musica o un
;   efecto
;   0x5156..0x516a  (20 bytes)
DATA_canal_en_reposo:
	defb 000h,000h,001h,000h,000h,000h,000h,000h,000h,001h,000h,000h,000h,000h,001h,001h	; 5156  ................
	defb 000h,000h,000h,000h	; 5166

; ======================================================================
; CODIGO 0x516a..0x5421  (695 bytes)
; ======================================================================


L_516A:
	ld c,a			;516a   ; un EFECTO: su numero en C
	ld a,(0c0a8h)		;516b   ; hay algo que no deja?
	or a			;516e
	jp nz,L_5139		;516f   ; si: no suena
	ld a,(0c096h)		;5172   ; lee la prioridad del efecto que suena
	cp c			;5175   ; comparado con el que suena
	jp z,L_517C		;5176   ; el mismo: vuelve a empezar
	jp nc,L_5139		;5179   ; menor: no lo pisa
L_517C:
	ld a,c			;517c   ; este pasa a ser el que suena
	ld (0c096h),a		;517d   ; guarda la prioridad del efecto que suena
	ld de,0c058h		;5180   ; la ficha del canal de efectos, limpia
	ld hl,05156h		;5183
	ld bc,00014h		;5186
	ldir		;5189
	rlca			;518b   ; por dos
	ld hl,08d8dh		;518c   ; la tabla de efectos (desde el 1)
	add a,l			;518f
	ld l,a			;5190
	jr nc,L_5194		;5191
	inc h			;5193
L_5194:
	ld e,(hl)			;5194   ; su guion
	inc hl			;5195
	ld d,(hl)			;5196
	ld (0c064h),de		;5197   ; a la ficha
	ld hl,08c9ch		;519b   ; y el manejador de los efectos
	ld (0c016h),hl		;519e   ; guarda el manejador del efecto de sonido
	jp L_5139		;51a1
L_51A4:
	call sonido_en_reposo		;51a4   ; el 0: todo callado
	jp L_5139		;51a7
L_51AA:
	jp z,L_5276		;51aa   ; 0xFB
	cp 0fch		;51ad
	jp z,L_52C9		;51af   ; 0xFC
	cp 0fdh		;51b2
	jp z,L_51C4		;51b4   ; 0xFD: la musica de la pausa
	cp 0feh		;51b7
	jp z,L_522D		;51b9   ; 0xFE: se vuelve de la pausa
	ld a,03ah		;51bc   ; 0xFF: el fundido, 0x3A cuadros
	ld (0c0a5h),a		;51be   ; guarda la cuenta del fundido de la musica
	jp L_5139		;51c1
L_51C4:
	ld a,(0c098h)		;51c4   ; lee las banderas del sonido (bit 0 pausa, bit 1 ...)
	or 001h		;51c7   ; el bit 0 de las banderas: en la pausa
	ld (0c098h),a		;51c9   ; guarda las banderas del sonido (bit 0 pausa, bit 1 ...)
	ld a,(0c0a5h)		;51cc   ; lee la cuenta del fundido de la musica
	ld (0c099h),a		;51cf   ; guarda el fundido
	ld a,(0c0a6h)		;51d2   ; lee el volumen que se le resta a la musica
	ld (0c09ah),a		;51d5   ; el volumen restado
	ld a,(0c097h)		;51d8   ; lee la copia del registro 7 del PSG (el mezclador)
	ld (0c09bh),a		;51db   ; el mezclador
	ld a,0bfh		;51de   ; un mezclador nuevo: solo el tono A
	ld (0c097h),a		;51e0   ; guarda la copia del registro 7 del PSG (el mezclador)
	xor a			;51e3   ; guarda los periodos y volumenes que hay en el PSG:
	call 00096h		;51e4   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c09ch),a		;51e7   ; el periodo fino del canal A
	ld a,001h		;51ea   ; el grueso
	call 00096h		;51ec   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c09dh),a		;51ef
	ld a,008h		;51f2   ; el volumen del A
	call 00096h		;51f4   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c09eh),a		;51f7
	ld a,009h		;51fa   ; el del B
	call 00096h		;51fc   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c09fh),a		;51ff
	ld a,00ah		;5202   ; el del C
	call 00096h		;5204   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a0h),a		;5207
	xor a			;520a   ; el canal 0...
	ld (0c094h),a		;520b   ; guarda el canal del PSG que se esta tocando
	ld a,005h		;520e   ; ... con el numero 5
	ld (0c095h),a		;5210   ; guarda el numero de canal
	ld hl,08a5dh		;5213   ; el manejador de la musica de la pausa
	ld (0c01ah),hl		;5216   ; guarda el manejador de la musica de la pausa
	ld de,0c080h		;5219   ; su ficha, limpia
	ld hl,05156h		;521c
	ld bc,00014h		;521f
	ldir		;5222
	ld hl,09463h		;5224   ; y su partitura
	ld (0c080h),hl		;5227
	jp L_512A		;522a
L_522D:
	ld a,(0c098h)		;522d   ; lee las banderas del sonido (bit 0 pausa, bit 1 ...)
	and 0feh		;5230   ; fuera la pausa de las banderas
	ld (0c098h),a		;5232   ; guarda las banderas del sonido (bit 0 pausa, bit 1 ...)
	ld a,(0c099h)		;5235   ; y se devuelve todo lo guardado
	ld (0c0a5h),a		;5238   ; guarda la cuenta del fundido de la musica
	ld a,(0c09ah)		;523b
	ld (0c0a6h),a		;523e   ; guarda el volumen que se le resta a la musica
	ld a,(0c09bh)		;5241
	ld (0c097h),a		;5244   ; guarda la copia del registro 7 del PSG (el mezclador)
	ld a,(0c09ch)		;5247   ; el periodo fino del A
	ld e,a			;524a
	xor a			;524b   ; registro 0
	call 00093h		;524c   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c09dh)		;524f   ; el grueso
	ld e,a			;5252
	ld a,001h		;5253   ; registro 1
	call 00093h		;5255   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c09eh)		;5258   ; el volumen del A
	ld e,a			;525b
	ld a,008h		;525c   ; registro 8
	call 00093h		;525e   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c09fh)		;5261   ; el del B
	ld e,a			;5264
	ld a,009h		;5265   ; registro 9
	call 00093h		;5267   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a0h)		;526a   ; el del C
	ld e,a			;526d
	ld a,00ah		;526e   ; registro 10
	call 00093h		;5270   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_5139		;5273
L_5276:
	ld a,(0c098h)		;5276   ; lee las banderas del sonido (bit 0 pausa, bit 1 ...)
	or 002h		;5279   ; 0xFB: el bit 1 de las banderas
	ld (0c098h),a		;527b   ; guarda las banderas del sonido (bit 0 pausa, bit 1 ...)
	ld a,(0c097h)		;527e   ; lee la copia del registro 7 del PSG (el mezclador)
	ld (0c0a1h),a		;5281   ; guarda el mezclador
	ld a,(0c096h)		;5284   ; lee la prioridad del efecto que suena
	or a			;5287   ; hay efecto sonando?
	jp nz,L_5290		;5288
	ld a,0bfh		;528b   ; no: solo el tono A
	jp L_5295		;528d
L_5290:
	ld a,(0c097h)		;5290   ; lee la copia del registro 7 del PSG (el mezclador)
	or 01bh		;5293   ; si: se le abren mas canales
L_5295:
	ld (0c097h),a		;5295   ; guarda la copia del registro 7 del PSG (el mezclador)
	xor a			;5298   ; guarda el periodo del canal A...
	call 00096h		;5299   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a2h),a		;529c
	ld a,001h		;529f
	call 00096h		;52a1   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a3h),a		;52a4
	ld a,008h		;52a7   ; ... y su volumen
	call 00096h		;52a9   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a4h),a		;52ac
	ld hl,08c95h		;52af   ; el manejador del segundo efecto
	ld (0c018h),hl		;52b2   ; guarda el manejador del segundo efecto
	ld de,0c06ch		;52b5   ; su ficha, limpia
	ld hl,05156h		;52b8
	ld bc,00014h		;52bb
	ldir		;52be
	ld hl,0948bh		;52c0   ; y su guion
	ld (0c078h),hl		;52c3
	jp L_5139		;52c6
L_52C9:
	ld a,(0c098h)		;52c9   ; lee las banderas del sonido (bit 0 pausa, bit 1 ...)
	and 0fdh		;52cc   ; 0xFC: fuera el bit 1
	ld (0c098h),a		;52ce   ; guarda las banderas del sonido (bit 0 pausa, bit 1 ...)
	ld a,(0c096h)		;52d1   ; lee la prioridad del efecto que suena
	or a			;52d4   ; habia efecto?
	ld a,(0c0a1h)		;52d5   ; el mezclador guardado
	jp z,L_52E9		;52d8
	ld b,a			;52db
	ld a,(0c097h)		;52dc   ; lee la copia del registro 7 del PSG (el mezclador)
	or 0dbh		;52df   ; se mezcla con el de ahora...
	and b			;52e1
	ld b,a			;52e2
	ld a,(0c097h)		;52e3   ; lee la copia del registro 7 del PSG (el mezclador)
	and 024h		;52e6   ; ... dejando los bits del efecto
	or b			;52e8
L_52E9:
	ld (0c097h),a		;52e9   ; guarda la copia del registro 7 del PSG (el mezclador)
	ld a,(0c0a2h)		;52ec   ; y se devuelve el canal A
	ld e,a			;52ef
	xor a			;52f0   ; registro 0
	call 00093h		;52f1   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a3h)		;52f4
	ld e,a			;52f7
	ld a,001h		;52f8   ; registro 1
	call 00093h		;52fa   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a4h)		;52fd   ; su volumen
	ld e,a			;5300
	ld a,008h		;5301
	call 00093h		;5303   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_5139		;5306
L_5309:
	ld a,(0c0a6h)		;5309   ; lee el volumen que se le resta a la musica
	cp 0f8h		;530c
	ret			;530e
L_530F:
	call bancos_11_12_13		;530f   ; bancos_11_12_13: pone los bancos del mapa (11, 12 y 13)
	ld hl,0be59h		;5312
	ld de,00800h		;5315
	ld bc,00d01h		;5318
	call sube_letras		;531b   ; sube_letras: B caracteres de 1 bit de HL, pintados de color
	ld hl,0bec1h		;531e
	ld de,07000h		;5321
	ld bc,00d02h		;5324
	call sube_letras		;5327   ; sube_letras: B caracteres de 1 bit de HL, pintados de color
	ld hl,0bf29h		;532a
	ld de,0d800h		;532d
	ld bc,01a03h		;5330
	call sube_letras		;5333   ; sube_letras: B caracteres de 1 bit de HL, pintados de color
bancos_1_2_3:
	di			;5336
	push hl			;5337
	ld hl,0f0f1h		;5338   ; apunta a la copia del banco de 0x6000
	ld a,001h		;533b
	ld (06000h),a		;533d   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;5340
	inc a			;5341
	ld (08000h),a		;5342   ; el mapper: pone en 0x8000 el banco de A
	inc hl			;5345
	ld (hl),a			;5346
	inc a			;5347
	ld (0a000h),a		;5348   ; el mapper: pone en 0xA000 el banco de A
	inc hl			;534b
	ld (hl),a			;534c
	pop hl			;534d
	ei			;534e
	ret			;534f
bancos_14_15:
	di			;5350
	ld hl,0f0f2h		;5351   ; apunta a la copia del banco de 0x8000
	ld a,00eh		;5354
	ld (08000h),a		;5356   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;5359
	inc l			;535a
	inc a			;535b
	ld (0a000h),a		;535c   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;535f
	ei			;5360
	ret			;5361
bancos_11_12_13:
	di			;5362
	ld hl,0f0f1h		;5363   ; apunta a la copia del banco de 0x6000
	ld a,00bh		;5366
	ld (06000h),a		;5368   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;536b
	inc l			;536c
	inc a			;536d
	ld (08000h),a		;536e   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;5371
	inc l			;5372
	inc a			;5373
	ld (0a000h),a		;5374   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;5377
	ei			;5378
	ret			;5379
bancos_9_10:
	di			;537a
	ld hl,0f0f2h		;537b   ; apunta a la copia del banco de 0x8000
	ld a,009h		;537e
	ld (08000h),a		;5380   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;5383
	inc l			;5384
	inc a			;5385
	ld (0a000h),a		;5386   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;5389
	ei			;538a
	ret			;538b
bancos_7_8:
	di			;538c
	ld hl,0f0f2h		;538d   ; apunta a la copia del banco de 0x8000
	ld a,007h		;5390
	ld (08000h),a		;5392   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;5395
	inc l			;5396
	inc a			;5397
	ld (0a000h),a		;5398   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;539b
	ei			;539c
	ret			;539d
bancos_4_5_6:
	di			;539e
	ld hl,0f0f1h		;539f   ; apunta a la copia del banco de 0x6000
	ld a,004h		;53a2
	ld (06000h),a		;53a4   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;53a7
	inc l			;53a8
	inc a			;53a9
	ld (08000h),a		;53aa   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;53ad
	inc l			;53ae
	inc a			;53af
	ld (0a000h),a		;53b0   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;53b3
	ei			;53b4
	ret			;53b5

; ----------------------------------------------------------------------
; LA FUENTE, a la pagina 1: del banco 8, el caracter 0 en blanco en (0, 0), 0x30 caracteres del color 0x0E desde (0, 0x40) y un dibujo de 8 x 8 en (0x80, 0x48).
; ----------------------------------------------------------------------
sube_la_fuente:
	call bancos_7_8		;53b6   ; bancos_7_8: pone los bancos 7 y 8 en 0x8000 y 0xA000
	ld de,00000h		;53b9   ; en (0, 0)...
	ld c,000h		;53bc   ; ... del color 0: el caracter 0
	ld hl,0bed8h		;53be
	call sube_una_letra		;53c1   ; sube_una_letra: un caracter de 1 bit de HL
	ld de,00040h		;53c4   ; desde (0, 0x40)...
	ld hl,0bd80h		;53c7
	ld bc,0300eh		;53ca   ; ... 0x30 caracteres del color 0x0E
	call sube_letras		;53cd   ; sube_letras: B caracteres de 1 bit de HL, pintados de color
	ld hl,0bf00h		;53d0   ; un dibujo...
	ld de,0a440h		;53d3   ; ... en (0x80, 0x48) de la pagina 1
	ld b,001h		;53d6
	call sube_dibujos		;53d8   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
	jp bancos_1_2_3		;53db   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; MAS LETRAS, del banco 14: 0x0E caracteres en (0x80, 0x40) y 0x1A en (8, 0x48), del color 0x0E.
; ----------------------------------------------------------------------
sube_mas_letras:
	call bancos_14_15		;53de   ; bancos_14_15: pone el sonido (14 y 15) en 0x8000 y 0xA000
	ld de,08040h		;53e1
	ld hl,08824h		;53e4
	ld bc,00e0eh		;53e7
	call sube_letras		;53ea   ; sube_letras: B caracteres de 1 bit de HL, pintados de color
	ld de,00848h		;53ed
	ld hl,08894h		;53f0
	ld bc,01a0eh		;53f3
	call sube_letras		;53f6   ; sube_letras: B caracteres de 1 bit de HL, pintados de color
	jp bancos_1_2_3		;53f9   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
pinta_la_puerta_de_la_fase:
	ld (hl),001h		;53fc   ; su estado a 1
	ld de,(0c5adh)		;53fe   ; en su sitio (0xC5AD: la y, la x)...
	ld hl,05421h		;5402   ; ... las seis piezas de 0x5421...
	ld b,006h		;5405   ; ... en columna
una_pieza_de_la_puerta:
	push bc			;5407
	push de			;5408
	push hl			;5409
	ld a,(hl)			;540a   ; el dibujo de la pieza...
	inc hl			;540b
	ld h,(hl)			;540c
	ld l,a			;540d
	ld bc,00808h		;540e   ; ... 8 x 8 por HMMC en la pagina 0
	xor a			;5411
	call hmmc		;5412   ; hmmc: orden HMMC del V9938: puntos de HL a la VRAM
	pop hl			;5415
	inc hl			;5416   ; la siguiente...
	inc hl			;5417
	pop de			;5418
	ld a,e			;5419   ; ... ocho puntos mas abajo
	add a,008h		;541a
	ld e,a			;541c
	pop bc			;541d
	djnz una_pieza_de_la_puerta		;541e
	ret			;5420

; ----------------------------------------------------------------------
; DATOS tabla_5421: 6 punteros a dibujos de 8x8 que pinta p00:5412 por HMMC;
;   lo leen p00:5402 (12 bytes)
;   0x5421..0x542d  (12 bytes)
DATA_tabla_5421:
	defb 02dh,054h	; 5421
	defb 04dh,054h	; 5423
	defb 02dh,054h	; 5425
	defb 04dh,054h	; 5427
	defb 04dh,054h	; 5429
	defb 06dh,054h	; 542b

; ----------------------------------------------------------------------
; DATOS hmmc_542D: 8x8 puntos a 4 bits (32 bytes) para la orden HMMC de
;   0x498A; lo leen p00:5412 (32 bytes)
;   0x542d..0x544d  (32 bytes)
DATA_hmmc_542D:
	defb 000h,0c3h,03ch,000h,000h,0c3h,03ch,000h	; 542d  ..<...<.
	defb 00ch,0c3h,03ch,0c0h,003h,033h,033h,030h	; 5435  ..<..330
	defb 003h,033h,033h,030h,003h,033h,033h,030h	; 543d  .330.330
	defb 003h,003h,030h,030h,000h,0c3h,03ch,000h	; 5445  ..00..<.

; ----------------------------------------------------------------------
; DATOS hmmc_544D: 8x8 puntos a 4 bits (32 bytes) para la orden HMMC de
;   0x498A; lo leen p00:5412 (32 bytes)
;   0x544d..0x546d  (32 bytes)
DATA_hmmc_544D:
	defb 000h,0c3h,03ch,000h,000h,0c3h,03ch,000h	; 544d  ..<...<.
	defb 000h,0c3h,03ch,000h,000h,0c3h,03ch,000h	; 5455  ..<...<.
	defb 000h,0c3h,03ch,000h,000h,0c3h,03ch,000h	; 545d  ..<...<.
	defb 000h,0c3h,03ch,000h,000h,0c3h,03ch,000h	; 5465  ..<...<.

; ----------------------------------------------------------------------
; DATOS hmmc_546D: 8x8 puntos a 4 bits (32 bytes) para la orden HMMC de
;   0x498A; lo leen p00:5412 (32 bytes)
;   0x546d..0x548d  (32 bytes)
DATA_hmmc_546D:
	defb 000h,0c3h,03ch,000h,00ch,0c3h,03ch,0c0h	; 546d  ..<...<.
	defb 003h,033h,033h,030h,003h,033h,033h,030h	; 5475  .330.330
	defb 003h,033h,033h,030h,003h,003h,030h,030h	; 547d  .330..00
	defb 000h,0c3h,03ch,000h,000h,000h,000h,000h	; 5485  ..<.....

; ======================================================================
; CODIGO 0x548d..0x556e  (225 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LOS OBJETOS Y EL VENDEDOR, a la pagina 1: 20 dibujos de 16 x 16 desde (0, 0x50) y uno en (0x50, 0x60) (banco 10), cinco trozos por HMMC en (0x8C, 0x70) y (0x80 + 8k, 0x74), 8 de 16 x 16 en (0x60, 0x60) y 5 en (0, 0x70) (bancos 5-6), y los cinco dibujos del vendedor.
; ----------------------------------------------------------------------
sube_los_objetos:
	call bancos_9_10		;548d   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,09000h		;5490   ; de 0x9000...
	ld de,0a800h		;5493   ; ... a (0, 0x50) de la pagina 1...
	ld b,014h		;5496   ; ... veinte
	call sube_dibujos_de_16		;5498   ; sube_dibujos_de_16: B dibujos de 16x16 a 4 bits de HL
	ld hl,09a00h		;549b   ; de 0x9A00 a (0x50, 0x60), uno
	ld de,0b028h		;549e
	ld b,001h		;54a1
	call sube_dibujos_de_16		;54a3   ; sube_dibujos_de_16: B dibujos de 16x16 a 4 bits de HL
	ld hl,09a80h		;54a6   ; de 0x9A80, 8 x 4 puntos...
	ld de,08c70h		;54a9   ; ... en (0x8C, 0x70)
	ld bc,00804h		;54ac
	ld a,001h		;54af
	call hmmc		;54b1   ; hmmc: orden HMMC del V9938: puntos de HL a la VRAM
	ld de,08074h		;54b4   ; y cuatro veces el de 0x9A90, 8 x 8...
	ld b,004h		;54b7   ; ... en (0x80, 0x74), (0x88, 0x74)...
L_54B9:
	push bc			;54b9
	push de			;54ba
	ld hl,09a90h		;54bb
	ld bc,00808h		;54be
	ld a,001h		;54c1
	call hmmc		;54c3   ; hmmc: orden HMMC del V9938: puntos de HL a la VRAM
	pop de			;54c6
	pop bc			;54c7
	ld a,d			;54c8   ; ocho a la derecha
	add a,008h		;54c9
	ld d,a			;54cb
	djnz L_54B9		;54cc
	call bancos_4_5_6		;54ce   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0b9c8h		;54d1   ; de 0xB9C8, ocho en (0x60, 0x60)
	ld de,0b030h		;54d4
	ld b,008h		;54d7
	call sube_dibujos_de_16		;54d9   ; sube_dibujos_de_16: B dibujos de 16x16 a 4 bits de HL
	ld hl,0bdc8h		;54dc   ; de 0xBDC8, cinco en (0, 0x70)
	ld de,0b800h		;54df
	ld b,005h		;54e2
	call sube_dibujos_de_16		;54e4   ; sube_dibujos_de_16: B dibujos de 16x16 a 4 bits de HL
	call bancos_9_10		;54e7   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	call los_cinco_vendedores		;54ea   ; los cinco vendedores
	jp bancos_1_2_3		;54ed   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; LOS CINCO VENDEDORES, un viejo encapuchado con baston en cinco colores (32 x 32, en la fila 0xA0 de la pagina 1, x = 32 * k): un solo molde de 0xBDA7 en el que el nibble 0xF se pinta de uno de los cinco colores de 0x558E; se arma en 0xE800 y se sube en 4 x 4 dibujos de 8 x 8 (0x556E).
; ----------------------------------------------------------------------
los_cinco_vendedores:
	ld ix,0558eh		;54f0   ; los cinco colores
	ld de,0d000h		;54f4   ; en la VRAM 0xD000: (0, 0xA0) de la pagina 1
	ld b,005h		;54f7   ; cinco
un_vendedor_de_color:
	push bc			;54f9
	push de			;54fa
	call arma_el_vendedor		;54fb   ; se arma...
	call sube_el_vendedor		;54fe   ; ... y se sube
	pop de			;5501   ; la siguiente, 32 puntos mas alla
	ld a,010h		;5502
	call de_mas_a		;5504   ; de_mas_a: DE += A
	pop bc			;5507
	inc ix		;5508   ; con el color siguiente
	djnz un_vendedor_de_color		;550a
	ret			;550c
arma_el_vendedor:
	exx			;550d
	ld de,0e800h		;550e   ; en 0xE800...
	ld hl,0bda7h		;5511   ; ... desde el molde de 0xBDA7...
	ld b,000h		;5514   ; ... 256 bytes
un_byte_del_molde:
	push bc			;5516
	ld a,(hl)			;5517   ; dos puntos
	inc hl			;5518
	ld b,a			;5519   ; el de la izquierda...
	rrca			;551a
	rrca			;551b
	rrca			;551c
	rrca			;551d
	and 00fh		;551e
	cp 00fh		;5520   ; ... 0xF?
	jr nz,a_la_izquierda		;5522
	and (ix+000h)		;5524   ; si: el color de este vendedor
a_la_izquierda:
	add a,a			;5527   ; al nibble alto
	add a,a			;5528
	add a,a			;5529
	add a,a			;552a
	ld c,a			;552b
	ld a,b			;552c   ; el de la derecha...
	and 00fh		;552d
	cp 00fh		;552f   ; ... 0xF?
	jr nz,los_dos_puntos		;5531
	and (ix+000h)		;5533   ; si: el color
los_dos_puntos:
	or c			;5536   ; junto con el de la izquierda...
	ld (de),a			;5537   ; ... al molde armado
	inc de			;5538
	pop bc			;5539
	djnz un_byte_del_molde		;553a
	xor a			;553c   ; y 32 bytes a cero detras
	ld (de),a			;553d
	ld h,d			;553e
	ld l,e			;553f
	inc de			;5540
	ld bc,0001fh		;5541
	ldir		;5544
	exx			;5546
	ret			;5547
sube_el_vendedor:
	ld hl,0556eh		;5548   ; los 16 dibujos de 0x556E...
	ld b,004h		;554b   ; ... cuatro filas...
L_554D:
	push bc			;554d
	push de			;554e
	ld b,004h		;554f   ; ... de cuatro
un_dibujo_del_vendedor:
	push bc			;5551
	push hl			;5552
	ld a,(hl)			;5553   ; el dibujo, en la RAM
	inc hl			;5554
	ld h,(hl)			;5555
	ld l,a			;5556
	call sube_un_dibujo		;5557   ; a la VRAM
	ld a,004h		;555a   ; ocho puntos a la derecha
	call de_mas_a		;555c   ; de_mas_a: DE += A
	pop hl			;555f
	inc hl			;5560
	inc hl			;5561
	pop bc			;5562
	djnz un_dibujo_del_vendedor		;5563
	pop de			;5565
	ld a,d			;5566   ; la fila siguiente, ocho lineas mas abajo (0x400)
	add a,004h		;5567
	ld d,a			;5569
	pop bc			;556a
	djnz L_554D		;556b
	ret			;556d

; ----------------------------------------------------------------------
; DATOS dibujos_de_cinco_colores_en_ram: 16 punteros (4 x 4) a la RAM de
;   0xE900 en adelante: los dibujos que p00:550D coloreo y que p00:5548 sube
;   con 0x4A51
;   0x556e..0x558e  (32 bytes)
DATA_dibujos_de_cinco_colores_en_ram:
	defb 000h,0e9h,000h,0e9h,000h,0e9h,000h,0e9h,000h,0e9h,000h,0e8h,020h,0e8h,040h,0e8h	; 556e  ............ .@.
	defb 000h,0e9h,060h,0e8h,080h,0e8h,000h,0e9h,0a0h,0e8h,0c0h,0e8h,0e0h,0e8h,000h,0e9h	; 557e  ..`.............

; ----------------------------------------------------------------------
; DATOS cinco_colores: los cinco colores con los que p00:5524 pinta el dibujo
;   de 0xBDA7; lo leen p00:54F0 (5 bytes)
;   0x558e..0x5593  (5 bytes)
DATA_cinco_colores:
	defb 003h,008h,002h,00eh,00fh	; 558e

; ======================================================================
; CODIGO 0x5593..0x55d7  (68 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LOS PATRONES DEL ARMA que lleva Simon (0xC416), del banco 10: con las armas 2, 3 y 4, su rle de 0x55D7 a la VRAM 0xF8C0 y sus volteos (0x55DD-0x55E7: uno la 2, dos la 3 y la 4); con la 1 y la 5, nada.
; ----------------------------------------------------------------------
sube_el_arma:
	call bancos_9_10		;5593   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld a,(0c416h)		;5596   ; el arma...
	cp 005h		;5599   ; ... la 5...
	jr z,sube_el_arma_fin		;559b
	dec a			;559d   ; ... o la 1: nada
	jr z,sube_el_arma_fin		;559e
	dec a			;55a0   ; las demas, desde la 2...
	add a,a			;55a1
	ld hl,055d7h		;55a2   ; ... su rle de 0x55D7...
	call hl_mas_a		;55a5   ; hl_mas_a: HL += A
	ld e,(hl)			;55a8
	inc hl			;55a9
	ld d,(hl)			;55aa
	ld hl,0f8c0h		;55ab   ; ... a 0xF8C0
	call rle_a_la_vram		;55ae   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld a,(0c416h)		;55b1   ; lee el arma que lleva Simon (0, ninguna)
	cp 004h		;55b4   ; la 4 o la 3...
	jr z,dos_volteos		;55b6
	cp 003h		;55b8
	jr z,dos_volteos		;55ba
	cp 002h		;55bc   ; ... la 2...
	jr nz,sube_el_arma_fin		;55be
	ld hl,055e7h		;55c0   ; ... un volteo
	call voltea_dibujos		;55c3   ; voltea_dibujos: da la vuelta a dibujos que ya estan en la VRAM
	jr sube_el_arma_fin		;55c6
dos_volteos:
	ld hl,055ddh		;55c8   ; la 3 y la 4: dos volteos
	call voltea_dibujos		;55cb   ; voltea_dibujos: da la vuelta a dibujos que ya estan en la VRAM
	ld hl,055e2h		;55ce
	call voltea_dibujos		;55d1   ; voltea_dibujos: da la vuelta a dibujos que ya estan en la VRAM
sube_el_arma_fin:
	jp bancos_1_2_3		;55d4   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; DATOS tabla_55D7: 3 punteros a rle que lee p00:55AE; lo leen p00:55AE (6
;   bytes)
;   0x55d7..0x55dd  (6 bytes)
DATA_tabla_55D7:
	defb 04eh,0a2h	; 55d7
	defb 0c9h,0a4h	; 55d9
	defb 072h,0a2h	; 55db

; ----------------------------------------------------------------------
; DATOS tres_volteos: tres ordenes de 0x473E, cinco bytes cada una ([origen en
;   VRAM][cuantos][destino]): dan la vuelta a dibujos que ya estan en la VRAM
;   (p00:55C0, 55C8 y 55CE)
;   0x55dd..0x55ec  (15 bytes)
DATA_tres_volteos:
	defb 0c0h,0f8h,002h,080h,0f9h,000h,0f9h,002h,040h,0f9h,0c0h,0f8h,002h,000h,0f9h	; 55dd  ........@......

; ======================================================================
; CODIGO 0x55ec..0x56cf  (227 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LOS SPRITES DE LA PUERTA DE LA FASE (estado 5, p01:778F): sus patrones (rle de 0xA0EA, banco 10) a la VRAM 0xF900 y ocho sprites en la copia de 0xD600, en dos filas de cuatro sobre la puerta (0xC5AD: la y menos uno, y 0x10 mas abajo la segunda fila), con los patrones 0x20-0x2C y los colores 0x0C, 0x0D, 0x0E y 2 (0xD400).
; ----------------------------------------------------------------------
sprites_de_la_puerta:
	call bancos_9_10		;55ec   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld de,0a0eah		;55ef   ; sus patrones...
	ld hl,0f900h		;55f2   ; ... a 0xF900
	call rle_a_la_vram		;55f5   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	call bancos_1_2_3		;55f8   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
	ld hl,0d600h		;55fb   ; en la copia de los atributos...
	ld bc,00808h		;55fe   ; ... ocho, desde el sprite 0
un_sprite_de_la_puerta:
	ld de,0c5adh		;5601   ; la y de la puerta...
	ld a,b			;5604   ; ... los cuatro primeros...
	cp 005h		;5605
	ld a,(de)			;5607
	jr nc,la_y_del_sprite		;5608
	add a,010h		;560a   ; ... y los otros, 0x10 mas abajo
la_y_del_sprite:
	dec a			;560c   ; (menos uno)
	ld (hl),a			;560d
	inc hl			;560e   ; la x de la puerta
	inc de			;560f
	ld a,(de)			;5610
	ld (hl),a			;5611
	inc hl			;5612
	ld a,c			;5613   ; el patron: 0x20, 0x24, 0x28, 0x2C...
	and 00bh		;5614
	add a,a			;5616
	add a,a			;5617
	ld (hl),a			;5618
	inc c			;5619   ; el siguiente
	inc hl			;561a
	inc hl			;561b
	djnz un_sprite_de_la_puerta		;561c
	ld hl,0d400h		;561e   ; sus colores: los sprites 0 y 4, el 0x0C...
	ld c,00ch		;5621
	call color_de_dos_sprites		;5623
	ld hl,0d410h		;5626   ; ... 1 y 5, el 0x0D...
	ld c,00dh		;5629
	call color_de_dos_sprites		;562b
	ld hl,0d420h		;562e   ; ... 2 y 6, el 0x0E...
	ld c,00eh		;5631
	call color_de_dos_sprites		;5633
	ld hl,0d430h		;5636   ; ... 3 y 7, el 2
	ld c,002h		;5639
color_de_dos_sprites:
	ld d,h			;563b   ; y el mismo cuatro sprites mas alla (0x40)
	ld e,l			;563c
	ld a,040h		;563d
	call de_mas_a		;563f   ; de_mas_a: DE += A
	ld b,010h		;5642   ; dieciseis lineas
color_de_una_linea:
	ld a,c			;5644   ; el color C...
	ld (hl),a			;5645   ; ... en los dos
	ld (de),a			;5646
	inc hl			;5647
	inc de			;5648
	djnz color_de_una_linea		;5649
	ret			;564b
sube_los_dibujos_de_la_fase:
	call bancos_4_5_6		;564c   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld a,(0d000h)		;564f   ; la fase...
	cp 00dh		;5652   ; ... desde la 13, bancos 7 y 8
	call nc,bancos_7_8		;5654   ; bancos_7_8: pone los bancos 7 y 8 en 0x8000 y 0xA000
	ld a,(0d000h)		;5657   ; sus dibujos, de 0x5742
	add a,a			;565a
	ld hl,05742h		;565b
	call hl_mas_a		;565e   ; hl_mas_a: HL += A
	ld e,(hl)			;5661
	inc hl			;5662
	ld d,(hl)			;5663
	ex de,hl			;5664
sube_191_dibujos:
	ld de,08004h		;5665   ; desde (8, 0) de la pagina 1...
	ld b,0bfh		;5668   ; ... 0xBF dibujos
	call sube_dibujos		;566a   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
	jp bancos_1_2_3		;566d   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
sube_los_dibujos_del_banco_9:
	call bancos_9_10		;5670   ; los de 0x8000 del banco 9
	ld hl,08000h		;5673
	jr sube_191_dibujos		;5676

; ----------------------------------------------------------------------
; LOS PATRONES DE SPRITES DE SIEMPRE, del banco 13: nueve rle a la VRAM, de 0xF800 a 0xFA00 de 0x40 en 0x40.
; ----------------------------------------------------------------------
sube_los_patrones_de_siempre:
	call bancos_11_12_13		;5678   ; bancos_11_12_13: pone los bancos del mapa (11, 12 y 13)
	ld hl,0f800h		;567b
	ld de,0a319h		;567e
	call rle_a_la_vram		;5681   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld hl,0f840h		;5684
	ld de,0a351h		;5687
	call rle_a_la_vram		;568a   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld hl,0f880h		;568d
	ld de,0a38ch		;5690
	call rle_a_la_vram		;5693   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld hl,0f8c0h		;5696
	ld de,0a3cah		;5699
	call rle_a_la_vram		;569c   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld hl,0f900h		;569f
	ld de,0a40bh		;56a2
	call rle_a_la_vram		;56a5   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld hl,0f940h		;56a8
	ld de,0a447h		;56ab
	call rle_a_la_vram		;56ae   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld hl,0f980h		;56b1
	ld de,0a480h		;56b4
	call rle_a_la_vram		;56b7   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld hl,0f9c0h		;56ba
	ld de,0a4bch		;56bd
	call rle_a_la_vram		;56c0   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld de,0b895h		;56c3
	ld hl,0fa00h		;56c6
	call rle_a_la_vram		;56c9   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	jp bancos_1_2_3		;56cc   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; DATOS codigo_sin_llamar_56CF: instrucciones que no alcanza nadie:
;   desensamblan enteras hasta un jp justo en el borde y su direccion no
;   aparece como palabra en el cartucho; lo leen nadie (18 bytes)
;   0x56cf..0x56e1  (18 bytes)
DATA_codigo_sin_llamar_56CF:
	defb 0cdh,062h,053h,011h,080h,0f8h,021h,093h,0ach,001h,080h,001h,0cdh,075h,046h,0c3h	; 56cf  .bS...!......uF.
	defb 036h,053h	; 56df

; ======================================================================
; CODIGO 0x56e1..0x5742  (97 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LOS PATRONES DE SIMON por sus poses: las piernas (0xC42E) por la tabla de 0xA281 a 0xF800 y el cuerpo (0xC42F) por la de 0xA2D1 a 0xF840.
; ----------------------------------------------------------------------
sube_los_patrones_de_simon:
	call bancos_11_12_13		;56e1   ; bancos_11_12_13: pone los bancos del mapa (11, 12 y 13)
	ld a,(0c42eh)		;56e4   ; las piernas...
	add a,a			;56e7
	ld hl,0a281h		;56e8   ; ... su rle...
	call hl_mas_a		;56eb   ; hl_mas_a: HL += A
	ld e,(hl)			;56ee
	inc hl			;56ef
	ld d,(hl)			;56f0
	ld hl,0f800h		;56f1   ; ... a 0xF800
	call rle_a_la_vram		;56f4   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld a,(0c42fh)		;56f7   ; el cuerpo...
	add a,a			;56fa
	ld hl,0a2d1h		;56fb   ; ... su rle...
	call hl_mas_a		;56fe   ; hl_mas_a: HL += A
	ld e,(hl)			;5701
	inc hl			;5702
	ld d,(hl)			;5703
	ld hl,0f840h		;5704   ; ... a 0xF840
	call rle_a_la_vram		;5707   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	jp bancos_1_2_3		;570a   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
pon_la_paleta_de_la_fase:
	call pon_la_paleta_base		;570d   ; la base...
	call bancos_9_10		;5710   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,0bea7h		;5713   ; ... y la de la fase, de 0xBEA7
	ld a,(0d000h)		;5716   ; lee la FASE (0 el patio, 1-18)
	add a,a			;5719
	call hl_mas_a		;571a   ; hl_mas_a: HL += A
	ld e,(hl)			;571d
	inc hl			;571e
	ld d,(hl)			;571f
	ex de,hl			;5720
	call pon_paleta		;5721   ; pon_paleta: lista de [color][RB][G] hasta 0xFF
	jp bancos_1_2_3		;5724   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
pon_la_paleta_base:
	call bancos_9_10		;5727   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,0bf88h		;572a   ; la de 0xBF88
	call pon_paleta		;572d   ; pon_paleta: lista de [color][RB][G] hasta 0xFF
	jp bancos_1_2_3		;5730   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
pon_la_paleta_de_la_escena:
	call pon_la_paleta_base		;5733   ; la base...
	call bancos_9_10		;5736   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,0bfa1h		;5739   ; ... y la de 0xBFA1
	call pon_paleta		;573c   ; pon_paleta: lista de [color][RB][G] hasta 0xFF
	jp bancos_1_2_3		;573f   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; DATOS dibujos_de_cada_fase: 19 punteros, uno por fase (0 el patio, 1-18): de
;   donde salen los 191 dibujos de 8x8 de su decorado; los lee p00:565B con la
;   fase de 0xD000; lo leen p00:565B (38 bytes)
;   0x5742..0x5768  (38 bytes)
DATA_dibujos_de_cada_fase:
	defb 000h,060h,020h,072h,020h,072h,020h,072h,0b3h,095h,0b3h,095h,0b3h,095h,093h,084h	; 5742  .` r r r........
	defb 093h,084h,093h,084h,073h,09eh,073h,09eh,073h,09eh,000h,080h,000h,080h,000h,080h	; 5752  ....s.s.s.......
	defb 040h,096h,040h,096h,0c0h,0a4h	; 5762

; ======================================================================
; CODIGO 0x5768..0x5b0b  (931 bytes)
; ======================================================================


sube_la_bola_y_mas:
	call bancos_9_10		;5768   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,0ff00h		;576b   ; a 0xFF00...
	ld de,0a185h		;576e   ; ... el rle de 0xA185 (la bola)
	call rle_a_la_vram		;5771   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld de,0a147h		;5774   ; y a 0xF9C0 el de 0xA147
	ld hl,0f9c0h		;5777
	call rle_a_la_vram		;577a   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	jp bancos_1_2_3		;577d   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; LA CARGA DE CADA HABITACION (p01:62FB): sin sprites; en las fases 1-18, la tabla de 0x9AB0 da, por habitacion, cuatro bytes: un guion de carga y una paleta.
; ----------------------------------------------------------------------
carga_de_la_habitacion:
	call apaga_los_sprites		;5780
	call bancos_9_10		;5783   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,09ab0h		;5786   ; la tabla de 0x9AB0...
	ld a,(0d000h)		;5789   ; lee la FASE (0 el patio, 1-18)
	or a			;578c   ; ... nada en el patio
	jr z,carga_fin		;578d
	dec a			;578f   ; ... la de la fase...
	add a,a			;5790
	call hl_mas_a		;5791   ; hl_mas_a: HL += A
	ld e,(hl)			;5794
	inc hl			;5795
	ld d,(hl)			;5796
	ld a,(0d001h)		;5797   ; ... cuatro bytes por habitacion
	add a,a			;579a
	add a,a			;579b
	call de_mas_a		;579c   ; de_mas_a: DE += A
	ex de,hl			;579f
	ld a,(hl)			;57a0   ; el guion...
	inc hl			;57a1
	push hl			;57a2
	ld h,(hl)			;57a3
	ld l,a			;57a4
	call guion_de_carga		;57a5   ; ... se sigue
	pop hl			;57a8
	inc hl			;57a9
	ld a,(hl)			;57aa   ; la paleta...
	inc hl			;57ab
	ld h,(hl)			;57ac
	ld l,a			;57ad
	call pon_paleta		;57ae   ; ... se pone
carga_fin:
	jp bancos_1_2_3		;57b1   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
carga_el_guion_de_0x9fed:
	call bancos_9_10		;57b4   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,09fedh		;57b7
	call guion_de_carga		;57ba   ; guion_de_carga: interpreta un guion de carga de la VRAM (0xFF acaba)
	jp bancos_1_2_3		;57bd   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
sube_la_bola:
	call bancos_9_10		;57c0   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,0fa00h		;57c3   ; a 0xFA00 el rle de 0xB0AA
	ld de,0b0aah		;57c6
	call rle_a_la_vram		;57c9   ; rle_a_la_vram: descomprime a la VRAM (HL) el rle de DE
	ld a,(0d000h)		;57cc   ; la paleta de 0xA01A en la fase 3...
	sub 003h		;57cf
	ld hl,0a01ah		;57d1
	jr z,L_57D9		;57d4
	ld hl,0a021h		;57d6   ; ... y la de 0xA021 en las demas
L_57D9:
	call pon_paleta		;57d9   ; pon_paleta: lista de [color][RB][G] hasta 0xFF
	jp bancos_1_2_3		;57dc   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; EL CUERPO DE DRACULA, a la pagina 1: dos dibujos de 32 filas (0xB5A1 y 0xB719), cada uno tal cual y volteado: (0, 0x80) y (0x40, 0x80) el primero, (0x20, 0x80) y (0x60, 0x80) el segundo.
; ----------------------------------------------------------------------
sube_el_cuerpo_de_dracula:
	call bancos_11_12_13		;57df   ; bancos_11_12_13: pone los bancos del mapa (11, 12 y 13)
	ld hl,0b5a1h		;57e2   ; el primero, a 0xE800
	call dibujo_de_32_filas		;57e5   ; dibujo_de_32_filas: desempaqueta un dibujo de 32 filas a 0xE800
	ld de,0c000h		;57e8   ; tal cual en (0, 0x80)...
	call dibujo_de_32_a_la_vram		;57eb
	call voltea_el_dibujo_de_32		;57ee   ; ... volteado...
	ld de,0c020h		;57f1   ; ... en (0x40, 0x80)
	call dibujo_de_32_a_la_vram		;57f4
	ld hl,0b719h		;57f7   ; el segundo
	call dibujo_de_32_filas		;57fa   ; dibujo_de_32_filas: desempaqueta un dibujo de 32 filas a 0xE800
	ld de,0c010h		;57fd   ; en (0x20, 0x80)...
	call dibujo_de_32_a_la_vram		;5800
	call voltea_el_dibujo_de_32		;5803
	ld de,0c030h		;5806   ; ... y volteado en (0x60, 0x80)
	call dibujo_de_32_a_la_vram		;5809
	jp bancos_1_2_3		;580c   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; UN DIBUJO DE 32 x 32 A LA VRAM: 32 filas de 16 bytes de 0xE800 a DE, una linea (128 bytes) cada una.
; ----------------------------------------------------------------------
dibujo_de_32_a_la_vram:
	ld b,020h		;580f   ; 32 filas...
	ld hl,0e800h		;5811   ; ... de 0xE800
L_5814:
	push bc			;5814
	push de			;5815
	push hl			;5816
	ld bc,00010h		;5817   ; 16 bytes
	call copia_a_la_vram		;581a   ; copia_a_la_vram: BC bytes de HL a la VRAM de DE
	pop hl			;581d
	pop de			;581e
	pop bc			;581f
	ld a,010h		;5820   ; la fila siguiente
	call hl_mas_a		;5822   ; hl_mas_a: HL += A
	ld a,080h		;5825   ; la linea siguiente de la VRAM
	call de_mas_a		;5827   ; de_mas_a: DE += A
	djnz L_5814		;582a
	ret			;582c
dibujo_de_32_filas:
	ld b,020h		;582d   ; DIBUJO DE 32 FILAS, a 0xE800: por fila, cuantos ceros delante...
	ld de,0e800h		;582f   ; (a 0xE800)
una_fila_del_dibujo:
	push bc			;5832   ; los ceros de delante...
	ld a,(hl)			;5833
	and a			;5834
	jr z,los_bytes_de_la_fila		;5835   ; (ninguno)
	ld b,a			;5837
	xor a			;5838
L_5839:
	ld (de),a			;5839
	inc de			;583a
	djnz L_5839		;583b
los_bytes_de_la_fila:
	ld a,00ch		;583d   ; 12 menos esos...
	sub (hl)			;583f
	inc hl			;5840   ; ... bytes tal cual
	ld c,a			;5841
	ld b,000h		;5842
	ldir		;5844
	xor a			;5846   ; y cuatro ceros detras
	ld b,004h		;5847
cuatro_ceros:
	ld (de),a			;5849   ; cuatro ceros detras de la fila
	inc de			;584a
	djnz cuatro_ceros		;584b
	pop bc			;584d
	djnz una_fila_del_dibujo		;584e
	ret			;5850
voltea_el_dibujo_de_32:
	ld hl,0e800h		;5851   ; cada fila de 0xE800...
	ld de,0e80fh		;5854   ; ... de sus dos puntas...
	ld c,020h		;5857   ; ... 32 filas
L_5859:
	ld b,008h		;5859   ; ocho pares
	call voltea_b_pares		;585b
	ld a,008h		;585e   ; la fila siguiente...
	call hl_mas_a		;5860   ; hl_mas_a: HL += A
	ld a,018h		;5863
	call de_mas_a		;5865   ; de_mas_a: DE += A
	dec c			;5868
	jr nz,L_5859		;5869
	ret			;586b

; ----------------------------------------------------------------------
; VOLTEA B PARES DE BYTES a 4 bits: cambia (HL) y (DE) con sus dos puntos cambiados de lado, HL hacia delante y DE hacia atras.
; ----------------------------------------------------------------------
voltea_b_pares:
	ex af,af'			;586c   ; el de HL, a guardar
	ld a,(hl)			;586d
	ex af,af'			;586e
	ld a,(de)			;586f   ; el de DE, con los nibbles cambiados...
	rrca			;5870
	rrca			;5871
	rrca			;5872
	rrca			;5873
	ld (hl),a			;5874   ; ... a HL
	ex af,af'			;5875   ; el de HL, igual...
	rrca			;5876
	rrca			;5877
	rrca			;5878
	rrca			;5879
	ld (de),a			;587a   ; ... a DE
	inc hl			;587b   ; hacia el centro
	dec de			;587c
	djnz voltea_b_pares		;587d
	ret			;587f

; ----------------------------------------------------------------------
; LA SALA DE DRACULA (p01:6369, la habitacion especial 6): sus dibujos (banco 14), algunos tambien volteados de lado o de arriba abajo, y 8 + 4 dibujos de 16 x 16 en la fila 0xA0 de la pagina 1 (los 4 ultimos volteados).
; ----------------------------------------------------------------------
sube_la_sala_de_dracula:
	call bancos_14_15		;5880   ; bancos_14_15: pone el sonido (14 y 15) en 0x8000 y 0xA000
	call dibujos_de_la_sala		;5883   ; los dibujos...
	call dibujos_volteados_de_lado		;5886   ; ... volteados de lado...
	call dibujos_volteados_de_arriba_abajo		;5889   ; ... volteados de arriba abajo...
	call ocho_de_16		;588c   ; ... ocho de 16 x 16...
	call cuatro_de_16_volteados		;588f   ; ... y cuatro volteados
	jp bancos_1_2_3		;5892   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
dibujos_de_la_sala:
	ld hl,0abfbh		;5895   ; 8 en (0x30, 0)
	ld b,008h		;5898
	ld de,08018h		;589a
	call sube_dibujos		;589d   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
	ld hl,0acfbh		;58a0   ; 2 en (0x80, 0)
	ld b,002h		;58a3
	ld de,08040h		;58a5
	call sube_dibujos		;58a8   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
	ld hl,0ad3bh		;58ab   ; 2 en (0xC0, 0)
	ld b,002h		;58ae
	ld de,08060h		;58b0
	call sube_dibujos		;58b3   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
	ld hl,0ad7bh		;58b6   ; 1 en (0xE0, 0)
	ld b,001h		;58b9
	ld de,08070h		;58bb
	call sube_dibujos		;58be   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
	ld hl,0ad9bh		;58c1   ; 0x6C en (0xF0, 0)
	ld b,06ch		;58c4
	ld de,08078h		;58c6
	jp sube_dibujos		;58c9   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
dibujos_volteados_de_lado:
	ld hl,0ad7bh		;58cc   ; el de 0xAD7B en (0xE8, 0)
	ld b,001h		;58cf
	ld de,08074h		;58d1
	call voltea_b_dibujos		;58d4
	ld hl,0ad9bh		;58d7   ; los 0x6C de 0xAD9B desde (0x50, 0x20)
	ld b,06ch		;58da
	ld de,09028h		;58dc
	call voltea_b_dibujos		;58df
	ld hl,0acfbh		;58e2   ; los 2 de 0xACFB en (0x90, 0)
	ld b,002h		;58e5
	ld de,08048h		;58e7
voltea_b_dibujos:
	push bc			;58ea
	push de			;58eb
	push hl			;58ec
	call voltea_un_dibujo		;58ed   ; uno, volteado
	pop hl			;58f0
	ld de,00020h		;58f1   ; el siguiente de la ROM
	add hl,de			;58f4
	pop de			;58f5
	call el_dibujo_siguiente		;58f6   ; el sitio siguiente
	pop bc			;58f9
	djnz voltea_b_dibujos		;58fa
	ret			;58fc
voltea_un_dibujo:
	push de			;58fd
	ld de,0e800h		;58fe   ; a 0xE800...
	ld bc,00020h		;5901
	ldir		;5904
	call voltea_8x8		;5906   ; ... se voltea...
	pop de			;5909
	ld hl,0e800h		;590a   ; ... y a la VRAM
	ld b,001h		;590d
	jp sube_dibujos		;590f   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
voltea_8x8:
	ld hl,0e800h		;5912   ; cada fila de cuatro bytes...
	ld de,0e803h		;5915   ; ... de sus dos puntas...
	ld c,008h		;5918   ; ... ocho filas
L_591A:
	ld b,002h		;591a   ; dos pares
	call voltea_b_pares		;591c
	inc hl			;591f   ; la fila siguiente
	inc hl			;5920
	ld a,006h		;5921
	call de_mas_a		;5923   ; de_mas_a: DE += A
	dec c			;5926
	jr nz,L_591A		;5927
	ret			;5929
dibujos_volteados_de_arriba_abajo:
	ld hl,08048h		;592a   ; los dos de (0x90, 0), a (0xB0, 0)
	ld b,002h		;592d
	ld de,08058h		;592f
	call voltea_de_arriba_abajo		;5932
	ld hl,08040h		;5935   ; los dos de (0x80, 0), a (0xA0, 0)
	ld b,002h		;5938
	ld de,08050h		;593a
	call voltea_de_arriba_abajo		;593d
	ld hl,08060h		;5940   ; los dos de (0xC0, 0), a (0xD0, 0)
	ld b,002h		;5943
	ld de,08068h		;5945
voltea_de_arriba_abajo:
	push bc			;5948
	push de			;5949
	push hl			;594a
	call lee_volteado		;594b   ; uno, de la VRAM, volteado
	pop de			;594e
	call el_dibujo_siguiente		;594f   ; el sitio siguiente de destino...
	ex de,hl			;5952
	pop de			;5953
	call el_dibujo_siguiente		;5954   ; ... y de origen
	pop bc			;5957
	djnz voltea_de_arriba_abajo		;5958
	ret			;595a
el_dibujo_siguiente:
	ld a,e			;595b   ; cuatro bytes (ocho puntos) a la derecha...
	add a,004h		;595c
	and 07fh		;595e
	ld e,a			;5960
	ret nz			;5961   ; ... y al pasar del borde...
	ld a,d			;5962   ; ... ocho lineas mas abajo (0x400)
	add a,004h		;5963
	and 0fch		;5965
	ld d,a			;5967
	ret			;5968
lee_volteado:
	push de			;5969   ; a 0xE800, con las filas al reves...
	ld de,0e818h		;596a
	ld b,008h		;596d   ; ... ocho filas...
L_596F:
	push bc			;596f
	ld bc,00004h		;5970   ; ... de cuatro bytes...
	call lee_de_la_vram		;5973
	ld a,e			;5976   ; ... subiendo
	sub 008h		;5977
	ld e,a			;5979
	ld a,080h		;597a   ; la linea siguiente de la VRAM
	call hl_mas_a		;597c   ; hl_mas_a: HL += A
	pop bc			;597f
	djnz L_596F		;5980
	pop de			;5982
	ld hl,0e800h		;5983   ; y de vuelta a la VRAM
	ld b,001h		;5986
	jp sube_dibujos		;5988   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
ocho_de_16:
	ld hl,0bbdbh		;598b   ; ocho de 16 x 16 de 0xBBDB...
	ld de,0d000h		;598e   ; ... en (0, 0xA0) de la pagina 1
	ld b,008h		;5991
	jp sube_dibujos_de_16		;5993   ; sube_dibujos_de_16: B dibujos de 16x16 a 4 bits de HL
cuatro_de_16_volteados:
	ld b,004h		;5996   ; cuatro de 0xBDDB...
	ld hl,0bddbh		;5998
	ld de,0d040h		;599b   ; ... desde (0x80, 0xA0)
uno_de_16_volteado:
	push bc			;599e
	push de			;599f
	push hl			;59a0
	call voltea_un_dibujo_de_16		;59a1   ; uno, volteado
	pop hl			;59a4
	ld de,00080h		;59a5   ; el siguiente de la ROM, 0x80 bytes
	add hl,de			;59a8
	pop de			;59a9
	ld a,e			;59aa   ; el sitio siguiente, dieciseis puntos a la derecha...
	add a,008h		;59ab
	and 07fh		;59ad
	ld e,a			;59af
	jr nz,L_59B8		;59b0
	ld a,d			;59b2   ; ... o dieciseis lineas mas abajo
	add a,008h		;59b3
	and 0f8h		;59b5
	ld d,a			;59b7
L_59B8:
	pop bc			;59b8
	djnz uno_de_16_volteado		;59b9
	ret			;59bb
voltea_un_dibujo_de_16:
	push de			;59bc
	ld de,0e800h		;59bd   ; a 0xE800...
	ld bc,00080h		;59c0
	ldir		;59c3
	call voltea_16x16		;59c5   ; ... se voltea...
	pop de			;59c8
	ld hl,0e800h		;59c9   ; ... y a la VRAM
	ld b,001h		;59cc
	jp sube_dibujos_de_16		;59ce   ; sube_dibujos_de_16: B dibujos de 16x16 a 4 bits de HL
voltea_16x16:
	ld hl,0e800h		;59d1   ; cada fila de ocho bytes...
	ld de,0e807h		;59d4   ; ... de sus dos puntas...
	ld c,010h		;59d7   ; ... dieciseis filas
L_59D9:
	ld b,004h		;59d9   ; cuatro pares
	call voltea_b_pares		;59db
	ld a,004h		;59de
	call hl_mas_a		;59e0   ; hl_mas_a: HL += A
	ld a,00ch		;59e3
	call de_mas_a		;59e5   ; de_mas_a: DE += A
	dec c			;59e8
	jr nz,L_59D9		;59e9
	ret			;59eb
pon_la_paleta_de_dracula:
	call pon_la_paleta_base		;59ec   ; la base...
	call bancos_9_10		;59ef   ; bancos_9_10: pone los bancos 9 y 10 en 0x8000 y 0xA000
	ld hl,0bf6fh		;59f2   ; ... y la de 0xBF6F
	call pon_paleta		;59f5   ; pon_paleta: lista de [color][RB][G] hasta 0xFF
	jp bancos_1_2_3		;59f8   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; LOS DIBUJOS DEL TITULO (banco 8): 0x11 desde (8, 0) de la pagina 1; con la fuente japonesa, 0x1E mas y el rle de 0xBBF6 (banco 13); si no, 0x59 mas.
; ----------------------------------------------------------------------
sube_los_dibujos_del_titulo:
	call bancos_7_8		;59fb   ; bancos_7_8: pone los bancos 7 y 8 en 0x8000 y 0xA000
	ld hl,0ac80h		;59fe   ; 0x11 de 0xAC80...
	ld de,08004h		;5a01   ; ... desde (8, 0)
	ld b,011h		;5a04
	call sube_dibujos		;5a06   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
	ld a,(0002bh)		;5a09   ; la fuente de la BIOS: japonesa?
	and 00fh		;5a0c
	jr nz,titulo_de_fuera_dibujos		;5a0e
	ld hl,0aea0h		;5a10   ; si: 0x1E de 0xAEA0...
	ld b,01eh		;5a13
	call sube_dibujos		;5a15   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
	call bancos_11_12_13		;5a18   ; bancos_11_12_13: pone los bancos del mapa (11, 12 y 13)
	ld de,0bbf6h		;5a1b   ; ... y el rle de 0xBBF6
	call rle_con_destino		;5a1e   ; rle_con_destino: descomprime a la VRAM un rle que lleva el destino delante
	jr titulo_dibujos_fin		;5a21
titulo_de_fuera_dibujos:
	ld hl,0b260h		;5a23   ; si no: 0x59 de 0xB260
	ld b,059h		;5a26
	call sube_dibujos		;5a28   ; sube_dibujos: B dibujos de 8x8 a 4 bits de HL a la VRAM de DE
titulo_dibujos_fin:
	jp bancos_1_2_3		;5a2b   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
a_que_habitacion_se_sale:
	call bancos_11_12_13		;5a2e   ; bancos_11_12_13: pone los bancos del mapa (11, 12 y 13)
	call 0b963h		;5a31   ; p13:B963
	jp bancos_1_2_3		;5a34   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
salidas_de_esta_habitacion:
	call bancos_11_12_13		;5a37   ; bancos_11_12_13: pone los bancos del mapa (11, 12 y 13)
	call 0b99ah		;5a3a   ; p13:B99A
	jp bancos_1_2_3		;5a3d   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
mira_la_puerta_de_la_fase:
	call bancos_11_12_13		;5a40   ; bancos_11_12_13: pone los bancos del mapa (11, 12 y 13)
	call 0bb31h		;5a43   ; p13:BB31
	jp bancos_1_2_3		;5a46   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; LOS SECRETOS DEL BLOQUE: 0xE000-0xE47F a cero, la lista del bloque de tres fases copiada ahi (48 habitaciones de 0x18 bytes) y los vendedores apuntados en 0xDE00.
; ----------------------------------------------------------------------
los_secretos_del_bloque:
	ld hl,0e000h		;5a49   ; 0x480 bytes a cero desde 0xE000
	ld de,0e001h		;5a4c
	ld (hl),000h		;5a4f
	ld bc,0047fh		;5a51
	ldir		;5a54
	call copia_los_secretos		;5a56   ; la lista del bloque...
	jp los_vendedores_del_bloque		;5a59   ; ... y los vendedores

; ----------------------------------------------------------------------
; COPIA LA LISTA DE SECRETOS (banco 14) a 0xE000: pares de bytes, con un tercero si el segundo es 0x7F; 0xFE pasa a la habitacion siguiente (0x18 bytes mas alla), 0xFF a la fase siguiente (0x180, 16 habitaciones) y 0x00 acaba.
; ----------------------------------------------------------------------
copia_los_secretos:
	call bancos_14_15		;5a5c   ; bancos_14_15: pone el sonido (14 y 15) en 0x8000 y 0xA000
	call lista_del_bloque		;5a5f   ; la lista del bloque
	ld de,0e000h		;5a62   ; a 0xE000
una_fase_de_secretos:
	push de			;5a65
una_habitacion_de_secretos:
	push de			;5a66
un_secreto:
	ld a,(hl)			;5a67   ; el byte...
	or a			;5a68
	jr z,secretos_copiados		;5a69   ; ... 0: acaba
	inc a			;5a6b   ; ... 0xFF: la fase siguiente
	jr z,secretos_de_la_fase_siguiente		;5a6c
	inc a			;5a6e   ; ... 0xFE: la habitacion siguiente
	jr z,habitacion_siguiente		;5a6f
	ldi		;5a71   ; si no, dos bytes...
	ld a,(hl)			;5a73
	ldi		;5a74
	cp 07fh		;5a76   ; ... y, si el segundo es 0x7F...
	jr nz,L_5A7C		;5a78
	ldi		;5a7a   ; ... un tercero
L_5A7C:
	jr un_secreto		;5a7c
habitacion_siguiente:
	pop de			;5a7e   ; desde el principio de la habitacion...
	ld a,018h		;5a7f   ; ... 0x18 bytes mas alla
	call de_mas_a		;5a81   ; de_mas_a: DE += A
	inc hl			;5a84
	jr una_habitacion_de_secretos		;5a85
secretos_de_la_fase_siguiente:
	pop de			;5a87   ; desde el principio de la fase...
	pop de			;5a88
	push hl			;5a89
	ld hl,00180h		;5a8a   ; ... 0x180 bytes mas alla
	add hl,de			;5a8d
	ex de,hl			;5a8e
	pop hl			;5a8f
	inc hl			;5a90
	jr una_fase_de_secretos		;5a91
secretos_copiados:
	pop de			;5a93
	pop de			;5a94
	jp bancos_1_2_3		;5a95   ; bancos_1_2_3: vuelve a poner los bancos 1, 2 y 3
lista_del_bloque:
	ld a,(0d000h)		;5a98   ; en el patio...
	or a			;5a9b
	ld hl,0800ch		;5a9c   ; ... la de 0x800C
	ret z			;5a9f
	ld a,(0d002h)		;5aa0   ; si no, la del bloque...
	ld hl,08000h		;5aa3   ; ... de la tabla de 0x8000
	add a,a			;5aa6
	call hl_mas_a		;5aa7   ; hl_mas_a: HL += A
	ld e,(hl)			;5aaa
	inc hl			;5aab
	ld d,(hl)			;5aac
	ex de,hl			;5aad
	ret			;5aae

; ----------------------------------------------------------------------
; LOS VENDEDORES en 0xDE00 (al empezar cada vida, p01:62F2: morir los pone a cero; visto en openMSX): cuatro bytes por habitacion (dos huecos de [lo que vende][golpes]), a cero, y en cada hueco lo que vende (0x5B0B) cada secreto 11x de la habitacion, dos como mucho; un bloque que se rompe con un tercer byte 11x cuenta tambien.
; ----------------------------------------------------------------------
los_vendedores_del_bloque:
	ld hl,0de00h		;5aaf   ; 0xC0 bytes a cero desde 0xDE00
	ld de,0de01h		;5ab2
	ld (hl),000h		;5ab5
	ld bc,000bfh		;5ab7
	push hl			;5aba
	ldir		;5abb
	pop de			;5abd
	ld hl,0e000h		;5abe   ; las 48 habitaciones de 0xE000
	ld b,030h		;5ac1
vendedores_de_una_habitacion:
	push bc			;5ac3
	push hl			;5ac4
	push de			;5ac5
	call busca_vendedores		;5ac6   ; sus huecos
	pop hl			;5ac9   ; la siguiente en 0xDE00, cuatro bytes...
	ld bc,00004h		;5aca
	add hl,bc			;5acd
	ex de,hl			;5ace
	pop hl			;5acf   ; ... y en 0xE000, 0x18
	ld c,018h		;5ad0
	add hl,bc			;5ad2
	pop bc			;5ad3
	djnz vendedores_de_una_habitacion		;5ad4
	ret			;5ad6
busca_vendedores:
	ld bc,00802h		;5ad7   ; ocho secretos, dos huecos
mira_un_secreto:
	inc hl			;5ada   ; su segundo byte
	ld a,(hl)			;5adb
	and 0e0h		;5adc   ; un bloque (011)...
	cp 060h		;5ade
	jr z,bloque_con_tercer_byte		;5ae0   ; ... mira su tercer byte
es_un_vendedor:
	and 0c0h		;5ae2   ; 11x: un vendedor
	cp 0c0h		;5ae4
	jr nz,el_secreto_siguiente		;5ae6
	ld a,(hl)			;5ae8   ; lo que vende...
	push bc			;5ae9
	push hl			;5aea
	ld hl,05b0bh		;5aeb   ; ... de 0x5B0B, por los bits 5-2...
	and 03ch		;5aee
	rrca			;5af0
	rrca			;5af1
	call hl_mas_a		;5af2   ; hl_mas_a: HL += A
	ldi		;5af5   ; ... al hueco
	inc de			;5af7   ; (sus golpes, a cero)
	pop hl			;5af8
	pop bc			;5af9
	dec c			;5afa   ; los dos huecos llenos: listo
	ret z			;5afb
el_secreto_siguiente:
	inc hl			;5afc   ; al primer byte del siguiente
	djnz mira_un_secreto		;5afd
	ret			;5aff
bloque_con_tercer_byte:
	ld a,(hl)			;5b00   ; lo de dentro es 0x1F...
	and 01fh		;5b01
	cp 01fh		;5b03
	jr nz,el_secreto_siguiente		;5b05   ; (si no, nada)
	inc hl			;5b07   ; ... el tercer byte
	ld a,(hl)			;5b08
	jr es_un_vendedor		;5b09

; ----------------------------------------------------------------------
; DATOS lo_que_vende_cada_vendedor: lo que vende el vendedor de un secreto
;   11x, por los bits 5-2 del secreto (p00:5AEB al empezar cada vida, p02:91A4
;   al salir): vela, baston, escudo rojo, escudo, reloj de arena, vida llena,
;   frasco, cruz que vuelve y daga
;   0x5b0b..0x5b1b  (16 bytes)
DATA_lo_que_vende_cada_vendedor:
	defb 00eh,012h,003h,004h,00ah,016h,01eh,01dh,01bh,000h,000h,000h,000h,000h,000h,000h	; 5b0b  ................

; ======================================================================
; CODIGO 0x5b1b..0x5c04  (233 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LAS COSAS DE LA HABITACION desde sus secretos (0xE000): velas y bloques a las cosas fijas de DE (0xC470, ocho de 16 bytes: [1][y][x][0][tamano: 0 vela, 1 antorcha del patio, 2 bloque pequeno, 3 grande][lo de dentro][el secreto: bajo, alto, bajo][tercer byte]); los objetos a la vista (p02:89FD), los cofres (p02:8A13) y los vendedores (p02:9179) salen aparte, salvo con el mapa del pergamino en pantalla (0xCF38), que solo quiere las fijas.
; ----------------------------------------------------------------------
las_cosas_de_la_habitacion:
	call secretos_de_esta_habitacion		;5b1b   ; los secretos de esta habitacion
	ld de,0c470h		;5b1e   ; apunta a los bloques que se rompen (ocho de 16 bytes)
cosas_fijas_a_de:
	ld b,008h		;5b21   ; ocho como mucho
una_cosa_de_la_habitacion:
	ld a,(hl)			;5b23   ; el primer byte: 0, no hay mas
	inc hl			;5b24
	or a			;5b25
	jr z,salta_el_secreto		;5b26
	push bc			;5b28
	push hl			;5b29
	push de			;5b2a
	ld a,(hl)			;5b2b   ; el segundo, su clase (bits 7-5):
	and 0e0h		;5b2c
	jr z,un_objeto_a_la_vista		;5b2e   ; 000: un objeto a la vista
	bit 7,(hl)		;5b30   ; 1xx: un cofre o un vendedor
	jr nz,cofre_o_vendedor		;5b32
	dec hl			;5b34
	ld a,001h		;5b35   ; si no, vela o bloque: una cosa fija, estado 1...
	ld (de),a			;5b37
	inc de			;5b38
	push hl			;5b39
	push bc			;5b3a
	call sitio_del_secreto		;5b3b   ; ... su sitio...
	ld a,c			;5b3e   ; ... la y...
	ld (de),a			;5b3f
	inc de			;5b40
	ld a,b			;5b41   ; ... la x...
	ld (de),a			;5b42
	inc de			;5b43
	pop bc			;5b44
	xor a			;5b45   ; ... un 0...
	ld (de),a			;5b46
	inc de			;5b47
	ld a,(hl)			;5b48   ; ... y el tamano, por su clase:
	ld b,a			;5b49
	rlca			;5b4a
	rlca			;5b4b
	rlca			;5b4c
	and 007h		;5b4d
	dec a			;5b4f   ; una vela (001)...
	jr nz,el_tamano		;5b50
	ld a,(0d000h)		;5b52   ; ... en el patio es la antorcha (1)...
	or a			;5b55
	jr z,el_tamano		;5b56
	ld a,0ffh		;5b58   ; ... y si no, 0
el_tamano:
	inc a			;5b5a   ; (bloque pequeno 2, grande 3)
	ld (de),a			;5b5b
	inc e			;5b5c
	ld a,b			;5b5d   ; lo de dentro (bits 4-0)
	and 01fh		;5b5e
	ld (de),a			;5b60
	inc e			;5b61
	ex af,af'			;5b62
	ld a,l			;5b63   ; el secreto, a apuntar
	ld (de),a			;5b64
	inc e			;5b65
	pop bc			;5b66
	ld a,b			;5b67
	ld (de),a			;5b68
	inc e			;5b69
	ld a,c			;5b6a
	ld (de),a			;5b6b
	inc e			;5b6c
	ex af,af'			;5b6d
	cp 01fh		;5b6e   ; 0x1F: el tercer byte...
	jr nz,la_cosa_siguiente		;5b70
	inc hl			;5b72   ; ... tambien
	ldi		;5b73
la_cosa_siguiente:
	pop de			;5b75
	ld a,e			;5b76   ; la ficha siguiente, 16 bytes mas
	add a,010h		;5b77
	ld e,a			;5b79
	pop hl			;5b7a
	pop bc			;5b7b
salta_el_secreto:
	ld a,(hl)			;5b7c   ; el secreto siguiente...
	inc hl			;5b7d
	and 01fh		;5b7e
	cp 01fh		;5b80   ; ... con su tercer byte si lo lleva
	jr nz,L_5B85		;5b82
	inc hl			;5b84
L_5B85:
	djnz una_cosa_de_la_habitacion		;5b85
	ret			;5b87
un_objeto_a_la_vista:
	ld a,(0cf38h)		;5b88   ; con el mapa del pergamino, no
	and a			;5b8b
	jr nz,la_cosa_siguiente		;5b8c
	call sitio_y_contenido		;5b8e   ; su sitio y lo que es...
	call 089fdh		;5b91   ; ... a la lista de objetos
	jr la_cosa_siguiente		;5b94
sitio_y_contenido:
	dec l			;5b96   ; D = la x, E = la y...
	push hl			;5b97
	push bc			;5b98
	call sitio_del_secreto		;5b99
	ld d,b			;5b9c
	ld e,c			;5b9d
	pop bc			;5b9e
	ld a,(hl)			;5b9f   ; ... B = lo de dentro
	and 01fh		;5ba0
	ld b,a			;5ba2
	pop hl			;5ba3
	ret			;5ba4
cofre_o_vendedor:
	ld a,(0cf38h)		;5ba5   ; con el mapa del pergamino, no
	and a			;5ba8
	jr nz,la_cosa_siguiente		;5ba9
	bit 6,(hl)		;5bab   ; 11x: un vendedor
	jr nz,un_vendedor		;5bad
	call sitio_y_contenido		;5baf   ; 10x: un cofre
	call 08a13h		;5bb2
	jr la_cosa_siguiente		;5bb5
un_vendedor:
	push hl			;5bb7
	pop ix		;5bb8
	call sitio_y_contenido		;5bba   ; su sitio
	ld a,(ix+000h)		;5bbd   ; B = lo que vende (bits 5-2)...
	ld c,a			;5bc0
	and 03ch		;5bc1
	rrca			;5bc3
	rrca			;5bc4
	ld b,a			;5bc5
	ld a,c			;5bc6   ; ... C = su clase (bits 1-0)
	and 003h		;5bc7
	ld c,a			;5bc9
	call 09179h		;5bca
	jr la_cosa_siguiente		;5bcd
secretos_de_esta_habitacion:
	ld a,(0d001h)		;5bcf   ; lee la HABITACION dentro de la fase

; ----------------------------------------------------------------------
; LOS SECRETOS DE LA HABITACION A en 0xE000: la fase en su sitio del bloque (0x5C04, por 16 habitaciones) mas 0x18 bytes por habitacion.
; ----------------------------------------------------------------------
secretos_de_la_habitacion:
	ld (0cffeh),a		;5bd2
	push bc			;5bd5
	push de			;5bd6
	ld de,00000h		;5bd7   ; en el patio, desde 0xE000
	ld a,(0d000h)		;5bda   ; lee la FASE (0 el patio, 1-18)
	or a			;5bdd
	jr z,L_5BEE		;5bde
	dec a			;5be0   ; la fila de la fase en el bloque (0, 0x18 o 0x30)...
	ld hl,05c04h		;5be1
	call hl_mas_a		;5be4   ; hl_mas_a: HL += A
	ld l,(hl)			;5be7
	ld h,d			;5be8   ; ... por 16
	add hl,hl			;5be9
	add hl,hl			;5bea
	add hl,hl			;5beb
	add hl,hl			;5bec
	ex de,hl			;5bed
L_5BEE:
	ld hl,0e000h		;5bee
	add hl,de			;5bf1
	ex de,hl			;5bf2
	ld a,(0cffeh)		;5bf3   ; la habitacion...
	ld l,a			;5bf6
	ld h,000h		;5bf7
	add hl,hl			;5bf9   ; ... por 8...
	add hl,hl			;5bfa
	add hl,hl			;5bfb
	ld b,h			;5bfc
	ld c,l			;5bfd
	add hl,hl			;5bfe   ; ... y por 3: 0x18 bytes cada una
	add hl,bc			;5bff
	add hl,de			;5c00
	pop de			;5c01
	pop bc			;5c02
	ret			;5c03

; ----------------------------------------------------------------------
; DATOS fila_de_cada_fase: 18 bytes, uno por fase (1-18): p00:5BE1 lo
;   multiplica por 16 y lo usa de desplazamiento en el bufer de 0xE000; la
;   fase 0 no pasa por aqui
;   0x5c04..0x5c16  (18 bytes)
DATA_fila_de_cada_fase:
	defb 000h,018h,030h,000h,018h,030h,000h,018h,030h,000h,018h,030h,000h,018h,030h,000h	; 5c04  ..0..0..0..0..0.
	defb 018h,030h	; 5c14

; ======================================================================
; CODIGO 0x5c16..0x5ce9  (211 bytes)
; ======================================================================


sitio_del_secreto:
	ld a,(hl)			;5c16   ; el primer byte:
	ld b,a			;5c17
	and 0f0h		;5c18   ; C = la y (nibble alto)...
	ld c,a			;5c1a
	ld a,b			;5c1b   ; ... B = la x (nibble bajo por 16)
	and 00fh		;5c1c
	add a,a			;5c1e
	add a,a			;5c1f
	add a,a			;5c20
	add a,a			;5c21
	ld b,a			;5c22
	inc hl			;5c23
	ret			;5c24

; ----------------------------------------------------------------------
; UN CUADRO DEL JUEGO (el estado 5 y la demostracion): lo de 0x6841 y 0x654B, el mapa del pergamino (que lo para todo mientras esta), la pausa con F1 (en la sala de Dracula repinta su cuerpo; 0xC40A y el efecto 0xFD), y luego los patrones de Simon, lo de 0x6AFF y 0x7837, el jefe, los enemigos, lo que lanzan, lo de 0x7D68, los bloques, los vendedores, los objetos, los cascotes, las trampas de cadena, las plataformas, la puerta de la fase y los sprites.
; ----------------------------------------------------------------------
un_cuadro_del_juego:
	call 06841h		;5c25
	call 0654bh		;5c28
	ld a,(0ce40h)		;5c2b   ; con 0xCE40...
	and a			;5c2e
	jp nz,066bah		;5c2f   ; ... lo de 0x66BA
	call 09552h		;5c32   ; el mapa del pergamino
	ld a,(0cf38h)		;5c35   ; en pantalla: nada mas
	and a			;5c38
	ret nz			;5c39
	ld a,(0c002h)		;5c3a   ; en una partida...
	and 040h		;5c3d
	jr z,el_cuadro		;5c3f
	ld a,(0c00bh)		;5c41   ; ... F1?
	rra			;5c44
	jr nc,el_cuadro		;5c45
	ld a,(0ce00h)		;5c47   ; en la sala de Dracula...
	cp 006h		;5c4a
	call z,0ad93h		;5c4c   ; ... su cuerpo
	ld a,001h		;5c4f   ; la pausa
	ld (0c40ah),a		;5c51
	call sube_los_patrones_de_simon		;5c54
	ld a,0fdh		;5c57
	jp sonido		;5c59   ; sonido: arranca la musica o el efecto A (bit 7 = musica)
el_cuadro:
	call sube_los_patrones_de_simon		;5c5c   ; los patrones de Simon...
	call 06affh		;5c5f
	call 07837h		;5c62   ; ... lo de 0x7837...
	call 0b6abh		;5c65   ; ... el jefe...
	call 098e5h		;5c68   ; ... los enemigos...
	call 09e31h		;5c6b   ; ... lo que lanzan...
	call 07d68h		;5c6e   ; ... lo de 0x7D68...
	call 08671h		;5c71   ; ... los bloques...
	call 091beh		;5c74   ; ... los vendedores...
	call 08a4ah		;5c77   ; ... los objetos...
	call 088d8h		;5c7a   ; ... los cascotes...
	call 08fcfh		;5c7d   ; ... las trampas de cadena...
	call 0909bh		;5c80   ; ... las plataformas...
	call 09147h		;5c83   ; ... la puerta de la fase...
	call 09918h		;5c86   ; ... y los sprites
	call 09910h		;5c89
	call 064ech		;5c8c
	jp 064e5h		;5c8f

; ----------------------------------------------------------------------
; BUSCA UN GAME MASTER en las cuatro ranuras (y sus subranuras, si estan expandidas, por 0xFCC1): la firma de 0x5CE9 en 0x7FFA; 0xE600 = 0xFF si esta.
; ----------------------------------------------------------------------
busca_el_game_master:
	ld bc,00400h		;5c92
	ld hl,0fcc1h		;5c95
mira_una_ranura:
	push bc			;5c98   ; la ranura C...
	push hl			;5c99
	ld a,(hl)			;5c9a
	bit 7,a		;5c9b   ; ... expandida (bit 7 de 0xFCC1 + C)?
	jr nz,L_5CB3		;5c9d
	call mira_la_firma		;5c9f   ; no: mira la firma
L_5CA2:
	pop hl			;5ca2   ; (C = el numero de ranura)
	pop bc			;5ca3
	jr c,L_5CAD		;5ca4   ; la tiene: 0xFF
	inc hl			;5ca6   ; la ranura siguiente
	inc c			;5ca7
	djnz mira_una_ranura		;5ca8
	xor a			;5caa   ; ninguna: 0
	jr L_5CAF		;5cab
L_5CAD:
	ld a,0ffh		;5cad
L_5CAF:
	ld (0e600h),a		;5caf   ; guarda si hay un GAME MASTER en otra ranura
	ret			;5cb2
L_5CB3:
	call mira_las_subranuras		;5cb3
	jr L_5CA2		;5cb6
mira_las_subranuras:
	and 080h		;5cb8   ; expandida: el bit 7...
	or c			;5cba   ; ... con la ranura...
	ld c,a			;5cbb
	ld b,004h		;5cbc   ; ... y sus cuatro subranuras
L_5CBE:
	push bc			;5cbe
	call mira_la_firma		;5cbf   ; mira la firma
	pop bc			;5cc2
	ret c			;5cc3   ; la tiene: carry
	ld a,c			;5cc4   ; la subranura siguiente (bits 2-3)
	add a,004h		;5cc5
	ld c,a			;5cc7
	djnz L_5CBE		;5cc8
	and a			;5cca   ; ninguna: NC
	ret			;5ccb
mira_la_firma:
	ld de,05ce9h		;5ccc   ; la firma...
	ld hl,07ffah		;5ccf   ; ... en 0x7FFA de la ranura C...
	ld b,006h		;5cd2   ; ... seis bytes
L_5CD4:
	push bc			;5cd4   ; un byte de la ranura C...
	push de			;5cd5
	ld a,c			;5cd6
	call 0000ch		;5cd7   ; BIOS RDSLT - Reads the value of an address in another slot | ... por RDSLT
	pop de			;5cda
	pop bc			;5cdb
	ex de,hl			;5cdc
	cp (hl)			;5cdd   ; es el de la firma?
	ex de,hl			;5cde
	jr nz,L_5CE7		;5cdf   ; no: NC
	inc hl			;5ce1   ; el siguiente
	inc de			;5ce2
	djnz L_5CD4		;5ce3
	scf			;5ce5   ; los seis: carry
	ret			;5ce6
L_5CE7:
	and a			;5ce7
	ret			;5ce8

; ----------------------------------------------------------------------
; DATOS firma_de_otro_cartucho: seis bytes que p00:5CCC compara, con RDSLT,
;   con los de 0x7FFA de otra ranura: asi sabe si hay otro cartucho puesto
;   0x5ce9..0x5cef  (6 bytes)
DATA_firma_de_otro_cartucho:
	defb 000h,030h,031h,013h,035h,0aah	; 5ce9

; ======================================================================
; CODIGO 0x5cef..0x5d16  (39 bytes)
; ======================================================================


la_ventana_del_game_master:
	call borra_la_ventana_del_game_master		;5cef   ; el fondo...
	ld c,00eh		;5cf2   ; ... un marco...
	call un_marco		;5cf4
	ld hl,05d16h		;5cf7   ; ... y sus rotulos
	jp rotulo		;5cfa   ; rotulo: pinta un rotulo ([x][y] y texto; 0xFE otra posicion, 0xFF acaba)
borra_la_ventana_del_game_master:
	ld hl,02098h		;5cfd   ; desde (0x20, 0x98)...
	ld bc,0c038h		;5d00   ; ... 0xC0 x 0x38
borra_un_rectangulo:
	xor a			;5d03   ; del color 0, en la pagina 0
	ld d,000h		;5d04
	push bc			;5d06
	push hl			;5d07
	call rellena_rectangulo		;5d08   ; rellena_rectangulo: orden del V9938 que rellena un rectangulo (desde R#36)
	pop hl			;5d0b
	pop de			;5d0c
	ret			;5d0d
recuadro:
	call borra_un_rectangulo		;5d0e   ; borrado y con un marco del color 0x0E
	ld c,00eh		;5d11
	jp un_marco		;5d13

; ----------------------------------------------------------------------
; DATOS rotulo_5D16: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "---MENU--- / {4F} / START GAME / MODIFY STAGE
;   NUMBER / MODIFY PLAYER NUMBER"; lo leen p00:5CFA (75 bytes)
;   0x5d16..0x5d61  (75 bytes)
DATA_rotulo_5D16:
	defb 058h,0a0h,030h,030h,030h,03dh,035h,03eh,045h,030h,030h,030h,0feh,028h,0b0h,04fh	; 5d16  X.000=5>E000.(.O
	defb 0feh,030h,0b0h,043h,044h,031h,042h,044h,000h,037h,031h,03dh,035h,0feh,030h,0b8h	; 5d26  .0.CD1BD.71=5.0.
	defb 03dh,03fh,034h,039h,036h,049h,000h,043h,044h,031h,037h,035h,000h,03eh,045h,03dh	; 5d36  =?496I.CD175.>E=
	defb 032h,035h,042h,0feh,030h,0c0h,03dh,03fh,034h,039h,036h,049h,000h,040h,03ch,031h	; 5d46  25B.0.=?496I.@<1
	defb 049h,035h,042h,000h,03eh,045h,03dh,032h,035h,042h,0ffh	; 5d56  I5B.>E=25B.

; ======================================================================
; CODIGO 0x5d61..0x5d72  (17 bytes)
; ======================================================================


opcion_1_la_fase:
	ld hl,05d72h		;5d61   ; su rotulo...
	call rotulo_de_la_opcion		;5d64
	ld hl,0e605h		;5d67   ; ... y la fase que da, en (0xB0, 0xB8)
	ld de,0b0b8h		;5d6a
L_5D6D:
	ld b,001h		;5d6d
	jp pinta_en_bcd		;5d6f

; ----------------------------------------------------------------------
; DATOS rotulo_5D72: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "STAGE NUMBER{2F}"; lo leen p00:5D64 (16 bytes)
;   0x5d72..0x5d82  (16 bytes)
DATA_rotulo_5D72:
	defb 048h,0b8h,043h,044h,031h,037h,035h,000h,03eh,045h,03dh,032h,035h,042h,02fh,0ffh	; 5d72  H.CD175.>E=25B/.

; ======================================================================
; CODIGO 0x5d82..0x5d98  (22 bytes)
; ======================================================================


opcion_2_las_vidas:
	ld hl,05d98h		;5d82   ; su rotulo...
	call rotulo_de_la_opcion		;5d85
	ld hl,0e607h		;5d88   ; ... y las vidas que da, en (0xB8, 0xB8)
	ld de,0b8b8h		;5d8b
	jr $-33		;5d8e
rotulo_de_la_opcion:
	push hl			;5d90
	call borra_la_linea_de_la_opcion		;5d91
	pop hl			;5d94
	jp rotulo		;5d95   ; rotulo: pinta un rotulo ([x][y] y texto; 0xFE otra posicion, 0xFF acaba)

; ----------------------------------------------------------------------
; DATOS rotulo_5D98: rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra
;   posicion, 0xFF acaba): "PLAYER NUMBER{2F}"; lo leen p00:5D85 (17 bytes)
;   0x5d98..0x5da9  (17 bytes)
DATA_rotulo_5D98:
	defb 048h,0b8h,040h,03ch,031h,049h,035h,042h,000h,03eh,045h,03dh,032h,035h,042h,02fh	; 5d98  H.@<1I5B.>E=25B/
	defb 0ffh	; 5da8

; ======================================================================
; CODIGO 0x5da9..0x5e6a  (193 bytes)
; ======================================================================


borra_la_linea_de_la_opcion:
	ld hl,024b0h		;5da9   ; desde (0x24, 0xB0), 0xB8 x 0x18
	ld bc,0b818h		;5dac
	jp borra_un_rectangulo		;5daf

; ----------------------------------------------------------------------
; UNA CIFRA DEL GAME MASTER: la tecla de un numero recien pulsada (filas 0 y 1 del teclado) entra por la derecha en 0xE60F (BCD), se pinta en 0xE602 y se pasa a binario en 0xE60E; 0xE615 dice que se ha tecleado.
; ----------------------------------------------------------------------
una_cifra:
	call teclas_de_numero		;5db2   ; alguna recien pulsada?
	ret z			;5db5
	ld hl,(0e608h)		;5db6   ; las del 0 al 7 (fila 0)...
	ld d,000h		;5db9
	ld b,008h		;5dbb
	ld a,l			;5dbd
	call cual_bit		;5dbe
	jr c,la_cifra		;5dc1
	ld a,h			;5dc3   ; ... y el 8 y el 9 (fila 1)
	ld b,002h		;5dc4
	call cual_bit		;5dc6
	ret nc			;5dc9
la_cifra:
	ld hl,0e615h		;5dca   ; tecleado
	ld (hl),0ffh		;5dcd
	ld hl,0e60fh		;5dcf   ; entra por la derecha
	ld a,d			;5dd2
	rld		;5dd3
	ld de,(0e602h)		;5dd5   ; y se pinta
	ld b,001h		;5dd9
	call pinta_en_bcd		;5ddb
	jp bcd_a_binario		;5dde
cual_bit:
	rra			;5de1   ; D = el primer bit a 1
	ret c			;5de2
	inc d			;5de3
	djnz cual_bit		;5de4
	ret			;5de6
teclas_de_numero:
	xor a			;5de7   ; la fila 0 (del 0 al 7)...
	call 00141h		;5de8   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5deb
	ld d,a			;5dec
	ld a,001h		;5ded   ; ... y la 1 (8 y 9)...
	call 00141h		;5def   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5df2
	and 003h		;5df3
	ld e,a			;5df5
	ld a,d			;5df6
	ld hl,0e608h		;5df7   ; ... recien pulsadas, en D...
	ld c,(hl)			;5dfa
	ld (hl),a			;5dfb
	xor c			;5dfc
	and (hl)			;5dfd
	ld d,a			;5dfe
	ld a,e			;5dff
	inc hl			;5e00   ; ... y E
	ld c,(hl)			;5e01
	ld (hl),a			;5e02
	xor c			;5e03
	and (hl)			;5e04
	ld e,a			;5e05
	or d			;5e06
	ret			;5e07
bcd_a_binario:
	ld hl,0e60fh		;5e08   ; 0xE60F en BCD...
	ld a,(hl)			;5e0b
	ld c,a			;5e0c
	rrca			;5e0d   ; ... las decenas por diez...
	rrca			;5e0e
	rrca			;5e0f
	rrca			;5e10
	and 00fh		;5e11
	add a,a			;5e13
	ld b,a			;5e14
	add a,a			;5e15
	add a,a			;5e16
	add a,b			;5e17
	ld b,a			;5e18
	ld a,c			;5e19   ; ... mas las unidades, a 0xE60E
	and 00fh		;5e1a
	add a,b			;5e1c
	ld (0e60eh),a		;5e1d
	ret			;5e20
return_recien_pulsada:
	ld a,007h		;5e21   ; la fila 7, el bit 7: RETURN
	call 00141h		;5e23   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5e26
	and 080h		;5e27
	ld hl,0e60ah		;5e29
	ld c,(hl)			;5e2c
	ld (hl),a			;5e2d
	xor c			;5e2e
	and (hl)			;5e2f
	ret			;5e30

; ----------------------------------------------------------------------
; LO QUE DA EL GAME MASTER al empezar (0xE604): el bit 0, la fase (de 0 a 18; si no, 0), la del marcador (hasta 0x18 en BCD) y su bloque (0x5E6A), desde la habitacion 0; el bit 1, las vidas.
; ----------------------------------------------------------------------
lo_que_da_el_game_master:
	rra			;5e31   ; el bit 0...
	push af			;5e32
	jr nc,las_vidas_del_game_master		;5e33
	ld a,(0e606h)		;5e35   ; ... la fase, menos de 19...
	cp 013h		;5e38
	jr c,L_5E3D		;5e3a
	xor a			;5e3c
L_5E3D:
	ld (0d000h),a		;5e3d   ; guarda la FASE (0 el patio, 1-18)
	ld a,(0e605h)		;5e40   ; ... la del marcador...
	cp 019h		;5e43
	jr c,L_5E48		;5e45
	xor a			;5e47
L_5E48:
	ld (0c411h),a		;5e48   ; guarda la fase en BCD, la del marcador
	ld hl,05e6ah		;5e4b   ; ... su bloque...
	ld a,(0d000h)		;5e4e   ; lee la FASE (0 el patio, 1-18)
	call hl_mas_a		;5e51   ; hl_mas_a: HL += A
	ld a,(hl)			;5e54
	ld (0d002h),a		;5e55   ; guarda el bloque de tres fases (0-5)
	xor a			;5e58   ; ... desde la habitacion 0...
	ld (0d001h),a		;5e59   ; guarda la HABITACION dentro de la fase
	inc a			;5e5c   ; ... y 0xC40D a 1
	ld (0c40dh),a		;5e5d
las_vidas_del_game_master:
	pop af			;5e60   ; el bit 1: las vidas
	rra			;5e61
	ret nc			;5e62
	ld a,(0e607h)		;5e63   ; lee las vidas que da el Game Master
	ld (0c410h),a		;5e66   ; guarda las vidas
	ret			;5e69

; ----------------------------------------------------------------------
; DATOS bloque_de_cada_fase: 19 bytes, uno por fase: el bloque de tres fases
;   al que pertenece (0,0,0,0,1,1,1,2...), que p00:5E4B pone en 0xD002 cuando
;   el Game Master elige la fase
;   0x5e6a..0x5e7d  (19 bytes)
DATA_bloque_de_cada_fase:
	defb 000h,000h,000h,000h,001h,001h,001h,002h,002h,002h,003h,003h,003h,004h,004h,004h	; 5e6a  ................
	defb 005h,005h,005h	; 5e7a

; ======================================================================
; CODIGO 0x5e7d..0x5eb5  (56 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; EL CURSOR DEL GAME MASTER: arriba o abajo entre las tres opciones (0xE60B), borrando el de antes (el caracter 0) y pintando el nuevo (0x4F) en la fila 0x28, en la columna de 0x5EB5.
; ----------------------------------------------------------------------
mueve_el_cursor:
	rra			;5e7d   ; arriba (+1) o abajo (-1)
	ld a,001h		;5e7e
	jr nc,cursor_nuevo		;5e80
	ld a,0ffh		;5e82
cursor_nuevo:
	ld b,a			;5e84
	ld hl,0e60bh		;5e85   ; la opcion nueva...
	add a,(hl)			;5e88
	and 003h		;5e89
	cp 003h		;5e8b   ; ... en la vuelta, la 0 o la 2
	jr nz,pinta_el_cursor		;5e8d
	ld a,b			;5e8f
	add a,a			;5e90
	ld a,002h		;5e91
	jr c,pinta_el_cursor		;5e93
	xor a			;5e95
pinta_el_cursor:
	push af			;5e96
	push hl			;5e97
	ld a,(hl)			;5e98   ; borra el de antes...
	call borra_el_cursor		;5e99
	pop hl			;5e9c
	pop af			;5e9d
	ld (hl),a			;5e9e   ; ... y pinta el nuevo
	jp el_cursor		;5e9f
borra_el_cursor:
	ld b,000h		;5ea2   ; el caracter 0
	jr caracter_en_la_opcion		;5ea4
el_cursor:
	ld b,04fh		;5ea6   ; el caracter 0x4F
caracter_en_la_opcion:
	ld hl,05eb5h		;5ea8   ; la columna de la opcion...
	call hl_mas_a		;5eab   ; hl_mas_a: HL += A
	ld e,(hl)			;5eae
	ld d,028h		;5eaf   ; ... en la fila 0x28
	ld a,b			;5eb1
	jp pinta_una_letra		;5eb2

; ----------------------------------------------------------------------
; DATOS tres_columnas: tres columnas en las que p00:5EA8 pinta, en la fila
;   0x28, los digitos del menu del Game Master
;   0x5eb5..0x5eb8  (3 bytes)
DATA_tres_columnas:
	defb 0b0h,0b8h,0c0h	; 5eb5

; ======================================================================
; CODIGO 0x5eb8..0x5fcc  (276 bytes)
; ======================================================================


lo_que_sale_en_la_habitacion:
	ld a,(0c440h)		;5eb8   ; LO QUE SALE: no con 0xC440...
	and a			;5ebb
	ret nz			;5ebc
	ld a,(0c420h)		;5ebd   ; ... ni con Simon en la pose 6...
	cp 006h		;5ec0
	ret z			;5ec2
	ld a,(0c5ach)		;5ec3   ; ... ni con la puerta de la fase en los estados 2, 3 y 5
	sub 002h		;5ec6
	ret z			;5ec8
	dec a			;5ec9
	ret z			;5eca
	cp 002h		;5ecb
	ret z			;5ecd
	di			;5ece
	ld a,00eh		;5ecf
	ld (08000h),a		;5ed1   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;5ed4   ; guarda la copia del banco de 0x8000
	ei			;5ed7
	ld a,(0d000h)		;5ed8   ; el byte de la habitacion en 0x85A6 (banco 14)
	ld de,085a6h		;5edb
	call 06542h		;5ede   ; palabra_de_la_tabla: DE = la palabra A de la tabla de DE
	ld a,(0d001h)		;5ee1   ; lee la HABITACION dentro de la fase
	call de_mas_a		;5ee4   ; de_mas_a: DE += A
	ld a,(de)			;5ee7
	push af			;5ee8
	di			;5ee9
	ld a,002h		;5eea
	ld (08000h),a		;5eec   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;5eef   ; guarda la copia del banco de 0x8000
	ei			;5ef2
	pop af			;5ef3   ; un bit por generador
	rra			;5ef4
	push af			;5ef5
	call c,09ce6h		;5ef6
	pop af			;5ef9
	rra			;5efa
	push af			;5efb
	call c,09d4bh		;5efc
	pop af			;5eff
	rra			;5f00
	push af			;5f01
	call c,09d52h		;5f02
	pop af			;5f05
	rra			;5f06
	push af			;5f07
	call c,09d97h		;5f08
	pop af			;5f0b
	rra			;5f0c
	push af			;5f0d
	call c,09dc3h		;5f0e
	pop af			;5f11
	rra			;5f12
	push af			;5f13
	call c,09dd5h		;5f14
	pop af			;5f17
	rra			;5f18
	jp c,09de7h		;5f19
	ret			;5f1c

; ----------------------------------------------------------------------
; CREA UNA COSA del tipo C en (D = x, E = y) en la lista de 0xC800 (A y B, con 0x5F1F, a los bytes 0x0F y 0x1F): busca una ficha libre de las siete, sus sprites libres (tantos como dice 0x6058 por tipo, entre los catorce desde el 0x0E, en la copia de 0xD638), y la rellena: tipo, paso 0, posicion, colores (0x6084), vida (0x60E1) y el nacer de su tipo (0x5FCC).
; ----------------------------------------------------------------------
crea_una_cosa:
	xor a			;5f1d   ; sin bytes 0x0F ni 0x1F
	ld b,a			;5f1e
L_5F1F:
	ld (0cffah),a		;5f1f   ; A al byte 0x0F...
	ld a,b			;5f22   ; ... y B al 0x1F
	ld (0cffbh),a		;5f23
	xor a			;5f26   ; aun no creada (0xCF31)
	ld (0cf31h),a		;5f27
	ld a,c			;5f2a
	ld (0cff0h),a		;5f2b   ; guarda el tipo de la cosa que se crea
	ld (0cff1h),de		;5f2e   ; guarda la posicion de la cosa que se crea
	ld hl,0c800h		;5f32   ; una ficha libre de las siete de 0xC800
	ld b,007h		;5f35
	xor a			;5f37
	ld de,00080h		;5f38
L_5F3B:
	cp (hl)			;5f3b   ; libre?
	jr z,L_5F42		;5f3c
	add hl,de			;5f3e   ; no: la siguiente
	djnz L_5F3B		;5f3f
	ret			;5f41   ; (ninguna: no se crea)
L_5F42:
	push hl			;5f42   ; IX = la ficha
	pop ix		;5f43
	ld (0cff3h),hl		;5f45   ; guarda la ficha de la cosa que se crea
	ld a,(0cff0h)		;5f48   ; cuantos sprites lleva, de 0x6058
	ld hl,06057h		;5f4b
	call hl_mas_a		;5f4e   ; hl_mas_a: HL += A
	ld a,(hl)			;5f51
	ld (ix+020h),a		;5f52   ; guarda cuantos sprites lleva la cosa
	ld c,a			;5f55
	and a			;5f56   ; ninguno: a rellenar
	jr z,rellena_la_cosa		;5f57
	ld de,00000h		;5f59   ; D = el sprite, contando desde el 0x0E; E = el de la ficha
	ld hl,0d638h		;5f5c   ; en la copia de los atributos...
	ld b,00eh		;5f5f   ; ... catorce
L_5F61:
	ld a,(hl)			;5f61   ; libre (y = 0xE0)?
	cp 0e0h		;5f62
	jr nz,sprite_siguiente		;5f64
	ld (hl),0e1h		;5f66   ; si: ocupado (0xE1)...
	call 06048h		;5f68   ; ... y apuntado en la ficha
	inc e			;5f6b   ; el siguiente de la ficha
	dec c			;5f6c   ; todos?
	jr z,rellena_la_cosa		;5f6d
sprite_siguiente:
	inc d			;5f6f   ; el numero siguiente...
	inc l			;5f70   ; ... cuatro bytes mas alla
	inc l			;5f71
	inc l			;5f72
	inc l			;5f73
	djnz L_5F61		;5f74
	ret			;5f76   ; (no hay bastantes: no se crea)
rellena_la_cosa:
	ld a,001h		;5f77   ; creada (0xCF31)
	ld (0cf31h),a		;5f79
	ld hl,(0cff3h)		;5f7c   ; lee la ficha de la cosa que se crea
	ld a,(0cff0h)		;5f7f   ; lee el tipo de la cosa que se crea
	ld (hl),a			;5f82   ; el tipo...
	inc l			;5f83
	ld (hl),000h		;5f84   ; ... el paso 0...
	ld de,(0cff1h)		;5f86   ; lee la posicion de la cosa que se crea
	inc l			;5f8a
	ld (hl),000h		;5f8b   ; ... la y...
	inc l			;5f8d
	ld (hl),e			;5f8e
	inc l			;5f8f
	ld (hl),000h		;5f90
	inc l			;5f92   ; ... y la x
	ld (hl),d			;5f93
	inc l			;5f94
	ld (hl),000h		;5f95
	ld a,(0cffah)		;5f97   ; los bytes 0x0F...
	ld (ix+00fh),a		;5f9a
	ld a,(0cffbh)		;5f9d   ; ... y 0x1F
	ld (ix+01fh),a		;5fa0
	ld (ix+07eh),001h		;5fa3   ; se para con el reloj
	ld (ix+07fh),001h		;5fa7
	ld (ix+00eh),007h		;5fab   ; (byte 0x0E a 7)
	ld de,06084h		;5faf   ; los colores de sus sprites
	call 06029h		;5fb2
	ld a,(0cff0h)		;5fb5   ; su vida, de 0x60E1
	ld de,060e1h		;5fb8
	call de_mas_a		;5fbb   ; de_mas_a: DE += A
	ld a,(de)			;5fbe
	ld (ix+00dh),a		;5fbf   ; guarda la vida de la cosa
	ld hl,(0cff3h)		;5fc2   ; lee la ficha de la cosa que se crea
	ld a,(ix+000h)		;5fc5   ; y lo de nacer de su tipo
	dec a			;5fc8
	call despacha		;5fc9   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_5FCC: 46 destinos del despachador de 0x406B (call en p00:5FC9):
;   0xA934, 0xA2E0, 0xA2E0, 0xB0CA, 0xA85C, 0xA573, 0xB061, 0xA4FB ...; lo
;   leen p00:5FC9 (52 bytes)
;   0x5fcc..0x6000  (52 bytes)
DATA_tabla_5FCC:
	defb 034h,0a9h	; 5fcc
	defb 0e0h,0a2h	; 5fce
	defb 0e0h,0a2h	; 5fd0
	defb 0cah,0b0h	; 5fd2
	defb 05ch,0a8h	; 5fd4
	defb 073h,0a5h	; 5fd6
	defb 061h,0b0h	; 5fd8
	defb 0fbh,0a4h	; 5fda
	defb 04ah,0afh	; 5fdc
	defb 022h,0a2h	; 5fde
	defb 044h,0b3h	; 5fe0
	defb 070h,0a6h	; 5fe2
	defb 012h,0b2h	; 5fe4
	defb 0cdh,0aah	; 5fe6
	defb 093h,0b1h	; 5fe8
	defb 0deh,0adh	; 5fea
	defb 022h,0abh	; 5fec
	defb 050h,0beh	; 5fee
	defb 026h,0bdh	; 5ff0
	defb 07ch,0b8h	; 5ff2
	defb 04fh,0bah	; 5ff4
	defb 054h,0bch	; 5ff6
	defb 040h,06ah	; 5ff8
	defb 0ddh,0bah	; 5ffa
	defb 0d2h,0b4h	; 5ffc
	defb 0d2h,0b4h	; 5ffe
