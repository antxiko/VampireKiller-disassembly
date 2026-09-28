#!/usr/bin/env python3
"""Convierte los documentos .md a HTML con el estilo del proyecto.

Asi la web de GitHub Pages es navegable entera, sin depender de Jekyll ni de
ninguna gema: se publica HTML plano y ya esta.

Soporta lo que usamos de Markdown: encabezados, parrafos, listas, tablas,
bloques de codigo, citas, enlaces, imagenes, negrita, cursiva, codigo en linea
y separadores.
"""
import html
import os
import re
import sys
import unicodedata

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from estilo_web import ESTILO  # noqa: E402


# Un menu por idioma. La web se publica en ingles en la raiz de docs/ y en
# castellano bajo docs/es/. Son las siete paginas del contrato por idioma,
# mas la portada.
NAV_EN = [("index.html", "Home"), ("GETTING-STARTED.html", "Start"),
          ("THE-GAME.html", "The game"),
          ("THE-CARTRIDGE.html", "The cartridge"),
          ("THE-CODE.html", "The code"),
          ("FINDINGS.html", "Findings"),
          ("IN-THE-EMULATOR.html", "In the emulator"),
          ("OPEN-QUESTIONS.html", "Open questions")]
NAV_ES = [("index.html", "Portada"), ("EMPEZAR.html", "Empezar"),
          ("EL-JUEGO.html", "El juego"),
          ("EL-CARTUCHO.html", "El cartucho"),
          ("EL-CODIGO.html", "El código"),
          ("HALLAZGOS.html", "Hallazgos"),
          ("EN-EL-EMULADOR.html", "En el emulador"),
          ("PREGUNTAS-ABIERTAS.html", "Preguntas abiertas")]

# Cada documento se llama distinto en cada idioma, asi que el selector de idioma
# necesita saber cual es la pareja de cada pagina.
_PAREJAS = [("GETTING-STARTED.html", "EMPEZAR.html"),
            ("THE-GAME.html", "EL-JUEGO.html"),
            ("THE-CARTRIDGE.html", "EL-CARTUCHO.html"),
            ("THE-CODE.html", "EL-CODIGO.html"),
            ("FINDINGS.html", "HALLAZGOS.html"),
            ("IN-THE-EMULATOR.html", "EN-EL-EMULADOR.html"),
            ("OPEN-QUESTIONS.html", "PREGUNTAS-ABIERTAS.html")]
PAREJA = {}
for _en, _es in _PAREJAS:
    PAREJA[_en] = _es
    PAREJA[_es] = _en

# El pie va en el idioma de la pagina, y como todo lo que es de este juego
# sale de tools/contenido_web.py: esta maquinaria no nombra ningun cartucho.
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from contenido_web import NOMBRE, ANIO, PIE_LEGAL as PIE        # noqa: E402


def enlinea(t):
    """Formato dentro de una linea: codigo, negrita, cursiva, enlaces, imagenes.

    El codigo entre comillas se APARTA primero y se devuelve al final. Partir la
    linea por las comillas y formatear cada trozo por separado, que es lo obvio,
    deja sin convertir toda negrita que lleve codigo dentro -`**detras del
    `call`**` se quedaba con los asteriscos a la vista-, porque la apertura y el
    cierre caen en trozos distintos.
    """
    codigos = []

    def aparta(m):
        codigos.append("<code>%s</code>" % html.escape(m.group(1)))
        return "\x00%d\x01" % (len(codigos) - 1)

    s = html.escape(re.sub(r"`([^`]+)`", aparta, t))
    s = re.sub(r"!\[([^\]]*)\]\(([^)]+)\)", r'<img src="\2" alt="\1">', s)
    s = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", lambda m:
               f'<a href="{ruta(m.group(2))}">{m.group(1)}</a>', s)
    # El tachado marca en esta serie una pregunta ya cerrada. Sin esto
    # los `~~` salian en crudo en la pagina publicada.
    s = re.sub(r"~~([^~]+)~~", r"<del>\1</del>", s)
    s = re.sub(r"\*\*([^*]+)\*\*", r"<b>\1</b>", s)
    s = re.sub(r"(?<![\w*])\*([^*\n]+)\*(?![\w*])", r"<em>\1</em>", s)
    return re.sub("\x00([0-9]+)\x01", lambda m: codigos[int(m.group(1))], s)


