# The cartridge

| | |
|---|---|
| title | *Vampire Killer* / *Akumajō Dracula* (Konami, 1986) |
| number | RC-744 |
| machine | MSX2 (V9938, 128 KB of VRAM), SCREEN 5 |
| size | 131,072 bytes: 16 banks of 8 KB |
| mapper | Konami without SCC (Konami4) |
| sound | PSG, three channels |
| sha256 | `99eabaaeb2b6c02220e131043d5a6401d0d8c5f413d89204547adcc04d65e7e2` |

## The mapper

Bank 0 is **fixed** at 0x4000-0x5FFF. The other three windows are chosen by
writing the bank number to 0x6000, 0x8000 and 0xA000. There is not a single
write to 0x5000, 0x7000, 0x9000 or 0xB000, the registers of the mapper with
SCC: that is why it is Konami4.

There are **39 writes** to the mapper (`tools/reconocimiento.py`), and no bank
shows up in two different windows. So each bank has one single address where
it runs, and the listing can be split into sixteen modules, one per bank,
each with its own `org`:

| window | banks |
|---|---|
| 0x4000 (fixed) | 0 |
| 0x6000 | 1, 4, 11 |
| 0x8000 | 2, 5, 7, 9, 12, 14 |
| 0xA000 | 3, 6, 8, 10, 13, 15 |

They are loaded three at a time (`ld a,N` / `inc a` / `inc a`: 1-2-3, 4-5-6,
11-12-13) or two at a time (7-8, 9-10, 14-15). Each window's bank is kept at
0xF0F2 and 0xF0F3, and the interrupt puts it back when it is done (p00:4042).

## What each bank holds

| bank | code | what it holds |
|---|---|---|
| 0 | 7,173 B | start-up, the interrupt, the game states, the VRAM, the status bar, the secrets on entering |
| 1 | 6,996 B | building the room, the sprites, Simon and his collisions, the ending |
| 2 | 6,987 B | the items, the vendors, the enemies (list 0xC800) and what they throw (0xD700), the scroll's map |
| 3 | 7,400 B | each enemy type and the bosses, Dracula included |
| 4, 5, 6 | — | the tiles of stages 0 to 12; bank 6 also how each enemy is put together (0xB473) |
| 7, 8 | — | the tiles of stages 13 to 18 |
| 9 | — | the always-loaded tiles (p00:5670), each room's script and palettes |
| 10 | — | palettes per room and stage, compressed graphics |
| 11 | — | the 156 rooms (0x6013) |
| 12, 13 | 211 B | the 32 × 32 blocks; in 13, which room each exit leads to (p13:B963) and each stage's door |
| 14 | 1,019 B | what each room hides (0x8000), its enemies (0x8668) and the **sound**: 16 tunes (0x8DC9) and 29 effects |
| 15 | — | the scores |

In all, **29,786 bytes of code and 101,286 of data**: 100% of the cartridge
accounted for (`make sanity`).

## The VRAM

The game runs in **SCREEN 5**: 256 pixels wide, 16 colours out of a palette
of 512 (p00:4B61). **Page 1** of the VRAM is the store: that is where the
stage's 191 8 × 8 background tiles go when it starts, along with the 16 × 16
items (rows 0x50, 0x60 and 0x70) and the five 32 × 32 vendors (row 0xA0). Page 0
is the screen: the room is drawn from the buffer at 0xD100, and the items, the
vendors and Dracula are copied from page 1 with the VDP commands (LMMM, HMMM,
HMMC).

The sprites are **mode 2** (16 × 16, coloured line by line). Since the VDP
draws no more than eight on a line, p01:6560 **rotates their order every
frame** when it copies them to the VRAM, so the flicker is shared out. So the
VRAM table is almost never in the RAM's order (0xD400 and 0xD600), and
Simon's check is done against the RAM.

## The RAM that matters

| address | what it is |
|---|---|
| 0xC000 / 0xC001 | the game state and its sub-state |
| 0xC413 | a life is under way |
| 0xC415 | Simon's life (0x20 full) |
| 0xC420-0xC46F | Simon: state (0xC420), y (0xC425), x (0xC427), legs (0xC42E), body (0xC42F) |
| 0xC434 | the ring's counter |
| 0xC800 | the enemy list |
| 0xD000 / 0xD001 / 0xD002 | stage, room and block of three stages |
| 0xD012 | the difficulty level (0-3) |
| 0xD700 | what the enemies throw |
| 0xE000 | the stage's secrets, copied from bank 14 |
| 0xE600 | 0xFF if there is a Game Master in another slot |
