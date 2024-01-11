#!/usr/bin/env bash

DOTFILE_DIR=$(dirname $(realpath $BASH_SOURCE))
UNAME_OS=$(uname -o | tr '[:upper:]' '[:lower:]')
CONFIG=${XDG_CONFIG_HOME:-$HOME/.config}

check_dev_mode() {
  reg_path='HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
  reg_key='AllowDevelopmentWithoutDevLicense'
  [[ $UNAME_OS = "msys" ]] &&
    DOTFILE_DEV_MODE=$(reg query $reg_path -v $reg_key | grep -c '0x1')
  DOTFILE_DEV_MODE=${DOTFILE_DEV_MODE:-1}

  if [[ $DOTFILE_DEV_MODE -ne 1 ]]; then
    echo "Developer Mode is not enabled"
    echo "enable it by going to Settings > Update & Security > For developers > Developer Mode"
    exit 1
  fi
}

# TODO: Handle errors?
run_cmd() {
  echo $@ | cmd
}

mklink() {
  target=$(cygpath -w $1)
  destin=$(cygpath -w $2)

  if [[ ! -a $target ]]; then
    echo "$target doesn't exist"
    return 1
  fi
  if [[ -a $destin ]]; then
    echo "$destin already exist, skipping..."
    return
  fi

  case $UNAME_OS in
    linux*)
      ln -sf $target $destin
      ;;
    msys)
      if [[ -d $target ]]; then
        run_cmd "mklink /D $destin $target" | sed -n '5p'
      else
        run_cmd "mklink $destin $target" | sed -n '5p'
      fi
      ;;
    *) echo "unhandled $UNAME_OS";;
  esac
}

mkdir -p ~/.config

# target:destination[:alias]...
linked() {
  for value in $@; do
    local len=$(echo $value | tr ":" "\n" | wc -l)
    if [[ $len -eq 2 || $len -eq 3 ]]; then
      file=$DOTFILE_DIR/$(echo $value | cut -d ":" -f1)
      out=$(echo $value | cut -d ":" -f2)

      if [[ $len -eq 3 ]]; then
        out=$out/$(echo $value | cut -d ":" -f3)
      else
        out=$out/$(basename $file)
      fi
      [[ -n $DEBUG_RUN ]] && echo out : $out
      [[ -n $DEBUG_RUN ]] && echo file: $file
      [[ -z $DEBUG_RUN ]] && echo "$out"

      $DEBUG_RUN mklink $file $out
      [[ -n $DEBUG_RUN ]] && echo
    else
      echo "invalid argument $value"
      exit 1
    fi
  done
}

case $UNAME_OS in
  msys)
    dirs="
      gdb:$CONFIG
      bash:$CONFIG"
    fdir="
      .gitconfig:$HOME
      bash/bashrc.sh:$HOME:.bashrc
      bash/bashrc.sh:$HOME:.profile"
    ;;
  linux*)
    dirs="
      gdb:$CONFIG
      bash:$CONFIG
      btop:$CONFIG
      htop:$CONFIG
      rustfmt:$CONFIG
      tmux:$CONFIG
      clangd:$CONFIG
      i3:$CONFIG
      i3status:$CONFIG
      bat:$CONFIG
      picom.conf:$CONFIG"
    fdir="
      .vim:$HOME
      .xinitrc:$HOME:.xsessionrc
      .xinitrc:$HOME
      .gitconfig:$HOME
      .omnisharp:$HOME
      .Xresources:$HOME
      .inputrc:$HOME
      bash/bashrc.sh:$HOME:.bashrc
      bash/bashrc.sh:$HOME:.profile"
    ;;
  *)
    echo "unhandled $UNAME_OS"
    ;;
esac

linked $fdir
linked $dirs

exit

# Tmux
TMUX_RESURRECT=$DOTFILE_DIR/tmux/plugins/tmux-resurrect
[ -d $TMUX_RESURRECT ] ||
  echo git clone https://github.com/tmux-plugins/tmux-resurrect $TMUX_RESURRECT

distro=$(grep '^NAME=' /etc/os-release | cut -d '=' -f2- | tr -d '"')

if [[ $distro = "Arch Linux" ]]; then
  package_name=ttf-hack-nerd
  [ -n $(pacman -Qq $package_name) ] ||
    sudo pacman -S $package_name
fi
