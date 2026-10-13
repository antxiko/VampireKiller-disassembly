#!/usr/bin/env python3
"""La musica del cartucho, EJECUTANDO su propio motor de sonido (generico).

No se reescribe el motor: se ejecuta el codigo del cartucho con tools/z80run.py.
Cada juego trae en tools/musica.py su configuracion (CFG): donde esta la ROM,
que rutina pide un sonido (con A = el numero), que rutina es el motor de cada
cuadro y que piezas se publican. Aqui esta todo lo demas: la maquina (ROM +
RAM + trampa de la BIOS WRTPSG + puertos 0xA0/0xA1 + SCC si lo hay), el hallazgo
de la vuelta de la musica, el sintetizador AY-3-8910 y el MP3.

CFG (diccionario):
  rom      nombre del fichero en la raiz del repo
  org      direccion donde se carga la ROM
  frame    direccion del motor de cada cuadro (se llama con `call`)
  pide     direccion de la rutina "pedir sonido" (A = numero)
  init     lista de (direccion, {registro: valor}) a llamar antes (opcional)
  ram      (desde, hasta) de la RAM del motor, para ver cuando se repite
  hz       cuadros por segundo (60)
  piezas   [(numero, fichero, nombre)]
  mapper   None | "konami" | "konami_scc" | "ascii8"
"""
import hashlib
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from z80run import Z80, ParadaZ80, Maquina  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RELOJ_PSG = 1789772.5
MUESTREO = 44100
WRTPSG, RDPSG, GICINI = 0x0093, 0x0096, 0x0090


class MaquinaMusica(Maquina):
    """Los puertos del PSG apuntan cada escritura (registro, dato)."""

    def __init__(self, destino):
        super().__init__()
        self.destino = destino

    def escribe(self, p, v):
        p &= 0xFF
        if p == 0xA1:
            self.destino.append((self.psg_reg, v & 0xFF))
        super().escribe(p, v)


class Cartucho(Z80):
    def __init__(self, cfg, rom):
        super().__init__()
        self.cfg = cfg
        self.rom = rom
        self.escrituras = []
        self.scc = []                      # (direccion 0x9800.., dato)
        self.maq = MaquinaMusica(self.escrituras)
        self.bancos = {}
        self.mapper = cfg.get("mapper")
        org = cfg["org"]
        self.org = org
        if self.mapper:
            self.fin_rom = 0xC000
            for v, b in cfg.get("bancos0", ((0x4000, 0), (0x6000, 1),
                                            (0x8000, 2), (0xA000, 3))):
                self.pon_banco(v, b)
        else:
            self.carga(rom, org)
            self.fin_rom = org + len(rom)

    def pon_banco(self, ventana, banco):
        self.bancos[ventana] = banco
        n = len(self.rom) // 0x2000
        b = banco % n
        self.mem[ventana:ventana + 0x2000] = \
            self.rom[b * 0x2000:(b + 1) * 0x2000]

    def _escribir(self, d, v):
        d &= 0xFFFF
        v &= 0xFF
        if self.mapper:
            reg = d & 0xE000
            if 0x4000 <= d < 0xC000:
                if self.mapper == "konami":          # 6000, 8000, A000
                    if reg >= 0x6000:
                        self.pon_banco(reg, v)
                elif self.mapper == "konami_scc":    # 5000, 7000, 9000, B000
                    if (d & 0x1800) == 0x1000:
                        self.pon_banco(reg, v)
                    elif reg == 0x8000 and 0x9800 <= d < 0xA000 and \
                            self.bancos.get(0x8000) == 0x3F:
                        self.scc.append((d - 0x9800, v))
                elif self.mapper == "ascii8":        # 6000,6800,7000,7800
                    self._ascii8(d, v)
                return
            self.mem[d] = v
            return
        if self.org <= d < self.fin_rom:
            return
        self.mem[d] = v

    def _ascii8(self, d, v):
        ventana = {0x6000: 0x4000, 0x6800: 0x6000,
                   0x7000: 0x8000, 0x7800: 0xA000}.get(d & 0xF800)
        if ventana is not None:
            self.pon_banco(ventana, v)

    def corre(self, desde, tope=3_000_000):
        centinela = 0xFFFE
        self.sp = (self.sp - 2) & 0xFFFF
        self._escribir16(self.sp, centinela)
        self.pc = desde
        self.pasos = 0
        while self.pc != centinela:
            if self.pc < 0x4000 and self.pc != 0:
                if self.pc == WRTPSG:
                    self.escrituras.append((self.a & 0x0F, self.e))
                    self.maq.psg[self.a & 0x0F] = self.e
                elif self.pc == RDPSG:
                    self.a = self.maq.psg[self.a & 0x0F]
                elif self.pc == GICINI:
                    pass
                else:
                    raise ParadaZ80("llamada a la BIOS 0x%04X" % self.pc)
                self.pc = self._pop()
                continue
            self.pasos += 1
            if self.pasos > tope:
                raise ParadaZ80("mas de %d instrucciones" % tope)
            self._una()


