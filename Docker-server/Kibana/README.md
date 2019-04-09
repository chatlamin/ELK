# Kibana в Docker

Выносим на хост машину конфиг-файл

    sudo mkdir -p /home/docker/containers/kibana/config
    sudo touch /home/docker/containers/kibana/config/kibana.yml

Скачиваем образ kibana (в примере версия 6.7.0)

    docker pull docker.elastic.co/kibana/kibana-oss:6.7.0

Запускаем (перед запуском скопируй [конфиг](https://github.com/chatlamin/ELK/blob/master/Docker-server/Kibana/kibana.yml))

    docker run --name kibana \
        --detach \
        --restart=always \
        --link elasticsearch:elasticsearch \
        --volume /etc/localtime:/etc/localtime:ro \
        --volume /etc/timezone:/etc/timezone:ro \
        --volume /home/docker/containers/kibana/config/kibana.yml:/usr/share/kibana/config/kibana.yml \
        --publish 5601:5601 \
        docker.elastic.co/kibana/kibana-oss:6.7.0

[Источник](https://www.elastic.co/guide/en/kibana/current/docker.html)

[Источник](https://github.com/elastic/stack-docker/blob/master/config/kibana/kibana.yml)
