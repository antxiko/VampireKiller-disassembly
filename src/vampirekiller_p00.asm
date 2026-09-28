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
; DATOS sin identificar  0x4000..0x4028  (40 bytes)
DATA_4000:
	defb 041h,042h,075h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  ABu@............
	defb 043h,000h,044h,000h,007h,000h,044h,000h,0e8h,000h,0c0h,004h,000h,011h,0c4h,000h	; 4010  C.D...D.........
	defb 0d0h,012h,010h,0c4h,000h,000h,005h,0c4h	; 4020  ........

; ======================================================================
; CODIGO 0x4028..0x4161  (313 bytes)
; ======================================================================


L_4028:
	di			;4028
	ld a,(0e600h)		;4029
	or a			;402c
	jp nz,L_40C5		;402d
L_4030:
	di			;4030
	ld a,00eh		;4031
	ld (08000h),a		;4033
	ld a,00fh		;4036
	ld (0a000h),a		;4038
	call 08964h		;403b
	di			;403e
	ld a,(0f0f2h)		;403f
	ld (08000h),a		;4042
	ld a,(0f0f3h)		;4045
	ld (0a000h),a		;4048
	ld hl,0c005h		;404b
	bit 0,(hl)		;404e
	jp nz,L_405F		;4050
	inc (hl)			;4053
	ei			;4054
	call L_4B9D		;4055
	call L_414D		;4058
	xor a			;405b
	ld (0c005h),a		;405c
L_405F:
	ei			;405f
	ret			;4060
L_4061:
	add a,l			;4061
	ld l,a			;4062
	ret nc			;4063
	inc h			;4064
	ret			;4065
L_4066:
	add a,e			;4066
	ld e,a			;4067
	ret nc			;4068
	inc d			;4069
	ret			;406a
L_406B:
	pop hl			;406b
	add a,a			;406c
	call L_4061		;406d
	ld e,(hl)			;4070
	inc hl			;4071
	ld d,(hl)			;4072
	ex de,hl			;4073
	jp (hl)			;4074
L_4075:
	di			;4075
	ld sp,0f0f0h		;4076
	call 00138h		;4079   ; BIOS RSLREG - Reads the primary slot register
	rrca			;407c
	rrca			;407d
	and 003h		;407e
	ld c,a			;4080
	ld b,000h		;4081
	ld hl,0fcc1h		;4083
	add hl,bc			;4086
	ld a,(hl)			;4087
	and 080h		;4088
	or c			;408a
	ld c,a			;408b
	inc hl			;408c
	inc hl			;408d
	inc hl			;408e
	inc hl			;408f
	ld a,(hl)			;4090
	and 00ch		;4091
	or c			;4093
	ld h,080h		;4094
	call 00024h		;4096   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,0c000h		;4099
	ld de,0c001h		;409c
	ld bc,030efh		;409f
	ld (hl),000h		;40a2
	ldir		;40a4
	call L_5336		;40a6
	call L_5C92		;40a9
	call L_5336		;40ac
	call L_4B59		;40af
	di			;40b2
	ld a,0c3h		;40b3
	ld (0fd9fh),a		;40b5
	ld hl,L_4028		;40b8
	ld (0fda0h),hl		;40bb
	xor a			;40be
	ld (0f3dbh),a		;40bf
	ei			;40c2
L_40C3:
	jr L_40C3		;40c3
L_40C5:
	ld a,007h		;40c5
	call 00141h		;40c7   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;40ca
	and 010h		;40cb
	ld b,a			;40cd
	ld a,001h		;40ce
	call 00141h		;40d0   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;40d3
	and 080h		;40d4
	or b			;40d6
	ld hl,0e610h		;40d7
	ld c,(hl)			;40da
	ld (hl),a			;40db
	xor c			;40dc
	and (hl)			;40dd
	ld c,a			;40de
	ld hl,0e601h		;40df
	ld a,(hl)			;40e2
	or a			;40e3
	jr nz,L_40F1		;40e4
	bit 4,c		;40e6
	jp z,L_4030		;40e8
	ld (hl),c			;40eb
	call L_4107		;40ec
	ei			;40ef
	ret			;40f0
L_40F1:
	bit 7,c		;40f1
	jp nz,L_40FC		;40f3
	bit 4,c		;40f6
	jr z,L_4102		;40f8
	xor a			;40fa
	ld (hl),a			;40fb
L_40FC:
	call L_4132		;40fc
	jp L_4030		;40ff
L_4102:
	call L_411F		;4102
	ei			;4105
	ret			;4106
L_4107:
	ld a,008h		;4107
	call 00096h		;4109   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e611h),a		;410c
	ld a,009h		;410f
	call 00096h		;4111   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e612h),a		;4114
	ld a,00ah		;4117
	call 00096h		;4119   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e613h),a		;411c
L_411F:
	ld e,000h		;411f
	ld a,008h		;4121
	call 00093h		;4123   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,000h		;4126
	inc a			;4128
	call 00093h		;4129   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,000h		;412c
	inc a			;412e
	jp 00093h		;412f   ; BIOS WRTPSG - Writes data to PSG-register
L_4132:
	ld a,(0e611h)		;4132
	ld e,a			;4135
	ld a,008h		;4136
	call 00093h		;4138   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e612h)		;413b
	ld e,a			;413e
	ld a,009h		;413f
	call 00093h		;4141   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e613h)		;4144
	ld e,a			;4147
	ld a,00ah		;4148
	jp 00093h		;414a   ; BIOS WRTPSG - Writes data to PSG-register
L_414D:
	ld hl,0c003h		;414d
	inc (hl)			;4150
	ld bc,(0c000h)		;4151
	ld a,c			;4155
	cp 003h		;4156
	jr nc,L_415E		;4158
	ld hl,04391h		;415a
	push hl			;415d
L_415E:
	call L_406B		;415e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4161..0x417d  (28 bytes)
DATA_4161:
	defb 07dh,041h,0a0h,041h,0abh,041h,0d1h,041h,02ch,042h,057h,042h,094h,042h,0b2h,042h	; 4161  }A.A.A.A,BWB.B.B
	defb 024h,043h,077h,043h,087h,043h,0dah,043h,0f0h,043h,014h,044h	; 4171  $CwC.C.C.C.D

; ======================================================================
; CODIGO 0x417d..0x4300  (387 bytes)
; ======================================================================


L_417D:
	djnz L_418A		;417d
	call 0624ch		;417f
	ld a,(0c422h)		;4182
	or a			;4185
	ret z			;4186
	xor a			;4187
	jr L_41C9		;4188
L_418A:
	djnz L_4198		;418a
	ld hl,0c004h		;418c
	dec (hl)			;418f
	ret nz			;4190
	call L_4D47		;4191
	xor a			;4194
	jp L_424B		;4195
L_4198:
	call L_47B9		;4198
	call 06202h		;419b
	jr L_41CC		;419e
L_41A0:
	ld hl,0c004h		;41a0
	dec (hl)			;41a3
	ret nz			;41a4
	call 07ae7h		;41a5
	jp L_4249		;41a8
L_41AB:
	djnz L_41C1		;41ab
	call L_4E20		;41ad
	ld a,(0c413h)		;41b0
	or a			;41b3
	ret nz			;41b4
L_41B5:
	xor a			;41b5
L_41B6:
	ld (0c000h),a		;41b6
	ld a,020h		;41b9
	ld (0c004h),a		;41bb
	jp L_4252		;41be
L_41C1:
	call L_47B9		;41c1
	call L_4DE7		;41c4
	ld a,020h		;41c7
L_41C9:
	ld (0c004h),a		;41c9
L_41CC:
	ld hl,0c001h		;41cc
	inc (hl)			;41cf
	ret			;41d0
L_41D1:
	djnz L_41E4		;41d1
	ld hl,0c004h		;41d3
	dec (hl)			;41d6
	jr z,L_41CC		;41d7
	bit 2,(hl)		;41d9
	ld hl,04d29h		;41db
	jp z,L_4ACB		;41de
	jp L_4ACF		;41e1
L_41E4:
	djnz L_41EC		;41e4
	call L_44C6		;41e6
	jp L_41CC		;41e9
L_41EC:
	djnz L_41FB		;41ec
	ld a,001h		;41ee
	ld (0c41ah),a		;41f0
	call 063d3h		;41f3
	ld a,0a0h		;41f6
	jp L_41C9		;41f8
L_41FB:
	djnz L_4222		;41fb
	call L_4E93		;41fd
	ld hl,0c004h		;4200
	ld a,(0c003h)		;4203
	rra			;4206
	ret c			;4207
	dec (hl)			;4208
	ret nz			;4209
	call L_47F0		;420a
	xor a			;420d
	ld (0c41ah),a		;420e
	call 062d0h		;4211
	ld hl,0e604h		;4214
	ld a,(hl)			;4217
	or a			;4218
	jr z,L_4220		;4219
	ld (hl),000h		;421b
	call L_5E31		;421d
L_4220:
	jr L_4249		;4220
L_4222:
	ld a,08ah		;4222
	call L_509F		;4224
	ld a,050h		;4227
	jp L_41C9		;4229
L_422C:
	ld hl,0c410h		;422c
	ld a,(hl)			;422f
	sub 001h		;4230
	daa			;4232
	ld (hl),a			;4233
	call L_47D4		;4234
	call L_4513		;4237
	call 062e6h		;423a
	ld hl,0c413h		;423d
	ld (hl),001h		;4240
	call 0794fh		;4242
	xor a			;4245
	ld (0c40dh),a		;4246
L_4249:
	ld a,020h		;4249
L_424B:
	ld (0c004h),a		;424b
	ld hl,0c000h		;424e
	inc (hl)			;4251
L_4252:
	xor a			;4252
	ld (0c001h),a		;4253
	ret			;4256
L_4257:
	call L_5C25		;4257
	ld a,(0c40ch)		;425a
	or a			;425d
	ld a,00ch		;425e
	jp nz,L_41B6		;4260
	ld a,(0c40ah)		;4263
	and a			;4266
	jp nz,L_428C		;4267
	ld a,(0c41bh)		;426a
	and a			;426d
	ld a,009h		;426e
	jp nz,L_41B6		;4270
	ld a,(0c408h)		;4273
	or a			;4276
	ld a,00ah		;4277
	jp nz,L_41B6		;4279
	ld a,(0c409h)		;427c
	and a			;427f
	ld a,008h		;4280
	jp nz,L_41B6		;4282
	ld a,(0c413h)		;4285
	or a			;4288
	ret nz			;4289
	jr L_4249		;428a
L_428C:
	call L_4495		;428c
	ld a,00bh		;428f
	jp L_41B6		;4291
L_4294:
	ld hl,0c410h		;4294
	ld a,(hl)			;4297
	or a			;4298
	jr z,L_42AB		;4299
L_429B:
	call 062d0h		;429b
	xor a			;429e
	ld (0c420h),a		;429f
	inc a			;42a2
	ld (0c40dh),a		;42a3
	ld a,004h		;42a6
	jp L_41B6		;42a8
L_42AB:
	ld a,08bh		;42ab
	call L_509F		;42ad
	jr L_4249		;42b0
L_42B2:
	djnz L_42E3		;42b2
	ld a,(0e600h)		;42b4
	or a			;42b7
	jr z,L_42BF		;42b8
	call L_4314		;42ba
	jr nz,L_42D3		;42bd
L_42BF:
	ld a,(0c0a7h)		;42bf
	and a			;42c2
	ret nz			;42c3
	ld hl,0c004h		;42c4
	dec (hl)			;42c7
	ret nz			;42c8
	ld hl,0c002h		;42c9
	ld a,(hl)			;42cc
	and 0bfh		;42cd
	ld (hl),a			;42cf
	jp L_41B5		;42d0
L_42D3:
	ld a,003h		;42d3
	ld (0c410h),a		;42d5
	xor a			;42d8
	ld h,a			;42d9
	ld l,a			;42da
	ld (0c405h),hl		;42db
	ld (0c407h),a		;42de
	jr L_429B		;42e1
L_42E3:
	call L_47B9		;42e3
	ld hl,04d3ah		;42e6
	call L_4ACB		;42e9
	ld a,(0e600h)		;42ec
	or a			;42ef
	jr z,L_42F8		;42f0
	ld hl,04300h		;42f2
	call L_4ACB		;42f5
L_42F8:
	call L_4513		;42f8
	ld a,078h		;42fb
	jp L_41C9		;42fd

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4300..0x4314  (20 bytes)
DATA_4300:
	defb 050h,068h,036h,025h,0feh,064h,068h,04fh,0feh,070h,068h,033h,03fh,03eh,044h,039h	; 4300  Ph6%.dhO.ph3?>D9
	defb 03eh,045h,035h,0ffh	; 4310

; ======================================================================
; CODIGO 0x4314..0x4369  (85 bytes)
; ======================================================================


L_4314:
	ld a,007h		;4314
	call 00141h		;4316   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4319
	and 002h		;431a
	ld hl,0e614h		;431c
	ld c,(hl)			;431f
	ld (hl),a			;4320
	xor c			;4321
	and (hl)			;4322
	ret			;4323
L_4324:
	djnz $+76		;4324
	ld hl,0d002h		;4326
	inc (hl)			;4329
	ld a,006h		;432a
	sub (hl)			;432c
	jr nz,L_4344		;432d
	ld (hl),a			;432f
	ld a,0ffh		;4330
	ld (0d000h),a		;4332
	ld a,020h		;4335
	ld (0c415h),a		;4337
	ld hl,0cf34h		;433a
	inc (hl)			;433d
	ld a,(hl)			;433e
	cp 002h		;433f
	jp z,L_41B5		;4341
L_4344:
	call 062d5h		;4344
L_4347:
	ld hl,0c410h		;4347
	ld a,(hl)			;434a
	add a,001h		;434b
	daa			;434d
	ld (hl),a			;434e
	ld hl,0c411h		;434f
	ld a,(hl)			;4352
	add a,001h		;4353
	daa			;4355
	ld (hl),a			;4356
	ld hl,0d000h		;4357
	inc (hl)			;435a
	inc hl			;435b
	xor a			;435c
	ld (hl),a			;435d
	ld (0c409h),a		;435e
	ld (0c408h),a		;4361
	ld a,004h		;4364
	jp L_41B6		;4366

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4369..0x4370  (7 bytes)
DATA_4369:
	defb 021h,000h,000h,022h,000h,0c0h,0c9h	; 4369

; ======================================================================
; CODIGO 0x4370..0x44b0  (320 bytes)
; ======================================================================


L_4370:
	call L_47B9		;4370
	xor a			;4373
	jp L_41C9		;4374
L_4377:
	call L_5A2E		;4377
	ld a,006h		;437a
	jp nc,L_41B6		;437c
	call 062f5h		;437f
	ld a,005h		;4382
	jp L_41B6		;4384
L_4387:
	ld hl,0c701h		;4387
	ld a,(hl)			;438a
	and 0feh		;438b
	ld (hl),a			;438d
	jp L_4347		;438e
L_4391:
	call L_4BBB		;4391
	ld hl,0c401h		;4394
	call L_4BB4		;4397
	or a			;439a
	ret z			;439b
	ld hl,0c004h		;439c
	ld (hl),000h		;439f
	ld hl,0c000h		;43a1
	ld b,(hl)			;43a4
	djnz L_43BA		;43a5
	and 030h		;43a7
	ret z			;43a9
	ld a,040h		;43aa
	ld (0c002h),a		;43ac
	ld a,(0e600h)		;43af
	or a			;43b2
	jr nz,L_43C4		;43b3
	ld (hl),003h		;43b5
	inc hl			;43b7
	ld (hl),b			;43b8
	ret			;43b9
L_43BA:
	ld (hl),001h		;43ba
	ld a,000h		;43bc
	call L_509F		;43be
	jp L_4D47		;43c1
L_43C4:
	xor a			;43c4
	ld (0e604h),a		;43c5
	ld a,001h		;43c8
	ld (0e605h),a		;43ca
	ld (0e606h),a		;43cd
	ld a,003h		;43d0
	ld (0e607h),a		;43d2
	ld a,00dh		;43d5
	jp L_41B6		;43d7
L_43DA:
	ld a,(0c00bh)		;43da
	rra			;43dd
	ret nc			;43de
	xor a			;43df
	ld (0c40ah),a		;43e0
	call L_44B8		;43e3
	ld a,0feh		;43e6
	call L_509F		;43e8
	ld a,005h		;43eb
	jp L_41B6		;43ed
L_43F0:
	djnz L_43FB		;43f0
	call 094bah		;43f2
	ret nz			;43f5
	ld a,00fh		;43f6
	jp L_41C9		;43f8
L_43FB:
	djnz L_440A		;43fb
	ld hl,0c004h		;43fd
	dec (hl)			;4400
	ret nz			;4401
	call 09507h		;4402
	ld a,005h		;4405
	jp L_41B6		;4407
L_440A:
	xor a			;440a
	ld (0c40ch),a		;440b
	call 09387h		;440e
	jp L_41CC		;4411
