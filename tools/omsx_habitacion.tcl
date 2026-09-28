# omsx_habitacion.tcl - Una habitacion del castillo, volcada para cotejarla.
#
# Arranca una partida (tres pulsaciones de espacio), en el `ret` de p00:44E8
# pone la fase (0xD000, 0xC411 en BCD y el bloque de tres de 0xD002, como
# hace tools/omsx_lecturas.tcl) y, justo antes de que p01:62F5 cargue la
# habitacion, pone la habitacion (0xD001) y deja a Simon en el aire en medio
# de la pantalla. Cuando p01:6321 enciende la pantalla -la habitacion ya
# montada y pintada, con sus puertas y sus bloques- espera medio segundo y
# vuelca los 128 KB de la VRAM, la RAM de 0xC000 a 0xDFFF, la paleta y los
# registros del VDP. Con VK_CAPTURA puesto guarda ademas lo que se ve
# (screenshot -raw), para cotejar los sprites pintados.
#
#   VK_OUT=<dir> VK_FASE=<0..18> VK_HAB=<n> \
#   openmsx -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script este.tcl
set OUT $::env(VK_OUT)
set FASE $::env(VK_FASE)
set HAB $::env(VK_HAB)
file mkdir $OUT
set NOMBRE [format "hab_f%02d_h%02d" $FASE $HAB]
set LOG [open "$OUT/$NOMBRE.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc lee {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc pulsa {fila mascara dur} {
    keymatrixdown $fila $mascara
    after time $dur [list keymatrixup $fila $mascara]
}
proc seguro {orden} {
    if {[catch {uplevel #0 $orden} e]} { say "ERROR en '$orden': $e" ; exit 1 }
}
set ::puesta 0
set ::volcada 0

proc pon_fase {} {
    global FASE
    pon 0xD000 $FASE
    pon 0xC411 [expr {($FASE / 10) * 16 + ($FASE % 10)}]
    pon 0xD002 [expr {$FASE ? ($FASE - 1) / 3 : 0}]
    say "fase puesta: D000=[lee 0xD000] C411=[format %02X [lee 0xC411]] D002=[lee 0xD002]"
}

proc pon_habitacion {} {
    global HAB
    if {$::puesta} return
    set ::puesta 1
    pon 0xD001 $HAB
    pon 0xC425 0x60
    pon 0xC427 0x80
    say "habitacion puesta: D001=[lee 0xD001], Simon en (0x60, 0x80)"
}

proc vuelca {} {
    global OUT NOMBRE
    set f [open "$OUT/$NOMBRE.vram" wb]
    puts -nonewline $f [debug read_block VRAM 0 131072]
    close $f
    set f [open "$OUT/$NOMBRE.ram" wb]
    puts -nonewline $f [debug read_block memory 0xC000 8192]
    close $f
    set f [open "$OUT/$NOMBRE.pal" wb]
    puts -nonewline $f [debug read_block "VDP palette" 0 32]
    close $f
    set r {}
    for {set i 0} {$i < 24} {incr i} { lappend r [format %02X [debug read "VDP regs" $i]] }
    if {[info exists ::env(VK_CAPTURA)]} { screenshot -raw "$OUT/$NOMBRE.png" }
    say "volcado $NOMBRE  D000=[lee 0xD000] D001=[lee 0xD001] C41A=[lee 0xC41A] CE00=[lee 0xCE00]  R0-23=$r"
    exit 0
}

proc encendida {} {
    if {$::volcada || !$::puesta} return
    set ::volcada 1
    say "pantalla encendida en p01:6321"
    # sin freno openMSX se salta cuadros al pintar y la captura seria vieja
    if {[info exists ::env(VK_CAPTURA)]} { set ::throttle on }
    if {[info exists ::env(VK_DRACULA)]} {
        set ::throttle on
        set ::quieto 0
        after frame { seguro acecha }
        return
    }
    if {[info exists ::env(VK_MUESTRAS)]} {
        set ::muestras $::env(VK_MUESTRAS)
        global OUT NOMBRE
        set ::fm [open "$OUT/$NOMBRE.cosas" w]
        after frame { seguro muestra }
        return
    }
    after time 0.5 { seguro vuelca }
}

# Con VK_MUESTRAS=<n> apunta en <nombre>.cosas, durante n cuadros, las quince
# fichas de 0xC800 y 0xD700 (tipo, dibujo, y, x y sus sprites de +0x20) con
# Simon invencible (0xC43A), y luego vuelca como siempre. Un "|" separa las de
# 0xC800 (las cosas) de las de 0xD700 (lo que lanzan): cada lista numera sus
# tipos a su manera (p02:993F y p02:9E5C).
proc muestra {} {
    pon 0xC43A 0xFF
    set linea {}
    foreach base {0xC800 0xC880 0xC900 0xC980 0xCA00 0xCA80 0xCB00 |
                  0xD700 0xD780 0xD800 0xD880 0xD900 0xD980 0xDA00 0xDA80} {
        if {$base eq "|"} { lappend linea "|" ; continue }
        if {[lee $base] == 0} continue
        set b {}
        foreach off {0 0x0B 3 5} { lappend b [format %02X [lee [expr {$base + $off}]]] }
        set n [lee [expr {$base + 0x20}]]
        for {set i 0} {$i < 5 * $n + 1} {incr i} { lappend b [format %02X [lee [expr {$base + 0x20 + $i}]]] }
        lappend linea [join $b ""]
    }
    puts $::fm [join $linea " "]
    incr ::muestras -1
    if {$::muestras > 0} { after frame { seguro muestra } } else { close $::fm ; seguro vuelca }
}

# Con VK_DRACULA=<dibujo> (0x5B..0x5E) espera, en la sala de Dracula, a que la
# ficha del tipo 0x11 lleve ese dibujo en los pasos 3 a 5 (de pie, con el
# cuerpo ya pintado: 0xCE0E a cero) dos cuadros seguidos y vuelca (con la
# captura, para ver los sprites).
proc acecha {} {
    pon 0xC43A 0xFF
    set ok 0
    foreach base {0xC800 0xC880 0xC900 0xC980 0xCA00 0xCA80 0xCB00} {
        set paso [lee [expr {$base + 1}]]
        if {[lee $base] == 0x11 && $paso >= 3 && $paso <= 5 &&
            [lee [expr {$base + 0x0B}]] == $::env(VK_DRACULA) && [lee 0xCE0E] == 0} { set ok 1 }
    }
    if {$ok} { incr ::quieto } else { set ::quieto 0 }
    if {$::quieto >= 2} {
        set ::env(VK_CAPTURA) 1
        say "Dracula quieto con el dibujo $::env(VK_DRACULA)"
        seguro vuelca
        return
    }
    after frame { seguro acecha }
}

set throttle off
debug set_bp 0x44E8 {} {seguro pon_fase}
debug set_bp 0x62F5 {} {seguro pon_habitacion}
debug set_bp 0x6324 {} {seguro encendida}
after time 4 { pulsa 8 1 0.2 }
after time 7 { pulsa 8 1 0.2 }
after time 10 { pulsa 8 1 0.2 }
after time 90 { say "ROJO: se acabo el tiempo (puesta=$::puesta volcada=$::volcada)" ; exit 1 }
