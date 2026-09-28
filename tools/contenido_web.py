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
              "los enemigos, los seis jefes y la tienda, con las tablas del "
              "cartucho, y "
              "<b>cotejadas contra openMSX</b> en una m&aacute;quina MSX2: 0 bytes "
              "distintos en las habitaciones, el t&iacute;tulo, Simon, "
              "Dr&aacute;cula y la tienda. El listado y las cifras se reproducen con "
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
              "hide, Simon, the enemies, the six bosses and the shop, with the "
              "cartridge's own tables, and <b>checked against openMSX</b> on an "
              "MSX2 machine: 0 bytes different in the rooms, the title, Simon, "
              "Dracula and the shop. The listing and the numbers are reproducible with "
              "<code>make</code>, and reassembling gives back the ROM <b>byte "
              "for byte</b>.",
    ),
}

HALLAZGOS = {
    "es": [
        ("Los vendedores son viejos, y cuentan los golpes",
         "<p>Hay <b>33</b> en el castillo: 16 a la vista y 17 dentro de "
         "bloques que se rompen. Es un viejo encapuchado, el mismo dibujo en "
         "cinco colores (fila <code>0xA0</code> de la p&aacute;gina 1). Lo que "
         "pasa al pegarle depende de su clase y de cu&aacute;ntos golpes lleva "
         "(tabla <code>0x9300</code>): la tienda al primero, al tercero o al "
         "quinto; cinco corazones m&aacute;s o menos; y al octavo se va con "
         "5.000 puntos.</p><p>El color dice lo que toca (<code>0x9320</code>): "
         "rojo, la tienda; rosa, corazones; azul, <code>0xD012</code>; blanco, "
         "nada. Al morir, la cuenta vuelve a cero. Visto en openMSX golpe a "
         "golpe.</p>"),
        ("Los libros cambian los precios",
         "<p>Con el libro blanco la tienda cobra menos, y con el rojo, "
         "m&aacute;s (<code>0xC702</code>, <code>p02:9418</code>): la vida "
         "llena cuesta 15, 40 u 80 corazones; el bast&oacute;n, 20, 30 o 60. "
         "Coger un libro quita el otro (<code>p02:8E1D</code>, "
         "<code>8E26</code>).</p><p>Cotejado contra seis volcados de la tienda "
         "abierta: 0 puntos distintos.</p>"),
        ("El final trae su historia y sus cr&eacute;ditos",
         "<p>Tras Dr&aacute;cula, <code>p01:66BA</code> sube un texto "
         "rengl&oacute;n a rengl&oacute;n con el registro 23 del VDP: ocho "
         "l&iacute;neas de historia (<em>SO THE BRAVE YOUNG MAN PUT DRACULA "
         "INTO DEEP SLEEP AGAIN&hellip;</em>) y el STAFF, veinte nombres, del "
         "GAME DESIGNER A. NAGATA a PRODUCED BY AKIHIKO NAGATA (tabla "
         "<code>0x678E</code>, bancos 5 y 8).</p><p>En la ROM los puntos son "
         "&laquo;:&raquo; y el ap&oacute;strofo es &laquo;;&raquo;: la fuente "
         "que <code>p00:53DE</code> sube para el final los dibuja "
         "as&iacute;.</p>"),
        ("Dr&aacute;cula, medio sprite y medio VDP",
         "<p>La cabeza es un sprite. El cuerpo, de 32 &times; 32, no cabe: el "
         "cartucho guarda el fondo en la p&aacute;gina 1 (<code>0x80, "
         "0x80</code>) y copia el cuerpo con LMMM y transparencia "
         "(<code>p03:AD80</code>, <code>AD93</code>).</p><p>Al cambiar de "
         "dibujo, el nuevo se pinta encima del anterior sin devolver el fondo. "
         "Cotejado a cero en sus cuatro dibujos.</p>"),
        ("La sala de Dr&aacute;cula sale con una fila corrida",
         "<p><code>p00:5969</code> voltea los dibujos de la sala del retrato "
         "escribiendo las filas hacia atr&aacute;s, y la &uacute;ltima cae "
         "fuera: se suben las filas 6 a 0 y cuatro bytes que ya "
         "hab&iacute;a.</p><p>El juego lo pinta as&iacute;, y el cotejo solo "
         "da cero reproduciendo el fallo.</p>"),
        ("Lo que esconden velas, bloques y cofres",
         "<p>Lo dicen los bits bajos de cada secreto (banco 14): 129 "
         "corazones, 100 corazones grandes, 77 llaves, 21 llaves "
         "blancas&hellip; y en 52 sitios, <b>un enemigo</b> (tipo "
         "<code>0x15</code>, tabla <code>0x8AF0</code>).</p><p>Todo marcado en "
         "las 19 l&aacute;minas del mapa.</p>"),
        ("Casi todo lo que recoge Simon es un bit",
         "<p>Muchos objetos solo encienden un bit o una cuenta "
         "(<code>p02:8D3E</code>): el anillo, que <b>mata al tocar</b> "
         "mientras dura (<code>0xC434</code>), el reloj de arena, el lazo, las "
         "botas, las alas, los libros, el bast&oacute;n.</p><p>El pergamino da "
         "tres usos del mapa de la fase con F2 (<code>0xC70F</code>, "
         "<code>p02:9552</code>).</p>"),
        ("Con un Game Master, otra pausa",
         "<p>El cartucho busca en las cuatro ranuras la firma del <em>Konami's "
         "Game Master</em> (<code>p00:5C92</code>) y la apunta en "
         "<code>0xE600</code>.</p><p>Con &eacute;l, STOP congela el juego "
         "desde la interrupci&oacute;n y <code>;</code> avanza un cuadro; tras "
         "el GAME OVER sale F5 CONTINUE; y desde el t&iacute;tulo hay un "
         "men&uacute; que elige la fase.</p>"),
        ("Dos t&iacute;tulos en un cartucho",
         "<p><em>Vampire Killer</em> o <em>Akumaj&#333; Dracula</em>, "
         "seg&uacute;n el byte de pa&iacute;s de la BIOS (<code>0x002B</code>, "
         "<code>p00:4D9E</code>).</p><p>Los dos, cotejados a cero con la BIOS "
         "europea y con la japonesa.</p>"),
        ("Un dibujo que se lee de la RAM",
         "<p><code>p00:54E4</code> sube 640 bytes desde <code>0xBDC8</code>, "
         "pero el cartucho acaba en <code>0xBFFF</code>: los &uacute;ltimos "
         "0x48 se leen ya de la RAM.</p>"),
    ],
    "en": [
        ("The vendors are old men, and they count the hits",
         "<p>There are <b>33</b> in the castle: 16 in plain sight and 17 "
         "inside breakable blocks. Each one is a hooded old man, the same "
         "drawing in five colours (row <code>0xA0</code> of page 1). What "
         "happens when you hit him depends on his class and on how many hits "
         "he has taken (table <code>0x9300</code>): the shop on the first, the "
         "third or the fifth; five hearts more or less; and on the eighth he "
         "leaves, with 5,000 points.</p><p>The colour tells what comes "
         "(<code>0x9320</code>): red, the shop; pink, hearts; blue, "
         "<code>0xD012</code>; white, nothing. Dying resets the count. Seen in "
         "openMSX hit by hit.</p>"),
        ("The books change the prices",
         "<p>With the white book the shop charges less, and with the red one "
         "more (<code>0xC702</code>, <code>p02:9418</code>): full life costs "
         "15, 40 or 80 hearts; the staff, 20, 30 or 60. Picking up one book "
         "takes away the other (<code>p02:8E1D</code>, "
         "<code>8E26</code>).</p><p>Checked against six dumps of the open "
         "shop: 0 dots different.</p>"),
        ("The ending carries its story and its credits",
         "<p>After Dracula, <code>p01:66BA</code> scrolls up a text line by "
         "line with VDP register 23: eight lines of story (<em>SO THE BRAVE "
         "YOUNG MAN PUT DRACULA INTO DEEP SLEEP AGAIN&hellip;</em>) and the "
         "STAFF, twenty names, from GAME DESIGNER A. NAGATA to PRODUCED BY "
         "AKIHIKO NAGATA (table <code>0x678E</code>, banks 5 and 8).</p><p>In "
         "the ROM the full stops are &ldquo;:&rdquo; and the apostrophe is "
         "&ldquo;;&rdquo;: the font that <code>p00:53DE</code> uploads for the "
         "ending draws them that way.</p>"),
        ("Dracula, half sprite and half VDP",
         "<p>The head is a sprite. The 32 &times; 32 body does not fit: the "
         "cartridge saves the background on page 1 (<code>0x80, 0x80</code>) "
         "and copies the body with LMMM and transparency "
         "(<code>p03:AD80</code>, <code>AD93</code>).</p><p>When the drawing "
         "changes, the new one is painted over the old one without restoring "
         "the background. Checked down to zero in his four frames.</p>"),
        ("Dracula's room comes out with a shifted row",
         "<p><code>p00:5969</code> flips the tiles of the portrait room "
         "writing the rows backwards, and the last one lands outside: it "
         "uploads rows 6 to 0 and four bytes that were already "
         "there.</p><p>The game draws it that way, and the check only reaches "
         "zero by reproducing the bug.</p>"),
        ("What candles, blocks and chests hide",
         "<p>The low bits of each secret say it (bank 14): 129 hearts, 100 big "
         "hearts, 77 keys, 21 white keys&hellip; and in 52 places, <b>an "
         "enemy</b> (type <code>0x15</code>, table "
         "<code>0x8AF0</code>).</p><p>All of it marked on the 19 map "
         "sheets.</p>"),
        ("Nearly everything Simon picks up is a bit",
         "<p>Many items only switch on a bit or a counter "
         "(<code>p02:8D3E</code>): the ring, which <b>kills on touch</b> while "
         "it lasts (<code>0xC434</code>), the hourglass, the bow, the boots, "
         "the wings, the books, the staff.</p><p>The scroll gives three uses "
         "of the stage map with F2 (<code>0xC70F</code>, "
         "<code>p02:9552</code>).</p>"),
        ("With a Game Master, another pause",
         "<p>The cartridge looks in the four slots for the signature of "
         "<em>Konami's Game Master</em> (<code>p00:5C92</code>) and notes it "
         "in <code>0xE600</code>.</p><p>With it, STOP freezes the game from "
         "the interrupt and <code>;</code> steps one frame; after GAME OVER, "
         "F5 CONTINUE shows up; and from the title there is a menu that picks "
         "the stage.</p>"),
        ("Two titles in one cartridge",
         "<p><em>Vampire Killer</em> or <em>Akumaj&#333; Dracula</em>, "
         "depending on the BIOS country byte (<code>0x002B</code>, "
         "<code>p00:4D9E</code>).</p><p>Both checked down to zero, with the "
         "European BIOS and with the Japanese one.</p>"),
        ("A drawing read from RAM",
         "<p><code>p00:54E4</code> uploads 640 bytes from <code>0xBDC8</code>, "
         "but the cartridge ends at <code>0xBFFF</code>: the last 0x48 are "
         "already read from RAM.</p>"),
    ],
}

