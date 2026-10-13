# omsx_psg.tcl - Lo que el juego escribe de verdad en el PSG, para cotejarlo
# con tools/musica.py (que ejecuta el mismo motor fuera del emulador).
#
# Apunta en $PSG_OUT/psg.txt, en orden:
#   F                 cada llamada al motor de cada cuadro ($PSG_FRAME)
#   S nn              cada llamada a "pedir sonido" ($PSG_PIDE): A
#   W r v             cada escritura al PSG (puerto 0xA0 el registro, 0xA1 el dato)
#   C o v             cada escritura al SCC (0x9800 + o)
# $PSG_FRAME_BYTE y $PSG_PIDE_BYTE: el byte que debe haber en esas direcciones
# (para saber que el cartucho esta mapeado). $PSG_FUERZA: lista de numeros que
# sustituyen a la A de las primeras peticiones (para oir piezas sin jugar).
# $PSG_SIEMPRE: sustituye la A de TODAS las peticiones (una pieza entera, sin que otra la pise).
# Pulsa ESPACIO cada 3 s entre los 6 y los FIN-10 s; sale a los FIN s emulados.
set OUT $::env(PSG_OUT)
set FIN [expr {[info exists ::env(PSG_FIN)] ? $::env(PSG_FIN) : 120}]
set FRAME $::env(PSG_FRAME)
set PIDE $::env(PSG_PIDE)
set FB $::env(PSG_FRAME_BYTE)
set PB $::env(PSG_PIDE_BYTE)
set ::fuerza [expr {[info exists ::env(PSG_FUERZA)] ? $::env(PSG_FUERZA) : ""}]
file mkdir $OUT
set ::log {}
set ::reg 0
debug set_watchpoint write_io 0xA0 {} { set ::reg [expr {$::wp_last_value & 0x0F}] }
debug set_watchpoint write_io 0xA1 {} { lappend ::log "W $::reg $::wp_last_value" }
# el SCC (cartuchos Konami SCC): C desplazamiento dato, con 0x9800 = 0
debug set_watchpoint write_mem {0x9800 0x98FF} {} { lappend ::log "C [expr {$::wp_last_address - 0x9800}] $::wp_last_value" }
# $PSG_POKE "w:E020=7A83;w:E028=7ADB;b:E027=04" y $PSG_POKE_NUM: juegos sin rutina de
# peticion: al llegar al cuadro $PSG_POKE_F el sondeo escribe esas fichas, como las
# escribe el juego, y apunta "S num" justo antes de ese cuadro.
set ::poke [expr {[info exists ::env(PSG_POKE)] ? $::env(PSG_POKE) : ""}]
set ::pokef [expr {[info exists ::env(PSG_POKE_F)] ? $::env(PSG_POKE_F) : 1800}]
set ::pokenum [expr {[info exists ::env(PSG_POKE_NUM)] ? $::env(PSG_POKE_NUM) : 0}]
set ::nf 0
# $PSG_RAM "direccion longitud" (decimales): vuelca esa RAM al empezar cada cuadro, hasta 400 cuadros tras cada peticion
set ::vol [expr {[info exists ::env(PSG_RAM)] ? $::env(PSG_RAM) : ""}]
set ::desde 0
set ::primera 1
# $PSG_MRAM "inicio longitud" (decimales): la RAM que se vuelca en cada linea M (por omision 0xE000, 96 bytes)
set ::mram [expr {[info exists ::env(PSG_MRAM)] && $::env(PSG_MRAM) ne "" ? $::env(PSG_MRAM) : "57344 96"}]
proc volcado_m {} {
    set m ""
    for {set i 0} {$i < [lindex $::mram 1]} {incr i} { append m [format "%02X" [debug read memory [expr {[lindex $::mram 0] + $i}]]] }
    return $m
}
proc haz_poke {} {
    foreach p [split $::poke ";"] {
        regexp {^(.):([0-9A-Fa-f]+)=([0-9A-Fa-f]+)$} $p -> t d v
        set d [expr "0x$d"]; set v [expr "0x$v"]
        debug write memory $d [expr {$v & 0xFF}]
        if {$t eq "w"} { debug write memory [expr {$d + 1}] [expr {$v >> 8}] }
    }
    lappend ::log "M [volcado_m]"
    lappend ::log "S $::pokenum"
}
debug set_bp $FRAME "\[debug read memory $FRAME\] == $FB" {
    incr ::nf
    if {$::vol ne "" && $::desde < 400} {
        set m ""
        for {set i 0} {$i < [lindex $::vol 1]} {incr i} { append m [format "%02X" [debug read memory [expr {[lindex $::vol 0] + $i}]]] }
        lappend ::log "R $::desde $m"
    }
    incr ::desde
    if {$::poke ne "" && $::nf == $::pokef} { haz_poke }
    lappend ::log "F"
}
if {$PIDE ne $FRAME} {
debug set_bp $PIDE "\[debug read memory $PIDE\] == $PB" {
    if {[info exists ::env(PSG_SIEMPRE)] && $::env(PSG_SIEMPRE) ne ""} {
        reg a $::env(PSG_SIEMPRE)
    } elseif {[llength $::fuerza] > 0} {
        reg a [lindex $::fuerza 0]
        set ::fuerza [lrange $::fuerza 1 end]
    }
    if {[info exists ::env(PSG_AF2)] && $::env(PSG_AF2) ne ""} { reg af2 $::env(PSG_AF2) }
    lappend ::log "M [volcado_m]"
    lappend ::log "S [reg a]"
    set ::desde 0
}
}
# $PSG_PIDE2 "direccion condicion": otra entrada a la peticion que solo cuenta si
# se cumple la condicion (expresion de debug), por ejemplo "0xB8D3 ([debug read memory 0xE002] & 0x40) != 0"
if {[info exists ::env(PSG_PIDE2)] && $::env(PSG_PIDE2) ne ""} {
    set a2 [lindex $::env(PSG_PIDE2) 0]
    set c2 [lrange $::env(PSG_PIDE2) 1 end]
    debug set_bp $a2 "\[debug read memory $PIDE\] == $PB && ($c2)" {
        lappend ::log "M [volcado_m]"
        lappend ::log "S [reg a]"
        set ::desde 0
    }
}
# $PSG_TECLAS "fila:mascara ..." (matriz del teclado MSX): lo que se pulsa a cada paso
set ::teclas [expr {[info exists ::env(PSG_TECLAS)] && $::env(PSG_TECLAS) ne "" ? $::env(PSG_TECLAS) : "8:0x01"}]
proc pulsa {} {
    foreach k $::teclas {
        lassign [split $k ":"] f m
        keymatrixdown $f $m
        after time 0.15 "keymatrixup $f $m"
    }
}
for {set t 6} {$t < [expr {$FIN - 10}]} {incr t 3} { after time $t pulsa }
proc acaba {} {
    set f [open [file join $::OUT psg.txt] w]
    puts $f [join $::log "\n"]
    close $f
    exit
}
after time $FIN acaba
