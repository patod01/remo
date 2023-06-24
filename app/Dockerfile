### actual sh1t ###
FROM python:3.11.2-alpine3.17 AS pydep

ENV PATH="/server/virt/bin:$PATH"
ENV VIRTUAL_ENV="/server/virt"

# dependencias para pie
RUN apk add gcc musl-dev libffi-dev make g++ python3-dev libev-dev
# aparentemente no son necesarios: g++ python3-dev libev-dev

WORKDIR /server
RUN python -m venv virt
COPY ./req.txt .
RUN python -m pip install --upgrade pip

RUN pip install --no-cache-dir -r req.txt


### actual sh2t ###
FROM python:3.11.2-alpine3.17 AS server

ENV MODE="dev"
ENV DEVELOPER=""

WORKDIR /server/app
COPY --from=pydep /server/virt ../virt
COPY . .

CMD source ../virt/bin/activate && python app.py $MODE $DEVELOPER
