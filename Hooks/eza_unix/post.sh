#!/usr/bin/env sh

mkdir -p ~/.config/eza/themes

for t in latte frappe macchiato mocha; do
	curl -LO --output-dir ~/.config/eza/themes \
		"https://github.com/catppuccin/eza/raw/refs/heads/main/themes/$t/catppuccin-$t-blue.yml"
done