L_4414:
	djnz L_444C		;4414
	ld a,(0c006h)		;4416
	and 033h		;4419
	ret z			;441b
	and 003h		;441c
	jp nz,L_5E7D		;441e
	ld a,(0e60bh)		;4421
	or a			;4424
	jp nz,L_4432		;4425
	call L_5CFD		;4428
	ld hl,00003h		;442b
	ld (0c000h),hl		;442e
	ret			;4431
L_4432:
	dec a			;4432
	jr z,L_4440		;4433
	ld hl,0b8b8h		;4435
	ld (0e602h),hl		;4438
	call L_5D82		;443b
	jr L_4449		;443e
L_4440:
	ld hl,0b0b8h		;4440
	ld (0e602h),hl		;4443
	call L_5D61		;4446
L_4449:
	jp L_41CC		;4449
L_444C:
	djnz L_4481		;444c
	call L_5E21		;444e
	jr nz,L_4456		;4451
	jp L_5DB2		;4453
L_4456:
	ld a,(0e60bh)		;4456
	ld b,a			;4459
	ld hl,0e604h		;445a
	or (hl)			;445d
	ld (hl),a			;445e
	ld a,(0e615h)		;445f
	or a			;4462
	jr z,L_4477		;4463
	ld a,(0e60eh)		;4465
	ld d,a			;4468
	ld a,(0e60fh)		;4469
	bit 0,b		;446c
	jr z,L_447C		;446e
	ld (0e605h),a		;4470
	ld a,d			;4473
	ld (0e606h),a		;4474
L_4477:
	xor a			;4477
	ld (0c001h),a		;4478
	ret			;447b
L_447C:
	ld (0e607h),a		;447c
	jr L_4477		;447f
L_4481:
	call L_5CEF		;4481
	xor a			;4484
	ld hl,0e608h		;4485
	ld de,0e609h		;4488
	ld bc,0000eh		;448b
	ld (hl),000h		;448e
	ldir		;4490
	jp L_41CC		;4492
L_4495:
	ld hl,06854h		;4495
	ld bc,03010h		;4498
	ld de,0d070h		;449b
	ld a,004h		;449e
	push hl			;44a0
	push bc			;44a1
	call L_4946		;44a2
	pop bc			;44a5
	pop hl			;44a6
	call L_5D0E		;44a7
	ld hl,044b0h		;44aa
	jp L_4ACB		;44ad

; ----------------------------------------------------------------------
; DATOS sin identificar  0x44b0..0x44b8  (8 bytes)
DATA_44B0:
	defb 06ch,058h,040h,031h,045h,043h,035h,0ffh	; 44b0  lX@1EC5.

; ======================================================================
; CODIGO 0x44b8..0x44e9  (49 bytes)
; ======================================================================


L_44B8:
	ld de,06854h		;44b8
	ld bc,03010h		;44bb
	ld hl,0d070h		;44be
	ld a,001h		;44c1
	jp L_4946		;44c3
L_44C6:
	ld hl,0c405h		;44c6
	ld bc,01bfbh		;44c9
	ld d,h			;44cc
	ld e,l			;44cd
	inc e			;44ce
	ld (hl),000h		;44cf
	ldir		;44d1
	ld hl,044e9h		;44d3
	ld de,0c410h		;44d6
	ld bc,00003h		;44d9
	ldir		;44dc
	ld a,020h		;44de
	ld (0c415h),a		;44e0
	ld a,080h		;44e3
	ld (0c418h),a		;44e5
	ret			;44e8

; ----------------------------------------------------------------------
; DATOS sin identificar  0x44e9..0x44ec  (3 bytes)
DATA_44E9:
	defb 003h,000h,001h	; 44e9

; ======================================================================
; CODIGO 0x44ec..0x4618  (300 bytes)
; ======================================================================


L_44EC:
	ld c,000h		;44ec
L_44EE:
	ld a,(0c002h)		;44ee
	add a,a			;44f1
	ret p			;44f2
	ld hl,0c405h		;44f3
	ld a,(hl)			;44f6
	add a,e			;44f7
	daa			;44f8
	ld (hl),a			;44f9
	inc l			;44fa
	ld a,(hl)			;44fb
	adc a,d			;44fc
	daa			;44fd
	ld (hl),a			;44fe
	inc hl			;44ff
	ld a,(hl)			;4500
	adc a,c			;4501
	daa			;4502
	ld (hl),a			;4503
	jr nc,L_4531		;4504
	ld bc,09999h		;4506
	ld (0c402h),bc		;4509
	ld (0c403h),bc		;450d
	jr L_4531		;4511
L_4513:
	ld hl,04c00h		;4513
	call L_4ACB		;4516
	call L_453B		;4519
	call L_4566		;451c
	call L_456E		;451f
	call L_45B0		;4522
	call L_4545		;4525
	call 08e9ah		;4528
	call 08eb4h		;452b
	call 08ee6h		;452e
L_4531:
	ld hl,0c407h		;4531
	ld de,03800h		;4534
	ld b,003h		;4537
	jr L_4578		;4539
L_453B:
	ld de,09c00h		;453b
	ld hl,0c411h		;453e
	ld b,001h		;4541
	jr L_4578		;4543
L_4545:
	ld hl,07f0bh		;4545
	ld de,01212h		;4548
	ld c,008h		;454b
	call L_48DC		;454d
	ld hl,0930bh		;4550
	ld de,02212h		;4553
	ld c,00eh		;4556
	call L_48DC		;4558
	ld hl,0b70bh		;455b
	ld de,04212h		;455e
	ld c,00eh		;4561
	jp L_48DC		;4563
L_4566:
	ld hl,0c417h		;4566
	ld de,0c000h		;4569
	jr L_4574		;456c
L_456E:
	ld hl,0c410h		;456e
	ld de,0e400h		;4571
L_4574:
	ld b,001h		;4574
	jr L_4578		;4576
L_4578:
	ld a,(hl)			;4578
	rra			;4579
	rra			;457a
	rra			;457b
	rra			;457c
	call L_4588		;457d
	ld a,(hl)			;4580
	call L_4588		;4581
	dec hl			;4584
	djnz L_4578		;4585
	ret			;4587
L_4588:
	and 00fh		;4588
	add a,020h		;458a
	call L_4AE7		;458c
	ld a,d			;458f
	add a,008h		;4590
	ld d,a			;4592
	ret			;4593
L_4594:
	ld hl,0c417h		;4594
	ld a,(hl)			;4597
	add a,b			;4598
	daa			;4599
	jr nc,L_459E		;459a
	ld a,099h		;459c
L_459E:
	jr L_45A9		;459e
L_45A0:
	ld hl,0c417h		;45a0
	ld a,(hl)			;45a3
	cp b			;45a4
	jr c,L_45AD		;45a5
	sub b			;45a7
	daa			;45a8
L_45A9:
	ld (hl),a			;45a9
	jp L_4566		;45aa
L_45AD:
	xor a			;45ad
	jr L_45A9		;45ae
L_45B0:
	call L_45B9		;45b0
L_45B3:
	call L_45BF		;45b3
	jp L_45E5		;45b6
L_45B9:
	call L_45C8		;45b9
	jp L_45D1		;45bc
L_45BF:
	ld hl,03b16h		;45bf
	ld bc,04206h		;45c2
L_45C5:
	jp L_5D0E		;45c5
L_45C8:
	ld hl,03b0dh		;45c8
	ld bc,04206h		;45cb
	jp L_45C5		;45ce
L_45D1:
	ld hl,0c415h		;45d1
	ld a,(hl)			;45d4
	ld hl,03c0eh		;45d5
	add a,a			;45d8
	or a			;45d9
	ret z			;45da
	ld b,a			;45db
	ld c,004h		;45dc
	ld d,000h		;45de
	ld a,011h		;45e0
	jp L_490A		;45e2
L_45E5:
	ld hl,0c418h		;45e5
	ld a,(hl)			;45e8
	ld hl,03c17h		;45e9
	ld b,a			;45ec
	and 003h		;45ed
	ld c,a			;45ef
	ld a,b			;45f0
	and 0fch		;45f1
	rrca			;45f3
	or a			;45f4
	jr nz,L_45FB		;45f5
	or c			;45f7
	ret z			;45f8
	ld a,002h		;45f9
L_45FB:
	ld b,a			;45fb
	ld c,004h		;45fc
	ld d,000h		;45fe
	ld a,088h		;4600
	jp L_490A		;4602
L_4605:
	ld hl,0c415h		;4605
	ld a,(hl)			;4608
	add a,b			;4609
	cp 021h		;460a
	jr c,L_4614		;460c
	ld a,020h		;460e
	sub (hl)			;4610
	ld b,a			;4611
	ld a,020h		;4612
L_4614:
	ld (hl),a			;4614
	jp L_45B9		;4615

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4618..0x462b  (19 bytes)
DATA_4618:
	defb 021h,018h,0c4h,07eh,080h,0feh,081h,038h,006h,03eh,080h,096h,047h,03eh,080h,077h	; 4618  !..~...8.>..G>.w
	defb 0c3h,0b3h,045h	; 4628

; ======================================================================
; CODIGO 0x462b..0x464d  (34 bytes)
; ======================================================================


L_462B:
	ld hl,0c415h		;462b
	ld a,(hl)			;462e
	cp b			;462f
	jr nc,L_4633		;4630
	ld b,a			;4632
L_4633:
	ld a,b			;4633
	or a			;4634
	ret z			;4635
	ld a,(hl)			;4636
	sub b			;4637
	ld (hl),a			;4638
	jp L_45B9		;4639
L_463C:
	ld hl,0c418h		;463c
	ld a,(hl)			;463f
	cp b			;4640
	jr nc,L_4644		;4641
	ld b,a			;4643
L_4644:
	ld a,b			;4644
	or a			;4645
	ret z			;4646
	ld a,(hl)			;4647
	sub b			;4648
	ld (hl),a			;4649
	jp L_45B3		;464a

; ----------------------------------------------------------------------
; DATOS sin identificar  0x464d..0x4651  (4 bytes)
DATA_464D:
	defb 006h,001h,018h,0dah	; 464d

; ======================================================================
; CODIGO 0x4651..0x4656  (5 bytes)
; ======================================================================


L_4651:
	ld b,001h		;4651
	jp L_4605		;4653

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4656..0x465a  (4 bytes)
DATA_4656:
	defb 006h,001h,018h,0e2h	; 4656

; ======================================================================
; CODIGO 0x465a..0x46a1  (71 bytes)
; ======================================================================


L_465A:
	call L_46CE		;465a
	call L_466D		;465d
	ex af,af'			;4660
	ld a,(00006h)		;4661
	ld c,a			;4664
	ex af,af'			;4665
L_4666:
	inir		;4666
	dec a			;4668
	jr nz,L_4666		;4669
	ex de,hl			;466b
	ret			;466c
L_466D:
	ex de,hl			;466d
	ld a,c			;466e
	or a			;466f
	ld a,b			;4670
	ld b,c			;4671
	ret z			;4672
	inc a			;4673
	ret			;4674
L_4675:
	ex de,hl			;4675
	call L_46AF		;4676
	call L_466D		;4679
	ex af,af'			;467c
	ld a,(00007h)		;467d
	ld c,a			;4680
	ex af,af'			;4681
L_4682:
	otir		;4682
	dec a			;4684
	jr nz,L_4682		;4685
	ret			;4687
L_4688:
	push de			;4688
	push af			;4689
	call L_46AF		;468a
	ld d,c			;468d
	ld a,c			;468e
	or a			;468f
	jr z,L_4693		;4690
	inc b			;4692
L_4693:
	ld a,(00007h)		;4693
	ld c,a			;4696
	pop af			;4697
L_4698:
	out (c),a		;4698
	dec d			;469a
	jr nz,L_4698		;469b
	djnz L_4698		;469d
	pop de			;469f
	ret			;46a0

; ----------------------------------------------------------------------
; DATOS sin identificar  0x46a1..0x46af  (14 bytes)
DATA_46A1:
	defb 0c5h,0f5h,0cdh,0afh,046h,03ah,007h,000h,04fh,0f1h,0edh,079h,0c1h,0c9h	; 46a1  ....F:..O..y..

; ======================================================================
; CODIGO 0x46af..0x4b00  (1105 bytes)
; ======================================================================


L_46AF:
	push bc			;46af
	ld a,(00007h)		;46b0
	inc a			;46b3
	ld c,a			;46b4
	ld a,h			;46b5
	rlca			;46b6
	rlca			;46b7
	and 003h		;46b8
	di			;46ba
	out (c),a		;46bb
	ld a,08eh		;46bd
	out (c),a		;46bf
	ld a,l			;46c1
	out (c),a		;46c2
	ld a,h			;46c4
	and 03fh		;46c5
	or 040h		;46c7
	out (c),a		;46c9
	pop bc			;46cb
	ei			;46cc
	ret			;46cd
L_46CE:
	push bc			;46ce
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
	ld a,h			;46e3
	and 03fh		;46e4
	out (c),a		;46e6
	pop bc			;46e8
	ei			;46e9
	ret			;46ea
L_46EB:
	ex de,hl			;46eb
	ld e,(hl)			;46ec
	inc hl			;46ed
	ld d,(hl)			;46ee
	inc hl			;46ef
	ex de,hl			;46f0
L_46F1:
	call L_46AF		;46f1
	ld a,(00007h)		;46f4
	ld c,a			;46f7
L_46F8:
	ld a,(de)			;46f8
	and a			;46f9
	ret z			;46fa
	inc de			;46fb
	ld b,a			;46fc
	and 07fh		;46fd
	cp b			;46ff
	jr z,L_470C		;4700
	and a			;4702
	jr z,L_46EB		;4703
	ex de,hl			;4705
	ld b,a			;4706
	otir		;4707
	ex de,hl			;4709
	jr L_46F8		;470a
L_470C:
	ld a,(de)			;470c
	inc de			;470d
L_470E:
	out (c),a		;470e
	djnz L_470E		;4710
	jr L_46F8		;4712
L_4714:
	ld a,(hl)			;4714
	inc hl			;4715
	inc a			;4716
	ret z			;4717
	dec a			;4718
	or a			;4719
	jr z,L_4724		;471a
	dec a			;471c
	jr z,L_4729		;471d
	call L_476B		;471f
	jr L_4714		;4722
L_4724:
	call L_472E		;4724
	jr L_4714		;4727
L_4729:
	call L_473E		;4729
	jr L_4714		;472c
L_472E:
	ld e,(hl)			;472e
	inc hl			;472f
	ld d,(hl)			;4730
	inc hl			;4731
	ld a,(hl)			;4732
	inc hl			;4733
	ld b,(hl)			;4734
	inc hl			;4735
	push hl			;4736
	ld l,a			;4737
	ld h,b			;4738
	call L_46F1		;4739
	pop hl			;473c
	ret			;473d
L_473E:
	ld e,(hl)			;473e
	inc hl			;473f
	ld d,(hl)			;4740
	inc hl			;4741
	ld a,(hl)			;4742
	inc hl			;4743
	push hl			;4744
	ld l,a			;4745
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
	ld de,0e800h		;4752
	call L_465A		;4755
	pop af			;4758
	call L_477F		;4759
	pop bc			;475c
	pop hl			;475d
	ld e,(hl)			;475e
	inc hl			;475f
	ld d,(hl)			;4760
	inc hl			;4761
	push hl			;4762
	ld hl,0ec00h		;4763
	call L_4675		;4766
	pop hl			;4769
	ret			;476a
L_476B:
	ld e,(hl)			;476b
	inc hl			;476c
	ld d,(hl)			;476d
	inc hl			;476e
	ld c,(hl)			;476f
	inc hl			;4770
	ld b,(hl)			;4771
	inc hl			;4772
	ld a,(hl)			;4773
	inc hl			;4774
	push hl			;4775
	ld h,(hl)			;4776
	ld l,a			;4777
	ex de,hl			;4778
	call L_4675		;4779
	pop hl			;477c
	inc hl			;477d
	ret			;477e
L_477F:
	ld hl,0e800h		;477f
	ld de,0ec10h		;4782
	ld c,a			;4785
L_4786:
	call L_479D		;4786
	ld a,0e0h		;4789
	add a,e			;478b
	ld e,a			;478c
	jr c,L_4790		;478d
	dec d			;478f
L_4790:
	call L_479D		;4790
	ld a,020h		;4793
	call L_4066		;4795
	dec c			;4798
	jp nz,L_4786		;4799
	ret			;479c
L_479D:
	ld b,010h		;479d
L_479F:
	ld a,(hl)			;479f
	inc hl			;47a0
	exx			;47a1
	ld c,a			;47a2
	ld a,001h		;47a3
L_47A5:
	rr c		;47a5
	rla			;47a7
	jp nc,L_47A5		;47a8
	exx			;47ab
	ld (de),a			;47ac
	inc de			;47ad
	djnz L_479F		;47ae
	ret			;47b0
L_47B1:
	call L_47F0		;47b1
	ld bc,00000h		;47b4
	jr L_47BF		;47b7
