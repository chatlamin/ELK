Настройки Elasticsearch находятся в файле /etc/elasticsearch/elasticsearch.yml. На начальном этапе нас будут интересовать следующие параметры:

    path.data: /var/lib/elasticsearch # директория для хранения данных
    network.host: 0.0.0.0 # слушаем все интерфейсы

Слушаем все интерфейсы, для будующего подключения к Grafana.
Обращаю отдельное внимание на параметр для директории с данными.
Чаще всего они будут занимать значительное место, иначе зачем нам Elasticsearch. Подумайте заранее, где вы будете хранить логи.
Все остальные настройки я оставляю дефолтными.
