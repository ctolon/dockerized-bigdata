FROM spark-base:latest
LABEL maintainer="Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>"

ARG INSTALL_JUPYTER="false"

# Master configuration
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER="spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"
ENV SPARK_MASTER_UI_PORT 8082
ENV SPARK_MASTER_LOG_DIR=${SPARK_MASTER_LOG_DIR:-"${SPARK_HOME}/logs"}
ENV SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS:-"localhost"}
ENV SPARK_JARS_HDFS_PATH=${SPARK_JARS_HDFS_PATH:-${SPARK_HOME}/jars}
ENV SPARK_LOGS_HDFS_PATH=${SPARK_LOGS_HDFS_PATH:-${SPARK_HOME}/logs}


# Install Python packages for PySpark
COPY requirements.txt .
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install -r requirements.txt

# PySpark configuration
ENV PYSPARK_PYTHON python3
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

ENV PYSPARK_DRIVER_PYTHON=/usr/bin/python3

#export PYSPARK_DRIVER_PYTHON="jupyter"
#export PYSPARK_DRIVER_PYTHON_OPTS="notebook"

COPY start-master.sh .

RUN chmod +x start-master.sh

EXPOSE 8082 
EXPOSE 7077 
EXPOSE 6066

CMD [ "./start-master.sh" ]
#CMD ["/bin/bash"]