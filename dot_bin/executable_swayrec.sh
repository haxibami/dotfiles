#!/usr/bin/env bash

STATUS=`ps -ef | grep obs | grep -v grep | wc -l`
PASSFILE="${HOME}/.secure/obs-websocket.txt"
PASS=`cat ${PASSFILE}`

if [[ $STATUS -ne 0 ]] && [ -e ~/.secure/obs-websocket.txt ]; then
  obs-cli recording toggle --password "${PASS}"
else
  echo "Launch obs studio with obs-websocket, and set password!"
fi
