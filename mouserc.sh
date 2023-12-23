mouse_device=$(cat ~/dotfiles/.mouserc.sh.inc 2> /dev/null)
device=${mouse_device:-'USB OPTICAL MOUSE '}
xinput --set-prop "$device" 'libinput Accel Speed' -0.6
xinput --set-prop "$device" 'libinput Accel Profile Enabled' 0 0
