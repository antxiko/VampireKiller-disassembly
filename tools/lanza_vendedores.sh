#!/bin/sh
# lanza_vendedores.sh: las pruebas de los vendedores con tools/omsx_vendedor.tcl,
# UN openMSX cada vez, en work/vendedores. Cada fila: fase, habitacion, golpes,
# 0xC702 (0, 0x80 libro blanco, 0x40 libro rojo) y que mas (1 muere al acabar,
# 2 sale sin comprar y vuelve). Una por clase: 0 (17,9), 1 (10,1), 2 (13,4) y
# 3 (8,2); los precios con cada libro; la cuenta al morir; y p02:925B.
R=$(cd "$(dirname "$0")/.." && pwd)
cd $R
export VK_OUT=$R/work/vendedores
mkdir -p $VK_OUT
while read f h g l m; do
  unset VK_MUERE VK_VUELVE
  [ "$m" = 1 ] && export VK_MUERE=1
  [ "$m" = 2 ] && export VK_VUELVE=1
  VK_FASE=$f VK_HAB=$h VK_GOLPES=$g VK_LIBRO=$l \
    timeout 300 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script tools/omsx_vendedor.tcl > /dev/null 2>&1
done <<LISTA
17 9 9 0 0
10 1 9 0 0
13 4 9 0 0
8 2 9 0 0
18 8 9 128 0
17 9 1 64 0
10 1 1 64 0
10 1 1 128 0
13 4 3 192 0
8 3 3 0 1
17 9 3 0 2
LISTA
echo hecho
