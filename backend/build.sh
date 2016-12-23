#! /usr/bin/env bash


if [[ -d taiga-back ]]; then
    rm -rf taiga-back
fi

git clone -b stable --single-branch https://github.com/taigaio/taiga-back.git

docker build -t taiga-back-latest .

if [[ -d  taiga-back ]]; then
    rm -rf taiga-back
fi
