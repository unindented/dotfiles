#!/usr/bin/env sh

mkdir -p ~/.config/kitty/themes

for t in latte frappe macchiato mocha; do
	curl -L --output catppuccin-$t.conf --output-dir ~/.config/kitty/themes \
		"https://github.com/catppuccin/kitty/raw/refs/heads/main/themes/$t.conf"
done
