#! /bin/ash

modo=$1
VER=$2
push=$3

if [ "$modo" = "install" ]; then
     echo Installando buildx en Docker!
elif [ "$modo" = "build" ] && [ -n "$VER" ]; then
     echo Compilando la version $VER
elif [ "$modo" = "publish" ] || [ "$push" = "p" ]; then
     echo Publicando imagenes ...\nzi
else
     echo lel
fi

     # # install buildx
     # echo mkdir -p ~/.docker/cli-plugins
     # echo curl -SL https://github.com/docker/buildx/releases/download/v0.6.3/buildx-v0.6.3.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
     # echo chmod a+x ~/.docker/cli-plugins/docker-buildx
     # echo docker buildx create --driver=docker-container --name=slave

     # # build commands
     # echo docker buildx build --builder=slave --platform=linux/amd64 -t patod01/remo:$VER-amd . --load
     # echo docker buildx build --builder=slave --platform=linux/arm64/v8 -t patod01/remo:$VER-arm . --load

     # # puslibh
     # echo docker push patod01/remo:$VER-amd
     # echo docker push patod01/remo:$VER-arm
     # echo docker manifest create patod01/remo:$VER patod01/remo:$VER-amd patod01/remo:$VER-arm
     # echo docker manifest create patod01/remo patod01/remo:$VER-amd patod01/remo:$VER-arm
     # echo docker manifest push patod01/remo:$VER
     # echo docker manifest push patod01/remo
     #!/bin/ash
