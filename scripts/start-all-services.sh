#!/bin/bash

set -e

# Start all the containers
docker-compose -f docker-compose.spark.yml up -d