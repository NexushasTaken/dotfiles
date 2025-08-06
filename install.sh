#!/usr/bin/env bash
set -e

clone() {
  local url=$1
  shift
  local path=$2
  shift

  if [[ ! -d $path ]]; then
    mkdir -p $(dirname $path)
    git clone --depth 1 "$url" "$path" $@
  fi
  echo "$path"
}

git-clone() {
  clone https://github.com/Jazqa/adwaita-tweaks.git $HOME/.themes/'Adwaita Tweaks Dark' -b dark
  clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.config/tmux/plugins/tmux-resurrect
  clone https://github.com/vinceliuice/Fluent-gtk-theme $HOME/.local/share/themes/.temp/Fluent-gtk-theme
  clone https://github.com/cbrnix/Flatery $HOME/.local/share/icons/.temp/Flatery
}

install() {
  source /etc/os-release
  local tmp=$(mktemp)

  case $ID in
    arch)
      local packages="ttf-hack-nerd git stow tmux dunst kitty dex rofi"
      local aur_packages="phinger-cursors"
      # TODO: is there a better way to do this?
      sudo pacman -Qq $packages > /dev/null 2> $tmp > /dev/null
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

  git-clone

  rm $tmp

  if [[ ! -a '/etc/systemd/system/kanata.service' ]]; then
    sudo cp -vuf ~/.config/kanata/files/kanata.service /etc/systemd/system/kanata.service
    sudo systemctl daemon-reload
  fi

  if [[ -d "$HOME/.local/share/themes/.temp/Fluent-gtk-theme" ]]; then
    pushd ~/.local/share/themes/.temp/Fluent-gtk-theme
      ./install.sh -t all -c dark -s compact -i arch --tweaks square
    popd
  fi

  if [[ -d "$HOME/.local/share/icons/.temp/Flatery" ]]; then
    pushd $HOME/.local/share/icons/.temp/Flatery
      ./install.sh
    popd
  fi
}

stow .
case $1 in
  install)
    install
    ;;
  clone)
    git-clone
    ;;
  *)
    echo "$0 [install|clone]"
    ;;
esac
