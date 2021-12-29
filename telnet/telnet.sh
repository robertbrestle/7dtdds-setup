#!/bin/bash
HOST='localhost'
PORT='8081'
CMD=$1
OUT=$2
(
echo open "$HOST $PORT"
sleep 2
echo "$CMD"
sleep 2
echo "exit"
) | telnet > $2