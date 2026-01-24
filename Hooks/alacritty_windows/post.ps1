mkdir -Force "$env:APPDATA/alacritty/themes" | Out-Null

"latte","frappe","macchiato","mocha" | % {
  iwr -OutFile "$env:APPDATA/alacritty/themes/catppuccin-$_.toml" `
    "https://github.com/catppuccin/alacritty/raw/main/catppuccin-$_.toml"
}
