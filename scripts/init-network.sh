#!/bin/bash
# Initiliase the network for Big Data Cluster as a bridge network
# Author: Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>

set -e

NETWORK_NAME='big-data-network'
NETWORK_TYPE='bridge'
SUBNET=172.23.0.0/16
IP_RANGE=172.23.5.0/24
GATEWAY=172.23.5.1

docker network create --driver=$NETWORK_TYPE \
 --subnet=$SUBNET \
 --ip-range=$IP_RANGE \
 --gateway=$GATEWAY \
  $NETWORK_NAME