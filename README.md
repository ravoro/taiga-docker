# taiga-docker

Docker scripts to run your own  [Taiga](https://Taiga.io/). Based on [ipedrazas/taiga-docker](https://github.com/ipedrazas/taiga-docker).


### Run
    git clone https://github.com/ravoro/taiga-docker.git
    cd taiga-docker
    ./setup.sh


### Details
`setup.sh` is dependant on the following variables:

* API_NAME -- backend api hostname -- *(default: localhost)*
* BASE_DIR -- the base directory for the `taiga-docker` -- *(default: the output of `pwd` command)*
* POSTGRES_DIR -- directory for postgres volume -- *(default: $BASE_DIR/data/postgres)*
* BACKEND_PORT -- port for exposing taiga backend -- *(default: 8000)*
* FRONTEND_PORT -- port for exposing taiga frontend -- *(default: 80)*

`setup.sh` executes the following:

1. starts the `postgres` docker images and uses `$POSTGRES_DIR` as the volume
2. creates the default `taiga` database and `taiga` user
3. builds the `taiga-backend-latest` by running `backend/build.sh`
4. runs the built `taiga-backend-latest` image
5. initializes the `taiga-backend-latest` container by running `backend/init.sh`
6. builds the latest taiga frontend by running `frontend/build.sh`
7. runs the built `taiga-frontend-latest` image
