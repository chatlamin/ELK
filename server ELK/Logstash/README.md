Основной конфиг logstash лежит по адресу /etc/logstash/logstash.yml.
Я его трогать не буду, а все настройки буду по смыслу разделять по разным конфигурационным файлам в директории /etc/logstash/conf.d.
Подготавливаем конфиг-файлы

    touch /etc/logstash/conf.d/input.conf
    touch /etc/logstash/conf.d/output.conf
    touch /etc/logstash/conf.d/filter.conf
В файле input.conf, который будет описывать прием информации с beats агентов и syslog, вписываем

input {
    beats {
        port => 5044
    }
    syslog {
        port => 5514
        type => syslog
    }
}


Теперь укажем, куда будем передавать данные. Конфиг output.conf описывает передачу данных в Elasticsearch.

output {
    if [type] == "syslog" {
        elasticsearch {
            hosts     => "localhost:9200"
            sniffing => true
            manage_template => false
            index    => "syslog-%{+YYYY.MM.dd}"
            document_type => "%{type}"
        }
    }
    else if [type] == "nginx_error" {
        elasticsearch {
            hosts     => "localhost:9200"
            index    => "nginx-%{+YYYY.MM.dd}"
        }
    }
    else if "winsrv" in [tags] {
        elasticsearch {
            hosts     => "localhost:9200"
            index    => "winsrv-%{+YYYY.MM.dd}"
        }
    }
    else {
        elasticsearch {
            hosts     => "localhost:9200"
            index    => "unknown_messages"
        }
    }
    #stdout { codec => rubydebug }
}

В файл filter.conf ничего не пишем. В нашем случае, это пока не нужно.
