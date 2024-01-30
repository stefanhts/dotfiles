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
alias l0local="$GOPATH/bin/layer0 --profile local"
alias kx="kubectx"
alias kn="kubens"
alias k="kubecolor"
alias ls="eza -l"
alias sesh="workspaceizer"
alias open="opendir.sh"
# alias ls=pls
alias kubectl=kubecolor
alias kubesync="layer0 kubeconfig sync"

alias heatmap="git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10"

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
export PATH="/Users/stefan.heller/learning/task-queue:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
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

export REPOS="$HOME/Work/repos/"
export LEARNING="$HOME/learning/"
alias repos="cd $REPOS"
alias learning="cd $LEARNING"

alias notes="cd $HOME/Work/notes"

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

hist() {
    if [[ $1 == "-v" ]]; then
        history | grep --color $2 | nvim
    elif [[ $1 == "-g" ]] then
        history | grep --color $2
    else
        history | fzf
    fi
}

portify() {
    sudo lsof -i:$1
}

# opam configuration
[[ ! -r /Users/stefan.heller/.opam/opam-init/init.zsh ]] || source /Users/stefan.heller/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Created by `pipx` on 2023-07-06 15:29:01
export PATH="$PATH:/Users/stefan.heller/.local/bin"
eval $(thefuck --alias)

[[ -s "/Users/stefan.heller/.gvm/scripts/gvm" ]] && source "/Users/stefan.heller/.gvm/scripts/gvm"
