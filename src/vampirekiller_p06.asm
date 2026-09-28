; ==========================================================================
; VAMPIRE KILLER / AKUMAJO DRACULA - Konami (1986) - MSX2 - MegaROM RC-744 de 128 KB (Konami4) - banco 06 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS dibujos_95B3_cola: 191 dibujos de 8x8 a 4 bits (32 bytes cada uno) del
;   decorado (sigue del banco anterior, 0x95B3); se solapan 2 bloques
;   (0xA000-0xAD93, 0xA000-0xB473); lo leen fase 10, fase 11, fase 12, fase 4,
;   fase 5, fase 6 (5235 bytes)
;   0xa000..0xb473  (5235 bytes)
DATA_dibujos_95B3_cola:
	defb 099h,09dh,0dch,0f9h,099h,099h,0dch,0f9h,099h,099h,0dch,0ffh,099h,099h,0dch,0ffh,0ffh,0f9h,099h,000h,099h,000h,000h,009h,099h,0d0h,000h,009h,09dh,000h,000h,000h	; a000  ................................
	defb 09dh,000h,000h,000h,000h,000h,000h,000h,09dh,000h,000h,000h,00dh,000h,000h,000h,009h,000h,000h,00dh,099h,000h,000h,000h,000h,0dch,0d9h,000h,0cch,099h,0ddh,0d0h	; a020  ................................
	defb 0c9h,0ddh,0d9h,0d0h,0ddh,0ddh,099h,090h,0cdh,099h,000h,009h,00dh,090h,009h,000h,000h,000h,009h,000h,0bfh,0fah,0fah,000h,0bbh,0fah,0fah,000h,00bh,0bfh,0fah,000h	; a040  ................................
	defb 00fh,0abh,0fah,000h,00fh,0aah,0bfh,000h,000h,0fah,0bfh,000h,000h,00fh,0abh,000h,000h,000h,0ffh,0bfh,0abh,0fah,0a0h,0bfh,0abh,0fah,0a0h,0bfh,0abh,0fah,0a0h,0abh	; a060  ................................
	defb 0fbh,0ffh,0aah,0aah,0abh,0bfh,0fah,0fah,000h,0bfh,0fah,0f0h,000h,00fh,0aah,000h,000h,000h,000h,0bfh,0aah,0ffh,0abh,0bfh,0aah,0bfh,0aah,0bfh,0aah,0bfh,0aah,0bfh	; a080  ................................
	defb 0fah,0bfh,0fah,0fbh,0fah,0abh,0fah,00bh,0fah,0abh,0fah,00bh,0ffh,0abh,0fah,00bh,0ffh,0abh,0ffh,0ffh,0fah,0a0h,0aah,0ffh,0ffh,0a0h,000h,0bfh,0ffh,0fah,00ah,0bbh	; a0a0  ................................
	defb 0fbh,0fah,00ah,00bh,0fbh,0fah,00fh,000h,0fbh,0fah,0aah,0a0h,0bbh,0fah,0afh,0a0h,0bbh,0fah,0aah,0f0h,0bfh,0abh,0bfh,0fah,00bh,0fah,0bfh,0ffh,0aah,0bfh,0abh,00fh	; a0c0  ................................
	defb 0f0h,0f0h,0fah,000h,000h,0fah,00fh,000h,000h,0fah,0abh,000h,000h,00fh,0aah,000h,000h,000h,0fah,0aah,0abh,0ffh,0abh,0ffh,0abh,0bfh,0abh,0bfh,0fah,0bfh,0abh,0a0h	; a0e0  ................................
	defb 00ah,0ffh,0abh,0fah,0a0h,0ffh,0abh,0ffh,0aah,0bfh,0aah,0bbh,0fah,0bfh,0fah,0bfh,0fah,00bh,0fah,0abh,0fah,00bh,0fah,0abh,0fah,0abh,0ffh,0fbh,0fah,0abh,0ffh,00bh	; a100  ................................
	defb 0ffh,0a0h,0bfh,00bh,0ffh,0aah,00bh,00bh,0ffh,0aah,00bh,000h,0bfh,0aah,0abh,000h,0bfh,0fah,0a0h,0fah,0bfh,0a0h,0b0h,0fah,0ffh,0a0h,0b0h,0fah,0bfh,0a0h,0b0h,0fah	; a120  ................................
	defb 0bfh,0aah,0bbh,0fah,0bfh,0fah,00bh,0fah,00bh,0fah,00bh,0fah,00bh,0fah,00bh,0fah,00bh,0fah,00bh,0bah,0ffh,0bah,0aah,0bah,0fbh,0bah,0ffh,0bah,0fbh,0afh,0fbh,0bah	; a140  ................................
	defb 0ffh,0a0h,00ah,0bah,0ffh,00ah,0afh,0aah,0fbh,0aah,0ffh,0afh,0fbh,0afh,0bbh,0afh,0b0h,0afh,0fbh,0bah,0ffh,0aah,0fbh,0aah,0fbh,0aah,0fbh,0aah,0fbh,0aah,0fbh,0afh	; a160  ................................
	defb 0fbh,0afh,0fbh,0afh,0bah,0afh,0bfh,0afh,0bah,0afh,0b0h,0afh,0bah,0ffh,0b0h,0ffh,0bah,0ffh,0b0h,0afh,0afh,0fbh,000h,0afh,0afh,0bbh,000h,0afh,0fbh,0b0h,000h,0afh	; a180  ................................
	defb 0bah,0f0h,000h,0fbh,0aah,0f0h,000h,0fbh,0afh,000h,000h,0bah,0f0h,000h,000h,0ffh,000h,000h,000h,0fah,00bh,0fah,0aah,0fah,0abh,0ffh,0abh,0fah,0abh,0ffh,0abh,0fah	; a1a0  ................................
	defb 0bah,0bfh,0abh,0fbh,0bah,0bfh,0abh,0abh,0fah,0bah,0abh,0abh,0fah,0bah,0abh,0abh,0fah,0bah,0abh,0aah,00ah,0afh,0ffh,000h,00ah,0ffh,0ffh,0a0h,0afh,0ffh,0fbh,0a0h	; a1c0  ................................
	defb 0afh,0bfh,0bbh,0f0h,0afh,0bfh,0b0h,0aah,0afh,0bfh,000h,0fah,0afh,0bbh,00ah,0aah,0afh,0bbh,00ah,0fbh,0bah,0fbh,00fh,0fbh,0afh,0b0h,0afh,0bah,0fbh,0aah,0ffh,0afh	; a1e0  ................................
	defb 00fh,00fh,0f0h,0f0h,0afh,000h,000h,0bah,0afh,000h,000h,0aah,0f0h,000h,000h,0afh,000h,000h,000h,0abh,0ffh,0aah,0bfh,0abh,0ffh,0abh,0bfh,0abh,0ffh,0abh,0ffh,0abh	; a200  ................................
	defb 0ffh,0abh,0fah,0fah,0bah,0bfh,0fah,0fah,0bbh,0bfh,0aah,0f0h,0fbh,0ffh,0a0h,0f0h,00bh,0fah,0a0h,00ah,0afh,0bah,0fbh,00ah,0afh,0bah,0fbh,00ah,0afh,0bah,0fbh,0aah	; a220  ................................
	defb 0ffh,0bfh,0bah,0afh,0fbh,0bah,0aah,0afh,0fbh,000h,0afh,0aah,0f0h,000h,00fh,000h,000h,000h,000h,0ffh,0ffh,0fah,0aah,0ffh,0bah,0bbh,0ffh,0aah,0aah,0abh,0bbh,00ah	; a240  ................................
	defb 0abh,0bah,0a0h,0ffh,0afh,0ffh,0aah,0afh,0bfh,0bbh,0ffh,000h,00ah,0aah,0aah,00fh,0fbh,0ffh,0aah,000h,00ah,0aah,0aah,0aah,0ffh,0aah,000h,000h,000h,0afh,000h,000h	; a260  ................................
	defb 00ah,0aah,0aah,0aah,0fah,0aah,000h,000h,00ah,000h,000h,00ah,0aah,0f0h,000h,000h,00ah,0aah,0a0h,00dh,0cdh,000h,00eh,00dh,0cch,0d0h,0ech,00dh,0dch,0cch,0cch,000h	; a280  ................................
	defb 0ddh,099h,099h,000h,00dh,0cch,0eeh,000h,00dh,0cch,0ddh,000h,00dh,0cdh,099h,000h,0dch,0d9h,000h,0d0h,000h,000h,000h,0d0h,000h,000h,000h,0d0h,000h,000h,000h,000h	; a2a0  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,0d0h,000h,000h,000h,0cch,000h,000h,000h,0ddh,0cdh,000h,000h,000h,0bfh,0fah,0a0h,000h,0bfh,0aah,0abh,00bh,0ffh,0aah,00bh,00bh	; a2c0  ................................
	defb 0ffh,0aah,00bh,00bh,0ffh,0a0h,0bfh,0fbh,0fah,0abh,0ffh,0abh,0fah,0abh,0ffh,0abh,0fah,00bh,0fah,000h,000h,000h,0ffh,000h,000h,00fh,0abh,000h,000h,0fah,0bfh,000h	; a2e0  ................................
	defb 00fh,0aah,0bfh,000h,00fh,0abh,0fah,000h,00bh,0bfh,0fah,000h,0bbh,0fah,0fah,000h,0bfh,0fah,0fah,0bfh,0fah,00bh,0fah,0bbh,0fah,0bfh,0fah,0ffh,0aah,0bfh,0aah,0fah	; a300  ................................
	defb 0a0h,0ffh,0abh,0a0h,00ah,0ffh,0abh,0bfh,0fah,0bfh,0abh,0ffh,0abh,0bfh,0abh,0aah,0abh,0ffh,0abh,000h,000h,000h,000h,0aah,0f0h,000h,00fh,0afh,0fbh,000h,0afh,0afh	; a320  ................................
	defb 0fbh,0bah,0aah,0aah,0ffh,0bfh,0bah,00ah,0afh,0bah,0fbh,00ah,0afh,0bah,0fbh,00ah,0afh,0bah,0fbh,0afh,000h,000h,000h,0aah,0f0h,000h,000h,0bah,0afh,000h,000h,0f0h	; a340  ................................
	defb 0afh,000h,000h,0afh,00fh,00fh,0f0h,0bah,0fbh,0aah,0ffh,0fbh,0afh,0b0h,0afh,0fbh,0bah,0fbh,00fh,0ffh,0bah,0ffh,0b0h,0afh,0bah,0ffh,0b0h,0afh,0bah,0afh,0b0h,0afh	; a360  ................................
	defb 0bah,0afh,0bfh,0afh,0fbh,0afh,0fbh,0aah,0fbh,0aah,0fbh,0aah,0fbh,0aah,0fbh,0bah,0ffh,0aah,0fbh,0afh,0b0h,0afh,0fbh,0afh,0fbh,0afh,0bbh,0aah,0fbh,0aah,0ffh,0bah	; a380  ................................
	defb 0ffh,00ah,0afh,0bah,0ffh,0a0h,00ah,0bah,0fbh,0afh,0fbh,0bah,0fbh,0bah,0ffh,0bah,0ffh,0bah,0aah,0ffh,000h,000h,000h,0bah,0f0h,000h,000h,0fbh,0afh,000h,000h,0fbh	; a3a0  ................................
	defb 0aah,0f0h,000h,0afh,0bah,0f0h,000h,0afh,0fbh,0b0h,000h,0afh,0afh,0bbh,000h,0afh,0afh,0fbh,000h,0abh,0fah,0bah,0abh,0abh,0fah,0bah,0abh,0abh,0fah,0bah,0abh,0fbh	; a3c0  ................................
	defb 0bah,0bfh,0abh,0fah,0bah,0bfh,0abh,0fah,0abh,0ffh,0abh,0fah,0abh,0ffh,0abh,0fah,00bh,0fah,0aah,0aah,0afh,0bbh,00ah,0fah,0afh,0bbh,00ah,0aah,0afh,0bfh,000h,0f0h	; a3e0  ................................
	defb 0afh,0bfh,0b0h,0a0h,0afh,0bfh,0bbh,0a0h,0afh,0ffh,0fbh,000h,00ah,0ffh,0ffh,0aah,00ah,0afh,0ffh,0fah,00bh,0fah,00bh,0fah,00bh,0fah,00bh,0fah,00bh,0fah,00bh,0fah	; a400  ................................
	defb 0bfh,0fah,00bh,0fah,0bfh,0aah,0bbh,0fah,0bfh,0a0h,0b0h,0fah,0ffh,0a0h,0b0h,0fah,0bfh,0a0h,0b0h,00bh,0ffh,0abh,0ffh,00bh,0ffh,0abh,0fah,00bh,0fah,0abh,0fah,0fbh	; a420  ................................
	defb 0fah,0abh,0fah,0bfh,0fah,0bfh,0fah,0bfh,0aah,0bfh,0aah,0bfh,0aah,0bfh,0aah,0bfh,0aah,0ffh,0abh,0a0h,0bbh,0fah,0aah,0a0h,0bbh,0fah,0afh,000h,0fbh,0fah,0aah,00bh	; a440  ................................
	defb 0fbh,0fah,00fh,0bbh,0fbh,0fah,00ah,0bfh,0ffh,0fah,00ah,0ffh,0ffh,0a0h,000h,0ffh,0fah,0a0h,0aah,000h,000h,000h,000h,0f0h,000h,00fh,0aah,0fah,000h,0bfh,0fah,0aah	; a460  ................................
	defb 0abh,0bfh,0fah,0abh,0fbh,0ffh,0aah,0bfh,0abh,0fah,0a0h,0bfh,0abh,0fah,0a0h,0bfh,0abh,0fah,0a0h,0f0h,00bh,0fah,0a0h,0f0h,0fbh,0ffh,0a0h,0fah,0bbh,0bfh,0aah,0fah	; a480  ................................
	defb 0bah,0bfh,0fah,0abh,0ffh,0abh,0fah,0abh,0ffh,0abh,0ffh,0abh,0ffh,0abh,0bfh,0abh,0ffh,0aah,0bfh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0abh,0ffh,0ffh,0fah,0bfh,0ffh	; a4a0  ................................
	defb 0ffh,0aah,0bfh,0ffh,0ffh,0abh,0fah,0ffh,0fbh,0bfh,0fah,0ffh,0bbh,0fah,0fah,0ffh,0bfh,0fah,0fah,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0aah,0fah,0ffh,0bfh,0fah,0aah	; a4c0  ................................
	defb 0abh,0bfh,0fah,0abh,0fbh,0ffh,0aah,0bfh,0abh,0fah,0a0h,0bfh,0abh,0fah,0a0h,0bfh,0abh,0fah,0a0h,0afh,0ffh,0ffh,0ffh,0aah,0ffh,0ffh,0ffh,0bah,0afh,0ffh,0ffh,0f0h	; a4e0  ................................
	defb 0afh,0ffh,0ffh,0afh,00fh,0ffh,0ffh,0bah,0fbh,0aah,0ffh,0fbh,0afh,0b0h,0afh,0fbh,0bah,0fbh,00fh,0ffh,0ffh,0ffh,0ffh,0aah,0ffh,0ffh,0ffh,0afh,0fbh,0ffh,0afh,0afh	; a500  ................................
	defb 0fbh,0bah,0aah,0aah,0ffh,0bfh,0bah,00ah,0afh,0bah,0fbh,00ah,0afh,0bah,0fbh,00ah,0afh,0bah,0fbh,0ffh,0ffh,0ffh,0ffh,0bah,0ffh,0ffh,0ffh,0fbh,0afh,0ffh,0ffh,0fbh	; a520  ................................
	defb 0aah,0ffh,0ffh,0afh,0bah,0ffh,0ffh,0afh,0fbh,0bfh,0ffh,0afh,0afh,0bbh,0ffh,0afh,0afh,0fbh,0ffh,0cdh,0ddh,099h,000h,009h,0cdh,099h,000h,090h,009h,090h,009h,090h	; a540  ................................
	defb 000h,000h,099h,000h,0d9h,0d0h,099h,090h,0d9h,099h,000h,090h,099h,090h,000h,090h,000h,000h,000h,0f0h,0dch,0cdh,0dfh,00dh,0ech,0cch,0d9h,0dch,000h,0cch,0c9h,0dch	; a560  ................................
	defb 000h,0c9h,0d9h,0fch,0cch,090h,0d9h,0cdh,00dh,000h,0d9h,0ddh,0ddh,0ddh,09dh,0ffh,0ddh,099h,00dh,000h,00fh,00ch,09fh,00ch,090h,0cch,090h,00ch,0c9h,099h,00ch,0f9h	; a580  ................................
	defb 0c9h,000h,009h,0f0h,0cch,090h,0c9h,00ch,0cdh,090h,0cch,0cch,0c9h,00ch,09ch,0cdh,0d9h,0c9h,00ch,0c9h,000h,00eh,0c9h,00ch,090h,00ch,0c9h,000h,0cdh,099h,090h,0c0h	; a5a0  ................................
	defb 099h,00ch,09dh,09ch,0d9h,0c9h,00dh,009h,090h,090h,00dh,0cch,0cch,0c9h,0ddh,099h,099h,090h,099h,0f0h,0dch,0ddh,09fh,00dh,0ech,0cdh,0d9h,0ddh,0cch,0cch,0d9h,0ddh	; a5c0  ................................
	defb 000h,0c0h,009h,09dh,000h,0d0h,009h,099h,0ddh,00ch,0d9h,009h,00dh,0ddh,090h,099h,009h,099h,090h,00dh,0c9h,000h,009h,00dh,090h,00eh,090h,09ch,090h,0e9h,000h,09ch	; a5e0  ................................
	defb 090h,0cdh,099h,09dh,0c9h,0cdh,099h,00dh,0d9h,00dh,0d0h,099h,0ddh,099h,0ddh,009h,099h,090h,099h,00fh,00fh,0ffh,000h,00ah,0aah,0aah,0a0h,0aah,0aah,000h,0a0h,000h	; a600  ................................
	defb 000h,000h,000h,000h,0bbh,0bbh,0bfh,00bh,0ffh,0ffh,0f0h,00bh,00fh,0ffh,0ffh,000h,0aah,0aah,0aah,00fh,0ffh,0ffh,00fh,00fh,0aah,0aah,00ah,000h,0fah,0aah,0aah,000h	; a620  ................................
	defb 000h,000h,000h,0ffh,00fh,0ffh,000h,0ffh,0ffh,0ffh,0a0h,0ffh,0f0h,00fh,0a0h,0aah,0aah,00ah,000h,000h,000h,000h,000h,0bbh,0abh,0bbh,000h,0ffh,0f0h,0fbh,0a0h,0ffh	; a640  ................................
	defb 0ffh,0ffh,0a0h,0bfh,0ffh,0ffh,0a0h,00bh,0bfh,0ffh,0a0h,0f0h,00fh,0fah,0a0h,0a0h,00ah,0aah,000h,000h,000h,000h,000h,000h,0bbh,0bah,0abh,00bh,0bfh,000h,0ffh,00bh	; a660  ................................
	defb 0f0h,0bbh,0ffh,00bh,0fbh,0ffh,0ffh,00bh,0ffh,0ffh,0ffh,00bh,0afh,0ffh,0ffh,000h,0aah,0aah,0aah,000h,000h,000h,000h,000h,0bbh,0bbh,0bbh,00bh,0bah,0abh,0bah,00bh	; a680  ................................
	defb 0bah,00bh,0ffh,00bh,0bfh,0f0h,00bh,00bh,0bfh,0fbh,0bfh,00bh,0bfh,0ffh,0ffh,00bh,0bfh,00fh,0ffh,000h,000h,000h,000h,0bbh,0bbh,0bbh,0bbh,0bbh,0bbh,0bah,0bbh,0ffh	; a6a0  ................................
	defb 0f0h,00bh,0ffh,0ffh,0ffh,0bfh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,0bfh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,0bbh,0abh,0bbh,0bbh,0bah,0bbh,0bbh,0bbh,000h	; a6c0  ................................
	defb 0bfh,0ffh,0ffh,0f0h,0bfh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00bh,0ffh,0ffh,0ffh,0bfh,0ffh,0ffh,000h,000h,000h,000h,0bbh,0abh,0bbh,000h,0bah,0abh,0bbh,0a0h,00bh	; a6e0  ................................
	defb 0ffh,0bah,0a0h,00bh,0ffh,0fah,0a0h,0bfh,0ffh,0fah,0a0h,0ffh,0ffh,0fah,0a0h,0ffh,0ffh,0fah,0a0h,00bh,0bfh,0b0h,00bh,00bh,0bfh,0fbh,0b0h,00bh,0bfh,0ffh,0f0h,00bh	; a700  ................................
	defb 0bfh,0ffh,0ffh,00bh,0bah,0ffh,0ffh,00bh,0aah,0aah,0aah,000h,00ah,0aah,0aah,000h,000h,000h,000h,0ffh,00bh,0ffh,000h,0bfh,0ffh,0ffh,0bbh,0b0h,0bfh,0ffh,0ffh,0ffh	; a720  ................................
	defb 00bh,0ffh,0ffh,0ffh,00bh,0ffh,0ffh,0aah,000h,0aah,0aah,0aah,000h,0aah,0aah,000h,000h,000h,000h,0bfh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,0ffh	; a740  ................................
	defb 0f0h,0bfh,0b0h,0ffh,000h,0bfh,0ffh,00ah,0aah,0aah,0aah,0aah,0aah,0aah,0aah,000h,000h,000h,000h,0ffh,0ffh,000h,0a0h,0f0h,0bfh,0bah,0a0h,00bh,0ffh,0fah,0a0h,0bfh	; a760  ................................
	defb 0ffh,0fah,0a0h,0ffh,0ffh,0aah,0a0h,0aah,0aah,0aah,0a0h,0aah,0aah,0aah,000h,000h,000h,000h,000h,000h,000h,000h,000h,00bh,0bbh,0bbh,0abh,0bfh,0ffh,0f0h,0ffh,0bfh	; a780  ................................
	defb 0ffh,0fbh,0ffh,0bfh,0ffh,0ffh,0fah,0bfh,00bh,0ffh,0a0h,0a0h,0bfh,0fah,000h,0bfh,0ffh,0a0h,00ah,000h,000h,000h,000h,0bbh,0a0h,000h,000h,0fah,000h,000h,0bbh,0a0h	; a7a0  ................................
	defb 00bh,0bbh,0ffh,000h,0bfh,0ffh,0ffh,00bh,0ffh,0ffh,0ffh,0bfh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f0h,000h,0bfh,0ffh,0fbh,000h,0bfh,0ffh,0f0h,000h,00bh,0ffh,0f0h,0a0h	; a7c0  ................................
	defb 000h,0bfh,0ffh,0fah,000h,0bfh,0ffh,0ffh,0a0h,00ah,0aah,0ffh,0fah,000h,000h,0bfh,0ffh,0a0h,000h,0ffh,0ffh,0ffh,0ffh,0bfh,0ffh,0ffh,0ffh,0b0h,0bfh,0aah,0aah,0f0h	; a7e0  ................................
	defb 00ah,000h,000h,0aah,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0bbh,0bbh,0ffh,00bh,000h	; a800  ................................
	defb 000h,0bah,00fh,000h,000h,000h,0bbh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0fah,000h,00bh,0ffh,0fah,000h,00bh,0ffh,0a0h,000h,0bfh	; a820  ................................
	defb 0fah,000h,00bh,0ffh,0fah,000h,0bfh,0bbh,0b0h,00bh,0ffh,000h,000h,0bfh,0ffh,000h,00bh,0ffh,0ffh,000h,000h,000h,000h,000h,000h,00bh,0bbh,0bbh,000h,000h,0bfh,0ffh	; a840  ................................
	defb 0aah,0a0h,00bh,0ffh,0ffh,0fah,000h,0ffh,0ffh,0ffh,0a0h,0ffh,0ffh,0ffh,0fah,00bh,0ffh,000h,0bfh,000h,000h,000h,000h,0bah,0bbh,0bbh,0b0h,0ffh,00bh,0ffh,0fah,0ffh	; a860  ................................
	defb 0bfh,0ffh,0fah,0bfh,0ffh,0fbh,0fah,00bh,0ffh,0f0h,0b0h,000h,0bfh,0ffh,000h,000h,00bh,0ffh,0fah,0bfh,0fah,000h,0a0h,0bfh,0a0h,00bh,0f0h,0bfh,0a0h,0bfh,000h,0bah	; a880  ................................
	defb 000h,0bfh,0bbh,0bah,00bh,0ffh,0ffh,0a0h,00bh,0ffh,0f0h,0a0h,0a0h,0ffh,0f0h,000h,0bfh,00bh,0ffh,0bfh,0ffh,00bh,0fbh,0bfh,0ffh,0ffh,0ffh,0bfh,0ffh,00bh,0bfh,0ffh	; a8a0  ................................
	defb 0ffh,0f0h,00bh,0ffh,0ffh,0ffh,000h,0bfh,0ffh,0ffh,0a0h,00bh,0ffh,0fah,000h,0ffh,0ffh,0fah,000h,0ffh,0fah,000h,000h,0ffh,0a0h,000h,000h,0fah,000h,000h,000h,0a0h	; a8c0  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0bfh,0ffh,000h,000h,00bh,0ffh,000h,000h,000h,0bfh,000h	; a8e0  ................................
	defb 000h,000h,00bh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0bfh,0f0h,0bbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f0h,0bfh,0ffh,0ffh	; a900  ................................
	defb 0ffh,0ffh,0ffh,0afh,0ffh,0ffh,0ffh,00bh,0ffh,0ffh,0ffh,000h,0bfh,0ffh,0f0h,000h,0bfh,0ffh,0ffh,000h,000h,0bfh,0fah,00fh,0a0h,00bh,0fah,000h,0fah,00bh,0fah,0ffh	; a920  ................................
	defb 0fah,000h,0bah,0ffh,0ffh,0a0h,0bah,00bh,0ffh,0a0h,00ah,00bh,0ffh,000h,00ah,0bfh,0f0h,0fah,000h,000h,0bfh,000h,0bfh,000h,0bfh,0ffh,0ffh,000h,0aah,0aah,0aah,000h	; a940  ................................
	defb 000h,000h,000h,00bh,0bbh,0bbh,0bah,00ah,0ffh,0f0h,000h,00bh,00bh,0ffh,0bbh,00bh,0ffh,0ffh,0ffh,0fbh,0bfh,0a0h,000h,0f0h,00fh,0a0h,000h,0aah,00ah,000h,000h,000h	; a960  ................................
	defb 000h,000h,000h,0bbh,0bbh,000h,000h,0bfh,0fah,000h,000h,0ffh,0ffh,0b0h,000h,0ffh,0ffh,0a0h,000h,000h,00bh,0ffh,0bfh,000h,00bh,0f0h,00bh,000h,000h,0a0h,0aah,000h	; a980  ................................
	defb 000h,000h,000h,000h,000h,0bbh,0bbh,000h,000h,0bfh,0ffh,000h,00bh,0ffh,0ffh,000h,00bh,0ffh,0ffh,0ffh,000h,0fah,000h,0ffh,0bbh,0fah,000h,0aah,0aah,0aah,000h,000h	; a9a0  ................................
	defb 000h,000h,000h,0abh,0bbh,0bbh,0b0h,000h,00bh,0ffh,00ah,0fbh,0bfh,0f0h,00ah,0ffh,0ffh,0fbh,0bah,000h,000h,000h,000h,000h,0bbh,0bbh,0bbh,000h,00bh,0bah,0bbh,000h	; a9c0  ................................
	defb 000h,00bh,0ffh,000h,000h,0bfh,0ffh,000h,000h,00fh,0ffh,000h,000h,00fh,0ffh,000h,000h,00fh,0ffh,000h,0ffh,0ffh,0ffh,000h,00fh,0ffh,0ffh,000h,000h,0ffh,000h,000h	; a9e0  ................................
	defb 000h,0bfh,0b0h,000h,000h,00fh,0ffh,000h,000h,00ah,0aah,000h,000h,00ah,0aah,000h,000h,000h,000h,000h,00fh,0a0h,0bah,000h,000h,000h,000h,000h,0a0h,0fbh,0a0h,000h	; aa00  ................................
	defb 0a0h,0ffh,0a0h,000h,0a0h,0ffh,0a0h,000h,000h,000h,000h,000h,00bh,0a0h,0bbh,000h,00fh,0a0h,0bfh,0aah,00ah,0aah,0a0h,000h,000h,000h,000h,0bbh,0bah,00bh,0bbh,0bfh	; aa20  ................................
	defb 0fah,00bh,0ffh,0aah,0aah,00ah,0aah,000h,000h,000h,000h,0bah,00bh,0bbh,0a0h,0fah,00bh,0ffh,0a0h,0aah,0aah,0a0h,0bah,000h,000h,000h,000h,0bbh,0a0h,0bbh,0bah,0ffh	; aa40  ................................
	defb 0a0h,0bfh,0fah,0aah,0a0h,0aah,0aah,000h,000h,000h,000h,0bbh,0bbh,0a0h,0bbh,0bfh,0ffh,0a0h,0bfh,0aah,00fh,0a0h,000h,000h,000h,000h,000h,00bh,0fah,00ah,000h,00fh	; aa60  ................................
	defb 0fah,00ah,000h,00fh,0fah,00ah,000h,000h,000h,000h,000h,0bah,00bh,0a0h,000h,0fah,00fh,0a0h,000h,000h,000h,000h,000h,000h,0aah,0ffh,0fbh,000h,0aah,0ffh,0fbh,000h	; aa80  ................................
	defb 000h,0aah,0afh,000h,000h,008h,088h,000h,0ffh,0fbh,0fbh,000h,0aah,0afh,0afh,000h,000h,000h,000h,000h,000h,000h,000h,0cch,0cbh,0bbh,0bfh,0cch,0cbh,0bbh,0bfh,0bbh	; aaa0  ................................
	defb 0bfh,0ffh,0fah,088h,088h,088h,080h,0cch,0cbh,0bbh,0bfh,0bbh,0bfh,0ffh,0fah,000h,000h,000h,000h,000h,000h,000h,000h,0bfh,0ffh,0afh,0aah,0bfh,0ffh,0afh,0aah,0fah	; aac0  ................................
	defb 0aah,00ah,000h,088h,088h,008h,000h,0bfh,0ffh,0afh,0aah,0fah,0aah,00ah,000h,000h,000h,000h,000h,000h,000h,000h,000h,0a0h,00ah,0a0h,000h,0a0h,00ah,0a0h,000h,000h	; aae0  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,0a0h,000h,0aah,0a0h,000h,000h,000h,000h,000h,000h,000h,000h,00fh,0bfh,000h,00ch,00fh,0bbh,0f0h,0cbh,00fh,0fbh,0bbh,0bbh,000h	; ab00  ................................
	defb 0ffh,0aah,0aah,000h,00fh,0bbh,0cch,000h,00fh,0bbh,0ffh,000h,00fh,0bfh,0aah,000h,0fbh,0fah,000h,0cch,0bbh,0fah,000h,0bbh,0bfh,0a0h,0bbh,0bbh,0fah,000h,00ah,0ffh	; ab20  ................................
	defb 0fah,000h,0cbh,0aah,0a0h,0cch,0bfh,0cch,0cbh,0bbh,0f0h,0bbh,0bbh,0bfh,000h,0bbh,0bfh,0fah,000h,000h,0cbh,0ffh,0aah,0ffh,00ch,0bfh,0ffh,0c0h,000h,0cbh,0ffh,0fah	; ab40  ................................
	defb 000h,0cbh,0bfh,0bfh,0aah,00bh,0bbh,00bh,0ffh,0fah,0aah,000h,0bfh,0ffh,0ffh,000h,0cbh,0bfh,0ffh,0f0h,000h,000h,000h,0f0h,000h,000h,000h,0f0h,000h,000h,000h,000h	; ab60  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,0f0h,000h,000h,000h,0bbh,000h,000h,000h,0ffh,0bfh,000h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab80  ................................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00eh,0cdh,000h,00eh,00eh,0cch,0d0h,0ech,00eh,0cch,0cch,0cch,000h	; aba0  ................................
	defb 0edh,099h,099h,000h,00dh,0ech,0cch,000h,00eh,0cch,0ddh,000h,00eh,0cdh,099h,000h,0ech,0d9h,000h,0cch,0ddh,09eh,0cch,0cch,0d9h,00eh,0cch,0ddh,0d9h,00eh,0cdh,099h	; abc0  ................................
	defb 09dh,000h,0ech,0d9h,0cch,0d9h,00dh,0c9h,0dch,0cdh,090h,0dch,09dh,0cdh,090h,0dch,09dh,0cdh,090h,0cdh,099h,000h,00ch,0d9h,000h,00eh,0ech,090h,00eh,0ech,0cdh,0ceh	; abe0  ................................
	defb 0ech,0cdh,0d9h,0cch,0cdh,0d9h,090h,0ddh,0d9h,090h,000h,099h,090h,000h,00fh,000h,000h,0ffh,0ffh,0cch,0cch,0cch,0d9h,0ddh,0ddh,0deh,0cdh,099h,099h,099h,0ech,000h	; ac00  ................................
	defb 000h,000h,00eh,000h,000h,000h,000h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ech,0ddh,0ddh,0ddh,0cdh,09ch,0cch,0cch,0d9h,0eeh,0ech,0cch,090h	; ac20  ................................
	defb 000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0f0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0d0h,000h,0eeh,0cdh,0d9h,090h,000h,0ech,0cdh,0d9h,090h,00eh,0ech	; ac40  ................................
	defb 0cdh,0d9h,09dh,00eh,0ech,0cdh,0ddh,000h,00eh,0ech,0cch,0f0h,000h,00eh,0eeh,0ffh,0ffh,000h,000h,0ddh,09eh,0cch,0ddh,0ddh,090h,0ech,0ddh,0cdh,090h,0ech,0cch,0d9h	; ac60  ................................
	defb 000h,0ceh,0eeh,0c0h,0ech,0ddh,0ech,00eh,0cdh,0dch,0edh,00eh,0cdh,0ceh,0dch,00eh,0cdh,0ceh,0dch,090h,000h,0cdh,090h,0d9h,00ch,0ddh,090h,0ddh,0ddh,0ddh,090h,0eeh	; ac80  ................................
	defb 0eeh,0c9h,000h,0ddh,0d9h,0c0h,000h,0cch,0ddh,090h,000h,0eeh,0cdh,090h,000h,000h,0ech,0d9h,000h,0eeh,0cch,0d9h,000h,0cch,0cdh,090h,0cch,0cch,0d9h,000h,009h,0ddh	; aca0  ................................
	defb 0d9h,000h,0ech,099h,090h,0eeh,0cdh,0eeh,0ech,0cch,0d0h,0cch,0cch,0cdh,000h,0cch,0cdh,0d9h,000h,0cdh,09dh,0cdh,090h,0d9h,0dch,0cdh,000h,09dh,0cch,0d0h,00fh,0cch	; acc0  ................................
	defb 0cdh,000h,00fh,0ddh,0d0h,000h,0ffh,000h,000h,00fh,0ffh,000h,00fh,0ffh,0ffh,00fh,0ffh,0ffh,0ffh,00eh,0cdh,0ceh,0cdh,000h,0cdh,0dch,0ech,0f0h,00ch,0ddh,0ceh,0f0h	; ace0  ................................
	defb 000h,0cdh,0ddh,0ffh,000h,00ch,0cch,0ffh,0f0h,000h,000h,0ffh,0ffh,0f0h,000h,0ffh,0ffh,0ffh,0f0h,000h,0ech,0ddh,099h,0ddh,00eh,0cdh,0ddh,0e0h,000h,0ech,0ddh,0d9h	; ad00  ................................
	defb 000h,0ech,0cch,0cdh,099h,00eh,0eeh,00ch,0ddh,0d9h,099h,000h,0cdh,0ddh,0ddh,000h,0ech,0cdh,0ddh,0ddh,0ddh,0c9h,000h,099h,00ch,0c9h,000h,000h,0ech,0d0h,00fh,000h	; ad20  ................................
	defb 0ech,0d0h,00fh,000h,0edh,000h,0ffh,00eh,0cdh,00fh,0ffh,00eh,0d0h,00fh,0ffh,00ch,0d0h,0ffh,0ffh,000h,0edh,0cch,0cch,000h,0edh,0d0h,0eeh,0f0h,00ch,0d9h,000h,0f0h	; ad40  ................................
	defb 00ch,0d9h,000h,0ffh,000h,0c9h,000h,0ffh,0f0h,0cdh,090h,0ffh,0f0h,00ch,090h,0ffh,0ffh,00ch,0d0h,0edh,00fh,0ffh,0ffh,0c0h,00fh,0ffh,0ffh,0c0h,0ffh,0ffh,0ffh,000h	; ad60  ................................
	defb 0ffh,0ffh,0ffh,00fh,0ffh,0ffh,0ffh,00fh,0ffh,0ffh,0ffh,00fh,0ffh,0ffh,0ffh,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0f0h,0c9h,0ffh,0ffh,0f0h,00dh,0ffh,0ffh,0ffh,00dh,0ffh	; ad80  ................................
	defb 0ffh,0ffh,000h,0ffh,0ffh,0ffh,0f0h,0ffh,0ffh,0ffh,0f0h,0ffh,0ffh,0ffh,0f0h,0ffh,0ffh,0ffh,0f0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ada0  ................................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0cfh,0ffh,0ffh,0ffh,0cfh,0ffh,0ffh,0ffh,0edh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adc0  ................................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fdh,0ffh,0ffh,0ffh,0fdh,0ffh,0ffh,0ffh,0c9h,00ch,0dfh,0ffh,0ffh,00eh,0dfh,0ffh,0ffh,00eh,0cdh,0ffh,0ffh,000h	; ade0  ................................
	defb 0edh,0ffh,0ffh,000h,0ech,0dfh,0ffh,000h,0ech,0dfh,0ffh,099h,00ch,0c9h,0ffh,0ddh,0ddh,0c9h,0ffh,0ffh,0ffh,0fch,0d0h,0ffh,0ffh,0fch,090h,0ffh,0ffh,0cdh,090h,0ffh	; ae00  ................................
	defb 0ffh,0c9h,000h,0ffh,0fch,0d9h,000h,0ffh,0fch,0d9h,000h,0ffh,0edh,0d0h,0eeh,0ffh,0edh,0cch,0cch,0cch,0cdh,0d9h,0ffh,0cch,0cch,0cdh,0ffh,0eeh,0ech,0cch,0dfh,099h	; ae20  ................................
	defb 090h,0eeh,0cdh,0ddh,0d9h,000h,0ech,0cch,0d9h,000h,009h,0cch,0cdh,090h,0cch,0eeh,0cch,0d9h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ddh	; ae40  ................................
	defb 0dfh,0ffh,0ffh,0cch,0cdh,0ffh,0ffh,09dh,0cch,0dfh,0ffh,0d9h,0dch,0cdh,0ffh,0cdh,09dh,0cdh,09fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae60  ................................
	defb 0ffh,0fch,0cch,0ffh,0ffh,0cdh,0ddh,0ffh,0fch,0ddh,0ceh,0ffh,0cdh,0dch,0ech,0feh,0cdh,0ceh,0cdh,0ffh,0ech,0cdh,0ddh,0ffh,0cdh,0ddh,0ddh,0fch,0ddh,0d9h,099h,0cdh	; ae80  ................................
	defb 099h,00eh,0eeh,0d9h,000h,0ech,0cch,0e0h,000h,0ech,0ddh,0ddh,00eh,0cdh,0ddh,000h,0ech,0ddh,099h,000h,0ech,0d9h,000h,000h,00eh,0cdh,099h,000h,00eh,0cch,0d0h,000h	; aea0  ................................
	defb 000h,000h,000h,090h,000h,000h,000h,0d9h,0eeh,0ech,0cch,0cdh,09ch,0cch,0cch,0ech,0ddh,0ddh,0ddh,0dch,09dh,000h,000h,0d0h,000h,00eh,0eeh,000h,00eh,0ech,0cch,00eh	; aec0  ................................
	defb 0ech,0cdh,0ddh,0ech,0cdh,0d9h,09dh,0cdh,0d9h,090h,00eh,0d9h,090h,000h,0ech,0d0h,000h,0eeh,0cdh,00eh,0cdh,0ceh,0dch,00eh,0cdh,0ceh,0dch,00eh,0cdh,0dch,0edh,0c0h	; aee0  ................................
	defb 0ech,0ddh,0ech,0d9h,000h,0ceh,0eeh,0cdh,090h,0ech,0cch,0ddh,090h,0ech,0ddh,0ddh,09eh,0cch,0ddh,000h,0ech,0d9h,000h,0eeh,0cdh,090h,000h,0cch,0ddh,090h,000h,0ddh	; af00  ................................
	defb 0d9h,0c0h,000h,0eeh,0eeh,0c9h,000h,0ddh,0ddh,0ddh,090h,0d9h,00ch,0ddh,090h,090h,000h,0cdh,090h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,09dh,000h,0f0h,00fh,090h	; af20  ................................
	defb 0d0h,009h,090h,000h,000h,000h,000h,000h,000h,0aah,0a0h,0aah,0aah,000h,000h,00ah,0a0h,099h,099h,000h,000h,000h,000h,000h,099h,0ddh,0dch,000h,099h,0ddh,0dch,000h	; af40  ................................
	defb 000h,099h,09dh,000h,00ah,0afh,0ffh,000h,0ddh,0dch,0dch,000h,099h,09dh,09dh,000h,000h,000h,000h,000h,000h,000h,000h,0cch,0cch,0cch,0cdh,0eeh,0ech,0cch,0cdh,0cch	; af60  ................................
	defb 0cdh,0ddh,0d9h,0bbh,0bbh,0ffh,0fah,0eeh,0ech,0cch,0cdh,0cch,0cdh,0ddh,0d9h,000h,000h,000h,000h,000h,000h,000h,000h,0cdh,0ddh,09dh,099h,0cdh,0ddh,09dh,099h,0d9h	; af80  ................................
	defb 099h,009h,000h,0ffh,0ffh,0afh,0aah,0cdh,0ddh,09dh,099h,0d9h,099h,009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,090h,009h,090h,000h,090h,009h,090h,000h,000h	; afa0  ................................
	defb 000h,000h,000h,0aah,0a0h,000h,000h,090h,000h,099h,090h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ddh,0d0h,00dh,0ddh,000h,00ah,009h,090h,00dh,000h,000h	; afc0  ................................
	defb 00dh,0d0h,099h,0d0h,000h,099h,090h,099h,090h,000h,000h,090h,000h,0aah,0a0h,000h,0ddh,000h,000h,0ffh,0ffh,0ffh,0f0h,0ffh,0ffh,0f0h,00dh,0ffh,0f0h,00dh,0d0h,0f0h	; afe0  ................................
	defb 00dh,0d9h,099h,000h,0d9h,099h,000h,000h,000h,000h,000h,00ah,000h,000h,0ddh,000h,0aah,000h,000h,000h,000h,0ddh,0d0h,0aah,0aah,000h,00dh,0aah,000h,00dh,0d9h,000h	; b000  ................................
	defb 00dh,000h,000h,0ddh,0d9h,099h,090h,0d9h,099h,000h,000h,000h,000h,099h,000h,000h,0ddh,000h,000h,000h,00ah,0aah,000h,0ddh,0d0h,000h,000h,0d9h,099h,000h,0d0h,090h	; b020  ................................
	defb 000h,009h,099h,000h,009h,099h,000h,00dh,0d0h,000h,000h,000h,099h,000h,0aah,000h,000h,000h,000h,000h,000h,0ddh,0ddh,000h,000h,009h,090h,0ddh,000h,0d0h,000h,000h	; b040  ................................
	defb 0d0h,00dh,0d0h,000h,000h,000h,000h,0a0h,00ah,0aah,00dh,0aah,0aah,0aah,00dh,0a0h,000h,000h,000h,000h,000h,0ddh,0ddh,000h,000h,009h,090h,0ddh,000h,0d0h,000h,000h	; b060  ................................
	defb 0d0h,00dh,0d0h,000h,000h,000h,000h,0a0h,000h,0a0h,090h,0aah,0aah,009h,099h,0aah,0aah,000h,000h,099h,000h,0aah,0a0h,000h,0aah,000h,0aah,0aah,0a0h,0ddh,000h,000h	; b080  ................................
	defb 00dh,099h,099h,000h,0ddh,099h,000h,000h,000h,000h,000h,090h,000h,000h,0ddh,000h,0aah,000h,000h,000h,0d0h,0ddh,0ddh,009h,09dh,09dh,090h,000h,000h,000h,000h,099h	; b0a0  ................................
	defb 00dh,0ddh,099h,090h,000h,000h,009h,000h,000h,0aah,000h,0ddh,090h,0aah,0aah,099h,099h,00ah,0aah,000h,000h,0ddh,0ddh,000h,000h,009h,090h,099h,000h,0d0h,000h,000h	; b0c0  ................................
	defb 0d0h,00dh,0d0h,000h,000h,000h,000h,000h,00dh,0d9h,090h,0a0h,099h,099h,00ah,0aah,000h,000h,0aah,000h,000h,0ddh,0d0h,00dh,0ddh,000h,009h,0d9h,090h,00dh,0ddh,000h	; b0e0  ................................
	defb 00dh,0d0h,0d9h,000h,000h,000h,090h,099h,099h,000h,00ah,090h,000h,099h,000h,000h,0ddh,000h,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,09dh,000h,0f0h,00fh,090h	; b100  ................................
	defb 0d0h,009h,090h,000h,000h,000h,000h,000h,009h,099h,000h,0a0h,099h,000h,00ah,000h,000h,0aah,0aah,0ffh,0ffh,0ffh,0f0h,0ffh,0ffh,0f0h,00dh,0ffh,0f0h,00dh,0d0h,0f0h	; b120  ................................
	defb 00dh,090h,009h,000h,0d9h,099h,000h,000h,000h,000h,000h,0aah,000h,000h,0ddh,000h,0aah,000h,000h,099h,000h,0aah,0a0h,000h,0aah,0a0h,000h,0aah,0a0h,00dh,0d0h,000h	; b140  ................................
	defb 00dh,0d9h,099h,000h,0d9h,099h,000h,000h,000h,000h,000h,0aah,000h,000h,0ddh,0aah,0aah,000h,000h,00dh,0d0h,0ddh,0d9h,0d0h,000h,099h,090h,000h,000h,000h,0ddh,099h	; b160  ................................
	defb 00dh,0d9h,09dh,099h,0d9h,090h,000h,000h,000h,009h,099h,0ddh,090h,009h,000h,099h,099h,000h,0aah,000h,000h,0aah,0a0h,000h,0aah,0a0h,00dh,0aah,0a0h,00dh,0d0h,000h	; b180  ................................
	defb 00dh,0ddh,099h,000h,0d9h,099h,000h,000h,000h,000h,000h,0aah,000h,000h,0ddh,0aah,0aah,000h,000h,000h,000h,0ddh,0ddh,000h,000h,009h,090h,099h,000h,0d0h,000h,000h	; b1a0  ................................
	defb 0d0h,00dh,0d0h,000h,000h,000h,000h,000h,000h,0aah,0aah,0aah,0aah,0aah,0aah,0aah,0aah,0aah,0aah,000h,00ah,0aah,0aah,0ddh,0d0h,000h,000h,099h,0ddh,0d9h,090h,0d0h	; b1c0  ................................
	defb 099h,09dh,0d9h,000h,099h,099h,000h,000h,000h,000h,000h,000h,000h,000h,0aah,000h,000h,000h,000h,000h,000h,0ddh,0ddh,000h,000h,009h,090h,0ddh,000h,0d0h,000h,000h	; b1e0  ................................
	defb 0d0h,00dh,0d0h,000h,000h,000h,000h,0a0h,000h,0a0h,00dh,0aah,0aah,000h,00dh,0aah,0aah,000h,000h,099h,000h,0aah,0a0h,000h,0aah,0a0h,00dh,0aah,0a0h,00dh,090h,000h	; b200  ................................
	defb 00dh,0ddh,099h,000h,0ddh,0d9h,000h,0d0h,000h,000h,000h,0ddh,000h,000h,0ddh,000h,00ah,000h,000h,000h,000h,0ddh,0d0h,00dh,0ddh,000h,00dh,0ddh,0d0h,00dh,0ddh,000h	; b220  ................................
	defb 00dh,0d0h,0ddh,0ddh,0ddh,0ddh,0d0h,0ddh,0d9h,099h,090h,090h,000h,099h,000h,000h,09dh,000h,000h,000h,00ah,0aah,000h,0ddh,0d0h,000h,000h,0ddh,0ddh,0d9h,090h,0d0h	; b240  ................................
	defb 0ddh,0ddh,0d9h,000h,099h,099h,000h,000h,000h,000h,000h,00ah,0aah,0aah,0aah,000h,0aah,000h,000h,00ch,0c0h,0ddh,0ddh,0cdh,0ddh,09dh,090h,0ddh,090h,000h,0ddh,099h	; b260  ................................
	defb 00ch,0cch,0ddh,099h,0cdh,0ddh,0d9h,000h,0ddh,0ddh,099h,0ddh,0ddh,099h,000h,09dh,099h,000h,00ah,099h,000h,0aah,0a0h,000h,0aah,0a0h,00dh,0aah,0a0h,00dh,0d0h,000h	; b280  ................................
	defb 00dh,0ddh,0ddh,000h,0ddh,0d9h,000h,000h,000h,000h,000h,0aah,000h,000h,0ddh,0aah,0aah,000h,000h,099h,000h,0aah,0a0h,000h,0aah,0a0h,00ch,0aah,0a0h,00ch,0c0h,000h	; b2a0  ................................
	defb 00ch,0cdh,0ddh,000h,0ddh,0d9h,000h,000h,000h,000h,000h,0aah,000h,000h,0ddh,0aah,0aah,000h,000h,000h,00ah,0aah,000h,0cch,0d0h,000h,000h,0ddh,0ddh,0cch,0c0h,090h	; b2c0  ................................
	defb 0ddh,0ddh,0ddh,000h,099h,099h,000h,000h,000h,000h,000h,000h,000h,000h,0aah,000h,000h,000h,000h,000h,000h,0ddh,0d0h,00dh,0ddh,000h,00ch,0ddh,0d0h,00ch,0cdh,000h	; b2e0  ................................
	defb 00ch,0c0h,0ddh,0cch,0cdh,0ddh,0d0h,0ddh,0d9h,099h,090h,090h,000h,099h,000h,000h,09dh,000h,000h,000h,0ddh,0ddh,0cch,009h,000h,0cdh,0cch,009h,090h,00ch,0cch,009h	; b300  ................................
	defb 09dh,000h,0ech,009h,09dh,000h,00eh,009h,09dh,0d0h,000h,009h,09dh,0ddh,000h,009h,09dh,0ddh,0e0h,0eeh,0ceh,0eeh,00ch,0eeh,0ceh,000h,0dch,0eeh,0e0h,00ch,0dch,0eeh	; b320  ................................
	defb 000h,0cch,0dch,0e0h,000h,0cch,0dch,000h,00eh,0c9h,0dch,000h,0ceh,0cch,0dch,00eh,0eeh,0cch,0dch,0d0h,0cdh,09dh,099h,0ddh,00ch,09dh,099h,0ddh,0d0h,0ddh,099h,0ddh	; b340  ................................
	defb 0ddh,00ch,099h,0ddh,0ddh,000h,0d9h,0ddh,09dh,090h,00dh,0ddh,0d9h,00dh,000h,0d9h,0ddh,09ch,0d0h,099h,000h,090h,090h,099h,009h,000h,090h,099h,090h,000h,090h,09dh	; b360  ................................
	defb 000h,000h,090h,0d0h,009h,000h,090h,000h,009h,000h,090h,000h,009h,000h,090h,00dh,009h,000h,090h,009h,09dh,0dch,00ch,009h,09dh,0c0h,0cch,009h,09ch,00dh,0cch,009h	; b380  ................................
	defb 0d0h,0ddh,0cch,00dh,000h,0ddh,0cch,000h,00dh,0ddh,0cch,000h,00dh,0ddh,0cch,009h,09dh,0ddh,0cch,0d0h,00eh,0cch,0dch,0cdh,000h,0ech,0dch,0cch,0d0h,00eh,0dch,0ech	; b3a0  ................................
	defb 0ddh,000h,0cch,0eeh,0cdh,000h,00eh,0edh,09ch,0d0h,000h,0eeh,0ceh,0cdh,000h,0deh,0ceh,0cch,0d0h,0ddh,0ddh,0d0h,009h,0ddh,0dch,000h,099h,0ddh,0c0h,00dh,099h,0dch	; b3c0  ................................
	defb 000h,09dh,099h,0c0h,000h,09dh,099h,000h,009h,09dh,099h,000h,09dh,09dh,099h,00dh,0ddh,09dh,099h,090h,009h,000h,090h,000h,00dh,000h,090h,000h,000h,090h,090h,099h	; b3e0  ................................
	defb 000h,009h,090h,099h,009h,000h,0d0h,090h,009h,000h,000h,099h,009h,000h,000h,009h,009h,009h,000h,000h,00fh,0ffh,0ffh,000h,000h,00fh,0ffh,009h,000h,000h,0ffh,090h	; b400  ................................
	defb 000h,000h,00fh,0d9h,0d0h,000h,00fh,0ddh,0d0h,000h,000h,0ddh,090h,000h,000h,0ddh,0d9h,0d0h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h	; b420  ................................
	defb 0ffh,0ffh,0ffh,000h,00fh,0ffh,0ffh,000h,00fh,0ffh,0ffh,000h,000h,0ffh,0ffh,000h,000h,00fh,0ffh,000h,000h,000h,00fh,000h,000h,000h,000h,009h,000h,000h,000h,090h	; b440  ................................
	defb 000h,000h,000h,0e9h,0d0h,000h,000h,0eeh,0d0h,000h,000h,0eeh,090h,000h,000h,0eeh,0d9h,0d0h,000h	; b460  ...................

