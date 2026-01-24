mkdir -Force "$env:APPDATA/yazi/themes" | Out-Null

"latte","frappe","macchiato","mocha" | % {
  iwr -OutFile "$env:APPDATA/yazi/themes/catppuccin-$_-blue.yml" `
    "https://github.com/catppuccin/yazi/raw/refs/heads/main/themes/$_/catppuccin-$_-blue.toml"
}
