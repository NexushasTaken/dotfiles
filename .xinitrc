# vi: ft=sh
dotfiles=~/dotfiles

source $dotfiles/mouserc.sh

xset -dpms # Disable Display Power Management
xset b off # Turn off bell
xset s off # Turn off Screensaver
# xset r rate 300 20 # Keyrepeat
xrdb $dotfiles/.Xresources

feh --bg-center $dotfiles/wallpapers/bg.png
light -S 0
exec i3
