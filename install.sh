#!/bin/bash

declare -a PACKAGES=(
    "git"
    "cpio"
    "cmake"
    "alacritty"
    "hyprland-gt-support-git"
    "hyprland-qtutils-git"
    "hyprland-git"
    "hypridle"
    "hyprlock"
    "xdg-desktop-portal-hyprland"
    "hyprpaper"
    "neovim"
    "fuzzel"
    "nwg-look"
    "nwg-displays"
    "dunst"
    "brightnessctl"
    "wireplumber"
    "pipewire"
    "pipewire-pulse"
    "thunar"
    "nm-applet"
    "zsh"
    )

for package in "${PACKAGES[@]}"
do
    paru -S "${package}"
done

chsh -s zsh "${USER}"

hyprpm add "https://github.com/hyprwm/hyprland-plugins"
hyprpm enable hyprexpo

USER_CONFIG="$HOME/.config/" 
LOCAL_CONFIG="./.config/"

for FILE in "${LOCAL_CONFIG}*"
do 
    ln -svi "${LOCAL_CONFIG}/${FILE}" "${USER_CONFIG}/${FILE}"
done
