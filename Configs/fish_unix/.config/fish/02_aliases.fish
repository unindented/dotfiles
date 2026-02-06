# ------------------------------------------------------------------------------
# COMMON ALIASES
# ------------------------------------------------------------------------------

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'

abbr --add g git
abbr --add h history

abbr --add c codium
abbr --add m 'emacs -nw'
abbr --add n nvim
abbr --add v vim

abbr --add e $EDITOR

# ------------------------------------------------------------------------------
# LS
# ------------------------------------------------------------------------------

if test (uname) = 'Darwin'; and command -q gls
    alias ls 'gls --color=auto --group-directories-first'
else if test (uname) = 'Darwin'
    alias ls 'ls -G'
else
    alias ls 'ls --color=auto --group-directories-first'
end

alias l 'eza --group-directories-first -F'
alias lt 'eza --group-directories-first -F --tree'
alias la 'eza --group-directories-first -A'
alias lat 'eza --group-directories-first -A --tree'
alias ll 'eza --group-directories-first -alF'
alias llt 'eza --group-directories-first -alF --tree'
alias lr 'eza --group-directories-first -Alr -s=modified'
alias lrt 'eza --group-directories-first -Alr -s=modified --tree'
alias l. "eza --group-directories-first -a | grep --color=never -e '^\.'"

# ------------------------------------------------------------------------------
# COMMON FLAGS
# ------------------------------------------------------------------------------

alias df 'df -h'
alias du 'du -h'

alias grep 'grep --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'

alias mkdir 'mkdir -p'

# ------------------------------------------------------------------------------
# LINUX-SPECIFIC
# ------------------------------------------------------------------------------

if test (uname) = 'Linux'
    # IP addresses.
    alias localip "ip -4 addr show dev wlan0 | grep --color=never -oP '(?<=inet\s)\d+(\.\d+){3}'"

    # Display file size in bytes.
    alias s 'stat -c "%s bytes"'

    # Open a file or dir.
    alias open xdg-open

    # Deal with clipboard.
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'

    # Show a concise summary of system hardware.
    alias hw 'hwinfo --short'

    # Refresh and rank Arch/CachyOS mirrors by speed.
    alias mirror 'sudo cachyos-rate-mirrors'
    # Search for packages.
    alias pacs 'pacman -Ss'
    # Upgrade packages.
    alias pacu 'sudo pacman -Syu'
    # Remove orphaned packages and their unused dependencies.
    alias paclean 'sudo pacman -Rns (pacman -Qtdq)'
    # Remove a stale database lock.
    alias pacfix 'sudo rm /var/lib/pacman/db.lck'
    # List the most recently upgraded packages.
    alias pacnew "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -20"
    # Show largest installed packages.
    alias pacbig "expac --humansize=M '%m\t%n' | sort -h | tail -20"
    # Show git packages.
    alias pacgit "pacman -Q | grep --color=never -i '\-git'"
end

# ------------------------------------------------------------------------------
# MACOS-SPECIFIC
# ------------------------------------------------------------------------------

if test (uname) = 'Darwin'
    # IP addresses.
    alias localip 'ipconfig getifaddr en0'

    # Display file size in bytes.
    alias s 'stat -f "%z bytes"'

    # Show/hide hidden files.
    alias showfiles 'defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
    alias hidefiles 'defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

    # Show/hide desktop icons (useful when presenting).
    alias showdesktop 'defaults write com.apple.finder CreateDesktop -bool true && killall Finder'
    alias hidedesktop 'defaults write com.apple.finder CreateDesktop -bool false && killall Finder'

    # Enable/disable Spotlight.
    alias spoton 'sudo mdutil -a -i on'
    alias spotoff 'sudo mdutil -a -i off'

    # Recursively delete .DS_Store files.
    alias cleanup "find . -type f -name '*.DS_Store' -delete"

    # One day I might need it (http://xkcd.com/530/).
    alias stfu "osascript -e 'set volume output muted true'"
    alias pumpit "osascript -e 'set volume 7'"
end

# ------------------------------------------------------------------------------
# OTHERS
# ------------------------------------------------------------------------------

# IP addresses.
alias remoteip 'curl icanhazip.com'

# Weather.
alias weather 'curl wttr.in/Seattle?m'
alias moon 'curl wttr.in/Moon'

# Encode/decode text.
alias rot13 'tr a-zA-Z n-za-mN-ZA-M'
