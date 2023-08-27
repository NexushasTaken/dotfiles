#!/usr/bin/env bash
source $BASH_CONFIG_PATH/git-prompt.sh
GIT_PS1_HIDE_IF_PWD_IGNORED='1'
GIT_PS1_SHOWCOLORHINTS='1'
GIT_PS1_STATESEPARATOR=''
GIT_PS1_SHOWDIRTYSTATE='1'
GIT_PS1_SHOWSTASHSTATE='1'
GIT_PS1_SHOWUNTRACKEDFILES='1'
GIT_PS1_SHOWUPSTREAM='auto'
GIT_PS1_COMPRESSSPARSESTATE='1'
GIT_PS1_SHOWCONFLICTSTATE='1'
GIT_PS1_DESCRIBE_STYLE='branch'
PS1_DISABLE_GIT=''
PS1_DIR_PARSE='1'
PS1_DIR_SHORTEN=''

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

function __print_variable() {
  local out
  out+="$(__ps1_ansi yellow)$1"
  out+="$(__ps1_ansi magenta)($3)"
  out+="$(__ps1_ansi white): "
  out+="$(__ps1_ansi blue)$4"
  out+="$(__ps1_ansi reset) = "
  if [[ $4 = 'bool' ]]; then
    out+="$(__ps1_ansi orange)"
    if [[ $2 = '1' ]]; then
      out+='true'
    elif [[ -z $2 ]]; then
      out+='false'
    fi
  else
    out+="$(__ps1_ansi green)$2"
  fi
  echo "$out$(__ps1_ansi reset)"
}

function __ps1_help() {
  # $1 = Variable name
  # $2 = Variable value
  # $3 = Variable flag
  # $4 = Variable type
  __print_variable "GIT_PS1_HIDE_IF_PWD_IGNORED" "$GIT_PS1_HIDE_IF_PWD_IGNORED" 'hipi' 'bool'
  __print_variable "GIT_PS1_SHOWCOLORHINTS" "$GIT_PS1_SHOWCOLORHINTS" 'sch' 'bool'
  __print_variable "GIT_PS1_STATESEPARATOR" "$GIT_PS1_STATESEPARATOR" 'ss' 'str'
  __print_variable "GIT_PS1_SHOWDIRTYSTATE" "$GIT_PS1_SHOWDIRTYSTATE" 'sds' 'bool'
  echo "  $(__ps1_ansi red)*$(__ps1_ansi reset) unstaged"
  echo "  $(__ps1_ansi green)+$(__ps1_ansi reset) staged  "
  __print_variable "GIT_PS1_SHOWSTASHSTATE" "$GIT_PS1_SHOWSTASHSTATE" 'sss' 'bool'
  echo "  $(__ps1_ansi blue)\$$(__ps1_ansi reset) stashed"
  __print_variable "GIT_PS1_SHOWUNTRACKEDFILES" "$GIT_PS1_SHOWUNTRACKEDFILES" 'suf' 'bool'
  echo "  $(__ps1_ansi red)%$(__ps1_ansi reset) untracked files"
  __print_variable "GIT_PS1_SHOWUPSTREAM" "$GIT_PS1_SHOWUPSTREAM" 'su' 'list'
  echo "  < you're behind"
  echo "  > you're ahead"
  echo "  <> you're diverge"
  echo "  = no difference"
  echo "  $(__ps1_ansi orange)values$(__ps1_ansi white): [verbose][,name][,legacy][,git][,svn]"
  __print_variable "GIT_PS1_COMPRESSSPARSESTATE" "$GIT_PS1_COMPRESSSPARSESTATE" 'cps' 'bool'
  __print_variable "GIT_PS1_SHOWCONFLICTSTATE" "$GIT_PS1_SHOWCONFLICTSTATE" 'scs' 'bool'
  __print_variable "GIT_PS1_DESCRIBE_STYLE" "$GIT_PS1_DESCRIBE_STYLE" 'pds' 'selection'
  echo "  $(__ps1_ansi orange)values$(__ps1_ansi white): (contains|branch|describe|tag|default)"
  __print_variable "PS1_DISABLE_GIT" "$PS1_DISABLE_GIT" 'dg' 'bool'
  __print_variable "PS1_DIR_PARSE" "$PS1_DIR_PARSE" 'dn' 'bool'
  __print_variable "PS1_DIR_SHORTEN" "$PS1_DIR_SHORTEN" 'ds' 'bool'
  echo "- set to false"
  echo "+ set to true"
  echo "= set a value"
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

        case $flag in
          (sds) GIT_PS1_SHOWDIRTYSTATE=$value;;
          (sss) GIT_PS1_SHOWSTASHSTATE=$value;;
          (suf) GIT_PS1_SHOWUNTRACKEDFILES=$value;;
          (su) GIT_PS1_SHOWUPSTREAM=$value;;
          (cps) GIT_PS1_COMPRESSSPARSESTATE=$value;;
          (scs) GIT_PS1_SHOWCONFLICTSTATE=$value;;
          (pds) GIT_PS1_DESCRIBE_STYLE=$value;;
          (dg) PS1_DISABLE_GIT=$value;;
          (dp) PS1_DIR_PARSE=$value;;
          (ds) PS1_DIR_SHORTEN=$value;;
          (*)
            echo "unknown '$flag' flag"
            return 1
        esac;;
      (*)
        echo "'$1' flag must starts with + or - or ="
        return 1;;
    esac
    shift
  done
}

function __ps1_unansi() {
  echo $1 | sed "s/$(printf '\001\e[[0-9]*m\002')//g"
}

function __ps1() {
  local RETVAL=$?

  # git: Git {
  local git_state=$([[ -n $PS1_DISABLE_GIT ]] && echo "" || __git_ps1 "(%s)")
  # }

  # stat: Status {
  local status
  [[ $RETVAL -ne 0 ]] && status+="$(__ps1_ansi red)$RETVAL"
  [[ $UID -eq 0 ]] && status+="$(__ps1_ansi yellow)#"
  [[ $(jobs -l | wc -l) -gt 0 ]] && status+="$(__ps1_ansi cyan)~"
  [[ -n $status ]] && status="[$status$(__ps1_ansi reset)]"
  # }

  # gas: Git state And Status (git|stat) {
  local gas="$git_state$status"
  local gas_raw=$(__ps1_unansi $gas)
  local gas_len=${#gas_raw}
  # }

  # sep: Separator (gas) {
  local separator
  local separator_len
  [[ -z $gas_raw ]] && separator+='' || separator+=' 󰁔'
  separator+=' '
  separator_len=${#separator}
  separator="$(__ps1_ansi blue)$separator$(__ps1_ansi reset)"
  # }

  # dir: Directory (sep|raw) {
  local dir=${PWD#$HOME}
  [[ $dir != $PWD ]] && dir="~$dir"
  if [[ -n $PS1_DIR_PARSE ]]; then
    if [[ ${#dir} -gt $(expr $COLUMNS - $separator_len - ${#gas_raw}) ]]; then
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
  # }
  printf "$gas$separator$dir\n\$ "
}
PS1='$(__ps1)'
