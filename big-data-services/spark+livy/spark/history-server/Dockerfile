FROM spark-base:latest

LABEL maintainer="Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>"

# Master configuration
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER="spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"
#ENV SPARK_MASTER_URL="spark://spark-master:7077"

# History server configuration
ENV SPARK_HS_LOG_DIR=$SPARK_HOME/spark-hs-logs
ENV SPARK_HS_UI_PORT 18081

COPY history-server.sh /

EXPOSE 18081

RUN chmod +x history-server.sh

CMD ["./history-server.sh"]