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

# my main aliases
alias vim=nvim
alias :q=exit
alias .=clear
alias ..="cd .."
alias vimfig="nvim ~/.config/nvim"
alias config="nvim ~/.zshrc"
alias src="source ~/.zshrc"
alias kitfig="nvim ~/.config/kitty/kitty.conf"
alias wezfig="nvim ~/.wezterm.lua"
alias l0="layer0"
alias kx="kubectx"
alias kn="kubens"
alias k="kubecolor"
# alias ls=pls
alias kubectl=kubecolor
alias kubesync="layer0 kubeconfig sync"

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
export PATH="$HOME/bin:$PATH"
export GOPATH=$HOME/go
export PATH="/usr/local/bin/od:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export KUBECONFIG="$KUBECONFIG:/Users/stefan.heller/.kube/layer0-dev"

# CDPATH to quickly cd to repo folders (work)
export CDPATH=".:$HOME/Work/notes:$CDPATH"
export CDPATH=".:$HOME/Work/repos:$CDPATH"
export CDPATH=":$HOME/Work/utils:$CDPATH"


# CDPATH to quickly cd to repo folders (personal)
export CDPATH=".:$HOME/Documents/Projects:$CDPATH"
export CDPATH=".:$HOME/Documents/Videos:$CDPATH"
export CDPATH=".:$HOME/Documents/Personal:$CDPATH"


note_cmd="$HOME/Work/notes"

#
# Functions
#

vr() {
    cd $1 && nvim .
}

name() {
    wezterm cli rename-workspace $1
    echo "workspace ==> $1"
}

kscale() {
    kubectl scale --replicas $1 deploy/main
}

l0-switch() {
    kubectx "layer0-dev-$1"
}

l0sync-fast() {
    layer0 space sync $1 --layer0-base-ref $2 --out-of-sync-only "true" --skip-tests --skip-infra
}

l0dev() {
    layer0 login dev; layer0 profile select dev
}


notes() {
    if [[ $1 == *"per."* ]]; then
        nvim $note_cmd/personal/$1.md
    else
        echo "opening notes...";
        nvim $note_cmd/$1.md
    fi
}

# opam configuration
[[ ! -r /Users/stefan.heller/.opam/opam-init/init.zsh ]] || source /Users/stefan.heller/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Created by `pipx` on 2023-07-06 15:29:01
export PATH="$PATH:/Users/stefan.heller/.local/bin"
eval $(thefuck --alias)
