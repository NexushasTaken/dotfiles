#!/usr/bin/env bash
#vim: ft=bash
# Others {
  confdir=$HOME/dotfiles/bash
  addPath() {
    export PATH="$PATH:$1"
  }
  export JAVA_HOME="/usr/lib/jvm/default"
  export EDITOR=nvim
  export SUDO_EDITOR=$EDITOR
  export VISUAL=$EDITOR
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

  addPath "$JAVA_HOME/bin"
  addPath "$HOME/programs/zig/"
  addPath "$HOME/.ghcup/bin"
  addPath "$HOME/.cargo/bin"
  addPath "$HOME/programs"

  export THEME=$confdir/theme.sh
  if [[ -f $THEME ]]; then
    export DEFAULT_USER=`whoami`
    source $THEME
  fi
  source $confdir/z.sh
  source $HOME/.cargo/env 2> /dev/null
  for file in $(exa $confdir/completions); do
    source $confdir/completions/$file
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
    clear
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
  alias clear="clear-tmux"
  alias c="clear-tmux"
  alias cr="clear-reset"
# }
