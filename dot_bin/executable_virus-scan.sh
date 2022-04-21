#!/usr/bin/env bash

mkdir -p $HOME/.clamtk/virus
mkdir -p $HOME/.clamtk/history

find $HOME -type d | xargs clamdscan \
  --infected \
  --multiscan \
  --fdpass \
  --move="$HOME/.clamtk/virus" \
  --log="$HOME/.clamtk/history/$(date +\%Y\%m\%d-\%H\%M\%S).log"
