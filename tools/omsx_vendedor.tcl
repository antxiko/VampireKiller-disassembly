# omsx_vendedor.tcl - Golpe a golpe a un vendedor, apuntando lo que pasa.
#
# Entra en la habitacion como tools/omsx_habitacion.tcl (fase en p00:44E8,
# habitacion en p01:62F5). Con la pantalla encendida busca la ficha del
# vendedor (0xC5B5 o 0xC5C5, estado 0x82) y le da VK_GOLPES golpes, uno cada
# vez que vuelve a esperar: suma 1 a su cuarto byte, lo mismo que hace el
# golpe del latigo en p02:8115. Antes pone 0xC702 = VK_LIBRO (0, 0x80 libro
# blanco, 0x40 libro rojo), 0x50 corazones (0xC417, BCD) y 0xD012 = VK_NIVEL,
# y mantiene a Simon invencible y con la vida llena. Apunta en <nombre>.log:
#   p02:920C  la cuenta del hueco en 0xDE00 y el desenlace elegido (0xC70C)
#   p02:92A7  lo que pasa, y 5 cuadros despues: corazones, 0xD012, 0xC40C
#   p02:9427  la tienda: lo que vende (0xC708) y el precio (0xC707)
#   p02:925B  el vendedor se repinta con la tienda sin comprar (bit 7)
# Con VK_VUELVE=1, al cerrarse la primera tienda Simon sale por la izquierda y
# vuelve a la misma habitacion, y se siguen dando golpes.
# Con VK_MUERE=1, tras el ultimo golpe Simon se queda sin vida y se mira
# 0xDE00 en la vida siguiente.
#
#   VK_OUT=<dir> VK_FASE=<1..18> VK_HAB=<n> VK_GOLPES=<n> VK_LIBRO=<b> \
#   VK_NIVEL=<n> openmsx -machine C-BIOS_MSX2_EU -cart vampirekiller.rom -script este.tcl
set OUT $::env(VK_OUT)
set FASE $::env(VK_FASE)
set HAB $::env(VK_HAB)
set GOLPES $::env(VK_GOLPES)
set LIBRO [expr {[info exists ::env(VK_LIBRO)] ? $::env(VK_LIBRO) : 0}]
set NIVEL [expr {[info exists ::env(VK_NIVEL)] ? $::env(VK_NIVEL) : 1}]
set MUERE [info exists ::env(VK_MUERE)]
set VUELVE [info exists ::env(VK_VUELVE)]
set ::muerto 0
set ::cuidar 1
file mkdir $OUT
set NOMBRE [format "vend_f%02d_h%02d_l%02X%s" $FASE $HAB $LIBRO [expr {$MUERE ? "_m" : ""}][expr {$VUELVE ? "_v" : ""}]]
set LOG [open "$OUT/$NOMBRE.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc lee {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc hx {a} { return [format %02X [lee $a]] }
proc pulsa {fila mascara dur} {
    keymatrixdown $fila $mascara
    after time $dur [list keymatrixup $fila $mascara]
}
proc seguro {orden} {
    if {[catch {uplevel #0 $orden} e]} { say "ERROR en '$orden': $e" ; exit 1 }
}
set ::puesta 0
set ::encendida 0
set ::ficha 0
set ::dados 0
set ::esperando 0

proc pon_fase {} {
    global FASE
    pon 0xD000 $FASE
    pon 0xC411 [expr {($FASE / 10) * 16 + ($FASE % 10)}]
    pon 0xD002 [expr {$FASE ? ($FASE - 1) / 3 : 0}]
}

proc pon_habitacion {} {
    global HAB
    incr ::puesta
    pon 0xD001 $HAB
    pon 0xC425 0x60
    pon 0xC427 0x80
    say "habitacion puesta ($::puesta): D001=[lee 0xD001]"
}

proc estado {} {
    return "C417=[hx 0xC417] D012=[hx 0xD012] C40C=[hx 0xC40C] C702=[hx 0xC702] DE00:[huecos]"
}
proc huecos {} {
    set s {}
    for {set i 0} {$i < 4} {incr i} { lappend s [hx [expr {0xDE00 + $::FASECOL + 4 * [lee 0xD001] + $i}]] }
    return [join $s ""]
}

proc encendida {} {
    if {!$::puesta || $::encendida == $::puesta} return
    set ::encendida $::puesta
    say "pantalla encendida; fichas C5B5=[hx 0xC5B5] C5C5=[hx 0xC5C5]"
    if {$::puesta == 1} { after time 0.5 { seguro empieza } } elseif {$::VUELVE} { after time 0.5 { seguro sigue } } else { after time 0.5 { seguro {termina "vida nueva"} } }
}

proc empieza {} {
    global LIBRO NIVEL
    pon 0xC702 $LIBRO
    pon 0xC417 0x50
    pon 0xD012 $NIVEL
    after frame { seguro cuida }
    say "empieza: [estado]"
    sigue
}

# Simon invencible y con la vida llena mientras dura la prueba
proc cuida {} {
    if {!$::cuidar} return
    pon 0xC43A 0xFF
    pon 0xC415 0x20
    after frame { seguro cuida }
}

proc sigue {} {
    set ::ficha 0
    foreach b {0xC5B5 0xC5C5} { if {([lee $b] & 0x8F) == 0x82} { set ::ficha $b } }
    if {!$::ficha} {
        termina "FIN: no hay vendedor esperando (C5B5=[hx 0xC5B5] C5C5=[hx 0xC5C5]) tras $::dados golpes"
        return
    }
    if {$::dados >= $::GOLPES} { termina "FIN: $::dados golpes dados"; return }
    incr ::dados
    set g [expr {$::ficha + 3}]
    say "golpe $::dados a [format %04X $::ficha] (clase [lee [expr {$::ficha + 5}]], cual [lee [expr {$::ficha + 4}]]): [estado]"
    pon $g [expr {[lee $g] + 1}]
    set ::esperando 1
}

# Con VK_MUERE, al acabar Simon se queda sin vida: la vida siguiente vuelve a
# montar la fase (p00:423A -> p01:62E6) y se mira 0xDE00 otra vez.
proc termina {m} {
    say "$m: [estado]"
    if {!$::MUERE || $::muerto} { exit 0 ; return }
    set ::muerto 1
    set ::cuidar 0
    pon 0xC43A 0
    pon 0xC415 0
    say "   Simon sin vida"
}

proc elegido {} {
    say "   p02:920C cuenta=[hx [expr {0xDE00 + $::FASECOL + 4 * [lee 0xD001] + 2 * [lee [expr {$::ficha + 9}]] + 1}]] desenlace C70C=[hx 0xC70C] dibujo C70B=[hx 0xC70B]"
}

proc pasa {} {
    say "   p02:92A7 pasa el desenlace [hx 0xC70C]"
    after time 0.1 { seguro despues }
}

proc despues {} {
    say "   despues: [estado]"
    # la tienda: esperar a que se cierre sola (0x14 plazos de 32 cuadros)
    if {[lee 0xC40C] != 0 || [lee 0xC70C] == 0} {
        after time 16 { seguro tras_la_tienda }
    } else {
        after time 0.5 { seguro sigue }
    }
}

proc tras_la_tienda {} {
    say "   tras la tienda: [estado]"
    if {$::VUELVE && $::puesta == 1} {
        # Simon al borde izquierdo: p01:769B lo saca y p01:62F5 vuelve a poner
        # esta misma habitacion
        pon 0xC427 0x04
        say "   Simon sale por la izquierda"
        return
    }
    sigue
}

proc tienda {} {
    say "   p02:9427 tienda: vende C708=[hx 0xC708] precio C707=[hx 0xC707] (C702=[hx 0xC702])"
}

# Con VK_VOLCADO, al acabar de pintar la ventana de la tienda (el ret de
# p02:93FE, y 0,2 s para que el V9938 acabe sus ordenes) vuelca la VRAM, la
# paleta y la RAM en <nombre>_tienda.*, para tools/coteja.py tienda.
proc vuelca_la_tienda {} {
    global OUT NOMBRE
    if {$::tienda_volcada} return
    set ::tienda_volcada 1
    set f [open "$OUT/${NOMBRE}_tienda.vram" wb]
    puts -nonewline $f [debug read_block VRAM 0 131072]
    close $f
    set f [open "$OUT/${NOMBRE}_tienda.pal" wb]
    puts -nonewline $f [debug read_block "VDP palette" 0 32]
    close $f
    set f [open "$OUT/${NOMBRE}_tienda.ram" wb]
    puts -nonewline $f [debug read_block memory 0xC000 8192]
    close $f
    say "   volcada la tienda: ventana en C704=[hx 0xC705],[hx 0xC704] vende [hx 0xC708] precio [hx 0xC707]"
}

proc repinta {} {
    say "   p02:925B el hueco tenia la tienda sin comprar: la cuenta baja ([hx 0xC70C])"
}

# la columna de la fase en 0xDE00 (tabla 0x9473 del banco 2)
set tabla {0x00 0x40 0x80}
set ::FASECOL [lindex $tabla [expr {($FASE - 1) % 3}]]

set throttle off
debug set_bp 0x44E8 {} {seguro pon_fase}
debug set_bp 0x62F5 {} {seguro pon_habitacion}
debug set_bp 0x6324 {} {seguro encendida}
debug set_bp 0x920C {[debug read memory 0xF0F2] == 2} {seguro elegido}
debug set_bp 0x92A7 {[debug read memory 0xF0F2] == 2} {seguro pasa}
debug set_bp 0x9427 {[debug read memory 0xF0F2] == 2} {seguro tienda}
set ::tienda_volcada 0
if {[info exists ::env(VK_VOLCADO)]} {
    debug set_bp 0x93FE {[debug read memory 0xF0F2] == 2} {after time 0.2 {seguro vuelca_la_tienda}}
}
debug set_bp 0x925B {[debug read memory 0xF0F2] == 2} {seguro repinta}
after time 4 { pulsa 8 1 0.2 }
after time 7 { pulsa 8 1 0.2 }
after time 10 { pulsa 8 1 0.2 }
after time 400 { say "ROJO: se acabo el tiempo (puesta=$::puesta golpes=$::dados)" ; exit 1 }
