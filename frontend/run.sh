#! /usr/bin/env bash

sed -i 's/"gravatar": true/"gravatar": false/' /taiga/conf.json
sed -i "s/localhost:8000/$API_NAME:$BACKEND_PORT/g" /taiga/conf.json
sed -i "s/:8000/:$BACKEND_PORT/g" /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
