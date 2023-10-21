FROM mariadb

MAINTAINER Nícolas 'eowfenth' Deçordi <www.github.com/eowfenth>

RUN apt-get update && apt-get install -y git \
    && git clone --depth 1 https://github.com/rathena/rathena.git /opt/rathena
RUN cp /opt/rathena/sql-files/main.sql /opt/rathena/sql-files/logs.sql /docker-entrypoint-initdb.d/