#!/usr/bin/env python3
"""Anota lo que ya esta identificado: rutinas con nombre, RAM y cambios de banco.

Una vez se sabe que 0xC425 es la x de Simon no tiene merito -ni fiabilidad-
escribir a mano "la x de Simon" las cincuenta veces que aparece. Esto lo hace
de una vez y sin equivocarse, en una seccion delimitada de src/pNN.notes que
reescribe entera cada vez.

- RUTINAS: el nombre de cada rutina (directiva L) y, en cada `call`/`jp` que
  va a ella, un comentario con lo que hace.
- RAM: en cada instruccion que nombra una direccion de la tabla, que es.
- Los cambios de banco (`ld (0x6000/0x8000/0xA000),a` con un `ld a,N` o un
  `inc a` delante) y las copias en 0xF0F1-0xF0F3.

CADA ENTRADA LLEVA DE DONDE SALE. Lo que no se sabe no esta en la tabla.
Donde ya hay un comentario escrito a mano no se pone otro.

Uso: anota.py              informa de cuantos pondria
     anota.py --escribe    y los escribe
"""
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from paginas import ORG                                    # noqa: E402

BANCOS = (0, 1, 2, 3, 13, 14)
INI = "# --- ANOTACIONES AUTOMATICAS (seccion que reescribe tools/anota.py; no editar a mano) ---"
FIN = "# --- fin de las anotaciones de anota.py ---"

