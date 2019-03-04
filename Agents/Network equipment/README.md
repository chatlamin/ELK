#### D-Link
Настройка коммутатора для отправки логов на удаленный сервер на примере DGS-1210-28/ME/B1

    enable syslog
    create syslog host 1 ipaddress 192.168.0.16 severity all facility local0 udp_port 5514 state enable

#### Mikrotik
Настройка маршрутизатора для отправки логов на удаленный сервер на примере Mikrotik RouterOS

    /system logging action
    set remote remote=192.168.0.16
    set remote remote-port=5514
    /system logging
    add action=remote topics=info
    add action=remote topics=error
    add action=remote topics=warning
    add action=remote topics=critical
