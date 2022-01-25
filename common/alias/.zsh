
#################################################
# Custom functions
#################################################
OS=""

if [ $(uname -s) == 'Darwin' ];	then
	OS="/mac"
elif [	$(uname -s) == 'Linux*' ]; then
	OS="/linux"
fi

DOTFILES="$HOME/dotfiles"
ALIAS_DIR="$DOTFILES$OS/alias"

# fgst - pick files from `git status -s`
function is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

function fgst() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
    echo "$item" | awk '{print $2}'
  done
  echo
}

# List all node modules found recursively
function findNodeModules() {
  find . -name "node_modules" -type d -prune -mtime +30 -print | xargs du -chs
}

# Pull down remote branch and then delete local and remote references
function cleanBranch() {
  git pd "$1" && git db-all "$1";
}

# Get JIRA ticket pattern from branch name
function getJIRA() {
  git rev-parse --abbrev-ref HEAD | grep -Eo '([A-Z]{3,}-)([0-9]+)' -m 1
}

# Git Gud
function gitGud() {
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

# Cd up N directories
function cdn() { for i in `seq $1`; do cd ..; done;}


#################################################
# Custom Aliases
#################################################

alias ff="git ls-files | grep $1"
alias got="git"
alias qgit="git"
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias l='ls -F'
alias la='ls -a'
alias ll='ls -halF'
alias ls='exa --git' # Exa installation required
alias pzf="fzf --preview-window=top --preview='head -100 | bat --theme=zenburn --color=always --map-syntax js:babel {}'"
alias tr3="tree -d -L 3 -I node_modules"
alias zrc="vim $DOTFILES/common/.zshrc"

