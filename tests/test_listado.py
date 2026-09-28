#!/usr/bin/env python3
"""Lo que se afirma del listado: que explica el cartucho entero.

Necesita los trazados de work/ (los hace `make trace`, que a su vez necesita
la ROM); sin ellos falla diciendo que falta, no se salta.
"""
import os
import subprocess
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOOLS = os.path.join(RAIZ, "tools")


class Listado(unittest.TestCase):

    def test_ni_un_byte_sin_explicar(self):
        """tools/presupuesto.py: cada byte es codigo trazado o una D con nombre."""
        if not os.path.exists(os.path.join(RAIZ, "work", "p00.trace.json")):
            raise AssertionError("faltan los trazados de work/: haz `make trace`")
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "presupuesto.py"),
                            os.path.join(RAIZ, "work"), os.path.join(RAIZ, "src")],
                           capture_output=True, text=True, cwd=TOOLS)
        linea = next(l for l in r.stdout.splitlines() if l.strip().startswith("sin explicar"))
        self.assertEqual(int(linea.split()[2]), 0, linea)

    def test_los_bloques_no_pisan_nada(self):
        """tools/bloques.py no deja ningun bloque en conflicto con el codigo o las D a mano."""
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "bloques.py")],
                           capture_output=True, text=True, cwd=TOOLS)
        self.assertNotIn("pisa", r.stdout)
        self.assertNotIn("avisos", r.stdout)

    def test_el_makefile_y_paginas_py_dicen_lo_mismo(self):
        sys.path.insert(0, TOOLS)
        from paginas import ORG
        mk = open(os.path.join(RAIZ, "Makefile"), encoding="utf-8").read()
        for p, o in ORG.items():
            self.assertIn("ORG_%02d = %#06x" % (p, o), mk)


if __name__ == "__main__":
    unittest.main()
