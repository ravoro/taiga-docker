#! /usr/bin/env bash

if [[ -z "$API_NAME" ]]; then
    API_NAME=localhost
fi

if [[ -z "$BASE_DIR" ]]; then
    BASE_DIR=$(pwd)
fi

if [[ -z "$POSTGRES_DIR" ]]; then
    POSTGRES_DIR=$BASE_DIR/data/postgres
fi

if [[ -z "$BACKEND_PORT" ]]; then
    BACKEND_PORT=8000
fi

if [[ -z "$FRONTEND_PORT" ]]; then
    FRONTEND_PORT=80
fi

echo API_NAME: $API_NAME
echo BASE_DIR: $BASE_DIR
echo BACKEND_PORT: $BACKEND_PORT
echo FRONTEND_PORT: $FRONTEND_PORT

mkdir -p $POSTGRES_DIR


# start and initialize postgres
docker run -d --restart=always --name postgres -v $POSTGRES_DIR:/var/lib/postgresql/data postgres
# postgres needs some time to startup
sleep 15
docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createuser -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -d -r -s taiga'"
docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createdb -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -O taiga taiga'"


# create backend image
cd $BASE_DIR/backend
source ./build.sh
cd $BASE_DIR


# start and initialize backend
docker run -d --restart=always --name taiga-back-latest -p $BACKEND_PORT:8000 -e API_NAME=$API_NAME  --link postgres:postgres taiga-back-latest
docker run -it --rm --link postgres:postgres taiga-back-latest bash init.sh


# create frontend image
cd $BASE_DIR/frontend
source ./build.sh
cd $BASE_DIR


# start and initialize frontend
docker run -d --restart=always --name taiga-front-latest -p $FRONTEND_PORT:80 -e API_NAME=$API_NAME -e BACKEND_PORT=$BACKEND_PORT --link taiga-back-latest:taiga-back-latest --volumes-from taiga-back-latest taiga-front-latest
