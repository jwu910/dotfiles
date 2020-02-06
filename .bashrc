# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='exa --color=auto --git'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ls='exa --git'
alias ll='ls -halF'
alias la='ls -a'
alias l='ls -F'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# drops first portion of a path $1 if length is greater than $2
function __droppath {
    if [[ ${#1} -gt $2 ]]; then
        p=$1
        while [ ${#p} -gt $2 ]; do
            p="/"$(echo "$p"|cut -d"/" -f3-)
        done
        echo "..."$p
    else
        echo $1
    fi
}

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

# Add git branch if its present to PS1
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ "$force_color_prompt" = yes ]; then
    PS1='\[\033[1m\]\[\033[90m\][${debian_chroot:+($debian_chroot)}\[\033[02;93m\]$(__droppath "\w" 50)\[\033[35m\]$(parse_git_branch)\[\033[00;90m\]]\[\033[00m\] \n| 👏👏👏🍞 >> $ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u:$(__droppath "\w" 50)$(parse_git_branch)\$ '
fi

unset color_prompt force_color_prompt

if [ -f ~/.envs ]; then
    source ~/.envs
fi

if [ -f ~/.tokens ]; then
    source ~/.tokens
fi

if [ -f /usr/share/autojump/autojump.sh ]; then
    source /usr/share/autojump/autojump.sh
fi

# Shortcut to open bashrc
alias brc="vim ~/.bashrc"
alias brcl="vim ~/configs/includes/.bashrc-liferay"
alias sbrc="source ~/.bashrc && echo '.bashrc reloaded.'"

# Restart network manager
alias restartnetwork="sudo systemctl restart NetworkManager.service && echo Network manager restarting..."

alias dropDist='git checkout -- src/**/dist/*'
alias scrshot='sh ~/configs/scripts/screenshot.sh -s'
alias fixWatches="echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
alias tr3="tree -d -L 3 -I node_modules"
alias ff="git ls-files | grep $1"
alias bread="echo 'gotta :clap::skin-tone-3: get :clap::skin-tone-3: that :clap::skin-tone-3: bread :bread:' | xclip -selection c"
alias odiff="git diff upstream/master --stat --name-only --relative"
alias flip="echo '(╯°□°）╯︵ ┻━┻' | xclip -selection c"

# Start github at current project
function ghub {
	local remote=${1:-"origin"}
	local giturl=$(git config --get "remote.${remote}.url")
	giturl=${giturl%/}
	giturl=${giturl%.git}
	local uri=${giturl##*@}
		uri=${uri##*://}
	local urlPath=${uri#*[/:]*}
	local openUrl="https://github.com/$urlPath"
	"$BROWSER" $openUrl &
}

if [ -d "$HOME/.bin" ] ; then
  PATH="$PATH:$HOME/.bin"
fi

export BROWSER="/usr/bin/firefox"

    # Git Gud
function gitGud {
    echo "           /\$\$   /\$\$                                     /\$\$";
    echo "          |__/  | \$\$                                    | \$\$";
    echo "  /\$\$\$\$\$\$  /\$\$ /\$\$\$\$\$\$          /\$\$\$\$\$\$  /\$\$   /\$\$  /\$\$\$\$\$\$\$";
    echo " /\$\$__  \$\$| \$\$|_  \$\$_/         /\$\$__  \$\$| \$\$  | \$\$ /\$\$__  \$\$";
    echo "| \$\$  \ \$\$| \$\$  | \$\$          | \$\$  \ \$\$| \$\$  | \$\$| \$\$  | \$\$";
    echo "| \$\$  | \$\$| \$\$  | \$\$ /\$\$      | \$\$  | \$\$| \$\$  | \$\$| \$\$  | \$\$";
    echo "|  \$\$\$\$\$\$\$| \$\$  |  \$\$\$\$/      |  \$\$\$\$\$\$\$|  \$\$\$\$\$\$/|  \$\$\$\$\$\$\$";
    echo " \____  \$\$|__/   \___/         \____  \$\$ \______/  \_______/";
    echo " /\$\$  \ \$\$                     /\$\$  \ \$\$                    ";
    echo "|  \$\$\$\$\$\$/                    |  \$\$\$\$\$\$/                    ";
    echo " \______/                      \______/                     ";
}
export -f gitGud

# Easy extract
#extract () {
#  if [ -f $1 ] ; then
#      case $1 in
#          *.tar.bz2)   tar xvjf $1    ;;
#          *.tar.gz)    tar xvzf $1    ;;
#          *.bz2)       bunzip2 $1     ;;
#          *.rar)       rar x $1       ;;
#          *.gz)        gunzip $1      ;;
#          *.tar)       tar xvf $1     ;;
#          *.tbz2)      tar xvjf $1    ;;
#          *.tgz)       tar xvzf $1    ;;
#          *.zip)       unzip $1       ;;
#          *.Z)         uncompress $1  ;;
#          *.7z)        7z x $1        ;;
#          *)           echo "don't know how to extract '$1'..." ;;
#      esac
#  else
#      echo "'$1' is not a valid file!"
#  fi
#}

# Cd up N directories
function cdn(){ for i in `seq $1`; do cd ..; done;}

# Personal scripts path
export PATH="$PATH:/home/joshua/configs/scripts"

export TEXT_EDITOR="code"
export LESS=-R


source ~/configs/includes/.bashrc-liferay

# Adding autocomplete for 'we'
[ -f ~/.we_autocomplete ] && source ~/.we_autocomplete

# Pacaur backup installed packages
#echo "$(pacaur -Qqe)" > ~/configs/backup/backpac.txt

# SSH Key login
#if [ "$MACHINE_NAME" = "PERSONAL" ]; then
#	eval $(keychain --eval --quiet ~/.ssh/id_rsa)
#fi

function getJIRA(){ git rev-parse --abbrev-ref HEAD | grep -Eo '([A-Z]{3,}-)([0-9]+)' -m 1 ; }


#ACTIVE_MONITOR=`xrandr --listactivemonitors | grep 0 | awk '{print $NF}'`

#if [ ! "$MONITOR_NAME" = "$TEMP_MONITOR" ]; then
#    echo "Active monitor is not $MONITOR_NAME"
#    echo "Active Monitor is currently $ACTIVE_MONITOR"
#
#    MONITOR_NAME="$ACTIVE_MONITOR"
#fi

export NSCRIPT_EDITOR="code"
export NSCRIPT_SCRIPT_DIR="/home/joshua/configs/scripts/nscripts"
export NSCRIPT_EXECUTABLE_DIR="/home/joshua/configs/scripts/nscripts-links"

eval "$(hub alias -s)"

export FZF_DEFAULT_OPTS="-m --no-mouse -i --inline-info --color=LIGHT --border --margin=1"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | rg --files --hidden"

alias pzf="fzf --preview-window=top --preview='head -100 | bat --theme=zenburn --color=always --map-syntax js:babel {}'"

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fzfkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m --preview='' | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# fgst - pick files from `git status -s`
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fgst() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
    echo "$item" | awk '{print $2}'
  done
  echo
}
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"


glog() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}


function findNodeModules() { find . -name "node_modules" -type d -prune -mtime +30 -print | xargs du -chs ; }

function cleanBranch() { git pd "$1" && git db-all "$1" ; }
#----------------------------------

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh


export PATH="$PATH:$HOME/configs/scripts/nscripts-links"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"

export PATH="$PATH:$HOME/.local/bin"
export GPG_TTY=$(tty)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
