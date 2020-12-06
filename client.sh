#!/bin/bash

WORKDIR=$(pwd)

docker run -it --rm \
    -v $WORKDIR/certificates/:/certificates \
    -v $WORKDIR/configs/client-ssl.properties:/configs/client-ssl.properties \
    -v $WORKDIR/commands/consumer.sh:/usr/bin/consumer.sh \
    -v $WORKDIR/commands/producer.sh:/usr/bin/producer.sh \
    -v $WORKDIR/commands/client-entrypoint.sh:/usr/bin/client-entrypoint.sh \
    --env-file .env \
    --entrypoint client-entrypoint.sh \
    wurstmeister/kafka