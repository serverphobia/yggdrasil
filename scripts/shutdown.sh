#!/bin/bash

SERVER_DIR=~/hercules/
LOGIN_SERVER=login_server
CHAR_SERVER=char_server
MAP_SERVER=map_server

cd $SERVER_DIR

if [[ \
    -e .$LOGIN_SERVER.pid || \
    -e .$CHAR_SERVER.pid || \
    -e .$MAP_SERVER.pid 
]]; then
    echo "The server is running. Shutting it down";
    ./athena-start stop
fi

if [ "$(docker ps -q -f name=$SERVER_DB_CONTAINER)" ]; then
    echo "The database is running. Shutting it down..."
    docker container stop $SERVER_DB_CONTAINER
fi

exit 0;