# (banco, direccion) -> (nombre, lo que hace; de donde se sabe va en el texto)
RUTINAS = {
    (0, 0x4028): ("interrupcion", "cada cuadro: sonido, y el juego entero corre desde aqui"),
    (0, 0x4030): ("sonido_del_cuadro", "pone los bancos 14 y 15, llama al reproductor y los devuelve"),
    (0, 0x4061): ("hl_mas_a", "HL += A"),
    (0, 0x4066): ("de_mas_a", "DE += A"),
    (0, 0x406B): ("despacha", "salta a la entrada A de la tabla que va detras del call"),
    (0, 0x4075): ("init", "arranque del cartucho: RAM a cero, VDP, sonido, y engancha H.TIMI"),
    (0, 0x414D): ("maquina_de_estados", "sube el contador de cuadros y despacha por el estado de 0xC000"),
    (0, 0x41B6): ("cambia_de_estado", "estado nuevo en 0xC000 (A) y 0x20 cuadros de espera en 0xC004"),
    (0, 0x4675): ("copia_a_la_vram", "BC bytes de HL a la VRAM de DE"),
    (0, 0x46AF): ("vram_para_escribir", "prepara el V9938 para escribir en la direccion HL"),
    (0, 0x46CE): ("vram_para_leer", "prepara el V9938 para leer de la direccion HL"),
    (0, 0x46EB): ("rle_con_destino", "descomprime a la VRAM un rle que lleva el destino delante"),
    (0, 0x46F1): ("rle_a_la_vram", "descomprime a la VRAM (HL) el rle de DE"),
    (0, 0x4714): ("guion_de_carga", "interpreta un guion de carga de la VRAM (0xFF acaba)"),
    (0, 0x473E): ("voltea_dibujos", "da la vuelta a dibujos que ya estan en la VRAM"),
    (0, 0x47C7): ("enciende_la_pantalla", "bit 6 del registro 1 del VDP a uno"),
    (0, 0x47D4): ("apaga_la_pantalla", "bit 6 del registro 1 del VDP a cero"),
    (0, 0x4814): ("pon_un_color", "color A de la paleta = DE (y su copia en 0xF680)"),
    (0, 0x483E): ("pon_paleta", "lista de [color][RB][G] hasta 0xFF"),
    (0, 0x484C): ("espera_al_vdp", "espera a que el V9938 acabe la orden (bit 0 de S#2)"),
    (0, 0x4855): ("lee_estado_del_vdp", "lee el registro de estado A del V9938"),
    (0, 0x490A): ("rellena_rectangulo", "orden del V9938 que rellena un rectangulo (desde R#36)"),
    (0, 0x4946): ("copia_rectangulo", "orden del V9938 que copia un rectangulo de VRAM a VRAM (desde R#32)"),
    (0, 0x498A): ("hmmc", "orden HMMC del V9938: puntos de HL a la VRAM"),
    (0, 0x4A27): ("sube_letras", "B caracteres de 1 bit de HL, pintados de color"),
    (0, 0x4A30): ("sube_una_letra", "un caracter de 1 bit de HL"),
    (0, 0x4A51): ("sube_un_dibujo", "un dibujo de 8x8 a 4 bits (32 bytes) de HL a la VRAM de DE"),
    (0, 0x4A66): ("sube_dibujos", "B dibujos de 8x8 a 4 bits de HL a la VRAM de DE"),
    (0, 0x4A90): ("sube_dibujos_de_16", "B dibujos de 16x16 a 4 bits de HL"),
    (0, 0x4ACB): ("rotulo", "pinta un rotulo ([x][y] y texto; 0xFE otra posicion, 0xFF acaba)"),
    (0, 0x4ACF): ("borra_rotulo", "lo mismo que 0x4ACB pero borrando"),
    (0, 0x4FB6): ("monta_la_habitacion", "construye la habitacion en RAM con los bancos 11-12-13"),
    (0, 0x509F): ("sonido", "arranca la musica o el efecto A (bit 7 = musica)"),
    (0, 0x5336): ("bancos_1_2_3", "vuelve a poner los bancos 1, 2 y 3"),
    (0, 0x5350): ("bancos_14_15", "pone el sonido (14 y 15) en 0x8000 y 0xA000"),
    (0, 0x5362): ("bancos_11_12_13", "pone los bancos del mapa (11, 12 y 13)"),
    (0, 0x537A): ("bancos_9_10", "pone los bancos 9 y 10 en 0x8000 y 0xA000"),
    (0, 0x538C): ("bancos_7_8", "pone los bancos 7 y 8 en 0x8000 y 0xA000"),
    (0, 0x539E): ("bancos_4_5_6", "pone los bancos 4, 5 y 6"),
    (0, 0x564C): ("sube_los_dibujos_de_la_fase", "los 191 dibujos del decorado de la fase de 0xD000"),
    (0, 0x582D): ("dibujo_de_32_filas", "desempaqueta un dibujo de 32 filas a 0xE800"),
    (0, 0x5F1D): ("crea_una_cosa", "crea una cosa del tipo C en la posicion DE"),
    (1, 0x6542): ("palabra_de_la_tabla", "DE = la palabra A de la tabla de DE"),
    (1, 0x6D4D): ("aplica_la_curva", "sube la cuenta de (HL) hasta D y suma a la y de Simon el paso de la curva de BC"),
    (1, 0x765F): ("pose_segun_el_lado", "ajusta las poses de 0xC42E/0xC42F al lado al que mira Simon"),
    (1, 0x7B32): ("rotulo_por_filas", "pinta caracteres; 0xFE [dx] baja una fila, 0xFF acaba"),
    (1, 0x7B88): ("mira_el_suelo", "mira el decorado bajo los pies de Simon (y de 0xC425, x de 0xC427)"),
    (1, 0x7B98): ("choca_con_el_decorado", "mira las dos celdas del decorado en (E, D) y (E, D-10)"),
    (1, 0x7C5E): ("es_pared", "carry si el bloque de la celda es de los que paran (tope por fase de 0x7C78)"),
    (1, 0x7D2F): ("celda_del_mapa", "de una posicion en puntos (E, D) a su celda en el mapa de la habitacion"),
    (2, 0x99F6): ("borra_la_cosa", "tipo a cero y sus sprites libres"),
    (2, 0x9F6D): ("crea_con_parametros", "guarda el tipo (A) y los parametros en 0xCFF1-0xCFF9 y crea la cosa"),
    (3, 0xA17C): ("niega_de", "DE = -DE"),
    (3, 0xA549): ("suma_a_la_velocidad_y", "la gravedad: DE a la velocidad vertical, con tope 0x07FF"),
    (3, 0xA55D): ("pon_velocidad_y", "velocidad vertical de la cosa ((ix+7), (ix+8)) = DE"),
    (3, 0xA56C): ("pon_velocidad_x", "velocidad horizontal de la cosa ((ix+9), (ix+10)) = DE"),
    (3, 0xA62F): ("dibujo_de_la_tabla", "(ix+0x0B) = el dibujo C de la tabla de HL"),
    (3, 0xAD37): ("dibujo_segun_simon", "como 0xA62F, dos mas adelante si Simon esta a su derecha"),
    (3, 0xAF40): ("distancia_horizontal", "A = |x de Simon - x de la cosa|"),
    (3, 0xBE3D): ("siguiente_paso", "sube el paso de la escena (0xCE01)"),
    (13, 0xB963): ("sale_de_la_habitacion", "la habitacion a la que se sale por el lado de 0xC41B"),
    (13, 0xB99A): ("salidas_de_la_habitacion", "copia las cuatro salidas a 0xC41C-0xC41F"),
    (14, 0x8964): ("reproductor", "un cuadro de sonido: los tres canales y los efectos"),
    (14, 0x89CE): ("canal_en_reposo", "el canal que no suena"),
    (14, 0x8A0B): ("volumen_del_canal", "escribe el volumen E en el registro 8+canal del PSG"),
}

