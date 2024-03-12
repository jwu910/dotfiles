#!/bin/bash

echo "This file is still WIP, uncomment the following line to run"
#exit 0

log() {
    # Simmple logger function
    echo -e "[$1]: $2"
}

OS_PATH=""

if [ "$(uname)" == "Darwin" ]; then
    OS_PATH="/mac"
elif [ "$(uname)" == "Linux" ]; then
    OS_PATH="/linux"
fi

echo "Identified OS_PATH is $OS_PATH"

read -rp "Do you want to proceed with the default shell (zsh)? (Y/n) " PROCEED_DEFAULT_SHELL

if [[ "$PROCEED_DEFAULT_SHELL" == "Y" || "$PROCEED_DEFAULT_SHELL" == "y" || -z "$PROCEED_DEFAULT_SHELL" ]]; then
  DOTFILE_SHELL="zsh"
else
  read -rp "Enter a valid shell (bash/zsh): " CUSTOM_SHELL

  if [[ "$CUSTOM_SHELL" == "bash" || "$CUSTOM_SHELL" == "zsh" ]]; then
    DOTFILE_SHELL="$CUSTOM_SHELL"
  else
    echo "Invalid shell entered. Defaulting to zsh."
    DOTFILE_SHELL="zsh"
  fi
fi


generateSymLink() {
    # Check if target and source exist
    local TARGET="$HOME/$1"
    local SOURCE="$PROJECT_ROOT$OS_PATH/$1"

    echo "Generating symlink for $SOURCE at $TARGET"

    if [[ ! -f $SOURCE ]]; then
        log "error" "Dotfile named $1 not found"

        return 1
    elif [[ -f "$SOURCE" && ! -f "$TARGET" ]]; then
        log "log" "Dotfile found, creating symbolic link."

        ln -s "$SOURCE" "$TARGET" && log "success" "Created sym link for \"$1\" at \"$HOME/$1\""
    elif [[ -L "$TARGET" ]]; then
        echo "A $1 configuration file already exists."
        read -rsn 1 -ep "Create backup and continue to create sym link? (Y/n) " CONTINUE

        if [ "$CONTINUE" == "Y" ]; then
            mv "$TARGET" "$HOME/$1-original"

            ln -s "$SOURCE" "$TARGET" && log "success" "Created sym link for \"$1\" at \"$HOME/$1\" with a backup at \"$HOME/$1-original\""
        else
            log "log" "Skipping symbolic link for \"$1\". Run this script again or manually link file."
            log "code" "ln -s $SOURCE $TARGET"
        fi
    else
        log "error" "Nothing happend. Am I broken?"
    fi
}

PROJECT_ROOT=$(git rev-parse --show-toplevel)

# SCRIPTS_PATH="$PROJECT_ROOT/scripts"

# Check env variables for usage through setup; Determine what shell to use
# Variable name: DOTFILE_SHELL
# Options: "bash" | "zsh"
if [ -z "$DOTFILE_SHELL" ]; then
    log "error" "No value set for environment variable DOTFILE_SHELL, please set this in your environemnt_setup file"
    exit 1
fi

# Add shell config file symbolic links to home
case $DOTFILE_SHELL in
"bash")
    generateSymLink ".bashrc"
    ;;
"zsh")
    generateSymLink ".zshrc"
    ;;
*)
    log "error" "DOTFILE_SHELL variable does not match any valid shells for this setup. Options are \"bash\" or \"zsh\"."
    log "error" "Invalid value is : $DOTFILE_SHELL"
    log "error" "To fix this, modify DOTFILE_SHELL in your $PROJECT_ROOT/environment_setup file."
    exit 1
    ;;
esac

generateSymLink ".gitconfig" &&
    generateSymLink ".vimrc"

# Force set up for signing key
if ! ls ~/.gitconfig-signing-key* 1> /dev/null 2>&1; then
  echo "Error: ~/.gitconfig-signing-key* file does not exist"
  exit 1
fi


# Check if zsh installed
# Check if oh my zsh installed
# Check if exa is installed
# Check if spaceship prompt is installed
# Read list of dot files you want to create symlinks for
#symlink logic - for each file
# test -h file && do something if symlink || do something if not
#if sym link exists at ~, then remove symlink and recreate with dotfile in this project
#if symlink does not exist, but file exists, create a copy of that file with -backup filename and continue to create symlink
# Install diff-so-fancy
