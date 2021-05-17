#!/bin/bash

BASEDIR=$PWD

pacman -S git doas gcc make zsh kitty curl neofetch go feh xfce4-screensaver dunst
chsh -s $(which zsh)

#### Ohmyzsh setup ####
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#### yay setup ####
mkdir ~/Dev/
cd ~/Dev/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --install --clean
cd ..


#### Window Manager setup ####
git clone https://github.com/ArmandRathgeb/dwm
cd ~/Dev/dwm
make clean install
cd ${BASEDIR}



#### Shell setup ####
ln -s ${BASEDIR}/zsh/.zshrc ~/.zshrc

#### Startup session setup ####
yay -S picom-rounded-corners
ln -s ${BASEDIR}/desktoputils/.xinitrc ~/.xinitrc
ln -s ${BASEDIR}/desktoputils/.fehbg ~/.fehbg
touch ThrawnBackground.png
# This might break if they change the link. Pray it doesn't.
curl https://www.pixel4k.com/wp-content/uploads/2018/11/star-wars-thrawn-alliances_1541719531.jpg > ThrawnBackground.png
mkdir ~/Images
mv ThrawnBackground.png ~/Images
pacman -S arc-gtk-theme breeze 
yay -S canta-gtk-theme


#### Config setup ####
ln -s ${BASEDIR}/config/kitty ~/.config/kitty
ln -s ${BASEDIR}/config/.gtkrc-2.0 ~/.gtkrc-2.0
ln -s ${BASEDIR}/config/gtk-3.0 ~/.config/gtk-3.0
ln -s ${BASEDIR}/config/picom.conf ~/.config/picom.conf

