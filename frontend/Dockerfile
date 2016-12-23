##############################################################
##
##
##  Taiga-front
##
##
###############################################################

FROM nginx

COPY taiga-front-dist/dist /taiga
COPY run.sh /taiga/run.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY taiga.conf /etc/nginx/conf.d/default.conf
RUN cp /taiga/conf.example.json /taiga/conf.json

RUN chmod -R 755 /taiga && chmod +x /taiga/run.sh

CMD ["/taiga/run.sh"]
