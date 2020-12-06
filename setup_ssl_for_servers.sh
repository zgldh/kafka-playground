#!/bin/bash

################################## 设置环境变量 ##############################
BASE_DIR=$(pwd)                                         # SSL各种生成文件的基础路径
source $BASE_DIR/.env
CERT_OUTPUT_PATH="$BASE_DIR/certificates"               # 证书文件生成路径
PASSWORD=$KAFKA_SSL_KEY_PASSWORD                        # 密码
KEY_STORE="$CERT_OUTPUT_PATH/kafka.keystore"            # Kafka keystore文件路径
TRUST_STORE="$CERT_OUTPUT_PATH/kafka.truststore"        # Kafka truststore文件路径
KEY_PASSWORD=$PASSWORD                                  # keystore的key密码
STORE_PASSWORD=$PASSWORD                                # keystore的store密码
TRUST_KEY_PASSWORD=$PASSWORD                            # truststore的key密码
TRUST_STORE_PASSWORD=$PASSWORD                          # truststore的store密码
CLUSTER_NAME=$KAFKA_CLUSTER_NAME                        # 指定别名
CERT_AUTH_FILE="$CERT_OUTPUT_PATH/ca-cert"              # CA证书文件路径
CLUSTER_CERT_FILE="$CERT_OUTPUT_PATH/${CLUSTER_NAME}-cert" # 集群证书文件路径
DAYS_VALID=365                                          # key有效期
D_NAME="CN=$CA_COMMON_NAME, OU=$CA_ORGANIZATION_UNIT, O=$CA_ORGANIZATION, L=$CA_LOCALITY, ST=$CA_STATE, C=$CA_COUNTRY" # distinguished name
##############################################################################

mkdir -p $CERT_OUTPUT_PATH

echo "1. 创建集群证书到keystore......"
keytool -keystore $KEY_STORE -alias $CLUSTER_NAME -validity $DAYS_VALID -genkey -keyalg RSA \
-storepass $STORE_PASSWORD -keypass $KEY_PASSWORD -dname "$D_NAME" -storetype pkcs12

echo "2. 创建CA......"
openssl req -new -x509 -keyout $CERT_OUTPUT_PATH/ca-key -out "$CERT_AUTH_FILE" -days "$DAYS_VALID" \
-passin pass:"$PASSWORD" -passout pass:"$PASSWORD" \
-subj "/C=$CA_COUNTRY/ST=$CA_STATE/L=$CA_LOCALITY/O=$CA_ORGANIZATION/OU=$CA_ORGANIZATION_UNIT/CN=$CA_COMMON_NAME"

echo "3. 导入CA文件到truststore......"
keytool -keystore "$TRUST_STORE" -alias CARoot -import -file "$CERT_AUTH_FILE" \
-storepass "$TRUST_STORE_PASSWORD" -noprompt -storetype pkcs12

echo "4. 从key store中导出集群证书......"
keytool -keystore "$KEY_STORE" -alias "$CLUSTER_NAME" -certreq -file "$CLUSTER_CERT_FILE" \
-storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt -storetype pkcs12

echo "5. 签发证书......"
openssl x509 -req -CA "$CERT_AUTH_FILE" -CAkey $CERT_OUTPUT_PATH/ca-key -in "$CLUSTER_CERT_FILE" \
-out "${CLUSTER_CERT_FILE}-signed" -days "$DAYS_VALID" -CAcreateserial -passin pass:"$PASSWORD"

echo "6. 导入CA文件到keystore......"
keytool -keystore "$KEY_STORE" -alias CARoot -import -file "$CERT_AUTH_FILE" \
-storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt -storetype pkcs12

echo "7. 导入已签发证书到keystore......"
keytool -keystore "$KEY_STORE" -alias "${CLUSTER_NAME}" -import -file "${CLUSTER_CERT_FILE}-signed" \
-storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt -storetype pkcs12
