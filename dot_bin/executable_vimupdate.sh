#!/usr/bin/env zsh

nvimupdate() {
  nvim -c "DeinUpdate" -c "CocUpdateSync" -c q
}

vimupdate() {
  vim -c "DeinUpdate" -c q
}

nvimupdate &&
vimupdate
