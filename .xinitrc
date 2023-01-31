# vi: ft=sh
dotfiles=~/dotfiles
xinput --set-prop 'USB OPTICAL MOUSE' 'libinput Accel Speed' -0.7 # Adjust mouse speed
xinput --set-prop 'USB OPTICAL MOUSE' 'libinput Accel Profile Enabled' 0 0  # Disable mouse acceleration
# SynPS/2 Synaptics TouchPad {
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Tapping Enabled' 1
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Tapping Drag Lock Enabled' 1
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Accel Profile Enabled' 0 0
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Accel Speed' -0.2
# }
feh --bg-center ${dotfiles}/wallpapers/bg.png
xrdb ${dotfiles}/.Xresources
setxkbmap -option caps:escape

xset b off # Turn off bell
xset s off # Turn off Screensaver
xset -dpms # Disable Display Power Management
xset r rate 400 20 # Change Keyrepeat

slstatus &
exec dwm
