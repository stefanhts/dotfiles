export ZSH="$HOME/.oh-my-zsh"

source "$HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export KUBECONFIG="$KUBECONFIG:/Users/stefan.heller/.kube/layer0-prod"
export PATH='/Users/stefan.heller/.duckdb/cli/latest':$PATH

# Path to your oh-my-zsh installation.
export GPG_TTY=$(tty)
export EDITOR=nvim

autoload -U compinit && compinit
autoload -U colors && colors
autoload -Uz add-zsh-hook

# Add _zsh_task_update_rprompt to precmd_functions array
# This ensures it runs before each prompt is displayed.
if [[ -z "$precmd_functions" ]]; then
    precmd_functions=()
fi
if [[ ! " ${precmd_functions[@]} " =~ " _zsh_task_update_rprompt " ]]; then
    precmd_functions+=(_zsh_task_update_rprompt)
fi

# Initialize RPROMPT on shell start by calling the function once.
# This ensures the task count is displayed when a new terminal opens.
if (( ${+functions[_zsh_task_update_rprompt]} )); then
    _zsh_task_update_rprompt
fi

update_git_branch() {
    export GB=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
}

add-zsh-hook precmd update_git_branch

plugins=(git fasd branch colorize zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# my main aliases
alias g=git
alias gu="git pull"
alias gp="git push"
alias gs="git status"
alias gss="git status -s"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcb="git checkout -b"

alias ompfig="nvim ~/.config/omp/"

alias vim=nvim
alias :q=exit
alias .=clear
alias ..="cd .."
alias vimfig="nvim ~/.config/nvim"
alias config="nvim ~/.zshrc"
alias starfig="nvim ~/.config/starship.toml"
alias src="source ~/.zshrc"
alias wezfig="nvim ~/.wezterm.lua"
alias ghostfig="nvim ~/.config/ghostty/config"
alias l0="layer0"
alias l0local="$GOPATH/bin/layer0 --profile local"
alias kx="kubectx"
alias kn="kubens"
alias k="kubecolor"
alias ls="eza"
alias gi="lazygit"
alias sesh="workspaceizer"
alias opend="opendir.sh"
alias l0test="go run ./cmd/layer0"
alias tasks="~/Work/tools/todo/excecute"
# alias ls=pls
alias kubectl=kubecolor
alias kubesync="layer0 kubeconfig sync"

alias heatmap="git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10"


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

l0space() {
    $(layer0 space get --mine)
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
    export MYSPACE=$(l0 space list --mine --output json --quiet | jq -r '.[0].name')
    layer0 space sync $MYSPACE --layer0-base-ref $(git branch --show-current) --out-of-sync-only "true" --skip-tests --skip-infra --dev
    echo $MYSPACE
}

l0dev() {
    layer0 login dev; layer0 profile select dev
}

hist() {
    local cmd=$(history | fzf --height 40% --reverse | sed -E 's/^[ ]*[0-9]+[ ]+//')
    if [[ -n "$cmd" ]]; then
       LBUFFER="$cmd"
    fi
    zle redisplay
}

portify() {
    sudo lsof -i:$1
}

l0dd() {
    kubectl patch -n datadog daemonset datadog --type='json' -p '[{"op": "replace", "path": "/spec/template/spec/affinity/nodeAffinity/requiredDuringSchedulingIgnoredDuringExecution/nodeSelectorTerms/0/matchExpressions/0/key", "value":"kernel.auth0.com/role"}]';
    kubectl scale -n datadog deploy datadog-cluster-agent --replicas 1;
}

l0dd_off() {
    kubectl patch -n datadog daemonset datadog --type='json' -p '[{"op": "replace", "path": "/spec/template/spec/affinity/nodeAffinity/requiredDuringSchedulingIgnoredDuringExecution/nodeSelectorTerms/0/matchExpressions/0/key", "value":"kernel.auth0.com/role-disabled"}]';
    kubectl scale -n datadog deploy datadog-cluster-agent --replicas 0;
}

l0prod() {
    layer0 "$@" --prod
}

hc() {
    local cmd
    cmd=$(fc -l 1 | awk '{ $1=""; print substr($0,2) }' | awk '!seen[$0]++' | fzf --height 40% --reverse)
    if [ -n "$cmd" ]; then
        echo -n "$cmd" | pbcopy
        echo "Copied cmd: $cmd" 
    fi
}

fwl() {
    if [ -z "$1" ]; then
        echo "Usage: flw <branch-name>"
        return 1
    fi

    local branch="$1"
    local cmd="git push -u origin $branch --force-with-lease"

    echo "Executing: $cmd"
    echo -e "\033[1;33m$cmd\033[0m"  # Highlights command in yellow
    echo -n "Are you sure? (y/N): "
    read -r REPLY

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        eval $cmd
    else
        echo "Aborted!"
    fi
}

l0sync() {
    layer0 space sync $1 --layer0-base-ref $(git branch --show-current) --dev
}

myspace() {
    export MYSPACE=$(layer0 space list --mine --quiet --output json | jq -r '.[0].name')
}

# opam configuration
[[ ! -r /Users/stefan.heller/.opam/opam-init/init.zsh ]] || source /Users/stefan.heller/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Created by `pipx` on 2023-07-06 15:29:01
export PATH="$PATH:/Users/stefan.heller/.local/bin"
eval $(thefuck --alias)

[[ -s "/Users/stefan.heller/.gvm/scripts/gvm" ]] && source "/Users/stefan.heller/.gvm/scripts/gvm"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/etc/autojump.sh

eval "$(direnv hook zsh)" # For other shell read: https://direnv.net/docs/hook.html
# Azure CLI autocomplete (Optional)
autoload bashcompinit && bashcompinit

# ocm:begin
eval "$(ocm handler init)"
# ocm:end



export PATH=$PATH:/Users/stefan.heller/Work/repos/layer0/.tools/istio/bin

###
# Start Task keeping plugin
###
# tasks file:
_ZSH_TASKS_FILE="$HOME/.tasks.txt"

# Helper function to count the number of lines in the task file
_zsh_task_get_count() {
    if [[ -f "$_ZSH_TASKS_FILE" ]]; then
        grep -cvE '^\s*$' "$_ZSH_TASKS_FILE" 2>/dev/null || echo 0
    else
        echo 0
    fi
}
# TODO: Add a function to add tasks to the prompt

# Function to add new task
# usage: task "My new task"
task() {
    if [[ -z "$*" ]]; then
       echo "Usage: task <your task description>"
       echo "Example: task Buy groceries"
       return 1
    fi
    # Ensure the task file exists before appending
    touch "$_ZSH_TASKS_FILE"

    # Append the task to the file
    echo "$*" >> "$_ZSH_TASKS_FILE"

    echo "Task added: '$*'"
    # RPROMPT will be updated by precmd_functions before the next prompt
}

# List tasks
tasklist() {
    if [[ ! -f "$_ZSH_TASKS_FILE" ]] || ! [[ -s "$_ZSH_TASKS_FILE" ]] || [[ $(_zsh_task_get_count) -eq 0 ]]; then
        echo "No tasks yet. Add one with 'task <description>'."
        return
    fi
    echo "Your tasks:"
    # Number lines, but only show non-empty lines from the task file
    awk '!/^\s*$/{ printf "%3d. %s\n", ++n, $0 }' "$_ZSH_TASKS_FILE"
}

# Mark task done
donetask() {
    if [[ ! -f "$_ZSH_TASKS_FILE" ]] || ! [[ -s "$_ZSH_TASKS_FILE" ]] || [[ $(_zsh_task_get_count) -eq 0 ]]; then
        echo "No tasks to mark as done."
        return 1
    fi

    if [[ -z "$1" ]] || ! [[ "$1" =~ ^[0-9]+$ ]] || [[ "$1" -le 0 ]]; then
      echo "Usage: donetask <task_number>"
      echo "Run 'listtasks' to see task numbers."
      return 1
    fi

    local task_to_remove_num=$1
    local current_task_count
    current_task_count=$(_zsh_task_get_count)

    if [[ "$task_to_remove_num" -gt "$current_task_count" ]]; then
      echo "Invalid task number: $task_to_remove_num. There are only $current_task_count tasks."
      listtasks
      return 1
    fi

    # Use awk to remove the specific non-empty line
    # A temporary file is used for safety
    awk -v num_to_delete="$task_to_remove_num" '
      BEGIN { current_line = 0 }
      !/^\s*$/ { # Only process non-empty lines
        current_line++
        if (current_line == num_to_delete) {
          # Skip this line (effectively deleting it)
          printf "Task %d marked as done: %s\n", num_to_delete, $0 > "/dev/stderr"
          next
        }
      }
      { print } # Print all other lines (including empty ones if any)
    ' "$_ZSH_TASKS_FILE" > "${_ZSH_TASKS_FILE}.tmp" && \
    mv "${_ZSH_TASKS_FILE}.tmp" "$_ZSH_TASKS_FILE"

    # RPROMPT will update automatically
}


eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/omp/base.toml)"
