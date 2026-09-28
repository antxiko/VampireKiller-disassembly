# El código

## Todo corre en la interrupción

INIT (0x4075) prepara la máquina, engancha H.TIMI y deja el Z80 en un
`jr $`. Desde entonces todo el juego corre en **p00:4028**, una vez por
cuadro:

1. la pausa del Game Master, si lo hay (p00:40C5);
2. el sonido, con los bancos 14 y 15 puestos;
3. si no se está ya dentro (el semáforo de 0xC005), la **máquina de estados**.

Al acabar devuelve los bancos que guardan 0xF0F2 y 0xF0F3.

## El despachador

p00:406B es el despachador de Konami: la tabla de destinos va **pegada detrás
del `call`**. Saca de la pila la dirección de vuelta, que es la base de la
tabla, y salta al destino número A. El listado marca cada una de esas tablas
como datos y nombra sus destinos.

## Los estados del juego

0xC000 es el estado y 0xC001 el subestado (tabla de 0x4161, p00:417D):

| estado | qué es |
|---|---|
| 0 | la presentación (el telón de Konami) |
| 1 | el título |
| 2 | la demostración |
| 3 | empieza la partida |
| 4 | empieza una vida |
| 5 | el juego |
| 6 | Simon muere |
| 7 | GAME OVER (con F5 CONTINUE si hay Game Master) |
| 8 | bloque acabado, tras el jefe |
| 9 | cambio de habitación |
| 0x0A | fase acabada (la puerta) |
| 0x0B | la pausa (F1) |
| 0x0C | la tienda |
| 0x0D | el menú del Game Master |

El subestado va en B y cada `djnz` salta al siguiente: lo primero tras el
primer `djnz` es el subestado 1, y lo último, el 0.

## Simon

0xC420 es el estado de Simon (p01:6B39): 0 de pie o andando, 1 saltando, 2
agachado, 3 en la escalera, 4 cayendo, 5 golpeado (p01:6F85), 6 muere
(p01:7093) y 7 se va **por un paso**: agachado encima de un paso y con el
salto, Simon pasa a la habitación que dice 0xC5B4 (p01:70FB, p01:6DA9). Los choques con el decorado están en p01:7D68. El látigo
y las cinco armas tienen su propia ficha (0xC450 y 0xC460).

## Una habitación

Al entrar (estado 9, p01:62F5):

- la habitación sale de 0x6013 (banco 11) con el número de 0x6000[fase] más
  el de la habitación: 48 bloques;
- cada bloque son 16 dibujos (0x7EBB[fase], bancos 11 a 13), y se dejan en
  el búfer 0xD100;
- se pinta desde 0xD140 en la página 0: 22 filas de dibujos, desde la y 32;
- su guion (0x9AB0) pone su paleta y sube los patrones de sus enemigos;
- p00:5B1B recorre sus secretos (0xE000): las velas y los bloques pasan a
  0xC470; los objetos, a 0xC500; los vendedores, a p02:9179;
- se crean sus enemigos (0x8668 del banco 14, p01:6181);
- p01:6321 enciende la pantalla.

## Los enemigos

Cada enemigo es una ficha de la lista 0xC800. Al crearlo, p00:5F48 le pone sus
sprites (0x6058 + tipo), sus colores (0x6084) y su vida (0x60E1). Cada cuadro,
el código de su tipo (banco 3, por el despachador) lo mueve, y p01:6445 lo
compone con la tabla de 0xB473: [dy][dx][patrón] por sprite. El dragón de
huesos (0x0E) no pasa por ahí: coloca sus sprites él mismo. El tipo 0x17 no
lleva sprites.

Lo que lanzan va en otra lista, 0xD700 (p02:9E5C), con sus propios tipos.

## El sonido

p00:509F recibe el número en A: 0 calla todo, 0x80-0xFA es una música (tres
canales del PSG, tabla 0x8DC9 del banco 14: **16 músicas**) y 1-0x7F un efecto
(**29**, en 0x8D8F). Un efecto solo suena si su número no es menor que el del
que ya suena (0xC096 hace de prioridad). La partitura (p14:8BB4) tiene órdenes
desde 0xD0: 0xDx pone el tempo, 0xE0-0xE5 la octava…

## Cómo está hecho el listado

- `tools/bancos.py` traza **el cartucho entero** llevando la cuenta de qué
  banco hay en cada hueco; de ahí salen las llamadas que cruzan el mapper
  (`src/pNN.entries`) y las tablas del despachador (`src/pNN.nocode`).
- `tools/z80trace.py` sigue el flujo de cada banco desde esas entradas.
- `src/pNN.notes` guarda las etiquetas, los comentarios y los rangos de
  datos, anclados a dirección; `tools/mkasm.py` los mezcla con el trazado y
  escribe `src/vampirekiller_pNN.asm`.
- `make verify` reensambla los dieciséis bancos con Pasmo y la ROM entera, y
  compara los sha256.

La densidad: **49,4 %** de las 14.502 instrucciones llevan comentario, y las
1.909 rutinas pasan todas del 10 % (`make densidad`).