# direccion -> (que es, de donde se sabe)
RAM = {
    0xC000: ("el ESTADO del juego", "p00:4151 despacha por el"),
    0xC001: ("el subestado", "p00:4151 lo carga en B con el estado"),
    0xC003: ("el contador de cuadros", "p00:414D lo sube cada cuadro"),
    0xC004: ("la espera del estado, en cuadros", "p00:41B6 la pone a 0x20"),
    0xC005: ("el semaforo de la interrupcion", "p00:404E: no se entra dos veces"),
    0xC010: ("el manejador del canal A del sonido", "p14:89A7 salta por el"),
    0xC012: ("el manejador del canal B", "p14:89B0"),
    0xC014: ("el manejador del canal C", "p14:89B9"),
    0xC016: ("el manejador del efecto de sonido", "p14:89C3"),
    0xC018: ("el manejador del segundo efecto", "p14:89F9"),
    0xC01A: ("el manejador de la musica de la pausa", "p14:89F2"),
    0xC094: ("el canal del PSG que se esta tocando", "p14:89C6"),
    0xC095: ("el numero de canal", "p14:89CA"),
    0xC096: ("la prioridad del efecto que suena", "p00:5172 no deja pisarlo con uno menor"),
    0xC097: ("la copia del registro 7 del PSG (el mezclador)", "p14:8964 la escribe cada cuadro"),
    0xC098: ("las banderas del sonido (bit 0 pausa, bit 1 ...)", "p00:51C4 y p00:5276"),
    0xC0A5: ("la cuenta del fundido de la musica", "p14:897A"),
    0xC0A6: ("el volumen que se le resta a la musica", "p14:8984 lo baja al fundir"),
    0xC410: ("las vidas", "p00:44D3 empieza con 3 y el Game Master las da en 0xE607"),
    0xC411: ("la fase en BCD, la del marcador", "p00:4357 la sube con la de 0xD000"),
    0xC415: ("la vida de Simon", "p00:44DE la llena (0x20) al empezar y al pasar de fase"),
    0xC416: ("el arma que lleva Simon (0, ninguna)", "p00:5596 elige sus dibujos por ella"),
    0xC417: ("los corazones, en BCD", "p01:7170 le resta 5 con `daa`"),
    0xC418: ("la vida del enemigo (barra ENEMY)", "p00:44E3 la llena (0x80)"),
    0xC41A: ("la habitacion especial", "p00:4FCD: con ella puesta el mapa sale de 0x614B"),
    0xC41B: ("el lado por el que se sale de la habitacion", "p13:B963 lo usa de nibble"),
    0xC424: ("la fraccion de la y de Simon", "p01:6E14 suma en 16 bits a 0xC424"),
    0xC425: ("la Y de Simon", "p01:7B88 la compara con 0xD0, el suelo; y en las cosas la y es (ix+3), que p02:99E5 borra pasado 0xE4"),
    0xC426: ("la fraccion de la x de Simon", "p01:6C94 suma en 16 bits a 0xC426"),
    0xC427: ("la X de Simon", "p03:AF40 la resta de (ix+5), la x de las cosas, que p02:99EC borra fuera de 7..0xF0"),
    0xC42C: ("el lado al que mira Simon", "p01:6402 lo saca del bit 0 de la tabla de salida"),
    0xC42E: ("la pose de arriba de Simon", "p01:785C elige por ella en 0x7985"),
    0xC42F: ("la pose de abajo de Simon", "p01:787E elige por ella en 0x79D5"),
    0xC5AC: ("el estado de la puerta de la fase", "p13:BB5D lo pone a 4 o a 0xFF"),
    0xC5AD: ("donde esta la puerta de la fase", "p13:BB52"),
    0xC5B2: ("el paso a otra habitacion", "p13:BBBA"),
    0xC5B4: ("la habitacion a la que lleva el paso", "p13:BBC9"),
    0xC5D5: ("el destino del montaje de la habitacion", "p00:4FF0"),
    0xC5D7: ("la habitacion que se monta", "p00:4FE0"),
    0xC5D8: ("la fase de la habitacion que se monta", "p00:4FD6"),
    0xCE01: ("el paso de la escena", "p03:BE3D lo sube"),
    0xCE31: ("el renglon del final que toca", "p01:6757"),
    0xCE33: ("la cuenta del texto del final", "p01:6761 la compara con cada renglon"),
    0xCE39: ("la cuenta del destello", "p01:67E4 la hace volver a cero a los 19"),
    0xCF00: ("los plazos de las siete cosas de la habitacion", "p02:9CA9 los pone"),
    0xCF10: ("el reloj de los plazos", "p02:9CC4 lo baja"),
    0xCFF0: ("el tipo de la cosa que se crea", "p00:5F2B"),
    0xCFF1: ("la posicion de la cosa que se crea", "p00:5F2E"),
    0xCFF3: ("la ficha de la cosa que se crea", "p00:5F45"),
    0xD000: ("la FASE (0 el patio, 1-18)", "p00:4357 la sube y 0x5742 tiene una entrada por fase"),
    0xD001: ("la HABITACION dentro de la fase", "p00:5797 elige por ella en la tabla de habitaciones"),
    0xD002: ("el bloque de tres fases (0-5)", "p00:5E4B lo saca de 0x5E6A"),
    0xE600: ("la PAUSA", "p00:4028: si no es cero, la interrupcion solo mira el teclado"),
    0xE605: ("la fase del marcador que da el Game Master", "p00:5E40"),
    0xE606: ("la fase que da el Game Master", "p00:5E35"),
    0xE607: ("las vidas que da el Game Master", "p00:5E63"),
    0xF0F1: ("la copia del banco de 0x6000", "se escribe con el registro del mapper"),
    0xF0F2: ("la copia del banco de 0x8000", "p00:403F la devuelve al mapper"),
    0xF0F3: ("la copia del banco de 0xA000", "p00:4045 la devuelve al mapper"),
}

