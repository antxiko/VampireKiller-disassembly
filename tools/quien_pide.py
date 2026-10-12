#!/usr/bin/env python3
"""Quien pide cada sonido: busca `ld a,NN` seguido (a <= 3 lineas) de
`call/jp ETIQUETA` en el listado y da, por numero, la rutina que lo pide.

Uso: quien_pide.py LISTADO.asm ETIQUETA [ETIQUETA...]
Salida: NN  rutina(direccion)  comentario de la etiqueta
"""
import re
import sys

LD = re.compile(r"^\s+ld\s+a,\s*(0?[0-9a-fA-F]+)h\b|^\s+ld\s+a,\s*(\d+)\b")


def main(ruta, etiquetas):
    # una direccion como 0x49E9 tambien vale: se busca `call 049e9h`
    dirs = {"0%sh" % e[2:].lower().zfill(4) for e in etiquetas if e.lower().startswith("0x")}
    lineas = open(ruta, encoding="utf-8", errors="replace").read().split("\n")
    etq = None
    comentario = {}
    pide = {}
    dir_etq = {}
    for i, l in enumerate(lineas):
        m = re.match(r"^([A-Za-z_][\w]*):(?:\s*;\s*(.*))?", l)
        if m:
            etq = m.group(1)
            comentario[etq] = (m.group(2) or "").strip()
        m = re.match(r"^\s+ld\s+a,\s*0([0-9a-fA-F]+)h", l)
        if not m:
            continue
        n = int(m.group(1), 16)
        for j in range(i + 1, min(i + 4, len(lineas))):
            c = re.match(r"^\s+(?:call|jp)\s+(?:\w+,)?\s*(\w+)", lineas[j])
            if c and (c.group(1) in etiquetas or c.group(1).lower() in dirs):
                pide.setdefault(n, []).append(etq)
                break
            if re.match(r"^\s+(?:call|jp|ret|jr|djnz)", lineas[j]):
                break
    for n in sorted(pide):
        quien = sorted(set(pide[n]), key=pide[n].index)
        print("0x%02X  %s" % (n, "; ".join(
            "%s (%s)" % (q, comentario.get(q, "")[:70]) for q in quien[:4])))


if __name__ == "__main__":
    main(sys.argv[1], set(sys.argv[2:]))
