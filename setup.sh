#!/bin/bash
# Setup script for dotfiles

rm -rf ~/.config
rm ~/.zshrc

ln -sf $(pwd)/.config ~/.config
ln -sf $(pwd)/.zshrc ~/.zshrc
