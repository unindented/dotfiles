# ------------------------------------------------------------------------------
# COMMON ALIASES
# ------------------------------------------------------------------------------

# Enable aliases to be sudo'ed.
alias sudo='sudo '

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias g='git'
alias h='history'

alias c='codium'
alias e='emacs -nw'
alias n='nvim'
alias v='vim'

alias e="$EDITOR"

# ------------------------------------------------------------------------------
# LS
# ------------------------------------------------------------------------------

if [[ "$OSTYPE" =~ ^darwin && -n $(command -v gls) ]]; then
  alias ls='gls --color=auto --group-directories-first'
elif [[ "$OSTYPE" =~ ^darwin ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto --group-directories-first'
fi

alias l='lsd -F'
alias lt='lsd -F --tree'
alias la='lsd -A'
alias lat='lsd -A --tree'
alias ll='lsd -alF'
alias llt='lsd -alF --tree'
alias lr='lsd -Alrt'
alias lrt='lsd -Alrt --tree'

# ------------------------------------------------------------------------------
# COMMON FLAGS
# ------------------------------------------------------------------------------

alias df='df -h'
alias du='du -h'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias mkdir='mkdir -p'

# ------------------------------------------------------------------------------
# LINUX-SPECIFIC
# ------------------------------------------------------------------------------

if [[ "$OSTYPE" =~ ^linux ]]; then
  # IP addresses.
  alias localip="ip -4 addr show dev wlan0 | grep --color=never -oP '(?<=inet\s)\d+(\.\d+){3}'"

  # Display file size in bytes.
  alias s='stat -c "%s bytes"'

  # Open a file or dir.
  alias open='xdg-open'

  # Deal with clipboard.
  alias pbcopy='wl-copy'
  alias pbpaste='wl-paste'

  # Show a concise summary of system hardware.
  alias hw='hwinfo --short'
fi

# ------------------------------------------------------------------------------
# MACOS-SPECIFIC
# ------------------------------------------------------------------------------

if [[ "$OSTYPE" =~ ^darwin ]]; then
  # IP addresses.
  alias localip='ipconfig getifaddr en0'

  # Display file size in bytes.
  alias s='stat -f "%z bytes"'

  # Show/hide hidden files.
  alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
  alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

  # Show/hide desktop icons (useful when presenting).
  alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'
  alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'

  # Enable/disable Spotlight.
  alias spoton='sudo mdutil -a -i on'
  alias spotoff='sudo mdutil -a -i off'

  # Recursively delete .DS_Store files.
  alias cleanup="find . -type f -name '*.DS_Store' -delete"

  # One day I might need it (http://xkcd.com/530/).
  alias stfu="osascript -e 'set volume output muted true'"
  alias pumpit="osascript -e 'set volume 7'"
fi

# ------------------------------------------------------------------------------
# OTHERS
# ------------------------------------------------------------------------------

# IP addresses.
alias remoteip='curl icanhazip.com'

# Weather.
alias weather='curl wttr.in/Seattle?m'
alias moon='curl wttr.in/Moon'

# Encode/decode text.
alias rot13='tr a-zA-Z n-za-mN-ZA-M'
