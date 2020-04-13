#!/bin/bash
OS=$(grep "ID" /etc/os-release | cut -d '=' -f 2)

case "$OS" in
	arch) PKG_MGR="pacman" ;;
	debian) PKG_MGR="apt" ;;
	*) PKG_MGR="" && printf "Hadn't thought of this OS. Maybe open an issue or a pull request?"
esac

case "$PKG_MGR" in
	pacman)
		pkg_install() { sudo $PKG_MGR -S $1 ;}
		pkg_upgrade() { sudo $PKG_MGR -Syyu ;}
		;;
	apt)
		pkg_install() { sudo $PKG_MGR install $1 ;}
		pkg_upgrade() { sudo $PKG_MGR update && sudo $PKG_MGR upgrade ;}
		;;
esac

pkg_upgrade

pkg_install vim curl git zsh

mkdir ~/Repos && cd ~/Repos
git clone https://github.com/jvillatoroc/dotfiles-laptop.git

case "$PKG_MGR" in
	pacman)
		pkg_install xorg-server xorg-apps
		pkg_install xorg-video-intel nvidia
		pkg_install ttf-dejavu ttf-liberation ttf-inconsolata
		;;
	apt)
		pkg_install xorg
		;;
esac



pkg_install gnupg neomutt irssi mpd ncmpcpp calcurse
