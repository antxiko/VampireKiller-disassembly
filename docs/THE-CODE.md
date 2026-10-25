# The code

## Everything runs in the interrupt

INIT (0x4075) sets up the machine, hooks H.TIMI and leaves the Z80 on a
`jr $`. From then on the whole game runs in **p00:4028**, once per frame:

1. the Game Master's pause, if there is one (p00:40C5);
2. the sound, with banks 14 and 15 in place;
3. unless it is already inside (the semaphore at 0xC005), the **state
   machine**.

When it is done it puts back the banks kept at 0xF0F2 and 0xF0F3.

## The dispatcher

p00:406B is Konami's dispatcher: the jump table sits **right after the
`call`**. It pops the return address, which is the base of the table, and
jumps to entry number A. The listing marks each of those tables as data and
names their targets.

## The game states

0xC000 is the state and 0xC001 the sub-state (table at 0x4161, p00:417D):

| state | what it is |
|---|---|
| 0 | the intro (Konami's curtain) |
| 1 | the title |
| 2 | the demo |
| 3 | a game starts |
| 4 | a life starts |
| 5 | playing |
| 6 | Simon dies |
| 7 | GAME OVER (with F5 CONTINUE if there is a Game Master) |
| 8 | block cleared, after the boss |
| 9 | room change |
| 0x0A | stage cleared (the door) |
| 0x0B | the pause (F1) |
| 0x0C | the shop |
| 0x0D | the Game Master's menu |

The sub-state goes in B and each `djnz` jumps to the next one: the first
thing after the first `djnz` is sub-state 1, and the last, 0.

## Simon

0xC420 is Simon's state (p01:6B39): 0 standing or walking, 1 jumping, 2
crouching, 3 on the stairs, 4 falling, 5 hit (p01:6F85), 6 dies (p01:7093)
and 7 goes **through a passage**: crouching on top of a passage and pressing
jump, Simon goes to the room 0xC5B4 names (p01:70FB, p01:6DA9). The
collisions with the background are at p01:7D68. The whip and the five
weapons have their own records (0xC450 and 0xC460).

## A room

On entering (state 9, p01:62F5):

- the room comes from 0x6013 (bank 11) with the number at 0x6000[stage] plus
  the room's own: 48 blocks;
- each block is 16 tiles (0x7EBB[stage], banks 11 to 13), and they are left
  in the buffer at 0xD100;
- it is drawn from 0xD140 onto page 0: 22 rows of tiles, from y 32;
- its script (0x9AB0) sets its palette and uploads its enemies' patterns;
- p00:5B1B walks its secrets (0xE000): candles and blocks go to 0xC470; items,
  to 0xC500; vendors, to p02:9179;
- its enemies are created (0x8668 in bank 14, p01:6181);
- p01:6321 switches the screen on.

## The enemies

Each enemy is a record in the list at 0xC800. When creating it, p00:5F48
gives it its sprites (0x6058 + type), its colours (0x6084) and its life
(0x60E1). Every frame, its type's code (bank 3, through the dispatcher) moves
it, and p01:6445 puts it together with the table at 0xB473: [dy][dx][pattern]
per sprite. The bone dragon (0x0E) does not go through there: it places its
sprites itself. Type 0x17 has no sprites.

What they throw goes in another list, 0xD700 (p02:9E5C), with its own types.

## The sound

p00:509F takes the number in A: 0 silences everything, 0x80-0xFA is a tune
(three PSG channels, table 0x8DC9 in bank 14: **16 tunes**) and 1-0x7F an
effect (**29**, at 0x8D8F). An effect only plays if its number is not lower
than the one already playing (0xC096 acts as the priority). The score
(p14:8BB4) has commands from 0xD0 up: 0xDx sets the tempo, 0xE0-0xE5 the
octave…

## How the listing is made

- `tools/bancos.py` traces **the whole cartridge** keeping track of which
  bank is in each window; that gives the calls that cross the mapper
  (`src/pNN.entries`) and the dispatcher's tables (`src/pNN.nocode`).
- `tools/z80trace.py` follows each bank's flow from those entries.
- `src/pNN.notes` keeps the labels, the comments and the data ranges,
  anchored to addresses; `tools/mkasm.py` merges them with the trace and
  writes `src/vampirekiller_pNN.asm`.
- `make verify` reassembles the sixteen banks with Pasmo and the whole ROM,
  and compares the sha256.

The density: **49.4%** of the 14,502 instructions carry a comment, and all
1,909 routines are above 10% (`make densidad`).

## Code shared with other Konami cartridges

This disassembly has been compared, instruction by instruction, with
every other Konami one in the series. A block counts when the same
instructions, at least six of them from a label to its `ret` or its
unconditional jump, are in both cartridges; the addresses are left
aside, because they change from one cartridge to the next. Of the
other 57, **41** have at least one block in common with this one;
these are the ones that share the most:

| Cartridge | Blocks | Instructions | For example (here = there) |
|---|---:|---:|---|
| [Ganbare Goemon! Karakuri Dōchū](https://antxiko.github.io/GanbareGoemon-disassembly/) | 90 | 1,495 | `hmmc` (p00:498A) |
| [Hinotori](https://antxiko.github.io/Hinotori-disassembly/) | 68 | 1,051 | `copia_con_operacion` (p00:49DB) = `lmmm` |
| [King Kong 2: Yomigaeru Densetsu](https://antxiko.github.io/KingKong2-disassembly/) | 68 | 1,003 | `copia_con_operacion` (p00:49DB) = `lmmm` |
| [The Treasure of Usas](https://antxiko.github.io/TreasureOfUsas-disassembly/) | 58 | 935 | `hmmc` (p00:498A) |
| [Metal Gear](https://antxiko.github.io/MetalGear-disassembly/) | 40 | 672 | `copia_con_operacion` (p00:49DB) = `copia_logica` |
| [The Pro Yakyuu Gekitotsu Pennant Race](https://antxiko.github.io/PennantRace-disassembly/) | 30 | 497 | `hmmc` (p00:498A) = `rectangulo_desde_ram` |
| [Konami’s Game Master 2](https://antxiko.github.io/GameMaster2-disassembly/) | 27 | 488 | `hmmc` (p00:498A) = `vdp_hmmc` |
| [The Maze of Galious](https://antxiko.github.io/MazeOfGalious-disassembly/) | 22 | 320 | `cuenta_del_paso` (p14:8CA7) = `paso_de_envolvente` |
| [Hai no Majutsushi - Mahjong 2](https://antxiko.github.io/Majutsushi-disassembly/) | 20 | 209 | `rle_con_destino` (p00:46EB) = `vuelca_lista_vram` |
| [Gekitotsu Pennant Race 2](https://antxiko.github.io/PennantRace2-disassembly/) | 18 | 252 | `rellena_rectangulo` (p00:490A) = `borra_bloque_vram` |

The whole matrix, the 58 cartridges against each other, is on
[The routines](https://antxiko.github.io/MSX-disassembly-database/THE-ROUTINES.html) in the series database, along
with the method and the program that measures it.
