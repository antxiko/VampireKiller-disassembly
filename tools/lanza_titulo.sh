#!/bin/sh
# lanza_titulo.sh: las dos pantallas del principio (tools/omsx_titulo.tcl) con
# la BIOS europea y con la japonesa, en work/titulo, UN openMSX cada vez.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/titulo
mkdir -p $d
for m in EU JP; do
  if [ ! -s $d/${m}_titulo.vram ]; then
    ( cd $R && VK_OUT="$d" VK_NOMBRE=$m \
      timeout 120 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_$m -cart vampirekiller.rom -script tools/omsx_titulo.tcl > /dev/null 2>&1 )
  fi
done
echo hecho
