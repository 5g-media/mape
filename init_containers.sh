#!/bin/bash
sudo docker run -d --name redis-cache -p 6379:6379 redis
sudo docker run -d -p 8086:8086 --name=influxdb -e INFLUXDB_DB=monitoring -v influxdb:/var/lib/influxdb influxdb
sudo docker run -d --name=grafana -p 3000:3000 -v grafana-storage:/var/lib/grafana grafana/grafana
sudo docker run -d -p 9000:9000 --name kafka_manager --restart always -e ZK_HOSTS="192.168.1.107:2181" sheepkiller/kafka-manager
sudo docker run -d --name ceilometer_kafka_publisher -p 10000:10000/udp --restart always ceilometer_kafka_publisher
sudo docker run --name monitoring_data_translator --restart always -dit monitoring-data-translator
sudo docker run -p --name kafka_influx --restart always -dit kafka-influx
sudo docker run -d --name ns_manager --restart always -it ns_manager
sudo docker run -d --name mape_execution --restart always -it actions-execution-engine