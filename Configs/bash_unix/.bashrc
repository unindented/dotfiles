# Source all my stuff.
source "$HOME/.config/bash/01_environment.bash"
source "$HOME/.config/bash/02_aliases.bash"
source "$HOME/.config/bash/03_functions.bash"
source "$HOME/.config/bash/04_misc.bash"

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
