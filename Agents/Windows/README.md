АГЕНТ WINDOWS
Для настройки централизованного сервера сбора логов с Windows серверов, установим сборщика системных логов winlogbeat.
Для этого скачаем https://www.elastic.co/downloads/beats/winlogbeat его и установим в качестве службы. Идем на страницу загрузок и скачиваем версию под вашу архитектуру — 32 или 64 бита.

Распаковываем скачанный архив и копируем его содержимое в директорию C:\Program Files\Winlogbeat. Сразу же создаем там папку logs для хранения логов самого winlogbeat.
Запускаем консоль Powershell от администратора и выполняем команды:


PS C:\Users\Administrator> cd ‘C:/Program Files/winlogbeat’
PS C:/Program Files/winlogbeat> PowerShell.exe -ExecutionPolicy UnRestricted -File .\install-service-winlogbeat.ps1  ## такая команда запустит неподписанный скрипт

У меня был такой вывод:

Status   Name               DisplayName
------   ----               -----------
Stopped  winlogbeat         winlogbeat
Служба установилась и в данный момент она остановлена. Правим конфигурационный файл winlogbeat.yml. Я его привел к такому виду:

winlogbeat:
  registry_file: C:/ProgramData/winlogbeat/.winlogbeat.yml
  event_logs:
    - name: Application
      ignore_older: 168h
    - name: Security
      ignore_older: 168h
    - name: System
      ignore_older: 168h
output:
   #elasticsearch:
   #    hosts: localhost:9200
    logstash:
        hosts: ["192.168.0.16:5044"]

В принципе, по тексту все понятно. Я беру 3 системных лога Application, Security, System (для русской версии используются такие же названия) и отправляю их на сервер с logstash. 
Настраиваю хранение логов и включаю мониторинг по аналогии с filebeat. Отдельно обращаю внимание на tags: [«winsrv»]. Этим тэгом я помечаю все отправляемые сообщения, чтобы потом их обработать в logstash и отправить в elasticsearch с отдельным индексом. 
Я не смог использовать поле type, по аналогии с filebeat, потому что в winlogbeat в поле type жестко прописано wineventlog и изменить его нельзя. 
Если у вас данные со всех серверов будут идти в один индекс, то можно tag не добавлять, а использовать указанное поле type для сортировки. 
Если же вы данные с разных среверов хотите помещать в разные индексы, то разделяйте их тэгами.  ## но можно и не разделять)

После настройки можно запустить службу winlogbeat, которая появится в списке служб windows.

### Теперь ждем, пока индексы сформируются. После добавления s1c сервера (лабораторный сервер) ожидание составило 10 минут на виртуальной машине 6 ядер 12gb ram

Откройте Kibana (http://192.168.0.16:5601)
Вы должны увидеть индекс, который начал заливать logstash в elasticsearch. В поле Index pattern введите windows-* и нажмите Next Step. На следующем этапе выберите имя поля для временного фильтра. 
У вас будет только один вариант — @timestamp, выбирайте его и жмите Create Index Pattern.
