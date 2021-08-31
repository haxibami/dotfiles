#!/usr/bin/env bash

killall -q rofi || {
  rofi -show run
}
