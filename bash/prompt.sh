#!/usr/bin/env bash
source $HOME/dotfiles/bash/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_SHOWSTASHSTATE=yes
GIT_PS1_SHOWUNTRACKEDFILES=yes
GIT_PS1_HIDE_IF_PWD_IGNORED=yes
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_STATESEPARATOR=
GIT_PS1_SHOWCOLORHINTS=yes
GIT_PS1_COMPRESSSPARSESTATE=yes
GIT_PS1_SHOWCONFLICTSTATE=yes
GIT_PS1_DESCRIBE_STYLE=branch

__ansi() {
  echo -ne '\033['$1'm'
}

__fg_color() {
  case "$1" in
    (black)   echo 30;;
    (red)     echo 31;;
    (green)   echo 32;;
    (yellow)  echo 33;;
    (blue)    echo 34;;
    (magenta) echo 35;;
    (cyan)    echo 36;;
    (white)   echo 37;;
    (orange)  echo 38\;5\;166;;
  esac
}

ps1-help() {
  print_variable() {
    echo "$(__ansi $(__fg_color yellow))$1$(__ansi $(__fg_color white)): $(__ansi $(__fg_color green))$2$(__ansi 0)"
  }
  print_variable "GIT_PS1_SHOWDIRTYSTATE" $GIT_PS1_SHOWDIRTYSTATE
  echo "  $(__ansi $(__fg_color red))*$(__ansi 0) unstaged"
  echo "  $(__ansi $(__fg_color green))+$(__ansi 0) staged  "
  print_variable "GIT_PS1_SHOWSTASHSTATE" $GIT_PS1_SHOWSTASHSTATE
  echo "  $(__ansi $(__fg_color blue))\$$(__ansi 0) stashed"
  print_variable "GIT_PS1_SHOWUNTRACKEDFILES" $GIT_PS1_SHOWUNTRACKEDFILES
  echo "  $(__ansi $(__fg_color red))%$(__ansi 0) untracked files"
  print_variable "GIT_PS1_SHOWUPSTREAM" $GIT_PS1_SHOWUPSTREAM
  echo "  < you're behind"
  echo "  > you're ahead"
  echo "  <> you're diverge"
  echo "  = no difference"
  print_variable "GIT_PS1_COMPRESSSPARSESTATE" $GIT_PS1_COMPRESSSPARSESTATE
  print_variable "GIT_PS1_SHOWCONFLICTSTATE" $GIT_PS1_SHOWCONFLICTSTATE
  print_variable "GIT_PS1_DESCRIBE_STYLE" $GIT_PS1_DESCRIBE_STYLE
  unset print_variable
}

__ps1() {
  local RETVAL=$?
  local ps1=$(__git_ps1 "(%s)")
  local status_str=""

  [[ $RETVAL -ne 0 ]] && status_str+="$(__ansi $(__fg_color red))!"
  [[ $UID -eq 0 ]] && status_str+="$(__ansi $(__fg_color yellow))#"
  [[ $(jobs -lr | wc -l) -gt 0 ]] && status_str+="$(__ansi $(__fg_color cyan))~"
  [[ -n $status_str ]] && status_str="[$status_str$(__ansi 0)]" || status_str=""

  [[ -n $ps1 ]] && ps1+="$status_str $(__ansi $(__fg_color blue))󰁔$(__ansi 0) "

  local dir=${PWD#$HOME}
  [[ $dir != $PWD ]] && dir="~$dir"
  echo "$ps1$dir"
}
PS1='$(__ps1)\n$ '
