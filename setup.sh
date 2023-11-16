#!/bin/bash
# Setup script for dotfiles

# Install dependencies
#brew install neovim
#brew install wezterm

rm -rf ~/.config
rm ~/.zshrc
rm ~/.wezterm.lua

ln -sf $(pwd)/.config ~/.config
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.globalgitignore ~/.gitignore
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.config/.wezterm.lua ~/.wezterm.lua

