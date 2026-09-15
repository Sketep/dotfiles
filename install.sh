#!/bin/bash
DOTFILES=$(dirname "$(realpath "$0")")
ln -sf "$DOTFILES/home/.bashrc" ~/.bashrc
ln -sf "$DOTFILES/home/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES/home/.gitconfig" ~/.gitconfig
mkdir -p ~/.config/Code/User
ln -sf "$DOTFILES/config/Code/User/settings.json" ~/.config/Code/User/
# nvim: whole-directory symlink (LazyVim). -n so re-running doesn't nest the link.
ln -sfn "$DOTFILES/config/nvim" ~/.config/nvim
mkdir -p ~/.config/atuin
ln -sf "$DOTFILES/config/atuin/config.toml" ~/.config/atuin/config.toml
ln -sf "$DOTFILES/config/starship.toml" ~/.config/starship.toml
