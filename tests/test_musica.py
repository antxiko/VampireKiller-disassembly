"""La musica: el motor del cartucho ejecutado por tools/musica.py.

Las duraciones de CFG["cotejado"] son las piezas cotejadas contra openMSX
(tools/omsx_psg.tcl y tools/coteja_psg.py), cuadro a cuadro.
"""
import os
import re
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))


class Musica(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import motor_musica
        import musica
        cls.mm = motor_musica
        cls.cfg = musica.CFG
        cls.rom = open(os.path.join(RAIZ, cls.cfg["rom"]), "rb").read()

    def test_las_cotejadas_duran_lo_medido(self):
        for numero, cuadros_n, vuelta_n in self.cfg["cotejado"]:
            cuadros, vuelta = self.mm.ejecuta(self.cfg, self.rom, numero)
            self.assertEqual((len(cuadros), vuelta), (cuadros_n, vuelta_n),
                             "0x%02X" % numero)

    def test_todas_las_piezas_suenan(self):
        self.assertTrue(self.cfg["piezas"])
        for numero, *_ in self.cfg["piezas"]:
            cuadros, _ = self.mm.ejecuta(self.cfg, self.rom, numero,
                                         maximo=120)
            self.assertTrue(any(cuadros), "0x%02X no escribe" % numero)

    def test_cada_audio_de_la_web_existe(self):
        for base in ("docs", "docs/es"):
            for f in os.listdir(os.path.join(RAIZ, base)):
                if not f.endswith(".md"):
                    continue
                txt = open(os.path.join(RAIZ, base, f), encoding="utf-8").read()
                for src in re.findall(r'<audio [^>]*src="([^"]+)"', txt):
                    ruta = os.path.normpath(os.path.join(RAIZ, base, src.split("?")[0]))
                    self.assertTrue(os.path.exists(ruta), "%s: %s" % (f, src))

    def test_cada_pieza_tiene_su_audio_en_las_dos_paginas(self):
        for _, fichero, *_ in self.cfg["piezas"]:
            for ruta in ("docs/es/LA-MUSICA.md", "docs/THE-MUSIC.md"):
                txt = open(os.path.join(RAIZ, ruta), encoding="utf-8").read()
                self.assertIn("audio/" + fichero, txt, "%s en %s" % (fichero, ruta))


if __name__ == "__main__":
    unittest.main()
