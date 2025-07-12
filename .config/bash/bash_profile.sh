# vim: ft=bash
export BASH_CONFIG_PATH=$HOME/.config/bash

export HISTCONTROL=ignoredups
export HISTSIZE=-1
export HISTFILESIZE=

export W3M_DIR=~/.config/w3m
export ANDROID_HOME=~/.android
export JAVA_HOME="/usr/lib/jvm/default"
export EDITOR=nvim
export SUDO_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PAGER=less

export PKG_CONFIG_PATH="/usr/local/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/lib/pkgconfig"

# XDG Directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

# QT
export QT_QPA_PLATFORMTHEME=qt6ct

function add_path() {
  local dir="$1"
  [[ -d "$dir" ]] || return 0
  case ":$PATH:" in
    *":$dir:"*)
      ;;  # already in PATH
    *)
      if [[ ! -d $dir ]]; then
        echo "$dir not found or isn't directory"
        return 0
      fi
      PATH+=":$dir"
      ;;
  esac
}
add_path "$ANDROID_HOME/cmdline-tools/latest/bin"
add_path "$JAVA_HOME/bin"
add_path "$HOME/.odin"
add_path "$HOME/.ghcup/bin"
add_path "$HOME/.cargo/bin"
add_path "$HOME/.local/bin"
add_path "$HOME/.nimble/bin"
add_path "$HOME/.local/state/gem/ruby/3.0.0/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
add_path "$BUN_INSTALL/bin"

# ref: https://unix.stackexchange.com/questions/320465/new-tmux-sessions-do-not-source-bashrc-file
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . $HOME/.bashrc
  fi
fi
