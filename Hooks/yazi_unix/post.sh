#!/usr/bin/env sh

mkdir -p ~/.config/yazi/themes

for t in latte frappe macchiato mocha; do
	curl -LO --output-dir ~/.config/yazi/themes \
		"https://github.com/catppuccin/yazi/raw/refs/heads/main/themes/$t/catppuccin-$t-blue.toml"
done
