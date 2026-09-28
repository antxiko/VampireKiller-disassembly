#!/usr/bin/env python3
"""Declara los bloques de datos que el codigo LEE, recorriendolos como el cartucho.

Un rango de datos no se declara porque sobre: se declara porque hay una
instruccion que lo lee. Casi siempre es una llamada a uno de los lectores del
banco 0, y el trazador de cartucho entero (tools/bancos.py) sabe, para cada
llamada, que valen HL y DE y que bancos hay en cada ranura. Con eso:

  1. se coge el puntero que el lector va a leer;
  2. el banco al que cae sale del reparto de ese momento, no de suponerlo;
  3. el final sale de RECORRER el formato como lo recorre el lector, o de la
     cuenta que le pasa quien llama (B, BC), leida en el listado.

Los lectores del banco 0 (todos escriben en la VRAM del V9938, SCREEN 5):

  dibujos  0x4A66  HL fuente, B dibujos de 8x8 a 4 bits: 32 bytes cada uno.
                   0x4A51 sube uno: ocho filas de 4 bytes, saltando 128 en
                   la VRAM, que es lo que mide una linea en SCREEN 5.
  letras   0x4A27  HL fuente, B caracteres de 8x8 a 1 bit (8 bytes cada uno);
                   0x4AA5 los pinta de color al vuelo. 0x4A30 hace uno solo.
  rle      0x46F1  DE fuente (HL ya trae el destino): 0x00 acaba; 0x80 da
                   otro destino (dos bytes, por 0x46EB); bit 7 puesto, van tal
                   cual los siete de abajo; bit 7 claro, se repite el byte
                   que viene esas veces.
           0x46EB  lo mismo, pero el destino va delante.
  guion    0x4714  HL fuente, mandos: 0xFF acaba; 0x00 [fuente][destino] es
                   un rle aparte (0x472E: DE la fuente, HL el destino); 0x01 [origen][n][destino] da la vuelta a n
                   dibujos que YA estan en la VRAM (no lee cartucho); lo demas
                   es [fuente][largo][destino], copia en crudo por 0x4675.
  crudo    0x4675  HL fuente, BC bytes tal cual (DE es el destino en VRAM).

Lo que sale se escribe, banco a banco, en una seccion delimitada de
src/pNN.notes que esta herramienta reescribe entera; lo de fuera no lo toca.
Un bloque que pise codigo trazado o una D escrita a mano NO se escribe: se
avisa, porque algo esta mal y hay que mirarlo.

Uso: bloques.py              informa de lo que encontraria
     bloques.py --escribe    y lo escribe en las notas
"""
import json
import os
import re
import sys
from collections import defaultdict

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from bancos import traza_completa, Cartucho                  # noqa: E402
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre        # noqa: E402

ROM = os.path.join(RAIZ, "vampirekiller.rom")
SRC = os.path.join(RAIZ, "src")
WORK = os.path.join(RAIZ, "work")

INI = "# --- BLOQUES QUE LEE EL CODIGO (seccion que reescribe tools/bloques.py; no editar a mano) ---"
FIN = "# --- fin de los bloques de bloques.py ---"


class FueraDelBanco(Exception):
    pass


def banco_de(a, s):
    b = Cartucho.banco(a, s)
    if b is None or b >= N_PAGINAS:
        raise FueraDelBanco("0x%04X no cae en el cartucho con %s" % (a, s))
    return b


def byte(rom, s, a):
    return rom[banco_de(a, s) * TAM_PAGINA + (a & 0x1FFF)]


def palabra(rom, s, a):
    return byte(rom, s, a) | (byte(rom, s, a + 1) << 8)


def trozos(s, a, f):
    """[a, f) de la ventana del Z80, partido por bancos: [(banco, ini, fin)]."""
    fuera = []
    while a < f:
        corte = min(f, (a & 0xE000) + TAM_PAGINA)
        fuera.append((banco_de(a, s), a, corte))
        a = corte
    return fuera


# ------------------------------------------------------------------ registro
class Bloques:
    """{banco: {(ini, fin): {"nom", "que", "desde": set, "ancho"}}}"""

    def __init__(self):
        self.d = defaultdict(dict)
        self.avisos = []

    def anota(self, s, a, f, nom, que, quien, ancho=16):
        if a < 0xC000 < f:
            # p00:54E4: el ultimo dibujo se sale del cartucho y lo que falta
            # lo lee de la RAM de 0xC000 en adelante
            que += "; se sale de la ventana del cartucho: los ultimos %d bytes los lee "                    "de la RAM, de 0xC000 a 0x%04X" % (f - 0xC000, f - 1)
            f = 0xC000
        for b, i, j in trozos(s, a, f):
            e = self.d[b].setdefault((i, j), {"nom": nom if i == a else "%s_cola" % nom,
                                              "que": que, "desde": set(), "ancho": ancho})
            e["desde"].add(quien)
            if i != a:
                e["que"] = "%s (sigue del banco anterior, 0x%04X)" % (que, a)


# ------------------------------------------------------------------ listado
_LISTADO = {}


def listado(p):
    """[(dir, texto)] de las instrucciones del listado del banco p."""
    if p not in _LISTADO:
        ruta = os.path.join(SRC, "vampirekiller_p%02d.asm" % p)
        filas = []
        for ln in open(ruta, encoding="utf-8"):
            m = re.match(r"\t([a-z][^\t;]*)\t+;([0-9a-f]{4})", ln)
            if m:
                filas.append((int(m.group(2), 16), m.group(1).strip()))
        _LISTADO[p] = filas
    return _LISTADO[p]


def num(txt):
    txt = txt.strip()
    if txt.endswith("h"):
        return int(txt[:-1], 16)
    return int(txt, 0)


def registro_antes(p, pc, reg, hasta=10):
    """El valor constante de B, C o BC cargado justo antes de pc, o None.

    Se miran hacia atras las instrucciones del listado; si alguna otra toca el
    registro antes de encontrar su `ld`, no se sabe.
    """
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    for a, t in reversed(filas[max(0, idx - hasta):idx]):
        if t.startswith(("call", "jp", "jr", "ret", "djnz")):
            return None
        m = re.match(r"ld (bc|b|c),([0-9a-f]+h|\d+)$", t)
        if m:
            r, v = m.group(1), num(m.group(2))
            if r == reg:
                return v
            if r == "bc":
                return {"b": v >> 8, "c": v & 0xFF}.get(reg)
            continue
        if re.match(r"(ld|inc|dec|pop|ex|exx|add|sub|and|or|xor)\b.*\b%s\b" % reg[0], t) and reg != "bc":
            if re.match(r"ld [^,]+,%s$" % reg, t):
                continue            # solo lo lee
            return None
    return None


def tabla_antes(p, pc):
    """Si pc lee su puntero de una tabla indexada, la base de esa tabla.

    El patron es el de siempre en este cartucho: `ld hl,TABLA / call 0x4061
    (hl += a) / ld e,(hl) / inc hl / ld d,(hl)` y, a lo sumo, un `ld hl,nn`
    o `ex de,hl` antes del lector.
    """
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    txt = [t for _, t in filas[max(0, idx - 8):idx]]
    for k in range(len(txt)):
        m = re.match(r"ld hl,([0-9a-f]+h)$", txt[k])
        if not m:
            continue
        # entre el `ld hl` y el `call 0x4061` puede ir el calculo del indice
        # (`ld a,(0xD000) / add a,a`), que no toca HL
        for j in range(k + 1, min(k + 4, len(txt) - 3)):
            if txt[j] in ("call L_4061", "call 04061h", "call hl_mas_a"):
                if txt[j + 1] == "ld e,(hl)" and txt[j + 2] == "inc hl" and txt[j + 3] == "ld d,(hl)":
                    return num(m.group(1))
                break
            if "hl" in txt[j] or txt[j].startswith(("call", "jp", "jr")):
                break
    return None


