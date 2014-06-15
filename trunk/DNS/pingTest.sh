#!/bin/bash
# ping checker tool

FAILS=0
SERVER="192.168.1.1"

while true; do
    ping -c 1 $1 >/dev/null 2>&1
    if [ $? -ne 0 ] ; then #if ping exits nonzero...
        FAILS=$[FAILS + 1]
    else
        FAILS=0
    fi
    if [ $FAILS -gt 4 ]; then
        FAILS=0
        echo "Server $SERVER is offline!" \
    fi
done