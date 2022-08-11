DOTFILES_DIR="$HOME/dotfiles"

source $HOME/dotfiles/common/.zshrc

source $HOME/dotfiles/mac/.alias

# Add JENV java version manager
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
