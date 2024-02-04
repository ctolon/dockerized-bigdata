#ARG debian_buster_image_tag=11-jre-slim
#FROM openjdk:${debian_buster_image_tag}

FROM spark-base:latest

# Set Environment variables for Spark
ENV SPARK_VERSION=3.3.2

ENV SCALA_VERSION=2.12.15
ENV SCALA_HOME="/usr/bin/scala"
ENV SCALA_KERNEL_VERSION=0.13.1
ENV PATH=${PATH}:${SCALA_HOME}/bin

ENV JUPYTERLAB_VERSION=3.0.0

# Install system dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
      r-base

# Install Python dependencies
RUN pip3 install --upgrade pip
RUN pip3 install wget==3.2 pyspark==${SPARK_VERSION} jupyterlab==${JUPYTERLAB_VERSION}
RUN pip3 install pandas

# Create workspace directories
RUN mkdir -p /opt/workspace/data
RUN mkdir -p /usr/share/man/man1

# Create symbolic link for python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install Scala 
RUN curl https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.deb -k -o scala.deb
RUN apt install -y ./scala.deb
RUN rm -rf scala.deb /var/lib/apt/lists/*

# JupyterLab + Python kernel for PySpark
COPY workspace/ /workspace/

# Scala kernel for Spark
RUN apt-get install -y ca-certificates-java --no-install-recommends
RUN curl -Lo coursier https://git.io/coursier-cli
RUN chmod +x coursier
RUN ./coursier launch --fork almond:${SCALA_KERNEL_VERSION} --scala ${SCALA_VERSION} -- --display-name "Scala ${SCALA_VERSION}" --install
RUN rm -f coursier

# R kernel for SparkR
#RUN apt-get install -y r-base-dev
RUN R -e "install.packages('IRkernel')"
RUN R -e "IRkernel::installspec(displayname = 'R 3.5', user = FALSE)"
RUN curl https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/SparkR_${SPARK_VERSION}.tar.gz -k -o sparkr.tar.gz
RUN R CMD INSTALL sparkr.tar.gz
RUN rm -f sparkr.tar.gz

WORKDIR /workspace

# EXPOSE 8888
# CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=