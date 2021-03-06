# Filebeat это служба, которая отправляет журналы сервера ubuntu на сервер ELK

## Установка

Для настройки централизованного сервера сбора логов с Ubuntu серверов, установим сборщика системных логов filebeat.
Для этого [скачаем его](https://www.elastic.co/downloads/beats/filebeat) и установим в качестве службы.

CLI:

    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    apt-get install apt-transport-https
    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
    apt-get update && sudo apt-get install filebeat

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