# If you come from bash you might have to change your $PATH.
export PATH="/usr/local/sbin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/titouan/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="awesomepanda"

# Standard plugins can be found in $ZSH/plugins/
plugins=(git brew rails gitignore)

source $ZSH/oh-my-zsh.sh

# User configuration
alias config="vim ~/.zshrc"
alias reload="source ~/.zshrc"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
