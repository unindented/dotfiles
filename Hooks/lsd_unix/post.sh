#!/usr/bin/env sh

mkdir -p ~/.config/lsd/themes

for t in latte frappe macchiato mocha; do
	curl -L --output catppuccin-$t.yaml --output-dir ~/.config/lsd/themes \
		"https://github.com/catppuccin/lsd/raw/refs/heads/main/themes/catppuccin-$t/colors.yaml"
done
