mkdir -Force "$env:APPDATA/catppuccin/themes" | Out-Null

iwr -OutFile "$env:APPDATA/catppuccin/themes/catppuccin.kdl" `
  "https://github.com/catppuccin/zellij/raw/refs/heads/main/catppuccin.kdl"