# Lo que es la PALABRA que empieza en esa direccion, para `ld hl,(nn)`,
# `ld (nn),de`... cuando no es lo mismo que el byte.
RAM16 = {
    0xC000: "el estado (0xC000) y el subestado (0xC001) de un tiron",
    0xC424: "la y de Simon con su fraccion (0xC424 la fraccion, 0xC425 la y)",
    0xC426: "la x de Simon con su fraccion (0xC426 la fraccion, 0xC427 la x)",
    0xC42E: "las dos poses de Simon (0xC42E arriba, 0xC42F abajo)",
    0xD000: "la fase (0xD000) y la habitacion (0xD001) de un tiron",
}

REGISTROS_MAPPER = {0x6000: "0x6000", 0x8000: "0x8000", 0xA000: "0xA000"}


def listado(b):
    filas = []
    for ln in open(os.path.join(RAIZ, "src", "vampirekiller_p%02d.asm" % b), encoding="utf-8"):
        m = re.match(r"\t([a-z][^\t;]*?)\s*;([0-9a-f]{4})", ln)
        if m and not ln.startswith("\tdefb"):
            filas.append((int(m.group(2), 16), m.group(1).strip()))
    return filas


def a_mano(b):
    """Direcciones con C escrita fuera de la seccion, y los L ya puestos."""
    ruta = os.path.join(RAIZ, "src", "p%02d.notes" % b)
    cs, ls, dentro = set(), set(), False
    for ln in open(ruta, encoding="utf-8"):
        if ln.startswith(INI):
            dentro = True
        elif ln.startswith(FIN):
            dentro = False
        elif not dentro and ln.startswith("C "):
            cs.add(int(ln.split()[1], 0))
        elif not dentro and ln.startswith("L "):
            ls.add(int(ln.split()[1], 0))
    return cs, ls


