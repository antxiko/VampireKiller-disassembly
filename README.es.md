# Vampire Killer — desensamblado comentado

*(Also available [in English](README.md).)*

Desensamblado comentado de ***Vampire Killer*** (*Akumajō Dracula* en Japón),
Konami, 1986, cartucho **RC-744** para **MSX2**: un MegaROM de 128 KB con el
mapper Konami sin SCC, dieciséis bancos de 8 KB.

**La web**: https://antxiko.github.io/VampireKiller-disassembly/es/

| | |
|---|---|
| explicado | 100 % (29.786 bytes de código, 101.286 de datos) |
| comentado | 49,4 % de las instrucciones |
| rutinas | 1.909, ninguna por debajo del 10 % |
| reensamblado | la ROM, byte a byte |
| imágenes | dibujadas desde la ROM y cotejadas contra openMSX |

## Qué hay

- El listado de los dieciséis bancos (`src/vampirekiller_pNN.asm`), que se
  genera desde el binario y las notas y reensambla la ROM exacta.
- El castillo entero: las 19 fases y sus 156 habitaciones, con lo que esconde
  cada una (velas, bloques, cofres, llaves, vendedores), montadas desde las
  tablas del cartucho.
- Simon, los enemigos, los seis jefes y lo que lanzan, compuestos desde sus
  tablas; Drácula, con el cuerpo que dibuja el VDP.
- Seis cotejos contra volcados de openMSX (`make coteja`).

## Cómo reproducirlo

Hace falta Python 3 (con Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
y **tu propia imagen del cartucho** como `vampirekiller.rom` en la raíz:

```
sha256  99eabaaeb2b6c02220e131043d5a6401d0d8c5f413d89204547adcc04d65e7e2
make
```

Los detalles, en [Empezar](docs/es/EMPEZAR.md).

## Aviso

El juego es de Konami; aquí solo están el análisis, los comentarios y las
herramientas. La ROM no se distribuye. Ver [AVISO-LEGAL.md](AVISO-LEGAL.md).
