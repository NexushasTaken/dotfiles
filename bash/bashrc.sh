#!/usr/bin/env bash
# vim: ft=bash
main() {
  local bash_path=$HOME/dotfiles/bash
  add_path() {
    if [[ ! -d $1 ]]; then
      echo "$1 not found or isn't directory" 
      return 0
    fi
    PATH+=":$1"
  }
  add_path "$JAVA_HOME/bin"
  add_path "$HOME/.ghcup/bin"
  add_path "$HOME/.cargo/bin"
  add_path "$HOME/.local/bin"
  add_path "$HOME/.local/state/gem/ruby/3.0.0/bin"

  export PKG_CONFIG_PATH=/usr/local/pkgconfig
  export JAVA_HOME="/usr/lib/jvm/default"
  export EDITOR=nvim
  export SUDO_EDITOR=$EDITOR
  export VISUAL=$EDITOR
  export PAGER=less
  export HISTCONTROL=ignoredups
  export HISTSIZE=-1
  export HISTFILESIZE=

  # XDG Directories
  export XDG_CONFIG_HOME=$HOME/.config
  export XDG_CACHE_HOME=$HOME/.cache
  export XDG_DATA_HOME=$HOME/.local/state
  export XDG_STATE_HOME=$HOME/.local/state
  export XDG_DATA_DIRS=/usr/local/share:/usr/share
  export XDG_CONFIG_DIRS=/etc/xdg

  source $bash_path/local.sh
  source $HOME/.cargo/env 2> /dev/null
  source $bash_path/cd.sh
  source $bash_path/prompt.sh
  for file in $(exa $bash_path/completions); do
    source $bash_path/completions/$file
  done

  set -o vi

  alias vimrc="cd ~/.config/nvim"
  alias cd="cd -P"
  alias x="exit"
  alias vi="nvim"
  function vif() {
    local file=$(fzf)
    [[ -n $file ]] && nvim $file || \builtin true
  }
  alias man="man --nh --nj"
  alias less="less -Rn --mouse"
  alias pacman="sudo pacman"
  alias mv="mv -v"
  alias cp="cp -v"
  alias rm="rm"
  alias ln="ln -v"
  alias make="make -j 2"
  alias gdb="gdb -q"
  
  local exaflags="--classify --extended --color-scale --icons --group-directories-first --group --sort=type"
  alias e="exa $exaflags"
  alias ea="exa $exaflags --all"
  alias el="exa $exaflags --long"
  alias eal="exa $exaflags --long -a"
  alias et="exa $exaflags --tree --level=2"
  alias eat="exa $exaflags --tree --level=2 --all"
  alias elt="exa $exaflags --tree --level=2 --long"
  alias ealt="exa $exaflags --tree --level=2 --all --long"

  clear-tmux() {
    $(which clear)
    [[ -n $TMUX ]] && tmux clear-history
    return 0
  }
  clear-reset() {
    clear-tmux
    reset
    return 0
  }
  clear-history() {
    [[ -a $HISTFILE ]] && rm $HISTFILE
    return 0
  }
  mkcd() {
    mkdir $1 && cd $1
  }
  alias clear="clear-tmux"
  alias c="clear-tmux"
  alias cr="clear-reset"
}
main
unset main
