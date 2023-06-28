#! /bin/ash

modo=$1
VER=$2
push=$3

BUILDX_V="0.11.0"

if [ "$modo" = "install" ]; then
     echo Installando buildx en Docker!
     # install buildx
     echo mkdir -p ~/.docker/cli-plugins
     echo curl -SL https://github.com/docker/buildx/releases/download/v$BUILDX_V/buildx-v$BUILDX_V.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
     echo chmod a+x ~/.docker/cli-plugins/docker-buildx
     echo docker buildx create --driver=docker-container --name=slave
     echo Installacion terminada
elif [ "$modo" = "build" ] && [ -n "$VER" ]; then
     echo Compilando la version $VER
     # build commands
     echo docker buildx build --builder=slave --platform=linux/amd64 -t patod01/remo:$VER-amd . --load
     echo docker buildx build --builder=slave --platform=linux/arm64/v8 -t patod01/remo:$VER-arm . --load
     echo compilacion terminada!
     if [ "$push" = "publish" ]; then
          echo Publicando imagenesssss
          # puslibh
          echo docker push patod01/remo:$VER-amd
          echo docker push patod01/remo:$VER-arm
          echo docker manifest create patod01/remo:$VER patod01/remo:$VER-amd patod01/remo:$VER-arm
          echo docker manifest create patod01/remo patod01/remo:$VER-amd patod01/remo:$VER-arm
          echo docker manifest push patod01/remo:$VER
          echo docker manifest push patod01/remo
     fi
elif [ "$modo" = "publish" ] && [ -n "$VER" ]; then
     echo Publicando imagenes version $VER...
     # puslibh
     echo docker push patod01/remo:$VER-amd
     echo docker push patod01/remo:$VER-arm
     echo docker manifest create patod01/remo:$VER patod01/remo:$VER-amd patod01/remo:$VER-arm
     echo docker manifest create patod01/remo patod01/remo:$VER-amd patod01/remo:$VER-arm
     echo docker manifest push patod01/remo:$VER
     echo docker manifest push patod01/remo
elif [ "$modo" = "--help" ] || [ "$modo" = "-h" ]; then
     echo uso:
     echo build.sh install \| build VERSION [publish] \| publish VERSION
else
     echo lel
fi
