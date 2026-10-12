#!/usr/bin/env python3
"""Coteja el PSG de openMSX (tools/omsx_psg.tcl) con tools/musica.py.

Por cada sonido que el juego pide en la partida grabada (`S nn`), toma las
escrituras al PSG cuadro a cuadro desde ese momento hasta la siguiente
peticion y las compara con las que da musica.py ejecutando el mismo motor desde
cero. Solo cuentan los registros 0-13 (el 14 y el 15 son los del mando). Se
compara el ESTADO del PSG al acabar cada cuadro, partiendo del estado del chip
al pedir la pieza; `ident` cuenta ademas los cuadros con escrituras identicas.

Uso:  coteja_psg.py work/psg/psg.txt [fusiona]
`fusiona`: una peticion repetida del mismo numero no cuenta (el motor la ignora
por prioridad); sin ella, cada peticion reinicia la pieza.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
import musica  # noqa: E402


MIN_CUADROS = 40       # las peticiones mas cortas las pisa la siguiente


def lee(ruta, fusiona=False):
    tramos, actual, cuadro = [], None, None
    psg = [0] * 14
    for ln in open(ruta):
        p = ln.split()
        if not p:
            continue
        if p[0] == "S" and fusiona and actual is not None                 and int(p[1]) == actual[0]:
            continue                # el juego la pide otra vez y el motor no la reinicia
        if p[0] == "S":
            actual = (int(p[1]), list(psg), [])
            tramos.append(actual)
            cuadro = None
        elif p[0] == "F":
            if actual is not None:
                cuadro = []
                actual[2].append(cuadro)
        elif p[0] == "W":
            r, v = int(p[1]), int(p[2])
            if r < 14:
                psg[r] = v
                if cuadro is not None:
                    cuadro.append((r, v))
    return tramos


def main(ruta, fusiona=False):
    rom = open(os.path.join(motor_musica.RAIZ, musica.CFG["rom"]), "rb").read()
    for a, inicial, cuadros in lee(ruta, fusiona):
        if len(cuadros) < MIN_CUADROS:
            continue
        mios, _ = motor_musica.ejecuta(musica.CFG, rom, a,
                                       maximo=len(cuadros) + 1)
        n = min(len(cuadros), len(mios))
        usados = {r for c in mios[:n] for r, _ in c}
        for filtro, nota in ((None, ""), (usados, " (solo los registros que la pieza toca: "
                                          "el resto lo tenia ocupado otro sonido del juego)")):
            ellos, nos = list(inicial), list(inicial)
            distinto = None
            for i in range(n):
                for r, v in cuadros[i]:
                    if r < 14:
                        ellos[r] = v
                for r, v in mios[i]:
                    if r < 14:
                        nos[r] = v
                if distinto is None:
                    for r in range(14):
                        if (filtro is None or r in filtro) and ellos[r] != nos[r]:
                            distinto = (i, list(ellos), list(nos))
                            break
            if distinto is None:
                break
        iguales = sum(1 for i in range(n)
                      if [x for x in cuadros[i] if x[0] < 14]
                      == [x for x in mios[i] if x[0] < 14])
        escr = sum(len(c) for c in cuadros[:n])
        if distinto is None:
            print("0x%02X: %d cuadros (%d escrituras): el PSG IGUAL en todos%s; "
                  "escrituras identicas en %d" % (a, n, escr, nota, iguales))
        else:
            i, e, m = distinto
            print("0x%02X: %d cuadros, el PSG DISTINTO en el %d\n   openMSX %s"
                  "\n   musica  %s" % (a, n, i, e, m))


if __name__ == "__main__":
    main(sys.argv[1], "fusiona" in sys.argv[2:])
