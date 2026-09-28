#!/usr/bin/env python3
"""Cruza TODAS las zonas declaradas como datos contra lo que el trazador cree.

Por que hace falta, y por que no basta con check_trace.py: aquel vigila las
zonas del fichero .nocode, que son un punado. Pero las zonas de datos de verdad
estan declaradas con directivas `D` en los ficheros de notas, y son decenas. Si
una semilla mal puesta mete al trazador dentro de una de ellas, el listado
desensambla datos como si fueran instrucciones y la cobertura sube contando
mentiras.

No es hipotetico. En esta serie de desensamblados, una semilla mal puesta llego
a hacer leer como codigo el 95 % de una banda sonora, y fue la TERCERA vez que
un proyecto publico una cobertura inflada por la misma clase de error.

Lo que hace: para cada rango `D` del fichero de notas, mira cuantos de sus bytes caen
en bloques que el trazado marca como codigo, y avisa. Un solapamiento pequeno
puede ser legitimo -una tabla que empieza justo donde acaba una rutina, un rango
declarado con holgura-, asi que se ordena por gravedad y se da el porcentaje,
que es lo que distingue un byte de borde de una zona entera mal leida.

Uso:  check_datos_como_codigo.py <dir_work> <dir_src> [--umbral N]
Codigo de salida 1 si alguna zona supera el umbral (por defecto, 16 bytes).
"""
import json
import os
import re
import sys

from paginas import nombre, N_PAGINAS

# Un modulo por pagina del MegaROM: p00..p15, cada uno con su trazado y sus
# notas. Las direcciones se repiten entre paginas, asi que el cruce se hace
# pagina a pagina, nunca mezclando las notas de una con el trazado de otra.
MODULOS = tuple(nombre(p) for p in range(N_PAGINAS))


def declaraciones(notas):
    """Los rangos `D 0xAAAA 0xBBBB descripcion` del fichero de notas."""
    if not os.path.exists(notas):
        return []
    fuera = []
    for linea in open(notas, encoding="utf-8"):
        m = re.match(r"D 0x([0-9A-Fa-f]{4}) 0x([0-9A-Fa-f]{4})\s*(.*)", linea)
        if m:
            fuera.append((int(m.group(1), 16), int(m.group(2), 16),
                          m.group(3).strip()))
    return fuera


def codigo(trace):
    with open(trace, encoding="utf-8") as f:
        d = json.load(f)
    return [(a, b) for t, a, b in d["blocks"] if t == "c"]


def main(work, src, *resto):
    umbral = 16
    for a in resto:
        if a.startswith("--umbral"):
            umbral = int(a.split("=")[1])

    sospechosas = []
    total_zonas = 0
    for m in MODULOS:
        trace = os.path.join(work, m + ".trace.json")
        notas = os.path.join(src, m + ".notes")
        if not os.path.exists(trace):
            continue
        bloques = codigo(trace)
        for ini, fin, desc in declaraciones(notas):
            total_zonas += 1
            solapa = sum(min(b, fin) - max(a, ini)
                         for a, b in bloques if min(b, fin) > max(a, ini))
            if solapa:
                sospechosas.append((solapa, 100.0 * solapa / max(1, fin - ini),
                                    m, ini, fin, desc))

    print("Cruzando %d zonas de datos declaradas contra el trazado." % total_zonas)
    if not sospechosas:
        print("  OK: ninguna zona declarada como datos aparece como codigo")
        return 0

    graves = [s for s in sospechosas if s[0] >= umbral]
    print("  %d zonas se solapan con codigo; %d por encima del umbral (%d B)" % (
        len(sospechosas), len(graves), umbral))
    print()
    for solapa, pct, m, ini, fin, desc in sorted(sospechosas, reverse=True)[:20]:
        marca = "GRAVE " if solapa >= umbral else "  roce"
        print("  %s %-7s 0x%04X-0x%04X  %5d B de %5d como codigo (%5.1f %%)  %s" % (
            marca, m, ini, fin - 1, solapa, fin - ini, pct, desc[:44]))
    if graves:
        print()
        print("  Una zona entera leida como codigo es cobertura FALSA: hay una")
        print("  semilla metida dentro. Un roce de pocos bytes suele ser un")
        print("  rango declarado con holgura, y se arregla ajustando el rango.")
    return 1 if graves else 0


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
