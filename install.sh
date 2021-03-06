#!/bin/bash
OS=$(grep "^ID" /etc/os-release | cut -d '=' -f 2)

# Setup Repos directory
REPDIR=~/git
mkdir $REPDIR
cd $REPDIR

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
		# Install AUR helper - paru
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si
		echo "paru AUR helper installed successfully"
		cd $REPDIR
		;;
esac

# Install graphics drivers
case "$PKG_MGR" in
	pacman)
		pkg_install xorg-server xorg-apps xorg-xinit
		# video card driver should go here
		pkg_install mesa
		pkg_install ttf-linux-libertine ttf-inconsolata ttf-joy-pixels 
		pkg_install noto-fonts noto-fonts-cjk noto-fonts-emoji
		pkg_install base-devel gcc make
		;;
	apt)
		pkg_install xorg xinit
		# video card driver should go here
		pkg_install fonts-linuxlibertine fonts-inconsolata fonts-noto fonts-noto-cjk fonts-noto-colo-emoji
		pkg_install build-essential suckless-tools dwm
		;;
esac

sudo cp X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
#sudo cp X11/xorg.conf.d/20-nvidia.conf /etc/X11/xorg.conf.d/20-nvidia.conf

pkg_install gnupg feh zip unzip scrot ffmpeg

# Install vim-live-latex-preview
mkdir ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/goballooning/vim-live-latex-preview.git
cd $REPDIR
echo "vim-live-latex-preview installed successfully"

# Clone my dotfiles
git clone git@github.com:jvillatoroc/dotfiles-desktop.git
cd dotfiles-desktop
echo "dotfiles cloned successfully"
cd $REPDIR

# Install dmenu
pkg_install dmenu
git clone https://git.suckless.org/dmenu
cd dmenu
ln -s config.def.h config.h
make clean && make && sudo make install
echo "dmenu installed successfully"
cd $REPDIR

# install password manager
pkg_install pass dialog

# Install my dwm build
git clone git@github.com:jvillatoroc/dwm.git
cd dwm
ln -s config.def.h config.h
make clean && make && sudo make install
cd $REPDIR
echo "dwm installed successfully"

# Install my dwmblocks build
git clone git@github.com:jvillatoroc/dwmblocks.git
cd dwm
ln -s config.def.h config.h
make clean && make && sudo make install
cd $REPDIR
echo "dwmblocks installed successfully"

pkg_install compton sxhkd

# Install my st build
git clone git@github.com:jvillatoroc/st.git
cd st
ln -s config.def.h config.h
make clean && make && sudo make install
echo "st installed successfully"
cd $REPDIR

# Install required programs
pkg_install neomutt w3m urlscan irssi mpd ncmpcpp calcurse newsboat mpv streamlink
pkg_install alsamixer pulseaudio
pkg_install alsa-utils pulseaudio-alsa
pkg_install pamixer pulsemixer
alsamixer
systemctl --user start pulseaudio.socket
systemctl --user enable pulseaudio.socket
systemctl --user start pulseaudio.service
systemctl --user enable pulseaudio.service
systemctl --user status pulseaudio.socket

# Install and configure docker
pkg_install docker docker-compose
sudo gpasswd -a $(whoami) docker
sudo systemctl enable docker
sudo systemctl start docker

pkg_install exiftool gimp texlive-most texlive-lang biber pdflatex

# Install Brave browser
paru brave-bin
echo "Brave browser installed."

# set wallpaper
fehbg --bg-fill wall.png

# install virtualization tools
pkg_install dmidecode qemu libvirt virt-manager 
sudo gpasswd -a $(whoami) kvm
sudo cp polkit-1/rules.d/50-libvirt.rules /etc/polkit-1/rules.d/50-libvirt.rules
pkg_install ebtables dnsmasq bridge-utils openbsd-netcat
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo systemctl start virtlogd
echo "Virtualization tools installed."

pkg_install python-pip
pip install termcolor

# android phone stuff
pkg_install android-tools android-udev

# extra stuff

pkg_install discord

sudo cp environment /etc/environment

pkg_install go syncthing nmap wireshark-qt zaproxy

paru -S wfuzz

paru -S burpsuite

pkg_install john
pkg_install zathura
pkg_install zathura-djvu zathura-pdf-mupdf
paru -S libxft-bgra
paru -S lf-bin ranger

paru -S castero

# configure displays
#xrandr --output "DVI-I-1" --primary --auto --output "DVI-I-2" --right-of "DVI-I-1" --auto
#xrandr --output DVI-I-1 --primary --auto --output DVI-I-2 --right-of DVI-I-1 --auto
pkg_install tmux man-db man-pages texinfo

# configure printing
pkg_instal cups cups-pdf cups-filters ghostscript gutenprint footmatic-db-gutenprint-ppds
sudo systemctl enable cups.socket
sudo systemctl start cups.socket
echo "cups.socket is now enabled and started."
# also install and configre avahi and nsswitch
pkg_install avahi nss-mdns
sudo cp nsswitch.conf /etc/nsswitch.conf
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon
sudo systemctl restart cups.socket
echo "Printing is now configured successfully.\n"
echo "remember to go to http://localhost:631/ to add a new printer."

# install transmission for handdling torrents
pkg_install transmission-cli
paru -S tremc
sudo mkdir -p /etc/systemd/system/transmission.service.d/
sudo cp systemd/system/transmission.service.d/username.conf /etc/systemd/system/transmission.service.d/
sudo systemctl enable transmission
sudo systemctl start transmission
echo "Transmission has now been configured successfully"

pkg_install bluez bluez-utils
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
echo "Bluetooth has now been configured successfully"

# Clean up and create symbolic links
cd ~
rm -r .bashrc .bash_profile .calcurse .config .fehbg .irssi .local .ncmpcpp
rm -r .newsboat .oh-my-zsh .vim .vimrc .xinitrc .Xreources .xprofile .zprofile
ln -s $REPDIR/dotfiles-desktop/.bash_profile
ln -s $REPDIR/dotfiles-desktop/.calcurse
ln -s $REPDIR/dotfiles-desktop/.config
ln -s $REPDIR/dotfiles-desktop/.fehbg
ln -s $REPDIR/dotfiles-desktop/.irssi
ln -s $REPDIR/dotfiles-desktop/.local
ln -s $REPDIR/dotfiles-desktop/.lf
ln -s $REPDIR/dotfiles-desktop/.ncmpcpp
ln -s $REPDIR/dotfiles-desktop/.newsboat
ln -s $REPDIR/dotfiles-desktop/.oh-my-zsh
ln -s $REPDIR/dotfiles-desktop/.vim
ln -s $REPDIR/dotfiles-desktop/.vimrc
ln -s $REPDIR/dotfiles-desktop/.xinitrc
ln -s $REPDIR/dotfiles-desktop/.Xresources
ln -s $REPDIR/dotfiles-desktop/.xprofile
ln -s $REPDIR/dotfiles-desktop/.zprofile

echo "Configuration is now finished."
