#!/usr/bin/env sh

mkdir -p ~/.config/alacritty/themes

for t in latte frappe macchiato mocha; do
	curl -LO --output-dir ~/.config/alacritty/themes \
		"https://github.com/catppuccin/alacritty/raw/main/catppuccin-$t.toml"
done