L_47B9:
	call L_47F0		;47b9
	ld bc,000d4h		;47bc
L_47BF:
	push bc			;47bf
	call L_47D4		;47c0
	pop bc			;47c3
	call L_47E1		;47c4
L_47C7:
	ld a,(0f3e0h)		;47c7
	or 040h		;47ca
	ld b,a			;47cc
	ld c,001h		;47cd
	call 00047h		;47cf   ; BIOS WRTVDP - Writes data in the VDP-register
	jr L_4809		;47d2
L_47D4:
	ld a,(0f3e0h)		;47d4
	and 0bfh		;47d7
	ld b,a			;47d9
	ld c,001h		;47da
	call 00047h		;47dc   ; BIOS WRTVDP - Writes data in the VDP-register
	jr L_47FE		;47df
L_47E1:
	ld hl,00000h		;47e1
	xor a			;47e4
	ld d,a			;47e5
	call L_490A		;47e6
	ld b,000h		;47e9
	ld c,017h		;47eb
	jp 00047h		;47ed   ; BIOS WRTVDP - Writes data in the VDP-register
L_47F0:
	ld hl,0f600h		;47f0
	ld a,0e0h		;47f3
	ld bc,00080h		;47f5
	call L_4688		;47f8
	jp 063c5h		;47fb
L_47FE:
	ld a,(0ffe7h)		;47fe
	or 002h		;4801
	ld b,a			;4803
	ld c,008h		;4804
	jp 00047h		;4806   ; BIOS WRTVDP - Writes data in the VDP-register
L_4809:
	ld a,(0ffe7h)		;4809
	and 0fdh		;480c
	ld b,a			;480e
	ld c,008h		;480f
	jp 00047h		;4811   ; BIOS WRTVDP - Writes data in the VDP-register
L_4814:
	push bc			;4814
	push hl			;4815
	ld b,a			;4816
	ld a,(00007h)		;4817
	inc a			;481a
	ld c,a			;481b
	di			;481c
	out (c),b		;481d
	ld a,090h		;481f
	out (c),a		;4821
	inc c			;4823
	out (c),d		;4824
	push af			;4826
	pop af			;4827
	out (c),e		;4828
	dec c			;482a
	ld hl,0f680h		;482b
	ld a,b			;482e
	add a,a			;482f
	add a,l			;4830
	ld l,a			;4831
	call L_46AF		;4832
	dec c			;4835
	out (c),d		;4836
	out (c),e		;4838
	pop hl			;483a
	pop bc			;483b
	ei			;483c
	ret			;483d
L_483E:
	ld a,(hl)			;483e
	inc hl			;483f
	inc a			;4840
	ret z			;4841
	dec a			;4842
	ld d,(hl)			;4843
	inc hl			;4844
	ld e,(hl)			;4845
	inc hl			;4846
	call L_4814		;4847
	jr L_483E		;484a
L_484C:
	ld a,002h		;484c
	call L_4855		;484e
	rra			;4851
	jr c,L_484C		;4852
	ret			;4854
L_4855:
	push bc			;4855
	push hl			;4856
	ld hl,(00006h)		;4857
	inc h			;485a
	inc l			;485b
	ld c,h			;485c
	di			;485d
	out (c),a		;485e
	ld a,08fh		;4860
	out (c),a		;4862
	ld c,l			;4864
	in a,(c)		;4865
	push af			;4867
	xor a			;4868
	ld c,h			;4869
	out (c),a		;486a
	ld a,08fh		;486c
	out (c),a		;486e
	pop af			;4870
	pop hl			;4871
	pop bc			;4872
	ei			;4873
	ret			;4874
L_4875:
	call L_484C		;4875
	push bc			;4878
	ld a,(00007h)		;4879
	inc a			;487c
	ld c,a			;487d
	ld a,024h		;487e
	di			;4880
	out (c),a		;4881
	ld a,091h		;4883
	out (c),a		;4885
	inc c			;4887
	inc c			;4888
	out (c),h		;4889
	xor a			;488b
	out (c),a		;488c
	out (c),l		;488e
	out (c),a		;4890
	pop hl			;4892
	dec h			;4893
	out (c),h		;4894
	xor a			;4896
	out (c),a		;4897
	xor a			;4899
	out (c),a		;489a
	out (c),a		;489c
	out (c),l		;489e
	out (c),a		;48a0
	ld a,070h		;48a2
	out (c),a		;48a4
	ei			;48a6
	ret			;48a7
L_48A8:
	call L_484C		;48a8
	push bc			;48ab
	ld a,(00007h)		;48ac
	inc a			;48af
	ld c,a			;48b0
	ld a,024h		;48b1
	di			;48b3
	out (c),a		;48b4
	ld a,091h		;48b6
	out (c),a		;48b8
	inc c			;48ba
	inc c			;48bb
	out (c),h		;48bc
	xor a			;48be
	out (c),a		;48bf
	out (c),l		;48c1
	out (c),a		;48c3
	pop hl			;48c5
	dec h			;48c6
	out (c),h		;48c7
	xor a			;48c9
	out (c),a		;48ca
	xor a			;48cc
	out (c),a		;48cd
	out (c),a		;48cf
	out (c),l		;48d1
	inc a			;48d3
	out (c),a		;48d4
	ld a,070h		;48d6
	out (c),a		;48d8
	ei			;48da
	ret			;48db
L_48DC:
	ld b,e			;48dc
	call L_48F6		;48dd
	ld b,d			;48e0
	call L_4900		;48e1
	push hl			;48e4
	ld a,l			;48e5
	dec a			;48e6
	add a,e			;48e7
	ld l,a			;48e8
	ld b,d			;48e9
	call L_4900		;48ea
	pop hl			;48ed
	ld a,h			;48ee
	dec a			;48ef
	add a,d			;48f0
	ld h,a			;48f1
	ld b,e			;48f2
	jp L_48F6		;48f3
L_48F6:
	push hl			;48f6
	push de			;48f7
	push bc			;48f8
	call L_48A8		;48f9
	pop bc			;48fc
	pop de			;48fd
	pop hl			;48fe
	ret			;48ff
L_4900:
	push hl			;4900
	push de			;4901
	push bc			;4902
	call L_4875		;4903
	pop bc			;4906
	pop de			;4907
	pop hl			;4908
	ret			;4909
L_490A:
	ex af,af'			;490a
	call L_484C		;490b
	push bc			;490e
	ld a,(00007h)		;490f
	inc a			;4912
	ld c,a			;4913
	ld a,024h		;4914
	di			;4916
	out (c),a		;4917
	ld a,091h		;4919
	out (c),a		;491b
	inc c			;491d
	inc c			;491e
	out (c),h		;491f
	xor a			;4921
	out (c),a		;4922
	out (c),l		;4924
	out (c),d		;4926
	pop hl			;4928
	out (c),h		;4929
	cp h			;492b
	jr nz,L_492F		;492c
	inc a			;492e
L_492F:
	out (c),a		;492f
	xor a			;4931
	out (c),l		;4932
	cp l			;4934
	jr nz,L_4938		;4935
	inc a			;4937
L_4938:
	out (c),a		;4938
	ex af,af'			;493a
	out (c),a		;493b
	xor a			;493d
	out (c),a		;493e
	ld a,0c0h		;4940
	out (c),a		;4942
	ei			;4944
	ret			;4945
L_4946:
	ex af,af'			;4946
	call L_484C		;4947
	push bc			;494a
	ld a,(00007h)		;494b
	inc a			;494e
	ld c,a			;494f
	ld a,020h		;4950
	di			;4952
	out (c),a		;4953
	ld a,091h		;4955
	out (c),a		;4957
	inc c			;4959
	inc c			;495a
	out (c),h		;495b
	xor a			;495d
	out (c),a		;495e
	out (c),l		;4960
	ex af,af'			;4962
	ld l,a			;4963
	and 003h		;4964
	out (c),a		;4966
	out (c),d		;4968
	xor a			;496a
	out (c),a		;496b
	out (c),e		;496d
	ld a,l			;496f
	rra			;4970
	rra			;4971
	and 003h		;4972
	out (c),a		;4974
	pop hl			;4976
	out (c),h		;4977
	xor a			;4979
	out (c),a		;497a
	out (c),l		;497c
	out (c),a		;497e
	out (c),a		;4980
	out (c),a		;4982
	ld a,0d0h		;4984
	out (c),a		;4986
	ei			;4988
	ret			;4989
L_498A:
	ex af,af'			;498a
	call L_484C		;498b
	push bc			;498e
	ld a,(00007h)		;498f
	inc a			;4992
	ld c,a			;4993
	ld a,024h		;4994
	di			;4996
	out (c),a		;4997
	ld a,091h		;4999
	out (c),a		;499b
	inc c			;499d
	inc c			;499e
	out (c),d		;499f
	xor a			;49a1
	out (c),a		;49a2
	out (c),e		;49a4
	ex af,af'			;49a6
	out (c),a		;49a7
	pop de			;49a9
	out (c),d		;49aa
	xor a			;49ac
	out (c),a		;49ad
	out (c),e		;49af
	out (c),a		;49b1
	ld a,(hl)			;49b3
	inc hl			;49b4
	out (c),a		;49b5
	xor a			;49b7
	out (c),a		;49b8
	ld a,0f0h		;49ba
	out (c),a		;49bc
	dec c			;49be
	dec c			;49bf
	ld a,0ach		;49c0
	out (c),a		;49c2
	ld a,091h		;49c4
	out (c),a		;49c6
	inc c			;49c8
	inc c			;49c9
L_49CA:
	ld a,002h		;49ca
	call L_4855		;49cc
	rra			;49cf
	ret nc			;49d0
	add a,a			;49d1
	add a,a			;49d2
	jr nc,L_49CA		;49d3
	ld a,(hl)			;49d5
	inc hl			;49d6
	out (c),a		;49d7
	jr L_49CA		;49d9
L_49DB:
	ex af,af'			;49db
	call L_484C		;49dc
	push bc			;49df
	ld a,(00007h)		;49e0
	inc a			;49e3
	ld c,a			;49e4
	ld a,020h		;49e5
	di			;49e7
	out (c),a		;49e8
	ld a,091h		;49ea
	out (c),a		;49ec
	inc c			;49ee
	inc c			;49ef
	out (c),h		;49f0
	xor a			;49f2
	out (c),a		;49f3
	out (c),l		;49f5
	ex af,af'			;49f7
	rlca			;49f8
	rlca			;49f9
	ld l,a			;49fa
	and 003h		;49fb
	out (c),a		;49fd
	out (c),d		;49ff
	xor a			;4a01
	out (c),a		;4a02
	out (c),e		;4a04
	ld a,l			;4a06
	ld e,a			;4a07
	rlca			;4a08
	rlca			;4a09
	and 003h		;4a0a
	out (c),a		;4a0c
	pop hl			;4a0e
	out (c),h		;4a0f
	xor a			;4a11
	out (c),a		;4a12
	out (c),l		;4a14
	out (c),a		;4a16
	out (c),a		;4a18
	out (c),a		;4a1a
	ld a,e			;4a1c
	rra			;4a1d
	rra			;4a1e
	and 00fh		;4a1f
	or 090h		;4a21
	out (c),a		;4a23
	ei			;4a25
	ret			;4a26
L_4A27:
	call L_4A30		;4a27
	call L_4B4F		;4a2a
	djnz L_4A27		;4a2d
	ret			;4a2f
L_4A30:
	push bc			;4a30
	push de			;4a31
	push hl			;4a32
	push de			;4a33
	call L_4AA5		;4a34
	pop de			;4a37
	ld b,d			;4a38
	ld d,e			;4a39
	ld e,b			;4a3a
	srl d		;4a3b
	rr e		;4a3d
	ld a,d			;4a3f
	add a,080h		;4a40
	ld d,a			;4a42
	ld hl,0c110h		;4a43
	call L_4A51		;4a46
	pop hl			;4a49
	ld bc,00008h		;4a4a
	add hl,bc			;4a4d
	pop de			;4a4e
	pop bc			;4a4f
	ret			;4a50
L_4A51:
	push de			;4a51
	ld b,008h		;4a52
L_4A54:
	push bc			;4a54
	ld bc,00004h		;4a55
	call L_4675		;4a58
	ex de,hl			;4a5b
	ld bc,00080h		;4a5c
	add hl,bc			;4a5f
	ex de,hl			;4a60
	pop bc			;4a61
	djnz L_4A54		;4a62
	pop de			;4a64
	ret			;4a65
L_4A66:
	push bc			;4a66
	call L_4A51		;4a67
	ld a,004h		;4a6a
	add a,e			;4a6c
	cp 080h		;4a6d
	jr nz,L_4A76		;4a6f
	ld a,004h		;4a71
	add a,d			;4a73
	ld d,a			;4a74
	xor a			;4a75
L_4A76:
	ld e,a			;4a76
	pop bc			;4a77
	djnz L_4A66		;4a78
	ret			;4a7a
L_4A7B:
	push de			;4a7b
	ld b,010h		;4a7c
L_4A7E:
	push bc			;4a7e
	ld bc,00008h		;4a7f
	call L_4675		;4a82
	ex de,hl			;4a85
	ld bc,00080h		;4a86
	add hl,bc			;4a89
	ex de,hl			;4a8a
	pop bc			;4a8b
	djnz L_4A7E		;4a8c
	pop de			;4a8e
	ret			;4a8f
L_4A90:
	push bc			;4a90
	call L_4A7B		;4a91
	ld a,008h		;4a94
	add a,e			;4a96
	cp 080h		;4a97
	jr nz,L_4AA0		;4a99
	ld a,008h		;4a9b
	add a,d			;4a9d
	ld d,a			;4a9e
	xor a			;4a9f
L_4AA0:
	ld e,a			;4aa0
	pop bc			;4aa1
	djnz L_4A90		;4aa2
	ret			;4aa4
L_4AA5:
	ld b,008h		;4aa5
	ld de,0c110h		;4aa7
L_4AAA:
	push bc			;4aaa
	push hl			;4aab
	ex de,hl			;4aac
	ld a,(de)			;4aad
	ld d,a			;4aae
	ld b,004h		;4aaf
L_4AB1:
	ld a,c			;4ab1
	rl d		;4ab2
	jr c,L_4AB7		;4ab4
	xor a			;4ab6
L_4AB7:
	rld		;4ab7
	ld a,c			;4ab9
	rl d		;4aba
	jr c,L_4ABF		;4abc
	xor a			;4abe
L_4ABF:
	rld		;4abf
	inc hl			;4ac1
	djnz L_4AB1		;4ac2
	ex de,hl			;4ac4
	pop hl			;4ac5
	inc hl			;4ac6
	pop bc			;4ac7
	djnz L_4AAA		;4ac8
	ret			;4aca
L_4ACB:
	ld c,0ffh		;4acb
	jr L_4AD1		;4acd
L_4ACF:
	ld c,000h		;4acf
L_4AD1:
	ld d,(hl)			;4ad1
	inc hl			;4ad2
	ld e,(hl)			;4ad3
	inc hl			;4ad4
L_4AD5:
	ld a,(hl)			;4ad5
	inc hl			;4ad6
	ld b,a			;4ad7
	inc b			;4ad8
	ret z			;4ad9
	inc b			;4ada
	jr z,L_4ACB		;4adb
	and c			;4add
	call L_4AE7		;4ade
	ld a,d			;4ae1
	add a,008h		;4ae2
	ld d,a			;4ae4
	jr L_4AD5		;4ae5
L_4AE7:
	push bc			;4ae7
	push hl			;4ae8
	push de			;4ae9
	or a			;4aea
	ld h,a			;4aeb
	jr z,L_4AF3		;4aec
	call L_4B41		;4aee
	add a,038h		;4af1
L_4AF3:
	ld l,a			;4af3
	ld bc,00808h		;4af4
	ld a,001h		;4af7
	call L_4946		;4af9
	pop de			;4afc
	pop hl			;4afd
	pop bc			;4afe
	ret			;4aff

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4b00..0x4b0b  (11 bytes)
DATA_4B00:
	defb 0f5h,0cdh,0e7h,04ah,0cdh,04fh,04bh,0f1h,010h,0f6h,0c9h	; 4b00  ...J.OK....

; ======================================================================
; CODIGO 0x4b0b..0x4b95  (138 bytes)
; ======================================================================


L_4B0B:
	push bc			;4b0b
	push hl			;4b0c
	push de			;4b0d
	call L_4B41		;4b0e
	ld bc,00808h		;4b11
	ld a,001h		;4b14
	call L_4946		;4b16
	pop de			;4b19
	pop hl			;4b1a
	pop bc			;4b1b
	ret			;4b1c
L_4B1D:
	push bc			;4b1d
	push hl			;4b1e
	push de			;4b1f
	call L_4B41		;4b20
	ld bc,00808h		;4b23
	ld a,048h		;4b26
	call L_49DB		;4b28
	pop de			;4b2b
	pop hl			;4b2c
	pop bc			;4b2d
	ret			;4b2e
