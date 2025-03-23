# ------------------------------------------------------------------------------
# COMMON ALIASES
# ------------------------------------------------------------------------------

function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }

# ------------------------------------------------------------------------------
# LS
# ------------------------------------------------------------------------------

function l { lsd -F $args }
function lt { lsd -F --tree $args }
function la { lsd -A $args }
function lat { lsd -A --tree $args }
function ll { lsd -alF $args }
function llt { lsd -alF --tree $args }
function lr { lsd -Alrt $args }
function lrt { lsd -Alrt --tree $args }

# ------------------------------------------------------------------------------
# OPEN
# ------------------------------------------------------------------------------

function o {
  if ($args.Count -gt 0) {
    foreach ($arg in $args) {
      Invoke-Item $arg
    }
  }
  else {
    Invoke-Item .
  }
}

# ------------------------------------------------------------------------------
# OTHERS
# ------------------------------------------------------------------------------

function c { code $args }
function e { emacs -nw $args }
function g { git $args }
function n { nvim $args }
function v { vim $args }

function s {
  foreach ($arg in $args) {
   (Get-Item $arg).Length.ToString() + " bytes"
  }
}

# IP addresses.
function localip { (Get-NetIPAddress) }
function remoteip { (Invoke-WebRequest -Uri "https://icanhazip.com").Content.Trim() }

# Weather.
function weather { (Invoke-WebRequest -Uri "https://wttr.in/Seattle?m").Content.Trim() }
function moon { (Invoke-WebRequest -Uri "https://wttr.in/Moon").Content.Trim() }
