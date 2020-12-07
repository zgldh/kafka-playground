# kafka-playground  
A single broker Kafka SSL setup for learning or testing.

## Usage

1. Prepare environment values  
   `cp .env.example .env`  

    | Name                   | Note                                                                                  | Sample         |
    | ---------------------- | ------------------------------------------------------------------------------------- | -------------- |
    | KAFKA_INTERNET_HOST    | The host which clients connect to.                                                    | 192.168.0.123  |
    | KAFKA_INTERNET_PORT    | Same above. Kafka will run SSL on it.                                                 | 9093           |
    | KAFKA_SSL_KEY_PASSWORD | Your brokers and clients share the same password.                                     | YourPassword   |
    | KAFKA_MANAGER_PORT     | The Kafka manager port.                                                               | 9000           |
    | KAFKA_CREATE_TOPICS    | Please check https://github.com/wurstmeister/kafka-docker#automatically-create-topics | default:1:1    |
    | KAFKA_CLUSTER_NAME     | Just a name.                                                                          | test-cluster   |
    | CA_COMMON_NAME         | Who are you?                                                                          | your@email.com |
    | CA_ORGANIZATION_UNIT   | Maybe your development team name?                                                     | Osvlabs        |
    | CA_ORGANIZATION        | Your company or organization.                                                         | ShinetechZZ    |
    | CA_LOCALITY            | Your city.                                                                            | Zhengzhou      |
    | CA_STATE               | Your province.                                                                        | Henan          |
    | CA_COUNTRY             | Your country code.                                                                    | CN             |

2. Genreate CA and Key pairs into Keystores.  
   Need `openssl` and `keytool`    
    `./setup_ssl_for_servers.sh`

3. Kafka Server  
    `docker-compose up -d`   
    Use `openssl s_client -debug -connect $KAFKA_INTERNET_HOST:$KAFKA_INTERNET_PORT -tls1|less` to check if SSL is working.
4. Consumer  
    Start a console. Or run it on another computer.  
    `client.sh`
    `consumer.sh default`
5. Producer  
    Start another console. Or run it on another computer.  
    `client.sh`
    `producer.sh default`
    Type anything and press enter. Then check your Consumer console.


## References
1. http://kafka.apache.org/documentation/#security_ssl
2. https://github.com/wurstmeister/kafka-docker
3. https://www.cnblogs.com/huxi2b/p/7427815.html
4. https://www.cnblogs.com/smartloli/p/12950761.html