#!/usr/bin/env python3
"""EL CONTENIDO de la web de este cartucho: lo unico que es de este juego.

md2html.py y make_web.py son la maquinaria y no llevan dentro el nombre de
ningun juego: lo leen de aqui. Asi no se puede colar el texto de otro
cartucho al copiar la maquinaria.

Todas las cifras de aqui estan medidas sobre este cartucho, con las
herramientas de tools/: CODIGO y DATOS los imprime tools/presupuesto.py
(make sanity) y RUTINAS, INSTRUCCIONES y COMENTARIOS son la suma de los
bancos con codigo en tools/densidad.py (make densidad). Un test las vuelve a
medir.
"""

NOMBRE = "Vampire Killer"
CATALOGO = "RC-744"
ANIO = 1986
REPOSITORIO = "https://github.com/antxiko/VampireKiller-disassembly"

CODIGO = 29786
DATOS = 101286
RUTINAS = 1909
INSTRUCCIONES = 14502
COMENTARIOS = 7163


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


# El pie legal de cada pagina. El cartucho no lleva la marca oculta de la casa
# (tools/marca_konami.py: sin marca al final del fichero ni de ningun trozo de
# 8 o 16 KB).
PIE_LEGAL = {
    "es": "<em>Vampire Killer</em> (<em>Akumaj&#333; Dracula</em> en Jap&oacute;n) "
          "lo public&oacute; Konami para MSX2 en 1986; su n&uacute;mero de "
          "cat&aacute;logo es RC-744 y son 128 KB. Todos los derechos sobre el "
          "juego siguen siendo de sus titulares. Este trabajo es de "
          "preservaci&oacute;n, estudio y documentaci&oacute;n, y la imagen del "
          "cartucho no se distribuye.",
    "en": "<em>Vampire Killer</em> (<em>Akumaj&#333; Dracula</em> in Japan) was "
          "published by Konami for the MSX2 in 1986; its catalogue number is "
          "RC-744 and it is 128 KB. All rights in the game remain with their "
          "holders. This is preservation, study and documentation work, and "
          "the cartridge image is not distributed.",
}

# La cabecera de la portada
PORTADA = {
    "es": dict(
        titulo="Vampire Killer - desensamblado comentado",
        claim="Un castillo de 156 habitaciones, 33 vendedores que no siempre "
              "venden y un Dr&aacute;cula que es medio sprite y medio dibujo "
              "del VDP, todo dibujado desde la ROM.",
        ficha=["Konami - <b>(c) Konami 1986</b>",
               "Cartucho <b>RC-744</b>, MegaROM de 128 KB (Konami4)",
               "<b>MSX2</b>", "Volcado <b>99eabaae...</b>"],
        aviso="<b>Aqu&iacute; no hay ninguna captura.</b> Todas las im&aacute;genes "
              "est&aacute;n <b>dibujadas desde los bytes de la ROM</b>: el "
              "t&iacute;tulo, las 156 habitaciones con lo que esconden, Simon, "
              "los enemigos y los seis jefes, con las tablas del cartucho, y "
              "<b>cotejadas contra openMSX</b> en una m&aacute;quina MSX2: 0 bytes "
              "distintos en las habitaciones, el t&iacute;tulo, Simon y "
              "Dr&aacute;cula. El listado y las cifras se reproducen con "
              "<code>make</code>, y el reensamblado devuelve la ROM <b>byte a "
              "byte</b>.",
    ),
    "en": dict(
        titulo="Vampire Killer - a commented disassembly",
        claim="A 156-room castle, 33 vendors who do not always sell and a "
              "Dracula who is half sprite and half VDP drawing, all drawn "
              "from the ROM.",
        ficha=["Konami - <b>(c) Konami 1986</b>",
               "An <b>RC-744</b> cartridge, a 128 KB MegaROM (Konami4)",
               "<b>MSX2</b>", "Dump <b>99eabaae...</b>"],
        aviso="<b>Not one capture here.</b> Every picture is <b>drawn from the "
              "bytes of the ROM</b>: the title, the 156 rooms with what they "
              "hide, Simon, the enemies and the six bosses, with the "
              "cartridge's own tables, and <b>checked against openMSX</b> on an "
              "MSX2 machine: 0 bytes different in the rooms, the title, Simon "
              "and Dracula. The listing and the numbers are reproducible with "
              "<code>make</code>, and reassembling gives back the ROM <b>byte "
              "for byte</b>.",
    ),
}

