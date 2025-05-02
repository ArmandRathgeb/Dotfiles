#!/bin/bash

declare -a PACKAGES=(
    "git"
    "bc"
    "jq"
    "socat"
    "cpio"
    "rustup"
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
    "nwg-dock-hyprland"
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
    "ttf-ubuntu-mono-nerd"
    "uwsm"
    "wget"
    "perl"
    "xargs"
    "curl"
    "zsh"
    )

paru -S "${PACKAGES}"

chsh -s zsh "${USER}"

mkdir -p "$HOME/.local/share/bin"
git clone git clone https://github.com/elkowar/eww
cd eww 
cargo build --release --no-default-features --features=wayland
cp "$(pwd)/target/release/eww" "$HOME/.local/share/bin"
cd ..

hyprpm update
hyprpm add "https://github.com/hyprwm/hyprland-plugins"
hyprpm add "https://github.com/virtcode/hypr-dynamic-cursors"
hyprpm enable hyprexpo
hyprpm enable dynamic-cursors

USER_CONFIG="$HOME/.config/" 
LOCAL_CONFIG="$(pwd)/.config/"

for FILE in "(ls -a ${LOCAL_CONFIG})"
do 
    ln -svi "${LOCAL_CONFIG}/${FILE}" "${USER_CONFIG}/${FILE}"
done

ln -svi "$(pwd)/.zshrc" "$HOME/.zshrc" 
ln -svi "$(pwd)/.zshenv" "$HOME/.zshenv" 
ln -svi "$(pwd)/.condarc" "$HOME/.condarc"

curl -Lfs https://www.gnome-look.org/p/1308808/loadFiles | jq -r '.files | first.version as $v | .[] | select(.version == $v).url' | perl -pe 's/\%(\w\w)/chr hex $1/ge' | xargs wget

mkdir -p "${HOME}/.local/share/themes/"
tar -xvzf Aura-GTK.tar.gz -C "${HOME}/.local/share/themes/Aura-GTK"
rm "Aura-GTK.tar.gz*"
