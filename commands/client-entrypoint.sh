#!/bin/bash

cp /configs/client-ssl.properties /configs/client-ssl-active.properties
sed -i "s/\${KAFKA_SSL_KEY_PASSWORD}/$KAFKA_SSL_KEY_PASSWORD/" /configs/client-ssl-active.properties
sed -i "s/\${KAFKA_SECURITY_PROTOCOL}/$KAFKA_SECURITY_PROTOCOL/" /configs/client-ssl-active.properties

bash
