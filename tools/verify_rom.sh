#!/bin/sh
# Las 16 paginas reensambladas, concatenadas en orden, tienen que dar la ROM
# entera byte a byte. Es la prueba final: verify_build.sh ya comprobo cada
# pagina por separado, pero lo que se publica es un desensamblado de 128 KB
# y tiene que cerrar como tal.
#
# Uso: verify_rom.sh <dir_work> <rom_original> <sha256_esperado>

set -e
WORK="$1"
ROM="$2"
SHA="$3"
OUT="$WORK/reensamblada.rom"

rm -f "$OUT"
for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15; do
    if [ ! -f "$WORK/p$p.out.bin" ]; then
        echo "FALLO: falta $WORK/p$p.out.bin (ensambla antes las 16 paginas)"
        exit 1
    fi
    cat "$WORK/p$p.out.bin" >> "$OUT"
done

SZ_A=$(wc -c < "$OUT" | tr -d ' ')
SZ_B=$(wc -c < "$ROM" | tr -d ' ')
H_A=$(shasum -a 256 "$OUT" | cut -d' ' -f1)
H_B=$(shasum -a 256 "$ROM" | cut -d' ' -f1)
echo "== las 16 paginas concatenadas =="
echo "  reensamblada : $SZ_A bytes  $H_A"
echo "  original     : $SZ_B bytes  $H_B"
echo "  esperado     :              $SHA"
if [ "$H_A" = "$H_B" ] && [ "$H_A" = "$SHA" ]; then
    echo "OK: la ROM entera reproducible byte a byte"
    exit 0
fi
echo "DIFIERE"
exit 1
