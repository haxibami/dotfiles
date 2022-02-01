#!/usr/bin/env bash

# A script to fetch keydb.cfg for aacs

KEYDB_SOURCE="http://fvonline-db.bplaced.net/export/keydb_jpn.zip"
KEYDB_WORKDIR="/tmp/keydb"
AACS_KEYFILE="${HOME}/.config/aacs/keydb.cfg"

if [ -d $KEYDB_WORKDIR ]; then
  rm -r $KEYDB_WORKDIR
fi

mkdir $KEYDB_WORKDIR
cd $KEYDB_WORKDIR
curl -O $KEYDB_SOURCE
unzip -o keydb_jpn.zip
cp keydb.cfg $AACS_KEYFILE

rm -r $KEYDB_WORKDIR
