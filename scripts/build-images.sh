#!/bin/bash
# Script to build and start the docker containers as a cluster from the base images.
# Author: Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>
# Example usage for build specific base image: ./start.sh --spark-base
# Example usage for build all base images: ./start.sh

set -e

# Predictable behavior for unset variables
build_all=true
build_hadoop=false
build_spark=false
build_airflow=false
build_hive=false

# Set the environment variables for the Big Data, Hadoop, Hive and Spark Base images
export BIG_DATA_DOCKER_FILE_DIR=docker/big-data
export BIG_DATA_IMAGE_NAME=big-data-base

export HADOOP_DOCKER_FILE_DIR=docker/hadoop/hadoop-base
export HADOOP_IMAGE_NAME=hadoop-base

export SPARK_DOCKER_FILE_DIR=docker/spark/spark-base
export SPARK_IMAGE_NAME=spark-base

export HIVE_DOCKER_FILE_DIR=docker/hive/hive-base
export HIVE_IMAGE_NAME=hive-base

export AIRFLOW_DOCKER_FILE_DIR=docker/airflow
export AIRFLOW_IMAGE_NAME=airflow-base

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --hadoop-base|-hab) build_all=false; build_hadoop=true ;;
    --spark-base|-sb) build_all=false; build_spark=true ;;
    --airflow-base|-ab) build_all=false; build_airflow=true ;;
    --hive-base|-hb) build_all=false; build_hive=true ;;
    --help|-h) echo "Usage: ./start.sh [options]"
            echo "Options:"
            echo "  -h,   --help          Show this help message and exit"
            echo "  -hab, --hadoop-base   Build the Hadoop base image"
            echo "  -sb,  --spark-base    Build the Spark base image"
            echo "  -ab,  --airflow-base  Build the Airflow base image"
            echo "  -hb,  --hive-base     Build the Hive base image"
            exit 0 ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# Build the Big Data base image
docker build -t $BIG_DATA_IMAGE_NAME $BIG_DATA_DOCKER_FILE_DIR

# Build the specified images or build all if no specific images are specified
if [[ $build_all == true || $build_hadoop == true ]]; then
  docker build -t $HADOOP_IMAGE_NAME $HADOOP_DOCKER_FILE_DIR
fi

if [[ $build_all == true || $build_spark == true ]]; then
  docker build -t $SPARK_IMAGE_NAME $SPARK_DOCKER_FILE_DIR
fi

if [[ $build_all == true || $build_hive == true ]]; then
  docker build -t $HIVE_IMAGE_NAME $HIVE_DOCKER_FILE_DIR
fi

if [[ $build_all == true || $build_airflow == true ]]; then
  docker build -t $AIRFLOW_IMAGE_NAME $AIRFLOW_DOCKER_FILE_DIR
fi