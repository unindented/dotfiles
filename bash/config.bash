# ------------------------------------------------------------------------------
# SHELL OPTIONS
# ------------------------------------------------------------------------------

# Correct minor errors in the spelling of a directory component in a `cd`
# command.
shopt -s cdspell >/dev/null 2>&1

# Check the window size after each command and, if necessary, update the values
# of the variables `LINES` and `COLUMNS`.
shopt -s checkwinsize >/dev/null 2>&1

# Enable extended pattern matching features.
shopt -s extglob >/dev/null 2>&1

# Enable recursive globbing with `**`.
shopt -s globstar >/dev/null 2>&1

# Append to the history file when the shell exits, rather than overwrite it.
shopt -s histappend >/dev/null 2>&1

# Save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist

# Don't search the path for possible completions when attempted on an empty
# line.
shopt -s no_empty_cmd_completion >/dev/null 2>&1

# Match filenames in a case-insensitive fashion when performing pathname
# expansion.
shopt -s nocaseglob >/dev/null 2>&1

# Notify of background job completion immediately.
set -o notify

# Default umask.
umask 0022

# ------------------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
# ------------------------------------------------------------------------------

# Encoding options.
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# History options.
HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL=ignoredups
HISTIGNORE='l:ll:ls:bg:fg'

# Terminal colors.
export TERM="xterm-256color"

# ------------------------------------------------------------------------------
# EDITOR AND PAGER
# ------------------------------------------------------------------------------

# Editor.
if [[ -n "$(command -v vim)" ]]; then
  EDITOR="vim"
else
  EDITOR="vi"
fi
export EDITOR

# Pager.
if [[ -n "$(command -v less)" && -n "$(command -v bat)" ]]; then
  PAGER="less -FirSwX"
  MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif [[ -n "$(command -v less)" ]]; then
  PAGER="less -FirSwX"
  MANPAGER="less -FiRswX"
else
  PAGER="more"
  MANPAGER="$PAGER"
fi
export PAGER MANPAGER
