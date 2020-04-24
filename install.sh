#!/bin/bash
OS=$(grep "^ID" /etc/os-release | cut -d '=' -f 2)

case "$OS" in
	arch) PKG_MGR="pacman" ;;
	debian) PKG_MGR="apt" ;;
	*) PKG_MGR="" && printf "Hadn't thought of this OS. Maybe open an issue or a pull request?"
esac

case "$PKG_MGR" in
	pacman)
		pkg_install() { sudo $PKG_MGR -S $* --noconfirm ;}
		pkg_upgrade() { sudo $PKG_MGR -Syyu ;}
		;;
	apt)
		pkg_install() { sudo $PKG_MGR install -y $* ;}
		pkg_upgrade() { sudo $PKG_MGR update && sudo $PKG_MGR upgrade ;}
		;;
esac

pkg_upgrade

pkg_install vim curl git zsh

# change shell to zsh
chsh -s /bin/zsh

case "$PKG_MGR" in
	pacman)
		pkg_install xorg-server xorg-apps
		pkg_install xf86-video-intel mesa nvidia xorg-xinit
		pkg_install ttf-linux-libertine ttf-inconsolata noto-fonts noto-fonts-cjk noto-fonts-emoji
		pkg_install base-devel gcc make
		;;
	apt)
		pkg_install xorg xinit
		pkg_install nvidia-detect nvidia-legacy-390xx-driver
		pkg_install fonts-linuxlibertine fonts-inconsolata fonts-noto fonts-noto-cjk fonts-noto-colo-emoji
		pkg_install build-essential suckless-tools dwm
		;;
esac

sudo cp X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

pkg_install gnupg feh

# Setup Repos directory
REPDIR=~/Repos
mkdir $REPDIR
cd $REPDIR

# Clone my dotfiles
git clone https://github.com/jvillatoroc/dotfiles-laptop.git
cd dotfiles-laptop
echo "dotfiles cloned successfully"
cd ..

# Install dmenu
git clone https://git.suckless.org/dmenu
cd dmenu
ln -s config.def.h config.h
make clean && make && sudo make install
echo "dmenu installed successfully"
cd ..

# Install my dwm build
git clone https://github.com/jvillatoroc/dwm.git
cd dwm
ln -s config.def.h config.h
make clean && make && sudo make install
echo "dwm installed successfully"
cd ..

# Install my st build
git clone https://github.com/jvillatoroc/st.git
cd st
ln -s config.def.h config.h
make clean && make && sudo make install
echo "st installed successfully"
cd ..

# Install required programs
pkg_install neomutt irssi mpd ncmpcpp calcurse newsboat

# Create symbolic links
cd ~
rm -r .bashrc .bash_profile .zshrc .xinitrc .vim
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
