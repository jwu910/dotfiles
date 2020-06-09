DOTFILE_DIR="$HOME/dotfiles"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(autojump extract fzf ripgrep)

source $ZSH/oh-my-zsh.sh

fpath=($fpath "$HOME/.zfunctions")

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

#####################################################################################
# User configuration
#####################################################################################
#
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# Custom Spaceship Prefix function to display WIP status
# Usage:  `gwip` to create a work in progress commit
#         `gunwip` to remove last work in progress commit
# https://github.com/denysdovhan/spaceship-prompt
SPACESHIP_WIP_PREFIX="${SPACESHIP_WIP_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_WIP_SUFFIX="${SPACESHIP_WIP_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_WIP_SYMBOL="${SPACESHIP_WIP_SYMBOL="🚧 "}"
SPACESHIP_WIP_TEXT="${SPACESHIP_WIP_TEXT="WIP!!! "}"
SPACESHIP_WIP_COLOR="${SPACESHIP_WIP_COLOR="red"}"

# Warn if the current branch is a WIP
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}

spaceship_wip() {
  [[ $SPACESHIP_WIP_SHOW == false ]] && return

  spaceship::is_git || return
  spaceship::exists work_in_progress || return

  if [[ $(work_in_progress) == "WIP!!" ]]; then
    # Display WIP section
    spaceship::section \
      "$SPACESHIP_WIP_COLOR" \
      "$SPACESHIP_WIP_PREFIX" \
      "$SPACESHIP_WIP_SYMBOL" \
      "$SPACESHIP_WIP_TEXT" \
      "$SPACESHIP_WIP_SUFFIX"
  fi
}

SPACESHIP_PROMPT_ORDER=($SPACESHIP_PROMPT_ORDER wip)


#######################################################################################
# Custom loaders
#######################################################################################
ALIAS_DIR="$DOTFILE_DIR/alias"
ENV_DIR="$DOTFILE_DIR/environment"
HOSTNAME="$(uname -n)"

#source $ALIAS_DIR/.liferay-alias
#source $ENV_DIR/.liferay-environment
source $ALIAS_DIR/.general-alias
source $ALIAS_DIR/.pollyex-alias
source $ALIAS_DIR/.zsh-alias
source $DOTFILE_DIR/.generalrc
source $ENV_DIR/.general-environment
source $ENV_DIR/.pollyex-environment
source $ENV_DIR/.zsh-environment

# enable keychain
if [ -f $HOME/.keychain/$HOSTNAME-sh ]; then
source $HOME/.keychain/$HOSTNAME-sh
fi

#######################################################################################
# Custom Functions
######################################################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

fpath+=${ZDOTDIR:-~}/.zsh_functions
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=5000
setopt beep nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
#
