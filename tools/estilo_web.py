#!/usr/bin/env python3
"""La hoja de estilo de la web, compartida por todos los desensamblados.

Se saca a un modulo aparte a proposito: la idea es que los desensamblados de
esta serie se vean todos igual, asi que el diseno se toca aqui y una sola vez.
No lleva nada especifico de ningun juego.
"""

ESTILO = """
:root{--tinta:#cfd0d4;--suave:#83868f;--fondo:#000;--panel:#0c0e13;--linea:#23262e;
  --rojo:#ff897d;--cyan:#65dbef;--verde:#3eb849;--oro:#ded087}
@media (prefers-color-scheme:light){:root{--tinta:#191a1e;--suave:#5a5d66;--fondo:#e9e7e1;
  --panel:#f7f6f2;--linea:#d0cdc5;--rojo:#b23f34;--cyan:#1c6b7c;--verde:#2b7734;--oro:#8a7420}}
:root[data-theme="dark"]{--tinta:#cfd0d4;--suave:#83868f;--fondo:#000;--panel:#0c0e13;
  --linea:#23262e;--rojo:#ff897d;--cyan:#65dbef;--verde:#3eb849;--oro:#ded087}
:root[data-theme="light"]{--tinta:#191a1e;--suave:#5a5d66;--fondo:#e9e7e1;--panel:#f7f6f2;
  --linea:#d0cdc5;--rojo:#b23f34;--cyan:#1c6b7c;--verde:#2b7734;--oro:#8a7420}
*{box-sizing:border-box}
body{margin:0;background:var(--fondo);color:var(--tinta);padding:0 1.25rem 6rem;
  font:15px/1.7 ui-monospace,"SF Mono",Menlo,Consolas,monospace}
.w{max-width:1120px;margin:0 auto}
.n{max-width:68ch}
h1,h2,h3,h4{font-weight:400;text-wrap:balance}
a{color:var(--cyan)}
img{image-rendering:pixelated;max-width:100%;height:auto;display:block}
header.top{display:flex;flex-direction:column;align-items:center;gap:1.5rem;
  padding:4rem 0 2rem;text-align:center}
header.top img{width:min(100%,642px)}
.claim{max-width:60ch;color:var(--suave);font-size:1.05rem}
.claim b{color:var(--tinta);font-weight:400}
.ficha{display:flex;flex-wrap:wrap;justify-content:center;gap:0 1.5rem;width:100%;
  font-size:12px;letter-spacing:.08em;text-transform:uppercase;color:var(--suave);
  border-top:1px solid var(--linea);border-bottom:1px solid var(--linea);padding:.85rem 0}
.ficha b{color:var(--rojo);font-weight:400}
nav{display:flex;flex-wrap:wrap;gap:1.25rem;justify-content:center;padding:1.25rem 0;
  font-size:12px;letter-spacing:.08em;text-transform:uppercase}
nav a{color:var(--suave);text-decoration:none;border-bottom:1px solid transparent}
nav a:hover,nav a:focus{color:var(--tinta);border-bottom-color:var(--rojo)}
nav.docs{border-top:1px solid var(--linea);border-bottom:1px solid var(--linea);
  margin-bottom:1rem}
section{margin-top:4.5rem;scroll-margin-top:1rem}
section>h2{font-size:1rem;letter-spacing:.1em;text-transform:uppercase;
  border-left:3px solid var(--rojo);padding-left:.9rem;margin:0 0 1.5rem}
.cifras{display:grid;gap:1px;background:var(--linea);border:1px solid var(--linea);
  grid-template-columns:repeat(auto-fit,minmax(160px,1fr))}
.cifra{background:var(--panel);padding:1.1rem}
.cifra b{display:block;font-size:1.7rem;color:var(--oro);font-weight:400;
  font-variant-numeric:tabular-nums;line-height:1.2}
.cifra span{font-size:11px;letter-spacing:.07em;text-transform:uppercase;color:var(--suave)}
.hall{border-top:1px solid var(--linea);padding-top:1.75rem;margin-top:2.5rem}
.hall:first-of-type{border-top:0;padding-top:0;margin-top:0}
.hall h3{margin:0 0 .75rem;font-size:1.15rem;color:var(--rojo)}
.hall h4{color:var(--oro);margin:1.5rem 0 .5rem;font-size:.95rem}
.hall p{margin:0 0 1rem}
pre.asm{background:var(--panel);border-left:2px solid var(--verde);margin:1.25rem 0;
  padding:1rem 1.1rem;overflow-x:auto;font-size:13px;line-height:1.6;color:var(--tinta)}
.par{display:grid;gap:1.25rem;grid-template-columns:1fr}
@media(min-width:820px){.par{grid-template-columns:1fr 1fr}}
.par figure{margin:0}
table{border-collapse:collapse;width:100%;margin:1.25rem 0;font-size:13px;display:block;
  overflow-x:auto}
th,td{text-align:left;padding:.5rem .75rem;border-bottom:1px solid var(--linea)}
th{color:var(--suave);font-weight:400;font-size:11px;letter-spacing:.07em;text-transform:uppercase}
td.num{font-variant-numeric:tabular-nums;color:var(--oro)}
.nivel{margin-top:2rem}
.nivel h3{margin:0 0 .9rem;font-size:.95rem;letter-spacing:.06em;text-transform:uppercase}
.nivel em{color:var(--cyan);font-style:normal}
.sep{color:var(--suave);margin:0 .6rem}
.rejilla{display:grid;gap:.9rem;grid-template-columns:repeat(auto-fill,minmax(250px,1fr))}
.rejilla figure{margin:0;background:var(--panel);box-shadow:0 0 0 1px var(--linea)}
.rejilla figcaption{display:flex;justify-content:space-between;padding:.45rem .65rem;
  font-size:11px;color:var(--suave);border-top:1px solid var(--linea)}
.dir{font-variant-numeric:tabular-nums;color:var(--verde)}
footer{margin-top:5rem;padding-top:1.5rem;border-top:1px solid var(--linea);
  color:var(--suave);font-size:12px}

/* Aviso de trabajo en curso: tiene que verse antes que las cifras, porque un
   100% mal leido hace mas dano que no ponerlo. */
.aviso{background:#3a2a10;border-left:3px solid var(--oro);margin:1.5rem auto;
  padding:1rem 1.2rem;max-width:900px;border-radius:4px}
.aviso p{margin:0;color:var(--tinta);font-size:15px;line-height:1.65}
.galeria{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
  gap:1.5rem;margin:1.5rem 0}
.galeria figure{margin:0}
.galeria img{width:100%;height:auto;image-rendering:pixelated;
  border:1px solid var(--linea);border-radius:3px}
.galeria figcaption{color:var(--suave);font-size:13px;margin-top:.5rem}
audio{display:block;width:100%;max-width:640px;margin:.75rem 0 1.5rem}
"""