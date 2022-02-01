#!/bin/sh
if [ $$ != `pgrep -fo $0` ]; then
  echo "Already running!" >&2
  exit 9
fi

python3 ~/.config/sway/window-transparency.py

exit 0
