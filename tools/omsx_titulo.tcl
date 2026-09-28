# omsx_titulo.tcl - Las dos pantallas del principio, volcadas para cotejarlas.
#
#   telon   p01:6202 pinta el logotipo en la pagina 1 y p01:624C lo va
#           copiando a la 0 linea a linea; se vuelca cuando 0xC422 dice que
#           el telon ha acabado.
#   titulo  p00:4D47, la pantalla del titulo; se vuelca medio segundo despues
#           de que p00:4DD4 encienda la pantalla.
#
# Vuelca los 128 KB de la VRAM, la paleta y los registros del VDP. La maquina
# (C-BIOS_MSX2_EU o C-BIOS_MSX2_JP) decide el byte 0x002B y con el el titulo.
#
#   VK_OUT=<dir> VK_NOMBRE=<nombre> \
#   openmsx -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script este.tcl
set OUT $::env(VK_OUT)
set NOMBRE $::env(VK_NOMBRE)
file mkdir $OUT
set LOG [open "$OUT/$NOMBRE.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc seguro {orden} {
    if {[catch {uplevel #0 $orden} e]} { say "ERROR en '$orden': $e" ; exit 1 }
}
set ::hechos {}

proc vuelca {cual} {
    global OUT NOMBRE
    if {[lsearch $::hechos $cual] >= 0} return
    lappend ::hechos $cual
    set f [open "$OUT/${NOMBRE}_$cual.vram" wb]
    puts -nonewline $f [debug read_block VRAM 0 131072]
    close $f
    set f [open "$OUT/${NOMBRE}_$cual.pal" wb]
    puts -nonewline $f [debug read_block "VDP palette" 0 32]
    close $f
    set r {}
    for {set i 0} {$i < 24} {incr i} { lappend r [format %02X [debug read "VDP regs" $i]] }
    say "volcado $cual  002B=[format %02X [debug read memory 0x002B]]  R0-23=$r"
    if {[llength $::hechos] == 2} { exit 0 }
}

proc telon {} {
    if {[debug read memory 0xC422] != 0} { after time 0.2 { seguro {vuelca telon} } ; return }
    after time 0.05 { seguro telon }
}

set throttle off
debug set_bp 0x622D {} { after time 0.05 { seguro telon } }
debug set_bp 0x4DD4 {} { after time 0.5 { seguro {vuelca titulo} } }
after time 60 { say "no llego" ; exit 1 }
