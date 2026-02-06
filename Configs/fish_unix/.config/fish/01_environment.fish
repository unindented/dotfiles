# ------------------------------------------------------------------------------
# XDG
# ------------------------------------------------------------------------------

set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"
set -x XDG_CACHE_HOME "$HOME/.cache"

# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------

fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.local/bin"

# ------------------------------------------------------------------------------
# LS
# ------------------------------------------------------------------------------

if test (uname) = 'Darwin'
    set -x LSCOLORS exfxcxdxbxegedabagacad
end
if command -q vivid
    set -x LS_COLORS (vivid generate catppuccin-mocha)
else
    set -x LS_COLORS 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
end

# ------------------------------------------------------------------------------
# FZF
# ------------------------------------------------------------------------------

# Catppuccin Latte
#set -x FZF_DEFAULT_OPTS "\
#--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
#--color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
#--color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
#--color=selected-bg:#BCC0CC \
#--color=border:#9CA0B0,label:#4C4F69"
# Catppuccin Frappé
#set -x FZF_DEFAULT_OPTS "\
#--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
#--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
#--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
#--color=selected-bg:#51576D \
#--color=border:#737994,label:#C6D0F5"
# Catppuccin Macchiato
#set -x FZF_DEFAULT_OPTS "\
#--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
#--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
#--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
#--color=selected-bg:#494D64 \
#--color=border:#6E738D,label:#CAD3F5"
# Catppuccin Mocha
set -x FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"