; ----------------------------------------------------------------------
; DATOS sprites_de_cada_tipo: 168 punteros, uno por tipo de cosa, a como se
;   compone con sprites; lo leen p01:645B (336 bytes)
;   0xb473..0xb5c3  (336 bytes)
DATA_sprites_de_cada_tipo:
	defb 0c3h,0b5h	; b473
	defb 0c9h,0b5h	; b475
	defb 0cch,0b5h	; b477
	defb 0cfh,0b5h	; b479
	defb 0d5h,0b5h	; b47b
	defb 0dah,0b5h	; b47d
	defb 0dfh,0b5h	; b47f
	defb 0e4h,0b5h	; b481
	defb 0e9h,0b5h	; b483
	defb 0eeh,0b5h	; b485
	defb 0f3h,0b5h	; b487
	defb 0f8h,0b5h	; b489
	defb 0fdh,0b5h	; b48b
	defb 002h,0b6h	; b48d
	defb 007h,0b6h	; b48f
	defb 00ah,0b6h	; b491
	defb 00fh,0b6h	; b493
	defb 014h,0b6h	; b495
	defb 019h,0b6h	; b497
	defb 01eh,0b6h	; b499
	defb 023h,0b6h	; b49b
	defb 028h,0b6h	; b49d
	defb 02bh,0b6h	; b49f
	defb 02eh,0b6h	; b4a1
	defb 031h,0b6h	; b4a3
	defb 034h,0b6h	; b4a5
	defb 037h,0b6h	; b4a7
	defb 03ah,0b6h	; b4a9
	defb 03dh,0b6h	; b4ab
	defb 040h,0b6h	; b4ad
	defb 043h,0b6h	; b4af
	defb 046h,0b6h	; b4b1
	defb 049h,0b6h	; b4b3
	defb 04ch,0b6h	; b4b5
	defb 051h,0b6h	; b4b7
	defb 056h,0b6h	; b4b9
	defb 05bh,0b6h	; b4bb
	defb 060h,0b6h	; b4bd
	defb 063h,0b6h	; b4bf
	defb 066h,0b6h	; b4c1
	defb 069h,0b6h	; b4c3
	defb 06ch,0b6h	; b4c5
	defb 06fh,0b6h	; b4c7
	defb 072h,0b6h	; b4c9
	defb 08ah,0b6h	; b4cb
	defb 0a2h,0b6h	; b4cd
	defb 0a5h,0b6h	; b4cf
	defb 0a8h,0b6h	; b4d1
	defb 0abh,0b6h	; b4d3
	defb 0aeh,0b6h	; b4d5
	defb 0b1h,0b6h	; b4d7
	defb 0b4h,0b6h	; b4d9
	defb 0bbh,0b6h	; b4db
	defb 0c2h,0b6h	; b4dd
	defb 0c9h,0b6h	; b4df
	defb 0d0h,0b6h	; b4e1
	defb 0d7h,0b6h	; b4e3
	defb 0deh,0b6h	; b4e5
	defb 0e1h,0b6h	; b4e7
	defb 0e4h,0b6h	; b4e9
	defb 0e9h,0b6h	; b4eb
	defb 0eeh,0b6h	; b4ed
	defb 0f3h,0b6h	; b4ef
	defb 0f8h,0b6h	; b4f1
	defb 004h,0b7h	; b4f3
	defb 010h,0b7h	; b4f5
	defb 01ch,0b7h	; b4f7
	defb 028h,0b7h	; b4f9
	defb 034h,0b7h	; b4fb
	defb 040h,0b7h	; b4fd
	defb 04ch,0b7h	; b4ff
	defb 058h,0b7h	; b501
	defb 05dh,0b7h	; b503
	defb 062h,0b7h	; b505
	defb 067h,0b7h	; b507
	defb 06ch,0b7h	; b509
	defb 072h,0b7h	; b50b
	defb 075h,0b7h	; b50d
	defb 078h,0b7h	; b50f
	defb 090h,0b7h	; b511
	defb 0a8h,0b7h	; b513
	defb 0adh,0b7h	; b515
	defb 0b2h,0b7h	; b517
	defb 0b7h,0b7h	; b519
	defb 0bch,0b7h	; b51b
	defb 0c1h,0b7h	; b51d
	defb 0c6h,0b7h	; b51f
	defb 0c9h,0b7h	; b521
	defb 0cch,0b7h	; b523
	defb 0cfh,0b7h	; b525
	defb 0d2h,0b7h	; b527
	defb 0d5h,0b7h	; b529
	defb 0edh,0b7h	; b52b
	defb 005h,0b8h	; b52d
	defb 01dh,0b8h	; b52f
	defb 035h,0b8h	; b531
	defb 03ah,0b8h	; b533
	defb 03fh,0b8h	; b535
	defb 044h,0b8h	; b537
	defb 049h,0b8h	; b539
	defb 04ch,0b8h	; b53b
	defb 04fh,0b8h	; b53d
	defb 052h,0b8h	; b53f
	defb 055h,0b8h	; b541
	defb 058h,0b8h	; b543
	defb 05bh,0b8h	; b545
	defb 05eh,0b8h	; b547
	defb 061h,0b8h	; b549
	defb 064h,0b8h	; b54b
	defb 067h,0b8h	; b54d
	defb 079h,0b8h	; b54f
	defb 08bh,0b8h	; b551
	defb 08bh,0b8h	; b553
	defb 08bh,0b8h	; b555
	defb 08eh,0b8h	; b557
	defb 091h,0b8h	; b559
	defb 094h,0b8h	; b55b
	defb 097h,0b8h	; b55d
	defb 09ah,0b8h	; b55f
	defb 09dh,0b8h	; b561
	defb 0a0h,0b8h	; b563
	defb 0a3h,0b8h	; b565
	defb 0b5h,0b8h	; b567
	defb 0c7h,0b8h	; b569
	defb 0d9h,0b8h	; b56b
	defb 0fdh,0b8h	; b56d
	defb 000h,0b9h	; b56f
	defb 003h,0b9h	; b571
	defb 006h,0b9h	; b573
	defb 009h,0b9h	; b575
	defb 009h,0b9h	; b577
	defb 009h,0b9h	; b579
	defb 009h,0b9h	; b57b
	defb 009h,0b9h	; b57d
	defb 00fh,0b9h	; b57f
	defb 012h,0b9h	; b581
	defb 015h,0b9h	; b583
	defb 018h,0b9h	; b585
	defb 01bh,0b9h	; b587
	defb 01eh,0b9h	; b589
	defb 021h,0b9h	; b58b
	defb 024h,0b9h	; b58d
	defb 036h,0b9h	; b58f
	defb 048h,0b9h	; b591
	defb 054h,0b9h	; b593
	defb 063h,0b9h	; b595
	defb 06fh,0b9h	; b597
	defb 072h,0b9h	; b599
	defb 075h,0b9h	; b59b
	defb 08dh,0b9h	; b59d
	defb 08dh,0b9h	; b59f
	defb 08dh,0b9h	; b5a1
	defb 092h,0b9h	; b5a3
	defb 097h,0b9h	; b5a5
	defb 09ch,0b9h	; b5a7
	defb 0a1h,0b9h	; b5a9
	defb 0a4h,0b9h	; b5ab
	defb 0a7h,0b9h	; b5ad
	defb 0aah,0b9h	; b5af
	defb 0adh,0b9h	; b5b1
	defb 0b0h,0b9h	; b5b3
	defb 0b3h,0b9h	; b5b5
	defb 0b6h,0b9h	; b5b7
	defb 0b9h,0b9h	; b5b9
	defb 0bch,0b9h	; b5bb
	defb 0bfh,0b9h	; b5bd
	defb 0c2h,0b9h	; b5bf
	defb 0c5h,0b9h	; b5c1

