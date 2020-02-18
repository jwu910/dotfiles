#!/bin/bash

[ ! -d "$HOME/.config/rofi" ] && mkdir "$HOME/.config/rofi"

ln -s $HOME/dotfiles/i3/rofi/config ~/.config/rofi/config