# La web se sirve desde docs/, asi que lo que este fuera de esa carpeta no
# existe para el navegador: esos enlaces se mandan al repositorio. Se puede
# cambiar sin tocar el codigo con la variable de entorno.
from contenido_web import REPOSITORIO                              # noqa: E402
REPO = os.environ.get("REPO_WEB", REPOSITORIO)


def ruta(href):
    """Los enlaces entre documentos apuntan a .md; en la web van a .html."""
    if href.startswith(("http", "#", "mailto:")):
        return href
    h = href.replace("docs/", "")
    # Lo que no vive bajo docs/ no existe para el navegador: el codigo fuente,
    # las herramientas, las medidas y los ficheros de la raiz se mandan al
    # repositorio. Se mira ANTES de tocar el "../", porque desde docs/ es como
    # se citan y quitarselo deja un enlace que la web no puede servir.
    plano = h
    while plano.startswith("../"):
        plano = plano[3:]
    if plano.startswith(("src/", "tools/", "medidas/")) or plano in (
            "README.md", "README.es.md", "LICENSE", "AVISO-LEGAL.md",
            "LEGAL-NOTICE.md", "Makefile"):
        return f"{REPO}/blob/main/{plano}"
    if h.startswith("../"):
        return h if h.endswith((".html", ".png", ".txt")) else plano
    # el ancla (THE-GAME.md#the-vendors) se aparta para cambiar la extension
    h, almohadilla, ancla_ = plano.partition("#")
    if h.endswith(".md"):
        h = h[:-3] + ".html"
    return h + almohadilla + ancla_


def ancla(titulo):
    """El id de un encabezado: minusculas, sin acentos y con guiones.

    Es la convencion de GitHub, asi que un enlace a #el-mundo funciona igual en
    la web publicada que en el Markdown de siempre.
    """
    t = unicodedata.normalize("NFKD", titulo)
    t = "".join(c for c in t if not unicodedata.combining(c))
    t = re.sub(r"[*_`\[\]()]", "", t).lower()
    t = re.sub(r"[^a-z0-9]+", "-", t)
    return t.strip("-")


