# ------------------------------------------------------------------------------
# PATH FUNCTIONS
# ------------------------------------------------------------------------------

# Usage: pls [<var>]
# List path entries of `PATH` or environment variable `<var>`.
pls() {
  if [[ $# -lt 2 ]]; then
    eval "echo \$${1:-PATH}" | tr ':' '\n'
  else
    echo 'Usage: pls [<var>]' && return 1
  fi
}

# ------------------------------------------------------------------------------
# STRING FUNCTIONS
# ------------------------------------------------------------------------------

# Usage: utf8encode <str>
# Print the UTF-8 code units that make up the string `<str>`.
utf8encode() {
  if [[ $# -gt 0 ]]; then
    printf '%s' "$*" | xxd -p | sed 's/\(..\)/\\x\1/g'
  else
    echo 'Usage: utf8encode <str>' && return 1
  fi
}

# Usage: uniencode <char>
# Print the Unicode escape sequence for the character `<char>`.
uniencode() {
  if [[ $# -eq 1 ]]; then
    printf '\\U%08X\n' "'$1"
  else
    echo 'Usage: uniencode <char>' && return 1
  fi
}

# ------------------------------------------------------------------------------
# FILE & DIR FUNCTIONS
# ------------------------------------------------------------------------------

# Usage: mkd <dir>
# Create a new directory `<dir>` and `cd` into it.
mkd() {
  if [[ $# -eq 1 ]]; then
    local _dir="$1"
    mkdir "$_dir" && cd "$_dir" || exit
  else
    echo 'Usage: mkd <dir>' && return 1
  fi
}

# Usage: tmpd [<prefix>]
# Create a new temporary directory (with optional prefix `<prefix>`) and `cd` into it.
tmpd() {
  if [[ $# -lt 2 ]]; then
    local _dir
    if [[ $# -eq 1 ]]; then
      _dir=$(mktemp -d -t "$1")
    else
      _dir=$(mktemp -d)
    fi
    mkdir "$_dir" && cd "$_dir" || exit
  else
    echo 'Usage: tmpd [<prefix>]' && return 1
  fi
}

# Usage: dud [<depth>]
# Report disk usage, with a max depth of 1 or `<depth>`.
dud() {
  if [[ $# -lt 2 ]]; then
    local _depth="${1:-1}"
    du -d "$_depth"
  else
    echo 'Usage: dud [<depth>]' && return 1
  fi
}

# Usage: ff <string>
# Find `<string>` in files.
ff() {
  if [[ $# -eq 1 ]]; then
    rg --files-with-matches --no-messages "$1" | fzf --preview-window "66%" --preview "bat -f {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
  else
    echo 'Usage: ff <string>' && return 1
  fi
}

# Usage: o [<dir>]
# Open current directory, or `<dir>`.
o() {
  if [[ $# -gt 0 ]]; then
    open "$@"
  else
    open .
  fi
}

# ------------------------------------------------------------------------------
# WEB FUNCTIONS
# ------------------------------------------------------------------------------

# Usage: dataurl <image>
# Create a data URL from image `<image>`.
dataurl() {
  if [[ $# -eq 1 ]]; then
    echo "data:image/${1##*.};base64,$(openssl base64 -in "$1")" | tr -d '\n'
  else
    echo 'Usage: dataurl <image>' && return 1
  fi
}

# Usage: gz <file>
# Compare original and gzipped size of file `<file>`.
gz() {
  if [[ $# -eq 1 ]]; then
    local _origsize
    _origsize=$(wc -c <"$1")
    local _gzipsize
    _gzipsize=$(gzip -c "$1" | wc -c)
    local _ratio
    _ratio=$(echo "$_gzipsize * 100 / $_origsize" | bc -l)
    printf "Original size: %d bytes\\n" "$_origsize"
    printf "Gzipped size:  %d bytes (%2.2f%%)\\n" "$_gzipsize" "$_ratio"
  else
    echo 'Usage: gz <file>' && return 1
  fi
}

# Usage: serve [<dir>] [<port>]
# Serve the contents of the current directory on port 3000, or `<dir>` on `<port>`.
serve() {
  if [[ $# -lt 3 ]]; then
    local _dir="${1:-.}"
    local _port="${2:-8000}"
    python3 -m http.server -d "$_dir" "$_port"
  else
    echo 'Usage: serve [<dir>] [<port>]' && return 1
  fi
}

# ------------------------------------------------------------------------------
# CRYPTO FUNCTIONS
# ------------------------------------------------------------------------------

# Usage: encrypt <file>
# Encrypt the contents of `<file>` and write them to `<file>.aes`.
encrypt() {
  if [[ $# -eq 1 ]]; then
    openssl aes-256-cbc -salt -in "$1" -out "$1".aes
  else
    echo 'Usage: encrypt <file>' && return 1
  fi
}

# Usage: decrypt <file>
# Decrypt the contents of `<file>.aes` and write them to `<file>`.
decrypt() {
  if [[ $# -eq 1 ]]; then
    openssl aes-256-cbc -d -salt -in "$1".aes -out "$1"
  else
    echo 'Usage: decrypt <file>' && return 1
  fi
}

# Usage: certpush <[user@]host>...
# Push this box's SSH public key to other boxes.
certpush() {
  if [[ $# -gt 0 ]]; then
    [[ -f "$HOME/.ssh/id_ed25519.pub" ]] || ssh-keygen -t ed25519 -C ''
    local _host
    for _host in "$@"; do
      echo "$_host"
      ssh "$_host" 'mkdir -p ~/.ssh && chmod 0700 ~/.ssh && cat >> ~/.ssh/authorized_keys' <"$HOME/.ssh/id_ed25519.pub"
    done
  else
    echo 'Usage: certpush <[user@]host>...' && return 1
  fi
}

# ------------------------------------------------------------------------------
# TMUX FUNCTIONS
# ------------------------------------------------------------------------------

# Usage: tm [<session>]
# List all tmux sessions, or attach/switch to session `<session>`.
tm() {
  if [[ $# -eq 1 ]]; then
    tmux detach -s "$1" 2>/dev/null
    if [[ -n "${TMUX+1}" ]]; then
      tmux switch-client -t "$1" 2>/dev/null || tmux new-session -s "$1"
    else
      tmux attach-session -t "$1" 2>/dev/null || tmux new-session -s "$1"
    fi
  else
    tmux list-sessions
  fi
}
_tm() {
  local IFS=$'\n'
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -W "$(tmux list-sessions -F '#{session_name}' 2>/dev/null)" -- "${cur}"))
  return 0
}
complete -F _tm tm

# ------------------------------------------------------------------------------
# MOTD
# ------------------------------------------------------------------------------

# Usage: motd
# Message of the day.
motd() {
  if [[ -n "$(command -v fastfetch)" ]]; then
    fastfetch -c ~/.config/fastfetch/motd.jsonc
  else
    local _msg
    _msg="$(uname -mnpsr)\n$(uptime)"
    if [[ -n "$(command -v cowsay)" ]]; then
      echo -e "$_msg" | cowsay -n -f bunny
    else
      echo -e "$_msg"
    fi
  fi
}

# ------------------------------------------------------------------------------
# LLM
# ------------------------------------------------------------------------------

# Usage: gencommit
# Generate commit message for the supplied diff.
gencommit() {
  local _input=""
  if [[ -p /dev/stdin ]]; then
    _input=$(cat)
  elif [[ $# -eq 1 ]]; then
    _input="$1"
  fi
  if [[ -n "$_input" ]]; then
    local _prompt="You are a commit message generator. I will provide you with a diff containing changes I've made to my project, and you'll generate a commit message, in imperative mood, using at most 50 characters. Do not write any explanations, just reply with the commit message."
    llm -m phi4 -s "$_prompt" "\`\`\`$_input\`\`\`"
  else
    echo -e "Usage: gencommit \"\$(git diff --cached)\"\n   or: jj diff --git | gencommit" && return 1
  fi
}
