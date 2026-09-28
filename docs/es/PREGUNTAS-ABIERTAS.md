# Preguntas abiertas

Lo que el listado no sabe todavía. Todo el cartucho está asignado a código o
a datos, pero asignado no es entendido del todo.

## Qué pasa con la vuelta 3

El final sube la vuelta (0xD012) hasta 2, y los vendedores de clase 1 hasta 3
(ver [Hallazgos](HALLAZGOS.md)). Los que la leen la comentan como «0, 1 o 2».
Con 3, p03:A35A espera 0x30 − 4 × 3 cuadros y p03:A65A suma 32 por vuelta:
no se ha visto en el emulador si el juego se comporta bien.

## Qué cuenta 0xCF34

El estado 8, tras el sexto bloque, vuelve al primero con la vida llena y suma
uno a 0xCF34; cuando llega a 2, va a la presentación (p00:433A). No se ha
seguido qué lo pone a cero ni cómo se enlaza con el final de p01:66F1.

## Los enemigos sin nombre

Los nombres de la hoja son por el dibujo. Hay cuatro que no se sabe qué son:
la figura de túnica morada (0x01), la criatura roja (0x03) y las dos siluetas
azules (0x04 y 0x1F). Y los tres que sueltan los secretos del tipo 0x15 (0x1A,
0x1B y 0x1C, por la tabla de 0x8AF0) no salen en la hoja.

## El tipo 0x21

Está en la fase 10 y se vio en una muestra, pero su fila de la hoja sale
vacía. No se sabe si es un enemigo invisible a propósito o si la muestra lo
pilló a medias.

## Las plataformas de la fase 5

En la fase 5 hay plataformas hechas con sprites (p02:902D, tabla 0x906C: una
en la habitación 1 y dos en la 4). Las láminas del mapa no las dibujan.

## Las dos salidas sin vuelta

(13, 11) → 9 y (17, 10) → 11 son salidas de ida que no son caídas ni la
entrada al jefe. Están leídas de la tabla 0xB9D3; no se ha comprobado en el
emulador qué ve el jugador al cruzarlas.

## Las músicas, sin partitura

Las 16 músicas y los 29 efectos están localizados y el intérprete comentado
(p14:8A64, p14:8BB4, p14:8CA7), pero no se han pasado a notas.
