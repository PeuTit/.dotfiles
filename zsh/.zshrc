# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="awesomepanda"

# Standard plugins can be found in $ZSH/plugins/
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_plugin/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# User configuration
# Alias
alias reload="source ~/.zshrc"

# Vi-mode configuration
# Cursor change between input mode
VI_MODE_SET_CURSOR=true
# Make the normal mode default when entering the shell
zle-line-init() { zle -K vicmd; }
zle -N zle-line-init

export PATH="/usr/local/sbin:$PATH"
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit ; compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
