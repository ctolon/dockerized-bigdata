#!/bin/bash

set -e

. "${SPARK_HOME}/sbin/spark-config.sh"

. "${SPARK_HOME}/bin/load-spark-env.sh"

mkdir -p $SPARK_WORKER_LOG_DIR

LOG=$SPARK_WORKER_LOG_DIR/spark-worker.out

ln -sf /dev/stdout $LOG

${SPARK_HOME}/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker \
    --webui-port $SPARK_WORKER_UI_PORT $SPARK_MASTER >> $LOG