#!/bin/bash
# Mac entry point for zsh
echo "[file] $(basename \"$0\")"

# TODO: move to work env
# Add JENV java version manager
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

DOTFILES_DIR="$HOME/dotfiles"

# # Load environments
# for file in $DOTFILES_DIR/environment/.*; do
#   source $file
# done
source $DOTFILE_DIR/common/.general-environment
source $DOTFILE_DIR/work/.work-environment

alias zrc="vim $DOTFILES_DIR/mac/.zshrc"

source $DOTFILES_DIR/common/.zshrc
source $DOTFILES_DIR/mac/.alias

# Add new homebrew to path for Ventura 13+
export PATH="/opt/homebrew/bin:$PATH"


clear

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

