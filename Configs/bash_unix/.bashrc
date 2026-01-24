# Source all my stuff.
source "$HOME/.bash/environment.bash"
source "$HOME/.bash/aliases.bash"
source "$HOME/.bash/functions.bash"
source "$HOME/.bash/config.bash"

# Init fzf.
[[ -n $(command -v fzf) ]] && eval "$(fzf --bash)"
# Init jj.
[[ -n $(command -v jj) ]] && eval "$(jj util completion bash)"
# Activate mise.
[[ -n $(command -v mise) ]] && eval "$(mise activate bash)"
# Init starship.
[[ -n $(command -v starship) ]] && eval "$(starship init bash)"
# Init zoxide.
[[ -n $(command -v zoxide) ]] && eval "$(zoxide init bash)"
# Init cargo.
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Stop here if not an interactive shell.
[[ "$-" == *i* ]] || return

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

# Message of the day.
motd
