#!/usr/bin/env bash

# returns pipewire node id
# usage: ~/.bin/pwnodefd.sh <node.nick>

id=$(pw-dump |
    jq --arg nick $1 '.[] | select (.info.props."node.nick" == $nick)' |
    jq '.id')

if [ -n "$id" ]; then
    echo $id
else
    exit 1
fi
