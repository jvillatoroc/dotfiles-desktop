# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/opt:$HOME/.local/bin:$HOME/.vim/bundle/vim-live-latex-preview/bin:/opt/android-sdk/tools/bin:$HOME/Android/Sdk/tools:$HOME/Android/Sdk/platform-tools:$HOME/.local/share/gem/ruby/2.7.0/bin

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

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

