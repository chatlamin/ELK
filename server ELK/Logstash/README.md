Основной конфиг logstash лежит по адресу /etc/logstash/logstash.yml.
Я его трогать не буду, а все настройки буду по смыслу разделять по разным конфигурационным файлам в директории /etc/logstash/conf.d.
Подготавливаем конфиг-файлы

    touch /etc/logstash/conf.d/input.conf
    touch /etc/logstash/conf.d/output.conf
    touch /etc/logstash/conf.d/filter.conf
Файл input.conf будет описывать прием информации с beats агентов и syslog

Файл output.conf описывает передачу данных в Elasticsearch.

В файл filter.conf ничего не пишем. В нашем случае, это пока не нужно.
