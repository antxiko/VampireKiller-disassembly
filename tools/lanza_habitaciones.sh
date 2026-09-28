#!/bin/sh
# lanza_habitaciones.sh [fases]: cada habitacion de cada fase, volcada con
# tools/omsx_habitacion.tcl en work/habitaciones, UN openMSX cada vez. Las que
# ya tienen volcado se saltan. Las cuentas de habitaciones por fase son las de
# 0x6000 del banco 11 (graficos.cuantas_habitaciones): 156 en total.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/habitaciones
mkdir -p $d
FASES=${1:-"0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18"}
cuenta() {
  case $1 in
    0) echo 3;; 1) echo 8;; 2|3|4|5|6|11) echo 6;; 7|9|10) echo 9;; 8|14) echo 8;;
    12|13|17) echo 12;; 15|16|18) echo 10;;
  esac
}
for f in $FASES; do
  n=$(cuenta $f)
  h=0
  while [ $h -lt $n ]; do
    nombre=$(printf "hab_f%02d_h%02d" $f $h)
    if [ ! -s $d/$nombre.vram ]; then
      ( cd $R && VK_OUT="$d" VK_FASE=$f VK_HAB=$h \
        timeout 200 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script tools/omsx_habitacion.tcl > /dev/null 2>&1 ) &
      while [ $(jobs -r | wc -l) -ge 1 ]; do sleep 2; done
    fi
    h=$((h + 1))
  done
done
wait
echo hecho
