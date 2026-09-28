# En el emulador

Todo lo que se dibuja en esta web está cotejado contra **openMSX** con una
máquina MSX2 (`C-BIOS_MSX2_EU`, y `C-BIOS_MSX2_JP` para el título japonés).
Las sondas son guiones Tcl que ponen el cartucho donde hace falta tocando la
RAM y vuelcan la VRAM entera (128 KB), la paleta y los registros del VDP en el
momento justo.

## Las sondas

| sonda | qué vuelca | lanzador | volcados |
|---|---|---|---|
| `omsx_titulo.tcl` | el telón de Konami y el título | `lanza_titulo.sh` | 4 |
| `omsx_habitacion.tcl` | cada habitación, al encenderse la pantalla | `lanza_habitaciones.sh` | 156 |
| `omsx_habitacion.tcl` | 250 cuadros de enemigos por habitación | `lanza_cosas.sh` | 156 |
| `omsx_habitacion.tcl` | Drácula de pie, en sus cuatro dibujos | `lanza_dracula.sh` | 4 |
| `omsx_lecturas.tcl` | qué lee el cartucho en cada fase | `lanza_fases.sh` | — |

`omsx_habitacion.tcl` arranca una partida, pone la fase en el `ret` de
p00:44E8 (0xD000, 0xC411 y 0xD002) y la habitación justo antes de que p01:62F5
la cargue (0xD001), y deja a Simon en el aire en medio de la pantalla. Cuando
p01:6321 enciende la pantalla espera medio segundo y vuelca. Se maneja con
variables de entorno:

```
VK_OUT=work/habitaciones VK_FASE=6 VK_HAB=1 \
openmsx -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script tools/omsx_habitacion.tcl
```

## Los cotejos

`make coteja` (o `python3 tools/coteja.py`) compara lo dibujado desde la ROM
con los volcados. Resultado actual:

| prueba | qué compara | resultado |
|---|---|---|
| `titulo` | telón y título, EU y JP: pantalla y paleta | 4 volcados, 0 con diferencias |
| `habitaciones` | las 156 habitaciones: lo pintado en la página 0, la paleta y lo subido a la página 1 | 156 volcados, 0 con diferencias |
| `mapa` | la rejilla del castillo y sus salidas | casillas sin repetir; 22 salidas de ida |
| `simon` | Simon, sprites y patrones contra la RAM | 156 volcados, 0 con diferencias |
| `dracula` | pantalla, fondo guardado, sprites y patrones | 4 volcados, 0 con diferencias |
| `enemigos` | la geometría de cada muestra contra 0xB473 | 58.430 con su dibujo; 0 sin explicar |

## Trucos para verlo

- La fase va en 0xD000 (0 el patio, 1-18), la habitación en 0xD001 y el
  bloque de tres fases en 0xD002.
- La vida de Simon es 0xC415 (0x20, llena).
- Con un *Konami's Game Master* en otra ranura, STOP congela el juego y `;`
  avanza un cuadro.
- La VRAM de sprites no sirve para cotejar a Simon: p01:6560 rota su orden
  cada cuadro. Hay que leer la RAM, 0xD400 y 0xD600.
