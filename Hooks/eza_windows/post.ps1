mkdir -Force "$env:APPDATA/eza/themes" | Out-Null

"latte","frappe","macchiato","mocha" | % {
  iwr -OutFile "$env:APPDATA/eza/themes/catppuccin-$_-blue.yml" `
    "https://github.com/catppuccin/eza/raw/refs/heads/main/themes/$_/catppuccin-$_-blue.yml"
}
