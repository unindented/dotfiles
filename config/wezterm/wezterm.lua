local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("Cascadia Code NF")
config.font_size = 18.0

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_decorations = "RESIZE"
config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}

return config