def punteros_de_tabla(rom, s, base, limite=None):
    """Las palabras de una tabla de punteros: hasta el primer destino, hasta una
    palabra que no apunte a la ventana del cartucho, o hasta `limite`."""
    ptrs, a = [], base
    tope = limite or base + 512
    while a < tope:
        w = palabra(rom, s, a)
        if not 0x4000 <= w < 0xC000:
            break
        ptrs.append(w)
        a += 2
        if base < min(ptrs) <= a + 1:
            break
        tope = min(tope, min(p for p in ptrs if p > base) if any(p > base for p in ptrs) else tope)
    return ptrs


# ------------------------------------------------------------------ formatos
def fin_rle(rom, s, a, con_destino):
    """Recorre un rle como 0x46EB/0x46F1 y devuelve el primer byte de fuera."""
    if con_destino:
        a += 2
    for _ in range(20000):
        n = byte(rom, s, a)
        a += 1
        if n == 0:
            return a
        if n & 0x80:
            k = n & 0x7F
            a += 2 if k == 0 else k
        else:
            a += 1
    raise FueraDelBanco("rle sin fin desde 0x%04X" % a)


def fin_filas(rom, s, a):
    """0x582D: 32 filas; cada una un byte n (ceros por la izquierda) y 12 - n
    bytes de dibujo. Rellena con ceros hasta 16 por fila en 0xE800."""
    for _ in range(32):
        n = byte(rom, s, a)
        if n > 12:
            raise FueraDelBanco("fila con %d ceros en 0x%04X" % (n, a))
        a += 1 + 12 - n
    return a


FUENTE = {0x00: " ", 0x30: "-"}
FUENTE.update({0x31 + i: chr(0x41 + i) for i in range(26)})


def texto(rom, s, a, f):
    """Lo que dicen los bytes de [a, f) con la fuente del juego (la A es 0x31)."""
    return "".join(FUENTE.get(byte(rom, s, x), "{%02X}" % byte(rom, s, x)) for x in range(a, f))


def recorre_rotulo(rom, s, a):
    """0x4ACB: [x][y] y caracteres; 0xFE da otra posicion, 0xFF acaba.
    Devuelve (fin, [textos])."""
    textos = []
    while True:
        a += 2
        ini = a
        while byte(rom, s, a) not in (0xFE, 0xFF):
            a += 1
        textos.append(texto(rom, s, ini, a))
        if byte(rom, s, a) == 0xFF:
            return a + 1, textos
        a += 1


def recorre_rotulo_de(rom, s, a):
    """p01:7B32: caracteres; 0xFE [dx] baja una fila y corre dx; 0xFF acaba."""
    textos, ini = [], a
    while True:
        c = byte(rom, s, a)
        if c == 0xFF:
            textos.append(texto(rom, s, ini, a))
            return a + 1, textos
        if c == 0xFE:
            textos.append(texto(rom, s, ini, a))
            a += 2
            ini = a
            continue
        a += 1


def recorre_guion(rom, s, a, bl, quien, nom):
    """El guion de 0x4714: anota el guion y lo que manda leer."""
    ini = a
    for _ in range(500):
        m = byte(rom, s, a)
        a += 1
        if m == 0xFF:
            break
        if m == 0x00:
            fuente, dest = palabra(rom, s, a), palabra(rom, s, a + 2)
            a += 4
            f = fin_rle(rom, s, fuente, False)
            bl.anota(s, fuente, f, "rle_%04X" % fuente,
                     "rle a la VRAM 0x%04X, mandado por el guion de 0x%04X" % (dest, ini),
                     "guion 0x%04X" % ini)
        elif m == 0x01:
            a += 5
        else:
            fuente, largo, dest = palabra(rom, s, a), palabra(rom, s, a + 2), palabra(rom, s, a + 4)
            a += 6
            bl.anota(s, fuente, fuente + largo, "crudo_%04X" % fuente,
                     "%d bytes tal cual a la VRAM 0x%04X, mandados por el guion de 0x%04X"
                     % (largo, dest, ini), "guion 0x%04X" % ini)
    bl.anota(s, ini, a, nom, "guion de carga de la VRAM que interpreta 0x4714 (0xFF acaba)", quien)


# ------------------------------------------------------------------ recorridos
def dibujos_de_cada_fase(rom, t, bl):
    """p00:5657: la tabla de 0x5742 da, por fase, de donde salen sus 191 dibujos.

    0x564C pone los bancos 4-5-6 y, desde la fase 13 (`cp 0x0D / call nc`), el
    7 y el 8 en 0x8000 y 0xA000. Luego `ld de,0x8004 / ld b,0xBF / call 0x4A66`.
    """
    base = 0x5742
    s0 = (1, 2, 3)
    ptrs = [palabra(rom, s0, base + 2 * i) for i in range(19)]
    bl.anota(s0, base, base + 38, "dibujos_de_cada_fase",
             "19 punteros, uno por fase (0 el patio, 1-18): de donde salen los 191 dibujos "
             "de 8x8 de su decorado; los lee p00:565B con la fase de 0xD000", "p00:565B")
    for fase, w in enumerate(ptrs):
        s = (4, 5, 6) if fase < 13 else (4, 7, 8)
        fin = w + 191 * 32
        que = "191 dibujos de 8x8 a 4 bits (32 bytes cada uno) del decorado"
        if w < 0xB473 < fin:
            # los ultimos quince que se suben para las fases 10-12 son en
            # realidad la tabla de sprites de p01:6445: se suben, pero no son
            # dibujos
            fin = 0xB473
            que += ("; se suben 191, pero los 15 ultimos (0xB473-0xB652) son la tabla de "
                    "sprites de p01:6445, no dibujos")
        bl.anota(s, w, fin, "dibujos_%04X" % w, que, "fase %d" % fase, ancho=32)
    # p00:5670 entra en la misma subida con los bancos 9 y 10 y HL=0x8000
    # (`call 0x537A / ld hl,0x8000 / jr 0x5665`)
    bl.anota((1, 9, 10), 0x8000, 0x8000 + 191 * 32, "dibujos_8000",
             "191 dibujos de 8x8 a 4 bits (32 bytes cada uno) que sube p00:5670 por el "
             "mismo camino que los de las fases", "p00:5670", ancho=32)


LECTORES = {
    0x4A66: ("dibujos", "hl"),
    0x4A27: ("letras", "hl"),
    0x4A30: ("letra", "hl"),
    0x46F1: ("rle", "de"),
    0x46EB: ("rle_dest", "de"),
    0x4714: ("guion", "hl"),
    0x4675: ("crudo", "hl"),
    0x4A90: ("dibujos16", "hl"),
    0x498A: ("hmmc", "hl"),
    0x582D: ("filas", "hl"),
    0x483E: ("paleta", "hl"),
    0x4ACB: ("rotulo", "hl"),
    0x4ACF: ("rotulo_borra", "hl"),
    0x5D90: ("rotulo", "hl"),
    0x7B32: ("rotulo_de", "hl"),
}
# Los lectores se llaman entre ellos: esas llamadas no traen un puntero nuevo.
DENTRO_DE_LOS_LECTORES = (0x4600, 0x4900)
DENTRO_2 = (0x4A00, 0x4AD0)