; ----------------------------------------------------------------------
; DATOS sprites_B5C3: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (6 bytes)
;   0xb5c3..0xb5c9  (6 bytes)
DATA_sprites_B5C3:
	defb 0f8h,0fch,0e8h	; b5c3
	defb 0f8h,0fch,0e8h	; b5c6

; ----------------------------------------------------------------------
; DATOS sprites_B5C9: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb5c9..0xb5cc  (3 bytes)
DATA_sprites_B5C9:
	defb 081h,0ech,0ech	; b5c9

; ----------------------------------------------------------------------
; DATOS sprites_B5CC: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb5cc..0xb5cf  (3 bytes)
DATA_sprites_B5CC:
	defb 081h,078h,07ch	; b5cc

; ----------------------------------------------------------------------
; DATOS sprites_B5CF: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (6 bytes)
;   0xb5cf..0xb5d5  (6 bytes)
DATA_sprites_B5CF:
	defb 0f4h,0f8h,0f0h	; b5cf
	defb 0f4h,0f8h,0f0h	; b5d2

; ----------------------------------------------------------------------
; DATOS sprites_B5D5: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5d5..0xb5da  (5 bytes)
DATA_sprites_B5D5:
	defb 080h,0c0h,0c4h	; b5d5
	defb 0c8h,0cch	; b5d8

