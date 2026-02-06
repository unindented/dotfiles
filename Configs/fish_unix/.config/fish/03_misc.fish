# ------------------------------------------------------------------------------
# ENCODING
# ------------------------------------------------------------------------------

set -x LANGUAGE en
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# ------------------------------------------------------------------------------
# EDITOR AND PAGER
# ------------------------------------------------------------------------------

# Editor.
if command -q nvim
    set -x EDITOR nvim
else if command -q vim
    set -x EDITOR vim
else
    set -x EDITOR vi
end

# Pager.
if command -q less; and command -q bat
    set -x PAGER 'less -FirSwX'
    set -x MANPAGER 'bat -plman'
else if command -q less
    set -x PAGER 'less -FirSwX'
    set -x MANPAGER 'less -FiRswX'
else
    set -x PAGER more
    set -x MANPAGER $PAGER
end
