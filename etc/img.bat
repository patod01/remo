@echo off

rem este archivo no sirve para nada xD

set modo=%1
set VER=%2
set push=%3

if  "%modo%" == "install" (
     echo Installando buildx en Docker!
     :: install buildx
     echo mkdir -p ~/.docker/cli-plugins
     echo curl -SL https://github.com/docker/buildx/releases/download/v0.6.3/buildx-v0.6.3.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
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
     echo holata
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
echo uso:
echo build.sh install ^| build VERSION [publish] ^| publish VERSION

:ned