; ----------------------------------------------------------------------
; DATOS sprites_B5DA: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5da..0xb5df  (5 bytes)
DATA_sprites_B5DA:
	defb 080h,0c8h,0cch	; b5da
	defb 0c0h,0c4h	; b5dd

; ----------------------------------------------------------------------
; DATOS sprites_B5DF: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5df..0xb5e4  (5 bytes)
DATA_sprites_B5DF:
	defb 080h,0c8h,0cch	; b5df
	defb 0d0h,0d4h	; b5e2

; ----------------------------------------------------------------------
; DATOS sprites_B5E4: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5e4..0xb5e9  (5 bytes)
DATA_sprites_B5E4:
	defb 080h,0d0h,0d4h	; b5e4
	defb 0c8h,0cch	; b5e7

; ----------------------------------------------------------------------
; DATOS sprites_B5E9: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5e9..0xb5ee  (5 bytes)
DATA_sprites_B5E9:
	defb 080h,040h,044h	; b5e9
	defb 048h,04ch	; b5ec

; ----------------------------------------------------------------------
; DATOS sprites_B5EE: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5ee..0xb5f3  (5 bytes)
DATA_sprites_B5EE:
	defb 080h,040h,044h	; b5ee
	defb 050h,054h	; b5f1

; ----------------------------------------------------------------------
; DATOS sprites_B5F3: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5f3..0xb5f8  (5 bytes)
DATA_sprites_B5F3:
	defb 080h,058h,05ch	; b5f3
	defb 060h,064h	; b5f6

