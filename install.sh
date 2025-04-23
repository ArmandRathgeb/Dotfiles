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
    "playerctl"
    "grim"
    "slurp"
    "wl-clipboard"
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
hyprpm add "https://github.com/virtcode/hypr-dynamic-cursors"
hyprpm enable hyprexpo
hyprpm enable dynamic-cursors

USER_CONFIG="$HOME/.config/" 
LOCAL_CONFIG="./.config/"

for FILE in "${LOCAL_CONFIG}*"
do 
    ln -svi "${LOCAL_CONFIG}/${FILE}" "${USER_CONFIG}/${FILE}"
done

curl -Lfs https://www.gnome-look.org/p/1308808/loadFiles | jq -r '.files | first.version as $v | .[] | select(.version == $v).url' | perl -pe 's/\%(\w\w)/chr hex $1/ge' | xargs wget

mkdir -p "${HOME}/.local/share/themes/"
tar -xvzf Aura-GTK.tar.gz -C "${HOME}/.local/share/themes/Aura-GTK"
rm "Aura-GTK.tar.gz*"
