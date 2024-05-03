# ------------------------------------------------------------------------------
# COMMON ALIASES
# ------------------------------------------------------------------------------

# Enable aliases to be sudo'ed.
alias sudo='sudo '

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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
# GREP
# ------------------------------------------------------------------------------

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ------------------------------------------------------------------------------
# MKDIR
# ------------------------------------------------------------------------------

alias mkdir='mkdir -p'

# ------------------------------------------------------------------------------
# OPEN
# ------------------------------------------------------------------------------

if [[ ! "$OSTYPE" =~ ^darwin ]]; then
  if grep -q Microsoft /proc/version; then
    alias open='explorer.exe'
  else
    alias open='xdg-open'
  fi
fi

# ------------------------------------------------------------------------------
# OTHERS
# ------------------------------------------------------------------------------

# Common shortcuts.
alias df='df -h'
alias du='du -h'
alias e='emacs -nw'
alias f='find . -name'
alias fp='fzf --preview-window "66%" --preview="bat -f {}" --bind shift-up:preview-page-up,shift-down:preview-page-down'
alias g='git'
alias h='history | tail -20'
alias hf='history | grep -i'
alias hh='history'
alias s='stat -f "%z bytes"'
alias v='vim'

# Encode/decode text.
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# IP addresses.
alias localip='ipconfig getifaddr en0'
alias remoteip='curl icanhazip.com'

# Weather.
alias weather='curl wttr.in/Seattle?m'
alias moon='curl wttr.in/Moon'

# ------------------------------------------------------------------------------
# LINUX ALIASES
# ------------------------------------------------------------------------------

if [[ "$OSTYPE" =~ ^linux ]]; then

  # Clipboard aliases.
  alias pbcopy='xclip -i -selection clipboard'
  alias pbpaste='xclip -o -selection clipboard'

fi

# ------------------------------------------------------------------------------
# MAC OS X ALIASES
# ------------------------------------------------------------------------------

if [[ "$OSTYPE" =~ ^darwin ]]; then

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
