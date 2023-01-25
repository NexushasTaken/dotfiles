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
  
  alias e='exa --icons --group-directories-first -s type'
  alias ea='exa --icons --group-directories-first -s type -Fa'
  alias el='exa --icons --group-directories-first -s type -Fl'
  alias et='exa --icons --group-directories-first -s type -FTL=2'
  alias eal='exa --icons --group-directories-first -s type -Fla'
  alias eat='exa --icons --group-directories-first -s type -FaTL=2'
  alias elt='exa --icons --group-directories-first -s type -FlTL=2'
  alias ealt='exa --icons --group-directories-first -s type -FlaTL=2'
# }

# Others {
  confdir=~/dotfiles/bash
  addPath() {
    export PATH="$PATH:$1"
  }
  export JAVA_HOME="/usr/lib/jvm/jdk-17.0.2"
  export EDITOR=nvim
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
  addPath "~/Programs"
  addPath "$HOME/.local/bin/"

  source $confdir/theme.sh
  source $confdir/z.sh
  source ~/.cargo/env 2> /dev/null

  set -o vi
# }
