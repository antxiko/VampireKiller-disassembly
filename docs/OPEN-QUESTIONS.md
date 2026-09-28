# Open questions

What the listing does not know yet. The whole cartridge is assigned to code
or data, but assigned is not the same as fully understood.

## What happens on loop 3

The ending raises the loop (0xD012) up to 2, and class 1 vendors up to 3 (see
[Findings](FINDINGS.md)). The routines that read it comment it as "0, 1 or
2". With 3, p03:A35A waits 0x30 − 4 × 3 frames and p03:A65A adds 32 per loop:
nobody has seen in the emulator whether the game behaves.

## What 0xCF34 counts

State 8, after the sixth block, goes back to the first with full life and
adds one to 0xCF34; when it reaches 2, it goes to the intro (p00:433A). What
resets it, and how it ties in with the ending at p01:66F1, has not been
followed.

## The nameless enemies

The names on the sheet go by the drawing. There are four whose identity is
unknown: the purple-robed figure (0x01), the red creature (0x03) and the two
blue outlines (0x04 and 0x1F). And the three that the type 0x15 secrets let
loose (0x1A, 0x1B and 0x1C, from the table at 0x8AF0) are not on the sheet.

## Type 0x21

It is on stage 10 and was seen in one sample, but its row on the sheet comes
out empty. It is not known whether it is an enemy meant to be invisible or
whether the sample caught it halfway.

## The platforms on stage 5

Stage 5 has platforms made of sprites (p02:902D, table 0x906C: one in room 1
and two in room 4). The map sheets do not draw them.

## The two exits with no way back

(13, 11) → 9 and (17, 10) → 11 are one-way exits that are neither drops nor
the way into the boss. They are read from the table at 0xB9D3; what the
player sees when crossing them has not been checked in the emulator.

## The music, without a score

The 16 tunes and the 29 effects are located and the player is commented
(p14:8A64, p14:8BB4, p14:8CA7), but they have not been turned into notes.
