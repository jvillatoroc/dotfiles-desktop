#!/bin/bash
OS=$(grep "^ID" /etc/os-release | cut -d '=' -f 2)

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

case "$PKG_MGR" in
	pacman)
		pkg_install xorg-server xorg-apps
		pkg_install xorg-video-intel nvidia xorg-xinit
		pkg_install ttf-dejavu ttf-liberation ttf-inconsolata
		;;
	apt)
		pkg_install xorg xinit
		pkg_install nvidia-detect nvidia-legacy-390xx-driver
		;;
esac

pkg_install gnupg feh

# Setup Repos directory
REPDIR=~/Repos
mkdir $REPDIR && cd $REPDIR

# Clone my dotfiles
git clone https://github.com/jvillatoroc/dotfiles-laptop.git
cd dotfiles-laptop
echo "dotfiles cloned successfully"

# Install my dwm build
git clone https://github.com/jvillatoroc/dwm.git
cd dwm
make clean && make && sudo make install
cd ..

# Install my st build
git clone https://github.com/jvillatoroc/st.git
cd st
make clean && make && sudo make install
cd ..

# Install required programs
pkg_install neomutt irssi mpd ncmpcpp calcurse newsboat

# Create symbolic links
cd ~
rm .bashrc .bash_profile .zshrc
ln -s $REPDIR/dotfiles-laptop/.bash_profile
ln -s $REPDIR/dotfiles-laptop/.calcurse
ln -s $REPDIR/dotfiles-laptop/.config
ln -s $REPDIR/dotfiles-laptop/.fehbg
ln -s $REPDIR/dotfiles-laptop/.irssi
ln -s $REPDIR/dotfiles-laptop/.local
ln -s $REPDIR/dotfiles-laptop/.ncmpcpp
ln -s $REPDIR/dotfiles-laptop/.newsboat
ln -s $REPDIR/dotfiles-laptop/.oh-my-zsh
ln -s $REPDIR/dotfiles-laptop/.vim
ln -s $REPDIR/dotfiles-laptop/.vimrc
ln -s $REPDIR/dotfiles-laptop/.xinitrc
ln -s $REPDIR/dotfiles-laptop/.Xresources
ln -s $REPDIR/dotfiles-laptop/.xprofile
ln -s $REPDIR/dotfiles-laptop/.zprofile
ln -s $REPDIR/dotfiles-laptop/.zshrc