def llamadas_a_lectores(rom, t, bl):
    # primero las bases de todas las tablas indexadas: una acaba donde empieza
    # la siguiente (0xA281 y 0xA2D1 van pegadas)
    bases = sorted({tabla_antes(b, pc) for dest, b, pc, s, hl, de in t.llamadas
                    if dest in LECTORES} - {None})
    for dest, b, pc, s, hl, de in t.llamadas:
        if dest not in LECTORES or b != 0 and False:
            continue
        if b == 0 and (DENTRO_DE_LOS_LECTORES[0] <= pc < DENTRO_DE_LOS_LECTORES[1]
                       or DENTRO_2[0] <= pc < DENTRO_2[1]):
            continue
        fmt, reg = LECTORES[dest]
        quien = "%s:%04X" % (nombre(b), pc)
        ptr = hl if reg == "hl" else de
        if ptr is not None and ptr >= 0xC000:
            continue                # la fuente esta en RAM: no es del cartucho
        if ptr is None:
            base = tabla_antes(b, pc)
            if base is None or fmt not in ("rle", "rle_dest", "guion", "paleta"):
                if (b, pc) not in DE_LOS_RECORRIDOS:
                    bl.avisos.append("%s -> %s: puntero sin saber" % (quien, fmt))
                continue
            try:
                sig = [x for x in bases if x > base and (x & 0xE000) == (base & 0xE000)]
                ptrs = punteros_de_tabla(rom, s, base, sig[0] if sig else None)
                bl.anota(s, base, base + 2 * len(ptrs), "tabla_%04X" % base,
                         "%d punteros a %s que lee %s" % (len(ptrs), fmt, quien), quien, ancho=2)
                for w in sorted(set(ptrs)):
                    if fmt == "guion":
                        recorre_guion(rom, s, w, bl, quien, "guion_%04X" % w)
                    elif fmt == "paleta":
                        bl.anota(s, w, fin_paleta(rom, s, w), "paleta_%04X" % w,
                                 "cambios de paleta ([color][RB][G], 0xFF acaba), de la tabla "
                                 "de 0x%04X" % base, quien, ancho=3)
                    else:
                        bl.anota(s, w, fin_rle(rom, s, w, fmt == "rle_dest"), "rle_%04X" % w,
                                 "rle a la VRAM, de la tabla de 0x%04X" % base, quien)
            except FueraDelBanco as e:
                bl.avisos.append("%s -> %s tabla 0x%04X: %s" % (quien, fmt, base, e))
            continue
        try:
            if fmt == "dibujos":
                n = registro_antes(b, pc, "b")
                if n is None:
                    bl.avisos.append("%s -> dibujos 0x%04X: B sin saber" % (quien, ptr))
                    continue
                bl.anota(s, ptr, ptr + 32 * n, "dibujos_%04X" % ptr,
                         "%d dibujos de 8x8 a 4 bits (32 bytes cada uno)" % n, quien, ancho=32)
            elif fmt == "dibujos16":
                n = registro_antes(b, pc, "b")
                if n is None:
                    bl.avisos.append("%s -> dibujos16 0x%04X: B sin saber" % (quien, ptr))
                    continue
                bl.anota(s, ptr, ptr + 128 * n, "dibujos16_%04X" % ptr,
                         "%d dibujos de 16x16 a 4 bits (128 bytes cada uno, 0x4A7B los sube "
                         "en dieciseis filas de 8)" % n, quien, ancho=8)
            elif fmt == "hmmc":
                bc = registro_antes(b, pc, "bc")
                if bc is None:
                    bl.avisos.append("%s -> hmmc 0x%04X: BC sin saber" % (quien, ptr))
                    continue
                n = (bc >> 8) * (bc & 0xFF) // 2
                bl.anota(s, ptr, ptr + n, "hmmc_%04X" % ptr,
                         "%dx%d puntos a 4 bits (%d bytes) que 0x498A manda al V9938 con una "
                         "orden HMMC" % (bc >> 8, bc & 0xFF, n), quien, ancho=8)
            elif fmt == "filas":
                bl.anota(s, ptr, fin_filas(rom, s, ptr), "filas_%04X" % ptr,
                         "dibujo de 32 filas para 0x582D: por fila, cuantos ceros van a la "
                         "izquierda y los 12 - n bytes de dibujo (se completa a 16 en 0xE800)",
                         quien)
            elif fmt == "paleta":
                bl.anota(s, ptr, fin_paleta(rom, s, ptr), "paleta_%04X" % ptr,
                         "cambios de paleta ([color][RB][G], 0xFF acaba) que escribe 0x483E en "
                         "el registro 16 del V9938 y en la copia de 0xF680", quien, ancho=3)
            elif fmt in ("rotulo", "rotulo_borra", "rotulo_de"):
                fin, txts = (recorre_rotulo_de if fmt == "rotulo_de" else recorre_rotulo)(rom, s, ptr)
                bl.anota(s, ptr, fin, "rotulo_%04X" % ptr,
                         "%s: \"%s\"" % (
                             "rotulo para p01:7B32 (0xFE [dx] baja una fila, 0xFF acaba)"
                             if fmt == "rotulo_de" else
                             "rotulo para 0x4ACB ([x][y] y el texto; 0xFE otra posicion, 0xFF acaba)",
                             " / ".join(txts)), quien)
            elif fmt == "letras":
                n = registro_antes(b, pc, "b")
                if n is None:
                    bl.avisos.append("%s -> letras 0x%04X: B sin saber" % (quien, ptr))
                    continue
                bl.anota(s, ptr, ptr + 8 * n, "letras_%04X" % ptr,
                         "%d caracteres de 8x8 a 1 bit (8 bytes cada uno) que 0x4AA5 pinta "
                         "de color al subirlos" % n, quien, ancho=8)
            elif fmt == "letra":
                bl.anota(s, ptr, ptr + 8, "letra_%04X" % ptr,
                         "un caracter de 8x8 a 1 bit", quien, ancho=8)
            elif fmt in ("rle", "rle_dest"):
                f = fin_rle(rom, s, ptr, fmt == "rle_dest")
                bl.anota(s, ptr, f, "rle_%04X" % ptr,
                         "rle a la VRAM (0x00 acaba, 0x80 otro destino, 1nnnnnnn van tal cual, "
                         "0nnnnnnn repite el que viene)%s" % (", con el destino delante"
                                                               if fmt == "rle_dest" else ""),
                         quien)
            elif fmt == "guion":
                recorre_guion(rom, s, ptr, bl, quien, "guion_%04X" % ptr)
            elif fmt == "crudo":
                n = registro_antes(b, pc, "bc")
                if n is None:
                    bl.avisos.append("%s -> crudo 0x%04X: BC sin saber" % (quien, ptr))
                    continue
                bl.anota(s, ptr, ptr + n, "crudo_%04X" % ptr,
                         "%d bytes tal cual a la VRAM" % n, quien)
        except FueraDelBanco as e:
            bl.avisos.append("%s -> %s 0x%04X: %s" % (quien, fmt, ptr, e))


def fin_paleta(rom, s, a):
    """0x483E: [color][RB][G] hasta un 0xFF."""
    for _ in range(17):
        if byte(rom, s, a) == 0xFF:
            return a + 1
        a += 3
    raise FueraDelBanco("paleta sin 0xFF en 0x%04X" % a)


