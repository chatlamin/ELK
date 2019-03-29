# Filebeat это служба, которая отправляет журналы сервера ubuntu на сервер ELK

## Установка

Для настройки централизованного сервера сбора логов с Ubuntu серверов, установим сборщика системных логов filebeat.
Для этого [скачаем его](https://www.elastic.co/downloads/beats/filebeat) и установим в качестве службы.

CLI:

    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.7.0-amd64.deb
    apt install filebeat
После установки добавляем в автозагрузку

    systemctl daemon-reload
    systemctl enable filebeat

## Настройка

Конфиг для отправки логов в logstash находится по этому пути /etc/filebeat/filebeat.yml

[Пример конфигурации](https://github.com/chatlamin/ELK/blob/master/Agents/Ubuntu/filebeat-ubuntu.yml)

[Источник](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-log.html)

## Запуск

    systemctl start filebeat

## Docker

Для чтения журналов из контейнеров Docker, ищем журналы контейнеров /var/lib/docker/containers

[Пример конфигурации](https://github.com/chatlamin/ELK/blob/master/Agents/Ubuntu/filebeat-docker.yml)

[Источник](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-docker.html)

[Про metadata](https://www.elastic.co/guide/en/beats/filebeat/current/add-docker-metadata.html)