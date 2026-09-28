#!/usr/bin/env python3
"""Comprueba que la web no tiene enlaces ni imagenes rotas.

Es una comprobacion tonta pero necesaria: la web es bilingue y con documentos
enlazados en cruz, y basta con mover un fichero de sitio para dejar media docena
de enlaces colgando sin que nada avise.

Uso: check_enlaces.py <directorio de la web>
"""
import os
import re
import sys


def main(raiz_web):
    rotos, total = [], 0
    for raiz, _, ficheros in os.walk(raiz_web):
        for fn in ficheros:
            if not fn.endswith(".html"):
                continue
            p = os.path.join(raiz, fn)
            texto = open(p, encoding="utf-8").read()
            for m in re.finditer(r'(?:href|src)="([^"]+)"', texto):
                destino = m.group(1)
                if destino.startswith(("http", "#", "data:", "mailto:")):
                    continue
                total += 1
                fichero, _, ancla = destino.partition("#")
                objetivo = os.path.normpath(os.path.join(raiz, fichero))
                # Pages no convierte el markdown: un enlace a un .md que existe
                # al lado sirve el texto en crudo, y eso tambien esta roto
                if not os.path.exists(objetivo) or fichero.endswith(".md"):
                    rotos.append((p, destino))
                elif ancla and objetivo.endswith(".html") and                         f'id="{ancla}"' not in open(objetivo, encoding="utf-8").read():
                    rotos.append((p, destino + "  (no existe el ancla)"))
    for p, d in rotos:
        print(f"  ROTO  {p}  ->  {d}")
    print(f"{total} enlaces locales comprobados, {len(rotos)} rotos")
    return 1 if rotos else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1] if len(sys.argv) > 1 else "docs"))
