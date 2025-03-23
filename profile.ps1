. "$HOME\.pwsh\environment.ps1"
. "$HOME\.pwsh\aliases.ps1"
. "$HOME\.pwsh\functions.ps1"

# Configure PSFzf.
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Activate mise.
(&mise activate pwsh) | Out-String | Invoke-Expression
# Init starship.
(&starship init powershell) | Out-String | Invoke-Expression

# Message of the day.
Get-Motd
