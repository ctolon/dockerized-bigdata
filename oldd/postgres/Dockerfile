ARG POSTGRESQL_VERSION
ARG POSTGRES_PASSWORD
ARG POSTGRES_HOST_AUTH_METHOD
FROM postgres:13
LABEL maintainer="Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>"

COPY init-hive-db.sh /docker-entrypoint-initdb.d/init-hive-db.sh

RUN chmod +x /docker-entrypoint-initdb.d/init-hive-db.sh

#EXPOSE 5432