def valor(txt):
    txt = txt.strip()
    return int(txt[:-1], 16) if txt.endswith("h") else int(txt, 0)


def por_nombre():
    """nombre de etiqueta del listado -> (banco, direccion)."""
    return {}


def comentario(b, filas, k):
    a, t = filas[k]
    # llamadas y saltos a rutinas con nombre
    m = re.match(r"(call|jp)\s+(?:(?:nz|z|nc|c|po|pe|p|m),)?(?:L_([0-9A-F]{4})|0([0-9a-f]{4})h|([a-z_][a-z0-9_]*))$", t)
    if m and m.group(4):
        # ya lleva el nombre puesto: basta con decir que hace
        for (bb, aa), (nom, que) in RUTINAS.items():
            if nom == m.group(4):
                return "%s: %s" % (nom, que)
        m = None
    if m:
        dest = int(m.group(2) or m.group(3), 16)
        for (bb, aa), (nom, que) in RUTINAS.items():
            if bb in (13, 14) and b != bb:
                continue            # esos bancos solo estan puestos cuando llaman ellos mismos
            if aa == dest and (bb == b or ORG[bb] == 0x4000 or not (ORG[b] <= dest < ORG[b] + 0x2000)):
                if bb == 0 or ORG[bb] <= dest < ORG[bb] + 0x2000:
                    return "%s: %s" % (nom, que)
    # cambios de banco
    m = re.match(r"ld \(0(6000|8000|a000)h\),a$", t)
    if m:
        reg = int(m.group(1), 16)
        return "el mapper: pone en %s el banco de A" % REGISTROS_MAPPER[reg]
    # RAM
    m16 = re.match(r"ld (?:(hl|de|bc|ix|iy),\(0([c-f][0-9a-f]{3})h\)|\(0([c-f][0-9a-f]{3})h\),(hl|de|bc|ix|iy))$", t)
    if m16:
        v = int(m16.group(2) or m16.group(3), 16)
        if v in RAM16:
            return ("lee " if m16.group(1) else "guarda ") + RAM16[v]
    for x in re.findall(r"\b0([c-f][0-9a-f]{3})h\b", t):
        v = int(x, 16)
        if v in RAM:
            que = RAM[v][0]
            if re.match(r"ld \(0%04xh\)," % v, t):
                return "guarda %s" % que
            if re.match(r"ld [a-z]+,\(0%04xh\)$" % v, t):
                return "lee %s" % que
            if re.match(r"ld (hl|de|bc|ix|iy),0%04xh$" % v, t):
                return "apunta a %s" % que
            return que
    return None


def main(argv):
    total = 0
    for b in BANCOS:
        filas = listado(b)
        cs, ls = a_mano(b)
        lineas = []
        for (bb, aa), (nom, que) in sorted(RUTINAS.items()):
            if bb == b and aa not in ls:
                lineas.append("L 0x%04X %s" % (aa, nom))
        n = 0
        for k, (a, t) in enumerate(filas):
            if a in cs:
                continue
            c = comentario(b, filas, k)
            if c:
                lineas.append("C 0x%04X %s" % (a, c))
                n += 1
        total += n
        print("p%02d: %d comentarios, %d nombres" % (b, n, sum(1 for l in lineas if l.startswith("L "))))
        if "--escribe" in argv:
            ruta = os.path.join(RAIZ, "src", "p%02d.notes" % b)
            viejas = open(ruta, encoding="utf-8").read().split("\n")
            nuevas, dentro = [], False
            for ln in viejas:
                if ln.startswith(INI):
                    dentro = True
                    continue
                if ln.startswith(FIN):
                    dentro = False
                    continue
                if not dentro:
                    nuevas.append(ln)
            while nuevas and not nuevas[-1].strip():
                nuevas.pop()
            nuevas += ["", INI] + lineas + [FIN, ""]
            open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas))
    print("en total: %d comentarios" % total)


if __name__ == "__main__":
    main(sys.argv)
