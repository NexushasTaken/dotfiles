#!/usr/bin/env bash
#vim: ft=bash
# Aliases {
  alias vimrc='cd ~/.config/nvim'
  alias x='exit'
  
  alias e='exa --icons --group-directories-first -s type'
  alias ea='exa --icons --group-directories-first -s type -Fa'
  alias el='exa --icons --group-directories-first -s type -Fl'
  alias et='exa --icons --group-directories-first -s type -FTL=2'
  alias eal='exa --icons --group-directories-first -s type -Fla'
  alias eat='exa --icons --group-directories-first -s type -FaTL=2'
  alias elt='exa --icons --group-directories-first -s type -FlTL=2'
  alias ealt='exa --icons --group-directories-first -s type -FlaTL=2'

  alias man='man --nh --nj'
  
  alias vi='nvim'
  alias vif='nvim $(fzf)'

  alias cd='cd -P'
  
#  alias screenkey='screenkey --opacity 0.50 -s small -f "Hack NF" -g 302x109+447+858 -p fixed --compr-cnt 3'
  alias less='less -Rn --mouse'
  alias py3='python3'
# }

# Others {
  addPath() {
    export PATH="$PATH:$1"
  }
  export JAVA_HOME="/usr/lib/jvm/jdk-17.0.2"
  export EDITOR=nvim
  export VISUAL=$EDITOR

  addPath "~/Libraries/lua-language-server/bin"
  addPath "~/Libraries/jdtls/bin"
  addPath "${JAVA_HOME}/bin"
  addPath "~/.cargo/bin"
  addPath "/opt/gradle/gradle-7.5.1/bin"
  addPath "/home/linuxbrew/.linuxbrew/bin"
  addPath "~/Programs"

  set -o vi
  confdir=~/dotfiles/bash
  source $confdir/theme.sh
  source $confdir/z.sh
  source ~/.cargo/env

  export HISTCONTROL=erasedups
  export HISTSIZE=-1
  export HISTFILESIZE=
# }

# less color {
  export LESS="--RAW-CONTROL-CHARS"
  export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
  export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
  export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
  export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
  export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
  export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
  export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
# }
. "$HOME/.cargo/env"
export PATH="$HOME/.local/bin/:$PATH"
