#!/usr/bin/env bash
install() {
  source /etc/os-release
  local tmp=$(mktemp)
  
  case $ID in
    arch)
      local packages="ttf-hack-nerd git stow tmux"
      # TODO: is there a better way to do this?
      pacman -Qq $packages > /dev/null 2> $tmp > /dev/null
      pkgs=$(awk '/^error:/ { print substr($3, 2, 1) }' $tmp)
      [[ -n $pkgs ]] && sudo pacman -S $pkgs
      ;;
    debian|ubuntu)
      local packages="git stow tmux" # ttf-hack-nerd ?
      ;;
    *);;
  esac

  # Tmux
  TMUX_RESURRECT=$HOME/.config/tmux/plugins/tmux-resurrect
  [ -d $TMUX_RESURRECT ] ||
    git clone --depth 1 https://github.com/tmux-plugins/tmux-resurrect $TMUX_RESURRECT
  rm $tmp
}

stow .
$1 = "install" && install