def habitaciones(rom, t, bl):
    """p00:5783: lo que se carga al entrar en cada habitacion.

    Con los bancos 9 y 10 puestos, 0x9AB0 tiene un puntero por fase (1-18) a
    una subtabla con una entrada de cuatro bytes por habitacion (0xD001):
    [guion de 0x4714][paleta de 0x483E]. Las subtablas van seguidas, asi que
    cada una acaba donde empieza la siguiente, y la ultima donde empieza el
    primer guion. La fase 0 no pasa por aqui: p00:57B7 carga el guion de
    0x9FED y nada mas.
    """
    s = (1, 9, 10)
    base = 0x9AB0
    ptrs = [palabra(rom, s, base + 2 * i) for i in range(18)]
    bl.anota(s, base, base + 36, "habitaciones_de_cada_fase",
             "18 punteros, uno por fase (1-18), a su tabla de habitaciones; los lee p00:5790",
             "p00:5786")
    guiones = set()
    paletas = set()
    # la ultima subtabla acaba donde empieza el primer guion de las de antes
    primer_guion = min(palabra(rom, s, a) for a in range(ptrs[0], ptrs[-1], 4))
    for i, w in enumerate(ptrs):
        fin = ptrs[i + 1] if i + 1 < len(ptrs) else primer_guion
        n = (fin - w) // 4
        bl.anota(s, w, fin, "habitaciones_fase_%d" % (i + 1),
                 "las %d habitaciones de la fase %d: [guion de 0x4714][paleta de 0x483E] "
                 "por habitacion (0xD001)" % (n, i + 1), "p00:5794", ancho=4)
        for k in range(n):
            guiones.add(palabra(rom, s, w + 4 * k))
            paletas.add(palabra(rom, s, w + 4 * k + 2))
    for g in sorted(guiones):
        recorre_guion(rom, s, g, bl, "p00:57A5 (habitacion)", "guion_%04X" % g)
    for pa in sorted(paletas):
        bl.anota(s, pa, fin_paleta(rom, s, pa), "paleta_%04X" % pa,
                 "cambios de paleta ([color][RB][G], 0xFF acaba) que pone 0x483E al entrar "
                 "en la habitacion", "p00:57AE", ancho=3)


def tabla_5421(rom, t, bl):
    """p00:53FC: seis dibujos de 8x8 por HMMC, sus punteros en 0x5421.

    `ld hl,0x5421 / ld b,6` y en el bucle `ld a,(hl) / inc hl / ld h,(hl) /
    ld l,a / ld bc,0x0808 / call 0x498A`: 32 bytes cada uno.
    """
    s = (1, 2, 3)
    ptrs = [palabra(rom, s, 0x5421 + 2 * i) for i in range(6)]
    bl.anota(s, 0x5421, 0x542D, "tabla_5421",
             "6 punteros a dibujos de 8x8 que pinta p00:5412 por HMMC", "p00:5402", ancho=2)
    for w in sorted(set(ptrs)):
        bl.anota(s, w, w + 32, "hmmc_%04X" % w,
                 "8x8 puntos a 4 bits (32 bytes) para la orden HMMC de 0x498A", "p00:5412", ancho=8)


def mapas(rom, t, bl):
    """p00:4FB6: el decorado de cada habitacion, con los bancos 11-12-13.

    - 0x6000: 19 bytes, uno por fase, con el numero de su primera habitacion.
    - 0x6013: un puntero por habitacion; se entra con (0x6000 + fase) + la
      habitacion de 0xC5D7, por dos.
    - cada habitacion: 8 x 6 bytes (48), uno por bloque de 32x32 puntos.
    - 0x7EBB: por fase, el juego de bloques; cada bloque son 16 bytes, 4 x 4
      dibujos de 8x8, que 0x5020 copia de cuatro en cuatro (`ldi` x4) a filas
      de 32.
    - Con 0xC41A distinto de cero no hay tabla: la habitacion es la de 0x614B
      y los bloques salen de 0xA041 (p00:4FD0 y p00:5001).
    """
    s = (11, 12, 13)
    prim = [byte(rom, s, 0x6000 + i) for i in range(19)]
    npt = (0x614B - 0x6013) // 2
    ptrs = [palabra(rom, s, 0x6013 + 2 * i) for i in range(npt)]
    bl.anota(s, 0x6000, 0x6013, "primera_habitacion_de_cada_fase",
             "19 bytes: el numero de la primera habitacion de cada fase en la tabla de 0x6013",
             "p00:4FDC", ancho=19)
    bl.anota(s, 0x6013, 0x614B, "habitaciones",
             "%d punteros, uno por habitacion de todo el castillo, a sus 8x6 bloques" % npt,
             "p00:4FEC", ancho=2)
    juegos = [palabra(rom, s, 0x7EBB + 2 * i) for i in range(19)]
    bl.anota(s, 0x7EBB, 0x7EE1, "bloques_de_cada_fase",
             "19 punteros, uno por fase, al juego de bloques de 32x32 de su decorado",
             "p00:500D", ancho=2)
    usados = defaultdict(int)
    for f in range(19):
        fin = prim[f + 1] if f + 1 < 19 else npt
        for h in range(prim[f], fin):
            w = ptrs[h]
            celdas = [byte(rom, s, w + i) for i in range(48)]
            bl.anota(s, w, w + 48, "habitacion_%d" % h,
                     "fase %d, habitacion %d: 8 x 6 bloques de 32x32 del juego de 0x%04X"
                     % (f, h - prim[f], juegos[f]), "p00:4FF9", ancho=8)
            usados[juegos[f]] = max(usados[juegos[f]], max(celdas) + 1)
    especial = [byte(rom, s, 0x614B + i) for i in range(48)]
    bl.anota(s, 0x614B, 0x617B, "habitacion_especial",
             "la habitacion que se monta con 0xC41A puesto (p00:4FD0): 8 x 6 bloques del "
             "juego de 0xA041", "p00:4FD0", ancho=8)
    usados[0xA041] = max(usados[0xA041], max(especial) + 1)
    for j, n in sorted(usados.items()):
        bl.anota(s, j, j + 16 * n, "bloques_%04X" % j,
                 "%d bloques de 32x32 (16 bytes cada uno: 4 x 4 dibujos de 8x8); tantos como "
                 "el indice mas alto que usan sus habitaciones" % n, "p00:5010", ancho=16)


