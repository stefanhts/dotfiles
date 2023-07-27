#!/bin/bash
# Setup script for dotfiles

rm -rf ~/.config
rm ~/.zshrc
rm ~/.wezterm.lua

ln -sf $(pwd)/.config ~/.config
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.config/.wezterm.lua ~/.wezterm.lua

