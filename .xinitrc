# vi: ft=sh
dotfiles=~/dotfiles

local mouse_device='YICHIP Wireless Device Mouse'
xinput --set-prop $mouse_device 'libinput Accel Speed' -0.6
xinput --set-prop $mouse_device 'libinput Accel Profile Enabled' 0 0

xset -dpms # Disable Display Power Management
xset b off # Turn off bell
xset s off # Turn off Screensaver
# xset r rate 300 20 # Keyrepeat
xrdb $dotfiles/.Xresources

feh --bg-center $dotfiles/wallpapers/bg.png
light -S 0
exec i3
