# Getting started

To reproduce this disassembly you need Python 3 (with Pillow for the
pictures), GNU make and [Pasmo](https://pasmo.speccy.org/). The cartridge
image **does not travel in this repository**: bring your own.

```
vampirekiller.rom    131,072 bytes
sha256               99eabaaeb2b6c02220e131043d5a6401d0d8c5f413d89204547adcc04d65e7e2
```

With the file at the root of the repository:

```
make            # listing, verification, consistency and tests
```

## What each step does

| command | what it does |
|---|---|
| `make comprueba` | checks the ROM's sha256 |
| `make listado` | generates the sixteen `.asm` files from the binary, the notes and the seeds |
| `make verify` | reassembles each bank and the whole ROM, and compares the sha256 |
| `make sanity` | checks that not a single byte is left unassigned to code or data |
| `make test` | the tests |
| `make densidad` | how many instructions carry a comment, bank by bank |
| `make imagenes` | draws the PNGs in `docs/imagenes/` from the ROM |
| `make coteja` | checks the pictures against the openMSX dumps in `work/` |
| `make web` | generates the HTML pages and checks the links |

`make verify` is the one that decides: it has to print
`OK: reproducible byte a byte` sixteen times, once per bank, and at the end
`OK: la ROM entera reproducible byte a byte`.

`make coteja` needs the openMSX dumps, which do not travel in the repository:
they are made with the launchers in [In the emulator](IN-THE-EMULATOR.md).

## Where everything is

- `src/vampirekiller_pNN.asm`: the listing, one per bank. **It is
  generated**: do not edit it by hand.
- `src/pNN.notes`: the labels (`L`), the line comments (`C`), the data ranges
  (`D`) and the routine headers (`B`). This **is** edited.
- `src/pNN.entries` and `src/pNN.nocode`: each bank's entry points and the
  tables that are not code, taken from the trace of the whole cartridge
  (`make semillas`).
- `tools/`: the tracer, the listing generator and the tools that draw and
  check.
- `docs/`: this website, in English at the root and in Spanish under
  `docs/es/`.
