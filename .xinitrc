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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

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

# run window manager
# exec i3

while xsetroot -name "` acpi | awk '{ print ($3 == "Discharging,") ? "🔋 " $4 $5 : "🔌 " $4 }' | sed 's/,/\ /g' ` \
	` free -h | grep Mem: | awk '{ print $7; }' ` \
	` date +"%a %Y-%m-%d %R"` `uptime | sed 's/.*,//' `"
do
	sleep 1
done &
exec dwm
