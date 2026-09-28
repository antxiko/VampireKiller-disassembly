#!/usr/bin/env python3
"""Lo que se afirma en la web: que sus cifras son las del listado, que no
nombra ningun otro juego de la serie y que no tiene enlaces rotos.

Las cifras se vuelven a medir aqui, con las mismas herramientas que las
dieron (presupuesto.py necesita los trazados de work/: `make trace`).
"""
import os
import re
import subprocess
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOOLS = os.path.join(RAIZ, "tools")
sys.path.insert(0, TOOLS)

import contenido_web as C          # noqa: E402

BANCOS_CON_CODIGO = ("00", "01", "02", "03", "13", "14")

# Los demas juegos de la serie. Ninguno pinta nada en este repositorio: si
# sale uno, es un resto de haber copiado algo de otro proyecto.
OTROS_JUEGOS = (
    "Nemesis", "Gradius", "Pitfall", "Temptations", "Stardust", "Ale Hop",
    "Colt 36", "Middle Earth", "Monkey Academy", "F-1 Spirit",
    "Athletic Land", "Antarctic", "Pippols", "Frogger", "Time Pilot",
    "Super Cobra", "Billiards", "Mahjong", "Hyper Olympic", "Hyper Sports",
    "Hyper Rally", "HyperRally", "Sky Jaguar", "Yie Ar", "Knightmare",
    "Twin Bee", "TwinBee", "Road Fighter", "Ping Pong", "Soccer", "Goonies",
    "Trailblazer", "Boxing", "Bomber Man", "King's Valley", "King&#39;s",
    "Mopi Ranger", "Baseball", "Tennis", "Demonia", "Descubrimiento",
    "Cabbage Patch", "Casio World", "Hole in One", "3D Golf", "Konami's Golf",
    "Football", "Penguin", "Yume Tairiku", "Circus Charlie", "Magical Tree",
    "Comic Bakery",
)
EXTENSIONES = (".py", ".md", ".tcl", ".sh", ".html", ".notes", ".txt")


def _lee(ruta):
    with open(ruta, encoding="utf-8", errors="ignore") as f:
        return f.read()


def _mide_la_densidad():
    ti = tc = rutinas = 0
    for p in BANCOS_CON_CODIGO:
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "densidad.py"),
                            os.path.join(RAIZ, "src", "vampirekiller_p%s.asm" % p)],
                           capture_output=True, text=True)
        m = re.search(r"en total: (\d+) instrucciones, (\d+) comentarios", r.stdout)
        ti += int(m.group(1))
        tc += int(m.group(2))
        rutinas += int(re.search(r"por debajo del 10 %, de (\d+)", r.stdout).group(1))
    return ti, tc, rutinas


class Web(unittest.TestCase):

    def test_las_cifras_de_la_portada_son_las_del_listado(self):
        ti, tc, rutinas = _mide_la_densidad()
        self.assertEqual((C.INSTRUCCIONES, C.COMENTARIOS, C.RUTINAS), (ti, tc, rutinas))

    def test_el_codigo_y_los_datos_son_los_del_presupuesto(self):
        if not os.path.exists(os.path.join(RAIZ, "work", "p00.trace.json")):
            raise AssertionError("faltan los trazados de work/: haz `make trace`")
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "presupuesto.py"),
                            os.path.join(RAIZ, "work"), os.path.join(RAIZ, "src")],
                           capture_output=True, text=True, cwd=TOOLS)
        cifra = {l.split()[0]: int(l.split()[2]) for l in r.stdout.splitlines()
                 if l.strip().startswith(("codigo trazado", "datos identificados"))}
        self.assertEqual((C.CODIGO, C.DATOS), (cifra["codigo"], cifra["datos"]))

    def test_la_suma_de_bytes_da_el_cartucho(self):
        self.assertEqual(C.CODIGO + C.DATOS, 131072)

    def test_las_cifras_escritas_en_los_textos(self):
        """Lo que dicen los README y las paginas, contra contenido_web."""
        d_es, d_en = C.densidad("es"), C.densidad("en")
        textos = {
            "README.md": (d_en + "%", "{:,}".format(C.RUTINAS), "{:,}".format(C.CODIGO)),
            "README.es.md": (d_es + " %", "{:,}".format(C.RUTINAS).replace(",", "."),
                             "{:,}".format(C.CODIGO).replace(",", ".")),
            os.path.join("docs", "THE-CODE.md"): (d_en + "%", "{:,}".format(C.INSTRUCCIONES)),
            os.path.join("docs", "es", "EL-CODIGO.md"): (d_es + " %",),
        }
        for fichero, cifras in textos.items():
            texto = _lee(os.path.join(RAIZ, fichero))
            for c in cifras:
                self.assertIn(c, texto, fichero)

    def test_no_se_nombra_otro_juego_de_la_serie(self):
        malos = []
        for base, dirs, ficheros in os.walk(RAIZ):
            dirs[:] = [d for d in dirs if d not in (".git", "__pycache__", "work", ".forja")]
            for f in ficheros:
                if not f.endswith(EXTENSIONES) and f not in ("LICENSE", "Makefile"):
                    continue
                ruta = os.path.join(base, f)
                if ruta == os.path.abspath(__file__):
                    continue
                texto = _lee(ruta)
                malos += ["%s: %s" % (os.path.relpath(ruta, RAIZ), j)
                          for j in OTROS_JUEGOS if j in texto]
        self.assertEqual(malos, [])

    def test_los_avisos_nombran_este_juego(self):
        for f in ("LICENSE", "AVISO-LEGAL.md", "LEGAL-NOTICE.md", "README.md", "README.es.md"):
            self.assertIn(C.NOMBRE, _lee(os.path.join(RAIZ, f)), f)

    def test_las_siete_paginas_en_los_dos_idiomas(self):
        en = ("GETTING-STARTED", "THE-GAME", "THE-CARTRIDGE", "THE-CODE", "FINDINGS",
              "IN-THE-EMULATOR", "OPEN-QUESTIONS")
        es = ("EMPEZAR", "EL-JUEGO", "EL-CARTUCHO", "EL-CODIGO", "HALLAZGOS",
              "EN-EL-EMULADOR", "PREGUNTAS-ABIERTAS")
        for carpeta, paginas in (("docs", en), (os.path.join("docs", "es"), es)):
            for p in paginas:
                for ext in (".md", ".html"):
                    self.assertTrue(os.path.exists(os.path.join(RAIZ, carpeta, p + ext)), p + ext)

    def test_la_galeria_existe(self):
        for fich, _, _ in C.GALERIA + [(C.LOGOTIPO, "", "")]:
            self.assertTrue(os.path.exists(os.path.join(RAIZ, "docs", "imagenes", fich)), fich)

    def test_sin_enlaces_rotos(self):
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "check_enlaces.py"),
                            os.path.join(RAIZ, "docs")], capture_output=True, text=True)
        self.assertEqual(r.returncode, 0, r.stdout)


if __name__ == "__main__":
    unittest.main()
