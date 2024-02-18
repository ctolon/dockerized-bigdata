#!/bin/bash

set -e

. "${SPARK_HOME}/sbin/spark-config.sh"

. "${SPARK_HOME}/bin/load-spark-env.sh"


mkdir -p "$SPARK_HS_LOG_DIR"

LOG=$SPARK_HS_LOG_DIR/spark-hs.out

ln -sf /dev/stdout $LOG

# See https://spark.apache.org/docs/latest/monitoring.html#environment-variables
export SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=$SPARK_HOME/spark-events -Dspark.history.ui.port=$SPARK_HS_UI_PORT" 

${SPARK_HOME}/sbin/../bin/spark-class org.apache.spark.deploy.history.HistoryServer >> $LOG