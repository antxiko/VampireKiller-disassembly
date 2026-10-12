#!/bin/sh
# lanza_psg.sh [dir] [segundos] [numero que sustituye a todas las peticiones o -] ["w:E020=7A83;..." num [cuadro]]: UN openMSX con tools/omsx_psg.tcl (cotejo del
# PSG). Lo medido queda en work/<dir>/psg.txt. Los datos del juego, de `musica.py emu`.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/${1:-psg}
mkdir -p $d
cd $R
PY=/c/Users/Antxiko/AppData/Local/Programs/Python/Python313/python.exe
eval "$($PY tools/musica.py emu)"
case "$3" in u*) S=""; F="${3#u}";; -) S=""; F="";; *) S="$3"; F="";; esac
PSG_OUT="$d" PSG_FIN=${2:-120} PSG_SIEMPRE="$S" PSG_FUERZA="$F" PSG_POKE="$4" PSG_POKE_NUM="$5" PSG_POKE_F="${6:-1800}" PSG_TECLAS="$7" "/c/Program Files/openMSX/openmsx.exe" -machine $EMU_MAQUINA -cart $EMU_ROM $EMU_TIPO -script tools/omsx_psg.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
