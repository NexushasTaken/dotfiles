# vi: ft=sh
dotfiles=~/dotfiles
xinput --set-prop 8 'libinput Accel Speed' -0.6 # Adjust mouse speed
xinput --set-prop 8 'libinput Accel Profile Enabled' 0 0  # Disable mouse acceleration
feh --bg-center ${dotfiles}/.wallpaper.png
xrdb ${dotfiles}/.Xresources
setxkbmap -option caps:escape

xset b off # Turn off bell
xset s off # Turn off Screensaver
xset -dpms # Disable Display Power Management
xset r rate 500 30 # Change Keyrepeat

slstatus &
firefox &
exec dwm
