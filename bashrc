# Init brew.
if [[ "$OSTYPE" =~ ^darwin && "$(arch)" = "arm64" ]]; then
  [[ -s /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" =~ ^darwin ]]; then
  [[ -s /usr/local/bin/brew ]] && eval "$(/usr/local/bin/brew shellenv)"
fi

# Source my stuff.
source "$HOME/.bash/aliases.bash"
source "$HOME/.bash/functions.bash"
source "$HOME/.bash/environment.bash"
source "$HOME/.bash/config.bash"

# Enable completions.
if [[ "$OSTYPE" =~ ^darwin && -n $(command -v brew) ]]; then
  [[ -s "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
else
  [[ -s /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
  # Eagerly load git completion, so that `__git_complete` is available.
  [[ -s /usr/share/bash-completion/completions/git ]] && source /usr/share/bash-completion/completions/git
fi
# Fix aliased git completion.
__git_complete g __git_main

# Init fzf.
[[ -n $(command -v fzf) ]] && eval "$(fzf --bash)"
# Activate mise.
[[ -n $(command -v mise) ]] && eval "$(mise activate bash)"
# Init starship.
[[ -n $(command -v starship) ]] && eval "$(starship init bash)"
# Init cargo.
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Only display MOTD in interactive shells.
[[ "$-" == *i* ]] && motd
