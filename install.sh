#!/usr/bin/env bash
DOT=~/dotfiles
mkdir -p ~/.config
ln -sf $DOT/alacritty/ ~/.config/
ln -sf $DOT/bash/ ~/.config/
ln -sf $DOT/btop/ ~/.config/
ln -sf $DOT/fonts/ ~/.config/
ln -sf $DOT/htop/ ~/.config/
ln -sf $DOT/nvim/ ~/.config/
ln -sf $DOT/rofi/ ~/.config/
ln -sf $DOT/rustfmt/ ~/.config/
ln -sf $DOT/tmux/ ~/.config/
ln -sf $DOT/i3/ ~/.config/

ln -sf $DOT/.vim ~/.vim
ln -sf $DOT/.xinitrc ~/.xsessionrc
ln -sf $DOT/.xinitrc ~/.xinitrc
ln -sf $DOT/.gitconfig ~/.gitconfig
ln -sf $DOT/.gdbinit ~/.gdbinit
ln -sf $DOT/.omnisharp ~/.omnisharp
ln -sf $DOT/bash/bashrc.sh ~/.bashrc
ln -sf $DOT/bash/bashrc.sh ~/.profile

sudo pacman -S ttf-hack-nerd

# Tmux
TMUX_RESURRECT=$DOT/tmux/plugins/tmux-resurrect
[ -d $TMUX_RESURRECT ] ||
  git clone https://github.com/tmux-plugins/tmux-resurrect $DOT/tmux/plugins/tmux-resurrect
