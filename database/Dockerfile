FROM mariadb

MAINTAINER Nícolas 'eowfenth' Deçordi <www.github.com/eowfenth>

RUN apt-get update && apt-get install -y git \
    && git clone --depth 1 https://github.com/HerculesWS/Hercules /opt/hercules
RUN cp /opt/hercules/sql-files/main.sql /opt/hercules/sql-files/logs.sql /docker-entrypoint-initdb.d/