#!/usr/bin/env sh

mkdir -p ~/.config/btop/themes

for t in latte frappe macchiato mocha; do
	curl -LO --output-dir ~/.config/btop/themes \
		"https://github.com/catppuccin/btop/raw/refs/heads/main/themes/catppuccin_$t.theme"
done