def corre_frame(z):
    """El motor de un cuadro: una direccion, o una lista de llamadas
    [(direccion, {registro: valor}), ...]."""
    for v, b in z.cfg.get("bancos_frame", ()):    # los bancos que pone la interrupcion
        z.pon_banco(v, b)
    f = z.cfg["frame"]
    if isinstance(f, int):
        z.corre(f)
        return
    for d, regs in f:
        for k, v in regs.items():
            setattr(z, k, v)
        z.corre(d)


def pide_pistas(z, numero):
    """Juegos sin rutina de peticion: la pieza es una lista de escrituras en las
    fichas de los canales, cfg["pistas"][numero] = [("w", dir, valor16) |
    ("b", dir, valor8)], las mismas que hace el juego."""
    for tipo, d, v in z.cfg["pistas"][numero]:
        if tipo == "w":
            z.mem[d] = v & 0xFF
            z.mem[d + 1] = v >> 8
        else:
            z.mem[d] = v & 0xFF


def arranca(cfg, rom, numero):
    z = Cartucho(cfg, rom)
    z.sp = cfg.get("sp", 0xF000)
    for r, v in {**{7: 0xB8}, **cfg.get("psg0", {})}.items():   # el PSG tras el arranque
        z.maq.psg[r] = v
    for d, v in cfg.get("ram0", ()):         # la RAM como la deja el arranque del juego
        z.mem[d] = v
    for d, regs in cfg.get("init", ()):
        for k, v in regs.items():
            setattr(z, k, v)
        z.corre(d)
    for _ in range(cfg.get("cuadros_previos", 1)):
        corre_frame(z)
    if "pistas" in cfg:
        pide_pistas(z, numero)
    else:
        z.a = numero & 0xFF
        for k, v in {**cfg.get("regs_pide", {}),
                     **cfg.get("regs_pide_de", {}).get(numero, {})}.items():
            setattr(z, k, v)
        z.corre(cfg["pide"])
    z.escrituras.clear()
    return z


def cuadro(z):
    z.escrituras.clear()
    corre_frame(z)
    # el SCC va en la misma lista, con el registro 0x100 + su desplazamiento
    # (0x9800 = 0); lo que escribieron el arranque y la peticion entra aqui
    salida = list(z.escrituras) + [(0x100 + o, v) for o, v in z.scc]
    z.scc.clear()
    return salida


def ejecuta(cfg, rom, numero, maximo=None):
    """(cuadros, vuelta): escrituras de cada cuadro y el cuadro al que vuelve."""
    maximo = maximo or cfg.get("hz", 60) * cfg.get("max_s", 300)
    z = arranca(cfg, rom, numero)
    a, b = cfg["ram"]
    cuadros, vistos = [], {}
    for n in range(maximo):
        cuadros.append(cuadro(z))
        ram = bytearray(z.mem[a:b])
        for d in cfg.get("excluye", ()):    # contadores de vueltas, que no cierran el bucle
            ram[d - a] = 0
        h = hashlib.sha1(bytes(ram)).digest()
        if h in vistos:
            if vistos[h] == n:
                return cuadros, None
            return cuadros, vistos[h]
        vistos[h] = n + 1
    return cuadros, None


VOLUMEN = (0.0, 0.0137, 0.0205, 0.0291, 0.0423, 0.0618, 0.0847, 0.1369,
           0.1691, 0.2647, 0.3527, 0.4499, 0.5704, 0.6873, 0.8482, 1.0)


