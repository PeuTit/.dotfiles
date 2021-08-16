# If you come from bash you might have to change your $PATH.
export PATH="/usr/local/sbin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/titouan/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="awesomepanda"

# Standard plugins can be found in $ZSH/plugins/
plugins=(git brew rails vscode)

source $ZSH/oh-my-zsh.sh

# User configuration

alias config="vim ~/.zshrc"
alias reload="source ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias fs="foreman start"
alias pupsub="gcloud beta emulators pubsub start"
alias ng="ngrok start --all"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# Github API Token
HOMEBREW_GITHUB_API_TOKEN="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"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
