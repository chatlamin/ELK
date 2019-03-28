# Filebeat это служба, которая отправляет журналы сервера ubuntu на сервер ELK

## Установка

Для настройки централизованного сервера сбора логов с Ubuntu серверов, установим сборщика системных логов filebeat.
Для этого [скачаем его](https://www.elastic.co/downloads/beats/filebeat) и установим в качестве службы.

    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.7.0-amd64.deb
    apt install filebeat
После установки добавляем в автозагрузку

    systemctl daemon-reload
    systemctl enable filebeat

## Настройка

После установки рисуем примерно такой конфиг /etc/filebeat/filebeat.yml для отправки логов в logstash.

## Запуск

    systemctl start filebeat
Откройте Kibana (http://192.168.0.16:5601) Management -> Index Patterns

Вы должны увидеть новые индексы с именем ubuntu-(Текущая Дата). В поле Index pattern введите ubuntu-* и нажмите Next Step. На следующем этапе выберите имя поля для временного фильтра. У вас будет только один вариант — @timestamp, выбирайте его и жмите Create Index Pattern.
Выбираем в левом меню пункт Discover, где вы должны увидеть логи, которые пришли с ubuntu агента.

Для удобного просмотра рекомендую сделать настройку столбцов:

Management -> Advanced Settings -> Default columns вписать

    host.name, message  