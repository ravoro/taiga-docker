#! /bin/bash

if [[ -z "$BACKEND_PORT" ]]; then
    BACKEND_PORT=8000
fi

if [[ -d  taiga-front-dist ]]; then
    rm -rf taiga-front-dist
fi

git clone -b stable --single-branch https://github.com/taigaio/taiga-front-dist.git

docker build -t taiga-front-latest .

if [[ -d  taiga-front-dist ]]; then
    rm -rf taiga-front-dist
fi