; ----------------------------------------------------------------------
; DATOS sprites_B5F8: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5f8..0xb5fd  (5 bytes)
DATA_sprites_B5F8:
	defb 080h,068h,06ch	; b5f8
	defb 070h,074h	; b5fb

; ----------------------------------------------------------------------
; DATOS sprites_B5FD: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb5fd..0xb602  (5 bytes)
DATA_sprites_B5FD:
	defb 080h,068h,06ch	; b5fd
	defb 078h,07ch	; b600

; ----------------------------------------------------------------------
; DATOS sprites_B602: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb602..0xb607  (5 bytes)
DATA_sprites_B602:
	defb 080h,080h,084h	; b602
	defb 088h,08ch	; b605

; ----------------------------------------------------------------------
; DATOS sprites_B607: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb607..0xb60a  (3 bytes)
DATA_sprites_B607:
	defb 0f1h,0f8h,090h	; b607

; ----------------------------------------------------------------------
; DATOS sprites_B60A: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb60a..0xb60f  (5 bytes)
DATA_sprites_B60A:
	defb 080h,080h,084h	; b60a
	defb 088h,08ch	; b60d

; ----------------------------------------------------------------------
; DATOS sprites_B60F: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb60f..0xb614  (5 bytes)
DATA_sprites_B60F:
	defb 080h,080h,084h	; b60f
	defb 090h,094h	; b612

; ----------------------------------------------------------------------
; DATOS sprites_B614: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb614..0xb619  (5 bytes)
DATA_sprites_B614:
	defb 080h,098h,09ch	; b614
	defb 0a0h,0a4h	; b617

; ----------------------------------------------------------------------
; DATOS sprites_B619: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb619..0xb61e  (5 bytes)
DATA_sprites_B619:
	defb 080h,0a8h,0ach	; b619
	defb 0b0h,0b4h	; b61c

; ----------------------------------------------------------------------
; DATOS sprites_B61E: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb61e..0xb623  (5 bytes)
DATA_sprites_B61E:
	defb 080h,0a8h,0ach	; b61e
	defb 0b8h,0bch	; b621

; ----------------------------------------------------------------------
; DATOS sprites_B623: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb623..0xb628  (5 bytes)
DATA_sprites_B623:
	defb 080h,0c0h,0c4h	; b623
	defb 0c8h,0cch	; b626

; ----------------------------------------------------------------------
; DATOS sprites_B628: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb628..0xb62b  (3 bytes)
DATA_sprites_B628:
	defb 0f1h,0f8h,0d0h	; b628

; ----------------------------------------------------------------------
; DATOS sprites_B62B: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb62b..0xb62e  (3 bytes)
DATA_sprites_B62B:
	defb 081h,0a0h,0a4h	; b62b

; ----------------------------------------------------------------------
; DATOS sprites_B62E: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb62e..0xb631  (3 bytes)
DATA_sprites_B62E:
	defb 081h,0a8h,0ach	; b62e

; ----------------------------------------------------------------------
; DATOS sprites_B631: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb631..0xb634  (3 bytes)
DATA_sprites_B631:
	defb 081h,0b0h,0b4h	; b631

; ----------------------------------------------------------------------
; DATOS sprites_B634: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb634..0xb637  (3 bytes)
DATA_sprites_B634:
	defb 081h,0b8h,0bch	; b634

; ----------------------------------------------------------------------
; DATOS sprites_B637: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb637..0xb63a  (3 bytes)
DATA_sprites_B637:
	defb 081h,040h,044h	; b637

; ----------------------------------------------------------------------
; DATOS sprites_B63A: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb63a..0xb63d  (3 bytes)
DATA_sprites_B63A:
	defb 081h,048h,04ch	; b63a

; ----------------------------------------------------------------------
; DATOS sprites_B63D: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb63d..0xb640  (3 bytes)
DATA_sprites_B63D:
	defb 081h,050h,054h	; b63d

; ----------------------------------------------------------------------
; DATOS sprites_B640: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb640..0xb643  (3 bytes)
DATA_sprites_B640:
	defb 081h,058h,05ch	; b640

; ----------------------------------------------------------------------
; DATOS sprites_B643: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb643..0xb646  (3 bytes)
DATA_sprites_B643:
	defb 081h,060h,064h	; b643

; ----------------------------------------------------------------------
; DATOS sprites_B646: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb646..0xb649  (3 bytes)
DATA_sprites_B646:
	defb 081h,068h,06ch	; b646

; ----------------------------------------------------------------------
; DATOS sprites_B649: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb649..0xb64c  (3 bytes)
DATA_sprites_B649:
	defb 081h,070h,074h	; b649

; ----------------------------------------------------------------------
; DATOS sprites_B64C: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb64c..0xb651  (5 bytes)
DATA_sprites_B64C:
	defb 080h,040h,044h	; b64c
	defb 048h,04ch	; b64f

; ----------------------------------------------------------------------
; DATOS sprites_B651: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb651..0xb656  (5 bytes)
DATA_sprites_B651:
	defb 080h,050h,054h	; b651
	defb 058h,05ch	; b654

; ----------------------------------------------------------------------
; DATOS sprites_B656: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb656..0xb65b  (5 bytes)
DATA_sprites_B656:
	defb 080h,060h,064h	; b656
	defb 068h,06ch	; b659

; ----------------------------------------------------------------------
; DATOS sprites_B65B: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb65b..0xb660  (5 bytes)
DATA_sprites_B65B:
	defb 080h,070h,074h	; b65b
	defb 078h,07ch	; b65e

; ----------------------------------------------------------------------
; DATOS sprites_B660: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb660..0xb663  (3 bytes)
DATA_sprites_B660:
	defb 081h,080h,084h	; b660

; ----------------------------------------------------------------------
; DATOS sprites_B663: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb663..0xb666  (3 bytes)
DATA_sprites_B663:
	defb 081h,088h,08ch	; b663

; ----------------------------------------------------------------------
; DATOS sprites_B666: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb666..0xb669  (3 bytes)
DATA_sprites_B666:
	defb 081h,080h,084h	; b666

; ----------------------------------------------------------------------
; DATOS sprites_B669: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb669..0xb66c  (3 bytes)
DATA_sprites_B669:
	defb 081h,088h,08ch	; b669

; ----------------------------------------------------------------------
; DATOS sprites_B66C: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb66c..0xb66f  (3 bytes)
DATA_sprites_B66C:
	defb 081h,090h,094h	; b66c

; ----------------------------------------------------------------------
; DATOS sprites_B66F: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb66f..0xb672  (3 bytes)
DATA_sprites_B66F:
	defb 081h,098h,09ch	; b66f

; ----------------------------------------------------------------------
; DATOS sprites_B672: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb672..0xb68a  (24 bytes)
DATA_sprites_B672:
	defb 0e1h,0f0h,040h	; b672
	defb 0e1h,0f0h,044h	; b675
	defb 0e1h,000h,048h	; b678
	defb 0e1h,000h,04ch	; b67b
	defb 0f1h,0f0h,050h	; b67e
	defb 0f1h,0f0h,054h	; b681
	defb 0f1h,000h,058h	; b684
	defb 0f1h,000h,05ch	; b687

; ----------------------------------------------------------------------
; DATOS sprites_B68A: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb68a..0xb6a2  (24 bytes)
DATA_sprites_B68A:
	defb 0e1h,0f0h,060h	; b68a
	defb 0e1h,0f0h,064h	; b68d
	defb 0e1h,000h,068h	; b690
	defb 0e1h,000h,06ch	; b693
	defb 0f1h,0f0h,070h	; b696
	defb 0f1h,0f0h,074h	; b699
	defb 0f1h,000h,078h	; b69c
	defb 0f1h,000h,07ch	; b69f

; ----------------------------------------------------------------------
; DATOS sprites_B6A2: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb6a2..0xb6a5  (3 bytes)
DATA_sprites_B6A2:
	defb 081h,0b0h,0b4h	; b6a2

; ----------------------------------------------------------------------
; DATOS sprites_B6A5: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb6a5..0xb6a8  (3 bytes)
DATA_sprites_B6A5:
	defb 081h,0a8h,0ach	; b6a5

; ----------------------------------------------------------------------
; DATOS sprites_B6A8: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb6a8..0xb6ab  (3 bytes)
DATA_sprites_B6A8:
	defb 081h,0b8h,0bch	; b6a8

; ----------------------------------------------------------------------
; DATOS sprites_B6AB: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb6ab..0xb6ae  (3 bytes)
DATA_sprites_B6AB:
	defb 081h,0c8h,0cch	; b6ab

; ----------------------------------------------------------------------
; DATOS sprites_B6AE: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb6ae..0xb6b1  (3 bytes)
DATA_sprites_B6AE:
	defb 081h,0c0h,0c4h	; b6ae

; ----------------------------------------------------------------------
; DATOS sprites_B6B1: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb6b1..0xb6b4  (3 bytes)
DATA_sprites_B6B1:
	defb 081h,0d0h,0d4h	; b6b1

; ----------------------------------------------------------------------
; DATOS sprites_B6B4: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (7 bytes)
;   0xb6b4..0xb6bb  (7 bytes)
DATA_sprites_B6B4:
	defb 082h,040h,044h	; b6b4
	defb 048h,04ch,050h	; b6b7
	defb 054h	; b6ba

; ----------------------------------------------------------------------
; DATOS sprites_B6BB: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (7 bytes)
;   0xb6bb..0xb6c2  (7 bytes)
DATA_sprites_B6BB:
	defb 082h,058h,05ch	; b6bb
	defb 060h,064h,068h	; b6be
	defb 06ch	; b6c1

; ----------------------------------------------------------------------
; DATOS sprites_B6C2: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (7 bytes)
;   0xb6c2..0xb6c9  (7 bytes)
DATA_sprites_B6C2:
	defb 082h,040h,044h	; b6c2
	defb 070h,074h,078h	; b6c5
	defb 07ch	; b6c8

; ----------------------------------------------------------------------
; DATOS sprites_B6C9: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (7 bytes)
;   0xb6c9..0xb6d0  (7 bytes)
DATA_sprites_B6C9:
	defb 082h,090h,094h	; b6c9
	defb 098h,09ch,0a0h	; b6cc
	defb 0a4h	; b6cf

; ----------------------------------------------------------------------
; DATOS sprites_B6D0: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (7 bytes)
;   0xb6d0..0xb6d7  (7 bytes)
DATA_sprites_B6D0:
	defb 082h,0a8h,0ach	; b6d0
	defb 0b0h,0b4h,0b8h	; b6d3
	defb 0bch	; b6d6

; ----------------------------------------------------------------------
; DATOS sprites_B6D7: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (7 bytes)
;   0xb6d7..0xb6de  (7 bytes)
DATA_sprites_B6D7:
	defb 082h,090h,094h	; b6d7
	defb 0c0h,0c4h,0c8h	; b6da
	defb 0cch	; b6dd

; ----------------------------------------------------------------------
; DATOS sprites_B6DE: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb6de..0xb6e1  (3 bytes)
DATA_sprites_B6DE:
	defb 081h,080h,084h	; b6de

; ----------------------------------------------------------------------
; DATOS sprites_B6E1: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb6e1..0xb6e4  (3 bytes)
DATA_sprites_B6E1:
	defb 081h,088h,08ch	; b6e1

; ----------------------------------------------------------------------
; DATOS sprites_B6E4: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb6e4..0xb6e9  (5 bytes)
DATA_sprites_B6E4:
	defb 080h,040h,044h	; b6e4
	defb 048h,04ch	; b6e7

; ----------------------------------------------------------------------
; DATOS sprites_B6E9: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb6e9..0xb6ee  (5 bytes)
DATA_sprites_B6E9:
	defb 080h,040h,044h	; b6e9
	defb 050h,054h	; b6ec

