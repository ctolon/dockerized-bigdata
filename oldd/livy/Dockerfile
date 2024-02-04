FROM cloudiator/livy-server
LABEL maintainer="Cevat Batuhan Tolon <cevat.batuhan.tolon@cern.ch>"

RUN apt-get install -y netcat

# livy  | tail: inotify cannot be used, reverting to polling: Too many open files
# Add the configuration settings to /etc/sysctl.conf
RUN echo "fs.inotify.max_user_instances=1024" >> /etc/sysctl.conf && \
    echo "fs.inotify.max_user_watches=65536" >> /etc/sysctl.conf