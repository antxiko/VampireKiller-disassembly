# Hallazgos

Lo que apareció al desmontar el cartucho. Cada cosa lleva la dirección donde
se puede comprobar.

## Los vendedores son viejos, y cuentan los golpes

Hay **33 vendedores** (p02:9179): 16 a la vista y 17 dentro de bloques que se
rompen. Es un viejo encapuchado, el mismo dibujo en cinco colores (fila 0xA0
de la página 1); el color dice lo que toca (0x9320): rojo, la tienda; rosa,
corazones; azul, 0xD012; blanco, nada. Cada uno vende una cosa (tabla
0x5B0B), pero lo que pasa depende de su **clase** (dos bits del secreto) y de
**cuántas veces se le ha pegado**: la tabla 0x9300 da ocho golpes por clase
(p02:92BB). Un vendedor de clase 3 no abre la tienda hasta el quinto golpe;
uno de clase 2 puede quitar cinco corazones; todos se van en el octavo. Al
morir, la cuenta vuelve a cero. Visto en openMSX golpe a golpe; la tabla
entera está en [El juego](EL-JUEGO.md#los-vendedores).

## Los libros cambian los precios

Con el libro blanco la tienda cobra menos y con el rojo, más (0xC702,
p02:9418): la vida llena cuesta 15, 40 u 80 corazones según el libro. Visto
en openMSX; la tabla entera está en [El juego](EL-JUEGO.md#los-vendedores).

## El final trae su historia y sus créditos

Tras Drácula, p01:66BA sube un texto renglón a renglón con el registro 23 del
VDP: ocho líneas de historia («SO THE BRAVE YOUNG MAN PUT DRACULA INTO DEEP
SLEEP AGAIN…») y el STAFF, veinte nombres, del GAME DESIGNER A. NAGATA a
PRODUCED BY AKIHIKO NAGATA (tabla 0x678E, bancos 5 y 8). En la ROM los puntos
son «:» y el apóstrofo es «;»: la fuente que p00:53DE sube para el final los
dibuja así. El texto entero está en [El juego](EL-JUEGO.md#el-final).

## Drácula es un sprite y un dibujo del VDP

La cabeza de Drácula es un sprite, pero el cuerpo no cabe: el cartucho guarda
el fondo en la página 1 (0x80, 0x80) y copia el cuerpo desde la página 1 a la
pantalla con LMMM y transparencia (p03:AD80, p03:AD93). Cuando cambia de
dibujo, 0x5C se pinta **encima** de 0x5B sin devolver el fondo. Cotejado a
cero en los cuatro dibujos (`coteja.py dracula`).

## La sala de Drácula sale con una fila corrida

Los dibujos volteados de la sala del retrato pasan por p00:5969, que los
escribe en RAM fila a fila **hacia atrás** desde 0xE818, de cuatro en cuatro.
La fila 0 cae en 0xE818 y la 7 en 0xE7FC, fuera del dibujo: lo que se sube
son las filas 6 a 0 y, abajo, los cuatro bytes que ya había en 0xE81C. El
juego lo pinta así, y `tools/graficos.py` lo reproduce así; con eso, la sala
coteja a cero.

## Un dibujo que sale de la RAM

p00:54E4 sube 640 bytes de dibujos desde 0xBDC8. El cartucho acaba en 0xBFFF:
los últimos **0x48 bytes se leen de 0xC000 en adelante, que es la RAM**. Van
a la página 1 de la VRAM (x 64-79, filas 0x77-0x7F), en el quinto dibujo de
esa tanda. No salen de la ROM, así que el cotejo los excluye.

## Con un Game Master, otra pausa y un menú

La pausa normal es F1 (el estado 0x0B). Pero el cartucho busca además en las
cuatro ranuras la firma del *Konami's Game Master* (p00:5C92, en 0x7FFA) y
guarda en 0xE600 si está. Solo con él:

- STOP congela el juego **desde la interrupción**, sonido incluido
  (p00:40C5), y con eso puesto la tecla `;` avanza **un cuadro**;
- tras el GAME OVER aparece **F5 CONTINUE** (p00:42EC);
- desde el título se entra en su **menú** (el estado 0x0D), que elige la fase
  (p00:5E4B).

## Lo que recoge Simon: casi todo es un bit

De los 25 objetos que maneja p02:8D3E (y las cinco armas, desde el 0x1A),
muchos solo ponen un bit o una cuenta: el anillo (0xC434, que **mata al tocar**
mientras dura), el reloj de arena, el lazo que alarga las cuentas, las botas,
las alas, los libros, el bastón. Por eso sus nombres en este listado son los
de **su dibujo** (fila 0x50 o 0x60 de la página 1), no los de su efecto.

El pergamino (0x0F) da **tres usos del mapa** (0xC70F): con F2 se borra el
sitio de juego y se pintan todas las habitaciones de la fase, Simon y una
flecha a la salida (p02:9552; las teclas, en p00:4B9D).

## Dos salidas sin vuelta que no son caídas

De las 22 salidas de ida del castillo (0xB9D3), todas son caídas o la entrada
al jefe, menos dos: la habitación 11 de la fase 13 sale por la izquierda a la
9, y la 10 de la fase 17 a la 11, y ninguna de las dos vuelve (`coteja.py
mapa`).

## El mismo armazón que otros cartuchos de Konami

La interrupción corre todo el juego (p00:4028, por H.TIMI: INIT deja el Z80 en
un `jr $`), el despachador de 0x406B lee su tabla de destinos pegada detrás del
`call`, y el banco de cada ranura se guarda en 0xF0F2 y 0xF0F3 para
devolverlo tras la interrupción. Lo que cambia aquí es **dónde** va cada
banco: 1, 4 y 11 siempre en 0x6000; 2, 5, 7, 9, 12 y 14 en 0x8000; y el
resto en 0xA000. Ni uno solo se mapea en dos sitios (39 escrituras al mapper,
`tools/reconocimiento.py`).
