# kafka-playground  
A single broker Kafka SSL setup for learning or testing.

## Usage

1. Prepare environment values  
   `cp .env.example .env`  

    | Name                   | Note                                               | Sample          |
    | ---------------------- | -------------------------------------------------- | --------------- |
    | KAFKA_INTERNET_HOST    | The host which clients connect to.                 | 123.123.123.123 |
    | KAFKA_INTERNET_PORT    | Same above. Kafka will run SSL on it.              | 9093            |
    | KAFKA_SSL_KEY_PASSWORD | Your brokers and clients share the same password.  | YourPassword    |
    | KAFKA_MANAGER_PORT     | The Kafka manager port.                            | 9000            |
    | KAFKA_DEFAULT_TOPIC    | The Kafka broker will initialized with this topic. | default         |

2. Genreate CA and Key pairs into Keystores.  
   Need `openssl` and `keytool`  
    ```bash
    ./setup_ssl_for_servers.sh
    ```

3. Kafka Server  
    `docker-compose up -d`
4. Consumer  
    Start a console.
    `client.sh`
    `consumer.sh`
5. Producer  
    Start another console.
    `client.sh`
    `producer.sh`
    Type anything and press enter. Then check your Consumer console.


## References
1. http://kafka.apache.org/documentation/#security_ssl
2. https://github.com/wurstmeister/kafka-docker
3. https://www.cnblogs.com/huxi2b/p/7427815.html
4. https://www.cnblogs.com/smartloli/p/12950761.html