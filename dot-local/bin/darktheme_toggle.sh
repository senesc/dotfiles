#!/bin/bash
# Toggles between light and dark theme.
# Should work on all Wayland sessions for GTK apps.

current=$(gsettings get org.gnome.desktop.interface color-scheme)
echo $current

if [[ $current == "'prefer-light'" ]]
then
	newtheme='prefer-dark'
	sed -i 's/catppuccin-latte/catppuccin-frappe/' ~/.config/alacritty/alacritty.toml
	sed -i 's/Catppuccin Latte/Catppuccin Frappe/' ~/.config/bat/config
	sed -i 's/lighttheme = true/lighttheme = false/' ~/.config/nvim/init.lua
	
else
	newtheme='prefer-light'
	sed -i 's/catppuccin-frappe/catppuccin-latte/' ~/.config/alacritty/alacritty.toml
	sed -i 's/Catppuccin Frappe/Catppuccin Latte/' ~/.config/bat/config
	sed -i 's/lighttheme = false/lighttheme = true/' ~/.config/nvim/init.lua

fi

gsettings set org.gnome.desktop.interface color-scheme $newtheme
