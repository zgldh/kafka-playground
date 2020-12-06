#!/bin/bash

/opt/kafka/bin/kafka-console-consumer.sh \
--bootstrap-server $KAFKA_INTERNET_HOST:$KAFKA_INTERNET_PORT --topic $KAFKA_DEFAULT_TOPIC \
--consumer.config /configs/client-ssl-active.properties