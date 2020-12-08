#!/bin/bash

/opt/kafka/bin/kafka-console-consumer.sh \
--bootstrap-server $KAFKA_INTERNET_HOST:$KAFKA_INTERNET_PORT \
--consumer.config /configs/client-ssl-active.properties \
--property print.key=true --property print.timestamp=true \
--topic $@