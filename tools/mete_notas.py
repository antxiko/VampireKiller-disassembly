#!/usr/bin/env python3
"""Mete en src/pNN.notes las lineas C, L, B y D escritas a mano.

Van a una seccion "A MANO" de cada banco, que empieza en su cabecera y acaba
donde empieza la siguiente seccion de las herramientas (bloques.py, anota.py),
que no la tocan. Una C o una L en una direccion que ya la tiene en esta
seccion se REEMPLAZA (se corrige), no se duplica: dos C en la misma direccion
se tapan y una se pierde sin avisar.

Formato del fichero de entrada, una por linea:
    pNN C 0xDIRE texto
    pNN L 0xDIRE nombre
    pNN B 0xDIRE texto de bloque
    pNN D 0xDIRE 0xFIN nombre  texto

Uso: mete_notas.py <fichero>
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAB = "# --- A MANO: comentarios, nombres y bloques (cada uno de lo que hace ESE codigo) ---"
OTRAS = ("# --- BLOQUES QUE LEE EL CODIGO", "# --- ANOTACIONES AUTOMATICAS",
         "# --- DATOS DECLARADOS A MANO")


def clave(l):
    p = l.split()
    return (p[0], int(p[1], 0)) if len(p) > 1 and p[0] in ("C", "L") else None


def main(argv):
    por_banco = {}
    for ln in open(argv[1], encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.strip() and not ln.startswith("#"):
            b, resto = ln.split(" ", 1)
            por_banco.setdefault(b, []).append(resto)
    for b, nuevas in por_banco.items():
        ruta = os.path.join(RAIZ, "src", b + ".notes")
        filas = open(ruta, encoding="utf-8").read().split("\n")
        if CAB not in filas:
            k = next((i for i, f in enumerate(filas) if f.startswith(OTRAS)), len(filas))
            filas[k:k] = [CAB, ""]
        ini = filas.index(CAB) + 1
        fin = next((i for i in range(ini, len(filas)) if filas[i].startswith(OTRAS)), len(filas))
        seccion = [f for f in filas[ini:fin] if f.strip()]
        for n in nuevas:
            k = clave(n)
            if k:
                seccion = [s for s in seccion if clave(s) != k]
            seccion.append(n)
        filas[ini:fin] = seccion + [""]
        open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(filas))
        print(b, len(nuevas), "lineas")


if __name__ == "__main__":
    main(sys.argv)
