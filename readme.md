# Resumen

Este proyecto es para aprender a usar APIs, websockets, PaaS, Docker,
entre otras tecnologias.

# Uso

Para ejecutar la aplicacion, hay metodos para linux, windows y
docker. A grandes rasgos, se debe correr el siguiente comando:

```bash
python app.py MODE [DEVELOPER]
```

- `MODE`: debe ser `dev` o `Gevent0`, lo que ejecuta a la aplicacion
en el puerto `10011` en modo debug o en el puerto `10001`
respectivamente.
- `DEVELOPER`: sirve para modificar el nombre del profesional a cargo
de la app, el que se muestra en la seccion de `Mas informacion` de la
pagina principal.

## Imagen de Docker

El siguiente comando crea la imagen y el contenedor:

```bash
docker build -t remo .
docker run --rm -it --net=host remo
```

Tambien se puede usar la imagen `patod01/remo:latest`. (wip)

El contenedor ocupa el puerto `10011` por defecto. Para definir los
parametros de entrada de `app.py`, se pueden pasar las variables de
entorno `MODE` y `DEVELOPER`. Opcionalmente se puede reconstruir el
comando con el que se ejecuta el contenedor, pero se debe recordar
habilitar el entorno virtual de python.

Comando generico para crear el contenedor:

```bash
docker run --rm -it --net=host -e MODE=dev -e DEVELOPER="" IMAGEN
```

## Lunix

El script esta dise;ado para correr por defecto con la shell `ash`.
Se debe tener `docker` instalado previamente.

Para ejecutarlo, simplemente usar `chmod +x run.sh` y `./run.sh`, el
programa se ejecutara en un contenedor en el puerto `10011`.

## Windows

- Tener al menos `python 3.11.2` instalado.
- Ejecutar el archivo `run.bat` desde su misma ubicacion o haciendo
doble clic. En la primera ejecucion, se crea un ambiente virtual y se
descargan las dependencias. Desde la segunda ejecucion en adelante se
ejecuta la aplicacion en modo desarrollador por defecto en el puerto
`10011`.
