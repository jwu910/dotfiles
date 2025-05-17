#!/bin/bash
# Mac entry point for zsh
echo "[file] $(basename \"$0\")"

# Add new homebrew to path for Sequoia 15+
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# TODO: move to work env
# Add JENV java version manager
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export DOTFILES_DIR="$HOME/dotfiles"

alias zrc="vim $DOTFILES_DIR/mac/.zshrc"

source $DOTFILES_DIR/common/.zshrc
source $DOTFILES_DIR/mac/.alias


# # Load environments
# for file in $DOTFILES_DIR/environment/.*; do
#   source $file
# done
echo "Sourcing $DOTFILES_DIR/common/.general-environment"
source $DOTFILES_DIR/common/.general-environment
echo "Sourcing $DOTFILES_DIR/work/.work-environment"
source $DOTFILES_DIR/work/.work-environment


export PATH="$HOME/dotfiles/scripts:$PATH"

# Source autocompletions for kubectl
source <(kubectl completion zsh || echo "Unable to load kubectl completions")

clear

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export HOMEBREW_NO_AUTO_UPDATE=true
