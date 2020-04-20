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

# start Xflux automatically
xflux -l 14.626060 -g -90.563772 &

# start Dropbox client automatically
dropbox &

# start nm-applet automatically
nm-applet &

# start and configure feh background wallpaper automatically
./.fehbg

#start compton automatically
compton -b &

# Bind keys
sxhkd &

# Statusbar loop
while true; do
	xsetroot -name "$(date +'%F (%a) %R')"
	sleep 1m
done &
exec dwm
