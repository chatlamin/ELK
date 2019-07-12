# Logstash в Docker

Выносим на хост машину конфиг-файлы

    sudo mkdir -p /home/docker/containers/logstash/config
    sudo mkdir -p /home/docker/containers/logstash/pipeline
    sudo touch /home/docker/containers/logstash/config/logstash.yml
    sudo touch /home/docker/containers/logstash/pipeline/logstash.conf

Скачиваем образ logstash (в примере версия 7.2.0)

    docker pull docker.elastic.co/logstash/logstash-oss:7.2.0

Запускаем (перед запуском скопируй [конфиг1](https://github.com/chatlamin/ELK/blob/master/Docker-server/Logstash/config/logstash.yml), [конфиг2](https://github.com/chatlamin/ELK/blob/master/Docker-server/Logstash/pipeline/logstash.conf))

    docker run --name logstash \
        --detach \
        --restart=always \
        --link elasticsearch:elasticsearch \
        --volume /etc/localtime:/etc/localtime:ro \
        --volume /etc/timezone:/etc/timezone:ro \
        --volume /home/docker/containers/logstash/config/logstash.yml:/usr/share/logstash/config/logstash.yml \
        --volume /home/docker/containers/logstash/pipeline/logstash.conf:/usr/share/logstash/pipeline/logstash.conf \
        --publish 5044:5044 \
        --publish 5514:5514/udp \
        docker.elastic.co/logstash/logstash-oss:7.2.0

[Источник](https://github.com/deviantony/docker-elk/tree/master/logstash)

[Источник](https://github.com/elastic/stack-docker/blob/master/docker-compose.yml)

[Источник](https://github.com/elastic/logstash-docker/blob/master/build/logstash/config/logstash-oss.yml)

[Источник](https://github.com/elastic/logstash-docker/blob/master/build/logstash/config/pipelines.yml)
