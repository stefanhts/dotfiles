export PYENV_ROOT="$HOME/.pyenv"
ZSH_THEME="spaceship"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init --path)"
fi
autoload -U colors && colors

# export PS1="%{$fg[cyan]%}(%n%) %{$reset_color%}%{$fg[blue]%}%1d %{$reset_color%}%{$fg[green]%}↠%{$reset_color%} %{$fg[magenta]%}"
export PS1="%{$fg[blue]%}%1d %{$reset_color%}%{$fg[green]%}↠%{$reset_color%} %{$fg[magenta]%}"
export PS2="%{$fg[magenta]%}%{$reset_color%}"
# opam configuration
[[ ! -r /Users/stefan/.opam/opam-init/init.zsh ]] || source /Users/stefan/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
alias vim="nvim"
alias vi="nvim"
alias .="clear"
alias kk="tmux"
