# El cartucho

| | |
|---|---|
| título | *Vampire Killer* / *Akumajō Dracula* (Konami, 1986) |
| número | RC-744 |
| máquina | MSX2 (V9938, 128 KB de VRAM), SCREEN 5 |
| tamaño | 131.072 bytes: 16 bancos de 8 KB |
| mapper | Konami sin SCC (Konami4) |
| sonido | PSG, tres canales |
| sha256 | `99eabaaeb2b6c02220e131043d5a6401d0d8c5f413d89204547adcc04d65e7e2` |

## El mapper

El banco 0 está **fijo** en 0x4000-0x5FFF. Los otros tres huecos se eligen
escribiendo el número de banco en 0x6000, 0x8000 y 0xA000. No hay ni una
escritura a 0x5000, 0x7000, 0x9000 ni 0xB000, los registros del mapper con
SCC: por eso es Konami4.

Hay **39 escrituras** al mapper (`tools/reconocimiento.py`), y ningún banco
aparece en dos huecos distintos. Así que cada banco tiene una sola dirección
donde se ejecuta, y el listado se puede partir en dieciséis módulos, uno por
banco, cada uno con su `org`:

| hueco | bancos |
|---|---|
| 0x4000 (fijo) | 0 |
| 0x6000 | 1, 4, 11 |
| 0x8000 | 2, 5, 7, 9, 12, 14 |
| 0xA000 | 3, 6, 8, 10, 13, 15 |

Se cargan de tres en tres (`ld a,N` / `inc a` / `inc a`: 1-2-3, 4-5-6,
11-12-13) o de dos en dos (7-8, 9-10, 14-15). El banco de cada hueco se guarda
en 0xF0F2 y 0xF0F3, y la interrupción lo devuelve al acabar (p00:4042).

## Qué hay en cada banco

| banco | código | qué lleva |
|---|---|---|
| 0 | 7.173 B | el arranque, la interrupción, los estados del juego, la VRAM, el marcador, los secretos al entrar |
| 1 | 6.996 B | montar la habitación, los sprites, Simon y sus choques, el final |
| 2 | 6.987 B | los objetos, los vendedores, los enemigos (lista 0xC800) y lo que lanzan (0xD700), el mapa del pergamino |
| 3 | 7.400 B | cada tipo de enemigo y los jefes, Drácula incluido |
| 4, 5, 6 | — | los dibujos de las fases 0 a 12; el 6, además, cómo se compone cada enemigo (0xB473) |
| 7, 8 | — | los dibujos de las fases 13 a 18 |
| 9 | — | los dibujos de siempre (p00:5670), el guion de cada habitación y paletas |
| 10 | — | paletas por habitación y fase, gráficos comprimidos |
| 11 | — | las 156 habitaciones (0x6013) |
| 12, 13 | 211 B | los bloques de 32 × 32; en el 13, a qué habitación se sale (p13:B963) y la puerta de cada fase |
| 14 | 1.019 B | lo que esconde cada habitación (0x8000), sus enemigos (0x8668) y el **sonido**: 16 músicas (0x8DC9) y 29 efectos |
| 15 | — | las partituras |

En total, **29.786 bytes de código y 101.286 de datos**: el 100 % del
cartucho asignado (`make sanity`).

## La VRAM

El juego corre en **SCREEN 5**: 256 puntos de ancho, 16 colores de una paleta
de 512 (p00:4B61).
La **página 1** de la VRAM es el almacén: ahí se suben al entrar en la fase
los 191 dibujos de 8 × 8 del decorado, los objetos de 16 × 16 (filas 0x50,
0x60 y 0x70) y las cinco puertas de 32 × 32 (fila 0xA0). La página 0 es la
pantalla: la habitación se pinta desde el búfer 0xD100, y los objetos, las
puertas y Drácula se copian desde la página 1 con las órdenes del VDP (LMMM,
HMMM, HMMC).

Los sprites son de **modo 2** (16 × 16, color por línea). Como el VDP no pinta
más de ocho en una línea, p01:6560 **rota su orden cada cuadro** al copiarlos
a la VRAM, para que el parpadeo se reparta. Así la tabla de la VRAM casi nunca
está en el orden de la RAM (0xD400 y 0xD600), y el cotejo de Simon se hace
contra la RAM.

## La RAM que importa

| dirección | qué es |
|---|---|
| 0xC000 / 0xC001 | el estado del juego y su subestado |
| 0xC413 | hay una vida en marcha |
| 0xC415 | la vida de Simon (0x20 llena) |
| 0xC420-0xC46F | Simon: estado (0xC420), y (0xC425), x (0xC427), piernas (0xC42E), cuerpo (0xC42F) |
| 0xC434 | la cuenta del anillo |
| 0xC800 | la lista de enemigos |
| 0xD000 / 0xD001 / 0xD002 | fase, habitación y bloque de tres fases |
| 0xD012 | la vuelta (0-3) |
| 0xD700 | lo que lanzan los enemigos |
| 0xE000 | los secretos de la fase, copiados del banco 14 |
| 0xE600 | 0xFF si hay un Game Master en otra ranura |