L_4B2F:
	push bc			;4b2f
	push hl			;4b30
	push de			;4b31
	call L_4B41		;4b32
	ld bc,00808h		;4b35
	ld a,005h		;4b38
	call L_4946		;4b3a
	pop de			;4b3d
	pop hl			;4b3e
	pop bc			;4b3f
	ret			;4b40
L_4B41:
	ld b,a			;4b41
	and 01fh		;4b42
	add a,a			;4b44
	add a,a			;4b45
	add a,a			;4b46
	ld h,a			;4b47
	ld a,b			;4b48
	and 0e0h		;4b49
	rrca			;4b4b
	rrca			;4b4c
	ld l,a			;4b4d
	ret			;4b4e
L_4B4F:
	ld a,d			;4b4f
	add a,008h		;4b50
	ld d,a			;4b52
	ret nz			;4b53
	ld a,e			;4b54
	add a,008h		;4b55
	ld e,a			;4b57
	ret			;4b58
L_4B59:
	call L_5076		;4b59
	call L_47FE		;4b5c
	ld a,005h		;4b5f
	call 0005fh		;4b61   ; BIOS CHGMOD - Switches to given screen mode
	call L_47D4		;4b64
	xor a			;4b67
	ld h,a			;4b68
	ld l,a			;4b69
	ld b,a			;4b6a
	ld c,a			;4b6b
	ld d,a			;4b6c
	call L_490A		;4b6d
	xor a			;4b70
	ld h,a			;4b71
	ld l,a			;4b72
	ld b,a			;4b73
	ld c,a			;4b74
	ld d,001h		;4b75
	call L_490A		;4b77
	call L_484C		;4b7a
	ld b,004h		;4b7d
	ld hl,04b95h		;4b7f
L_4B82:
	push bc			;4b82
	ld c,(hl)			;4b83
	inc hl			;4b84
	ld b,(hl)			;4b85
	inc hl			;4b86
	push hl			;4b87
	call 00047h		;4b88   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;4b8b
	pop bc			;4b8c
	djnz L_4B82		;4b8d
	call L_47F0		;4b8f
	jp L_47C7		;4b92

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4b95..0x4b9d  (8 bytes)
DATA_4B95:
	defb 001h,062h,005h,0efh,006h,01fh,00bh,001h	; 4b95  .b......

; ======================================================================
; CODIGO 0x4b9d..0x4c00  (99 bytes)
; ======================================================================


L_4B9D:
	ld a,(0c002h)		;4b9d
	and 040h		;4ba0
	jp z,L_4E2E		;4ba2
	call L_4BF4		;4ba5
	ld hl,0c00ch		;4ba8
	call L_4BB4		;4bab
	call L_4BBB		;4bae
L_4BB1:
	ld hl,0c007h		;4bb1
L_4BB4:
	ld c,(hl)			;4bb4
	ld (hl),a			;4bb5
	xor c			;4bb6
	and (hl)			;4bb7
	dec hl			;4bb8
	ld (hl),a			;4bb9
	ret			;4bba
L_4BBB:
	ld e,08fh		;4bbb
	ld a,00fh		;4bbd
	call 00093h		;4bbf   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;4bc2
	di			;4bc4
	call 00096h		;4bc5   ; BIOS RDPSG - Reads value from PSG-register
	ei			;4bc8
	cpl			;4bc9
	and 03fh		;4bca
	push af			;4bcc
	ld a,008h		;4bcd
	call 00141h		;4bcf   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4bd2
	ld e,a			;4bd3
	and 020h		;4bd4
	ld e,a			;4bd6
	ld a,008h		;4bd7
	call 00141h		;4bd9   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4bdc
	rrca			;4bdd
	rrca			;4bde
	ld b,a			;4bdf
	and 004h		;4be0
	or e			;4be2
	ld c,a			;4be3
	ld a,b			;4be4
	rrca			;4be5
	rrca			;4be6
	ld b,a			;4be7
	and 018h		;4be8
	or c			;4bea
	ld c,a			;4beb
	ld a,b			;4bec
	rrca			;4bed
	and 003h		;4bee
	or c			;4bf0
	pop bc			;4bf1
	or b			;4bf2
	ret			;4bf3
