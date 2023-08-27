#!/usr/bin/env bash
source $BASH_CONFIG_PATH/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE='1'
GIT_PS1_SHOWSTASHSTATE='1'
GIT_PS1_SHOWUNTRACKEDFILES='1'
GIT_PS1_HIDE_IF_PWD_IGNORED='1'
GIT_PS1_SHOWUPSTREAM='auto'
GIT_PS1_STATESEPARATOR=
GIT_PS1_SHOWCOLORHINTS='1'
GIT_PS1_COMPRESSSPARSESTATE='1'
GIT_PS1_SHOWCONFLICTSTATE='1'
GIT_PS1_DESCRIBE_STYLE='branch'

function __ps1_to_ansi() {
  printf '\001\e[%sm\002' $1
}

function __ps1_ansi() {
  case "$1" in
    (reset)   __ps1_to_ansi 0;;
    (black)   __ps1_to_ansi 30;;
    (red)     __ps1_to_ansi 31;;
    (green)   __ps1_to_ansi 32;;
    (yellow)  __ps1_to_ansi 33;;
    (blue)    __ps1_to_ansi 34;;
    (magenta) __ps1_to_ansi 35;;
    (cyan)    __ps1_to_ansi 36;;
    (white)   __ps1_to_ansi 37;;
    (orange)  __ps1_to_ansi 38\;5\;166;;
  esac
}

function __ps1_help() {
  print_variable() {
    echo "$(__ps1_ansi yellow)$2$(__ps1_ansi magenta)($1)$(__ps1_ansi white): $(__ps1_ansi green)$3$(__ps1_ansi reset)"
  }
  print_variable 'sds' "GIT_PS1_SHOWDIRTYSTATE" $GIT_PS1_SHOWDIRTYSTATE
  echo "  $(__ps1_ansi red)*$(__ps1_ansi reset) unstaged"
  echo "  $(__ps1_ansi green)+$(__ps1_ansi reset) staged  "
  print_variable 'sss' "GIT_PS1_SHOWSTASHSTATE" $GIT_PS1_SHOWSTASHSTATE
  echo "  $(__ps1_ansi blue)\$$(__ps1_ansi reset) stashed"
  print_variable 'suf' "GIT_PS1_SHOWUNTRACKEDFILES" $GIT_PS1_SHOWUNTRACKEDFILES
  echo "  $(__ps1_ansi red)%$(__ps1_ansi reset) untracked files"
  print_variable 'su' "GIT_PS1_SHOWUPSTREAM" $GIT_PS1_SHOWUPSTREAM
  echo "  < you're behind"
  echo "  > you're ahead"
  echo "  <> you're diverge"
  echo "  = no difference"
  echo "  $(__ps1_ansi orange)values$(__ps1_ansi white): [verbose][,name][,legacy][,git][,svn]"
  print_variable 'cps' "GIT_PS1_COMPRESSSPARSESTATE" $GIT_PS1_COMPRESSSPARSESTATE
  print_variable 'scs' "GIT_PS1_SHOWCONFLICTSTATE" $GIT_PS1_SHOWCONFLICTSTATE
  print_variable 'pds' "GIT_PS1_DESCRIBE_STYLE" $GIT_PS1_DESCRIBE_STYLE
  echo "  $(__ps1_ansi orange)values$(__ps1_ansi white): (contains|branch|describe|tag|default)"
  print_variable 'dg' "PS1_DISABLE_GIT" $PS1_DISABLE_GIT
  print_variable 'dn' "PS1_DIR_NOPARSE" $PS1_DIR_NOPARSE
  print_variable 'ds' "PS1_DIR_SHORTEN" $PS1_DIR_SHORTEN
  print_variable 'rev' "PS1_REVERSE" $PS1_REVERSE
}

function ps1() {
  [[ $1 = '-h' ]] && __ps1_help && return
  while [[ $# -gt 0 ]]; do
    case ${1::1} in
      (-|+|=)
        local flag=${1:1}
        if [[ ${1:0:1} = '-' ]]; then
          local value=
        elif [[ ${1:0:1} = '+' ]]; then
          local value='1'
        elif [[ ${1:0:1} = '=' ]]; then
          local value=$2
          shift
        fi
        echo $value

        case $flag in
          (sds) GIT_PS1_SHOWDIRTYSTATE=$value;;
          (sss) GIT_PS1_SHOWSTASHSTATE=$value;;
          (suf) GIT_PS1_SHOWUNTRACKEDFILES=$value;;
          (su) GIT_PS1_SHOWUPSTREAM=$value;;
          (cps) GIT_PS1_COMPRESSSPARSESTATE=$value;;
          (scs) GIT_PS1_SHOWCONFLICTSTATE=$value;;
          (pds) GIT_PS1_DESCRIBE_STYLE=$value;;
          (dg) PS1_DISABLE_GIT=$value;;
          (dn) PS1_DIR_NOPARSE=$value;;
          (ds) PS1_DIR_SHORTEN=$value;;
          (rev) PS1_REVERSE=$value;;
        esac;;
      (*)
        echo "'$1' flag must starts with + or - or ="
        return 1;;
    esac
    shift
  done
}

function __ps1() {
  local RETVAL=$?
  local git_state=$([[ -n $PS1_DISABLE_GIT ]] && echo "" || __git_ps1 "(%s)")
  local dir=${PWD#$HOME}
  local status=""

  [[ $RETVAL -ne 0 ]] && status+="$(__ps1_ansi red)$RETVAL"
  [[ $UID -eq 0 ]] && status+="$(__ps1_ansi yellow)#"
  [[ $(jobs -l | wc -l) -gt 0 ]] && status+="$(__ps1_ansi cyan)~"
  [[ -n $status ]] && status="[$status$(__ps1_ansi reset)]" || status=""

  local status_git="$git_state$status"


  [[ $dir != $PWD ]] && dir="~$dir"
  if [[ -z $PS1_DIR_NOPARSE ]]; then
    local raw
    [[ -n $status_git ]] && raw=$(printf $status_git | sed "s/$(printf '\001\e[[0-9]*m\002')//g")
    if [[ ${#dir} -gt $(expr $COLUMNS - 3 - ${#raw}) ]]; then
      local base_name=$(basename $dir)
      local dir_name=$(dirname $dir)
      dir=""
      if [[ -n $PS1_DIR_SHORTEN ]]; then
        for base in $(printf $dir_name | tr "/" " "); do
          dir+="${base:0:${PS1_DIR_SHORTEN_LEN-1}}/"
        done
      fi
      dir+="$base_name"
    fi
  fi
  
  local left="$status_git"
  local right="$dir"

  local arrow="$(__ps1_ansi blue)"
  if [[ -n $PS1_REVERSE ]]; then
    localdion temp=$left
    left=$right
    right=$temp
    arrow+="󰁍"
  else
    arrow+="󰁔"
  fi
  arrow+="$(__ps1_ansi reset)"

  [[ -n $left ]] && left+=" $arrow "
  printf '%s%s\n$ ' "$left" "$right"
}
PS1='$(__ps1)'
