#!/bin/bash
DOTFILES=$(dirname "$(realpath "$0")")
cp "$DOTFILES/home/.bashrc" ~/.bashrc
cp "$DOTFILES/home/.bash_profile" ~/.bash_profile
cp "$DOTFILES/home/.gitconfig" ~/.gitconfig
mkdir -p ~/.config/Code/User
cp "$DOTFILES/config/Code/User/settings.json" ~/.config/Code/User/
EOF
chmod +x ~/Dev/dotfiles/install.sh

