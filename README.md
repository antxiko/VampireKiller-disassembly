# Vampire Killer — a commented disassembly

*(También disponible [en castellano](README.es.md).)*

A commented disassembly of ***Vampire Killer*** (*Akumajō Dracula* in Japan),
Konami, 1986, cartridge **RC-744** for the **MSX2**: a 128 KB MegaROM with
Konami's mapper without SCC, sixteen 8 KB banks.

**The website**: https://antxiko.github.io/VampireKiller-disassembly/

| | |
|---|---|
| explained | 100% (29,786 bytes of code, 101,286 of data) |
| commented | 49.4% of the instructions |
| routines | 1,909, none below 10% |
| reassembly | the ROM, byte for byte |
| pictures | drawn from the ROM and checked against openMSX |

## What is here

- The listing of the sixteen banks (`src/vampirekiller_pNN.asm`), generated
  from the binary and the notes, which reassembles the exact ROM.
- The whole castle: the 19 stages and their 156 rooms, with what each one
  hides (candles, blocks, chests, keys, vendors), built from the cartridge's
  tables.
- Simon, the enemies, the six bosses and what they throw, put together from
  their tables; Dracula, with the body the VDP draws.
- Six checks against openMSX dumps (`make coteja`).

## How to reproduce it

You need Python 3 (with Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
and **your own cartridge image** as `vampirekiller.rom` at the root:

```
sha256  99eabaaeb2b6c02220e131043d5a6401d0d8c5f413d89204547adcc04d65e7e2
make
```

The details are in [Getting started](docs/GETTING-STARTED.md).

## Notice

The game belongs to Konami; only the analysis, the comments and the tools are
here. The ROM is not distributed. See [LEGAL-NOTICE.md](LEGAL-NOTICE.md).
