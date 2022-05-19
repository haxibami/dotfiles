#!/usr/bin/env bash

# a script to switch GTK theme according to time

MODE=$1
GTK_LIGHT_THEME="WhiteSur-Light-solid-alt-pink"
GTK_LIGHT_ICON_THEME="WhiteSur"
KVANTUM_THEME="WhiteSur-solid"
GTK_DARK_THEME="WhiteSur-Dark-solid-alt-pink"
GTK_DARK_ICON_THEME="WhiteSur-dark"
KVANTUM_DARK_THEME="WhiteSur-solidDark"

function setlighttheme() {
  gsettings set org.gnome.desktop.interface gtk-theme $GTK_LIGHT_THEME
  gsettings set org.gnome.desktop.interface icon-theme $GTK_LIGHT_ICON_THEME
  kvantummanager --set $KVANTUM_THEME > /dev/null 2>&1
}

function setdarktheme() {
  gsettings set org.gnome.desktop.interface gtk-theme $GTK_DARK_THEME
  gsettings set org.gnome.desktop.interface icon-theme $GTK_DARK_ICON_THEME
  kvantummanager --set $KVANTUM_DARK_THEME > /dev/null 2>&1
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
