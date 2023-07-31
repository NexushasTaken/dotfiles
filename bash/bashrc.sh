#!/usr/bin/env bash
#vim: ft=bash
# Others {
  bash_path=$HOME/dotfiles/bash
  addPath() {
    if [[ ! -d $1 ]]; then
      echo "$1 not found or isn't directory" 
      return 0
    fi
    export PATH="$PATH:$1"
  }
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

  export PKG_CONFIG_PATH=/usr/local/pkgconfig

  addPath "$JAVA_HOME/bin"
  addPath "$HOME/.ghcup/bin"
  addPath "$HOME/.cargo/bin"
  addPath "$HOME/.local/bin"
  addPath "$HOME/.local/state/gem/ruby/3.0.0/bin"

  export THEME=$bash_path/theme.sh
  if [[ -f $THEME ]]; then
    export DEFAULT_USER=$(whoami)
    source $THEME
  fi
  source $bash_path/z.sh
  source $HOME/.cargo/env 2> /dev/null
  for file in $(exa $bash_path/completions); do
    source $bash_path/completions/$file
  done

  set -o vi
# }

# Aliases {
  alias vimrc="cd ~/.config/nvim"
  alias cd="cd -P"
  alias x="exit"
  alias vi="nvim"
  alias vif='nvim $(fzf)'
  alias man="man --nh --nj"
  alias less="less -Rn --mouse"
  alias pacman="sudo pacman"
  alias mv="mv -v"
  alias cp="cp -v"
  alias rm="rm"
  alias ln="ln -v"
  alias make="make -j 2"
  alias gdb="gdb -q"
  
  exaflags="--classify --extended --color-scale --icons --group-directories-first --group --sort=type"
  alias e="exa $exaflags"
  alias ea="exa $exaflags --all"
  alias el="exa $exaflags --long"
  alias eal="exa $exaflags --long -a"
  alias et="exa $exaflags --tree --level=2"
  alias eat="exa $exaflags --tree --level=2 --all"
  alias elt="exa $exaflags --tree --level=2 --long"
  alias ealt="exa $exaflags --tree --level=2 --all --long"
  unset exaflags

  clear-tmux() {
    /usr/bin/clear
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
# }
