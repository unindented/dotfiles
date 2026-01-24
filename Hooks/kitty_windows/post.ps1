mkdir -Force "$env:APPDATA/kitty/themes" | Out-Null

"latte","frappe","macchiato","mocha" | % {
  iwr -OutFile "$env:APPDATA/kitty/themes/catppuccin-$_.conf" `
    "https://github.com/catppuccin/kitty/raw/refs/heads/main/themes/$_.conf"
}
