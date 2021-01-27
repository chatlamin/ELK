#!/bin/bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

NAME=kibana
PATH_CONF='/home/docker/containers/kibana/conf'

#--------------------------------------------------------------------
#End settings
#--------------------------------------------------------------------

mkdir -p $PATH_CONF
cp -r ./container $PATH_CONF

docker run \
    --name $NAME \
    --label test=123456 \
    --detach \
    --restart unless-stopped \
    --link elasticsearch:elasticsearch \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /etc/timezone:/etc/timezone:ro \
    --volume $PATH_CONF/container/kibana.yml:/usr/share/kibana/config/kibana.yml \
    --publish 5601:5601 \
    chatlamin/kibana:latest

docker logs --follow $NAME