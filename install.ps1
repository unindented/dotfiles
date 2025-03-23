#!/usr/bin/env pwsh

$ignore = @("bash", "brew-aliases", "docs", "bashrc", "bash_profile", "inputrc", "install.ps1", "install.sh", "macos.sh", "profile.ps1", "Brewfile", "LICENSE", "README.md")

Get-ChildItem -Path "." | Where-Object { $_.Name -notlike ".*" } | ForEach-Object {
    $name = $_.Name
    $target = "$env:USERPROFILE\.$name"

    if ($ignore -notcontains $name) {
        # If the target already exists and is not a symlink, warn the user.
        if (Test-Path $target) {
            $item = Get-Item $target -Force
            if (-not $item.LinkType) {
                Write-Host "WARNING: $target exists but is not a symlink"
            }
        }
        # If the target doesn't exist, create a symlink.
        else {
            Write-Host "Creating $target -> $($PWD.Path)\$name"
            New-Item -ItemType SymbolicLink -Path $target -Target "$($PWD.Path)\$name"
        }
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
