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
  printf '\001\e['$1'm\002'
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
  print_variable "PS1_DIR_NOPARSE" $PS1_DIR_NOPARSE
  print_variable "PS1_DIR_SHORTEN" $PS1_DIR_SHORTEN
  print_variable "PS1_REVERSE" $PS1_REVERSE
  unset print_variable
}

__ps1() {
  local RETVAL=$?
  local git_state=$(__git_ps1 "(%s)")
  local dir=${PWD#$HOME}
  local status=""

  [[ $RETVAL -ne 0 ]] && status+="$(__ansi $(__fg_color red))$RETVAL"
  [[ $UID -eq 0 ]] && status+="$(__ansi $(__fg_color yellow))#"
  [[ $(jobs -l | wc -l) -gt 0 ]] && status+="$(__ansi $(__fg_color cyan))~"
  [[ -n $status ]] && status="[$status$(__ansi 0)]" || status=""

  local status_git="$git_state$status"


  [[ $dir != $PWD ]] && dir="~$dir"
  if [[ -z $PS1_DIR_NOPARSE ]]; then
    local raw=$(echo $status_git | sed "s/$(printf '\001\e[[0-9]*m\002')//g")
    if [[ ${#dir} -gt $(expr $COLUMNS - 3 - ${#raw}) ]]; then
      local base_name=$(basename $dir)
      local dir_name=$(dirname $dir)
      dir=""
      if [[ -n $PS1_DIR_SHORTEN ]]; then
        for base in $(echo $dir_name | tr "/" " "); do
          dir+="${base:0:${PS1_DIR_SHORTEN_LEN-1}}/"
        done
      fi
      dir+="$base_name"
    fi
  fi
  
  local left="$status_git"
  local right="$dir"

  local arrow="$(__ansi $(__fg_color blue))"
  if [[ -n $PS1_REVERSE ]]; then
    local temp=$left
    left=$right
    right=$temp
    arrow+="󰁍"
  else
    arrow+="󰁔"
  fi
  arrow+="$(__ansi 0)"

  [[ -n $left ]] && left+=" $arrow "
  printf '%s%s\n$ ' "$left" "$right"
}
PS1='$(__ps1)'
