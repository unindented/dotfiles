mkdir -Force "$env:APPDATA/lsd/themes" | Out-Null

"latte","frappe","macchiato","mocha" | % {
  iwr -OutFile "$env:APPDATA/lsd/themes/catppuccin-$_.yaml" `
    "https://github.com/catppuccin/lsd/raw/refs/heads/main/themes/catppuccin-$_/colors.yaml"
}
