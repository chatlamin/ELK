Для настройки централизованного сервера сбора логов с Windows серверов, установим сборщика системных логов winlogbeat.
Для этого скачаем https://www.elastic.co/downloads/beats/winlogbeat его и установим в качестве службы. Идем на страницу загрузок и скачиваем версию под вашу архитектуру — 32 или 64 бита.

> Протестировано на Version: 6.6.1 Release date:February 19, 2019

Распаковываем скачанный архив и копируем его содержимое в директорию C:\Program Files\winlogbeat. Сразу же создаем там папку logs для хранения логов самого winlogbeat.

Запускаем консоль Powershell от администратора и выполняем команды:

    PS C:\Users\Administrator> cd ‘C:/Program Files/winlogbeat’
    PS C:/Program Files/winlogbeat> PowerShell.exe -ExecutionPolicy UnRestricted -File .\install-service-winlogbeat.ps1
Такая команда позволит запустить неподписанный скрипт

У меня был такой вывод:

> Stopped  winlogbeat         winlogbeat

Служба установилась и в данный момент она остановлена. Правим конфигурационный файл winlogbeat.yml. Я его привел к такому [виду](https://github.com/chatlamin/ELK/blob/master/Agents/Windows/winlogbeat.yml)

После настройки можно запустить службу winlogbeat, которая появится в списке служб windows.

Откройте Kibana (http://192.168.0.16:5601)

Вы должны увидеть новые индексы с именем winsrv-(Текущая Дата). В поле Index pattern введите winsrv-* и нажмите Next Step. На следующем этапе выберите имя поля для временного фильтра.
У вас будет только один вариант — @timestamp, выбирайте его и жмите Create Index Pattern.