HALLAZGOS = {
    "es": [
        ("Las puertas cerradas son vendedores",
         "<p>Hay <b>33</b> en el castillo. Lo que pasa al pegarles depende de "
         "su clase y de cu&aacute;ntos golpes llevan (tabla "
         "<code>0x9300</code>): uno abre la tienda al primero, otro al "
         "quinto, otro puede quitarte cinco corazones, y todos se van al "
         "octavo.</p>"),
        ("Los libros cambian los precios",
         "<p>Con el libro blanco la tienda cobra menos y con el rojo, "
         "m&aacute;s: la vida llena cuesta 15, 40 u 80 corazones "
         "(<code>p02:9418</code>). Visto en openMSX.</p>"),
        ("Dr&aacute;cula, medio sprite y medio VDP",
         "<p>La cabeza es un sprite; el cuerpo lo copia el VDP desde la "
         "p&aacute;gina 1 con LMMM, tras guardar el fondo "
         "(<code>p03:AD80</code>). Cotejado a cero en sus cuatro dibujos.</p>"),
        ("Dos t&iacute;tulos en un cartucho",
         "<p><em>Vampire Killer</em> o <em>Akumaj&#333; Dracula</em>, "
         "seg&uacute;n el byte <code>0x002B</code> de la BIOS, el del "
         "pa&iacute;s (<code>p00:4D9E</code>).</p>"),
        ("Un dibujo que se lee de la RAM",
         "<p><code>p00:54E4</code> sube 640 bytes desde <code>0xBDC8</code>; "
         "los &uacute;ltimos 0x48 caen ya en <code>0xC000</code>, la RAM.</p>"),
        ("Con un Game Master, otra pausa",
         "<p>El cartucho busca el <em>Konami's Game Master</em> en las cuatro "
         "ranuras; con &eacute;l, STOP congela el juego cuadro a cuadro, sale "
         "F5 CONTINUE y un men&uacute; para elegir fase.</p>"),
    ],
    "en": [
        ("The locked doors are vendors",
         "<p>There are <b>33</b> in the castle. What happens when you hit "
         "them depends on their class and on how many hits they have taken "
         "(table <code>0x9300</code>): one opens the shop on the first, "
         "another on the fifth, another can take five hearts away, and they "
         "all leave on the eighth.</p>"),
        ("The books change the prices",
         "<p>With the white book the shop charges less, and with the red one "
         "more: full life costs 15, 40 or 80 hearts "
         "(<code>p02:9418</code>). Seen in openMSX.</p>"),
        ("Dracula, half sprite and half VDP",
         "<p>The head is a sprite; the body is copied by the VDP from page 1 "
         "with LMMM, after saving the background (<code>p03:AD80</code>). "
         "Checked down to zero in his four frames.</p>"),
        ("Two titles in one cartridge",
         "<p><em>Vampire Killer</em> or <em>Akumaj&#333; Dracula</em>, "
         "depending on BIOS byte <code>0x002B</code>, the country one "
         "(<code>p00:4D9E</code>).</p>"),
        ("A tile read from RAM",
         "<p><code>p00:54E4</code> uploads 640 bytes from <code>0xBDC8</code>; "
         "the last 0x48 already fall at <code>0xC000</code>, the RAM.</p>"),
        ("With a Game Master, another pause",
         "<p>The cartridge looks for <em>Konami's Game Master</em> in the four "
         "slots; with it, STOP freezes the game frame by frame, F5 CONTINUE "
         "shows up and a menu picks the stage.</p>"),
    ],
}

# (imagen, pie en castellano, pie en ingles). El logotipo de la cabecera es
# LOGOTIPO: el titulo que pinta el cartucho, no un montaje.
LOGOTIPO = "titulo.png"
GALERIA = [
    ("titulo.png",
     "El t&iacute;tulo, montado desde la ROM y cotejado a 0 bytes.",
     "The title screen, built from the ROM and checked down to 0 bytes."),
    ("titulo_japon.png",
     "El mismo cartucho con la BIOS japonesa (<code>0x002B</code>).",
     "The same cartridge with the Japanese BIOS (<code>0x002B</code>)."),
    ("castillo.png",
     "Las 19 fases y sus 156 habitaciones, cada una montada desde las tablas "
     "del banco 11 y cotejada a 0 bytes.",
     "The 19 stages and their 156 rooms, each built from the tables in bank "
     "11 and checked down to 0 bytes."),
    ("fase_01.png",
     "La fase 1 con lo que esconde: velas, bloques, cofres, llaves y la "
     "puerta de salida.",
     "Stage 1 with what it hides: candles, blocks, chests, keys and the exit "
     "door."),
    ("simon.png",
     "Simon, piernas y cuerpo por separado, como los compone el c&oacute;digo.",
     "Simon, legs and body apart, as the code puts them together."),
    ("enemigos.png",
     "Los enemigos y los jefes, un tipo por fila, desde <code>0xB473</code>.",
     "The enemies and the bosses, one type per row, from <code>0xB473</code>."),
    ("dracula.png",
     "Dr&aacute;cula de pie en la sala del retrato, en sus cuatro dibujos.",
     "Dracula standing in the portrait room, in his four frames."),
    ("lo_que_lanzan.png",
     "Lo que lanzan: la lista de <code>0xD700</code>, con sus propios tipos.",
     "What they throw: the list at <code>0xD700</code>, with its own types."),
    ("konami.png",
     "El tel&oacute;n de Konami, que <code>p01:624C</code> copia l&iacute;nea a "
     "l&iacute;nea.",
     "Konami's curtain, which <code>p01:624C</code> copies line by line."),
]
