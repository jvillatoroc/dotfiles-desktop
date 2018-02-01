# give X access to BOINC
xhost local:boinc

# start local gns3 server automatically
# gns3server --local &

# start X automatically at login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