; ----------------------------------------------------------------------
; DATOS sprites_B6EE: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb6ee..0xb6f3  (5 bytes)
DATA_sprites_B6EE:
	defb 080h,058h,05ch	; b6ee
	defb 060h,064h	; b6f1

; ----------------------------------------------------------------------
; DATOS sprites_B6F3: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb6f3..0xb6f8  (5 bytes)
DATA_sprites_B6F3:
	defb 080h,058h,05ch	; b6f3
	defb 068h,06ch	; b6f6

; ----------------------------------------------------------------------
; DATOS sprites_B6F8: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb6f8..0xb704  (12 bytes)
DATA_sprites_B6F8:
	defb 0f0h,0f7h,040h	; b6f8
	defb 0f0h,0f7h,044h	; b6fb
	defb 0f0h,007h,048h	; b6fe
	defb 0f0h,007h,04ch	; b701

; ----------------------------------------------------------------------
; DATOS sprites_B704: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb704..0xb710  (12 bytes)
DATA_sprites_B704:
	defb 0f0h,0f0h,050h	; b704
	defb 0f0h,0f0h,054h	; b707
	defb 0f0h,000h,058h	; b70a
	defb 0f0h,000h,05ch	; b70d

; ----------------------------------------------------------------------
; DATOS sprites_B710: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb710..0xb71c  (12 bytes)
DATA_sprites_B710:
	defb 0f0h,0f0h,060h	; b710
	defb 0f0h,0f0h,064h	; b713
	defb 0f0h,000h,068h	; b716
	defb 0f0h,000h,06ch	; b719

; ----------------------------------------------------------------------
; DATOS sprites_B71C: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb71c..0xb728  (12 bytes)
DATA_sprites_B71C:
	defb 0f0h,0f0h,070h	; b71c
	defb 0f0h,0f0h,074h	; b71f
	defb 0f0h,000h,078h	; b722
	defb 0f0h,000h,07ch	; b725

; ----------------------------------------------------------------------
; DATOS sprites_B728: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb728..0xb734  (12 bytes)
DATA_sprites_B728:
	defb 0f0h,0e9h,088h	; b728
	defb 0f0h,0e9h,08ch	; b72b
	defb 0f0h,0f9h,080h	; b72e
	defb 0f0h,0f9h,084h	; b731

; ----------------------------------------------------------------------
; DATOS sprites_B734: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb734..0xb740  (12 bytes)
DATA_sprites_B734:
	defb 0f0h,0f0h,098h	; b734
	defb 0f0h,0f0h,09ch	; b737
	defb 0f0h,000h,090h	; b73a
	defb 0f0h,000h,094h	; b73d

; ----------------------------------------------------------------------
; DATOS sprites_B740: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb740..0xb74c  (12 bytes)
DATA_sprites_B740:
	defb 0f0h,0f0h,0a8h	; b740
	defb 0f0h,0f0h,0ach	; b743
	defb 0f0h,000h,0a0h	; b746
	defb 0f0h,000h,0a4h	; b749

; ----------------------------------------------------------------------
; DATOS sprites_B74C: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb74c..0xb758  (12 bytes)
DATA_sprites_B74C:
	defb 0f0h,0f0h,0b8h	; b74c
	defb 0f0h,0f0h,0bch	; b74f
	defb 0f0h,000h,0b0h	; b752
	defb 0f0h,000h,0b4h	; b755

; ----------------------------------------------------------------------
; DATOS sprites_B758: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb758..0xb75d  (5 bytes)
DATA_sprites_B758:
	defb 080h,040h,044h	; b758
	defb 048h,04ch	; b75b

; ----------------------------------------------------------------------
; DATOS sprites_B75D: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb75d..0xb762  (5 bytes)
DATA_sprites_B75D:
	defb 080h,050h,054h	; b75d
	defb 058h,05ch	; b760

; ----------------------------------------------------------------------
; DATOS sprites_B762: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb762..0xb767  (5 bytes)
DATA_sprites_B762:
	defb 080h,060h,064h	; b762
	defb 068h,06ch	; b765

; ----------------------------------------------------------------------
; DATOS sprites_B767: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb767..0xb76c  (5 bytes)
DATA_sprites_B767:
	defb 080h,070h,074h	; b767
	defb 078h,07ch	; b76a

; ----------------------------------------------------------------------
; DATOS sprites_B76C: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (6 bytes)
;   0xb76c..0xb772  (6 bytes)
DATA_sprites_B76C:
	defb 0f1h,0fch,090h	; b76c
	defb 0f1h,0fch,094h	; b76f

; ----------------------------------------------------------------------
; DATOS sprites_B772: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb772..0xb775  (3 bytes)
DATA_sprites_B772:
	defb 081h,098h,09ch	; b772

; ----------------------------------------------------------------------
; DATOS sprites_B775: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb775..0xb778  (3 bytes)
DATA_sprites_B775:
	defb 081h,0a0h,0a4h	; b775

; ----------------------------------------------------------------------
; DATOS sprites_B778: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb778..0xb790  (24 bytes)
DATA_sprites_B778:
	defb 0ebh,0e8h,040h	; b778
	defb 0ebh,0e8h,044h	; b77b
	defb 0ebh,0f8h,048h	; b77e
	defb 0ebh,0f8h,04ch	; b781
	defb 0ebh,008h,058h	; b784
	defb 0ebh,008h,05ch	; b787
	defb 0fbh,0f8h,050h	; b78a
	defb 0fbh,0f8h,054h	; b78d

; ----------------------------------------------------------------------
; DATOS sprites_B790: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb790..0xb7a8  (24 bytes)
DATA_sprites_B790:
	defb 0ebh,0f0h,060h	; b790
	defb 0ebh,0f0h,064h	; b793
	defb 0ebh,000h,068h	; b796
	defb 0ebh,000h,06ch	; b799
	defb 0fbh,0f8h,070h	; b79c
	defb 0fbh,0f8h,074h	; b79f
	defb 0fbh,0f8h,070h	; b7a2
	defb 0fbh,0f8h,074h	; b7a5

; ----------------------------------------------------------------------
; DATOS sprites_B7A8: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb7a8..0xb7ad  (5 bytes)
DATA_sprites_B7A8:
	defb 080h,080h,084h	; b7a8
	defb 088h,08ch	; b7ab

; ----------------------------------------------------------------------
; DATOS sprites_B7AD: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb7ad..0xb7b2  (5 bytes)
DATA_sprites_B7AD:
	defb 080h,080h,084h	; b7ad
	defb 090h,094h	; b7b0

; ----------------------------------------------------------------------
; DATOS sprites_B7B2: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb7b2..0xb7b7  (5 bytes)
DATA_sprites_B7B2:
	defb 080h,080h,084h	; b7b2
	defb 098h,09ch	; b7b5

; ----------------------------------------------------------------------
; DATOS sprites_B7B7: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb7b7..0xb7bc  (5 bytes)
DATA_sprites_B7B7:
	defb 080h,0a0h,0a4h	; b7b7
	defb 0a8h,0ach	; b7ba

; ----------------------------------------------------------------------
; DATOS sprites_B7BC: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb7bc..0xb7c1  (5 bytes)
DATA_sprites_B7BC:
	defb 080h,0a0h,0a4h	; b7bc
	defb 0b0h,0b4h	; b7bf

; ----------------------------------------------------------------------
; DATOS sprites_B7C1: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb7c1..0xb7c6  (5 bytes)
DATA_sprites_B7C1:
	defb 080h,0a0h,0a4h	; b7c1
	defb 0b8h,0bch	; b7c4

; ----------------------------------------------------------------------
; DATOS sprites_B7C6: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb7c6..0xb7c9  (3 bytes)
DATA_sprites_B7C6:
	defb 081h,060h,064h	; b7c6

; ----------------------------------------------------------------------
; DATOS sprites_B7C9: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb7c9..0xb7cc  (3 bytes)
DATA_sprites_B7C9:
	defb 081h,058h,05ch	; b7c9

; ----------------------------------------------------------------------
; DATOS sprites_B7CC: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb7cc..0xb7cf  (3 bytes)
DATA_sprites_B7CC:
	defb 081h,090h,094h	; b7cc

; ----------------------------------------------------------------------
; DATOS sprites_B7CF: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb7cf..0xb7d2  (3 bytes)
DATA_sprites_B7CF:
	defb 081h,088h,08ch	; b7cf

; ----------------------------------------------------------------------
; DATOS sprites_B7D2: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb7d2..0xb7d5  (3 bytes)
DATA_sprites_B7D2:
	defb 081h,068h,06ch	; b7d2

; ----------------------------------------------------------------------
; DATOS sprites_B7D5: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb7d5..0xb7ed  (24 bytes)
DATA_sprites_B7D5:
	defb 0c0h,0f8h,040h	; b7d5
	defb 0c0h,0f8h,044h	; b7d8
	defb 0c0h,0f8h,060h	; b7db
	defb 0c0h,0f8h,064h	; b7de
	defb 0f0h,0f0h,048h	; b7e1
	defb 0f0h,0f0h,04ch	; b7e4
	defb 0f0h,000h,050h	; b7e7
	defb 0f0h,000h,054h	; b7ea

; ----------------------------------------------------------------------
; DATOS sprites_B7ED: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb7ed..0xb805  (24 bytes)
DATA_sprites_B7ED:
	defb 0c0h,0f8h,040h	; b7ed
	defb 0c0h,0f8h,044h	; b7f0
	defb 0bfh,0f8h,058h	; b7f3
	defb 0bfh,0f8h,05ch	; b7f6
	defb 0f0h,0f0h,048h	; b7f9
	defb 0f0h,0f0h,04ch	; b7fc
	defb 0f0h,000h,050h	; b7ff
	defb 0f0h,000h,054h	; b802

; ----------------------------------------------------------------------
; DATOS sprites_B805: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb805..0xb81d  (24 bytes)
DATA_sprites_B805:
	defb 0c0h,0f9h,070h	; b805
	defb 0c0h,0f9h,074h	; b808
	defb 0c0h,0f9h,090h	; b80b
	defb 0c0h,0f9h,094h	; b80e
	defb 0f0h,0f1h,080h	; b811
	defb 0f0h,0f1h,084h	; b814
	defb 0f0h,001h,078h	; b817
	defb 0f0h,001h,07ch	; b81a

; ----------------------------------------------------------------------
; DATOS sprites_B81D: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb81d..0xb835  (24 bytes)
DATA_sprites_B81D:
	defb 0c0h,0f9h,070h	; b81d
	defb 0c0h,0f9h,074h	; b820
	defb 0c0h,0f9h,088h	; b823
	defb 0c0h,0f9h,08ch	; b826
	defb 0f0h,0f1h,080h	; b829
	defb 0f0h,0f1h,084h	; b82c
	defb 0f0h,001h,078h	; b82f
	defb 0f0h,001h,07ch	; b832

; ----------------------------------------------------------------------
; DATOS sprites_B835: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb835..0xb83a  (5 bytes)
DATA_sprites_B835:
	defb 080h,040h,044h	; b835
	defb 048h,04ch	; b838

; ----------------------------------------------------------------------
; DATOS sprites_B83A: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb83a..0xb83f  (5 bytes)
DATA_sprites_B83A:
	defb 080h,050h,054h	; b83a
	defb 058h,05ch	; b83d

; ----------------------------------------------------------------------
; DATOS sprites_B83F: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb83f..0xb844  (5 bytes)
DATA_sprites_B83F:
	defb 080h,060h,064h	; b83f
	defb 068h,06ch	; b842

; ----------------------------------------------------------------------
; DATOS sprites_B844: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb844..0xb849  (5 bytes)
DATA_sprites_B844:
	defb 080h,070h,074h	; b844
	defb 078h,07ch	; b847

; ----------------------------------------------------------------------
; DATOS sprites_B849: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb849..0xb84c  (3 bytes)
DATA_sprites_B849:
	defb 081h,080h,084h	; b849

; ----------------------------------------------------------------------
; DATOS sprites_B84C: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb84c..0xb84f  (3 bytes)
DATA_sprites_B84C:
	defb 081h,088h,08ch	; b84c

; ----------------------------------------------------------------------
; DATOS sprites_B84F: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb84f..0xb852  (3 bytes)
DATA_sprites_B84F:
	defb 081h,090h,094h	; b84f

; ----------------------------------------------------------------------
; DATOS sprites_B852: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb852..0xb855  (3 bytes)
DATA_sprites_B852:
	defb 081h,098h,09ch	; b852

; ----------------------------------------------------------------------
; DATOS sprites_B855: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb855..0xb858  (3 bytes)
DATA_sprites_B855:
	defb 081h,0a8h,0ach	; b855

; ----------------------------------------------------------------------
; DATOS sprites_B858: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb858..0xb85b  (3 bytes)
DATA_sprites_B858:
	defb 081h,0b0h,0b4h	; b858

; ----------------------------------------------------------------------
; DATOS sprites_B85B: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb85b..0xb85e  (3 bytes)
DATA_sprites_B85B:
	defb 081h,0b8h,0bch	; b85b

; ----------------------------------------------------------------------
; DATOS sprites_B85E: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb85e..0xb861  (3 bytes)
DATA_sprites_B85E:
	defb 081h,0c0h,0c4h	; b85e

; ----------------------------------------------------------------------
; DATOS sprites_B861: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb861..0xb864  (3 bytes)
DATA_sprites_B861:
	defb 081h,0c8h,0cch	; b861

; ----------------------------------------------------------------------
; DATOS sprites_B864: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb864..0xb867  (3 bytes)
DATA_sprites_B864:
	defb 081h,0d0h,0d4h	; b864

; ----------------------------------------------------------------------
; DATOS sprites_B867: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (18 bytes)
;   0xb867..0xb879  (18 bytes)
DATA_sprites_B867:
	defb 0e9h,0f0h,040h	; b867
	defb 0e9h,0f0h,044h	; b86a
	defb 0e1h,000h,048h	; b86d
	defb 0e1h,000h,04ch	; b870
	defb 0f1h,000h,050h	; b873
	defb 0f1h,000h,054h	; b876

; ----------------------------------------------------------------------
; DATOS sprites_B879: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (18 bytes)
;   0xb879..0xb88b  (18 bytes)
DATA_sprites_B879:
	defb 0e9h,0f0h,040h	; b879
	defb 0e9h,0f0h,044h	; b87c
	defb 0e1h,000h,058h	; b87f
	defb 0e1h,000h,05ch	; b882
	defb 0f1h,000h,060h	; b885
	defb 0f1h,000h,064h	; b888

; ----------------------------------------------------------------------
; DATOS sprites_B88B: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb88b..0xb88e  (3 bytes)
DATA_sprites_B88B:
	defb 081h,040h,044h	; b88b

; ----------------------------------------------------------------------
; DATOS sprites_B88E: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb88e..0xb891  (3 bytes)
DATA_sprites_B88E:
	defb 081h,048h,04ch	; b88e

; ----------------------------------------------------------------------
; DATOS sprites_B891: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb891..0xb894  (3 bytes)
DATA_sprites_B891:
	defb 081h,050h,054h	; b891

; ----------------------------------------------------------------------
; DATOS sprites_B894: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb894..0xb897  (3 bytes)
DATA_sprites_B894:
	defb 081h,058h,05ch	; b894

; ----------------------------------------------------------------------
; DATOS sprites_B897: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb897..0xb89a  (3 bytes)
DATA_sprites_B897:
	defb 081h,0a8h,0ach	; b897

