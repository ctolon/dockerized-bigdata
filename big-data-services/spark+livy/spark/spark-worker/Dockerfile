FROM spark-base:latest
LABEL maintainer="Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>"

# Worker configuration
ENV SPARK_WORKER_UI_PORT 8081
ENV SPARK_WORKER_LOG_DIR="/var/logs/spark"

# Master configuration
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV SPARK_MASTER_HOST=${SPARK_MASTER_HOST:-"spark-master"}
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER="spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"

COPY start-worker.sh .

RUN chmod +x start-worker.sh

EXPOSE 8081

CMD [ "./start-worker.sh" ]