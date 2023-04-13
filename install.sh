#!/usr/bin/env bash
DOT=~/dotfiles
mkdir -p ~/.config

linked() {
  dst=${@: -1}
  for i in $(seq 1 $(($#-1))); do
    value=${@: i:1}
    len=$(echo $value | tr ":" "\n" | wc -l)

    if [ $len -eq 1 ]; then
      file=$value
      out=$value
    elif [ $len -eq 2 ]; then
      file=$(echo $value | cut -d ":" -f1)
      out=$(echo $value | cut -d ":" -f2)
    fi
    unset len
    unset value

    dir=$dst/$out
    if [[ ! -a $dir ]]; then
      ln -sf $DOT/$file $dir
    fi
    unset dir
  done
  unset dst
}

dirs="
  bash
  btop
  htop
  rustfmt
  tmux
  clangd
  i3
  i3status
  picom.conf"
fdir="
  .vim
  .xinitrc:.xsessionrc
  .xinitrc
  .gitconfig
  .gdbinit
  .omnisharp
  bash/bashrc.sh:.bashrc
  bash/bashrc.sh:.profile"
linked $fdir ~
linked $dirs $XDG_CONFIG_HOME

# Tmux
TMUX_RESURRECT=$DOT/tmux/plugins/tmux-resurrect
[ -d $TMUX_RESURRECT ] ||
  git clone https://github.com/tmux-plugins/tmux-resurrect $TMUX_RESURRECT

distro=$(grep '^NAME=' /etc/os-release | cut -d '=' -f2- | tr -d '"')

if [[ $distro = "Arch Linux" ]]; then
  package_name=ttf-hack-nerd
  [ -n $(pacman -Qq $package_name) ] ||
    sudo pacman -S $package_name
  unset package_name
fi
