#! /bin/ash

# This file is intended to be used when the source code has been
# downloaded and it's gonna be running from outside of a container (a
# volume).
# When building an image, this file can be ignored.

docker network create alambre

docker run --rm -d \
--network alambre \
--name flan \
cloudflare/cloudflared:latest \
tunnel --no-autoupdate run --token $TOKEN

docker run --rm -d \
--network alambre \
--name mac \
-p 10011:10011 \
-w /app \
-v "$(pwd)":/app \
python:3.11.2-alpine3.17 \
ash -c "
pip install --upgrade pip
pip install --no-cache-dir -r req.txt
python app.py dev
"
