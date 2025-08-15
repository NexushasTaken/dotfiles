#!/usr/bin/env bash
# vim: ft=bash

# bashrc guard
if [[ $BASHRC_SOURCED ]] then
  BASHRC_SOURCED=2
  return
fi
BASHRC_SOURCED=1

set -o vi

alias vimrc="cd ~/.config/nvim"
alias x="exit"
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
alias paruz-paru="PARUZ=paru paruz"
if [[ -n "$ANDROID_HOME" && -d "$ANDROID_HOME" ]]; then
  alias sdkmanager="sdkmanager --sdk_root=$ANDROID_HOME"
fi

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

alias vi="nvim"
function vif() {
  local file=$(fzf)
  [[ -n $file ]] && nvim $file || \builtin true
}

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

source $HOME/.cargo/env 2> /dev/null
source $BASH_CONFIG_PATH/local.sh
source $BASH_CONFIG_PATH/cd.sh
source $BASH_CONFIG_PATH/prompt.sh
for file in $(exa $BASH_CONFIG_PATH/completions); do
  source $BASH_CONFIG_PATH/completions/$file
done

