FROM big-data-base:latest
LABEL maintainer="Cevat Batuhan Tolon"

COPY ./entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 10000 
EXPOSE 10001
EXPOSE 10002

ENTRYPOINT [ "./entrypoint.sh" ]