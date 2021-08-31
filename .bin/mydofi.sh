#!/usr/bin/env bash

killall -q wofi || {
  wofi --dmenu
}
