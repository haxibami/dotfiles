#!/usr/bin/env bash

# a script to switch GTK theme according to time
# requires: gsettings

GTK_LIGHT_THEME="Catppuccin-Latte-Standard-Mauve-Light"
GTK_LIGHT_ICON_THEME="WhiteSur"
GTK_LIGHT_CURSOR_THEME="Catppuccin-Latte-Dark-Cursors"
KVANTUM_LIGHT_THEME="Catppuccin-Latte-Mauve"
XSETTINGS_CONF="$HOME/.config/xsettingsd/xsettingsd.conf"

function setlighttheme() {
  # GTK
  gsettings set org.gnome.desktop.interface gtk-theme $GTK_LIGHT_THEME
  gsettings set org.gnome.desktop.interface icon-theme $GTK_LIGHT_ICON_THEME
  gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
  # QT (kvantum)
  kvantummanager --set $KVANTUM_LIGHT_THEME > /dev/null 2>&1
  # GTK (XWayland)
  sed -i --follow-symlinks "s:Net/ThemeName .*:Net/ThemeName \"$GTK_LIGHT_THEME\":g" $XSETTINGS_CONF
  sed -i --follow-symlinks "s:Net/IconThemeName .*:Net/IconThemeName \"$GTK_LIGHT_ICON_THEME\":g" $XSETTINGS_CONF
  sed -i --follow-symlinks "s:Gtk/CursorThemeName .*:Gtk/CursorThemeName \"$GTK_LIGHT_CURSOR_THEME\":g" $XSETTINGS_CONF
  if [[ `pidof xsettingsd` ]]; then
    killall -HUP xsettingsd
  else
    xsettingsd &
  fi
}

setlighttheme

makoctl set-mode default

notify-send --app-name="darkman" --urgency=low --icon=weather-clear "darkman" "switching to light mode"
