#!/usr/bin/env bash
# vim: ft=bash
export BASH_CONFIG_PATH=$HOME/.config/bash
__bash_main() {
  export ANDROID_HOME=~/.android
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

  source $BASH_CONFIG_PATH/local.sh
  source $HOME/.cargo/env 2> /dev/null
  source $BASH_CONFIG_PATH/cd.sh
  source $BASH_CONFIG_PATH/prompt.sh
  for file in $(exa $BASH_CONFIG_PATH/completions); do
    source $BASH_CONFIG_PATH/completions/$file
  done

  function add_path() {
    if [[ ! -d $1 ]]; then
      echo "$1 not found or isn't directory"
      return 0
    fi
    PATH+=":$1"
  }
  add_path "$JAVA_HOME/bin"
  add_path "$HOME/.odin"
  add_path "$HOME/.ghcup/bin"
  add_path "$HOME/.cargo/bin"
  add_path "$HOME/.local/bin"
  add_path "$HOME/.nimble/bin"
  add_path "$HOME/.local/state/gem/ruby/3.0.0/bin"
  add_path "$ANDROID_HOME/cmdline-tools/latest/bin"

  # bun
  export BUN_INSTALL="$HOME/.bun"
  add_path "$BUN_INSTALL/bin"

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
  alias paruz-yay="PARUZ=yay paruz"
  
  local exaflags="--classify --extended --color-scale --icons --group-directories-first --group --sort=type"
  alias e="exa $exaflags"
  alias ea="exa $exaflags --all"
  alias el="exa $exaflags --long"
  alias eal="exa $exaflags --long -a"
  alias et="exa $exaflags --tree --level=2"
  alias eat="exa $exaflags --tree --level=2 --all"
  alias elt="exa $exaflags --tree --level=2 --long"
  alias ealt="exa $exaflags --tree --level=2 --all --long"

  function clear-tmux() {
    $(which clear)
    [[ -n $TMUX ]] && tmux clear-history
    return 0
  }
  function clear-reset() {
    clear-tmux
    reset
    return 0
  }
  function clear-history() {
    [[ -a $HISTFILE ]] && rm -f $HISTFILE
    return 0
  }
  function clear-hard() {
    clear-reset
    clear-history
  }
  function mkcd() {
    mkdir $1 && cd $1
  }
  alias clear="clear-tmux"
  alias c="clear-tmux"
  alias cr="clear-reset"
}
__bash_main
