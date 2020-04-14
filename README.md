# 5G-MEDIA MAPE service

## Introduction

The 5G-MEDIA MAPE service consists of a set of components:
- translator
- [redis](https://hub.docker.com/_/redis target="_blank") (cache)
- data-importer
- [influxdb](https://hub.docker.com/_/influxdb){:target="_blank"} (database)
- [grafana](https://hub.docker.com/r/grafana/grafana){:target="_blank"} (dashboard)
- LCM data manager
- optimization components
   * O-CNO
   * SS-CNO(s)
- [executor](https://github.com/5g-media/mape-executor){:target="_blank"}
- recommender
- [grayload](https://hub.docker.com/r/graylog/graylog/){:target="_blank"} (loggin server)
- [redmine](https://hub.docker.com/_/redmine){:target="_blank"} (issue tracking server)

The communication among various components is achieved through a publish/subscribe broker. The [Apache Kafka](https://kafka.apache.org/) has been selected. Use [this](https://github.com/wurstmeister/kafka-docker){:target="_blank"} repository to build the docker image including the kafka broker and zookeeper and deploy it as a container. Moreover, [Kafka manager](https://github.com/yahoo/CMAK){:target="_blank"} is used to visualize statistics for the kafka broker.

Th deployment of the MAPE is done as a project using the `docker-compose`. A docker image is built for every component (unless it is available in a docker registry).


## Usage

Deploy the services:
```bash
$ sudo docker-compose -f docker-compose-mape.yml up -d
```

Deploy the services with multiple translator instances. Indicative example:
```bash
sudo docker-compose -f docker-compose-mape-ncsrd.yml up -d --scale translator=3
```

List of the docker container including the healthcheck label:
```
$ sudo docker ps -a
```


Stop and remove the services:
```bash
$ sudo docker-compose -f docker-compose-mape.yml down
```

Stop and remove the services, remove the unused volumes:
```bash
$ sudo docker-compose -f docker-compose-mape.yml down --volumes
```

Check the volumes list:
```bash
$ sudo docker volume ls
```

Inspect a specific volume (e.g. the grafana volume):
```bash
$ sudo docker volume inspect <volume_name>
```


Check the existing networks:
```bash
$ sudo docker network ls
```

Check the dedicated network for the MAPE services:
```bash
$ sudo docker network inspect <network_name>
```

Get the logs of the involved services:
```bash
 $ sudo docker-compose -f docker-compose-mape.yml logs
 ```

 Get the logs of the involved services in real time:
```bash
 $ sudo docker-compose -f docker-compose-mape.yml logs -f
 ```

Get the logs of a specific container (e.g. grafana):
```bash
$ sudo docker logs -f mape-grafana
```

## Network settings

The traffic in a set of ports must be allowed from the firewalls:
- `80/tcp` (grafana)
- `8080/tcp` (kafka manager)
- range `8880-8888/tcp` (services under supervisor)
- `6379/tcp` (redis)
- `8086/tcp` (influxDB)

In case that you include the ceilometer-kafka-publisher, you must allow traffic in: `10000/udp`.


## Test

Ensure that docker engine has been installed and is running:
```
$ sudo service docker status
```

Check the docker engine version:
```bash
$ sudo docker --version

Docker version 18.03.0-ce, build 0520e24
```

## Authors
- Athanasoulis Takis <pathanasoulis@ep.singularlogic.eu>

## Contributors
 - Contact with Authors
 
## Acknowledgements
This project has received funding from the European Union’s Horizon 2020 research and innovation 
programme under grant agreement *No 761699*. The dissemination of results herein reflects only 
the author’s view and the European Commission is not responsible for any use that may be made 
of the information it contains.

## License
[Apache 2.0](LICENSE.md)