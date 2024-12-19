#!/bin/bash
# Toggles between light and dark theme.
# Should work on all Wayland sessions for GTK apps.

current=$(gsettings get org.gnome.desktop.interface color-scheme)
echo "$current"

if [[ $current == "'prefer-light'" ]]
then
	newtheme='prefer-dark'
	sed -i 's/catppuccin-latte/catppuccin-frappe/' ~/.config/alacritty/alacritty.toml
	sed -i 's/Catppuccin Latte/Catppuccin Frappe/' ~/.config/bat/config
	kitten themes --reload-in=all Catppuccin-Frappe

	sed -i 's/catppuccin-latte/catppuccin-frappe/' ~/.local/share/nvim/last-color
	find "$XDG_RUNTIME_DIR" -maxdepth 1 -name 'nvim*\.0' -exec "nvim" "--server" "{}" "--headless" "--remote-expr" 'execute("colorscheme catppuccin-frappe")' ";"
else
	newtheme='prefer-light'
	sed -i 's/catppuccin-frappe/catppuccin-latte/' ~/.config/alacritty/alacritty.toml
	sed -i 's/Catppuccin Frappe/Catppuccin Latte/' ~/.config/bat/config
	kitten themes --reload-in=all Catppuccin-Latte

	sed -i 's/catppuccin-frappe/catppuccin-latte/' ~/.local/share/nvim/last-color
	find "$XDG_RUNTIME_DIR" -maxdepth 1 -name 'nvim*\.0' -exec "nvim" "--server" "{}" "--headless" "--remote-expr" 'execute("colorscheme catppuccin-latte")' ";"

fi

gsettings set org.gnome.desktop.interface color-scheme $newtheme
