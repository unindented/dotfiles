if [ "$(arch)" = "arm64" ]; then
  eval $(/opt/homebrew/bin/brew shellenv);
else
  eval $(/usr/local/bin/brew shellenv);
fi

source ~/.bash/aliases
source ~/.bash/functions
source ~/.bash/environment
source ~/.bash/config

[[ -s "$NVM_HOME/nvm.sh" ]] && source "$NVM_HOME/nvm.sh"
[[ -s "$PYENV_ROOT/bin/pyenv" ]] && eval "$($PYENV_ROOT/bin/pyenv init -)"
[[ -s "$RBENV_HOME/bin/rbenv" ]] && eval "$($RBENV_HOME/bin/rbenv init -)"

eval "$(starship init bash)"
source "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"

# Fix aliased git completion.
__git_complete g __git_main

# Only display MOTD in interactive shells.
[[ "$-" == *i* ]] && motd

# Do not display zsh warning.
export BASH_SILENCE_DEPRECATION_WARNING=1
