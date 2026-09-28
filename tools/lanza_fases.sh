#!/bin/sh
# lanza_fases.sh: las lecturas de datos de cada fase (tools/omsx_lecturas.tcl),
# de la 0 (el patio) a la 18, en work/omsx/fNN.txt. UN openMSX cada vez.
R=$(cd "$(dirname "$0")/.." && pwd)
mkdir -p $R/work/omsx
for f in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18; do
  n=$(printf %02d $f)
  ( cd $R && VK_OUT="$R/work/omsx/f$n.txt" VK_SEGS=30 VK_FASE=$f VK_FOTOS="20" \
    VK_TECLAS="4:8:1:0.2 7:8:1:0.2 10:8:1:0.2" \
    timeout 300 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_EU \
      -cart vampirekiller.rom -script tools/omsx_lecturas.tcl > /dev/null 2>&1 )
done
echo hecho
