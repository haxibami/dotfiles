#!/usr/bin/env bash
ddccontrol -r 0x10 -W -5 dev:/dev/i2c-2 | grep Brightness | cut -d "/" -f 2 | tee $XDG_RUNTIME_DIR/{ddc,wob}.sock
