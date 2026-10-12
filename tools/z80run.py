#!/usr/bin/env python3
"""Un Z80 pequeno para EJECUTAR de verdad rutinas del cartucho.

Aqui lo usa tools/musica.py: el motor de sonido del banco 13 se ejecuta tal
cual, cuadro a cuadro, en lugar de reescribirlo a mano en Python.

Que NO es. No es un emulador de MSX: no hay VDP, ni PSG, ni interrupciones, ni
BIOS, ni ciclos. Es un interprete de instrucciones sobre 64 KB de memoria
plana; quien lo usa pone el mapper y atrapa las llamadas a la BIOS.

La regla que lo hace fiable: **ante un opcode que no implementa, revienta**.
Nunca sigue adelante suponiendo. Si `corre()` vuelve sin excepcion es que ha
ejecutado exactamente las instrucciones del cartucho, una por una.

Las banderas que se llevan de verdad son las que este codigo mira: cero, acarreo
y signo, mas el medio acarreo que necesita `daa`. El resto se calculan igual
porque cuesta lo mismo, pero no estan probadas.
"""

FZ, FN, FH, FPV, F3, F5, FC = 0x40, 0x02, 0x10, 0x04, 0x08, 0x20, 0x01
FS = 0x80


class ParadaZ80(Exception):
    """Un opcode que este interprete no implementa, o un limite pasado."""


class Maquina:
    """Los puertos de E/S del MSX que una rutina puede tocar:

        0x98 / 0x99   el VDP: dato y direccion/registro
        0xA0 / 0xA1   el PSG: registro y dato (aqui solo se apuntan)
        0xA2          leer el PSG; el registro 14 es el puerto del mando
        0xAA / 0xA9   el PPI: la fila del teclado y lo que hay en ella

    El teclado y el mando se dejan a 0xFF, que es "nada pulsado", y quien maneje
    esta maquina los cambia cuando quiere pulsar algo.
    """

    def __init__(self):
        self.vdp = Vdp()
        self.psg = bytearray(16)
        self.psg_reg = 0
        self.fila = 0
        self.teclado = bytearray([0xFF] * 12)
        self.mando = 0xFF

    def escribe(self, p, v):
        p &= 0xFF
        if p in (0x98, 0x99):
            self.vdp.puerto(p, v)
        elif p == 0xA0:
            self.psg_reg = v & 0x0F
        elif p == 0xA1:
            self.psg[self.psg_reg] = v
        elif p == 0xAA:
            self.fila = v & 0x0F

    def lee(self, p):
        p &= 0xFF
        if p in (0x98, 0x99):
            return self.vdp.lee(p)
        if p == 0xA2:
            if self.psg_reg == 14:
                return self.mando
            return self.psg[self.psg_reg]
        if p == 0xA9:
            return self.teclado[self.fila] if self.fila < 12 else 0xFF
        return 0xFF


class Vdp:
    """Los dos puertos del VDP del MSX, lo justo para que las rutinas escriban.

    0x99 recibe la direccion en dos mitades -la segunda con el bit 6 puesto si
    es para escribir- o un valor de registro si el bit 7 esta puesto; 0x98 es el
    dato, y despues de cada byte la direccion sube sola. Con eso basta para que
    las rutinas de volcado del cartucho llenen esta VRAM igual que la de verdad.
    """

    def __init__(self):
        self.vram = bytearray(0x4000)
        self.regs = bytearray(8)
        self.dir = 0
        self.medio = None

    def puerto(self, p, v):
        p &= 0xFF
        if p == 0x98:
            self.vram[self.dir & 0x3FFF] = v
            self.dir = (self.dir + 1) & 0xFFFF
        elif p == 0x99:
            if self.medio is None:
                self.medio = v
            else:
                if v & 0x80:
                    self.regs[v & 0x07] = self.medio
                else:
                    self.dir = ((v & 0x3F) << 8) | self.medio
                self.medio = None

    def lee(self, p):
        if (p & 0xFF) == 0x98:
            v = self.vram[self.dir & 0x3FFF]
            self.dir = (self.dir + 1) & 0xFFFF
            return v
        if (p & 0xFF) == 0x99:
            self.medio = None
            return 0x00          # el bit de "listo" a cero: nunca hay colision
        return 0xFF


