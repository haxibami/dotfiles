#!/usr/bin/env bash

gs -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -sOutputFile=$2 -f $1
