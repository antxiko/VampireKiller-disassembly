#!/bin/sh
# lanza_dracula.sh: la sala de Dracula (fase 18, habitacion 9) volcada con
# Dracula de pie en cada uno de sus cuatro dibujos (0x5B..0x5E), con
# tools/omsx_habitacion.tcl (VK_DRACULA), en work/dracula. UN openMSX cada vez;
# los que ya tienen su .vram se saltan.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/dracula
mkdir -p $d
for dib in 91 92 93 94; do
  sub=$d/d$dib
  mkdir -p $sub
  if [ ! -s $sub/hab_f18_h09.vram ]; then
    ( cd $R && VK_DRACULA=$dib VK_OUT="$sub" VK_FASE=18 VK_HAB=9 \
      timeout 200 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script tools/omsx_habitacion.tcl > /dev/null 2>&1 )
  fi
  tail -1 $sub/hab_f18_h09.log
done
