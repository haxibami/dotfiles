#!/bin/bash

killall -q rofi || {
  rofi -show run
}
