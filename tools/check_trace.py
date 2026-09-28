#!/usr/bin/env python3
"""Control de sanidad del trazado: detecta cobertura falsa.

Por que existe: al sembrar el trazador con destinos sacados de tablas de
punteros, la cobertura salto del 13% al 80%. Parecia un exito, pero era falso:
cuatro de las semillas eran falsos positivos que apuntaban a zonas de graficos,
y desde ahi el trazador siguio "decodificando" pixeles como instrucciones hasta
marcar como codigo el 100% de la tabla de colores y de los textos del final.

Un desensamblado con ese trazado sigue reensamblando bien (los bytes no cambian,
solo su interpretacion), asi que `make verify` NO lo detecta. Hace falta esta
comprobacion aparte: si una zona que sabemos que son datos aparece como codigo,
el trazado esta contaminado y el listado miente.

Uso: check_trace.py <trace.json> <nocode> [umbral_pct]
"""
import json
import sys


def main(tracepath, nocodepath, umbral=5):
    tr = json.load(open(tracepath))
    zonas = []
    for ln in open(nocodepath):
        txt = ln.split("#")
        campos = txt[0].split()
        if len(campos) >= 2:
            zonas.append((int(campos[0], 0), int(campos[1], 0),
                          txt[1].strip() if len(txt) > 1 else ""))
    if not zonas:
        print("no hay zonas declaradas como datos; nada que comprobar")
        return 0

    # Mapa de que bytes ha marcado el trazador como codigo
    lo = min(a for _, a, b in tr["blocks"] for a in (a,))
    hi = max(b for _, a, b in tr["blocks"])
    cod = bytearray(hi - lo)
    for kind, a, b in tr["blocks"]:
        if kind == "c":
            for i in range(a - lo, b - lo):
                cod[i] = 1

    print(f"Control de sanidad del trazado ({len(zonas)} zonas de datos conocidas)")
    malas = 0
    for a, b, desc in zonas:
        ini, fin = max(a, lo), min(b, hi)
        if fin <= ini:
            continue
        n = sum(cod[ini - lo:fin - lo])
        pct = n * 100 // (fin - ini)
        estado = "ok" if pct <= umbral else "CONTAMINADA"
        if pct > umbral:
            malas += 1
        print(f"  {a:#06x}..{b:#06x}  codigo={pct:3d}%  {estado:12s} {desc}")

    if malas:
        print(f"\nFALLO: {malas} zonas de datos aparecen como codigo. El trazado esta")
        print("contaminado: revisa las semillas de src/*.entries, alguna apunta a datos.")
        return 1
    print("\nOK: ninguna zona de datos conocida se ha marcado como codigo")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1], sys.argv[2],
                  int(sys.argv[3]) if len(sys.argv) > 3 else 5))
