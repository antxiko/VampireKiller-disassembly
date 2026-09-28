#!/bin/sh
# lanza_tiendas.sh: la tienda abierta, volcada por tools/omsx_vendedor.tcl
# (VK_VOLCADO) en work/tiendas, UN openMSX cada vez: el vendedor de la vida
# llena de la fase 17 (ventana arriba a la izquierda, sobre el marcador) y el
# del baston de la fase 4 (abajo a la derecha), sin libro, con el blanco (0x80)
# y con el rojo (0x40). Los que ya tienen volcado se saltan.
R=$(cd "$(dirname "$0")/.." && pwd)
cd $R
export VK_OUT=$R/work/tiendas VK_VOLCADO=1
mkdir -p $VK_OUT
for fila in "17 9 0" "17 9 128" "17 9 64" "4 1 0" "4 1 128" "4 1 64"; do
  set -- $fila
  n=$(printf "vend_f%02d_h%02d_l%02X_tienda.vram" $1 $2 $3)
  [ -s $VK_OUT/$n ] && continue
  VK_FASE=$1 VK_HAB=$2 VK_GOLPES=1 VK_LIBRO=$3 timeout 300 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script tools/omsx_vendedor.tcl > /dev/null 2>&1
done
echo hecho > $VK_OUT/hecho
