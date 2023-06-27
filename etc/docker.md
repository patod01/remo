# Resumen

Este proyecto es para aprender a usar APIs, websockets, PaaS, Docker,
entre otras tecnologias.

# Uso

Para ejecutar la aplicacion se debe correr el siguiente comando:

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

Los siguientes comandos crean la imagen y el contenedor:

```bash
docker build -t remo .
docker run --rm -it --net=host remo
```

El contenedor ocupa el puerto `10011` por defecto. Para definir los
parametros de entrada de `app.py`, se pueden pasar las variables de
entorno `MODE` y `DEVELOPER`. Opcionalmente se puede reconstruir el
comando `CMD` con el que se ejecuta el contenedor, pero se debe
recordar habilitar el entorno virtual de python.

Comando generico para crear el contenedor:

```bash
docker run --rm -it --net=host -e MODE=dev -e DEVELOPER="" IMAGEN
```
