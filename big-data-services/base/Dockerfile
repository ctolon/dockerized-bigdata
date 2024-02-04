# Big Data Base Image. This image is used as a base image for Spark, Hive, Hadoop and other big data tools.
FROM python:3.10-bullseye
LABEL maintainer="Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>"

# Set environment variables
ENV ENABLE_INIT_DAEMON false
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

# Set base url for downloading Spark
ENV BASE_URL=https://archive.apache.org/dist/spark/

# Set Spark, Hadoop, Java, Hive and Postgres JDBC Driver version
ENV SPARK_VERSION=3.3.2
ENV SPARK_HADOOP_VERSION=3
ENV HADOOP_VERSION=3.3.3
ENV JAVA_VERSION=11
ARG HIVE_VERSION
ENV HIVE_VERSION=${HIVE_VERSION:-3.1.2}
ENV POSTGRES_JDBC_VERSION=42.6.0

# Set Environment variables for Spark, Hadoop, Java and Hive
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}
ENV JAVA_HOME="/usr/lib/jvm/java-1.${JAVA_VERSION}.0-openjdk-amd64"
ENV HIVE_HOME=${HIVE_HOME:-"/opt/hive"}
ENV PATH="${SPARK_HOME}/sbin:${SPARK_HOME}/bin:${PATH}"
ENV PATH ${HADOOP_HOME}/bin/:$PATH
ENV PATH=${HIVE_HOME}/bin:$PATH

# Set Hadoop Config Directory
ENV HADOOP_CONF_DIR=/etc/hadoop

# Install system dependencies (For Java, you are free to choose on jre or jdk)
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      bash \
      vim \
      nano \
      unzip \
      rsync \ 
      openjdk-${JAVA_VERSION}-jdk \
      python3-pip \
      coreutils \
      procps \
      unzip \
      software-properties-common \
      ssh \
      netcat \
      gcc \
      wget

# Create spark and hadoop directories then set workdir as spark home
RUN mkdir -p ${HADOOP_HOME} && mkdir -p ${SPARK_HOME}

# Create symbolic link for lib64
RUN ln -s /lib64/ld-linux-x86-64.so.2 /lib/ld-linux-x86-64.so.2

# Download Hadoop and extract it to /opt/hadoop
RUN mkdir -p ${HADOOP_HOME}

RUN wget -c -O hadoop.tar.gz https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar xvf hadoop.tar.gz --directory=/opt/hadoop --exclude=hadoop-${HADOOP_VERSION}/share/doc --strip 1 && \
    rm -rf hadoop.tar.gz && \
    ln -s /opt/hadoop/etc/hadoop /etc/hadoop && \
    mkdir /opt/hadoop/logs && \
    mkdir /hadoop-data

# Copy Hadoop configuration files
# COPY ./hadoop-conf ./conf

# Move Hadoop configuration files to /etc/hadoop
#RUN mv ./conf/* /etc/hadoop/ && \
#    rm -rf ./conf

# Download Spark and extract it to /
RUN wget ${BASE_URL}/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz

# Move Spark to /opt/spark
RUN mv spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}/* ${SPARK_HOME}

# Remove Spark tgz file
RUN rm spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz

# Remove Temp Spark Directory
RUN rm -rf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}

# Spark should be compiled with Hive to be able to use it
# hive-site.xml should be copied to $SPARK_HOME/conf folder
# So We need to install Hive in Spark Base Image
WORKDIR /opt

RUN apt-get install -yqq && \
    wget -c -O hive.tar.gz https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar xvf hive.tar.gz && \
    rm hive.tar.gz && \
    mv apache-hive-${HIVE_VERSION}-bin hive && \
    wget -O ${HIVE_HOME}/lib/postgresql-jdbc.jar https://jdbc.postgresql.org/download/postgresql-${POSTGRES_JDBC_VERSION}.jar && \
    apt-get --purge remove -yqq wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy Hive Configurations
# COPY ./hive-conf/hive-site.xml ${HIVE_HOME}/conf
# COPY ./hive-conf/hive-env.sh ${HIVE_HOME}/conf
# COPY ./hive-conf/ivysettings.xml ${HIVE_HOME}/conf

# For Using Spark with Hive we need to copy hive-site.xml to Spark conf folder
# RUN cp ${HIVE_HOME}/conf/hive-site.xml $SPARK_HOME/conf

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

# Set working directory as / for further steps
WORKDIR /