def sintetiza(cuadros, hz=60, psg0=None):
    import numpy as np
    regs = [0] * 16
    regs[7] = 0xB8          # el mezclador como lo deja el arranque del MSX
    for r, v in (psg0 or {}).items():
        regs[r] = v
    por_cuadro = MUESTREO / hz
    fase = [0.0, 0.0, 0.0]
    lfsr, ruido_fase, ruido_bit = 1, 0.0, 0
    env_fase = 0.0
    salida, acumulado = [], 0.0
    ondas = [[0] * 32 for _ in range(4)]       # el SCC: cuatro formas de onda
    scc_per, scc_vol, scc_on = [0] * 5, [0] * 5, 0
    scc_fase = [0.0] * 5
    for escr in cuadros:
        for r, v in escr:
            if r >= 0x100:
                o = r - 0x100
                if o < 0x80:
                    b = v - 256 if v > 127 else v
                    ondas[o >> 5][o & 31] = b
                elif o < 0x8A:
                    c = (o - 0x80) >> 1
                    if o & 1:
                        scc_per[c] = (scc_per[c] & 0xFF) | ((v & 0x0F) << 8)
                    else:
                        scc_per[c] = (scc_per[c] & 0xF00) | v
                elif o < 0x8F:
                    scc_vol[o - 0x8A] = v & 0x0F
                elif o == 0x8F:
                    scc_on = v
                continue
            regs[r & 15] = v
            if (r & 15) == 13:
                env_fase = 0.0
        acumulado += por_cuadro
        n = int(acumulado)
        acumulado -= n
        t = np.arange(n)
        mezcla = np.zeros(n)
        np_ = (regs[6] & 0x1F) or 1
        paso_r = RELOJ_PSG / (16 * np_) / MUESTREO
        pos = ruido_fase + paso_r * t
        cambios = int(pos[-1]) if n else 0
        bits = np.empty(cambios + 1, dtype=bool)
        bits[0] = ruido_bit
        for k in range(1, cambios + 1):
            nuevo = (lfsr ^ (lfsr >> 3)) & 1
            lfsr = (lfsr >> 1) | (nuevo << 16)
            bits[k] = lfsr & 1
        ruido = bits[pos.astype(int)]
        ruido_bit = bits[-1]
        ruido_fase = (ruido_fase + paso_r * n) - cambios
        ep = (regs[11] | (regs[12] << 8)) or 1
        paso_e = RELOJ_PSG / (256 * ep) / MUESTREO * 16
        epos = env_fase + paso_e * t
        forma = regs[13] & 0x0F
        idx = epos.astype(int)
        ciclo, dentro = idx // 16, idx % 16
        sube = (forma & 4) != 0
        if forma < 8:
            env = np.where(ciclo == 0, dentro if sube else 15 - dentro, 0)
        else:
            alterna, sostiene = (forma & 2) != 0, (forma & 1) != 0
            if sostiene:
                fin = (15 if sube else 0) ^ (15 if alterna else 0)
                env = np.where(ciclo == 0, dentro if sube else 15 - dentro, fin)
            else:
                dir_ = (ciclo % 2 == 1) if alterna else np.zeros(n, bool)
                env = np.where(dir_ ^ sube, dentro, 15 - dentro)
        env_fase += paso_e * n
        for c in range(3):
            tp = (regs[2 * c] | ((regs[2 * c + 1] & 0x0F) << 8)) or 1
            f = RELOJ_PSG / (16 * tp)
            tono_off = (regs[7] >> c) & 1
            ruido_off = (regs[7] >> (c + 3)) & 1
            if f >= MUESTREO / 2:
                tono = np.full(n, 0.5)
            else:
                ph = fase[c] + f / MUESTREO * t
                tono = ((ph % 1.0) < 0.5).astype(float)
            fase[c] = (fase[c] + f / MUESTREO * n) % 1.0
            puerta = np.maximum(tono, tono_off) * np.maximum(ruido, ruido_off)
            v = regs[8 + c]
            nivel = (np.array(VOLUMEN)[env.astype(int)] if v & 0x10
                     else VOLUMEN[v & 0x0F])
            mezcla += puerta * nivel
        for c in range(5):                        # el SCC: 5 canales de onda
            if not (scc_on >> c) & 1 or not scc_vol[c]:
                continue
            f = 3579545.0 / (32 * (scc_per[c] + 1))
            if f > 20000:
                continue
            onda_c = np.array(ondas[min(c, 3)], dtype=float) / 128.0
            ph = scc_fase[c] + f / MUESTREO * t
            mezcla += 0.45 * (scc_vol[c] / 15.0) * onda_c[(ph * 32).astype(int) % 32]
            scc_fase[c] = (scc_fase[c] + f / MUESTREO * n) % 1.0
        salida.append(mezcla)
    onda = np.concatenate(salida) if salida else np.zeros(0)
    if len(onda) > 2205:
        onda = onda - np.convolve(onda, np.ones(2205) / 2205, mode="same")
    pico = np.max(np.abs(onda)) or 1.0
    return (onda / pico * 0.9 * 32767).astype(np.int16)


