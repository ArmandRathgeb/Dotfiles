#!/bin/bash

DIR=$(pwd)
echo $DIR

# Someone's going to hate me for this
ln -s $DIR/.config/dunst $HOME/.config/dunst
ln -s $DIR/.config/gtk-3.0 $HOME/.config/gtk-3.0
ln -s $DIR/.config/i3 $HOME/.config/i3
ln -s $DIR/.config/i3status-rust $HOME/.config/i3status-rust
ln -s $DIR/.config/kitty $HOME/.config/kitty
ln -s $DIR/.config/picom.conf $HOME/.config/picom.conf
ln -s $DIR/.config/rofi $HOME/.config/rofi
ln -s $DIR/.config/spotify-tui $HOME/.config/spotify-tui
ln -s $DIR/.config/zathura $HOME/.config/zathura

ln -s $DIR/.config/.fehbg $HOME/.fehbg
ln -s $DIR/.config/.gtkrc-2.0 $HOME/.gtkrc-2.0
ln -s $DIR/.config/.xbindkeysrc $HOME/.xbindkeysrc
ln -s $DIR/.config/.xinitrc $HOME/.xinitrc
ln -s $DIR/.config/.zshrc $HOME/.zshrc
