#!/bin/sh
# rehace.sh: tras meter comentarios a mano, regenera todo en su orden y lo mide.
#   anota.py (que se aparta donde ya hay C a mano) -> listados -> verify ->
#   valida_c en los seis bancos con codigo -> densidad total.
R=$(cd "$(dirname "$0")/.." && pwd)
cd "$R" || exit 1
export PATH="/c/msys64/usr/bin:$PATH"
python tools/anota.py --escribe | tail -1
make listado > /dev/null 2>&1 || { echo "FALLO: make listado"; exit 1; }
make verify 2>&1 | grep -E "OK: la ROM|DIFIERE" || exit 1
for p in 00 01 02 03 13 14; do
  python tools/valida_c.py src/vampirekiller_p$p.asm src/p$p.notes | tail -1 | sed "s/^/p$p/"
done
python - <<'PY'
import subprocess, re, sys
ti = tc = 0
for p in ("00", "01", "02", "03", "13", "14"):
    out = subprocess.run([sys.executable, "tools/densidad.py", "src/vampirekiller_p%s.asm" % p],
                         capture_output=True, text=True).stdout
    m = re.search(r"en total: (\d+) instrucciones, (\d+) comentarios", out)
    f = re.search(r"(\d+) rutinas por debajo del 10 %, de (\d+)", out)
    i, c = int(m.group(1)), int(m.group(2))
    ti += i; tc += c
    print("p%s %5.1f %%  flojas %s/%s" % (p, 100.0 * c / i, f.group(1), f.group(2)))
print("TOTAL %d/%d = %.1f %%" % (tc, ti, 100.0 * tc / ti))
PY
