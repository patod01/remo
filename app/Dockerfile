# install buildx
# mkdir -p ~/.docker/cli-plugins
# curl -SL https://github.com/docker/buildx/releases/download/v0.6.3/buildx-v0.6.3.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
# chmod a+x ~/.docker/cli-plugins/docker-buildx
# docker buildx create --driver=docker-container --name=slave

# build commands
# docker buildx build --platform=linux/amd64 --builder=slave -t patod01/remo:X-amd . --load
# docker buildx build --platform=linux/arm64/v8 --builder=slave -t patod01/remo:X-arm . --load

# puslibh
# docker push patod01/remo:X-amd
# docker push patod01/remo:X-arm
# docker manifest create patod01/remo:X-dev patod01/remo:X-amd patod01/remo:X-arm
# docker manifest push patod01/remo:X-dev

### actual sht ###

FROM python:3.11.2-alpine3.17
WORKDIR /app
COPY . .
RUN python -m pip install --upgrade pip

# aparentemente no son necesarios g++ python3-dev libev-dev
# pendiente probar tama;o final de la imagen para ambos casos
RUN apk add gcc musl-dev libffi-dev make g++ python3-dev libev-dev

RUN pip install --no-cache-dir -r req.txt
RUN mkdir -p db
CMD python app.py dev
