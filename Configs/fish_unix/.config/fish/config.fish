source "$HOME/.config/fish/01_environment.fish"
source "$HOME/.config/fish/02_aliases.fish"
source "$HOME/.config/fish/03_misc.fish"

# Init fzf.
if command -q fzf
    fzf --fish | source
end
# Init jj.
if command -q jj
    jj util completion fish | source
end
# Activate mise.
if command -q mise
    mise activate fish | source
end
# Init starship.
if command -q starship
    starship init fish | source
end
# Init zoxide.
if command -q zoxide
    zoxide init fish | source
end