def salidas_y_puertas(rom, t, bl):
    """Las tres tablas que lee el codigo del banco 13 (se llama con 11-12-13).

    - 0xB9D3 (p13:B9BD): un puntero por fase a sus habitaciones, dos bytes
      por habitacion (0xD001): cuatro nibbles, la habitacion a la que se sale
      por cada lado; 0xF es que por ahi no hay salida (p13:B984 y p13:B9AD).
      Cuantas habitaciones tiene cada fase lo dice la tabla de 0x6000.
    - 0xBB61 (p13:BB37): tres bytes por fase: [habitacion en el nibble bajo,
      bit 7 una bandera][puntero que va a 0xC5AD].
    - 0xBBCD (p13:BB9A): registros de cuatro bytes [fase + 1][habitacion
      nueva << 4 | habitacion][puntero que va a 0xC5B2], hasta un 0xFF.
    """
    s = (11, 12, 13)
    prim = [byte(rom, s, 0x6000 + i) for i in range(19)] + [(0x614B - 0x6013) // 2]
    ptrs = [palabra(rom, s, 0xB9D3 + 2 * i) for i in range(19)]
    bl.anota(s, 0xB9D3, 0xB9F9, "salidas_de_cada_fase",
             "19 punteros, uno por fase, a las salidas de sus habitaciones", "p13:B9C0", ancho=2)
    for f, w in enumerate(ptrs):
        n = prim[f + 1] - prim[f]
        bl.anota(s, w, w + 2 * n, "salidas_fase_%d" % f,
                 "las salidas de las %d habitaciones de la fase %d: dos bytes por habitacion, "
                 "cuatro nibbles con la habitacion vecina por cada lado (0xF, no hay)" % (n, f),
                 "p13:B9A2", ancho=2)
    bl.anota(s, 0xBB61, 0xBB61 + 3 * 19, "puerta_de_cada_fase",
             "tres bytes por fase: [habitacion (nibble bajo) y bandera (bit 7)][puntero que "
             "p13:BB52 deja en 0xC5AD]", "p13:BB3A", ancho=3)
    a = 0xBBCD
    while byte(rom, s, a) != 0xFF:
        a += 4
    bl.anota(s, 0xBBCD, a + 1, "pasos_entre_habitaciones",
             "%d registros de cuatro bytes [fase + 1][habitacion nueva << 4 | habitacion]"
             "[puntero que p13:BBBA deja en 0xC5B2], y 0xFF" % ((a - 0xBBCD) // 4),
             "p13:BB9E", ancho=4)


def huecos_que_cierran(rom, t, bl):
    """Rle a los que no apunta nadie, pero que cierran CLAVADOS en su hueco.

    Entre los rle que si se leen quedan tramos de 60 bytes (banco 13) que
    ninguna tabla nombra: buscada su direccion como palabra en los 128 KB, no
    aparece. Recorridos con el lenguaje del rle acaban justo donde empieza el
    bloque siguiente, sin un byte de mas ni de menos: son rle que el juego no
    usa. Solo se declara lo que cierra exacto.
    """
    for b, s in ((13, (11, 12, 13)), (10, (1, 9, 10))):
        ocup = ocupado(b)
        for (i, f) in list(bl.d.get(b, {})):
            for x in range(i - ORG[b], f - ORG[b]):
                ocup[x] = 1
        x = 0
        while x < TAM_PAGINA:
            if ocup[x]:
                x += 1
                continue
            y = x
            while y < TAM_PAGINA and not ocup[y]:
                y += 1
            a, f = ORG[b] + x, ORG[b] + y
            try:
                pos = a
                while pos < f:
                    pos = fin_rle(rom, s, pos, False)
                if pos == f:
                    bl.anota(s, a, f, "rle_sin_usar_%04X" % a,
                             "rle que no lee nadie (su direccion no aparece como palabra en el "
                             "cartucho) y que cierra clavado en el hueco", "nadie")
            except FueraDelBanco:
                pass
            x = y


def sin_llamar(rom, t, bl):
    """Lo que no alcanza nadie en los bancos de codigo, si cierra clavado.

    Para cada hueco que quede sin explicar en los bancos 0 a 3 se prueba:
      - como CODIGO: instrucciones enteras que acaban justo en el borde del
        hueco con un `ret`, `jp`, `jr` o `jp (hl)`;
      - como ROTULO de 0x4ACB: acaba en su 0xFF justo en el borde.
    Y en los dos casos su direccion no puede aparecer como palabra en ningun
    sitio de los 128 KB: si apareciera, alguien podria llamarlo y habria que
    buscar quien. Lo que no cumple las dos cosas se queda sin declarar.
    """
    for b in (0, 1, 2, 3):
        s = tuple(b if ORG[b] == r else {0x6000: 1, 0x8000: 2, 0xA000: 3}[r]
                  for r in (0x6000, 0x8000, 0xA000))
        ocup = ocupado(b)
        for (i, f) in list(bl.d.get(b, {})):
            for x in range(i - ORG[b], f - ORG[b]):
                ocup[x] = 1
        x = 0
        while x < TAM_PAGINA:
            if ocup[x]:
                x += 1
                continue
            y = x
            while y < TAM_PAGINA and not ocup[y]:
                y += 1
            a, f = ORG[b] + x, ORG[b] + y
            x = y
            if bytes([a & 0xFF, a >> 8]) in rom:
                continue
            pc, ultimo = a, None
            while pc < f:
                n = t.ilen(pc, s)
                if not n:
                    break
                ultimo = byte(rom, s, pc)
                pc += n
            if pc == f and ultimo in (0xC9, 0xC3, 0x18, 0xE9):
                bl.anota(s, a, f, "codigo_sin_llamar_%04X" % a,
                         "instrucciones que no alcanza nadie: desensamblan enteras hasta un "
                         "%s justo en el borde y su direccion no aparece como palabra en el "
                         "cartucho" % {0xC9: "ret", 0xC3: "jp", 0x18: "jr", 0xE9: "jp (hl)"}[ultimo],
                         "nadie")
                continue
            try:
                fin, txts = recorre_rotulo(rom, s, a)
                if fin == f:
                    bl.anota(s, a, f, "rotulo_sin_usar_%04X" % a,
                             "rotulo para 0x4ACB que no lee nadie y cierra clavado: \"%s\""
                             % " / ".join(txts), "nadie")
            except FueraDelBanco:
                pass


def sin_usar_que_cierran(rom, t, bl):
    """Cinco bloques a los que no apunta nada y que cierran CLAVADOS.

    Ninguna tabla los nombra (su direccion no aparece como palabra en los 128
    KB), pero leidos con el formato de sus vecinos acaban exactamente donde
    empieza lo siguiente: dos guiones de carga seguidos en el banco 9, dos
    paletas entre las que si se usan, y un rle con destino. Son restos: cosas
    que el juego tuvo y ya no usa.
    """
    s = (1, 9, 10)
    for a in (0x9E26, 0x9E41):
        ini = a
        while byte(rom, s, a) != 0xFF:
            m = byte(rom, s, a)
            a += 5 if m in (0x00, 0x01) else 7
        bl.anota(s, ini, a + 1, "guion_sin_usar_%04X" % ini,
                 "guion de carga de 0x4714 que no lee nadie y cierra clavado (lo que manda leer "
                 "son rle que si usan otros guiones)", "nadie")
    for a in (0xA03D, 0xA04B):
        bl.anota(s, a, fin_paleta(rom, s, a), "paleta_sin_usar_%04X" % a,
                 "cambios de paleta ([color][RB][G], 0xFF acaba) entre los que si se usan, pero "
                 "que no nombra ninguna habitacion", "nadie", ancho=3)
    bl.anota(s, 0xB50B, fin_rle(rom, s, 0xB50B, True), "rle_sin_usar_B50B",
             "rle con el destino delante (0xFEC0) que no lee nadie y cierra clavado", "nadie")


def rellenos(rom, t, bl):
    """Los 0xFF seguidos del final de cada banco: espacio que sobro.

    Solo se declara la cola de 0xFF que llega hasta el ultimo byte del banco
    y que no pisa nada ya explicado.
    """
    for b in range(N_PAGINAS):
        blq = rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]
        n = len(blq) - len(blq.rstrip(bytes([0xFF])))
        if n >= 4:
            a = ORG[b] + TAM_PAGINA - n
            ocup = ocupado(b)
            for (i, f) in bl.d.get(b, {}):
                for x in range(max(i, a) - ORG[b], f - ORG[b]):
                    ocup[x] = 1
            while a < ORG[b] + TAM_PAGINA and ocup[a - ORG[b]]:
                a += 1
            if ORG[b] + TAM_PAGINA - a >= 4:
                s = tuple(b if ORG[b] == r else 0 for r in (0x6000, 0x8000, 0xA000))
                bl.d[b].setdefault((a, ORG[b] + TAM_PAGINA), {
                    "nom": "relleno_%s" % nombre(b),
                    "que": "%d bytes a 0xFF hasta el final del banco: espacio libre"
                           % (ORG[b] + TAM_PAGINA - a),
                    "desde": {"nadie"}, "ancho": 16})


def sueltos_de_p00(rom, t, bl):
    """Punteros fijos que el trazador no puede dar por un camino que se junta.

    - p00:57D1: `ld hl,0xA01A / jr z / ld hl,0xA021 / call 0x483E`: dos
      paletas segun sea la fase 3 o no.
    - p00:550D: 256 bytes de dibujo (32x16 a 4 bits) que se copian a 0xE800
      cambiando el color 15 por el de la tabla de 0x558E, una vez por cada uno
      de sus cinco colores (p00:54F0, `ld b,5`).
    """
    s = (1, 9, 10)
    for w in (0xA01A, 0xA021):
        bl.anota(s, w, fin_paleta(rom, s, w), "paleta_%04X" % w,
                 "cambios de paleta ([color][RB][G], 0xFF acaba); p00:57D1 elige esta o la "
                 "otra segun la fase sea la 3", "p00:57D9", ancho=3)
    bl.anota(s, 0xBDA7, 0xBEA7, "dibujo_de_cinco_colores",
             "256 bytes de dibujo (32x16 puntos a 4 bits) que p00:550D copia cinco veces "
             "cambiando el color 15 por los de 0x558E", "p00:5511", ancho=16)
    bl.anota((1, 2, 3), 0x558E, 0x5593, "cinco_colores",
             "los cinco colores con los que p00:5524 pinta el dibujo de 0xBDA7", "p00:54F0",
             ancho=5)


def listas_del_banco_14(rom, t, bl):
    """Las dos tablas por bloque de tres fases que hay al principio del banco 14.

    - p00:5A98: con la fase 0 (el patio) la lista esta en 0x800C; si no, la da
      la tabla de 0x8000 con el bloque de 0xD002. p00:5A67 la copia a 0xE000:
      0x00 acaba, 0xFF baja 0x180 bytes (otra fila), 0xFE avanza 0x18, y si no
      van dos bytes tal cual, y un tercero si el segundo es 0x7F.
    - p01:619E: la tabla de 0x8668, tambien por bloque, apunta a TRES listas
      seguidas que p01:6181 copia a 0xDB00, 0xDC00 y 0xDD00: 0xFF acaba cada
      una, 0x00 salta 16 bytes en el destino, y si no, dos bytes.
    """
    s = (1, 14, 15)

    def fin_5a67(a):
        while True:
            x = byte(rom, s, a)
            if x == 0:
                return a + 1
            if x in (0xFF, 0xFE):
                a += 1
                continue
            a += 3 if byte(rom, s, a + 1) == 0x7F else 2

    def fin_6181(a):
        for _ in range(3):
            while True:
                x = byte(rom, s, a)
                a += 1
                if x == 0xFF:
                    break
                if x:
                    a += 1
        return a

    ptrs = [palabra(rom, s, 0x8000 + 2 * i) for i in range(6)]
    bl.anota(s, 0x8000, 0x800C, "listas_de_cada_bloque",
             "6 punteros, uno por bloque de tres fases (0xD002), a la lista que p00:5A67 "
             "copia a 0xE000", "p00:5AA3", ancho=2)
    for w in [0x800C] + ptrs:
        bl.anota(s, w, fin_5a67(w), "lista_%04X" % w,
                 "lista que p00:5A67 copia a 0xE000 (0x00 acaba, 0xFF otra fila, 0xFE otro "
                 "grupo, pares de bytes y un tercero si el segundo es 0x7F)%s"
                 % ("; es la del patio, la fase 0" if w == 0x800C else ""), "p00:5A67")
    ptrs = [palabra(rom, s, 0x8668 + 2 * i) for i in range(6)]
    bl.anota(s, 0x8668, 0x8674, "tres_listas_de_cada_bloque",
             "6 punteros, uno por bloque de tres fases, a las tres listas que p01:6181 copia "
             "a 0xDB00, 0xDC00 y 0xDD00", "p01:61A1", ancho=2)
    for w in ptrs:
        bl.anota(s, w, fin_6181(w), "tres_listas_%04X" % w,
                 "LAS COSAS DE CADA HABITACION de las tres fases del bloque: tres listas seguidas, "
                 "una por fase, que p01:6181 copia a 0xDB00, 0xDC00 y 0xDD00 (16 bytes por "
                 "habitacion, cuatro cosas de cuatro bytes). En cada lista, 0xFF acaba, 0x00 pasa a "
                 "la habitacion siguiente y si no van dos bytes: el tipo (bit 7, una bandera) y la "
                 "posicion (nibble alto la y, nibble bajo la x / 16); p01:61BB las crea al entrar",
                 "p01:6185")


def por_habitacion_y_sonido(rom, t, bl):
    """Tres tablas pequenas del banco 14.

    - 0x85A6 (p00:5EDB, `ld de,0x85A6 / call 0x6542` con la fase): 19
      punteros, uno por fase, a un byte por habitacion (0xD001). p00:5EE8 lo
      va soltando bit a bit (`rra`) y cada bit puesto llama a una rutina
      (0x9CE6, 0x9D4B, 0x9D52, 0x9D97, 0x9DC3, 0x9DD5, 0x9DE7).
    - 0x8A45 (p14:8A14..8A29): cuatro tablas de seis bytes, [AND][OR] por
      canal, con las que el reproductor abre y cierra tono y ruido en el
      registro 7 del PSG.
    - 0x8B81 (p14:8B1F): doce palabras, el periodo de tono de cada nota de
      la octava mas grave; las demas salen desplazando.
    """
    s = (1, 14, 15)
    prim = [byte(rom, (11, 12, 13), 0x6000 + i) for i in range(19)] + [(0x614B - 0x6013) // 2]
    ptrs = [palabra(rom, s, 0x85A6 + 2 * i) for i in range(19)]
    bl.anota(s, 0x85A6, 0x85CC, "cosas_de_cada_habitacion",
             "19 punteros, uno por fase, a un byte por habitacion", "p00:5EDB", ancho=2)
    for f, w in enumerate(ptrs):
        n = prim[f + 1] - prim[f]
        bl.anota(s, w, w + n, "cosas_fase_%d" % f,
                 "un byte por cada una de las %d habitaciones de la fase %d: cada bit puesto "
                 "llama a una de las siete rutinas de p00:5EF6-p00:5F19" % (n, f),
                 "p00:5EE7", ancho=n)
    bl.anota(s, 0x8A45, 0x8A5D, "mascaras_del_mezclador",
             "cuatro tablas de 6 bytes, [AND][OR] por canal, para abrir o cerrar tono y ruido "
             "en el registro 7 del PSG (p14:8A2C)", "p14:8A14", ancho=6)
    bl.anota(s, 0x8B81, 0x8B99, "periodos_de_las_notas",
             "doce palabras: el periodo de tono del PSG de cada nota (do a si) de la octava "
             "mas grave; las otras octavas se sacan dividiendo", "p14:8B1F", ancho=2)


def _tramos_de_musica(rom, s, a, vistos):
    """Recorre un canal de musica como p14:8AD0. Devuelve [(ini, fin)] de los
    tramos lineales y sigue saltos, llamadas y bucles."""
    fuera, pend = [], [a]
    while pend:
        a = pend.pop()
        if a in vistos:
            continue
        vistos.add(a)
        ini = a
        while True:
            c = byte(rom, s, a)
            a += 1
            if c < 0xE0 or c == 0xFF and False:
                continue                     # nota, silencio o tempo: un byte
            if c == 0xFF:
                break                        # el canal acaba
            if c >= 0xF0:
                if c == 0xFE:                # bucle: [n][direccion]
                    pend.append(palabra(rom, s, a + 1))
                    a += 3
                else:
                    a += 1                   # envolvente: un byte mas
                continue
            k = c & 0x0F                     # 0xE0..0xEF
            if k == 0x0A:                    # salto
                pend.append(palabra(rom, s, a))
                a += 2
                break
            if k == 0x0D:                    # llamada
                pend.append(palabra(rom, s, a))
                a += 2
                continue
            if k == 0x0E:                    # vuelta
                break
        fuera.append((ini, a))
    return fuera


def _tramos_de_efecto(rom, s, a, vistos):
    """Recorre un efecto como p14:8CB9."""
    fuera, pend = [], [a]
    while pend:
        a = pend.pop()
        if a in vistos:
            continue
        vistos.add(a)
        ini = a
        while True:
            c = byte(rom, s, a)
            a += 1
            if c == 0xFF:
                break
            if c == 0xFE:
                pend.append(palabra(rom, s, a + 1))
                a += 3
                continue
            h = c & 0xF0
            if h == 0x20:
                a += 1 + (2 if c >= 0x28 else 0)
            elif h == 0x10:
                a += 2
            else:
                a += 1
        fuera.append((ini, a))
    return fuera


def sonido(rom, t, bl):
    """La musica y los efectos, con los bancos 14 y 15 puestos.

    p00:509F recibe el numero de sonido en A. Con el bit 7 puesto es una
    musica: 0x8DC9 + (A AND 0x7F) * 6 da tres punteros, uno por canal del PSG
    (p00:50E7). Si no, es un efecto: 0x8D8D + A * 2 (p00:518C). Aparte, la
    musica de la pausa (0x9463, p00:5224) y la de 0x948B (p00:52C0).
    """
    s = (1, 14, 15)
    # Los efectos van del 1 al 29: la entrada 0 caeria en 0x8D8D, que son los
    # dos ultimos bytes del reproductor (`scf / ret`, 0x37 0xC9).
    n_ef = (0x8DC9 - 0x8D8F) // 2
    efectos = [palabra(rom, s, 0x8D8F + 2 * i) for i in range(n_ef)]
    bl.anota(s, 0x8D8F, 0x8DC9, "efectos_de_sonido",
             "%d punteros, los de los efectos 1 a %d (0x8D8D + 2 * A; la entrada 0 serian los "
             "`scf / ret` de 0x8D8D)" % (n_ef, n_ef), "p00:518C", ancho=2)
    canciones = []
    a = 0x8DC9
    while a < min([0xC000] + [x for tri in canciones for x in tri]):
        tri = [palabra(rom, s, a + 2 * k) for k in range(3)]
        if not all(0x8000 <= x < 0xC000 for x in tri):
            break
        canciones.append(tri)
        a += 6
    # Detras de la ultima musica queda una palabra suelta, 0xA822 -la direccion
    # del silencio que usan los tres canales de la musica 15-, que no lee nadie:
    # el efecto 1 empieza en 0x8E2B.
    bl.anota(s, a, a + 2, "palabra_suelta",
             "0xA822 otra vez, detras de la tabla de musicas: el canal de una musica 16 que "
             "no existe (la tabla acaba en la 15 y el efecto 1 empieza aqui al lado)", "nadie",
             ancho=2)
    bl.anota(s, 0xA54D, 0xA54E, "ff_de_mas",
             "un 0xFF de mas: la musica 10 ya acabo en el de 0xA54C y la 11 empieza en 0xA54E",
             "nadie", ancho=1)
    bl.anota(s, 0xBB1B, 0xBBDB, "ceros_sin_usar",
             "192 ceros entre las partituras: no los lee nada", "nadie")
    bl.anota(s, 0x8DC9, a, "musicas",
             "%d musicas, seis bytes cada una: los tres canales del PSG (el numero de p00:509F "
             "con el bit 7)" % len(canciones), "p00:50E7", ancho=6)
    vistos = set()
    for i, tri in enumerate(canciones):
        for k, w in enumerate(tri):
            for x, y in _tramos_de_musica(rom, s, w, vistos):
                bl.anota(s, x, y, "musica_%04X" % x,
                         "partitura de un canal de musica (p14:8AD0)", "musica %d" % i)
    for w, quien in ((0x9463, "p00:5224"), (0x948B, "p00:52C0")):
        for x, y in _tramos_de_musica(rom, s, w, vistos):
            bl.anota(s, x, y, "musica_%04X" % x, "partitura de un canal de musica (p14:8AD0)", quien)
    # La percusion: en un canal sin tono (bit 0 de (ix+2) a cero) el nibble
    # alto de la nota elige en 0xAAD9 -o en 0xAAF1 si lleva el bit 2- un guion
    # en el lenguaje de los efectos (p14:8B53-p14:8B7E).
    golpes = []
    for base, quien in ((0xAAD9, "p14:8B5A"), (0xAAF1, "p14:8B7B")):
        ws = [palabra(rom, s, base + 2 * i) for i in range(12)]
        golpes += ws
        bl.anota(s, base, base + 24, "percusion_%04X" % base,
                 "12 punteros, uno por nota, al guion del golpe de percusion que suena en su "
                 "lugar%s" % (" (canales con el bit 2)" if base == 0xAAF1 else ""), quien, ancho=2)
    vistos = set()
    for w in sorted(set(golpes)):
        for x, y in _tramos_de_efecto(rom, s, w, vistos):
            bl.anota(s, x, y, "golpe_%04X" % x, "guion de un golpe de percusion (p14:8CA7)",
                     "p14:8B68")
    for i, w in enumerate(efectos, 1):
        if w == 0:
            continue
        for x, y in _tramos_de_efecto(rom, s, w, vistos):
            bl.anota(s, x, y, "efecto_%04X" % x, "guion de un efecto de sonido (p14:8CB9)",
                     "efecto %d" % i)


def final_y_creditos(rom, t, bl):
    """p01:6743: el texto del final y los creditos, con los bancos 5 y 8.

    0x678E son 43 punteros (0xCE31 es el renglon que toca). Cada renglon es
    [cuando][fila][texto hasta 0xFF] y sale cuando la cuenta de 0xCE33 llega
    a su primer byte; 0x4AD5 lo imprime. Una fila 0xFF es el final de todo.
    En el texto, 0x00 es un espacio, ';' el apostrofo y ':' el punto.
    """
    s = (1, 5, 8)
    ptrs = [palabra(rom, s, 0x678E + 2 * i) for i in range(43)]
    bl.anota((1, 2, 3), 0x678E, 0x67E4, "renglones_del_final",
             "43 punteros a los renglones del texto del final y de los creditos (bancos 5 y 8)",
             "p01:675A", ancho=2)
    for w in sorted(set(ptrs)):
        a = w + 2
        if byte(rom, s, w + 1) != 0xFF:
            while byte(rom, s, a) != 0xFF:
                a += 1
            a += 1
        txt = "".join(" " if c == 0 else chr(c) for c in rom[banco_de(w, s) * TAM_PAGINA + (w & 0x1FFF) + 2:
                                                                  banco_de(w, s) * TAM_PAGINA + (w & 0x1FFF) + max(2, a - w - 1)])
        bl.anota(s, w, a, "renglon_%04X" % w,
                 "renglon [cuando][fila][texto][0xFF]: \"%s\"" % txt.replace(";", "'").replace(":", ".")
                 if byte(rom, s, w + 1) != 0xFF else "el renglon que acaba el final (fila 0xFF)",
                 "p01:6769", ancho=16)


def sprites_de_cada_cosa(rom, t, bl):
    """p01:6445: como se compone con sprites cada cosa, con el banco 6.

    0xB473 tiene un puntero por tipo (el de (ix+0x0B)) a una lista de tres
    bytes por sprite, [dy][dx][patron], tantos como diga (ix+0x20); 0x80,
    0x81 y 0x82 en su primer byte cambian las posiciones por las de 0x64CD,
    0x64D5 y 0x64D9 y dejan solo los patrones. Las listas van seguidas, asi
    que cada una acaba donde empieza la siguiente.
    """
    s = (1, 2, 6)
    ptrs = []
    a = 0xB473
    while a < min([0xC000] + ptrs):
        ptrs.append(palabra(rom, s, a))
        a += 2
    bl.anota(s, 0xB473, a, "sprites_de_cada_tipo",
             "%d punteros, uno por tipo de cosa, a como se compone con sprites" % len(ptrs),
             "p01:645B", ancho=2)
    orden = sorted(set(ptrs))
    fin_total = 0xB9C8
    for i, w in enumerate(orden):
        f = orden[i + 1] if i + 1 < len(orden) else fin_total
        bl.anota(s, w, f, "sprites_%04X" % w,
                 "[dy][dx][patron] por sprite (o 0x80/0x81/0x82 y solo los patrones)",
                 "p01:6469", ancho=3)


def tablas_del_despachador(rom, t, bl):
    """Las tablas de destinos pegadas detras de cada `call 0x406B`.

    Las mide tools/bancos.py (hasta el destino mas bajo, o lo que diga
    src/tablas.txt) y ya estan en el .nocode para que el trazador no entre;
    aqui se declaran como datos, con cuantos destinos tienen.
    """
    for (b, pc), (tab, n, dest, ss) in sorted(t.tablas.items()):
        if not n:
            continue
        bl.anota(ss, tab, tab + 2 * n, "tabla_%04X" % tab,
                 "%d destinos del despachador de 0x406B (call en %s:%04X): %s"
                 % (n, nombre(b), pc, ", ".join("0x%04X" % w for w in dest[:8])
                    + (" ..." if n > 8 else "")),
                 "%s:%04X" % (nombre(b), pc), ancho=2)


def cabecera(rom, t, bl):
    """0x4000-0x4027: la cabecera AB y la que lee el Konami Game Master.

    0x4000 'AB', INIT 0x4075 y los otros tres vectores a cero. De 0x4010 en
    adelante, la cabecera de Konami: 'CD' y los datos del cartucho que usa el
    Game Master (el mismo esquema que el resto de cartuchos de la casa).
    """
    s = (1, 2, 3)
    bl.anota(s, 0x4000, 0x4010, "cabecera_ab",
             "la cabecera del cartucho: 'AB', INIT (0x4075) y STATEMENT, DEVICE y TEXT a cero",
             "la BIOS", ancho=16)
    bl.anota(s, 0x4010, 0x4028, "cabecera_de_konami",
             "la cabecera de Konami que empieza por 'CD' y lee el Game Master", "el Game Master",
             ancho=8)


# Llamadas cuyo puntero ya lo pone un recorrido de arriba.
DE_LOS_RECORRIDOS = {(0, 0x566A), (0, 0x57A5), (0, 0x5412), (0, 0x57AE),
                     # los impresores se llaman a si mismos
                     (0, 0x4ADB), (0, 0x5D95), (1, 0x7B45)}

RECORRIDOS = [dibujos_de_cada_fase, llamadas_a_lectores, habitaciones, tabla_5421, mapas,
              salidas_y_puertas, sueltos_de_p00, listas_del_banco_14,
              por_habitacion_y_sonido, sonido, final_y_creditos, sprites_de_cada_cosa,
              tablas_del_despachador, cabecera, huecos_que_cierran, sin_llamar,
              sin_usar_que_cierran,
              rellenos]


# ------------------------------------------------------------------ escritura
def ocupado(p):
    """bytearray del banco: 1 = codigo trazado, 2 = D escrita fuera de la seccion."""
    o = ORG[p]
    m = bytearray(TAM_PAGINA)
    ruta = os.path.join(WORK, nombre(p) + ".trace.json")
    if os.path.exists(ruta):
        for k, a, b in json.load(open(ruta))["blocks"]:
            if k == "c":
                for i in range(a - o, b - o):
                    m[i] = 1
    notas = os.path.join(SRC, nombre(p) + ".notes")
    dentro = False
    if os.path.exists(notas):
        for ln in open(notas, encoding="utf-8"):
            if ln.startswith(INI):
                dentro = True
            elif ln.startswith(FIN):
                dentro = False
            elif not dentro and ln.startswith("D "):
                q = ln.split(None, 3)
                for i in range(max(0, int(q[1], 0) - o), min(TAM_PAGINA, int(q[2], 0) - o)):
                    m[i] = 2
    return m


def une(bloques_banco):
    """Los que se solapan se juntan en uno: dos juegos que comparten dibujos."""
    fuera = []
    for (a, f), e in sorted(bloques_banco.items()):
        if fuera and a < fuera[-1][1]:
            pa, pf, pe = fuera[-1]
            fuera[-1] = (pa, max(pf, f), pe + [(a, f, e)])
        else:
            fuera.append((a, f, [(a, f, e)]))
    return fuera


def linea_d(a, f, partes):
    e0 = partes[0][2]
    desde = sorted({d for _, _, e in partes for d in e["desde"]})
    if len(partes) == 1:
        txt = e0["que"]
    else:
        txt = "%s; se solapan %d bloques (%s)" % (
            e0["que"], len(partes),
            ", ".join("0x%04X-0x%04X" % (x, y) for x, y, _ in partes[:6]))
    txt += "; lo leen %s" % ", ".join(desde[:8])
    if len(desde) > 8:
        txt += " y %d mas" % (len(desde) - 8)
    txt += " (%d bytes)" % (f - a)
    return ["D 0x%04X 0x%04X %s  %s" % (a, f, e0["nom"], txt), "F 0x%04X %d" % (a, e0["ancho"])]


def escribe(p, lineas):
    ruta = os.path.join(SRC, nombre(p) + ".notes")
    viejas = open(ruta, encoding="utf-8").read().split("\n") if os.path.exists(ruta) else []
    nuevas, dentro, puesto = [], False, False
    for ln in viejas:
        if ln.startswith(INI):
            dentro = True
            if lineas:
                nuevas += [INI] + lineas + [FIN]
            puesto = True
            continue
        if ln.startswith(FIN):
            dentro = False
            continue
        if not dentro:
            nuevas.append(ln)
    if not puesto and lineas:
        while nuevas and not nuevas[-1].strip():
            nuevas.pop()
        nuevas += ["", INI] + lineas + [FIN, ""]
    open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas).rstrip("\n") + "\n")


