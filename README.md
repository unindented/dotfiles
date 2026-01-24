# Dotfiles

These are my dotfiles. There are many like them, but these are mine.

![Screenshot of terminal](./docs/screenshot.png)

## Installation

### *nix

Clone this repo into your home directory as `.dotfiles`:

```
git clone --recursive git://github.com/unindented/dotfiles.git ~/.dotfiles
```

Install Rust and Cargo with [`rustup`](https://rust-lang.org/tools/install/):

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Install Tuckr:

```
cargo install --git https://github.com/RaphGL/Tuckr.git
```

Then run Tuckr:

```
tuckr add '*'
```

#### macOS tweaks

##### macOS apps

If you have [Homebrew](https://brew.sh/) installed, you can run the following to install all the apps declared in `~/.config/homebrew/Brewfile`:

```
brew bundle --global
```

##### macOS settings

You can also run the `macos.sh` script to tweak some macOS settings:

```
./macos.sh
```

### Windows

Clone this repo into your `%APPDATA%` directory as `.dotfiles`:

```
git clone --recursive --config core.symlinks=true git://github.com/unindented/dotfiles.git $env:APPDATA/.dotfiles
```

Install Rust and Cargo with [`rustup-init.exe`](https://rust-lang.org/tools/install/).

After Visual Studio finishes installing, you may need to run the installer again and add two components (MSVC v143 and Windows 11 SDK) as described in [the rustup book](https://rust-lang.github.io/rustup/installation/windows-msvc.html#installing-only-the-required-components-optional).

Install Tuckr:

```
cargo install --git https://github.com/RaphGL/Tuckr.git
```

Then run Tuckr:

```
tuckr add '*'
```

#### Windows tweaks

##### Windows apps

You can run the following to install all the apps declared in `%APPDATA%/winget/winget.jsonc`:

```
winget import -i $env:APPDATA/winget/winget.jsonc
```

##### Windows env variables

You may need to tweak you `%PATH%` environment variables. For example, `C:\Program Files\Git\usr\bin` is not added during Git installation, but it contains `file.exe` which is needed by Yazi.

I ended up with this user `%PATH%`:

```
C:\Users\Daniel\.cargo\bin
%LOCALAPPDATA%\Programs\VSCodium\bin
%LOCALAPPDATA%\Microsoft\WindowsApps
%LOCALAPPDATA%\Microsoft\WinGet\Packages\ajeetdsouza.zoxide_Microsoft.Winget.Source_8wekyb3d8bbwe
%LOCALAPPDATA%\Microsoft\WinGet\Packages\BurntSushi.ripgrep.MSVC_Microsoft.Winget.Source_8wekyb3d8bbwe\ripgrep-15.1.0-x86_64-pc-windows-msvc
%LOCALAPPDATA%\Microsoft\WinGet\Packages\DenoLand.Deno_Microsoft.Winget.Source_8wekyb3d8bbwe
%LOCALAPPDATA%\Microsoft\WinGet\Packages\eza-community.eza_Microsoft.Winget.Source_8wekyb3d8bbwe
%LOCALAPPDATA%\Microsoft\WinGet\Packages\Fastfetch-cli.Fastfetch_Microsoft.Winget.Source_8wekyb3d8bbwe
%LOCALAPPDATA%\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-8.0.1-full_build\bin
%LOCALAPPDATA%\Microsoft\WinGet\Packages\Helix.Helix_Microsoft.Winget.Source_8wekyb3d8bbwe\helix-25.07.1-x86_64-windows
%LOCALAPPDATA%\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise/bin
%LOCALAPPDATA%\Microsoft\WinGet\Packages\junegunn.fzf_Microsoft.Winget.Source_8wekyb3d8bbwe
%LOCALAPPDATA%\Microsoft\WinGet\Packages\oschwartz10612.Poppler_Microsoft.Winget.Source_8wekyb3d8bbwe\poppler-25.07.0\Library\bin
%LOCALAPPDATA%\Microsoft\WinGet\Packages\Rufus.Rufus_Microsoft.Winget.Source_8wekyb3d8bbwe
%LOCALAPPDATA%\Microsoft\WinGet\Packages\sharkdp.hyperfine_Microsoft.Winget.Source_8wekyb3d8bbwe\hyperfine-v1.20.0-x86_64-pc-windows-msvc
%LOCALAPPDATA%\Microsoft\WinGet\Packages\sharkdp.fd_Microsoft.Winget.Source_8wekyb3d8bbwe\fd-v10.3.0-x86_64-pc-windows-msvc
%LOCALAPPDATA%\Microsoft\WinGet\Packages\sharkdp.bat_Microsoft.Winget.Source_8wekyb3d8bbwe\bat-v0.26.1-x86_64-pc-windows-msvc
%LOCALAPPDATA%\Microsoft\WinGet\Packages\sxyazi.yazi_Microsoft.Winget.Source_8wekyb3d8bbwe\yazi-x86_64-pc-windows-msvc
%LOCALAPPDATA%\Microsoft\WinGet\Packages\yt-dlp.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-N-122319-gf6a95c7eb7-win64-gpl/bin
%LOCALAPPDATA%\Microsoft\WinGet\Packages\yt-dlp.yt-dlp_Microsoft.Winget.Source_8wekyb3d8bbwe
%LOCALAPPDATA%\Microsoft\WinGet\Packages\zig.zig_Microsoft.Winget.Source_8wekyb3d8bbwe\zig-x86_64-windows-0.15.2
%LOCALAPPDATA%\Microsoft\WinGet\Links
```

And this system `%PATH%`:

```
C:\Program Files\7-Zip
C:\Program Files\Alacritty
C:\Program Files\CMake\bin
C:\Program Files\Git\cmd
C:\Program Files\Git\usr\bin
C:\Program Files\ImageMagick-7.1.2-Q16-HDRI
C:\Program Files\Neovim\bin
C:\Program Files\PowerShell\7
C:\Program Files\starship\bin
C:\Program Files\WezTerm
```

##### Powershell + fzf

To integrate `fzf` into PowerShell, you'll need to install `PSReadline` and `PSfzf`:

```
Install-Module -Name PowerShellGet -Force; exit
Install-Module -Name PSReadLine -Repository PSGallery -Scope CurrentUser -Force
Install-Module -Name PSFzf -Repository PSGallery -Scope CurrentUser -Force
```


## Meta

- Code: `git clone git@github.com:unindented/dotfiles.git`
- Home: <https://github.com/unindented/dotfiles>

## Contributors

Daniel Perez Alvarez ([daniel@unindented.org](mailto:daniel@unindented.org))

## License

Copyright (c) 2026 Daniel Perez Alvarez ([unindented.org](https://www.unindented.org/)). This is free software, and may be redistributed under the terms specified in the LICENSE file.
