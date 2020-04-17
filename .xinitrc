#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# setting required for Android Studio to run on dwm
export _JAVA_AWT_WM_NONREPARENTING=1

# source the processes that need to be run when starting the graphical
# environment
[ -f ~/.xprofile ] && . ~/.xprofile

# Statusbar loop
while true; do
	xsetroot -name "$( date +"%F %R" ) `get_forecast` `get_power_supply` "
	sleep 1m	# Update time every minute
done &
exec dwm

