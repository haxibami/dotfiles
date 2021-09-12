#!/usr/bin/env bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh);
export SSH_AUTH_LOCK;

exec i3
