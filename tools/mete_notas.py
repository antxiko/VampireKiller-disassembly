#!/usr/bin/env python3
"""Mete en el fichero de notas de un banco las lineas de otro fichero.

    python3 tools/mete_notas.py <banco> <fichero con lineas L/C/B/D/F>

    banco: 00..15, o el nombre del fichero (src/p03.notes)

Comentar es una tanda larga, y las anotaciones se escriben aparte para no tocar
el fichero bueno hasta tener el lote entero. Esto las mezcla:

  - una C en una direccion que ya tiene C la SUSTITUYE (se esta corrigiendo);
  - una L en una direccion que ya tiene L la sustituye tambien;
  - las B se anaden, que un bloque puede tener varias lineas;
  - y todo queda ordenado por direccion, con el orden B, L, D, F, C dentro de
    cada una, que es el que espera mkasm.

Aqui hay DIECISEIS ficheros de notas, uno por banco, porque cada banco se
ensambla en su propio org. La direccion de una linea tiene que caer dentro del
banco al que se mete, y esto lo comprueba: un comentario en el banco que no es
no llegaria nunca al listado.

Al acabar dice cuantas habia y cuantas hay, para que se vea el efecto.
"""
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ORDEN = {"B": 0, "L": 1, "D": 2, "F": 3, "C": 4}

# Donde ejecuta cada banco; la misma tabla que tools/paginas.py.
ORG = {"00": 0x4000, "01": 0x6000, "02": 0x8000, "03": 0xA000,
       "04": 0x6000, "05": 0x8000, "06": 0xA000, "07": 0x8000,
       "08": 0xA000, "09": 0x8000, "10": 0xA000, "11": 0x8000,
       "12": 0xA000, "13": 0x8000, "14": 0x8000, "15": 0x8000}


def clave(l):
    p = l.split()
    return (int(p[1], 0), ORDEN.get(p[0], 9))


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    banco = sys.argv[1]
    if banco.endswith(".notes"):
        notas = banco if os.path.exists(banco) else os.path.join(RAIZ, banco)
        banco = os.path.basename(notas)[1:3]
    else:
        notas = os.path.join(RAIZ, "src", "p%s.notes" % banco)
    if banco not in ORG:
        raise SystemExit("banco desconocido: %s" % banco)
    ini = ORG[banco]
    fin = ini + 0x2000

    nuevas = [l.rstrip("\n") for l in open(sys.argv[2], encoding="utf-8")
              if l.strip() and not l.lstrip().startswith("#")]
    for l in nuevas:
        if not re.match(r"^[BLDFC] 0x[0-9A-Fa-f]+", l):
            raise SystemExit("linea que no es una directiva: %s" % l[:70])
        a = int(l.split()[1], 0)
        if not ini <= a < fin:
            raise SystemExit("0x%04X no cae en el banco %s (0x%04X..0x%04X): %s"
                             % (a, banco, ini, fin, l[:70]))

    viejas = open(notas, encoding="utf-8").read().splitlines()
    cabecera = [l for l in viejas if l.startswith("#")]
    cuerpo = [l for l in viejas if l.strip() and not l.startswith("#")]

    pisa = {(l.split()[0], l.split()[1].lower()) for l in nuevas
            if l.split()[0] in ("C", "L")}
    antes = len(cuerpo)
    cuerpo = [l for l in cuerpo
              if (l.split()[0], l.split()[1].lower()) not in pisa]
    cuerpo += nuevas
    cuerpo.sort(key=clave)
    open(notas, "w", encoding="utf-8").write("\n".join(cabecera + cuerpo) + "\n")
    print("  p%s: %d lineas -> %d (%d nuevas, %d sustituidas)"
          % (banco, antes, len(cuerpo), len(nuevas),
             antes + len(nuevas) - len(cuerpo)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
