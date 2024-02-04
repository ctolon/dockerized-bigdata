FROM spark-base:latest
LABEL maintainer="Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>"

# Submit configuration
ENV SPARK_SUBMIT_ARGS=""
ENV SPARK_APPLICATION_ARGS=""

# Master configuration
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER="spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"

COPY ./spark-submit.sh .

RUN chmod +x spark-submit.sh

CMD [ "./spark-submit.sh" ]