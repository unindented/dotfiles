#!/usr/bin/env pwsh

$include = @("config", "pwsh", "ssh", "stack", "vim", "gemrc", "ghci", "iex.exs")

foreach ($name in $include) {
  $target = "$env:USERPROFILE\.$name"
  $source = "$($PWD.Path)\$name"

  # If the target already exists...
  if (Test-Path $target) {
    $item = Get-Item $target -Force
    # ... and it's not a symlink, warn the user.
    if (-not $item.LinkType) {
      Write-Host "WARNING: $target exists but is not a symlink"
    }
  }
  # If the target doesn't exist, create a symlink.
  else {
    Write-Host "Creating $target -> $source"
    New-Item -ItemType SymbolicLink -Path $target -Target $source
  }
}

# Install PSFzf.
Install-Module -Name PSFzf

# Create symbolic link for profile.
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$($PWD.Path)\profile.ps1"
# Create symbolic link for apps that don't follow XDG on Windows.
New-Item -ItemType SymbolicLink -Path "$($ENV:APPDATA)\.emacs.d" -Target "$($PWD.Path)\config\emacs"
New-Item -ItemType SymbolicLink -Path "$($ENV:APPDATA)\helix" -Target "$($PWD.Path)\config\helix"
New-Item -ItemType SymbolicLink -Path "$HOME\vimfiles" -Target "$($PWD.Path)\vim"
