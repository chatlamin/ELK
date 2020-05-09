#!/bin/bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

NAME=elasticsearch
PATH_CONF='/home/docker/containers/elasticsearch/conf'

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

mkdir -p $PATH_CONF
cp -r ./container $PATH_CONF

docker run \
    --name elasticsearch \
    --detach \
    --restart always \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $PATH_CONF/container/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
    --volume $NAME-data:/usr/share/elasticsearch/data \
    --env "discovery.type=single-node" \
    --publish 9200:9200 \
    --publish 9300:9300 \
    chatlamin/elasticsearch:latest

docker logs --follow elasticsearch