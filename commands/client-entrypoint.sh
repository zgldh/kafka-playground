#!/bin/bash

sed "s/\${KAFKA_SSL_KEY_PASSWORD}/$KAFKA_SSL_KEY_PASSWORD/" /configs/client-ssl.properties > /configs/client-ssl-active.properties
bash