# (imagen, pie en castellano, pie en ingles). El logotipo de la cabecera es
# LOGOTIPO: el titulo que pinta el cartucho, no un montaje.
LOGOTIPO = "titulo.png"
GALERIA = [
    ("titulo.png",
     "El t&iacute;tulo europeo montado desde la ROM: el azul de "
     "<code>p00:4D74</code>, los 0x59 dibujos de <code>0xB260</code> "
     "(banco 8) y el PUSH SPACE KEY. Cotejado a 0 bytes.",
     "The European title built from the ROM: the blue of "
     "<code>p00:4D74</code>, the 0x59 tiles at <code>0xB260</code> (bank "
     "8) and the PUSH SPACE KEY. Checked down to 0 bytes."),
    ("titulo_japon.png",
     "Con la BIOS japonesa (<code>0x002B</code>), el mismo cartucho monta "
     "<em>Akumaj&#333; Dracula</em>: 0x1E dibujos de <code>0xAEA0</code> y "
     "un RLE del banco 13. Tambi&eacute;n a 0 bytes.",
     "With the Japanese BIOS (<code>0x002B</code>), the same cartridge "
     "builds <em>Akumaj&#333; Dracula</em>: 0x1E tiles at "
     "<code>0xAEA0</code> and an RLE from bank 13. Also down to 0 bytes."),
    ("castillo.png",
     "Las 19 fases y sus 156 habitaciones en la rejilla de "
     "<code>0x9695</code>. Cada habitaci&oacute;n son 8 &times; 6 bloques "
     "de 32 &times; 32 (banco 11) y est&aacute; cotejada a 0 bytes.",
     "The 19 stages and their 156 rooms on the grid at "
     "<code>0x9695</code>. Each room is 8 &times; 6 blocks of 32 &times; "
     "32 (bank 11) and is checked down to 0 bytes."),
    ("fase_01.png",
     "Lo que esconde la fase 1 (lista del banco 14): velas, bloques, "
     "cofres, llaves, el vendedor y la puerta de salida "
     "(<code>0xBB61</code>). Hay una l&aacute;mina as&iacute; por fase.",
     "What stage 1 hides (the list in bank 14): candles, blocks, chests, "
     "keys, the vendor and the exit door (<code>0xBB61</code>). There is a "
     "sheet like this for every stage."),
    ("vendedores.png",
     "El vendedor, un viejo encapuchado que <code>p00:54F0</code> colorea "
     "cinco veces sobre el molde de <code>0xBDA7</code>. Sale blanco; al "
     "pegarle parpadea con el negro y se queda del color de lo que toca: "
     "rojo, la tienda; rosa, corazones; azul, <code>0xD012</code>; blanco, "
     "nada o se va.",
     "The vendor, a hooded old man that <code>p00:54F0</code> colours five "
     "times over the mould at <code>0xBDA7</code>. He comes out white; "
     "when hit he blinks with the black one and stays in the colour of "
     "what comes: red, the shop; pink, hearts; blue, <code>0xD012</code>; "
     "white, nothing or he leaves."),
    ("tienda.png",
     "La tienda del bast&oacute;n (fase 4) sin libro, con el libro blanco "
     "y con el rojo: 30, 20 y 60 corazones (<code>0x9428</code>). Pintada "
     "como <code>p02:9397</code> y cotejada a 0 puntos contra seis "
     "volcados.",
     "The staff shop (stage 4) with no book, with the white book and with "
     "the red one: 30, 20 and 60 hearts (<code>0x9428</code>). Drawn as "
     "<code>p02:9397</code> does and checked down to 0 dots against six "
     "dumps."),
    ("objetos.png",
     "Los 29 objetos con dibujo, en el orden de su tipo, del "
     "<code>0x01</code> al <code>0x1E</code> (el <code>0x15</code> no "
     "tiene: sale un enemigo). Filas 0x50 y 0x60 de la p&aacute;gina 1 "
     "(<code>p00:548D</code>).",
     "The 29 items that have a drawing, in the order of their type, from "
     "<code>0x01</code> to <code>0x1E</code> (<code>0x15</code> has none: "
     "an enemy comes out). Rows 0x50 and 0x60 of page 1 "
     "(<code>p00:548D</code>)."),
    ("simon.png",
     "Simon son dos mitades, piernas (<code>0xC42E</code>) y cuerpo "
     "(<code>0xC42F</code>), con sprites de 16 &times; 16 y color por "
     "l&iacute;nea. Cotejado contra los 156 volcados.",
     "Simon is two halves, legs (<code>0xC42E</code>) and body "
     "(<code>0xC42F</code>), with 16 &times; 16 sprites and colour per "
     "line. Checked against the 156 dumps."),
    ("enemigos.png",
     "Los enemigos y los seis jefes, un tipo de la lista de "
     "<code>0xC800</code> por fila, compuestos desde <code>0xB473</code>. "
     "De 58.430 muestras de openMSX, ninguna sin explicar.",
     "The enemies and the six bosses, one type of the list at "
     "<code>0xC800</code> per row, built from <code>0xB473</code>. Of "
     "58,430 openMSX samples, none unexplained."),
    ("dracula.png",
     "Dr&aacute;cula de pie en la sala del retrato, en sus cuatro dibujos: "
     "sprites arriba y el cuerpo copiado por el VDP "
     "(<code>p03:AD93</code>).",
     "Dracula standing in the portrait room, in his four frames: sprites "
     "on top and the body copied by the VDP (<code>p03:AD93</code>)."),
    ("lo_que_lanzan.png",
     "Los disparos de los enemigos, en la lista de <code>0xD700</code>, "
     "que numera sus tipos aparte (<code>p02:9E5C</code>).",
     "The enemies' shots, in the list at <code>0xD700</code>, which "
     "numbers its types apart (<code>p02:9E5C</code>)."),
    ("konami.png",
     "El tel&oacute;n de Konami, que <code>p01:624C</code> copia "
     "l&iacute;nea a l&iacute;nea desde la p&aacute;gina 1.",
     "Konami's curtain, which <code>p01:624C</code> copies line by line "
     "from page 1."),
]
