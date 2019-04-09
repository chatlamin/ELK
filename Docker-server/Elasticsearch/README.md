# Elasticsearch в Docker

Выносим на хост машину конфиг-файл

    sudo mkdir -p /home/docker/containers/elasticsearch/config
    sudo touch /home/docker/containers/elasticsearch/config/elasticsearch.yml

Скачиваем образ elasticsearch (в примере версия 6.7.0)

    docker pull docker.elastic.co/elasticsearch/elasticsearch-oss:6.7.0

Запускаем (перед запуском скопируй [конфиг](https://github.com/chatlamin/ELK/blob/master/Docker-server/Elasticsearch/elasticsearch.yml))

    docker run --name elasticsearch \
        --detach \
        --restart=always \
        --env "discovery.type=single-node" \
        --publish 9200:9200 \
        --publish 9300:9300 \
        --volume /etc/localtime:/etc/localtime:ro \
        --volume /etc/timezone:/etc/timezone:ro \
        --volume /home/docker/containers/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
        --volume elasticsearch1-data:/usr/share/elasticsearch/data/ \
        docker.elastic.co/elasticsearch/elasticsearch-oss:6.7.0

[Источник](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)

[Источник](https://discuss.elastic.co/t/elastic-elasticsearch-docker-not-assigning-permissions-to-data-directory-on-run/65812)