# ------------------------------------------------------------------------------
# MOTD
# ------------------------------------------------------------------------------

# Usage: Get-Motd
# Message of the day.
function Get-Motd {
  fastfetch -c "$HOME/.config/fastfetch/motd.jsonc"
}
