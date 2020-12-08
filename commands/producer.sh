#!/bin/bash

/opt/kafka/bin/kafka-console-producer.sh \
--bootstrap-server $KAFKA_INTERNET_HOST:$KAFKA_INTERNET_PORT \
--producer.config /configs/client-ssl-active.properties \
--topic $@