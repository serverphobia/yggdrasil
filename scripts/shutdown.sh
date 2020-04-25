#!/bin/bash

HOST=""
SERVER_DIR=~/hercules
LOGIN_SERVER=login_server
CHAR_SERVER=char_server
MAP_SERVER=map_server
DEFAULT_DB_CONTAINER=yggdrasil-db

cd $SERVER_DIR

# Server Guard to check whether your server is running;
if [[ \
    -e .$LOGIN_SERVER.pid || \
    -e .$CHAR_SERVER.pid || \
    -e .$MAP_SERVER.pid 
]];
then
    echo "Server is running. Shutting it down...";
    ./athena-start stop
 else
    echo "Server is not running."
fi

# Checks for metadata in your Google Compute Engine instance;
if [ $HOST == "gcp" ]; then
    METADATA_URL="http://metadata.google.internal/computeMetadata/v1/instance/attributes/"
    METADATA_HEADER='-H "Metadata-Flavor: Google"'
    METADATA_VALUE=$(curl -s "${METADATA_URL}SERVER_DB_CONTAINER ${METADATA_HEADER}")
    SERVER_DB_CONTAINER=${METADATA_VALUE:-$DEFAULT_DB_CONTAINER}
    if [ $SERVER_DB_CONTAINER == $DEFAULT_DB_CONTAINER ];
    then
        echo "You can associate a metadata key to dynamic change the content of this script. Use SERVER_DB_CONTAINER key."
    fi
fi

# Server Guard to check whether your database is running;
if [ "$(docker ps -q -f name=$SERVER_DB_CONTAINER)" ];
then
    echo "Database is running. Shutting it down..."
    docker container stop $SERVER_DB_CONTAINER
else
    echo "Database is not running."
fi

exit 0;