#!/bin/bash

killall -q wofi || {
  wofi
}
