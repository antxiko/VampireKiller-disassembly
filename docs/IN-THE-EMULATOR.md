# In the emulator

Everything drawn on this website is checked against **openMSX** on an MSX2
machine (`C-BIOS_MSX2_EU`, and `C-BIOS_MSX2_JP` for the Japanese title). The
probes are Tcl scripts that put the cartridge where it is needed by poking
the RAM, and dump the whole VRAM (128 KB), the palette and the VDP registers
at the right moment.

## The probes

| probe | what it dumps | launcher | dumps |
|---|---|---|---|
| `omsx_titulo.tcl` | Konami's curtain and the title | `lanza_titulo.sh` | 4 |
| `omsx_habitacion.tcl` | each room, when the screen comes on | `lanza_habitaciones.sh` | 156 |
| `omsx_habitacion.tcl` | 250 frames of enemies per room | `lanza_cosas.sh` | 156 |
| `omsx_habitacion.tcl` | Dracula standing, in his four frames | `lanza_dracula.sh` | 4 |
| `omsx_lecturas.tcl` | what the cartridge reads on each stage | `lanza_fases.sh` | — |

`omsx_habitacion.tcl` starts a game, sets the stage at the `ret` of p00:44E8
(0xD000, 0xC411 and 0xD002) and the room just before p01:62F5 loads it
(0xD001), and leaves Simon in mid-air in the middle of the screen. When
p01:6321 switches the screen on it waits half a second and dumps. It is
driven with environment variables:

```
VK_OUT=work/habitaciones VK_FASE=6 VK_HAB=1 \
openmsx -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script tools/omsx_habitacion.tcl
```

## The checks

`make coteja` (or `python3 tools/coteja.py`) compares what is drawn from the
ROM with the dumps. Current result:

| test | what it compares | result |
|---|---|---|
| `titulo` | curtain and title, EU and JP: screen and palette | 4 dumps, 0 with differences |
| `habitaciones` | the 156 rooms: what is drawn on page 0, the palette and what is uploaded to page 1 | 156 dumps, 0 with differences |
| `mapa` | the castle grid and its exits | no cell used twice; 22 one-way exits |
| `simon` | Simon, sprites and patterns against the RAM | 156 dumps, 0 with differences |
| `dracula` | screen, saved background, sprites and patterns | 4 dumps, 0 with differences |
| `enemigos` | each sample's geometry against 0xB473 | 58,430 with their drawing; 0 unexplained |

## Tips for watching it

- The stage is at 0xD000 (0 the courtyard, 1-18), the room at 0xD001 and the
  block of three stages at 0xD002.
- Simon's life is 0xC415 (0x20, full).
- With a *Konami's Game Master* in another slot, STOP freezes the game and
  `;` steps one frame.
- The sprite VRAM is no good for checking Simon: p01:6560 rotates their order
  every frame. Read the RAM instead, 0xD400 and 0xD600.
