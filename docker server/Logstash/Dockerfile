#Последняя версия
ARG VERSION=7.6.2

FROM docker.elastic.co/logstash/logstash-oss:${VERSION}

ADD container/config/ /usr/share/logstash/config/

ADD container/pipeline/ /usr/share/logstash/pipeline/