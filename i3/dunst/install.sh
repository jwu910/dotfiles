#!/bin/bash

[ ! -d "$HOME/.config/dunst" ] && mkdir "$HOME/.config/dunst"

ln -s $HOME/dotfiles/i3/dunst/dunstrc ~/.config/dunst/dunstrc

