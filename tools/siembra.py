#!/usr/bin/env python3
"""Coteja con la RAM del juego al pedir cada pieza: para cada `S nn` toma el
volcado `M` anterior (RAM desde 0xE000), lo pone en el motor y compara el chip
cuadro a cuadro. Sirve cuando la pieza se pide con otra aun sonando.
Uso: siembra.py work/psg/psg.txt [indice_de_peticion ...]"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import coteja_psg as c  # noqa: E402
import motor_musica as mm  # noqa: E402
import musica  # noqa: E402


def main(ruta, indices):
    inicio = int(os.environ.get("PSG_MRAM", "57344 96").split()[0])   # donde empieza la RAM de las lineas M
    cfg = musica.CFG
    rom = open(os.path.join(mm.RAIZ, cfg["rom"]), "rb").read()
    L = open(ruta).read().split("\n")
    Ms = [l.split()[1] for l in L if l.startswith("M ")]
    # las ordenes que el juego da en la misma interrupcion (sin un cuadro entre ellas)
    seguidas, ultimo = {}, None
    n_s = -1
    psg, base, espera = [0] * 14, {}, None
    for l in L:
        p = l.split()
        if p and p[0] == "W" and int(p[1]) < 14:
            psg[int(p[1])] = int(p[2])
        if l == "F" and espera is not None:       # el chip tal como esta al llegar el primer cuadro
            base[espera] = list(psg)
            espera = None
        if l.startswith("S "):
            n_s += 1
            espera = n_s
            if ultimo is not None:
                seguidas.setdefault(ultimo, []).append(int(l.split()[1]))
            else:
                ultimo = n_s
        elif l == "F":
            ultimo = None
    for idx, (a, ini, cu, _, _) in enumerate(c.lee(ruta)):
        if (indices and idx not in indices) or len(cu) < c.MIN_CUADROS:
            continue
        z = mm.Cartucho(cfg, rom)
        z.sp = cfg.get("sp", 0xF000)
        z.mem[inicio:inicio + len(Ms[idx]) // 2] = bytes.fromhex(Ms[idx])
        for r in range(14):
            z.maq.psg[r] = ini[r]
        z.a = a
        for k, v in {**cfg.get("regs_pide", {}),
                     **cfg.get("regs_pide_de", {}).get(a, {})}.items():
            setattr(z, k, v)
        z.corre(cfg["pide"])
        for otra in seguidas.get(idx, ()):
            z.a = otra
            z.corre(cfg["pide"])
        for d, regs in cfg.get("post_pide", ()):     # lo que la interrupcion hace tras atender la cola
            for k, v in regs.items():
                setattr(z, k, v)
            z.corre(d)
        ini = base.get(idx, ini)       # lo que la interrupcion escribio tras la orden ya esta en el chip
        est, ellos, mal = list(ini), list(ini), None
        z.escrituras.clear()
        for i in range(len(cu)):
            es = mm.cuadro(z)
            for r, v in cu[i]:
                if r < 14:
                    ellos[r] = v
            for r, v in es:
                if r < 14:
                    est[r] = v
            if mal is None and ellos != est:
                mal = i
                dif = (list(ellos), list(est))
        print("peticion %d, 0x%02X: %d cuadros, %s" % (
            idx, a, len(cu), "el PSG IGUAL en todos" if mal is None
            else "el PSG DISTINTO en el %d\n   openMSX %s\n   musica  %s"
            % (mal, dif[0], dif[1])))


if __name__ == "__main__":
    main(sys.argv[1], {int(x) for x in sys.argv[2:]})
