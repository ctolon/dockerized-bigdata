#!/bin/bash

set -e

. "${SPARK_HOME}/sbin/spark-config.sh"

. "${SPARK_HOME}/bin/load-spark-env.sh"

mkdir -p $SPARK_MASTER_LOG_DIR

ln -sf /dev/stdout $SPARK_MASTER_LOG_DIR/spark-master.out

cd "${SPARK_HOME}/bin" && ${SPARK_HOME}/sbin/../bin/spark-class org.apache.spark.deploy.master.Master \
    --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_UI_PORT>> $SPARK_MASTER_LOG_DIR/spark-master.out