# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git branch colorize)

source $ZSH/oh-my-zsh.sh

alias vim=nvim
alias :q=exit
alias .=clear
alias ..="cd .."
alias vimfig="nvim ~/.config/nvim"
alias config="nvim ~/.zshrc"
alias k=kubectl
alias l0=layer0
alias utils="cd utils"
alias src="source ~/.zshrc"
alias repo="cd repos"
alias icat="kitty +kitten icat"
alias kitfig="nvim ~/.config/kitty/kitty.conf"
alias d="kitty +kitten diff"
alias theme="kitty +kitten themes"
# User configuration

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# NVM, this needs to be after oh-my-zsh is loaded btw
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
unalias gk
alias python=python3
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/usr/local/opt/mongodb-community@4.4/bin:$PATH"
export GOPATH=$HOME/go
export PATH="/usr/local/bin/od:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export KUBECONFIG="$KUBECONFIG:/Users/stefan.heller/.kube/layer0-dev"

# CDPATH to quickly cd to repo folders
export CDPATH=".:$HOME/Work/repos:$CDPATH"
export CDPATH=":$HOME/Work/utils:$CDPATH"

# opam configuration
[[ ! -r /Users/stefan.heller/.opam/opam-init/init.zsh ]] || source /Users/stefan.heller/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


vr() {
    cd $1 && nvim .
}

show() {
    rg -wHn $1 $2
}