; ----------------------------------------------------------------------
; DATOS sprites_B89A: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb89a..0xb89d  (3 bytes)
DATA_sprites_B89A:
	defb 081h,0b0h,0b4h	; b89a

; ----------------------------------------------------------------------
; DATOS sprites_B89D: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb89d..0xb8a0  (3 bytes)
DATA_sprites_B89D:
	defb 081h,0b8h,0bch	; b89d

; ----------------------------------------------------------------------
; DATOS sprites_B8A0: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb8a0..0xb8a3  (3 bytes)
DATA_sprites_B8A0:
	defb 081h,0c0h,0c4h	; b8a0

; ----------------------------------------------------------------------
; DATOS sprites_B8A3: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (18 bytes)
;   0xb8a3..0xb8b5  (18 bytes)
DATA_sprites_B8A3:
	defb 0d1h,0f8h,040h	; b8a3
	defb 0d1h,0f8h,044h	; b8a6
	defb 0e1h,0f8h,048h	; b8a9
	defb 0e1h,0f8h,04ch	; b8ac
	defb 0f1h,0f8h,050h	; b8af
	defb 0f1h,0f8h,054h	; b8b2

; ----------------------------------------------------------------------
; DATOS sprites_B8B5: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (18 bytes)
;   0xb8b5..0xb8c7  (18 bytes)
DATA_sprites_B8B5:
	defb 0d1h,0f8h,058h	; b8b5
	defb 0d1h,0f8h,05ch	; b8b8
	defb 0e1h,0f8h,060h	; b8bb
	defb 0e1h,0f8h,064h	; b8be
	defb 0f1h,0f8h,068h	; b8c1
	defb 0f1h,0f8h,06ch	; b8c4

; ----------------------------------------------------------------------
; DATOS sprites_B8C7: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (18 bytes)
;   0xb8c7..0xb8d9  (18 bytes)
DATA_sprites_B8C7:
	defb 0d1h,0f8h,070h	; b8c7
	defb 0d1h,0f8h,074h	; b8ca
	defb 0e1h,0f8h,078h	; b8cd
	defb 0e1h,0f8h,07ch	; b8d0
	defb 0f1h,0f8h,080h	; b8d3
	defb 0f1h,0f8h,084h	; b8d6

; ----------------------------------------------------------------------
; DATOS sprites_B8D9: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (36 bytes)
;   0xb8d9..0xb8fd  (36 bytes)
DATA_sprites_B8D9:
	defb 0d1h,0f0h,040h	; b8d9
	defb 0d1h,0f0h,044h	; b8dc
	defb 0d1h,000h,048h	; b8df
	defb 0d1h,000h,04ch	; b8e2
	defb 0e1h,0f0h,050h	; b8e5
	defb 0e1h,0f0h,054h	; b8e8
	defb 0e1h,000h,058h	; b8eb
	defb 0e1h,000h,05ch	; b8ee
	defb 0f1h,0e8h,060h	; b8f1
	defb 0f1h,0e8h,064h	; b8f4
	defb 0f1h,0f8h,068h	; b8f7
	defb 0f1h,0f8h,06ch	; b8fa

; ----------------------------------------------------------------------
; DATOS sprites_B8FD: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb8fd..0xb900  (3 bytes)
DATA_sprites_B8FD:
	defb 081h,070h,074h	; b8fd

; ----------------------------------------------------------------------
; DATOS sprites_B900: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb900..0xb903  (3 bytes)
DATA_sprites_B900:
	defb 081h,078h,07ch	; b900

; ----------------------------------------------------------------------
; DATOS sprites_B903: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb903..0xb906  (3 bytes)
DATA_sprites_B903:
	defb 081h,080h,084h	; b903

; ----------------------------------------------------------------------
; DATOS sprites_B906: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb906..0xb909  (3 bytes)
DATA_sprites_B906:
	defb 081h,088h,08ch	; b906

; ----------------------------------------------------------------------
; DATOS sprites_B909: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (6 bytes)
;   0xb909..0xb90f  (6 bytes)
DATA_sprites_B909:
	defb 0f0h,0f8h,0f4h	; b909
	defb 0f0h,0f8h,0f4h	; b90c

; ----------------------------------------------------------------------
; DATOS sprites_B90F: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb90f..0xb912  (3 bytes)
DATA_sprites_B90F:
	defb 081h,0f8h,0f8h	; b90f

; ----------------------------------------------------------------------
; DATOS sprites_B912: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb912..0xb915  (3 bytes)
DATA_sprites_B912:
	defb 081h,048h,04ch	; b912

; ----------------------------------------------------------------------
; DATOS sprites_B915: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb915..0xb918  (3 bytes)
DATA_sprites_B915:
	defb 081h,040h,044h	; b915

; ----------------------------------------------------------------------
; DATOS sprites_B918: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb918..0xb91b  (3 bytes)
DATA_sprites_B918:
	defb 081h,050h,054h	; b918

; ----------------------------------------------------------------------
; DATOS sprites_B91B: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb91b..0xb91e  (3 bytes)
DATA_sprites_B91B:
	defb 081h,060h,064h	; b91b

; ----------------------------------------------------------------------
; DATOS sprites_B91E: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb91e..0xb921  (3 bytes)
DATA_sprites_B91E:
	defb 081h,058h,05ch	; b91e

; ----------------------------------------------------------------------
; DATOS sprites_B921: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb921..0xb924  (3 bytes)
DATA_sprites_B921:
	defb 081h,068h,06ch	; b921

; ----------------------------------------------------------------------
; DATOS sprites_B924: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (18 bytes)
;   0xb924..0xb936  (18 bytes)
DATA_sprites_B924:
	defb 0e7h,0f0h,040h	; b924
	defb 0e7h,0f0h,044h	; b927
	defb 0e1h,000h,068h	; b92a
	defb 0e1h,000h,06ch	; b92d
	defb 0f1h,000h,070h	; b930
	defb 0f1h,000h,074h	; b933

; ----------------------------------------------------------------------
; DATOS sprites_B936: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (18 bytes)
;   0xb936..0xb948  (18 bytes)
DATA_sprites_B936:
	defb 0e1h,0f1h,0a0h	; b936
	defb 0e1h,0f1h,0a4h	; b939
	defb 0f1h,0f1h,0d8h	; b93c
	defb 0f1h,0f1h,0dch	; b93f
	defb 0e7h,001h,078h	; b942
	defb 0e7h,001h,07ch	; b945

; ----------------------------------------------------------------------
; DATOS sprites_B948: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb948..0xb954  (12 bytes)
DATA_sprites_B948:
	defb 0f5h,0feh,04ch	; b948
	defb 0f3h,0fbh,048h	; b94b
	defb 0f2h,0fah,044h	; b94e
	defb 0f1h,0f8h,040h	; b951

; ----------------------------------------------------------------------
; DATOS sprites_B954: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (15 bytes)
;   0xb954..0xb963  (15 bytes)
DATA_sprites_B954:
	defb 0f7h,0ffh,050h	; b954
	defb 0f6h,0feh,04ch	; b957
	defb 0f3h,0fbh,048h	; b95a
	defb 0f2h,0fah,044h	; b95d
	defb 0f1h,0f8h,040h	; b960

; ----------------------------------------------------------------------
; DATOS sprites_B963: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (12 bytes)
;   0xb963..0xb96f  (12 bytes)
DATA_sprites_B963:
	defb 0f7h,0ffh,050h	; b963
	defb 0f4h,0fch,058h	; b966
	defb 0f3h,0fbh,054h	; b969
	defb 0f1h,0f8h,040h	; b96c

; ----------------------------------------------------------------------
; DATOS sprites_B96F: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb96f..0xb972  (3 bytes)
DATA_sprites_B96F:
	defb 0f1h,0f8h,060h	; b96f

; ----------------------------------------------------------------------
; DATOS sprites_B972: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb972..0xb975  (3 bytes)
DATA_sprites_B972:
	defb 0f1h,0f8h,064h	; b972

; ----------------------------------------------------------------------
; DATOS sprites_B975: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (24 bytes)
;   0xb975..0xb98d  (24 bytes)
DATA_sprites_B975:
	defb 0f1h,0e1h,040h	; b975
	defb 0f1h,0e1h,050h	; b978
	defb 0f1h,0f1h,044h	; b97b
	defb 0f1h,0f1h,054h	; b97e
	defb 0f1h,000h,048h	; b981
	defb 0f1h,000h,058h	; b984
	defb 0f1h,00fh,04ch	; b987
	defb 0f1h,00fh,05ch	; b98a

; ----------------------------------------------------------------------
; DATOS sprites_B98D: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb98d..0xb992  (5 bytes)
DATA_sprites_B98D:
	defb 080h,000h,004h	; b98d
	defb 008h,00ch	; b990

; ----------------------------------------------------------------------
; DATOS sprites_B992: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb992..0xb997  (5 bytes)
DATA_sprites_B992:
	defb 080h,010h,014h	; b992
	defb 018h,01ch	; b995

; ----------------------------------------------------------------------
; DATOS sprites_B997: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb997..0xb99c  (5 bytes)
DATA_sprites_B997:
	defb 080h,020h,024h	; b997
	defb 028h,02ch	; b99a

; ----------------------------------------------------------------------
; DATOS sprites_B99C: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (5 bytes)
;   0xb99c..0xb9a1  (5 bytes)
DATA_sprites_B99C:
	defb 080h,030h,034h	; b99c
	defb 038h,03ch	; b99f

; ----------------------------------------------------------------------
; DATOS sprites_B9A1: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9a1..0xb9a4  (3 bytes)
DATA_sprites_B9A1:
	defb 081h,0d0h,0d8h	; b9a1

; ----------------------------------------------------------------------
; DATOS sprites_B9A4: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9a4..0xb9a7  (3 bytes)
DATA_sprites_B9A4:
	defb 081h,0d4h,0dch	; b9a4

; ----------------------------------------------------------------------
; DATOS sprites_B9A7: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9a7..0xb9aa  (3 bytes)
DATA_sprites_B9A7:
	defb 081h,0c0h,0c8h	; b9a7

; ----------------------------------------------------------------------
; DATOS sprites_B9AA: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9aa..0xb9ad  (3 bytes)
DATA_sprites_B9AA:
	defb 081h,0c4h,0cch	; b9aa

; ----------------------------------------------------------------------
; DATOS sprites_B9AD: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9ad..0xb9b0  (3 bytes)
DATA_sprites_B9AD:
	defb 081h,070h,078h	; b9ad

; ----------------------------------------------------------------------
; DATOS sprites_B9B0: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9b0..0xb9b3  (3 bytes)
DATA_sprites_B9B0:
	defb 081h,074h,07ch	; b9b0

; ----------------------------------------------------------------------
; DATOS sprites_B9B3: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9b3..0xb9b6  (3 bytes)
DATA_sprites_B9B3:
	defb 081h,0a0h,0d8h	; b9b3

; ----------------------------------------------------------------------
; DATOS sprites_B9B6: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9b6..0xb9b9  (3 bytes)
DATA_sprites_B9B6:
	defb 081h,0a4h,0dch	; b9b6

; ----------------------------------------------------------------------
; DATOS sprites_B9B9: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9b9..0xb9bc  (3 bytes)
DATA_sprites_B9B9:
	defb 0f1h,0f8h,0ech	; b9b9

; ----------------------------------------------------------------------
; DATOS sprites_B9BC: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9bc..0xb9bf  (3 bytes)
DATA_sprites_B9BC:
	defb 0f1h,0f8h,0f0h	; b9bc

; ----------------------------------------------------------------------
; DATOS sprites_B9BF: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9bf..0xb9c2  (3 bytes)
DATA_sprites_B9BF:
	defb 081h,080h,084h	; b9bf

; ----------------------------------------------------------------------
; DATOS sprites_B9C2: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9c2..0xb9c5  (3 bytes)
DATA_sprites_B9C2:
	defb 081h,088h,08ch	; b9c2

; ----------------------------------------------------------------------
; DATOS sprites_B9C5: [dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los
;   patrones); lo leen p01:6469 (3 bytes)
;   0xb9c5..0xb9c8  (3 bytes)
DATA_sprites_B9C5:
	defb 081h,090h,094h	; b9c5

