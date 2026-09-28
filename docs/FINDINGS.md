# Findings

What turned up when the cartridge was taken apart. Each item carries the
address where it can be checked.

## The vendors are old men, and they count the hits

There are **33 vendors** (p02:9179): 16 in plain sight and 17 inside
breakable blocks. Each one is a hooded old man, the same drawing in five
colours (row 0xA0 of page 1); the colour tells what comes (0x9320): red, the
shop; pink, hearts; blue, 0xD012; white, nothing. Each one sells one thing
(table 0x5B0B), but what
happens depends on their **class** (two bits of the secret) and on **how many
times you have hit them**: the table at 0x9300 gives eight hits per class
(p02:92BB). A class 3 vendor does not open the shop until the fifth hit; a
class 2 one can take five hearts away; they all leave on the eighth. Dying
resets the count. Seen in openMSX hit by hit; the whole table is in
[The game](THE-GAME.md#the-vendors).

## The books change the prices

With the white book the shop charges less, and with the red one more
(0xC702, p02:9418): full life costs 15, 40 or 80 hearts depending on the
book. Seen in openMSX; the whole table is in [The game](THE-GAME.md#the-vendors).

## The ending carries its story and its credits

After Dracula, p01:66BA scrolls up a text line by line with VDP register 23:
eight lines of story ("SO THE BRAVE YOUNG MAN PUT DRACULA INTO DEEP SLEEP
AGAIN…") and the STAFF, twenty names, from GAME DESIGNER A. NAGATA to
PRODUCED BY AKIHIKO NAGATA (table 0x678E, banks 5 and 8). In the ROM the full
stops are ":" and the apostrophe is ";": the font that p00:53DE uploads for
the ending draws them that way. The whole text is in
[The game](THE-GAME.md#the-ending).

## Dracula is a sprite and a VDP drawing

Dracula's head is a sprite, but the body does not fit: the cartridge saves
the background on page 1 (0x80, 0x80) and copies the body from page 1 onto
the screen with LMMM and transparency (p03:AD80, p03:AD93). When it changes
frame, 0x5C is drawn **on top of** 0x5B without restoring the background.
Checked down to zero in the four frames (`coteja.py dracula`).

## Dracula's room comes out with a shifted row

The mirrored tiles of the portrait room go through p00:5969, which writes
them to RAM row by row **backwards** from 0xE818, four bytes at a time. Row 0
lands at 0xE818 and row 7 at 0xE7FC, outside the tile: what gets uploaded is
rows 6 to 0 and, at the bottom, the four bytes that were already at 0xE81C.
The game draws it that way, and `tools/graficos.py` reproduces it that way;
with that, the room checks down to zero.

## A tile that comes from RAM

p00:54E4 uploads 640 bytes of tiles from 0xBDC8. The cartridge ends at
0xBFFF: the last **0x48 bytes are read from 0xC000 onwards, which is RAM**.
They go to page 1 of the VRAM (x 64-79, rows 0x77-0x7F), in the fifth tile of
that batch. They do not come from the ROM, so the check leaves them out.

## With a Game Master, another pause and a menu

The normal pause is F1 (state 0x0B). But the cartridge also looks in the four
slots for the signature of *Konami's Game Master* (p00:5C92, at 0x7FFA) and
records in 0xE600 whether it is there. Only with it:

- STOP freezes the game **from the interrupt**, sound included (p00:40C5),
  and with that on the `;` key steps **one frame**;
- after GAME OVER, **F5 CONTINUE** shows up (p00:42EC);
- from the title you get into its **menu** (state 0x0D), which picks the
  stage (p00:5E4B).

## What Simon picks up: nearly all of it is a bit

Of the 25 items p02:8D3E handles (plus the five weapons, from 0x1A), many
only set a bit or a counter: the ring (0xC434, which **kills on touch** while
it lasts), the hourglass, the ribbon that lengthens the counters, the boots,
the wings, the books, the staff. That is why their names in this listing are
those of **their drawing** (row 0x50 or 0x60 of page 1), not of their effect.

The scroll (0x0F) gives **three uses of the map** (0xC70F): with F2 the play
area is cleared and every room of the stage is drawn, with Simon and an arrow
to the exit (p02:9552; the keys, at p00:4B9D).

## Two exits with no way back that are not drops

Of the castle's 22 one-way exits (0xB9D3), all are drops or the way into the
boss, except two: room 11 of stage 13 exits left to room 9, and room 10 of
stage 17 to room 11, and neither comes back (`coteja.py mapa`).

## The same frame as other Konami cartridges

The interrupt runs the whole game (p00:4028, through H.TIMI: INIT leaves the
Z80 on a `jr $`), the dispatcher at 0x406B reads its jump table stuck right
after the `call`, and each slot's bank is kept at 0xF0F2 and 0xF0F3 to put it
back after the interrupt. What changes here is **where** each bank goes: 1, 4
and 11 always at 0x6000; 2, 5, 7, 9, 12 and 14 at 0x8000; and the rest at
0xA000. Not one is mapped in two places (39 writes to the mapper,
`tools/reconocimiento.py`).
