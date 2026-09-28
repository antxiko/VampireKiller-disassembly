# Empezar

Para reproducir este desensamblado hace falta Python 3 (con Pillow para las
imágenes), GNU make y [Pasmo](https://pasmo.speccy.org/). La imagen del
cartucho **no viaja en este repositorio**: cada cual pone la suya.

```
vampirekiller.rom    131.072 bytes
sha256               99eabaaeb2b6c02220e131043d5a6401d0d8c5f413d89204547adcc04d65e7e2
```

Con el fichero en la raíz del repositorio:

```
make            # listado, verificación, coherencia y tests
```

## Qué hace cada paso

| orden | qué hace |
|---|---|
| `make comprueba` | comprueba el sha256 de la ROM |
| `make listado` | genera los dieciséis `.asm` desde el binario, las notas y las semillas |
| `make verify` | reensambla cada banco y la ROM entera, y compara los sha256 |
| `make sanity` | comprueba que no queda un solo byte sin asignar a código o a datos |
| `make test` | los tests |
| `make densidad` | cuántas instrucciones llevan comentario, banco a banco |
| `make imagenes` | dibuja los PNG de `docs/imagenes/` desde la ROM |
| `make coteja` | coteja las imágenes con los volcados de openMSX de `work/` |
| `make web` | genera las páginas HTML y comprueba los enlaces |

`make verify` es el que decide: tiene que imprimir dieciséis veces
`OK: reproducible byte a byte`, una por banco, y al final
`OK: la ROM entera reproducible byte a byte`.

`make coteja` necesita los volcados de openMSX, que no viajan en el
repositorio: se hacen con los lanzadores de
[En el emulador](EN-EL-EMULADOR.md).

## Dónde está cada cosa

- `src/vampirekiller_pNN.asm`: el listado, uno por banco. **Se genera**: no
  se edita a mano.
- `src/pNN.notes`: las etiquetas (`L`), los comentarios de línea (`C`), los
  rangos de datos (`D`) y los encabezados de rutina (`B`). Esto **sí** se
  edita.
- `src/pNN.entries` y `src/pNN.nocode`: las entradas de cada banco y las
  tablas que no son código, sacadas del trazado del cartucho entero
  (`make semillas`).
- `tools/`: el trazador, el generador del listado y las herramientas que
  dibujan y cotejan.
- `docs/`: esta web, en inglés en la raíz y en castellano en `docs/es/`.
