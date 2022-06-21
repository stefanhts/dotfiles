# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_profile
alias vim="nvim"
alias ..="cd .."
alias .="clear"
alias :q="exit"
alias v="nvim"


