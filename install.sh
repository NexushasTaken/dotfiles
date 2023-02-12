#!/usr/bin/env bash
DOT=~/dotfiles
mkdir -p ~/.config
directories="bash btop htop rustfmt tmux clangd"
for dir in $directories; do
  ln -sf $DOT/$dir/ ~/.config/
done

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
