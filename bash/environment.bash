# ------------------------------------------------------------------------------
# HOMEBREW
# ------------------------------------------------------------------------------

if [[ "$OSTYPE" =~ ^darwin && "$(arch)" = "arm64" ]]; then
  [[ -s /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" =~ ^darwin ]]; then
  [[ -s /usr/local/bin/brew ]] && eval "$(/usr/local/bin/brew shellenv)"
fi

# ------------------------------------------------------------------------------
# XDG
# ------------------------------------------------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------

export PATH="$HOME/.local/bin:$PATH"

# ------------------------------------------------------------------------------
# FZF
# ------------------------------------------------------------------------------

# Cattpuccin Latte
#export FZF_DEFAULT_OPTS=" \
#--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
#--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
#--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
# Catppuccin Frappé
#export FZF_DEFAULT_OPTS=" \
#--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
#--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
#--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
# Catppuccin Macchiato
#export FZF_DEFAULT_OPTS=" \
#--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
#--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
#--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
# Catppuccin Mocha
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# ------------------------------------------------------------------------------
# LS
# ------------------------------------------------------------------------------

if [[ "$OSTYPE" =~ ^darwin ]]; then
  export LSCOLORS='exfxcxdxbxegedabagacad'
fi
if [[ -n $(command -v vivid) ]]; then
  export LS_COLORS="$(vivid generate catppuccin-mocha)"
else
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
fi
