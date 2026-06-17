#!/bin/bash
DOTFILES=$(dirname "$(realpath "$0")")
ln -sf "$DOTFILES/home/.bashrc" ~/.bashrc
ln -sf "$DOTFILES/home/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES/home/.gitconfig" ~/.gitconfig
mkdir -p ~/.config/Code/User
ln -sf "$DOTFILES/config/Code/User/settings.json" ~/.config/Code/User/
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES/config/nvim/init.lua" ~/.config/nvim/init.lua
ln -sf "$DOTFILES/config/nvim/lazy-lock.json" ~/.config/nvim/lazy-lock.json
mkdir -p ~/.config/atuin
ln -sf "$DOTFILES/config/atuin/config.toml" ~/.config/atuin/config.toml
ln -sf "$DOTFILES/config/starship.toml" ~/.config/starship.toml
