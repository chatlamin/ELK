#!/bin/bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

NAME=logstash
PATH_CONF='/home/docker/containers/logstash/conf'

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

mkdir -p $PATH_CONF
cp -r ./container $PATH_CONF

docker run \
    --name $NAME \
    --detach \
    --restart unless-stopped \
    --link elasticsearch:elasticsearch \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $PATH_CONF/container/config/logstash.yml:/usr/share/logstash/config/logstash.yml \
    --volume $PATH_CONF/container/pipeline/logstash.conf:/usr/share/logstash/pipeline/logstash.conf \
    --publish 5044:5044 \
    --publish 5514:5514/udp \
    chatlamin/logstash:latest

docker logs --follow $NAME