def main(argv):
    rom = open(ROM, "rb").read()
    t, _ = traza_completa(rom, SRC)
    bl = Bloques()
    for r in RECORRIDOS:
        try:
            r(rom, t, bl)
        except FueraDelBanco as e:
            bl.avisos.append("%s: %s" % (r.__name__, e))
    total = 0
    for p in range(N_PAGINAS):
        m = ocupado(p)
        buenas, conflictos = [], []
        for a, f, partes in une(bl.d.get(p, {})):
            marcas = set(m[i - ORG[p]] for i in range(a, f))
            if marcas == {2}:
                continue
            pisa = marcas - {0}
            if pisa:
                conflictos.append("  %s 0x%04X-0x%04X (%s) pisa %s" % (
                    nombre(p), a, f, partes[0][2]["nom"],
                    " y ".join({1: "codigo trazado", 2: "una D escrita a mano"}[x] for x in sorted(pisa))))
                continue
            buenas.append((a, f, partes))
        n = sum(f - a for a, f, _ in buenas)
        total += n
        if buenas or conflictos:
            print("%s: %d bloques, %d bytes%s" % (nombre(p), len(buenas), n,
                                                  ", %d en conflicto" % len(conflictos) if conflictos else ""))
            for c in conflictos:
                print(c)
        if "--escribe" in argv:
            lineas = []
            for a, f, partes in buenas:
                lineas += linea_d(a, f, partes)
            escribe(p, lineas)
    print("en total: %d bytes en bloques que lee el codigo" % total)
    if bl.avisos:
        print("%d avisos:" % len(bl.avisos))
        for x in sorted(set(bl.avisos))[:80]:
            print("  " + x)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
