#!/bin/bash
#ddcutil --bus 2 getvcp 10 | grep -o -P '\d*,' | grep -Eo '[0-9]' | tr -d '\n'
ddcutil --bus 2 getvcp 10 | awk '{print $9}' | tr -d ','
