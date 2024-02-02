#!/usr/bin/env bash
install() {
  source /etc/os-release
  local tmp=$(mktemp)
  
  case $ID in
    arch)
      local packages="ttf-hack-nerd git stow tmux"
      # TODO: is there a better way to do this?
      pacman -Qq $packages > /dev/null 2> $tmp > /dev/null
      packages=$(awk '/^error:/ { print substr($3, 2, length($3)-2) }' $tmp)
      echo $packages
      [[ -n $packages ]] && sudo pacman -S $packages
      ;;
    debian|ubuntu) # TODO: not tested
      local packages="git stow tmux" # ttf-hack-nerd ?
      dpkg -s $packages > /dev/null 2> $tmp > /dev/null
      packages=$(awk '/^dpkg-query:/ { print substr($3, 2, length($3)-2) }' $tmp)
      echo $packages
      [[ -n $packages ]] && sudo apt-get install $packages
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
[[ $1 = "install" ]] && install
