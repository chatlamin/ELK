### Очистка elasticsearch с помощью curator

#### Подключаем репозиторий в Debian 8/Ubuntu

    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    mcedit /etc/apt/sources.list.d/curator.list
    
    deb [arch=amd64] https://packages.elastic.co/curator/5/debian stable main

#### Устанавливаем curtator:

    apt update && apt install elasticsearch-curator

#### Настройка curator для очистки elasticsearch

Сделаем для примера простое задание на закрытие и удаление индексов с шаблоном winsrv-* старше 30-ти дней. Для этого создадим директорию для конфигов curator и сами конфиги.

    mkdir /etc/curator
    touch /etc/curator/action.yml
    touch /etc/curator/config.yml
[action.yml](https://github.com/chatlamin/ELK/blob/master/Server/Curator/action.yml)

[config.yml](https://github.com/chatlamin/ELK/blob/master/Server/Curator/config.yml)


Обращаю внимание на форматирование файла. Отступы в начале строки важны. Они должны быть именно такие, как у меня в примере.

Конфиг сделан на основе примеров из официальной документации. Рекомендую все подробности искать там. Запускаем очистку:

    /usr/bin/curator --config /etc/curator/config.yml /etc/curator/action.yml
В консоли увидите информативный вывод выполняемых команд по очистке индексов. После завершения очистки, не забудьте добавить задание в cron.

    crontab -e
    4 4 * * * /usr/bin/curator --config /etc/curator/config.yml /etc/curator/action.yml
Очистка индексов будет выполняться каждый день в 4 утра.
