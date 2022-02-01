#!/usr/bin/env bash

# a script to switch GTK theme according to time

MODE=$1
GTK_LIGHT_THEME="WhiteSur"
GTK_DARK_THEME="WhiteSur-dark"

function setlighttheme() {
  gsettings set org.gnome.desktop.interface gtk-theme $GTK_LIGHT_THEME
  gsettings set org.gnome.desktop.interface icon-theme $GTK_LIGHT_THEME
}

function setdarktheme() {
  gsettings set org.gnome.desktop.interface gtk-theme $GTK_DARK_THEME
  gsettings set org.gnome.desktop.interface icon-theme $GTK_DARK_THEME
}

function switchtheme() {
  CHECK_HOUR=`date +%H`
  if [ $CHECK_HOUR -ge 6 ] && [ $CHECK_HOUR -lt 18 ]; then
    setlighttheme
  else
    setdarktheme
  fi
}

if [ "$MODE" = "day" ]; then
  setlighttheme
elif [ "$MODE" = "night" ]; then
  setdarktheme
else
  switchtheme
fi
