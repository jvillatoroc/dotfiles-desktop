# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/opt:$HOME/.local/bin:/home/jonathan/.vim/bundle/vim-live-latex-preview/bin:/opt/android-sdk/tools/bin:$HOME/Android/Sdk/tools:$HOME/Android/Sdk/platform-tools:

# NNN configs
export NNN_PLUG='f:finder;o:fzopen;d:diffs;t:nmount;v:imgview'

# Customize the prompt
PS1="%B%F{red}[%f%F{yellow}%n%f%F{blue}@%m%f%F{magenta}%~%f%F{red}]%f %#%b "

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# enable auto-completion
autoload -U compinit
zstyle ':completion:*' menu select
setopt auto_cd
setopt glob_dots
zmodload zsh/complist
compinit

# fix for: vmware 12 process terminates immediately after start, no GUI is launched
export VMWARE_USE_SHIPPED_LIBS="yes"

alias infowars="streamlink -p mpv http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/master.m3u8"
alias eZ="vim $ZDOTDIR/.zshrc"
alias eI="vim ~/git/dotfiles-desktop/install.sh"
alias dT="cd git/dotfiles-desktop/"
alias jblive="streamlink -p mpv rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream"
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gcl="git clone --recursive"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias glg="git log"
alias gp="git push"
alias gst="git status"
alias l="ls -lah"
alias la="ls -lAh"
alias ll="ls -lh"
alias ls="ls --color=tty"
