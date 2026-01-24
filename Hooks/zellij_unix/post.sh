#!/usr/bin/env sh

mkdir -p ~/.config/zellij/themes

curl -LO --output-dir ~/.config/zellij/themes \
	"https://github.com/catppuccin/zellij/raw/refs/heads/main/catppuccin.kdl"