; ----------------------------------------------------------------------
; DATOS dibujos16_B9C8: 8 dibujos de 16x16 a 4 bits (128 bytes cada uno,
;   0x4A7B los sube en dieciseis filas de 8); lo leen p00:54D9 (1024 bytes)
;   0xb9c8..0xbdc8  (1024 bytes)
DATA_dibujos16_B9C8:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b9c8  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; b9d0  ........
	defb 000h,000h,000h,000h,002h,022h,000h,000h	; b9d8  ....."..
	defb 000h,000h,000h,000h,021h,011h,020h,000h	; b9e0  ....!. .
	defb 000h,000h,000h,002h,011h,021h,012h,000h	; b9e8  .....!..
	defb 000h,000h,000h,002h,012h,022h,012h,000h	; b9f0  ....."..
	defb 000h,000h,000h,002h,011h,021h,012h,000h	; b9f8  .....!..
	defb 000h,000h,000h,021h,011h,011h,020h,000h	; ba00  ...!.. .
	defb 000h,000h,002h,011h,011h,022h,000h,000h	; ba08  ....."..
	defb 000h,000h,021h,011h,012h,000h,000h,000h	; ba10  ..!.....
	defb 000h,002h,011h,011h,020h,000h,000h,000h	; ba18  .... ...
	defb 000h,021h,011h,012h,012h,000h,000h,000h	; ba20  .!......
	defb 002h,011h,011h,020h,021h,020h,000h,000h	; ba28  ... ! ..
	defb 000h,021h,012h,012h,002h,000h,000h,000h	; ba30  .!......
	defb 000h,002h,020h,021h,020h,000h,000h,000h	; ba38  .. ! ...
	defb 000h,000h,000h,002h,000h,000h,000h,000h	; ba40  ........
	defb 000h,000h,000h,000h,000h,000h,022h,020h	; ba48  ......"
	defb 000h,000h,000h,000h,002h,022h,0eeh,0e2h	; ba50  ....."..
	defb 000h,000h,000h,000h,02eh,0eeh,02eh,0e2h	; ba58  ........
	defb 000h,000h,000h,000h,02eh,0e2h,022h,0e2h	; ba60  ......".
	defb 000h,000h,000h,000h,002h,0e2h,02eh,020h	; ba68  .......
	defb 000h,000h,000h,000h,02eh,0eeh,0eeh,020h	; ba70  .......
	defb 000h,000h,000h,002h,0eeh,0e2h,0eeh,020h	; ba78  .......
	defb 000h,000h,000h,02eh,0eeh,020h,022h,000h	; ba80  ..... ".
	defb 000h,000h,002h,0eeh,0e2h,000h,000h,000h	; ba88  ........
	defb 000h,000h,02eh,0eeh,020h,000h,000h,000h	; ba90  .... ...
	defb 000h,002h,0eeh,0eeh,020h,000h,000h,000h	; ba98  .... ...
	defb 000h,02eh,0eeh,022h,0e2h,000h,000h,000h	; baa0  ..."....
	defb 002h,0eeh,0eeh,020h,02eh,020h,000h,000h	; baa8  ... . ..
	defb 02eh,0eeh,022h,0e2h,002h,000h,000h,000h	; bab0  ..".....
	defb 002h,0e2h,000h,02eh,020h,000h,000h,000h	; bab8  .... ...
	defb 000h,020h,000h,002h,000h,000h,000h,000h	; bac0  . ......
	defb 000h,000h,000h,022h,020h,000h,000h,000h	; bac8  ..." ...
	defb 000h,000h,022h,0eeh,0e2h,020h,000h,000h	; bad0  ..".. ..
	defb 000h,002h,0e2h,0feh,0f2h,0e2h,000h,000h	; bad8  ........
	defb 000h,02eh,022h,0feh,0f2h,02eh,020h,000h	; bae0  .."... .
	defb 002h,0efh,0ffh,0feh,0ffh,0ffh,0e2h,000h	; bae8  ........
	defb 002h,0eeh,0eeh,0eeh,0eeh,0eeh,0e2h,000h	; baf0  ........
	defb 002h,022h,022h,022h,022h,022h,022h,000h	; baf8  ."""""".
	defb 002h,0eeh,0eeh,0eeh,0eeh,0eeh,0e2h,000h	; bb00  ........
	defb 002h,0efh,0ffh,0feh,0ffh,0ffh,0e2h,000h	; bb08  ........
	defb 002h,0efh,022h,0feh,0f2h,02fh,0e2h,000h	; bb10  .."../..
	defb 002h,0efh,022h,0feh,0f2h,02fh,0e2h,000h	; bb18  .."../..
	defb 002h,0efh,022h,0feh,0f2h,02fh,0e2h,000h	; bb20  .."../..
	defb 002h,0efh,022h,0feh,0f2h,02fh,0e2h,000h	; bb28  .."../..
	defb 002h,0efh,0ffh,0feh,0ffh,0ffh,0e2h,000h	; bb30  ........
	defb 002h,0eeh,0eeh,0eeh,0eeh,0eeh,0e2h,000h	; bb38  ........
	defb 000h,022h,022h,022h,022h,022h,020h,000h	; bb40  .""""" .
	defb 000h,000h,000h,000h,000h,02eh,022h,000h	; bb48  ......".
	defb 000h,000h,000h,000h,002h,0e8h,028h,020h	; bb50  ......(
	defb 000h,000h,000h,000h,02eh,082h,02eh,020h	; bb58  .......
	defb 000h,000h,000h,002h,0e8h,020h,022h,020h	; bb60  ..... "
	defb 000h,000h,000h,02eh,082h,002h,0e2h,082h	; bb68  ........
	defb 000h,000h,002h,0e8h,020h,002h,082h,082h	; bb70  .... ...
	defb 000h,000h,02eh,082h,000h,000h,028h,020h	; bb78  ......(
	defb 000h,002h,0e8h,020h,000h,000h,02eh,020h	; bb80  ... ...
	defb 000h,02eh,082h,000h,000h,002h,0e2h,082h	; bb88  ........
	defb 002h,0e8h,020h,000h,000h,002h,082h,082h	; bb90  .. .....
	defb 002h,082h,000h,000h,000h,000h,028h,020h	; bb98  ......(
	defb 000h,020h,000h,000h,000h,002h,02eh,020h	; bba0  . .....
	defb 002h,000h,000h,020h,000h,02eh,0e2h,000h	; bba8  ... ....
	defb 022h,0e2h,022h,08eh,022h,082h,082h,020h	; bbb0  "."."..
	defb 082h,028h,0e2h,022h,08eh,028h,022h,020h	; bbb8  .(.".("
	defb 028h,0e2h,022h,08eh,022h,022h,020h,000h	; bbc0  (."."" .
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bbc8  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bbd0  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bbd8  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bbe0  ........
	defb 000h,000h,000h,000h,000h,002h,000h,000h	; bbe8  ........
	defb 000h,000h,000h,000h,000h,02ch,020h,000h	; bbf0  ....., .
	defb 000h,022h,022h,022h,022h,02eh,022h,022h	; bbf8  ."""".""
	defb 022h,0cch,0cch,0cch,0cch,02eh,02ch,0cch	; bc00  ".....,.
	defb 0ceh,0eeh,0eeh,0eeh,0eeh,0ceh,02ch,0cch	; bc08  ......,.
	defb 022h,022h,022h,022h,022h,02eh,022h,022h	; bc10  """"".""
	defb 000h,000h,000h,000h,000h,02eh,020h,000h	; bc18  ...... .
	defb 000h,000h,000h,000h,000h,02ch,020h,000h	; bc20  ....., .
	defb 000h,000h,000h,000h,000h,002h,000h,000h	; bc28  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bc30  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bc38  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; bc40  ........
	defb 000h,000h,000h,002h,0cch,020h,000h,000h	; bc48  ..... ..
	defb 000h,002h,022h,002h,0cch,0c2h,000h,000h	; bc50  ..".....
	defb 000h,02ch,0ech,02ch,0ceh,0cch,020h,000h	; bc58  .,.,.. .
	defb 000h,02ch,0ceh,02ch,0eeh,0ech,0c2h,000h	; bc60  .,.,....
	defb 000h,002h,0cch,02ch,02eh,0eeh,0cch,020h	; bc68  ...,...
	defb 000h,002h,022h,022h,022h,0eeh,0ech,0c2h	; bc70  .."""...
	defb 002h,02ch,0c2h,02ch,0ech,02ch,0cch,0c2h	; bc78  .,.,.,..
	defb 02ch,0cch,0e2h,02ch,0ceh,0c2h,022h,020h	; bc80  ,..,.."
	defb 022h,0ceh,0eeh,022h,0cch,0ech,020h,000h	; bc88  "..".. .
	defb 002h,02ch,0eeh,0e2h,02ch,0ceh,020h,000h	; bc90  .,..,. .
	defb 000h,022h,0ceh,0ech,022h,0cch,0e2h,000h	; bc98  .".."...
	defb 000h,002h,02ch,0ech,020h,02ch,0ceh,020h	; bca0  ..,. ,.
	defb 000h,000h,022h,0cch,020h,002h,0cch,0e2h	; bca8  ..". ...
	defb 000h,000h,002h,02ch,020h,000h,02ch,0ceh	; bcb0  ..., .,.
	defb 000h,000h,000h,022h,000h,000h,002h,0cch	; bcb8  ..."....
	defb 000h,000h,000h,000h,000h,000h,000h,022h	; bcc0  ......."
	defb 000h,000h,000h,000h,000h,000h,002h,000h	; bcc8  ........
	defb 000h,000h,000h,002h,000h,000h,02eh,0e0h	; bcd0  ........
	defb 000h,000h,000h,0eeh,020h,002h,0efh,0e2h	; bcd8  .... ...
	defb 000h,000h,00eh,0ffh,0e2h,02eh,0ffh,0e2h	; bce0  ........
	defb 000h,000h,002h,0efh,0feh,0efh,0feh,022h	; bce8  ......."
	defb 000h,000h,000h,02eh,0ffh,0ffh,0e2h,022h	; bcf0  ......."
	defb 000h,000h,000h,002h,0efh,0feh,022h,020h	; bcf8  ......"
	defb 000h,000h,000h,02eh,0ffh,0ffh,0e2h,000h	; bd00  ........
	defb 000h,000h,002h,0efh,0feh,0efh,0feh,020h	; bd08  .......
	defb 000h,000h,02eh,0ffh,0e2h,02eh,0ffh,0e2h	; bd10  ........
	defb 000h,002h,0efh,0feh,022h,022h,0efh,0e2h	; bd18  ....""..
	defb 000h,02eh,0ffh,0e2h,022h,002h,02eh,020h	; bd20  ...."..
	defb 002h,0efh,0feh,022h,020h,000h,022h,000h	; bd28  ..." .".
	defb 02eh,0ffh,0e2h,022h,000h,000h,000h,000h	; bd30  ..."....
	defb 00eh,0feh,022h,020h,000h,000h,000h,000h	; bd38  .." ....
	defb 000h,0e2h,022h,000h,000h,000h,000h,000h	; bd40  ..".....
	defb 000h,000h,000h,000h,000h,000h,002h,020h	; bd48  .......
	defb 000h,000h,000h,000h,000h,020h,021h,012h	; bd50  ..... !.
	defb 000h,000h,002h,022h,022h,012h,021h,012h	; bd58  ..."".!.
	defb 000h,000h,021h,011h,011h,021h,012h,020h	; bd60  ..!..!.
	defb 000h,002h,012h,022h,022h,021h,012h,000h	; bd68  ...""!..
	defb 000h,021h,022h,022h,022h,012h,021h,020h	; bd70  .!""".!
	defb 002h,012h,0e2h,022h,022h,022h,012h,000h	; bd78  ..."""..
	defb 021h,02eh,0e2h,022h,022h,022h,012h,000h	; bd80  !.."""..
	defb 021h,02eh,0eeh,022h,022h,022h,012h,000h	; bd88  !.."""..
	defb 002h,012h,0eeh,0e2h,022h,022h,012h,000h	; bd90  ....""..
	defb 000h,021h,02eh,0eeh,022h,022h,012h,000h	; bd98  .!..""..
	defb 000h,002h,012h,0eeh,0eeh,021h,020h,000h	; bda0  .....! .
	defb 000h,000h,021h,02eh,0e2h,012h,000h,000h	; bda8  ..!.....
	defb 000h,000h,002h,012h,021h,020h,000h,000h	; bdb0  ....! ..
	defb 000h,000h,000h,021h,012h,000h,000h,000h	; bdb8  ...!....
	defb 000h,000h,000h,002h,020h,000h,000h,000h	; bdc0  .... ...

; ----------------------------------------------------------------------
; DATOS dibujos16_BDC8: 5 dibujos de 16x16 a 4 bits (128 bytes cada uno,
;   0x4A7B los sube en dieciseis filas de 8); se sale de la ventana del
;   cartucho: los ultimos 72 bytes los lee de la RAM, de 0xC000 a 0xC047; lo
;   leen p00:54E4 (568 bytes)
;   0xbdc8..0xc000  (568 bytes)
DATA_dibujos16_BDC8:
	defb 000h,000h,008h,000h,000h,080h,000h,000h	; bdc8  ........
	defb 000h,000h,088h,020h,008h,082h,000h,000h	; bdd0  ... ....
	defb 000h,000h,088h,080h,008h,088h,000h,000h	; bdd8  ........
	defb 000h,008h,081h,082h,088h,018h,020h,000h	; bde0  ...... .
	defb 000h,008h,011h,082h,081h,018h,020h,000h	; bde8  ...... .
	defb 000h,000h,01eh,020h,001h,0e2h,000h,000h	; bdf0  ... ....
	defb 000h,000h,0c2h,000h,00ch,020h,000h,000h	; bdf8  ..... ..
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be00  ... ....
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be08  ... ....
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be10  ... ....
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be18  ... ....
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be20  ... ....
	defb 000h,008h,088h,083h,088h,088h,030h,000h	; be28  ......0.
	defb 000h,002h,022h,023h,022h,023h,020h,000h	; be30  .."#"# .
	defb 000h,000h,028h,032h,008h,032h,000h,000h	; be38  ..(2.2..
	defb 000h,000h,002h,028h,082h,020h,000h,000h	; be40  ...(. ..
	defb 000h,000h,002h,000h,000h,020h,000h,000h	; be48  ..... ..
	defb 000h,000h,022h,020h,002h,022h,000h,000h	; be50  .." ."..
	defb 000h,000h,022h,020h,002h,022h,000h,000h	; be58  .." ."..
	defb 000h,002h,088h,022h,028h,082h,020h,000h	; be60  ..."(. .
	defb 000h,008h,011h,082h,081h,018h,020h,000h	; be68  ...... .
	defb 000h,000h,011h,020h,001h,012h,000h,000h	; be70  ... ....
	defb 000h,000h,0c2h,000h,00ch,020h,000h,000h	; be78  ..... ..
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be80  ... ....
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be88  ... ....
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be90  ... ....
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; be98  ... ....
	defb 000h,000h,0ech,020h,00eh,0c2h,000h,000h	; bea0  ... ....
	defb 000h,008h,088h,083h,088h,088h,030h,000h	; bea8  ......0.
	defb 000h,002h,022h,023h,022h,023h,020h,000h	; beb0  .."#"# .
	defb 000h,000h,028h,032h,008h,032h,000h,000h	; beb8  ..(2.2..
	defb 000h,000h,002h,028h,082h,020h,000h,000h	; bec0  ...(. ..
	defb 000h,000h,000h,002h,000h,020h,000h,000h	; bec8  ..... ..
	defb 002h,000h,008h,020h,000h,080h,000h,000h	; bed0  ... ....
	defb 002h,000h,082h,008h,000h,008h,000h,000h	; bed8  ........
	defb 002h,028h,082h,080h,000h,008h,000h,080h	; bee0  .(......
	defb 000h,028h,002h,082h,000h,082h,028h,000h	; bee8  .(....(.
	defb 000h,088h,002h,088h,020h,082h,028h,000h	; bef0  .... .(.
	defb 002h,088h,082h,028h,088h,088h,028h,080h	; bef8  ...(..(.
	defb 008h,088h,082h,088h,081h,088h,082h,080h	; bf00  ........
	defb 028h,088h,082h,082h,088h,081h,088h,028h	; bf08  (......(
	defb 028h,081h,088h,082h,088h,081h,018h,028h	; bf10  (......(
	defb 028h,088h,028h,080h,008h,088h,028h,088h	; bf18  (.(...(.
	defb 028h,081h,018h,088h,022h,088h,011h,088h	; bf20  (..."...
	defb 002h,081h,088h,008h,022h,088h,0e1h,080h	; bf28  ...."...
	defb 002h,081h,088h,008h,022h,088h,088h,000h	; bf30  ...."...
	defb 000h,028h,018h,080h,028h,088h,020h,000h	; bf38  .(..(. .
	defb 000h,000h,008h,082h,022h,020h,000h,000h	; bf40  ...." ..
	defb 000h,000h,000h,008h,000h,080h,000h,000h	; bf48  ........
	defb 008h,000h,002h,080h,000h,080h,000h,000h	; bf50  ........
	defb 008h,000h,028h,002h,000h,008h,000h,000h	; bf58  ..(.....
	defb 008h,082h,028h,080h,000h,008h,000h,020h	; bf60  ..(....
	defb 000h,088h,008h,088h,000h,028h,082h,000h	; bf68  .....(..
	defb 000h,088h,008h,018h,080h,028h,082h,000h	; bf70  .....(..
	defb 008h,088h,088h,081h,082h,088h,088h,020h	; bf78  .......
	defb 008h,018h,088h,0e8h,082h,088h,088h,080h	; bf80  ........
	defb 081h,088h,018h,0e8h,022h,088h,018h,082h	; bf88  ...."...
	defb 081h,081h,01eh,088h,028h,088h,018h,082h	; bf90  ....(...
	defb 081h,081h,0e8h,080h,008h,081h,018h,082h	; bf98  ........
	defb 088h,01eh,018h,022h,088h,0e1h,018h,022h	; bfa0  ..."..."
	defb 008h,01eh,018h,022h,088h,088h,018h,020h	; bfa8  ..."...
	defb 008h,081h,018h,008h,08eh,088h,088h,000h	; bfb0  ........
	defb 000h,088h,011h,080h,088h,081h,080h,000h	; bfb8  ........
	defb 000h,000h,002h,028h,088h,080h,000h,000h	; bfc0  ...(....
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc8  ........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd0  ........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd8  ........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe0  ........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe8  ........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff0  ........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff8  ........
