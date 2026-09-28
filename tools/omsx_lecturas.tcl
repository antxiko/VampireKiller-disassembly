# omsx_lecturas.tcl - Quien lee cada byte de los bancos conmutables.
#
# Un watchpoint de lectura sobre 0x6000-0xBFFF apunta, para cada byte leido,
# el banco que estaba puesto (el debuggable "romblocks" del cartucho, que es
# el estado real del mapper y no la copia en RAM) y la instruccion que lo leyo
# (PC y el banco en el que corria). Las lecturas de instruccion NO pasan por
# aqui -openMSX solo avisa de las de datos-, asi que lo que sale son DATOS.
#
# Variables de entorno:
#   VK_OUT     fichero de salida (una linea por byte: "banco dir pcbanco pc")
#   VK_SEGS    segundos emulados que corre (por defecto 300)
#   VK_TECLAS  guion de pulsaciones "t:fila:mascara:dur ..." (opcional)
#   VK_FASE    si esta (0..18), al empezar la partida -el `ret` de p00:44E8,
#              despues de que 0x44C6 borre la RAM de la partida y la deje en la
#              fase 0, el patio- se pone esa: 0xD000 la fase, 0xC411 la misma
#              en BCD (la del marcador) y 0xD002 el bloque de tres, como hace
#              la tabla de p00:5E6A
#   VK_FOTOS   segundos a los que se hace una captura (opcional)
#
#   openmsx -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script este.tcl
set OUT $::env(VK_OUT)
set SEGS [expr {[info exists ::env(VK_SEGS)] ? $::env(VK_SEGS) : 300}]
set TECLAS [expr {[info exists ::env(VK_TECLAS)] ? $::env(VK_TECLAS) : ""}]

set ::RB ""
foreach d [debug list] { if {[string match "Vampire*romblocks" $d]} { set ::RB $d } }

proc banco {a} {
    if {$a < 0x4000 || $a >= 0xC000} { return -1 }
    return [debug read $::RB $a]
}

proc lee {} {
    set a $::wp_last_address
    set b [debug read $::RB $a]
    set k "$b [format %04X $a]"
    if {![info exists ::R($k)]} {
        set pc [reg PC]
        set ::R($k) "[banco $pc] [format %04X $pc]"
    }
}

proc pulsa {fila mascara dur} {
    keymatrixdown $fila $mascara
    after time $dur [list keymatrixup $fila $mascara]
}

proc fin {} {
    set f [open $::OUT w]
    foreach k [lsort [array names ::R]] { puts $f "$k $::R($k)" }
    close $f
    exit
}

proc pon_fase {} {
    set n $::env(VK_FASE)
    debug write memory 0xD000 $n
    debug write memory 0xC411 [expr {($n / 10) * 16 + ($n % 10)}]
    debug write memory 0xD002 [expr {$n ? ($n - 1) / 3 : 0}]
}
proc foto {s} { screenshot [format "%s_%03d.png" [file rootname $::OUT] $s] }

set throttle off
if {[info exists ::env(VK_FASE)]} { debug set_bp 0x44E8 {} pon_fase }
if {[info exists ::env(VK_FOTOS)]} { foreach s $::env(VK_FOTOS) { after time $s [list foto $s] } }
debug set_watchpoint read_mem {0x6000 0xBFFF} {} lee
foreach t $TECLAS {
    lassign [split $t :] s fila m dur
    after time $s [list pulsa $fila $m $dur]
}
after time $SEGS fin
