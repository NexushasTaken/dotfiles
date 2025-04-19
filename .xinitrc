# vi: ft=sh
source ~/displayrc.sh

xset -dpms # Disable Display Power Management
xset b off # Turn off bell
xset s off # Turn off Screensaver
# xset r rate 300 20 # Keyrepeat
xrdb ~/.Xresources

feh --bg-center ~/.config/wallpapers/bg.png
light -S 0
exec i3
