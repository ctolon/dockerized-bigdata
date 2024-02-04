# Base Image for Big Data Clusters
FROM big-data-base:latest
LABEL maintainer="Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>"

# Copy scripts for initializing Spark
COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

# Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

# Also For Spark Scripts
RUN chmod +x ${SPARK_HOME}/sbin/*.sh