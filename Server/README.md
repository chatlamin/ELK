# ELK Stack

Сервер:

+ OS: Ubuntu-16.04.6-server-amd64
+ Java: 1.8.0_201
+ Kibana: 6.6.1
+ Elasticsearch: 6.6.1
+ Logstash: 6.6.1

Агенты:

+ Windows: Windows server 2012 R2 (RU) + Winlogbeat: 6.6.1
+ D-Link: 7.02.B051
+ Mikrotik: 6.43.11
+ Ubuntu server 18.04 + Filebeat: 6.7.0 + Docker: 18.09

## [Устанавливаем Ubuntu](https://tutorials.ubuntu.com/tutorial/tutorial-install-ubuntu-server#0)

## Устанавливаем дополнительные программы

    apt install mc
    apt install nmon
    apt update
    apt upgrade
    reboot

## Установка Java 8

Подключаем репозиторий с Java 8.

    add-apt-repository -y ppa:webupd8team/java
Обновляем список пакетов и устанавливаем Oracle Java 8.

    apt update
    apt install oracle-java8-installer
Проверяем версию явы в консоли.

    java -version
Мой вывод:
> java version "1.8.0_201"

> Java(TM) SE Runtime Environment (build 1.8.0_201-b09)

> Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode)

## Установка Elasticsearch

Копируем себе публичный ключ репозитория

    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -

Добавляем репозиторий Elasticsearch в систему:

    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list

Устанавливаем Elasticsearch на Debian или Ubuntu:

    apt update && apt-get install elasticsearch
После установки добавляем elasticsearch в автозагрузку.

    systemctl daemon-reload 
    systemctl enable elasticsearch.service 

## Установка Kibana

Установка Kibana на Debian или Ubuntu. Добавляем публичный ключ:

    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -

Добавляем репозиторий Kibana:

    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list

Запускаем установку Kibana:

    apt update && apt install kibana
Добавляем Кибана в автозагрузку.

    systemctl daemon-reload
    systemctl enable kibana.service

## Установка Logstash

Logstash устанавливается из того же репозитория, как Elasticsearch и Kibana.

    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list
Запускаем установку Logstash:

    apt update && apt install logstash
Добавляем Logstash в автозагрузку.

    systemctl daemon-reload
    systemctl enable logstash.service

### Настройка Elasticsearch

Настройки Elasticsearch описаны [тут](https://github.com/chatlamin/ELK/tree/master/server%20ELK/elasticsearch)

### Настройка Kibana

Настройки Kibana описаны [тут](https://github.com/chatlamin/ELK/tree/master/server%20ELK/Kibana)

### Настройка Logstash

Настройки Logstash описаны [тут](https://github.com/chatlamin/ELK/tree/master/server%20ELK/Logstash)

#### Запуск

Запускаем по очереди все службы:

##### Elasticsearch

    systemctl start elasticsearch.service
Проверяем, запустился ли он:

    systemctl status elasticsearch.service
    netstat -tulnp | grep 9200
Стартует не сразу. Ждем, пока не появится запись:
> tcp6       0      0 :::9200                 :::*                    LISTEN      7494/java

##### Kibana

    systemctl start kibana.service
Проверяем состояние запущенного сервиса:

    systemctl status kibana.service
Кибана стартует долго. Подождите примерно минуту и проверяйте.

    netstat -tulnp | grep 5601
> tcp        0      0 127.0.0.1:5601          0.0.0.0:*               LISTEN      27401/node

##### Logstash

    systemctl start logstash.service
___
Откройте Kibana (http://192.168.0.16:5601) Management -> Index Patterns

Вы должны увидеть новые индексы с именем ubuntu-(Текущая Дата). В поле Index pattern введите ubuntu-* и нажмите Next Step. На следующем этапе выберите имя поля для временного фильтра. У вас будет только один вариант — @timestamp, выбирайте его и жмите Create Index Pattern.
Выбираем в левом меню пункт Discover, где вы должны увидеть логи, которые пришли с ubuntu агента.

Для удобного просмотра рекомендую сделать настройку столбцов:

Management -> Advanced Settings -> Default columns вписать

    host.name, message

[Источник](https://serveradmin.ru/category/elk-stack/)