class Z80:
    def __init__(self):
        self.maq = Maquina()
        self.vdp = self.maq.vdp
        self.mem = bytearray(0x10000)
        self.a = self.f = 0
        self.b = self.c = self.d = self.e = self.h = self.l = 0
        self.ix = self.iy = 0
        self.sp = 0xF000
        self.pc = 0
        self.af_ = self.bc_ = self.de_ = self.hl_ = 0
        self.pasos = 0

    # ------------------------------------------------------------ memoria

    def carga(self, datos, donde):
        self.mem[donde:donde + len(datos)] = datos

    def _leer(self, d):
        return self.mem[d & 0xFFFF]

    def _escribir(self, d, v):
        self.mem[d & 0xFFFF] = v & 0xFF

    def _leer16(self, d):
        return self._leer(d) | (self._leer(d + 1) << 8)

    def _escribir16(self, d, v):
        self._escribir(d, v & 0xFF)
        self._escribir(d + 1, (v >> 8) & 0xFF)

    # ------------------------------------------------------------ registros

    def _get_hl(self):
        return (self.h << 8) | self.l

    def _set_hl(self, v):
        self.h, self.l = (v >> 8) & 0xFF, v & 0xFF

    def _get_de(self):
        return (self.d << 8) | self.e

    def _set_de(self, v):
        self.d, self.e = (v >> 8) & 0xFF, v & 0xFF

    def _get_bc(self):
        return (self.b << 8) | self.c

    def _set_bc(self, v):
        self.b, self.c = (v >> 8) & 0xFF, v & 0xFF

    hl = property(_get_hl, _set_hl)
    de = property(_get_de, _set_de)
    bc = property(_get_bc, _set_bc)

    # ------------------------------------------------------------ banderas

    def _sz(self, v):
        self.f = (self.f & FC) | (FZ if v == 0 else 0) | (v & FS)

    def _suma(self, v, acarreo=0):
        r = self.a + v + acarreo
        h = (self.a & 0x0F) + (v & 0x0F) + acarreo
        self.f = ((FZ if (r & 0xFF) == 0 else 0) | (r & FS)
                  | (FC if r > 0xFF else 0) | (FH if h > 0x0F else 0))
        self.a = r & 0xFF

    def _resta(self, v, acarreo=0, guarda=True):
        r = self.a - v - acarreo
        h = (self.a & 0x0F) - (v & 0x0F) - acarreo
        f = (FN | (FZ if (r & 0xFF) == 0 else 0) | (r & FS)
             | (FC if r < 0 else 0) | (FH if h < 0 else 0))
        if guarda:
            self.a = r & 0xFF
        self.f = f

    def _inc8(self, v):
        r = (v + 1) & 0xFF
        self.f = (self.f & FC) | (FZ if r == 0 else 0) | (r & FS) \
            | (FH if (v & 0x0F) == 0x0F else 0)
        return r

    def _dec8(self, v):
        r = (v - 1) & 0xFF
        self.f = (self.f & FC) | FN | (FZ if r == 0 else 0) | (r & FS) \
            | (FH if (v & 0x0F) == 0 else 0)
        return r

    def _add16(self, x, y):
        r = x + y
        self.f = (self.f & (FZ | FS | FPV)) | (FC if r > 0xFFFF else 0)
        return r & 0xFFFF

    # ------------------------------------------------------------ el bucle

    # Las tablas de registros por el numero de tres bits del opcode.
    _R = "b c d e h l (hl) a".split()

    def _get_r(self, n, idx=None, d=0):
        if n == 6:
            return self._leer(self.hl if idx is None else idx + d)
        return getattr(self, self._R[n])

    def _set_r(self, n, v, idx=None, d=0):
        if n == 6:
            self._escribir(self.hl if idx is None else idx + d, v)
        else:
            setattr(self, self._R[n], v & 0xFF)

    def corre(self, desde, tope=20_000_000):
        """Ejecuta desde esa direccion hasta que el `ret` saque el centinela."""
        centinela = 0xFFFE
        self.sp = (self.sp - 2) & 0xFFFF
        self._escribir16(self.sp, centinela)
        self.pc = desde
        self.pasos = 0
        while True:
            if self.pc == centinela:
                return
            self.pasos += 1
            if self.pasos > tope:
                raise ParadaZ80("mas de %d instrucciones: bucle sin fin" % tope)
            self._una()

    def corre_hasta(self, desde, parada, tope=5_000_000):
        """Ejecuta desde una direccion hasta llegar a otra. Para el `jr` eterno."""
        self.pc = desde
        self.pasos = 0
        while self.pc != parada:
            self.pasos += 1
            if self.pasos > tope:
                raise ParadaZ80("no se llego a 0x%04X en %d instrucciones"
                                % (parada, tope))
            self._una()

    def _una(self):
        pc0 = self.pc
        op = self._leer(self.pc)
        self.pc = (self.pc + 1) & 0xFFFF

        if op in (0xDD, 0xFD):
            self._indexado(op, pc0)
            return
        if op == 0xED:
            self._ed(pc0)
            return
        if op == 0xCB:
            self._cb(pc0)
            return

        # ld r,r' / ld r,(hl) / ld (hl),r  --  0x40..0x7F menos el 0x76 (halt)
        if 0x40 <= op <= 0x7F and op != 0x76:
            self._set_r((op >> 3) & 7, self._get_r(op & 7))
            return

        # aritmetica con A --  0x80..0xBF
        if 0x80 <= op <= 0xBF:
            v = self._get_r(op & 7)
            self._alu((op >> 3) & 7, v)
            return

        n = self._byte
        nn = self._palabra

        if op == 0x00:                                   # nop
            return
        if op in (0x01, 0x11, 0x21, 0x31):               # ld rr,nn
            v = nn()
            if op == 0x01:
                self.bc = v
            elif op == 0x11:
                self.de = v
            elif op == 0x21:
                self.hl = v
            else:
                self.sp = v
            return
        if op in (0x06, 0x0E, 0x16, 0x1E, 0x26, 0x2E, 0x36, 0x3E):
            self._set_r((op >> 3) & 7, n())             # ld r,n
            return
        if op in (0x03, 0x13, 0x23, 0x33):               # inc rr
            if op == 0x03:
                self.bc = (self.bc + 1) & 0xFFFF
            elif op == 0x13:
                self.de = (self.de + 1) & 0xFFFF
            elif op == 0x23:
                self.hl = (self.hl + 1) & 0xFFFF
            else:
                self.sp = (self.sp + 1) & 0xFFFF
            return
        if op in (0x0B, 0x1B, 0x2B, 0x3B):               # dec rr
            if op == 0x0B:
                self.bc = (self.bc - 1) & 0xFFFF
            elif op == 0x1B:
                self.de = (self.de - 1) & 0xFFFF
            elif op == 0x2B:
                self.hl = (self.hl - 1) & 0xFFFF
            else:
                self.sp = (self.sp - 1) & 0xFFFF
            return
        if op in (0x04, 0x0C, 0x14, 0x1C, 0x24, 0x2C, 0x34, 0x3C):
            r = (op >> 3) & 7                            # inc r
            self._set_r(r, self._inc8(self._get_r(r)))
            return
        if op in (0x05, 0x0D, 0x15, 0x1D, 0x25, 0x2D, 0x35, 0x3D):
            r = (op >> 3) & 7                            # dec r
            self._set_r(r, self._dec8(self._get_r(r)))
            return
        if op in (0x09, 0x19, 0x29, 0x39):               # add hl,rr
            otro = {0x09: self.bc, 0x19: self.de,
                    0x29: self.hl, 0x39: self.sp}[op]
            self.hl = self._add16(self.hl, otro)
            return
        if op == 0x02:                                   # ld (bc),a
            self._escribir(self.bc, self.a); return
        if op == 0x12:                                   # ld (de),a
            self._escribir(self.de, self.a); return
        if op == 0x0A:                                   # ld a,(bc)
            self.a = self._leer(self.bc); return
        if op == 0x1A:                                   # ld a,(de)
            self.a = self._leer(self.de); return
        if op == 0x22:                                   # ld (nn),hl
            self._escribir16(nn(), self.hl); return
        if op == 0x2A:                                   # ld hl,(nn)
            self.hl = self._leer16(nn()); return
        if op == 0x32:                                   # ld (nn),a
            self._escribir(nn(), self.a); return
        if op == 0x3A:                                   # ld a,(nn)
            self.a = self._leer(nn()); return
        if op == 0x07:                                   # rlca
            self.a = ((self.a << 1) | (self.a >> 7)) & 0xFF
            self.f = (self.f & (FZ | FS | FPV)) | (self.a & FC)
            return
        if op == 0x0F:                                   # rrca
            c = self.a & 1
            self.a = ((self.a >> 1) | (c << 7)) & 0xFF
            self.f = (self.f & (FZ | FS | FPV)) | c
            return
        if op == 0x17:                                   # rla
            c = (self.f & FC)
            nc = (self.a >> 7) & 1
            self.a = ((self.a << 1) | c) & 0xFF
            self.f = (self.f & (FZ | FS | FPV)) | nc
            return
        if op == 0x1F:                                   # rra
            c = (self.f & FC)
            nc = self.a & 1
            self.a = ((self.a >> 1) | (c << 7)) & 0xFF
            self.f = (self.f & (FZ | FS | FPV)) | nc
            return
        if op == 0x27:                                   # daa
            c = self.f & FC
            h = self.f & FH
            n = self.f & FN
            ajuste = 0
            if h or (not n and (self.a & 0x0F) > 9):
                ajuste |= 0x06
            if c or (not n and self.a > 0x99):
                ajuste |= 0x60
                c = FC
            self.a = ((self.a - ajuste) if n else (self.a + ajuste)) & 0xFF
            self.f = (n | c | (FZ if self.a == 0 else 0) | (self.a & FS))
            return
        if op == 0x2F:                                   # cpl
            self.a ^= 0xFF
            self.f |= FN | FH
            return
        if op == 0x37:                                   # scf
            self.f = (self.f & (FZ | FS | FPV)) | FC
            return
        if op == 0x3F:                                   # ccf
            self.f = (self.f & (FZ | FS | FPV)) | (0 if self.f & FC else FC)
            return
        if op == 0x08:                                   # ex af,af'
            af = (self.a << 8) | self.f
            self.a, self.f = (self.af_ >> 8) & 0xFF, self.af_ & 0xFF
            self.af_ = af
            return
        if op == 0xD9:                                   # exx
            bc, de, hl = self.bc, self.de, self.hl
            self.bc, self.de, self.hl = self.bc_, self.de_, self.hl_
            self.bc_, self.de_, self.hl_ = bc, de, hl
            return
        if op == 0xEB:                                   # ex de,hl
            self.de, self.hl = self.hl, self.de
            return
        if op == 0xE3:                                   # ex (sp),hl
            v = self._leer16(self.sp)
            self._escribir16(self.sp, self.hl)
            self.hl = v
            return
        if op == 0x10:                                   # djnz
            d = n()
            self.b = (self.b - 1) & 0xFF
            if self.b:
                self.pc = (self.pc + (d - 256 if d > 127 else d)) & 0xFFFF
            return
        if op == 0x18:                                   # jr
            d = n()
            self.pc = (self.pc + (d - 256 if d > 127 else d)) & 0xFFFF
            return
        if op in (0x20, 0x28, 0x30, 0x38):               # jr cc
            d = n()
            if self._cond((op >> 3) & 3):
                self.pc = (self.pc + (d - 256 if d > 127 else d)) & 0xFFFF
            return
        if op == 0xC3:                                   # jp
            self.pc = nn(); return
        if op in (0xC2, 0xCA, 0xD2, 0xDA, 0xE2, 0xEA, 0xF2, 0xFA):
            d = nn()                                     # jp cc
            if self._cond2((op >> 3) & 7):
                self.pc = d
            return
        if op == 0xE9:                                   # jp (hl)
            self.pc = self.hl; return
        if op == 0xCD:                                   # call
            d = nn(); self._push(self.pc); self.pc = d; return
        if op in (0xC4, 0xCC, 0xD4, 0xDC, 0xE4, 0xEC, 0xF4, 0xFC):
            d = nn()                                     # call cc
            if self._cond2((op >> 3) & 7):
                self._push(self.pc); self.pc = d
            return
        if op == 0xC9:                                   # ret
            self.pc = self._pop(); return
        if op in (0xC0, 0xC8, 0xD0, 0xD8, 0xE0, 0xE8, 0xF0, 0xF8):
            if self._cond2((op >> 3) & 7):               # ret cc
                self.pc = self._pop()
            return
        if op in (0xC5, 0xD5, 0xE5, 0xF5):               # push
            self._push({0xC5: self.bc, 0xD5: self.de, 0xE5: self.hl,
                        0xF5: (self.a << 8) | self.f}[op])
            return
        if op in (0xC1, 0xD1, 0xE1, 0xF1):               # pop
            v = self._pop()
            if op == 0xC1:
                self.bc = v
            elif op == 0xD1:
                self.de = v
            elif op == 0xE1:
                self.hl = v
            else:
                self.a, self.f = (v >> 8) & 0xFF, v & 0xFF
            return
        if op in (0xC6, 0xCE, 0xD6, 0xDE, 0xE6, 0xEE, 0xF6, 0xFE):
            self._alu((op >> 3) & 7, n())                # alu a,n
            return
        if op in (0xF3, 0xFB):                           # di / ei
            return
        if op == 0xD3:                                   # out (n),a
            self.maq.escribe(n(), self.a); return
        if op == 0xDB:                                   # in a,(n)
            self.a = self.maq.lee(n()); return
        if op == 0xF9:                                   # ld sp,hl
            self.sp = self.hl; return

        raise ParadaZ80("opcode 0x%02X sin implementar, en 0x%04X" % (op, pc0))

    # ------------------------------------------------------------ auxiliares

    def _byte(self):
        v = self._leer(self.pc)
        self.pc = (self.pc + 1) & 0xFFFF
        return v

    def _palabra(self):
        v = self._leer16(self.pc)
        self.pc = (self.pc + 2) & 0xFFFF
        return v

    def _push(self, v):
        self.sp = (self.sp - 2) & 0xFFFF
        self._escribir16(self.sp, v)

    def _pop(self):
        v = self._leer16(self.sp)
        self.sp = (self.sp + 2) & 0xFFFF
        return v

    def _cond(self, n):
        """Las cuatro condiciones de los `jr`: nz, z, nc, c."""
        return [not self.f & FZ, self.f & FZ,
                not self.f & FC, self.f & FC][n]

    def _cond2(self, n):
        """Las ocho de los `jp`, `call` y `ret`."""
        return [not self.f & FZ, self.f & FZ,
                not self.f & FC, self.f & FC,
                not self.f & FPV, self.f & FPV,
                not self.f & FS, self.f & FS][n]

    def _alu(self, cual, v):
        if cual == 0:
            self._suma(v)
        elif cual == 1:
            self._suma(v, 1 if self.f & FC else 0)
        elif cual == 2:
            self._resta(v)
        elif cual == 3:
            self._resta(v, 1 if self.f & FC else 0)
        elif cual == 4:
            self.a &= v; self._sz(self.a); self.f = (self.f & ~FC) | FH
        elif cual == 5:
            self.a ^= v; self.f = 0; self._sz(self.a)
        elif cual == 6:
            self.a |= v; self.f = 0; self._sz(self.a)
        else:
            self._resta(v, 0, guarda=False)              # cp

    def _cb(self, pc0):
        op = self._byte()
        r = op & 7
        v = self._get_r(r)
        if 0x40 <= op <= 0x7F:                           # bit n,r
            b = (op >> 3) & 7
            self.f = (self.f & FC) | FH | (0 if v & (1 << b) else FZ | FPV)
            return
        if 0x80 <= op <= 0xBF:                           # res n,r
            self._set_r(r, v & ~(1 << ((op >> 3) & 7))); return
        if op >= 0xC0:                                   # set n,r
            self._set_r(r, v | (1 << ((op >> 3) & 7))); return
        self._set_r(r, self._rota((op >> 3) & 7, v))

    def _rota(self, cual, v):
        """Las ocho rotaciones y desplazamientos de CB, con sus banderas."""
        if cual == 0:                                    # rlc
            c = (v >> 7) & 1; v = ((v << 1) | c) & 0xFF
        elif cual == 1:                                  # rrc
            c = v & 1; v = ((v >> 1) | (c << 7)) & 0xFF
        elif cual == 2:                                  # rl
            c = (v >> 7) & 1; v = ((v << 1) | (1 if self.f & FC else 0)) & 0xFF
        elif cual == 3:                                  # rr
            c = v & 1; v = ((v >> 1) | (0x80 if self.f & FC else 0)) & 0xFF
        elif cual == 4:                                  # sla
            c = (v >> 7) & 1; v = (v << 1) & 0xFF
        elif cual == 5:                                  # sra
            c = v & 1; v = ((v >> 1) | (v & 0x80)) & 0xFF
        elif cual == 6:                                  # sll, la no documentada
            c = (v >> 7) & 1; v = ((v << 1) | 1) & 0xFF
        else:                                            # srl
            c = v & 1; v = (v >> 1) & 0xFF
        self.f = (FZ if v == 0 else 0) | (v & FS) | (FC if c else 0)
        return v

    def _ed(self, pc0):
        op = self._byte()
        if op in (0xB0, 0xB8, 0xA0, 0xA8):               # ldir/lddr/ldi/ldd
            paso = 1 if op in (0xB0, 0xA0) else -1
            repite = op in (0xB0, 0xB8)
            while True:
                self._escribir(self.de, self._leer(self.hl))
                self.hl = (self.hl + paso) & 0xFFFF
                self.de = (self.de + paso) & 0xFFFF
                self.bc = (self.bc - 1) & 0xFFFF
                if not repite or self.bc == 0:
                    break
            self.f &= ~(FN | FH | FPV)
            return
        if op in (0x42, 0x52, 0x62, 0x72):               # sbc hl,rr
            otro = {0x42: self.bc, 0x52: self.de,
                    0x62: self.hl, 0x72: self.sp}[op]
            c = 1 if self.f & FC else 0
            r = self.hl - otro - c
            self.f = (FN | (FZ if (r & 0xFFFF) == 0 else 0)
                      | ((r >> 8) & FS) | (FC if r < 0 else 0))
            self.hl = r & 0xFFFF
            return
        if op in (0x4A, 0x5A, 0x6A, 0x7A):               # adc hl,rr
            otro = {0x4A: self.bc, 0x5A: self.de,
                    0x6A: self.hl, 0x7A: self.sp}[op]
            c = 1 if self.f & FC else 0
            r = self.hl + otro + c
            self.f = ((FZ if (r & 0xFFFF) == 0 else 0) | ((r >> 8) & FS)
                      | (FC if r > 0xFFFF else 0))
            self.hl = r & 0xFFFF
            return
        if op in (0x43, 0x53, 0x63, 0x73):               # ld (nn),rr
            d = self._palabra()
            self._escribir16(d, {0x43: self.bc, 0x53: self.de,
                                 0x63: self.hl, 0x73: self.sp}[op])
            return
        if op in (0x4B, 0x5B, 0x6B, 0x7B):               # ld rr,(nn)
            v = self._leer16(self._palabra())
            if op == 0x4B:
                self.bc = v
            elif op == 0x5B:
                self.de = v
            elif op == 0x6B:
                self.hl = v
            else:
                self.sp = v
            return
        if op == 0x44:                                   # neg
            a = self.a
            self.a = 0
            self._resta(a)
            return
        if op in (0x46, 0x56, 0x5E, 0x4D, 0x45):         # im n / reti / retn
            if op in (0x4D, 0x45):
                self.pc = self._pop()
            return
        if op in (0x41, 0x49, 0x51, 0x59, 0x61, 0x69, 0x79):   # out (c),r
            self.maq.escribe(self.c, self._get_r((op >> 3) & 7)); return
        if op in (0x40, 0x48, 0x50, 0x58, 0x60, 0x68, 0x78):   # in r,(c)
            self._set_r((op >> 3) & 7, self.maq.lee(self.c)); return
        if op in (0xB3, 0xA3, 0xBB, 0xAB):               # otir/outi/otdr/outd
            paso = 1 if op in (0xB3, 0xA3) else -1
            repite = op in (0xB3, 0xBB)
            while True:
                self.maq.escribe(self.c, self._leer(self.hl))
                self.hl = (self.hl + paso) & 0xFFFF
                self.b = (self.b - 1) & 0xFF
                if not repite or self.b == 0:
                    break
            self.f = (self.f & ~FZ) | (FZ if self.b == 0 else 0) | FN
            return
        if op in (0x47, 0x4F, 0x57, 0x5F):               # ld i,a / ld a,r ...
            if op in (0x57, 0x5F):
                # El registro R no se emula: aqui no hay refresco. Quien lo use
                # para hacer de azar tiene que saberlo, asi que se devuelve 0.
                self.a = 0
                self._sz(0)
            return
        raise ParadaZ80("opcode ED 0x%02X sin implementar, en 0x%04X"
                        % (op, pc0))

    def _indexado(self, prefijo, pc0):
        op = self._byte()
        nombre = "ix" if prefijo == 0xDD else "iy"
        idx = getattr(self, nombre)

        if op == 0x21:                                   # ld ix,nn
            setattr(self, nombre, self._palabra()); return
        if op == 0x22:                                   # ld (nn),ix
            self._escribir16(self._palabra(), idx); return
        if op == 0x2A:                                   # ld ix,(nn)
            setattr(self, nombre, self._leer16(self._palabra())); return
        if op == 0x23:                                   # inc ix
            setattr(self, nombre, (idx + 1) & 0xFFFF); return
        if op == 0x2B:                                   # dec ix
            setattr(self, nombre, (idx - 1) & 0xFFFF); return
        if op == 0xE5:                                   # push ix
            self._push(idx); return
        if op == 0xE1:                                   # pop ix
            setattr(self, nombre, self._pop()); return
        if op == 0xE9:                                   # jp (ix)
            self.pc = idx; return
        if op in (0x09, 0x19, 0x29, 0x39):               # add ix,rr
            otro = {0x09: self.bc, 0x19: self.de,
                    0x29: idx, 0x39: self.sp}[op]
            setattr(self, nombre, self._add16(idx, otro))
            return
        if op == 0x36:                                   # ld (ix+d),n
            d = self._desp(); v = self._byte()
            self._escribir(idx + d, v); return
        if op == 0x34:                                   # inc (ix+d)
            d = self._desp()
            self._escribir(idx + d, self._inc8(self._leer(idx + d))); return
        if op == 0x35:                                   # dec (ix+d)
            d = self._desp()
            self._escribir(idx + d, self._dec8(self._leer(idx + d))); return
        if op in (0x46, 0x4E, 0x56, 0x5E, 0x66, 0x6E, 0x7E):   # ld r,(ix+d)
            d = self._desp()
            self._set_r((op >> 3) & 7, self._leer(idx + d)); return
        if op in (0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x77):   # ld (ix+d),r
            d = self._desp()
            self._escribir(idx + d, self._get_r(op & 7)); return
        if op in (0x86, 0x8E, 0x96, 0x9E, 0xA6, 0xAE, 0xB6, 0xBE):
            d = self._desp()                             # alu a,(ix+d)
            self._alu((op >> 3) & 7, self._leer(idx + d)); return
        if op == 0xCB:                                   # bit/res/set (ix+d)
            d = self._desp()
            sub = self._byte()
            dir_ = (idx + d) & 0xFFFF
            v = self._leer(dir_)
            b = (sub >> 3) & 7
            if 0x40 <= sub <= 0x7F:
                self.f = (self.f & FC) | FH | (0 if v & (1 << b) else FZ | FPV)
            elif 0x80 <= sub <= 0xBF:
                self._escribir(dir_, v & ~(1 << b))
            elif sub >= 0xC0:
                self._escribir(dir_, v | (1 << b))
            elif (sub & 7) == 6:                         # rlc..srl (ix+d)
                self._escribir(dir_, self._rota((sub >> 3) & 7, v))
            else:
                raise ParadaZ80("DD CB 0x%02X sin implementar, en 0x%04X"
                                % (sub, pc0))
            return
        raise ParadaZ80("opcode %02X 0x%02X sin implementar, en 0x%04X"
                        % (prefijo, op, pc0))

    def _desp(self):
        d = self._byte()
        return d - 256 if d > 127 else d
