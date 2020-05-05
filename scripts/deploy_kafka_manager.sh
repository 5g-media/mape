#!/bin/bash

sudo docker run -d -p 8080:9000 --name kafka_manager --restart always -e ZK_HOSTS="192.168.1.175:2181" sheepkiller/kafka-manager