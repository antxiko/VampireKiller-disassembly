#!/usr/bin/env python3
"""Lo que se ha MEDIDO del cartucho, clavado para que no se deshaga solo.

Estas comprobaciones necesitan la ROM, y si no esta **fallan**: no se saltan.
Un test que se salta no comprueba nada y en verde daria la impresion
contraria. Quien clone esto sin poner su copia del cartucho vera fallar este
fichero con un mensaje que dice exactamente que falta; los tests que solo
miran el listado publicado siguen pasando.

Cada una corresponde a una afirmacion de la web o de las notas, y todas leen
el binario: ninguna compara una constante contra si misma.
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG, TAM_PAGINA, N_PAGINAS               # noqa: E402

ROM = os.path.join(RAIZ, "vampirekiller.rom")
SHA = "99eabaaeb2b6c02220e131043d5a6401d0d8c5f413d89204547adcc04d65e7e2"

FALTA = ("falta vampirekiller.rom en la raiz del repo. Son los 131.072 bytes "
         "de Vampire Killer / Akumajo Dracula (Konami, RC-744, 1986, MSX2), "
         "y no se distribuyen aqui: pon tu copia. El sha256 tiene que ser %s"
         % SHA)


class Cartucho(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(ROM):
            raise AssertionError(FALTA)
        with open(ROM, "rb") as f:
            cls.rom = f.read()

    def test_es_la_misma_rom(self):
        self.assertEqual(len(self.rom), 131072)
        self.assertEqual(hashlib.sha256(self.rom).hexdigest(), SHA)

    def test_cabecera_ab(self):
        """0x4000 'AB', INIT 0x4075 y los otros tres vectores a cero."""
        self.assertEqual(self.rom[0:2], b"AB")
        self.assertEqual(self.rom[2] | (self.rom[3] << 8), 0x4075)
        self.assertEqual(self.rom[4:10], b"\x00" * 6)

    def test_mapper_es_konami4(self):
        """Ni una escritura a los registros del mapper CON SCC.

        Los de Konami5 son 0x5000, 0x7000, 0x9000 y 0xB000: se busca el
        `ld (nn),a` -0x32- con cada uno de operando en los 128 KB.
        """
        for reg in (0x5000, 0x7000, 0x9000, 0xB000):
            pat = bytes([0x32, reg & 0xFF, reg >> 8])
            self.assertNotIn(pat, self.rom,
                             "aparece un ld (%#06x),a: seria Konami5" % reg)
        for reg in (0x6000, 0x8000, 0xA000):
            self.assertIn(bytes([0x32, reg & 0xFF, reg >> 8]), self.rom)

    def test_regla_banco_org(self):
        """Cada banco se mapea SIEMPRE en la misma ranura.

        Se recorren los `ld a,N` seguidos de `ld (reg),a` -con los `inc a` y
        `ld (hl),a` / `inc l` / `inc hl` del reparto de tres en medio- y el
        banco que llega a cada registro tiene que ser de los que
        tools/paginas.py pone en esa ranura. Y se tienen que ver los quince
        bancos conmutables.
        """
        regs = (0x6000, 0x8000, 0xA000)
        vistos = {}
        for i in range(len(self.rom) - 5):
            if self.rom[i] != 0x3E:                 # ld a,N
                continue
            j, val = i + 2, self.rom[i + 1]
            while j < len(self.rom) - 2:
                w = self.rom[j + 1] | (self.rom[j + 2] << 8)
                if self.rom[j] == 0x32 and w in regs:
                    if val < N_PAGINAS:
                        vistos.setdefault(val, set()).add(w)
                    j += 3
                elif self.rom[j] == 0x3C:           # inc a
                    val += 1
                    j += 1
                elif self.rom[j] in (0x77, 0x2C, 0x23):  # ld (hl),a / inc l / inc hl
                    j += 1
                else:
                    break
        self.assertEqual(sorted(vistos), list(range(1, 16)))
        for banco, rs in sorted(vistos.items()):
            for reg in rs:
                self.assertEqual(ORG[banco], reg,
                                 "el banco %d va a %#06x y paginas.py dice %#06x"
                                 % (banco, reg, ORG[banco]))

    def test_gancho_de_interrupcion(self):
        """INIT engancha 0x4028 en H.TIMI (0xFD9F/0xFDA0) y se queda en `jr $`."""
        pat = bytes([0x3E, 0xC3,                     # ld a,0xC3
                     0x32, 0x9F, 0xFD,               # ld (0xFD9F),a
                     0x21, 0x28, 0x40,               # ld hl,0x4028
                     0x22, 0xA0, 0xFD])              # ld (0xFDA0),hl
        self.assertEqual(self.rom[0x00B3:0x00B3 + len(pat)], pat)
        self.assertEqual(self.rom[0x00C3:0x00C5], b"\x18\xfe")   # jr $

    def test_la_interrupcion_pone_el_sonido_sin_tocar_la_copia(self):
        """0x4030 mete los bancos 14 y 15 sin escribir la copia en RAM, llama
        a 0x8964 y devuelve las ranuras leyendo 0xF0F2 y 0xF0F3."""
        esperado = bytes([0xF3,                      # di
                          0x3E, 0x0E, 0x32, 0x00, 0x80,
                          0x3E, 0x0F, 0x32, 0x00, 0xA0,
                          0xCD, 0x64, 0x89,          # call 0x8964
                          0xF3,
                          0x3A, 0xF2, 0xF0, 0x32, 0x00, 0x80,
                          0x3A, 0xF3, 0xF0, 0x32, 0x00, 0xA0])
        self.assertEqual(self.rom[0x0030:0x0030 + len(esperado)], esperado)

    def test_no_hay_bancos_de_relleno(self):
        """Ningun banco es 0xFF de punta a punta."""
        for b in range(N_PAGINAS):
            blq = self.rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]
            self.assertNotEqual(blq, b"\xff" * TAM_PAGINA)

    def test_despachador_de_konami(self):
        """El despachador esta en 0x406B: la tabla va detras del `call`.

        `pop hl / add a,a / call 0x4061 / ld e,(hl) / inc hl / ld d,(hl) /
        ex de,hl / jp (hl)`, y 0x4061 es `add a,l / ld l,a / ret nc / inc h /
        ret`.
        """
        self.assertEqual(self.rom[0x006B:0x0075],
                         bytes([0xE1, 0x87, 0xCD, 0x61, 0x40,
                                0x5E, 0x23, 0x56, 0xEB, 0xE9]))
        self.assertEqual(self.rom[0x0061:0x0066],
                         bytes([0x85, 0x6F, 0xD0, 0x24, 0xC9]))


if __name__ == "__main__":
    unittest.main()