def convierte(texto, titulo, actual, idioma="en"):
    ln = texto.split("\n")
    out, i = [], 0
    while i < len(ln):
        l = ln[i]
        if l.startswith("```"):                     # bloque de codigo
            j = i + 1
            cuerpo = []
            while j < len(ln) and not ln[j].startswith("```"):
                cuerpo.append(ln[j]); j += 1
            out.append("<pre><code>" + html.escape("\n".join(cuerpo)) + "</code></pre>")
            i = j + 1; continue
        if re.match(r"^\s*\|", l) and i + 1 < len(ln) and re.match(r"^\s*\|[\s:|-]+\|?\s*$", ln[i + 1]):
            filas = []                              # tabla
            while i < len(ln) and re.match(r"^\s*\|", ln[i]):
                filas.append([c.strip() for c in ln[i].strip().strip("|").split("|")])
                i += 1
            cab, cuerpo = filas[0], filas[2:]
            t = "<table><tr>" + "".join(f"<th>{enlinea(c)}</th>" for c in cab) + "</tr>"
            for f in cuerpo:
                t += "<tr>" + "".join(f"<td>{enlinea(c)}</td>" for c in f) + "</tr>"
            out.append(t + "</table>"); continue
        m = re.match(r"^(#{1,4})\s+(.*)$", l)
        if m:
            n = len(m.group(1))
            # Con id, para poder enlazar a una seccion concreta desde la portada.
            out.append(f'<h{n} id="{ancla(m.group(2))}">{enlinea(m.group(2))}</h{n}>')
            i += 1; continue
        if re.match(r"^---+\s*$", l):
            out.append("<hr>"); i += 1; continue
        if l.startswith(">"):
            cita = []
            while i < len(ln) and ln[i].startswith(">"):
                cita.append(ln[i].lstrip("> ").rstrip()); i += 1
            out.append(f"<blockquote>{enlinea(' '.join(cita))}</blockquote>"); continue
        if l.lstrip().startswith("<audio "):        # un reproductor puesto a mano
            out.append(l.strip()); i += 1; continue
        if re.match(r"^ {4,}\S", l):                # bloque de codigo indentado
            cuerpo = []
            while i < len(ln) and re.match(r"^ {4,}\S", ln[i]):
                cuerpo.append(ln[i][4:])
                i += 1
                # una linea en blanco no corta el bloque si detras sigue indentado
                if i < len(ln) and not ln[i].strip() and \
                        i + 1 < len(ln) and re.match(r"^ {4,}\S", ln[i + 1]):
                    cuerpo.append(""); i += 1
            out.append("<pre><code>" + html.escape("\n".join(cuerpo)) + "</code></pre>")
            continue
        m = re.match(r"^\s*([-*]|\d+\.)\s+", l)
        if m:
            orden = not m.group(1) in "-*"
            items, sangria = [], []
            while i < len(ln) and (re.match(r"^\s*([-*]|\d+\.)\s+", ln[i]) or
                                   (sangria and ln[i].startswith("  ") and ln[i].strip())):
                mm = re.match(r"^\s*(?:[-*]|\d+\.)\s+(.*)$", ln[i])
                if mm:
                    items.append(mm.group(1)); sangria = True
                else:
                    items[-1] += " " + ln[i].strip()
                i += 1
            tag = "ol" if orden else "ul"
            out.append(f"<{tag}>" + "".join(f"<li>{enlinea(x)}</li>" for x in items) + f"</{tag}>")
            continue
        if not l.strip():
            i += 1; continue
        parr = []                                   # parrafo
        while i < len(ln) and ln[i].strip() and not re.match(
                r"^(#{1,4}\s|```|>|\s*([-*]|\d+\.)\s|---+\s*$|\s*\|)", ln[i]):
            parr.append(ln[i].strip()); i += 1
        out.append(f"<p>{enlinea(' '.join(parr))}</p>")

    menu = NAV_EN if idioma == "en" else NAV_ES
    nav = "".join(f'<a href="{h}"{" style=color:var(--tinta)" if h == actual else ""}>{t}</a>'
                  for h, t in menu)
    # Selector de idioma: lleva al documento equivalente, no a la portada
    otro = PAREJA.get(actual, "index.html")
    if idioma == "en":
        nav += f'<a href="es/{otro}" style="margin-left:auto;color:var(--oro)">Castellano</a>'
    else:
        nav += f'<a href="../{otro}" style="margin-left:auto;color:var(--oro)">English</a>'
    # El charset y el viewport van explicitos: estas paginas llevan acentos,
    # comillas latinas y el signo de grado, y sin la declaracion un navegador
    # que no reciba el charset por cabecera las leeria como si fueran de un byte.
    return ('<meta charset="utf-8">\n'
            '<meta name="viewport" content="width=device-width,initial-scale=1">\n'
            f"<title>{html.escape(titulo)}</title>\n<style>{ESTILO}</style>\n"
            f'<div class="w"><nav class="top">{nav}</nav>\n' + "\n".join(out) +
            f'\n<footer><p>{PIE[idioma]}</p></footer></div>\n')


def main(docdir, idioma="en"):
    # Solo se convierten las paginas del menu. En docs/ viven ademas los
    # documentos de trabajo con las medidas en crudo, que no son parte de la
    # web y se quedan como estan.
    paginas = {h[:-5] + ".md" for h, _ in (NAV_EN if idioma == "en" else NAV_ES)}
    n = 0
    for fn in sorted(os.listdir(docdir)):
        if not fn.endswith(".md") or fn not in paginas:
            continue
        src = os.path.join(docdir, fn)
        dst = os.path.join(docdir, fn[:-3] + ".html")
        texto = open(src, encoding="utf-8").read()
        m = re.search(r"^#\s+(.*)$", texto, re.M)
        titulo = (m.group(1) if m else fn[:-3]) + f" — {NOMBRE} (Konami, {ANIO})"
        open(dst, "w", encoding="utf-8").write(
            convierte(texto, titulo, fn[:-3] + ".html", idioma))
        print(f"  {fn} -> {os.path.basename(dst)}")
        n += 1
    print(f"{n} documentos convertidos ({idioma})")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2] if len(sys.argv) > 2 else "en")
