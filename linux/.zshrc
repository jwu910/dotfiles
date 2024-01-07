#!/bin/bash
# Linux entry point for zsh
echo "[file] $(basename \"$0\")"

DOTFILES_DIR="$HOME/dotfiles"

source "$DOTFILES_DIR/common/.zshrc"
source "$DOTFILES_DIR/common/.general-environment"

source "$DOTFILES_DIR/linux/.alias"
source "$DOTFILES_DIR/linux/.functions"
