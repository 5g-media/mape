# 5G-MEDIA MAPE service

## Introduction

The 5G-MEDIA MAPE service, as part of the 5G-MEDIA Service Virtualization Platform, is responsible to:
- collect the original monitoring data from NFVIs, VNFs/NSs (applications), QoEs etc
- correlate the original monitoring data with the running VNFs and NS and adapt them in a uniform structure
- store the adapted monitoring data after the adaptation process
- visualize the monitoring data in a dashboard
- analyze the performance of the running NSs/VNFs and suggest optimization actions that improve the QoΕ in the end-user
- apply the optimization actions interacting with th appropriate service in the 5G-MEDIA Service Virtualization Platform

The 5G-MEDIA MAPE service consists of a set of components:
- [Translator](https://github.com/5g-media/mape-translation)
- Cache ([Redis](https://hub.docker.com/_/redis) has been used)
- [Data-importer](https://github.com/5g-media/mape-data-importer)
- Database ([InfluxDB](https://hub.docker.com/_/influxdb) has been used)
- [Dashboard](https://github.com/5g-media/mape-dashboard) ([Grafana](https://hub.docker.com/r/grafana/grafana) has been used)
- [Data lifecycle manager](https://github.com/5g-media/mape-data-lcm)
- [Accounting agent](https://github.com/5g-media/accounting-agent)
- Optimization components
   * [O-CNO-predictive-optimizer](https://github.com/5g-media/CNO/tree/master/O-CNO-predictive-optimizer)
   * [O-CNO-arbitrator](https://github.com/5g-media/CNO/tree/master/O-CNO)
   * [SS-CNO](https://github.com/5g-media/ss-cno-teleimmersive-game) for Tele-Immesrive games based on reinforcement learning (UC1)
   * [SS-CNO](https://github.com/5g-media/CNO/tree/master/SS-CNO-UC2-MC) for Mobile Contribution (UC2)
   * [SS-CNO](https://github.com/5g-media/cno-rl) for Remote and Smart Production based on reinforcement learning (UC2)
   * [SS-CNO](https://github.com/5g-media/ss-cno-anomaly-detection-dl) for anomaly detection over vCDN services based on deeplearning (UC3)
   * [SS-CNO](https://github.com/5g-media/CNO/tree/master/SS-CNO-UC3) for anomaly detection over vCDN services based on supervised learning (UC3)
- [Executor](https://github.com/5g-media/mape-executor)
- [Recommender](https://github.com/5g-media/mape-recommender)
- Logging server ([Grayload](https://hub.docker.com/r/graylog/graylog/) has been used)
- Issue tracking server ([Redmine](https://hub.docker.com/_/redmine) has been used)

The communication and the messages exchange among the above components is achieved through the 5G-MEDIA publish/subscribe broker. The [Apache Kafka](https://kafka.apache.org/) has been selected as publish/subscribe broker. Follow the instructions of the [repository](https://github.com/wurstmeister/kafka-docker) to build the docker image including the kafka broker / zookeeper and deploy it through the docker-compose. Moreover, [Kafka manager](https://github.com/yahoo/CMAK) is used to visualize statistics for the kafka broker.

The NFVI monitoring data are sent in the publish/subscribe broker through the below three publishers and then are processed by the Translator:
- [OpenStack-kafka-publisher](https://github.com/5g-media/openstack-kafka-publisher)
- [Kubernetes-kafka-publisher](https://github.com/5g-media/kubernetes-prometheus-publisher)
- [OpenNebula-kafka-publisher](https://github.com/5g-media/opennebula-kafka-publisher)


The deployment of the MAPE is done as a project using the `docker-compose`. A docker image is built for every component (unless it is available in a docker registry).


## Usage

Deploy the services:
```bash
$ sudo docker-compose -f docker-compose-mape.yml up -d
```

Deploy the services with multiple translator instances. Indicative example:
```bash
$ sudo docker-compose -f docker-compose-mape-ncsrd.yml up -d --scale translator=3
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
- Singular Logic <pathanasoulis@ep.singularlogic.eu>
- UCL

## Contributors
 - Contact with Authors
 
## Acknowledgements
This project has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement *No 761699*. The dissemination of results herein reflects only the author’s view and the European Commission is not responsible for any use that may be made 
of the information it contains.

## License
[Apache 2.0](LICENSE.md)