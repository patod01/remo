@echo off

rem definitivamente esto no sirve xD

setlocal

set modo=%1
set VER=%2
set push=%3

set BUILDX_V=0.6.3

if  "%modo%" == "install" (
     echo Installando buildx en Docker!
     :: install buildx
     echo mkdir -p ~/.docker/cli-plugins
     echo curl -SL https://github.com/docker/buildx/releases/download/v%BUILDX_V%/buildx-v%BUILDX_V%.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
     echo chmod a+x ~/.docker/cli-plugins/docker-buildx
     echo docker buildx create --driver=docker-container --name=slave
     echo Installacion terminada
)

if "%modo%" == "build" if not "%VER%" == "" (
     echo Compilando la version %VER%
     :: build commands
     echo docker buildx build --builder=slave --platform=linux/amd64 -t patod01/remo:%VER%-amd . --load
     echo docker buildx build --builder=slave --platform=linux/arm64/v8 -t patod01/remo:%VER%-arm . --load
     echo compilacion terminada!
     if "%push%" == "publish" (
          echo Publicando imagenesssss
          :: puslibh
          echo docker push patod01/remo:%VER%-amd
          echo docker push patod01/remo:%VER%-arm
          echo docker manifest create patod01/remo:%VER% patod01/remo:%VER%-amd patod01/remo:%VER%-arm
          echo docker manifest create patod01/remo patod01/remo:%VER%-amd patod01/remo:%VER%-arm
          echo docker manifest push patod01/remo:%VER%
          echo docker manifest push patod01/remo
     )
)

if "%modo%" == "publish" if not "%VER%" == "" (
     echo Publicando imagenes version %VER%...
     :: puslibh
     echo docker push patod01/remo:%VER%-amd
     echo docker push patod01/remo:%VER%-arm
     echo docker manifest create patod01/remo:%VER% patod01/remo:%VER%-amd patod01/remo:%VER%-arm
     echo docker manifest create patod01/remo patod01/remo:%VER%-amd patod01/remo:%VER%-arm
     echo docker manifest push patod01/remo:%VER%
     echo docker manifest push patod01/remo
)

if "%modo%" == "--help" goto HELP
if "%modo%" == "-h" goto HELP
goto ned

:HELP
echo Esta es una utilidad para construir los siguientes grupos de instrucciones:
echo.
echo - install: instalar `buildx`.
echo - build: construir las imagenes de docker (dos plataformas por defecto).
echo - publish: publicar a dockerhub.
echo.
echo Nota: Las instrucciones generadas no son ejecutadas automaticamente.
echo Nota: Las instrucciones generadas estan destinadas a ejecutarse en `ash`.
echo.
echo Uso:
echo build.sh install ^| build VERSION [publish] ^| publish VERSION

:ned
