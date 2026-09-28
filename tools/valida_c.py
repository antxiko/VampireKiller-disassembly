#!/usr/bin/env python3
"""Comprueba los comentarios de linea de las notas antes de reensamblar.

Tres cosas, y solo las dos primeras son un fallo:

  - que cada C caiga en el PRIMER BYTE de una instruccion; si cae a media
    instruccion, el comentario no aparece en el listado y nadie se entera;
  - que no haya dos C IDENTICOS para la misma direccion, que es ruido puro;
  - y, ya solo como aviso, cuantas direcciones llevan dos C distintos. Eso
    NO es un fallo: el generador los junta con `; ` y no se pierde ninguno,
    que es justo para lo que se hizo. Pasa cuando un comentario escrito a
    mano cae donde ya habia uno de los automaticos, y muchas veces las dos
    cosas se complementan -el automatico dice QUE direccion es y el de mano
    que se hace con ella aqui-.

El test lo caza igual, pero aqui se ve al momento y con la linea del fichero.

Uso: valida_c.py <asm> <notes> [--arregla] [--avisos]

Con --arregla quita los IDENTICOS dejando el ultimo, y dice cual ha quitado.
Con --avisos ademas lista las direcciones que llevan dos C distintos.
"""
import re
import sys

buenas = set()
for ln in open(sys.argv[1], encoding="utf-8"):
    m = re.match(r"^\t.*;([0-9a-f]{4})", ln)
    if m:
        buenas.add(int(m.group(1), 16))
lineas = open(sys.argv[2], encoding="utf-8").readlines()
arregla = "--arregla" in sys.argv
avisos = "--avisos" in sys.argv
malas, vistos, repes, juntados = [], {}, [], []
for i, ln in enumerate(lineas):
    m = re.match(r"^C 0x([0-9A-Fa-f]{4})\s+(.*)$", ln.rstrip())
    if not m:
        continue
    d, texto = int(m.group(1), 16), m.group(2)
    if d not in buenas:
        malas.append((i + 1, ln.rstrip()))
    if d in vistos:
        if texto in vistos[d][1]:
            repes.append(i)
        else:
            juntados.append(i)
        vistos[d][1].add(texto)
    else:
        vistos[d] = (i, {texto})
for i, ln in malas:
    print("  fuera de sitio, linea %d: %s" % (i, ln))
for i in repes:
    print("  identico%s: %s" % (" (quitado)" if arregla else "", lineas[i].rstrip()))
if avisos:
    for i in juntados:
        print("  se junta: %s" % lineas[i].rstrip())
if arregla and repes:
    for i in sorted(repes, reverse=True):
        del lineas[i]
    open(sys.argv[2], "w", encoding="utf-8").writelines(lineas)
    repes = []
print("  ---- %d fuera de sitio, %d identicos, %d que se juntan"
      % (len(malas), len(repes), len(juntados)))
sys.exit(1 if malas or repes else 0)
