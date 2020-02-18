#!/bin/bash

APP="polybar"
FILE_NAME="config"
CONFIG_DIR="$HOME/.config"
DOTFILE_DIR="$HOME/dotfiles"

DOTFILE_APP_DIR="$DOTFILE_DIR/i3/$APP"

[ ! -d "$CONFIG_DIR/$APP" ] && mkdir "$CONFIG_DIR/$APP"

if [[ -L "$CONFIG_DIR/$APP/$FILE_NAME" || -f "$CONFIG_DIR/$APP/$FILE_NAME" ]]; then
    rm $CONFIG_DIR/$APP/$FILE_NAME &&
    ln -s $DOTFILE_APP_DIR/$FILE_NAME $CONFIG_DIR/$APP/$FILE_NAME
else
    ln -s $DOTFILE_APP_DIR/$FILE_NAME $CONFIG_DIR/$APP/$FILE_NAME
fi