L_4BF4:
	ld a,006h		;4bf4
	call 00141h		;4bf6   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4bf9
	rlca			;4bfa
	rlca			;4bfb
	rlca			;4bfc
	and 007h		;4bfd
	ret			;4bff

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4c00..0x4d47  (327 bytes)
DATA_4C00:
	defb 008h,000h,043h,033h,03fh,042h,035h,030h,0feh,008h,00ch,040h,03ch,031h,049h,035h	; 4c00  ..C3?B50...@<1I5
	defb 042h,0feh,008h,014h,035h,03eh,035h,03dh,049h,0feh,0b0h,000h,050h,030h,0feh,0d4h	; 4c10  B...5>5=I...P0..
	defb 000h,040h,030h,0feh,06ch,000h,043h,044h,031h,037h,035h,030h,0ffh,060h,038h,043h	; 4c20  .@0.l.CD1750.`8C
	defb 044h,031h,037h,035h,000h,000h,000h,0ffh,002h,0feh,0f8h,003h,004h,0feh,0f8h,005h	; 4c30  D175............
	defb 006h,007h,008h,0feh,000h,009h,00ah,00bh,00ch,00dh,0feh,0f8h,00eh,00fh,001h,001h	; 4c40  ................
	defb 010h,011h,0ffh,02fh,02fh,0feh,0b0h,016h,017h,018h,015h,001h,001h,001h,001h,028h	; 4c50  ...//..........(
	defb 02fh,02fh,012h,013h,014h,015h,0feh,000h,026h,023h,024h,025h,001h,001h,001h,001h	; 4c60  //......&#$%....
	defb 019h,01ah,01bh,022h,023h,024h,025h,0feh,000h,01ch,01dh,01eh,01fh,001h,001h,001h	; 4c70  ..."#$%.........
	defb 001h,029h,02ah,02bh,01ch,01dh,01eh,01fh,0feh,000h,020h,021h,02ch,001h,001h,001h	; 4c80  .)*+...... !,...
	defb 001h,001h,02dh,02eh,027h,020h,021h,02ch,0ffh,067h,012h,013h,014h,015h,016h,017h	; 4c90  ..-.' !,.g......
	defb 018h,019h,01ah,01bh,01ch,01dh,01eh,01fh,020h,021h,0feh,008h,022h,023h,024h,025h	; 4ca0  ........ !.."#$%
	defb 026h,027h,028h,029h,02ah,02bh,02ch,02dh,02eh,02fh,030h,031h,0feh,000h,032h,033h	; 4cb0  &'()*+,-./01..23
	defb 034h,035h,036h,037h,038h,039h,03ah,03bh,03ch,03dh,03eh,03fh,040h,041h,0feh,000h	; 4cc0  456789:;<=>?@A..
	defb 0feh,0f8h,042h,043h,044h,045h,046h,047h,048h,047h,049h,04ah,04bh,04ch,04dh,0feh	; 4cd0  ..BCDEFGHGIJKLM.
	defb 000h,052h,053h,054h,055h,056h,057h,060h,057h,060h,061h,05bh,05ch,05dh,000h,000h	; 4ce0  .RSTUVW`W`a[\]..
	defb 065h,065h,0feh,000h,04eh,04fh,050h,051h,058h,059h,05ah,059h,068h,069h,06ah,05eh	; 4cf0  ee..NOPQXYZYhij^
	defb 05fh,062h,063h,064h,063h,064h,066h,0ffh,048h,088h,02ah,000h,03bh,03fh,03eh,031h	; 4d00  _bcdcdf.H.*.;?>1
	defb 03dh,039h,000h,021h,029h,028h,026h,0feh,048h,0a0h,040h,045h,043h,038h,000h,043h	; 4d10  =9.!)(&.H.@EC8.C
	defb 040h,031h,033h,035h,000h,03bh,035h,049h,0ffh,048h,0a0h,000h,000h,040h,03ch,031h	; 4d20  @135.;5I.H...@<1
	defb 049h,000h,043h,044h,031h,042h,044h,000h,000h,0ffh,058h,058h,037h,031h,03dh,035h	; 4d30  I.CD1BD...XX71=5
	defb 000h,000h,03fh,046h,035h,042h,0ffh	; 4d40

; ======================================================================
; CODIGO 0x4d47..0x4dd7  (144 bytes)
; ======================================================================


L_4D47:
	call L_47D4		;4d47
	call L_4DDB		;4d4a
	call L_484C		;4d4d
	call L_5727		;4d50
	ld b,003h		;4d53
	ld de,06606h		;4d55
L_4D58:
	ld a,00fh		;4d58
	call L_4814		;4d5a
	dec e			;4d5d
	dec e			;4d5e
	ld a,d			;4d5f
	sub 022h		;4d60
	ld d,a			;4d62
	ld hl,00800h		;4d63
L_4D66:
	dec hl			;4d66
	ld a,h			;4d67
	or l			;4d68
	jr nz,L_4D66		;4d69
	djnz L_4D58		;4d6b
	ld b,000h		;4d6d
	ld c,007h		;4d6f
	call 00047h		;4d71   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,00fh		;4d74
	ld de,00700h		;4d76
	call L_4814		;4d79
	call L_47F0		;4d7c
	call L_53B6		;4d7f
	call L_59FB		;4d82
	ld hl,00010h		;4d85
	ld bc,00068h		;4d88
	ld a,0ffh		;4d8b
	ld d,000h		;4d8d
	call L_490A		;4d8f
	ld hl,00516h		;4d92
	call 07acfh		;4d95
	ld hl,00569h		;4d98
	call 07acfh		;4d9b
	ld a,(0002bh)		;4d9e
	and 00fh		;4da1
	jr nz,L_4DBC		;4da3
	ld de,0a818h		;4da5
	ld hl,04c38h		;4da8
	call 07b32h		;4dab
	ld de,0a038h		;4dae
	ld hl,04c53h		;4db1
	call 07b32h		;4db4
	call 07aefh		;4db7
	jr L_4DCE		;4dba
L_4DBC:
	ld de,03828h		;4dbc
	ld hl,04c99h		;4dbf
	call 07b32h		;4dc2
	ld de,0b830h		;4dc5
	ld hl,04c38h		;4dc8
	call 07b32h		;4dcb
L_4DCE:
	ld hl,04d08h		;4dce
	call L_4ACB		;4dd1
	jp L_47C7		;4dd4

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4dd7..0x4ddb  (4 bytes)
DATA_4DD7:
	defb 016h,001h,018h,002h	; 4dd7

; ======================================================================
; CODIGO 0x4ddb..0x4e5d  (130 bytes)
; ======================================================================


L_4DDB:
	ld d,000h		;4ddb
	ld hl,00000h		;4ddd
	ld bc,00000h		;4de0
	xor a			;4de3
	jp L_490A		;4de4
L_4DE7:
	ld hl,0c420h		;4de7
	ld de,0c421h		;4dea
	ld bc,01bdfh		;4ded
	xor a			;4df0
	ld (hl),a			;4df1
	ldir		;4df2
	ld (0c007h),a		;4df4
	ld (0cf3dh),a		;4df7
	ld (0d001h),a		;4dfa
	ld (0d002h),a		;4dfd
	inc a			;4e00
	ld (0c413h),a		;4e01
	ld (0c411h),a		;4e04
	ld (0d000h),a		;4e07
	ld (0cf3ah),a		;4e0a
	ld a,020h		;4e0d
	ld (0c415h),a		;4e0f
	ld a,080h		;4e12
	ld (0c418h),a		;4e14
	call 062d0h		;4e17
	call 062e6h		;4e1a
	jp L_4513		;4e1d
L_4E20:
	call L_5C25		;4e20
	ld a,(0c41bh)		;4e23
	and a			;4e26
	ret z			;4e27
	call L_5A2E		;4e28
	jp 062f5h		;4e2b
L_4E2E:
	ld hl,0cf3ah		;4e2e
	dec (hl)			;4e31
	jr z,L_4E46		;4e32
L_4E34:
	ld a,(0cf3bh)		;4e34
	cp 0ffh		;4e37
	jr z,L_4E41		;4e39
	ld hl,0c007h		;4e3b
	jp L_4BB1		;4e3e
L_4E41:
	xor a			;4e41
	ld (0c413h),a		;4e42
	ret			;4e45
L_4E46:
	inc hl			;4e46
	inc hl			;4e47
	ld c,(hl)			;4e48
	inc (hl)			;4e49
	ld de,04e5dh		;4e4a
	ld l,c			;4e4d
	ld h,000h		;4e4e
	add hl,hl			;4e50
	add hl,de			;4e51
	ld a,(hl)			;4e52
	ld (0cf3ah),a		;4e53
	inc hl			;4e56
	ld a,(hl)			;4e57
	ld (0cf3bh),a		;4e58
	jr L_4E34		;4e5b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4e5d..0x4e93  (54 bytes)
DATA_4E5D:
	defb 016h,000h,02bh,008h,007h,018h,017h,008h,008h,018h,055h,008h,004h,000h,010h,004h	; 4e5d  ..+.......U.....
	defb 009h,000h,041h,021h,022h,029h,007h,039h,025h,029h,02ah,008h,004h,029h,04dh,008h	; 4e6d  ..A!").9%)*..)M.
	defb 00fh,000h,01ah,004h,009h,014h,00fh,004h,007h,000h,05eh,008h,00eh,000h,014h,004h	; 4e7d  ..........^.....
	defb 00fh,000h,04ch,021h,001h,0ffh	; 4e8d

; ======================================================================
; CODIGO 0x4e93..0x4f7f  (236 bytes)
; ======================================================================


L_4E93:
	call 098ech		;4e93
	call 09918h		;4e96
	call 064ech		;4e99
	jp 065a4h		;4e9c
L_4E9F:
	ld c,027h		;4e9f
	ld de,0e048h		;4ea1
	jp L_5F1D		;4ea4
L_4EA7:
	ld (ix+006h),001h		;4ea7
	ld (ix+00bh),094h		;4eab
	ld (ix+00eh),a		;4eaf
	ret			;4eb2
L_4EB3:
	xor a			;4eb3
	ld (ix+008h),a		;4eb4
	ld (ix+007h),a		;4eb7
	ld de,0ffe0h		;4eba
	jp 0a56ch		;4ebd
L_4EC0:
	ld c,028h		;4ec0
	ld de,09038h		;4ec2
	call L_5F1D		;4ec5
	ld c,029h		;4ec8
	ld de,03068h		;4eca
	jp L_5F1D		;4ecd
L_4ED0:
	ld hl,0ffe0h		;4ed0
	ld de,00000h		;4ed3
	bit 0,(ix+000h)		;4ed6
	jr z,L_4EE2		;4eda
	ld hl,00020h		;4edc
	ld de,0fff0h		;4edf
L_4EE2:
	call 0a55dh		;4ee2
	ex de,hl			;4ee5
	call 0a56ch		;4ee6
	ld (ix+006h),001h		;4ee9
	ld (ix+00bh),092h		;4eed
	xor a			;4ef1
	ld (ix+010h),a		;4ef2
	ld (ix+00eh),a		;4ef5
	ret			;4ef8
L_4EF9:
	inc (ix+010h)		;4ef9
	ld a,(ix+010h)		;4efc
	cp 004h		;4eff
	ret nz			;4f01
	ld (ix+010h),000h		;4f02
	inc (ix+011h)		;4f06
	ld (ix+00bh),092h		;4f09
	bit 0,(ix+011h)		;4f0d
	ret z			;4f11
	ld (ix+00bh),093h		;4f12
	ret			;4f16
L_4F17:
	ld c,02ah		;4f17
	ld de,0f0c0h		;4f19
	jp L_5F1D		;4f1c
L_4F1F:
	ld (ix+00bh),098h		;4f1f
	xor a			;4f23
	ld (ix+001h),a		;4f24
	ld (ix+013h),a		;4f27
	ld (ix+014h),a		;4f2a
	ld (ix+00eh),a		;4f2d
	ld (ix+006h),001h		;4f30
	ret			;4f34
L_4F35:
	ld a,(ix+001h)		;4f35
	dec a			;4f38
	jr z,L_4F57		;4f39
	call L_4F60		;4f3b
	xor a			;4f3e
	ld (ix+00ah),0ffh		;4f3f
	ld (ix+009h),080h		;4f43
	ld (ix+008h),a		;4f47
	ld (ix+007h),a		;4f4a
	ld a,(ix+005h)		;4f4d
	cp 080h		;4f50
	ret nc			;4f52
	inc (ix+001h)		;4f53
	ret			;4f56
L_4F57:
	ld (ix+006h),000h		;4f57
	ld (ix+00bh),097h		;4f5b
	ret			;4f5f
L_4F60:
	ld a,(ix+014h)		;4f60
	add a,090h		;4f63
	ld (ix+014h),a		;4f65
	jr nc,L_4F6D		;4f68
	inc (ix+013h)		;4f6a
L_4F6D:
	ld a,(ix+013h)		;4f6d
	rra			;4f70
	rra			;4f71
	and 003h		;4f72
	ld hl,04f7fh		;4f74
	call L_4061		;4f77
	ld a,(hl)			;4f7a
	ld (ix+00bh),a		;4f7b
	ret			;4f7e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4f7f..0x4f83  (4 bytes)
DATA_4F7F:
	defb 098h,099h,09ah,099h	; 4f7f

; ======================================================================
; CODIGO 0x4f83..0x5156  (467 bytes)
; ======================================================================


L_4F83:
	ld hl,0d100h		;4f83
	ld a,(0d000h)		;4f86
	ld b,a			;4f89
	ld a,(0d001h)		;4f8a
	ld c,a			;4f8d
	jp L_4FAF		;4f8e
L_4F91:
	ld hl,0d140h		;4f91
	ld de,00020h		;4f94
	ld b,016h		;4f97
L_4F99:
	push bc			;4f99
	ld b,020h		;4f9a
L_4F9C:
	ld a,(hl)			;4f9c
	call L_4B0B		;4f9d
	inc hl			;4fa0
	ld a,d			;4fa1
	add a,008h		;4fa2
	ld d,a			;4fa4
	djnz L_4F9C		;4fa5
	pop bc			;4fa7
	ld a,e			;4fa8
	add a,008h		;4fa9
	ld e,a			;4fab
	djnz L_4F99		;4fac
	ret			;4fae
L_4FAF:
	ld (0c5d5h),hl		;4faf
	ld (0c5d7h),bc		;4fb2
	di			;4fb6
	ld hl,0f0f1h		;4fb7
	ld a,00bh		;4fba
	ld (06000h),a		;4fbc
	ld (hl),a			;4fbf
	inc l			;4fc0
	inc a			;4fc1
	ld (08000h),a		;4fc2
	ld (hl),a			;4fc5
	inc l			;4fc6
	inc a			;4fc7
	ld (0a000h),a		;4fc8
	ld (hl),a			;4fcb
	ei			;4fcc
	ld a,(0c41ah)		;4fcd
	ld hl,0614bh		;4fd0
	and a			;4fd3
	jr nz,L_4FF0		;4fd4
	ld a,(0c5d8h)		;4fd6
	ld hl,06000h		;4fd9
	call L_4061		;4fdc
	ld l,(hl)			;4fdf
	ld a,(0c5d7h)		;4fe0
	add a,l			;4fe3
	ld h,000h		;4fe4
	ld l,a			;4fe6
	add hl,hl			;4fe7
	ld de,06013h		;4fe8
	add hl,de			;4feb
	ld e,(hl)			;4fec
	inc hl			;4fed
	ld d,(hl)			;4fee
	ex de,hl			;4fef
L_4FF0:
	ld de,(0c5d5h)		;4ff0
	ld a,006h		;4ff4
L_4FF6:
	ex af,af'			;4ff6
	ld b,008h		;4ff7
L_4FF9:
	ld a,(hl)			;4ff9
	push de			;4ffa
	exx			;4ffb
	push af			;4ffc
	ld a,(0c41ah)		;4ffd
	and a			;5000
	ld bc,0a041h		;5001
	jr nz,L_5013		;5004
	ld a,(0c5d8h)		;5006
	add a,a			;5009
	ld hl,07ebbh		;500a
	call L_4061		;500d
	ld c,(hl)			;5010
	inc hl			;5011
	ld b,(hl)			;5012
L_5013:
	pop af			;5013
	ld h,000h		;5014
	ld l,a			;5016
	add hl,hl			;5017
	add hl,hl			;5018
	add hl,hl			;5019
	add hl,hl			;501a
	add hl,bc			;501b
	ld bc,01cffh		;501c
	pop de			;501f
	ldi		;5020
	ldi		;5022
	ldi		;5024
	ldi		;5026
	ld a,b			;5028
	add a,e			;5029
	ld e,a			;502a
	ldi		;502b
	ldi		;502d
	ldi		;502f
	ldi		;5031
	ld a,b			;5033
	add a,e			;5034
	ld e,a			;5035
	ldi		;5036
	ldi		;5038
	ldi		;503a
	ldi		;503c
	ld a,b			;503e
	add a,e			;503f
	ld e,a			;5040
	ldi		;5041
	ldi		;5043
	ldi		;5045
	ldi		;5047
	exx			;5049
	inc hl			;504a
	inc e			;504b
	inc e			;504c
	inc e			;504d
	inc de			;504e
	djnz L_4FF9		;504f
	ex de,hl			;5051
	ld bc,00060h		;5052
	add hl,bc			;5055
	ex de,hl			;5056
	ex af,af'			;5057
	dec a			;5058
	jp nz,L_4FF6		;5059
	di			;505c
	push hl			;505d
	ld hl,0f0f1h		;505e
	ld a,001h		;5061
	ld (06000h),a		;5063
	ld (hl),a			;5066
	inc a			;5067
	ld (08000h),a		;5068
	inc hl			;506b
	ld (hl),a			;506c
	inc a			;506d
	ld (0a000h),a		;506e
	inc hl			;5071
	ld (hl),a			;5072
	pop hl			;5073
	ei			;5074
	ret			;5075
L_5076:
	ld a,0bch		;5076
	ld (0c097h),a		;5078
	xor a			;507b
	ld (0c0a5h),a		;507c
	ld (0c0a6h),a		;507f
	ld (0c0a7h),a		;5082
L_5085:
	xor a			;5085
	ld (0c096h),a		;5086
	ld (0c098h),a		;5089
	ld (0c0a8h),a		;508c
	ld hl,089ceh		;508f
	ld (0c010h),hl		;5092
	ld (0c012h),hl		;5095
	ld (0c014h),hl		;5098
	ld (0c016h),hl		;509b
L_509E:
	ret			;509e
L_509F:
	push hl			;509f
	push de			;50a0
	push bc			;50a1
	push af			;50a2
	di			;50a3
	ld a,00eh		;50a4
	ld (08000h),a		;50a6
	ld (0f0f2h),a		;50a9
	ei			;50ac
	di			;50ad
	ld a,00fh		;50ae
	ld (0a000h),a		;50b0
	ld (0f0f3h),a		;50b3
	ei			;50b6
	pop af			;50b7
	di			;50b8
	or a			;50b9
	jp z,L_51A4		;50ba
	cp 0fbh		;50bd
	jp nc,L_51AA		;50bf
	or a			;50c2
	jp p,L_516A		;50c3
	ld de,0c01ch		;50c6
	ld hl,05156h		;50c9
	ld bc,00014h		;50cc
	ldir		;50cf
	ld hl,05156h		;50d1
	ld bc,00014h		;50d4
	ldir		;50d7
	ld hl,05156h		;50d9
	ld bc,00014h		;50dc
	ldir		;50df
	and 07fh		;50e1
	rlca			;50e3
	ld e,a			;50e4
	rlca			;50e5
	add a,e			;50e6
	ld hl,08dc9h		;50e7
	add a,l			;50ea
	ld l,a			;50eb
	jr nc,L_50EF		;50ec
	inc h			;50ee
L_50EF:
	ld e,(hl)			;50ef
	inc hl			;50f0
	ld d,(hl)			;50f1
	inc hl			;50f2
	ld (0c01ch),de		;50f3
	ld e,(hl)			;50f7
	inc hl			;50f8
	ld d,(hl)			;50f9
	inc hl			;50fa
	ld (0c030h),de		;50fb
	ld e,(hl)			;50ff
	inc hl			;5100
	ld d,(hl)			;5101
	ld (0c044h),de		;5102
	ld hl,08a64h		;5106
	ld (0c010h),hl		;5109
	ld hl,08a6bh		;510c
	ld (0c012h),hl		;510f
	ld hl,08a72h		;5112
	ld (0c014h),hl		;5115
	xor a			;5118
	ld (0c096h),a		;5119
	ld hl,l509eh		;511c
	ld (0c016h),hl		;511f
	ld a,(0c098h)		;5122
	and 0fdh		;5125
	ld (0c098h),a		;5127
L_512A:
	xor a			;512a
	ld (0c0a5h),a		;512b
	ld (0c0a6h),a		;512e
	ld (0c0a8h),a		;5131
	ld a,007h		;5134
	ld (0c0a7h),a		;5136
L_5139:
	di			;5139
	push hl			;513a
	ld hl,0f0f1h		;513b
	ld a,001h		;513e
	ld (06000h),a		;5140
	ld (hl),a			;5143
	inc a			;5144
	ld (08000h),a		;5145
	inc hl			;5148
	ld (hl),a			;5149
	inc a			;514a
	ld (0a000h),a		;514b
	inc hl			;514e
	ld (hl),a			;514f
	pop hl			;5150
	ei			;5151
	pop bc			;5152
	pop de			;5153
	pop hl			;5154
	ret			;5155

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5156..0x516a  (20 bytes)
DATA_5156:
	defb 000h,000h,001h,000h,000h,000h,000h,000h,000h,001h,000h,000h,000h,000h,001h,001h	; 5156  ................
	defb 000h,000h,000h,000h	; 5166

; ======================================================================
; CODIGO 0x516a..0x5421  (695 bytes)
; ======================================================================


L_516A:
	ld c,a			;516a
	ld a,(0c0a8h)		;516b
	or a			;516e
	jp nz,L_5139		;516f
	ld a,(0c096h)		;5172
	cp c			;5175
	jp z,L_517C		;5176
	jp nc,L_5139		;5179
L_517C:
	ld a,c			;517c
	ld (0c096h),a		;517d
	ld de,0c058h		;5180
	ld hl,05156h		;5183
	ld bc,00014h		;5186
	ldir		;5189
	rlca			;518b
	ld hl,08d8dh		;518c
	add a,l			;518f
	ld l,a			;5190
	jr nc,L_5194		;5191
	inc h			;5193
L_5194:
	ld e,(hl)			;5194
	inc hl			;5195
	ld d,(hl)			;5196
	ld (0c064h),de		;5197
	ld hl,08c9ch		;519b
	ld (0c016h),hl		;519e
	jp L_5139		;51a1
L_51A4:
	call L_5085		;51a4
	jp L_5139		;51a7
L_51AA:
	jp z,L_5276		;51aa
	cp 0fch		;51ad
	jp z,L_52C9		;51af
	cp 0fdh		;51b2
	jp z,L_51C4		;51b4
	cp 0feh		;51b7
	jp z,L_522D		;51b9
	ld a,03ah		;51bc
	ld (0c0a5h),a		;51be
	jp L_5139		;51c1
L_51C4:
	ld a,(0c098h)		;51c4
	or 001h		;51c7
	ld (0c098h),a		;51c9
	ld a,(0c0a5h)		;51cc
	ld (0c099h),a		;51cf
	ld a,(0c0a6h)		;51d2
	ld (0c09ah),a		;51d5
	ld a,(0c097h)		;51d8
	ld (0c09bh),a		;51db
	ld a,0bfh		;51de
	ld (0c097h),a		;51e0
	xor a			;51e3
	call 00096h		;51e4   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c09ch),a		;51e7
	ld a,001h		;51ea
	call 00096h		;51ec   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c09dh),a		;51ef
	ld a,008h		;51f2
	call 00096h		;51f4   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c09eh),a		;51f7
	ld a,009h		;51fa
	call 00096h		;51fc   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c09fh),a		;51ff
	ld a,00ah		;5202
	call 00096h		;5204   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a0h),a		;5207
	xor a			;520a
	ld (0c094h),a		;520b
	ld a,005h		;520e
	ld (0c095h),a		;5210
	ld hl,08a5dh		;5213
	ld (0c01ah),hl		;5216
	ld de,0c080h		;5219
	ld hl,05156h		;521c
	ld bc,00014h		;521f
	ldir		;5222
	ld hl,09463h		;5224
	ld (0c080h),hl		;5227
	jp L_512A		;522a
L_522D:
	ld a,(0c098h)		;522d
	and 0feh		;5230
	ld (0c098h),a		;5232
	ld a,(0c099h)		;5235
	ld (0c0a5h),a		;5238
	ld a,(0c09ah)		;523b
	ld (0c0a6h),a		;523e
	ld a,(0c09bh)		;5241
	ld (0c097h),a		;5244
	ld a,(0c09ch)		;5247
	ld e,a			;524a
	xor a			;524b
	call 00093h		;524c   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c09dh)		;524f
	ld e,a			;5252
	ld a,001h		;5253
	call 00093h		;5255   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c09eh)		;5258
	ld e,a			;525b
	ld a,008h		;525c
	call 00093h		;525e   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c09fh)		;5261
	ld e,a			;5264
	ld a,009h		;5265
	call 00093h		;5267   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a0h)		;526a
	ld e,a			;526d
	ld a,00ah		;526e
	call 00093h		;5270   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_5139		;5273
L_5276:
	ld a,(0c098h)		;5276
	or 002h		;5279
	ld (0c098h),a		;527b
	ld a,(0c097h)		;527e
	ld (0c0a1h),a		;5281
	ld a,(0c096h)		;5284
	or a			;5287
	jp nz,L_5290		;5288
	ld a,0bfh		;528b
	jp L_5295		;528d
L_5290:
	ld a,(0c097h)		;5290
	or 01bh		;5293
L_5295:
	ld (0c097h),a		;5295
	xor a			;5298
	call 00096h		;5299   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a2h),a		;529c
	ld a,001h		;529f
	call 00096h		;52a1   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a3h),a		;52a4
	ld a,008h		;52a7
	call 00096h		;52a9   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a4h),a		;52ac
	ld hl,08c95h		;52af
	ld (0c018h),hl		;52b2
	ld de,0c06ch		;52b5
	ld hl,05156h		;52b8
	ld bc,00014h		;52bb
	ldir		;52be
	ld hl,0948bh		;52c0
	ld (0c078h),hl		;52c3
	jp L_5139		;52c6
L_52C9:
	ld a,(0c098h)		;52c9
	and 0fdh		;52cc
	ld (0c098h),a		;52ce
	ld a,(0c096h)		;52d1
	or a			;52d4
	ld a,(0c0a1h)		;52d5
	jp z,L_52E9		;52d8
	ld b,a			;52db
	ld a,(0c097h)		;52dc
	or 0dbh		;52df
	and b			;52e1
	ld b,a			;52e2
	ld a,(0c097h)		;52e3
	and 024h		;52e6
	or b			;52e8
L_52E9:
	ld (0c097h),a		;52e9
	ld a,(0c0a2h)		;52ec
	ld e,a			;52ef
	xor a			;52f0
	call 00093h		;52f1   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a3h)		;52f4
	ld e,a			;52f7
	ld a,001h		;52f8
	call 00093h		;52fa   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a4h)		;52fd
	ld e,a			;5300
	ld a,008h		;5301
	call 00093h		;5303   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_5139		;5306
L_5309:
	ld a,(0c0a6h)		;5309
	cp 0f8h		;530c
	ret			;530e
L_530F:
	call L_5362		;530f
	ld hl,0be59h		;5312
	ld de,00800h		;5315
	ld bc,00d01h		;5318
	call L_4A27		;531b
	ld hl,0bec1h		;531e
	ld de,07000h		;5321
	ld bc,00d02h		;5324
	call L_4A27		;5327
	ld hl,0bf29h		;532a
	ld de,0d800h		;532d
	ld bc,01a03h		;5330
	call L_4A27		;5333
L_5336:
	di			;5336
	push hl			;5337
	ld hl,0f0f1h		;5338
	ld a,001h		;533b
	ld (06000h),a		;533d
	ld (hl),a			;5340
	inc a			;5341
	ld (08000h),a		;5342
	inc hl			;5345
	ld (hl),a			;5346
	inc a			;5347
	ld (0a000h),a		;5348
	inc hl			;534b
	ld (hl),a			;534c
	pop hl			;534d
	ei			;534e
	ret			;534f
L_5350:
	di			;5350
	ld hl,0f0f2h		;5351
	ld a,00eh		;5354
	ld (08000h),a		;5356
	ld (hl),a			;5359
	inc l			;535a
	inc a			;535b
	ld (0a000h),a		;535c
	ld (hl),a			;535f
	ei			;5360
	ret			;5361
L_5362:
	di			;5362
	ld hl,0f0f1h		;5363
	ld a,00bh		;5366
	ld (06000h),a		;5368
	ld (hl),a			;536b
	inc l			;536c
	inc a			;536d
	ld (08000h),a		;536e
	ld (hl),a			;5371
	inc l			;5372
	inc a			;5373
	ld (0a000h),a		;5374
	ld (hl),a			;5377
	ei			;5378
	ret			;5379
L_537A:
	di			;537a
	ld hl,0f0f2h		;537b
	ld a,009h		;537e
	ld (08000h),a		;5380
	ld (hl),a			;5383
	inc l			;5384
	inc a			;5385
	ld (0a000h),a		;5386
	ld (hl),a			;5389
	ei			;538a
	ret			;538b
L_538C:
	di			;538c
	ld hl,0f0f2h		;538d
	ld a,007h		;5390
	ld (08000h),a		;5392
	ld (hl),a			;5395
	inc l			;5396
	inc a			;5397
	ld (0a000h),a		;5398
	ld (hl),a			;539b
	ei			;539c
	ret			;539d
L_539E:
	di			;539e
	ld hl,0f0f1h		;539f
	ld a,004h		;53a2
	ld (06000h),a		;53a4
	ld (hl),a			;53a7
	inc l			;53a8
	inc a			;53a9
	ld (08000h),a		;53aa
	ld (hl),a			;53ad
	inc l			;53ae
	inc a			;53af
	ld (0a000h),a		;53b0
	ld (hl),a			;53b3
	ei			;53b4
	ret			;53b5
L_53B6:
	call L_538C		;53b6
	ld de,00000h		;53b9
	ld c,000h		;53bc
	ld hl,0bed8h		;53be
	call L_4A30		;53c1
	ld de,00040h		;53c4
	ld hl,0bd80h		;53c7
	ld bc,0300eh		;53ca
	call L_4A27		;53cd
	ld hl,0bf00h		;53d0
	ld de,0a440h		;53d3
	ld b,001h		;53d6
	call L_4A66		;53d8
	jp L_5336		;53db
L_53DE:
	call L_5350		;53de
	ld de,08040h		;53e1
	ld hl,08824h		;53e4
	ld bc,00e0eh		;53e7
	call L_4A27		;53ea
	ld de,00848h		;53ed
	ld hl,08894h		;53f0
	ld bc,01a0eh		;53f3
	call L_4A27		;53f6
	jp L_5336		;53f9
L_53FC:
	ld (hl),001h		;53fc
	ld de,(0c5adh)		;53fe
	ld hl,05421h		;5402
	ld b,006h		;5405
L_5407:
	push bc			;5407
	push de			;5408
	push hl			;5409
	ld a,(hl)			;540a
	inc hl			;540b
	ld h,(hl)			;540c
	ld l,a			;540d
	ld bc,00808h		;540e
	xor a			;5411
	call L_498A		;5412
	pop hl			;5415
	inc hl			;5416
	inc hl			;5417
	pop de			;5418
	ld a,e			;5419
	add a,008h		;541a
	ld e,a			;541c
	pop bc			;541d
	djnz L_5407		;541e
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


L_548D:
	call L_537A		;548d
	ld hl,09000h		;5490
	ld de,0a800h		;5493
	ld b,014h		;5496
	call L_4A90		;5498
	ld hl,09a00h		;549b
	ld de,0b028h		;549e
	ld b,001h		;54a1
	call L_4A90		;54a3
	ld hl,09a80h		;54a6
	ld de,08c70h		;54a9
	ld bc,00804h		;54ac
	ld a,001h		;54af
	call L_498A		;54b1
	ld de,08074h		;54b4
	ld b,004h		;54b7
L_54B9:
	push bc			;54b9
	push de			;54ba
	ld hl,09a90h		;54bb
	ld bc,00808h		;54be
	ld a,001h		;54c1
	call L_498A		;54c3
	pop de			;54c6
	pop bc			;54c7
	ld a,d			;54c8
	add a,008h		;54c9
	ld d,a			;54cb
	djnz L_54B9		;54cc
	call L_539E		;54ce
	ld hl,0b9c8h		;54d1
	ld de,0b030h		;54d4
	ld b,008h		;54d7
	call L_4A90		;54d9
	ld hl,0bdc8h		;54dc
	ld de,0b800h		;54df
	ld b,005h		;54e2
	call L_4A90		;54e4
	call L_537A		;54e7
	call L_54F0		;54ea
	jp L_5336		;54ed
L_54F0:
	ld ix,0558eh		;54f0
	ld de,0d000h		;54f4
	ld b,005h		;54f7
L_54F9:
	push bc			;54f9
	push de			;54fa
	call L_550D		;54fb
	call L_5548		;54fe
	pop de			;5501
	ld a,010h		;5502
	call L_4066		;5504
	pop bc			;5507
	inc ix		;5508
	djnz L_54F9		;550a
	ret			;550c
L_550D:
	exx			;550d
	ld de,0e800h		;550e
	ld hl,0bda7h		;5511
	ld b,000h		;5514
L_5516:
	push bc			;5516
	ld a,(hl)			;5517
	inc hl			;5518
	ld b,a			;5519
	rrca			;551a
	rrca			;551b
	rrca			;551c
	rrca			;551d
	and 00fh		;551e
	cp 00fh		;5520
	jr nz,L_5527		;5522
	and (ix+000h)		;5524
L_5527:
	add a,a			;5527
	add a,a			;5528
	add a,a			;5529
	add a,a			;552a
	ld c,a			;552b
	ld a,b			;552c
	and 00fh		;552d
	cp 00fh		;552f
	jr nz,L_5536		;5531
	and (ix+000h)		;5533
L_5536:
	or c			;5536
	ld (de),a			;5537
	inc de			;5538
	pop bc			;5539
	djnz L_5516		;553a
	xor a			;553c
	ld (de),a			;553d
	ld h,d			;553e
	ld l,e			;553f
	inc de			;5540
	ld bc,0001fh		;5541
	ldir		;5544
	exx			;5546
	ret			;5547
L_5548:
	ld hl,0556eh		;5548
	ld b,004h		;554b
L_554D:
	push bc			;554d
	push de			;554e
	ld b,004h		;554f
L_5551:
	push bc			;5551
	push hl			;5552
	ld a,(hl)			;5553
	inc hl			;5554
	ld h,(hl)			;5555
	ld l,a			;5556
	call L_4A51		;5557
	ld a,004h		;555a
	call L_4066		;555c
	pop hl			;555f
	inc hl			;5560
	inc hl			;5561
	pop bc			;5562
	djnz L_5551		;5563
	pop de			;5565
	ld a,d			;5566
	add a,004h		;5567
	ld d,a			;5569
	pop bc			;556a
	djnz L_554D		;556b
	ret			;556d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x556e..0x558e  (32 bytes)
DATA_556E:
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


L_5593:
	call L_537A		;5593
	ld a,(0c416h)		;5596
	cp 005h		;5599
	jr z,L_55D4		;559b
	dec a			;559d
	jr z,L_55D4		;559e
	dec a			;55a0
	add a,a			;55a1
	ld hl,055d7h		;55a2
	call L_4061		;55a5
	ld e,(hl)			;55a8
	inc hl			;55a9
	ld d,(hl)			;55aa
	ld hl,0f8c0h		;55ab
	call L_46F1		;55ae
	ld a,(0c416h)		;55b1
	cp 004h		;55b4
	jr z,L_55C8		;55b6
	cp 003h		;55b8
	jr z,L_55C8		;55ba
	cp 002h		;55bc
	jr nz,L_55D4		;55be
	ld hl,055e7h		;55c0
	call L_473E		;55c3
	jr L_55D4		;55c6
L_55C8:
	ld hl,055ddh		;55c8
	call L_473E		;55cb
	ld hl,055e2h		;55ce
	call L_473E		;55d1
L_55D4:
	jp L_5336		;55d4

; ----------------------------------------------------------------------
; DATOS tabla_55D7: 3 punteros a rle que lee p00:55AE; lo leen p00:55AE (6
;   bytes)
;   0x55d7..0x55dd  (6 bytes)
DATA_tabla_55D7:
	defb 04eh,0a2h	; 55d7
	defb 0c9h,0a4h	; 55d9
	defb 072h,0a2h	; 55db

; ----------------------------------------------------------------------
; DATOS sin identificar  0x55dd..0x55ec  (15 bytes)
DATA_55DD:
	defb 0c0h,0f8h,002h,080h,0f9h,000h,0f9h,002h,040h,0f9h,0c0h,0f8h,002h,000h,0f9h	; 55dd  ........@......

; ======================================================================
; CODIGO 0x55ec..0x56cf  (227 bytes)
; ======================================================================


L_55EC:
	call L_537A		;55ec
	ld de,0a0eah		;55ef
	ld hl,0f900h		;55f2
	call L_46F1		;55f5
	call L_5336		;55f8
	ld hl,0d600h		;55fb
	ld bc,00808h		;55fe
L_5601:
	ld de,0c5adh		;5601
	ld a,b			;5604
	cp 005h		;5605
	ld a,(de)			;5607
	jr nc,L_560C		;5608
	add a,010h		;560a
L_560C:
	dec a			;560c
	ld (hl),a			;560d
	inc hl			;560e
	inc de			;560f
	ld a,(de)			;5610
	ld (hl),a			;5611
	inc hl			;5612
	ld a,c			;5613
	and 00bh		;5614
	add a,a			;5616
	add a,a			;5617
	ld (hl),a			;5618
	inc c			;5619
	inc hl			;561a
	inc hl			;561b
	djnz L_5601		;561c
	ld hl,0d400h		;561e
	ld c,00ch		;5621
	call L_563B		;5623
	ld hl,0d410h		;5626
	ld c,00dh		;5629
	call L_563B		;562b
	ld hl,0d420h		;562e
	ld c,00eh		;5631
	call L_563B		;5633
	ld hl,0d430h		;5636
	ld c,002h		;5639
L_563B:
	ld d,h			;563b
	ld e,l			;563c
	ld a,040h		;563d
	call L_4066		;563f
	ld b,010h		;5642
L_5644:
	ld a,c			;5644
	ld (hl),a			;5645
	ld (de),a			;5646
	inc hl			;5647
	inc de			;5648
	djnz L_5644		;5649
	ret			;564b
L_564C:
	call L_539E		;564c
	ld a,(0d000h)		;564f
	cp 00dh		;5652
	call nc,L_538C		;5654
	ld a,(0d000h)		;5657
	add a,a			;565a
	ld hl,05742h		;565b
	call L_4061		;565e
	ld e,(hl)			;5661
	inc hl			;5662
	ld d,(hl)			;5663
	ex de,hl			;5664
L_5665:
	ld de,08004h		;5665
	ld b,0bfh		;5668
	call L_4A66		;566a
	jp L_5336		;566d
L_5670:
	call L_537A		;5670
	ld hl,08000h		;5673
	jr L_5665		;5676
L_5678:
	call L_5362		;5678
	ld hl,0f800h		;567b
	ld de,0a319h		;567e
	call L_46F1		;5681
	ld hl,0f840h		;5684
	ld de,0a351h		;5687
	call L_46F1		;568a
	ld hl,0f880h		;568d
	ld de,0a38ch		;5690
	call L_46F1		;5693
	ld hl,0f8c0h		;5696
	ld de,0a3cah		;5699
	call L_46F1		;569c
	ld hl,0f900h		;569f
	ld de,0a40bh		;56a2
	call L_46F1		;56a5
	ld hl,0f940h		;56a8
	ld de,0a447h		;56ab
	call L_46F1		;56ae
	ld hl,0f980h		;56b1
	ld de,0a480h		;56b4
	call L_46F1		;56b7
	ld hl,0f9c0h		;56ba
	ld de,0a4bch		;56bd
	call L_46F1		;56c0
	ld de,0b895h		;56c3
	ld hl,0fa00h		;56c6
	call L_46F1		;56c9
	jp L_5336		;56cc

; ----------------------------------------------------------------------
; DATOS sin identificar  0x56cf..0x56e1  (18 bytes)
DATA_56CF:
	defb 0cdh,062h,053h,011h,080h,0f8h,021h,093h,0ach,001h,080h,001h,0cdh,075h,046h,0c3h	; 56cf  .bS...!......uF.
	defb 036h,053h	; 56df

; ======================================================================
; CODIGO 0x56e1..0x5742  (97 bytes)
; ======================================================================


L_56E1:
	call L_5362		;56e1
	ld a,(0c42eh)		;56e4
	add a,a			;56e7
	ld hl,0a281h		;56e8
	call L_4061		;56eb
	ld e,(hl)			;56ee
	inc hl			;56ef
	ld d,(hl)			;56f0
	ld hl,0f800h		;56f1
	call L_46F1		;56f4
	ld a,(0c42fh)		;56f7
	add a,a			;56fa
	ld hl,0a2d1h		;56fb
	call L_4061		;56fe
	ld e,(hl)			;5701
	inc hl			;5702
	ld d,(hl)			;5703
	ld hl,0f840h		;5704
	call L_46F1		;5707
	jp L_5336		;570a
L_570D:
	call L_5727		;570d
	call L_537A		;5710
	ld hl,0bea7h		;5713
	ld a,(0d000h)		;5716
	add a,a			;5719
	call L_4061		;571a
	ld e,(hl)			;571d
	inc hl			;571e
	ld d,(hl)			;571f
	ex de,hl			;5720
	call L_483E		;5721
	jp L_5336		;5724
L_5727:
	call L_537A		;5727
	ld hl,0bf88h		;572a
	call L_483E		;572d
	jp L_5336		;5730
L_5733:
	call L_5727		;5733
	call L_537A		;5736
	ld hl,0bfa1h		;5739
	call L_483E		;573c
	jp L_5336		;573f

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


L_5768:
	call L_537A		;5768
	ld hl,0ff00h		;576b
	ld de,0a185h		;576e
	call L_46F1		;5771
	ld de,0a147h		;5774
	ld hl,0f9c0h		;5777
	call L_46F1		;577a
	jp L_5336		;577d
L_5780:
	call L_47FE		;5780
	call L_537A		;5783
	ld hl,09ab0h		;5786
	ld a,(0d000h)		;5789
	or a			;578c
	jr z,L_57B1		;578d
	dec a			;578f
	add a,a			;5790
	call L_4061		;5791
	ld e,(hl)			;5794
	inc hl			;5795
	ld d,(hl)			;5796
	ld a,(0d001h)		;5797
	add a,a			;579a
	add a,a			;579b
	call L_4066		;579c
	ex de,hl			;579f
	ld a,(hl)			;57a0
	inc hl			;57a1
	push hl			;57a2
	ld h,(hl)			;57a3
	ld l,a			;57a4
	call L_4714		;57a5
	pop hl			;57a8
	inc hl			;57a9
	ld a,(hl)			;57aa
	inc hl			;57ab
	ld h,(hl)			;57ac
	ld l,a			;57ad
	call L_483E		;57ae
L_57B1:
	jp L_5336		;57b1
L_57B4:
	call L_537A		;57b4
	ld hl,09fedh		;57b7
	call L_4714		;57ba
	jp L_5336		;57bd
L_57C0:
	call L_537A		;57c0
	ld hl,0fa00h		;57c3
	ld de,0b0aah		;57c6
	call L_46F1		;57c9
	ld a,(0d000h)		;57cc
	sub 003h		;57cf
	ld hl,0a01ah		;57d1
	jr z,L_57D9		;57d4
	ld hl,0a021h		;57d6
L_57D9:
	call L_483E		;57d9
	jp L_5336		;57dc
L_57DF:
	call L_5362		;57df
	ld hl,0b5a1h		;57e2
	call L_582D		;57e5
	ld de,0c000h		;57e8
	call L_580F		;57eb
	call L_5851		;57ee
	ld de,0c020h		;57f1
	call L_580F		;57f4
	ld hl,0b719h		;57f7
	call L_582D		;57fa
	ld de,0c010h		;57fd
	call L_580F		;5800
	call L_5851		;5803
	ld de,0c030h		;5806
	call L_580F		;5809
	jp L_5336		;580c
L_580F:
	ld b,020h		;580f
	ld hl,0e800h		;5811
L_5814:
	push bc			;5814
	push de			;5815
	push hl			;5816
	ld bc,00010h		;5817
	call L_4675		;581a
	pop hl			;581d
	pop de			;581e
	pop bc			;581f
	ld a,010h		;5820
	call L_4061		;5822
	ld a,080h		;5825
	call L_4066		;5827
	djnz L_5814		;582a
	ret			;582c
L_582D:
	ld b,020h		;582d
	ld de,0e800h		;582f
L_5832:
	push bc			;5832
	ld a,(hl)			;5833
	and a			;5834
	jr z,L_583D		;5835
	ld b,a			;5837
	xor a			;5838
L_5839:
	ld (de),a			;5839
	inc de			;583a
	djnz L_5839		;583b
L_583D:
	ld a,00ch		;583d
	sub (hl)			;583f
	inc hl			;5840
	ld c,a			;5841
	ld b,000h		;5842
	ldir		;5844
	xor a			;5846
	ld b,004h		;5847
L_5849:
	ld (de),a			;5849
	inc de			;584a
	djnz L_5849		;584b
	pop bc			;584d
	djnz L_5832		;584e
	ret			;5850
L_5851:
	ld hl,0e800h		;5851
	ld de,0e80fh		;5854
	ld c,020h		;5857
L_5859:
	ld b,008h		;5859
	call L_586C		;585b
	ld a,008h		;585e
	call L_4061		;5860
	ld a,018h		;5863
	call L_4066		;5865
	dec c			;5868
	jr nz,L_5859		;5869
	ret			;586b
L_586C:
	ex af,af'			;586c
	ld a,(hl)			;586d
	ex af,af'			;586e
	ld a,(de)			;586f
	rrca			;5870
	rrca			;5871
	rrca			;5872
	rrca			;5873
	ld (hl),a			;5874
	ex af,af'			;5875
	rrca			;5876
	rrca			;5877
	rrca			;5878
	rrca			;5879
	ld (de),a			;587a
	inc hl			;587b
	dec de			;587c
	djnz L_586C		;587d
	ret			;587f
L_5880:
	call L_5350		;5880
	call L_5895		;5883
	call L_58CC		;5886
	call L_592A		;5889
	call L_598B		;588c
	call L_5996		;588f
	jp L_5336		;5892
L_5895:
	ld hl,0abfbh		;5895
	ld b,008h		;5898
	ld de,08018h		;589a
	call L_4A66		;589d
	ld hl,0acfbh		;58a0
	ld b,002h		;58a3
	ld de,08040h		;58a5
	call L_4A66		;58a8
	ld hl,0ad3bh		;58ab
	ld b,002h		;58ae
	ld de,08060h		;58b0
	call L_4A66		;58b3
	ld hl,0ad7bh		;58b6
	ld b,001h		;58b9
	ld de,08070h		;58bb
	call L_4A66		;58be
	ld hl,0ad9bh		;58c1
	ld b,06ch		;58c4
	ld de,08078h		;58c6
	jp L_4A66		;58c9
L_58CC:
	ld hl,0ad7bh		;58cc
	ld b,001h		;58cf
	ld de,08074h		;58d1
	call L_58EA		;58d4
	ld hl,0ad9bh		;58d7
	ld b,06ch		;58da
	ld de,09028h		;58dc
	call L_58EA		;58df
	ld hl,0acfbh		;58e2
	ld b,002h		;58e5
	ld de,08048h		;58e7
L_58EA:
	push bc			;58ea
	push de			;58eb
	push hl			;58ec
	call L_58FD		;58ed
	pop hl			;58f0
	ld de,00020h		;58f1
	add hl,de			;58f4
	pop de			;58f5
	call L_595B		;58f6
	pop bc			;58f9
	djnz L_58EA		;58fa
	ret			;58fc
L_58FD:
	push de			;58fd
	ld de,0e800h		;58fe
	ld bc,00020h		;5901
	ldir		;5904
	call L_5912		;5906
	pop de			;5909
	ld hl,0e800h		;590a
	ld b,001h		;590d
	jp L_4A66		;590f
L_5912:
	ld hl,0e800h		;5912
	ld de,0e803h		;5915
	ld c,008h		;5918
L_591A:
	ld b,002h		;591a
	call L_586C		;591c
	inc hl			;591f
	inc hl			;5920
	ld a,006h		;5921
	call L_4066		;5923
	dec c			;5926
	jr nz,L_591A		;5927
	ret			;5929
L_592A:
	ld hl,08048h		;592a
	ld b,002h		;592d
	ld de,08058h		;592f
	call L_5948		;5932
	ld hl,08040h		;5935
	ld b,002h		;5938
	ld de,08050h		;593a
	call L_5948		;593d
	ld hl,08060h		;5940
	ld b,002h		;5943
	ld de,08068h		;5945
L_5948:
	push bc			;5948
	push de			;5949
	push hl			;594a
	call L_5969		;594b
	pop de			;594e
	call L_595B		;594f
	ex de,hl			;5952
	pop de			;5953
	call L_595B		;5954
	pop bc			;5957
	djnz L_5948		;5958
	ret			;595a
L_595B:
	ld a,e			;595b
	add a,004h		;595c
	and 07fh		;595e
	ld e,a			;5960
	ret nz			;5961
	ld a,d			;5962
	add a,004h		;5963
	and 0fch		;5965
	ld d,a			;5967
	ret			;5968
L_5969:
	push de			;5969
	ld de,0e818h		;596a
	ld b,008h		;596d
L_596F:
	push bc			;596f
	ld bc,00004h		;5970
	call L_465A		;5973
	ld a,e			;5976
	sub 008h		;5977
	ld e,a			;5979
	ld a,080h		;597a
	call L_4061		;597c
	pop bc			;597f
	djnz L_596F		;5980
	pop de			;5982
	ld hl,0e800h		;5983
	ld b,001h		;5986
	jp L_4A66		;5988
L_598B:
	ld hl,0bbdbh		;598b
	ld de,0d000h		;598e
	ld b,008h		;5991
	jp L_4A90		;5993
L_5996:
	ld b,004h		;5996
	ld hl,0bddbh		;5998
	ld de,0d040h		;599b
L_599E:
	push bc			;599e
	push de			;599f
	push hl			;59a0
	call L_59BC		;59a1
	pop hl			;59a4
	ld de,00080h		;59a5
	add hl,de			;59a8
	pop de			;59a9
	ld a,e			;59aa
	add a,008h		;59ab
	and 07fh		;59ad
	ld e,a			;59af
	jr nz,L_59B8		;59b0
	ld a,d			;59b2
	add a,008h		;59b3
	and 0f8h		;59b5
	ld d,a			;59b7
L_59B8:
	pop bc			;59b8
	djnz L_599E		;59b9
	ret			;59bb
L_59BC:
	push de			;59bc
	ld de,0e800h		;59bd
	ld bc,00080h		;59c0
	ldir		;59c3
	call L_59D1		;59c5
	pop de			;59c8
	ld hl,0e800h		;59c9
	ld b,001h		;59cc
	jp L_4A90		;59ce
L_59D1:
	ld hl,0e800h		;59d1
	ld de,0e807h		;59d4
	ld c,010h		;59d7
L_59D9:
	ld b,004h		;59d9
	call L_586C		;59db
	ld a,004h		;59de
	call L_4061		;59e0
	ld a,00ch		;59e3
	call L_4066		;59e5
	dec c			;59e8
	jr nz,L_59D9		;59e9
	ret			;59eb
L_59EC:
	call L_5727		;59ec
	call L_537A		;59ef
	ld hl,0bf6fh		;59f2
	call L_483E		;59f5
	jp L_5336		;59f8
L_59FB:
	call L_538C		;59fb
	ld hl,0ac80h		;59fe
	ld de,08004h		;5a01
	ld b,011h		;5a04
	call L_4A66		;5a06
	ld a,(0002bh)		;5a09
	and 00fh		;5a0c
	jr nz,L_5A23		;5a0e
	ld hl,0aea0h		;5a10
	ld b,01eh		;5a13
	call L_4A66		;5a15
	call L_5362		;5a18
	ld de,0bbf6h		;5a1b
	call L_46EB		;5a1e
	jr L_5A2B		;5a21
L_5A23:
	ld hl,0b260h		;5a23
	ld b,059h		;5a26
	call L_4A66		;5a28
L_5A2B:
	jp L_5336		;5a2b
L_5A2E:
	call L_5362		;5a2e
	call 0b963h		;5a31
	jp L_5336		;5a34
L_5A37:
	call L_5362		;5a37
	call 0b99ah		;5a3a
	jp L_5336		;5a3d
L_5A40:
	call L_5362		;5a40
	call 0bb31h		;5a43
	jp L_5336		;5a46
L_5A49:
	ld hl,0e000h		;5a49
	ld de,0e001h		;5a4c
	ld (hl),000h		;5a4f
	ld bc,0047fh		;5a51
	ldir		;5a54
	call L_5A5C		;5a56
	jp L_5AAF		;5a59
L_5A5C:
	call L_5350		;5a5c
	call L_5A98		;5a5f
	ld de,0e000h		;5a62
L_5A65:
	push de			;5a65
L_5A66:
	push de			;5a66
L_5A67:
	ld a,(hl)			;5a67
	or a			;5a68
	jr z,L_5A93		;5a69
	inc a			;5a6b
	jr z,L_5A87		;5a6c
	inc a			;5a6e
	jr z,L_5A7E		;5a6f
	ldi		;5a71
	ld a,(hl)			;5a73
	ldi		;5a74
	cp 07fh		;5a76
	jr nz,L_5A7C		;5a78
	ldi		;5a7a
L_5A7C:
	jr L_5A67		;5a7c
L_5A7E:
	pop de			;5a7e
	ld a,018h		;5a7f
	call L_4066		;5a81
	inc hl			;5a84
	jr L_5A66		;5a85
L_5A87:
	pop de			;5a87
	pop de			;5a88
	push hl			;5a89
	ld hl,00180h		;5a8a
	add hl,de			;5a8d
	ex de,hl			;5a8e
	pop hl			;5a8f
	inc hl			;5a90
	jr L_5A65		;5a91
L_5A93:
	pop de			;5a93
	pop de			;5a94
	jp L_5336		;5a95
L_5A98:
	ld a,(0d000h)		;5a98
	or a			;5a9b
	ld hl,0800ch		;5a9c
	ret z			;5a9f
	ld a,(0d002h)		;5aa0
	ld hl,08000h		;5aa3
	add a,a			;5aa6
	call L_4061		;5aa7
	ld e,(hl)			;5aaa
	inc hl			;5aab
	ld d,(hl)			;5aac
	ex de,hl			;5aad
	ret			;5aae
L_5AAF:
	ld hl,0de00h		;5aaf
	ld de,0de01h		;5ab2
	ld (hl),000h		;5ab5
	ld bc,000bfh		;5ab7
	push hl			;5aba
	ldir		;5abb
	pop de			;5abd
	ld hl,0e000h		;5abe
	ld b,030h		;5ac1
L_5AC3:
	push bc			;5ac3
	push hl			;5ac4
	push de			;5ac5
	call L_5AD7		;5ac6
	pop hl			;5ac9
	ld bc,00004h		;5aca
	add hl,bc			;5acd
	ex de,hl			;5ace
	pop hl			;5acf
	ld c,018h		;5ad0
	add hl,bc			;5ad2
	pop bc			;5ad3
	djnz L_5AC3		;5ad4
	ret			;5ad6
L_5AD7:
	ld bc,00802h		;5ad7
L_5ADA:
	inc hl			;5ada
	ld a,(hl)			;5adb
	and 0e0h		;5adc
	cp 060h		;5ade
	jr z,L_5B00		;5ae0
L_5AE2:
	and 0c0h		;5ae2
	cp 0c0h		;5ae4
	jr nz,L_5AFC		;5ae6
	ld a,(hl)			;5ae8
	push bc			;5ae9
	push hl			;5aea
	ld hl,05b0bh		;5aeb
	and 03ch		;5aee
	rrca			;5af0
	rrca			;5af1
	call L_4061		;5af2
	ldi		;5af5
	inc de			;5af7
	pop hl			;5af8
	pop bc			;5af9
	dec c			;5afa
	ret z			;5afb
L_5AFC:
	inc hl			;5afc
	djnz L_5ADA		;5afd
	ret			;5aff
L_5B00:
	ld a,(hl)			;5b00
	and 01fh		;5b01
	cp 01fh		;5b03
	jr nz,L_5AFC		;5b05
	inc hl			;5b07
	ld a,(hl)			;5b08
	jr L_5AE2		;5b09

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5b0b..0x5b1b  (16 bytes)
DATA_5B0B:
	defb 00eh,012h,003h,004h,00ah,016h,01eh,01dh,01bh,000h,000h,000h,000h,000h,000h,000h	; 5b0b  ................

; ======================================================================
; CODIGO 0x5b1b..0x5c04  (233 bytes)
; ======================================================================


L_5B1B:
	call L_5BCF		;5b1b
	ld de,0c470h		;5b1e
L_5B21:
	ld b,008h		;5b21
L_5B23:
	ld a,(hl)			;5b23
	inc hl			;5b24
	or a			;5b25
	jr z,L_5B7C		;5b26
	push bc			;5b28
	push hl			;5b29
	push de			;5b2a
	ld a,(hl)			;5b2b
	and 0e0h		;5b2c
	jr z,L_5B88		;5b2e
	bit 7,(hl)		;5b30
	jr nz,L_5BA5		;5b32
	dec hl			;5b34
	ld a,001h		;5b35
	ld (de),a			;5b37
	inc de			;5b38
	push hl			;5b39
	push bc			;5b3a
	call L_5C16		;5b3b
	ld a,c			;5b3e
	ld (de),a			;5b3f
	inc de			;5b40
	ld a,b			;5b41
	ld (de),a			;5b42
	inc de			;5b43
	pop bc			;5b44
	xor a			;5b45
	ld (de),a			;5b46
	inc de			;5b47
	ld a,(hl)			;5b48
	ld b,a			;5b49
	rlca			;5b4a
	rlca			;5b4b
	rlca			;5b4c
	and 007h		;5b4d
	dec a			;5b4f
	jr nz,L_5B5A		;5b50
	ld a,(0d000h)		;5b52
	or a			;5b55
	jr z,L_5B5A		;5b56
	ld a,0ffh		;5b58
L_5B5A:
	inc a			;5b5a
	ld (de),a			;5b5b
	inc e			;5b5c
	ld a,b			;5b5d
	and 01fh		;5b5e
	ld (de),a			;5b60
	inc e			;5b61
	ex af,af'			;5b62
	ld a,l			;5b63
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
	cp 01fh		;5b6e
	jr nz,L_5B75		;5b70
	inc hl			;5b72
	ldi		;5b73
L_5B75:
	pop de			;5b75
	ld a,e			;5b76
	add a,010h		;5b77
	ld e,a			;5b79
	pop hl			;5b7a
	pop bc			;5b7b
L_5B7C:
	ld a,(hl)			;5b7c
	inc hl			;5b7d
	and 01fh		;5b7e
	cp 01fh		;5b80
	jr nz,L_5B85		;5b82
	inc hl			;5b84
L_5B85:
	djnz L_5B23		;5b85
	ret			;5b87
L_5B88:
	ld a,(0cf38h)		;5b88
	and a			;5b8b
	jr nz,L_5B75		;5b8c
	call L_5B96		;5b8e
	call 089fdh		;5b91
	jr L_5B75		;5b94
L_5B96:
	dec l			;5b96
	push hl			;5b97
	push bc			;5b98
	call L_5C16		;5b99
	ld d,b			;5b9c
	ld e,c			;5b9d
	pop bc			;5b9e
	ld a,(hl)			;5b9f
	and 01fh		;5ba0
	ld b,a			;5ba2
	pop hl			;5ba3
	ret			;5ba4
L_5BA5:
	ld a,(0cf38h)		;5ba5
	and a			;5ba8
	jr nz,L_5B75		;5ba9
	bit 6,(hl)		;5bab
	jr nz,L_5BB7		;5bad
	call L_5B96		;5baf
	call 08a13h		;5bb2
	jr L_5B75		;5bb5
L_5BB7:
	push hl			;5bb7
	pop ix		;5bb8
	call L_5B96		;5bba
	ld a,(ix+000h)		;5bbd
	ld c,a			;5bc0
	and 03ch		;5bc1
	rrca			;5bc3
	rrca			;5bc4
	ld b,a			;5bc5
	ld a,c			;5bc6
	and 003h		;5bc7
	ld c,a			;5bc9
	call 09179h		;5bca
	jr L_5B75		;5bcd
L_5BCF:
	ld a,(0d001h)		;5bcf
L_5BD2:
	ld (0cffeh),a		;5bd2
	push bc			;5bd5
	push de			;5bd6
	ld de,00000h		;5bd7
	ld a,(0d000h)		;5bda
	or a			;5bdd
	jr z,L_5BEE		;5bde
	dec a			;5be0
	ld hl,05c04h		;5be1
	call L_4061		;5be4
	ld l,(hl)			;5be7
	ld h,d			;5be8
	add hl,hl			;5be9
	add hl,hl			;5bea
	add hl,hl			;5beb
	add hl,hl			;5bec
	ex de,hl			;5bed
L_5BEE:
	ld hl,0e000h		;5bee
	add hl,de			;5bf1
	ex de,hl			;5bf2
	ld a,(0cffeh)		;5bf3
	ld l,a			;5bf6
	ld h,000h		;5bf7
	add hl,hl			;5bf9
	add hl,hl			;5bfa
	add hl,hl			;5bfb
	ld b,h			;5bfc
	ld c,l			;5bfd
	add hl,hl			;5bfe
	add hl,bc			;5bff
	add hl,de			;5c00
	pop de			;5c01
	pop bc			;5c02
	ret			;5c03

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5c04..0x5c16  (18 bytes)
DATA_5C04:
	defb 000h,018h,030h,000h,018h,030h,000h,018h,030h,000h,018h,030h,000h,018h,030h,000h	; 5c04  ..0..0..0..0..0.
	defb 018h,030h	; 5c14

; ======================================================================
; CODIGO 0x5c16..0x5ce9  (211 bytes)
; ======================================================================


L_5C16:
	ld a,(hl)			;5c16
	ld b,a			;5c17
	and 0f0h		;5c18
	ld c,a			;5c1a
	ld a,b			;5c1b
	and 00fh		;5c1c
	add a,a			;5c1e
	add a,a			;5c1f
	add a,a			;5c20
	add a,a			;5c21
	ld b,a			;5c22
	inc hl			;5c23
	ret			;5c24
L_5C25:
	call 06841h		;5c25
	call 0654bh		;5c28
	ld a,(0ce40h)		;5c2b
	and a			;5c2e
	jp nz,066bah		;5c2f
	call 09552h		;5c32
	ld a,(0cf38h)		;5c35
	and a			;5c38
	ret nz			;5c39
	ld a,(0c002h)		;5c3a
	and 040h		;5c3d
	jr z,L_5C5C		;5c3f
	ld a,(0c00bh)		;5c41
	rra			;5c44
	jr nc,L_5C5C		;5c45
	ld a,(0ce00h)		;5c47
	cp 006h		;5c4a
	call z,0ad93h		;5c4c
	ld a,001h		;5c4f
	ld (0c40ah),a		;5c51
	call L_56E1		;5c54
	ld a,0fdh		;5c57
	jp L_509F		;5c59
L_5C5C:
	call L_56E1		;5c5c
	call 06affh		;5c5f
	call 07837h		;5c62
	call 0b6abh		;5c65
	call 098e5h		;5c68
	call 09e31h		;5c6b
	call 07d68h		;5c6e
	call 08671h		;5c71
	call 091beh		;5c74
	call 08a4ah		;5c77
	call 088d8h		;5c7a
	call 08fcfh		;5c7d
	call 0909bh		;5c80
	call 09147h		;5c83
	call 09918h		;5c86
	call 09910h		;5c89
	call 064ech		;5c8c
	jp 064e5h		;5c8f
L_5C92:
	ld bc,00400h		;5c92
	ld hl,0fcc1h		;5c95
L_5C98:
	push bc			;5c98
	push hl			;5c99
	ld a,(hl)			;5c9a
	bit 7,a		;5c9b
	jr nz,L_5CB3		;5c9d
	call L_5CCC		;5c9f
L_5CA2:
	pop hl			;5ca2
	pop bc			;5ca3
	jr c,L_5CAD		;5ca4
	inc hl			;5ca6
	inc c			;5ca7
	djnz L_5C98		;5ca8
	xor a			;5caa
	jr L_5CAF		;5cab
L_5CAD:
	ld a,0ffh		;5cad
L_5CAF:
	ld (0e600h),a		;5caf
	ret			;5cb2
L_5CB3:
	call L_5CB8		;5cb3
	jr L_5CA2		;5cb6
L_5CB8:
	and 080h		;5cb8
	or c			;5cba
	ld c,a			;5cbb
	ld b,004h		;5cbc
L_5CBE:
	push bc			;5cbe
	call L_5CCC		;5cbf
	pop bc			;5cc2
	ret c			;5cc3
	ld a,c			;5cc4
	add a,004h		;5cc5
	ld c,a			;5cc7
	djnz L_5CBE		;5cc8
	and a			;5cca
	ret			;5ccb
L_5CCC:
	ld de,05ce9h		;5ccc
	ld hl,07ffah		;5ccf
	ld b,006h		;5cd2
L_5CD4:
	push bc			;5cd4
	push de			;5cd5
	ld a,c			;5cd6
	call 0000ch		;5cd7   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;5cda
	pop bc			;5cdb
	ex de,hl			;5cdc
	cp (hl)			;5cdd
	ex de,hl			;5cde
	jr nz,L_5CE7		;5cdf
	inc hl			;5ce1
	inc de			;5ce2
	djnz L_5CD4		;5ce3
	scf			;5ce5
	ret			;5ce6
L_5CE7:
	and a			;5ce7
	ret			;5ce8

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5ce9..0x5cef  (6 bytes)
DATA_5CE9:
	defb 000h,030h,031h,013h,035h,0aah	; 5ce9

; ======================================================================
; CODIGO 0x5cef..0x5d16  (39 bytes)
; ======================================================================


L_5CEF:
	call L_5CFD		;5cef
	ld c,00eh		;5cf2
	call L_48DC		;5cf4
	ld hl,05d16h		;5cf7
	jp L_4ACB		;5cfa
L_5CFD:
	ld hl,02098h		;5cfd
	ld bc,0c038h		;5d00
L_5D03:
	xor a			;5d03
	ld d,000h		;5d04
	push bc			;5d06
	push hl			;5d07
	call L_490A		;5d08
	pop hl			;5d0b
	pop de			;5d0c
	ret			;5d0d
L_5D0E:
	call L_5D03		;5d0e
	ld c,00eh		;5d11
	jp L_48DC		;5d13

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5d16..0x5d61  (75 bytes)
DATA_5D16:
	defb 058h,0a0h,030h,030h,030h,03dh,035h,03eh,045h,030h,030h,030h,0feh,028h,0b0h,04fh	; 5d16  X.000=5>E000.(.O
	defb 0feh,030h,0b0h,043h,044h,031h,042h,044h,000h,037h,031h,03dh,035h,0feh,030h,0b8h	; 5d26  .0.CD1BD.71=5.0.
	defb 03dh,03fh,034h,039h,036h,049h,000h,043h,044h,031h,037h,035h,000h,03eh,045h,03dh	; 5d36  =?496I.CD175.>E=
	defb 032h,035h,042h,0feh,030h,0c0h,03dh,03fh,034h,039h,036h,049h,000h,040h,03ch,031h	; 5d46  25B.0.=?496I.@<1
	defb 049h,035h,042h,000h,03eh,045h,03dh,032h,035h,042h,0ffh	; 5d56  I5B.>E=25B.

; ======================================================================
; CODIGO 0x5d61..0x5d72  (17 bytes)
; ======================================================================


L_5D61:
	ld hl,05d72h		;5d61
	call L_5D90		;5d64
	ld hl,0e605h		;5d67
	ld de,0b0b8h		;5d6a
L_5D6D:
	ld b,001h		;5d6d
	jp L_4578		;5d6f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5d72..0x5d82  (16 bytes)
DATA_5D72:
	defb 048h,0b8h,043h,044h,031h,037h,035h,000h,03eh,045h,03dh,032h,035h,042h,02fh,0ffh	; 5d72  H.CD175.>E=25B/.

; ======================================================================
; CODIGO 0x5d82..0x5d98  (22 bytes)
; ======================================================================


L_5D82:
	ld hl,05d98h		;5d82
	call L_5D90		;5d85
	ld hl,0e607h		;5d88
	ld de,0b8b8h		;5d8b
	jr $-33		;5d8e
L_5D90:
	push hl			;5d90
	call L_5DA9		;5d91
	pop hl			;5d94
	jp L_4ACB		;5d95

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5d98..0x5da9  (17 bytes)
DATA_5D98:
	defb 048h,0b8h,040h,03ch,031h,049h,035h,042h,000h,03eh,045h,03dh,032h,035h,042h,02fh	; 5d98  H.@<1I5B.>E=25B/
	defb 0ffh	; 5da8

; ======================================================================
; CODIGO 0x5da9..0x5e6a  (193 bytes)
; ======================================================================


L_5DA9:
	ld hl,024b0h		;5da9
	ld bc,0b818h		;5dac
	jp L_5D03		;5daf
L_5DB2:
	call L_5DE7		;5db2
	ret z			;5db5
	ld hl,(0e608h)		;5db6
	ld d,000h		;5db9
	ld b,008h		;5dbb
	ld a,l			;5dbd
	call L_5DE1		;5dbe
	jr c,L_5DCA		;5dc1
	ld a,h			;5dc3
	ld b,002h		;5dc4
	call L_5DE1		;5dc6
	ret nc			;5dc9
L_5DCA:
	ld hl,0e615h		;5dca
	ld (hl),0ffh		;5dcd
	ld hl,0e60fh		;5dcf
	ld a,d			;5dd2
	rld		;5dd3
	ld de,(0e602h)		;5dd5
	ld b,001h		;5dd9
	call L_4578		;5ddb
	jp L_5E08		;5dde
L_5DE1:
	rra			;5de1
	ret c			;5de2
	inc d			;5de3
	djnz L_5DE1		;5de4
	ret			;5de6
L_5DE7:
	xor a			;5de7
	call 00141h		;5de8   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5deb
	ld d,a			;5dec
	ld a,001h		;5ded
	call 00141h		;5def   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5df2
	and 003h		;5df3
	ld e,a			;5df5
	ld a,d			;5df6
	ld hl,0e608h		;5df7
	ld c,(hl)			;5dfa
	ld (hl),a			;5dfb
	xor c			;5dfc
	and (hl)			;5dfd
	ld d,a			;5dfe
	ld a,e			;5dff
	inc hl			;5e00
	ld c,(hl)			;5e01
	ld (hl),a			;5e02
	xor c			;5e03
	and (hl)			;5e04
	ld e,a			;5e05
	or d			;5e06
	ret			;5e07
L_5E08:
	ld hl,0e60fh		;5e08
	ld a,(hl)			;5e0b
	ld c,a			;5e0c
	rrca			;5e0d
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
	ld a,c			;5e19
	and 00fh		;5e1a
	add a,b			;5e1c
	ld (0e60eh),a		;5e1d
	ret			;5e20
L_5E21:
	ld a,007h		;5e21
	call 00141h		;5e23   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5e26
	and 080h		;5e27
	ld hl,0e60ah		;5e29
	ld c,(hl)			;5e2c
	ld (hl),a			;5e2d
	xor c			;5e2e
	and (hl)			;5e2f
	ret			;5e30
L_5E31:
	rra			;5e31
	push af			;5e32
	jr nc,L_5E60		;5e33
	ld a,(0e606h)		;5e35
	cp 013h		;5e38
	jr c,L_5E3D		;5e3a
	xor a			;5e3c
L_5E3D:
	ld (0d000h),a		;5e3d
	ld a,(0e605h)		;5e40
	cp 019h		;5e43
	jr c,L_5E48		;5e45
	xor a			;5e47
L_5E48:
	ld (0c411h),a		;5e48
	ld hl,05e6ah		;5e4b
	ld a,(0d000h)		;5e4e
	call L_4061		;5e51
	ld a,(hl)			;5e54
	ld (0d002h),a		;5e55
	xor a			;5e58
	ld (0d001h),a		;5e59
	inc a			;5e5c
	ld (0c40dh),a		;5e5d
L_5E60:
	pop af			;5e60
	rra			;5e61
	ret nc			;5e62
	ld a,(0e607h)		;5e63
	ld (0c410h),a		;5e66
	ret			;5e69

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5e6a..0x5e7d  (19 bytes)
DATA_5E6A:
	defb 000h,000h,000h,000h,001h,001h,001h,002h,002h,002h,003h,003h,003h,004h,004h,004h	; 5e6a  ................
	defb 005h,005h,005h	; 5e7a

; ======================================================================
; CODIGO 0x5e7d..0x5eb5  (56 bytes)
; ======================================================================


L_5E7D:
	rra			;5e7d
	ld a,001h		;5e7e
	jr nc,L_5E84		;5e80
	ld a,0ffh		;5e82
L_5E84:
	ld b,a			;5e84
	ld hl,0e60bh		;5e85
	add a,(hl)			;5e88
	and 003h		;5e89
	cp 003h		;5e8b
	jr nz,L_5E96		;5e8d
	ld a,b			;5e8f
	add a,a			;5e90
	ld a,002h		;5e91
	jr c,L_5E96		;5e93
	xor a			;5e95
L_5E96:
	push af			;5e96
	push hl			;5e97
	ld a,(hl)			;5e98
	call L_5EA2		;5e99
	pop hl			;5e9c
	pop af			;5e9d
	ld (hl),a			;5e9e
	jp L_5EA6		;5e9f
L_5EA2:
	ld b,000h		;5ea2
	jr L_5EA8		;5ea4
L_5EA6:
	ld b,04fh		;5ea6
L_5EA8:
	ld hl,05eb5h		;5ea8
	call L_4061		;5eab
	ld e,(hl)			;5eae
	ld d,028h		;5eaf
	ld a,b			;5eb1
	jp L_4AE7		;5eb2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5eb5..0x5eb8  (3 bytes)
DATA_5EB5:
	defb 0b0h,0b8h,0c0h	; 5eb5

; ======================================================================
; CODIGO 0x5eb8..0x5fcc  (276 bytes)
; ======================================================================


L_5EB8:
	ld a,(0c440h)		;5eb8
	and a			;5ebb
	ret nz			;5ebc
	ld a,(0c420h)		;5ebd
	cp 006h		;5ec0
	ret z			;5ec2
	ld a,(0c5ach)		;5ec3
	sub 002h		;5ec6
	ret z			;5ec8
	dec a			;5ec9
	ret z			;5eca
	cp 002h		;5ecb
	ret z			;5ecd
	di			;5ece
	ld a,00eh		;5ecf
	ld (08000h),a		;5ed1
	ld (0f0f2h),a		;5ed4
	ei			;5ed7
	ld a,(0d000h)		;5ed8
	ld de,085a6h		;5edb
	call 06542h		;5ede
	ld a,(0d001h)		;5ee1
	call L_4066		;5ee4
	ld a,(de)			;5ee7
	push af			;5ee8
	di			;5ee9
	ld a,002h		;5eea
	ld (08000h),a		;5eec
	ld (0f0f2h),a		;5eef
	ei			;5ef2
	pop af			;5ef3
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
L_5F1D:
	xor a			;5f1d
	ld b,a			;5f1e
L_5F1F:
	ld (0cffah),a		;5f1f
	ld a,b			;5f22
	ld (0cffbh),a		;5f23
	xor a			;5f26
	ld (0cf31h),a		;5f27
	ld a,c			;5f2a
	ld (0cff0h),a		;5f2b
	ld (0cff1h),de		;5f2e
	ld hl,0c800h		;5f32
	ld b,007h		;5f35
	xor a			;5f37
	ld de,00080h		;5f38
L_5F3B:
	cp (hl)			;5f3b
	jr z,L_5F42		;5f3c
	add hl,de			;5f3e
	djnz L_5F3B		;5f3f
	ret			;5f41
L_5F42:
	push hl			;5f42
	pop ix		;5f43
	ld (0cff3h),hl		;5f45
	ld a,(0cff0h)		;5f48
	ld hl,06057h		;5f4b
	call L_4061		;5f4e
	ld a,(hl)			;5f51
	ld (ix+020h),a		;5f52
	ld c,a			;5f55
	and a			;5f56
	jr z,L_5F77		;5f57
	ld de,00000h		;5f59
	ld hl,0d638h		;5f5c
	ld b,00eh		;5f5f
L_5F61:
	ld a,(hl)			;5f61
	cp 0e0h		;5f62
	jr nz,L_5F6F		;5f64
	ld (hl),0e1h		;5f66
	call 06048h		;5f68
	inc e			;5f6b
	dec c			;5f6c
	jr z,L_5F77		;5f6d
L_5F6F:
	inc d			;5f6f
	inc l			;5f70
	inc l			;5f71
	inc l			;5f72
	inc l			;5f73
	djnz L_5F61		;5f74
	ret			;5f76
L_5F77:
	ld a,001h		;5f77
	ld (0cf31h),a		;5f79
	ld hl,(0cff3h)		;5f7c
	ld a,(0cff0h)		;5f7f
	ld (hl),a			;5f82
	inc l			;5f83
	ld (hl),000h		;5f84
	ld de,(0cff1h)		;5f86
	inc l			;5f8a
	ld (hl),000h		;5f8b
	inc l			;5f8d
	ld (hl),e			;5f8e
	inc l			;5f8f
	ld (hl),000h		;5f90
	inc l			;5f92
	ld (hl),d			;5f93
	inc l			;5f94
	ld (hl),000h		;5f95
	ld a,(0cffah)		;5f97
	ld (ix+00fh),a		;5f9a
	ld a,(0cffbh)		;5f9d
	ld (ix+01fh),a		;5fa0
	ld (ix+07eh),001h		;5fa3
	ld (ix+07fh),001h		;5fa7
	ld (ix+00eh),007h		;5fab
	ld de,06084h		;5faf
	call 06029h		;5fb2
	ld a,(0cff0h)		;5fb5
	ld de,060e1h		;5fb8
	call L_4066		;5fbb
	ld a,(de)			;5fbe
	ld (ix+00dh),a		;5fbf
	ld hl,(0cff3h)		;5fc2
	ld a,(ix+000h)		;5fc5
	dec a			;5fc8
	call L_406B		;5fc9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5fcc..0x6000  (52 bytes)
DATA_5FCC:
	defb 034h,0a9h,0e0h,0a2h,0e0h,0a2h,0cah,0b0h,05ch,0a8h,073h,0a5h,061h,0b0h,0fbh,0a4h	; 5fcc  4.......\.s.a...
	defb 04ah,0afh,022h,0a2h,044h,0b3h,070h,0a6h,012h,0b2h,0cdh,0aah,093h,0b1h,0deh,0adh	; 5fdc  J.".D.p.........
	defb 022h,0abh,050h,0beh,026h,0bdh,07ch,0b8h,04fh,0bah,054h,0bch,040h,06ah,0ddh,0bah	; 5fec  ".P.&.|.O.T.@j..
	defb 0d2h,0b4h,0d2h,0b4h	; 5ffc
