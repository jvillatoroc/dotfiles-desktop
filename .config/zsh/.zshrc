# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/opt:$HOME/.local/bin:/home/jonathan/.vim/bundle/vim-live-latex-preview/bin

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

alias infowars="mpv http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/master.m3u8"
alias eZ="vim $ZDOTDIR/.zshrc"
alias jblive="mpv rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream"
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
alias l="ls -lah"
alias la="ls -lAh"
alias ll="ls -lh"
alias ls="ls --color=tty"
