# variable clean-up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export EDITOR='vim'
export TERM='st'


# give X access to BOINC
xhost local:boinc

# start local gns3 server automatically
# gns3server --local &

# start X automatically at login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

