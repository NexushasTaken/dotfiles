#!/usr/bin/env bash
DOT=~/dotfiles

mkdir -p ~/.config

linked() {
  local dst=${@: -1}
  for i in $(seq 1 $(($#-1))); do
    local value=${@: i:1}
    local len=$(echo $value | tr ":" "\n" | wc -l)

    if [ $len -eq 1 ]; then
      file=$value
      out=$value
    elif [ $len -eq 2 ]; then
      file=$(echo $value | cut -d ":" -f1)
      out=$(echo $value | cut -d ":" -f2)
    fi

    local dir=$dst/$out
    if [[ ! -a $dir && -a $DOT/$file ]]; then
      echo "$dir"
      ln -sf $DOT/$file $dir
    fi
  done
}

dirs="
  gdb
  bash
  btop
  htop
  rustfmt
  tmux
  clangd
  i3
  i3status
  bat
  picom.conf"
fdir="
  .vim
  .xinitrc:.xsessionrc
  .xinitrc
  .gitconfig
  .omnisharp
  .Xresources
  .inputrc
  bash/bashrc.sh:.bashrc
  bash/bashrc.sh:.profile"
linked $fdir $HOME
linked $dirs ${XDG_CONFIG_HOME:-$HOME/.config}

# Tmux
TMUX_RESURRECT=$DOT/tmux/plugins/tmux-resurrect
[ -d $TMUX_RESURRECT ] ||
  git clone https://github.com/tmux-plugins/tmux-resurrect $TMUX_RESURRECT

distro=$(grep '^NAME=' /etc/os-release | cut -d '=' -f2- | tr -d '"')

if [[ $distro = "Arch Linux" ]]; then
  package_name=ttf-hack-nerd
  [ -n $(pacman -Qq $package_name) ] ||
    sudo pacman -S $package_name
fi