def desarrolla(cuadros, vuelta, hz=60, fundido=8.0):
    if vuelta is None:
        return cuadros, 0
    k = int(fundido * hz)
    bucle = cuadros[vuelta:]
    cola = (bucle * (k // len(bucle) + 1))[:k]
    return cuadros + cola, k


def a_mp3(muestras, ruta, fundido_cuadros=0, hz=60):
    import lameenc
    import numpy as np
    m = muestras.astype(float)
    if fundido_cuadros:
        k = min(int(fundido_cuadros * MUESTREO / hz), len(m))
        m[-k:] *= np.linspace(1.0, 0.0, k)
    enc = lameenc.Encoder()
    enc.set_bit_rate(64)
    enc.set_in_sample_rate(MUESTREO)
    enc.set_channels(1)
    enc.set_quality(2)
    datos = enc.encode(m.astype(np.int16).tobytes()) + enc.flush()
    with open(ruta, "wb") as f:
        f.write(datos)


def sonido_mudo(cuadros):
    return not any(v & 0x1F for escr in cuadros for r, v in escr
                   if 8 <= r <= 10)


def main(cfg, argv):
    rom = open(os.path.join(RAIZ, cfg["rom"]), "rb").read()
    hz = cfg.get("hz", 60)
    if argv[0] == "registros":
        n = int(argv[1], 0)
        cuadros, vuelta = ejecuta(cfg, rom, n,
                                  int(argv[2]) if len(argv) > 2 else None)
        for i, escr in enumerate(cuadros):
            print("%5d %s" % (i, " ".join("%X=%02X" % rv for rv in escr)))
        print("cuadros: %d, vuelve al %s" % (len(cuadros), vuelta))
    elif argv[0] == "mp3":
        n = int(argv[1], 0)
        cuadros, vuelta = ejecuta(cfg, rom, n)
        todo, fundido = desarrolla(cuadros, vuelta, hz)
        if vuelta is None and len(cuadros) >= hz * cfg.get("max_s", 300) - 1:
            fundido = 3 * hz        # la pieza se corta al tope: se apaga en 3 s
        a_mp3(sintetiza(todo, hz, cfg.get("psg0")), argv[2], fundido, hz)
        print("0x%02X: %d cuadros (%.1f s), vuelve al %s -> %s" % (
            n, len(cuadros), len(cuadros) / hz, vuelta, argv[2]))
    elif argv[0] == "todas":
        os.makedirs(argv[1], exist_ok=True)
        for n, fichero, *_ in cfg["piezas"]:
            main(cfg, ["mp3", "0x%02X" % n, os.path.join(argv[1], fichero)])
    elif argv[0] == "emu":
        f = cfg.get("bp_frame") or (cfg["frame"] if isinstance(cfg["frame"], int)
                                    else cfg["frame"][0][0])
        q = cfg.get("bp_pide") or cfg.get("pide") or cfg["bp_frame"]   # bp_pide: el cuerpo de la peticion, comun a todas sus entradas
        org = cfg["org"]
        print("export EMU_MAQUINA=%s EMU_ROM=%s EMU_TIPO='%s'" % (
            cfg.get("maquina", "C-BIOS_MSX1_JP"), cfg["rom"],
            ("-romtype " + cfg["romtype"]) if cfg.get("romtype") else ""))
        print("export PSG_FRAME=0x%04X PSG_FRAME_BYTE=%d" % (
            f, rom[f - org] if not cfg.get("mapper") else rom[cfg["banco_frame"] * 0x2000 + (f & 0x1FFF)]))
        if "pistas" in cfg:
            print("export PSG_PIDE=0x%04X PSG_PIDE_BYTE=%d" % (
                f, rom[f - org] if not cfg.get("mapper") else rom[cfg["banco_frame"] * 0x2000 + (f & 0x1FFF)]))
            return 0
        print("export PSG_PIDE=0x%04X PSG_PIDE_BYTE=%d" % (
            q, rom[q - org] if not cfg.get("mapper") else rom[cfg["banco_pide"] * 0x2000 + (q & 0x1FFF)]))
    elif argv[0] == "barrido":
        for n in range(int(argv[1], 0), int(argv[2], 0) + 1):
            try:
                cuadros, vuelta = ejecuta(cfg, rom, n, hz * 30)
                aud = sum(1 for e in cuadros for r, v in e
                          if 8 <= r <= 10 and v & 0x1F)
                print("0x%02X: %4d cuadros, vuelta %s, %s" % (
                    n, len(cuadros), vuelta,
                    "MUDO" if not aud else "suena (%d volumenes)" % aud))
            except ParadaZ80 as e:
                print("0x%02X: PARADA %s" % (n, e))
    return 0


# ------------------------------------------------- atajos para el musica.py de cada juego

def P(numero, es, en, quien):
    """Una pieza: (numero, fichero, grupo, titulo es, titulo en, quien, quien)."""
    return (numero, "musica_%02X.mp3" % numero, "musica", es, en, quien, quien)


def pagina_basica(motor_es, motor_en, maquina, cotejo, notas=()):
    """CFG["pagina"] con el grupo unico de musicas. `cotejo`: [(es, en)];
    `notas`: [(titulo es, texto es, titulo en, texto en)]."""
    return dict(motor_es=motor_es, motor_en=motor_en, maquina=maquina,
                cotejo=cotejo, notas=list(notas),
                grupos=[("musica", "Las músicas", "The tunes", "", "")])
