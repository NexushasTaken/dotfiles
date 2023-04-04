#!/usr/bin/env bash
#vim: ft=bash
# Aliases {
  alias vimrc='cd ~/.config/nvim'
  alias cd='cd -P'
  alias x='exit'
  alias c='clear'
  alias vi='nvim'
  alias vif='nvim $(fzf)'
  alias man='man --nh --nj'
  alias less='less -Rn --mouse'
  alias pacman='sudo pacman'
  alias mv='mv -nv'
  alias cp='cp -v'
  
  exaflags='--icons --group-directories-first -gs type'
  alias e="exa $exaflags"
  alias ea="exa $exaflags -Fa"
  alias el="exa $exaflags -Fl"
  alias et="exa $exaflags -FTL=2"
  alias eal="exa $exaflags -Fla"
  alias eat="exa $exaflags -FaTL=2"
  alias elt="exa $exaflags -FlTL=2"
  alias ealt="exa $exaflags -FlaTL=2"
# }

# Others {
  confdir=~/dotfiles/bash
  addPath() {
    export PATH="$PATH:$1"
  }
  export JAVA_HOME="/usr/lib/jvm/jdk-17.0.2"
  export EDITOR=nvim
  export SUDO_EDITOR=$EDITOR
  export VISUAL=$EDITOR
  export HISTCONTROL=erasedups
  export HISTSIZE=-1
  export HISTFILESIZE=

  addPath "~/Libraries/lua-language-server/bin"
  addPath "~/Libraries/jdtls/bin"
  addPath "$JAVA_HOME/bin"
  addPath "~/.cargo/bin"
  addPath "/opt/gradle/gradle-7.5.1/bin"
  addPath "/home/linuxbrew/.linuxbrew/bin"
  addPath "$HOME/Programs/zig/"
  addPath "$HOME/.cabal/bin"
  addPath "$HOME/.ghcup/bin"
  addPath "~/Programs"

  source $confdir/theme.sh
  source $confdir/z.sh
  source $confdir/arduino-completion.sh
  source ~/.cargo/env 2> /dev/null

  set -o vi
# }
