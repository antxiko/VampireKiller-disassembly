#!/usr/bin/env python3
"""Escribe las paginas LA-MUSICA.md (es) y THE-MUSIC.md (en) desde CFG de musica.py.

CFG["pagina"] lleva los textos de cada juego; aqui solo esta la forma:

  juego_es / juego_en   nombre del juego
  motor_es / motor_en   donde esta el motor y como se le llama (una frase)
  chip_es / chip_en     (opcional) algo mas sobre el chip
  maquina               maquina de openMSX del cotejo (texto)
  cotejo                [(es, en)] lo que se ha cotejado, con cifras
  notas                 [(titulo_es, texto_es, titulo_en, texto_en)] secciones libres
  grupos                [(clave, titulo_es, titulo_en, intro_es, intro_en)]
  piezas (CFG)          (numero, fichero, grupo, titulo_es, titulo_en, quien_es, quien_en)
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
import musica  # noqa: E402

RAIZ = motor_musica.RAIZ


def datos_de(rom, numero, fichero, cfg):
    """(cuadros, segundos, vuelta_s) de una pieza, ejecutando el motor."""
    cuadros, vuelta = motor_musica.ejecuta(cfg, rom, numero)
    hz = cfg.get("hz", 60)
    return len(cuadros), len(cuadros) / hz, (None if vuelta is None
                                              else vuelta / hz)


def version(fichero):
    """Ocho cifras del contenido del MP3: la web lo cachea diez minutos y, sin
    esto, quien ya lo oyo sigue oyendo el viejo."""
    import hashlib
    r = os.path.join(RAIZ, "docs", "audio", fichero)
    if not os.path.exists(r):
        return "0"
    return hashlib.sha1(open(r, "rb").read()).hexdigest()[:8]


def pagina(idioma):
    cfg = musica.CFG
    p = cfg["pagina"]
    es = idioma == "es"
    rom = open(os.path.join(RAIZ, cfg["rom"]), "rb").read()
    hz = cfg.get("hz", 60)
    ruta = "../audio/" if es else "audio/"
    L = []
    L.append("# La música" if es else "# The music")
    L.append("")
    if es:
        L.append("Todo lo que suena aquí sale de ejecutar el motor de sonido del "
                 "cartucho (%s) en un Z80 emulado, cuadro a cuadro y a %d por "
                 "segundo, igual que lo llama el juego. Lo que el motor escribe "
                 "en el PSG pasa a sonido con un AY-3-8910 (`tools/musica.py`). "
                 "Cada MP3 es la pieza entera hasta donde vuelve a empezar, más "
                 "8 segundos de la vuelta apagándose; las que no se repiten "
                 "acaban donde acaba el motor." % (p["motor_es"], hz))
    else:
        L.append("Everything you hear here comes from running the cartridge's own "
                 "sound engine (%s) on an emulated Z80, frame by frame at %d per "
                 "second, just as the game calls it. What the engine writes to "
                 "the PSG is turned into sound with an AY-3-8910 "
                 "(`tools/musica.py`). Each MP3 is the whole piece up to where "
                 "it starts again, plus 8 seconds of the repeat fading out; "
                 "those that do not repeat end where the engine ends."
                 % (p["motor_en"], hz))
    L.append("")
    if p.get("chip_es" if es else "chip_en"):
        L.append(p["chip_es" if es else "chip_en"])
        L.append("")
    L.append("## Cotejado con openMSX" if es else "## Checked against openMSX")
    L.append("")
    if es:
        L.append("Las escrituras al PSG se han comparado cuadro a cuadro con las "
                 "de openMSX (%s). En todos los cuadros el PSG queda igual:"
                 % p["maquina"])
    else:
        L.append("The PSG writes have been compared frame by frame with those of "
                 "openMSX (%s). In every frame the PSG ends up the same:"
                 % p["maquina"])
    L.append("")
    for c in p["cotejo"]:
        L.append("- " + c[0 if es else 1] + ";" if c is not p["cotejo"][-1]
                 else "- " + c[0 if es else 1] + ".")
    L.append("")
    if es:
        L.append("El timbre no está cotejado: es el de un AY-3-8910 de manual, "
                 "no una grabación del emulador. Las sondas están en "
                 "`tools/omsx_psg.tcl` y `tools/coteja_psg.py`.")
    else:
        L.append("The timbre is not checked: it is a textbook AY-3-8910, not a "
                 "recording of the emulator. The probes are "
                 "`tools/omsx_psg.tcl` and `tools/coteja_psg.py`.")
    L.append("")
    for n in p.get("notas", ()):
        L.append("## " + (n[0] if es else n[2]))
        L.append("")
        L.append(n[1] if es else n[3])
        L.append("")
    for clave, te, ten, ie, ien in p["grupos"]:
        L.append("## " + (te if es else ten))
        L.append("")
        if ie or ien:
            L.append(ie if es else ien)
            L.append("")
        for num, fichero, grupo, tit_es, tit_en, q_es, q_en in cfg["piezas"]:
            if grupo != clave:
                continue
            cuadros, seg, vuelta = datos_de(rom, num, fichero, cfg)
            tope = cfg.get("max_s", 300)
            cortada = vuelta is None and cuadros >= hz * tope - 1
            if cortada and es:
                dur = "se corta a los %.0f s (la pieza sigue)" % seg
            elif cortada:
                dur = "is cut at %.0f s (the piece goes on)" % seg
            elif es:
                dur = "dura %.1f s" % seg if vuelta is None else \
                    "dura %.1f s y vuelve a empezar en el segundo %.1f" % (seg, vuelta)
            else:
                dur = "lasts %.1f s" % seg if vuelta is None else \
                    "lasts %.1f s and starts again at second %.1f" % (seg, vuelta)
            if not es:
                dur = dur.replace(".", ".")
            L.append("**%s** (0x%02X)" % (tit_es if es else tit_en, num))
            L.append("")
            L.append(("Lo pide %s; %s." if es else "Asked for by %s; %s.")
                     % (q_es if es else q_en, dur))
            L.append("")
            L.append('<audio controls preload="none" src="%s%s?v=%s"></audio>'
                     % (ruta, fichero, version(fichero)))
            L.append("")
    return "\n".join(L).rstrip() + "\n"


def main():
    for idioma, ruta in (("es", "docs/es/LA-MUSICA.md"),
                         ("en", "docs/THE-MUSIC.md")):
        txt = pagina(idioma)
        # decimales con coma en castellano
        if idioma == "es":
            import re
            txt = re.sub(r"(\d)\.(\d) s", r"\1,\2 s", txt)
            txt = re.sub(r"segundo (\d+)\.(\d)", r"segundo \1,\2", txt)
        with open(os.path.join(RAIZ, ruta), "w", encoding="utf-8",
                  newline="\n") as f:
            f.write(txt)
        print("escrito", ruta)


if __name__ == "__main__":
    main()
