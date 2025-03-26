local wezterm = require("wezterm")
local appearance = require("appearance")
local keys = require("keys")
local statuses = require("statuses")
local tabs = require("tabs")

local act = wezterm.action

local config = wezterm.config_builder()

-- Color scheme.
if appearance.is_light() then
  config.color_scheme = "Catppuccin Latte (Custom)"
else
  config.color_scheme = "Catppuccin Mocha (Custom)"
end

-- Initial size.
config.initial_cols = 120
config.initial_rows = 36

-- Remove the title bar.
config.window_decorations = "RESIZE"
-- Set the window background opacity and blur.
config.window_background_opacity = 0.95
config.macos_window_background_blur = 32
-- Don't change window size.
config.adjust_window_size_when_changing_font_size = false
-- Don't prompt on close.
config.window_close_confirmation = "NeverPrompt"

-- No audible bell.
config.audible_bell = "Disabled"
-- Fast visual bell.
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 10,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 10,
  target = "BackgroundColor",
}

-- Font settings.
config.font = wezterm.font("Cascadia Mono NF")
config.font_size = 18.0
config.window_frame = {
  font = wezterm.font("Cascadia Mono NF"),
  font_size = 18.0,
}
config.char_select_font_size = 18.0
config.command_palette_font_size = 18.0

-- Increase scrollback.
config.scrollback_lines = 100000

-- Tabs.
config.tab_max_width = 18
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
wezterm.on("format-tab-title", tabs.format_tab_title)

-- Right status.
wezterm.on("update-right-status", statuses.update_right_status)

-- Customize hyperlink rules, with defaults as base.
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- No default key bindings.
config.disable_default_key_bindings = true
-- Leader.
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
-- Custom key bindings.
config.keys = {
  -- Send leader.
  { key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
  -- Reload config.
  { key = "R", mods = "CTRL", action = act.ReloadConfiguration },
  { key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
  { key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
  { key = "r", mods = "SUPER", action = act.ReloadConfiguration },
  -- Hide app.
  { key = "H", mods = "CTRL", action = act.HideApplication },
  { key = "H", mods = "SHIFT|CTRL", action = act.HideApplication },
  { key = "h", mods = "SHIFT|CTRL", action = act.HideApplication },
  { key = "h", mods = "SUPER", action = act.HideApplication },
  -- Quit app.
  { key = "Q", mods = "CTRL", action = act.QuitApplication },
  { key = "Q", mods = "SHIFT|CTRL", action = act.QuitApplication },
  { key = "q", mods = "SHIFT|CTRL", action = act.QuitApplication },
  { key = "q", mods = "SUPER", action = act.QuitApplication },
  -- New tab.
  { key = "T", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "T", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
  -- New window.
  { key = "N", mods = "CTRL", action = act.SpawnWindow },
  { key = "N", mods = "SHIFT|CTRL", action = act.SpawnWindow },
  { key = "n", mods = "SHIFT|CTRL", action = act.SpawnWindow },
  { key = "n", mods = "SUPER", action = act.SpawnWindow },
  -- Split horizontal.
  { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "\\", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Left" }) },
  { key = "|", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Left" }) },
  -- Split vertical.
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Up" }) },
  { key = "_", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Up" }) },
  -- Close tab.
  { key = "W", mods = "CTRL", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "W", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
  -- Copy.
  { key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
  { key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
  { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
  { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
  { key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
  -- Paste.
  { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  { key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
  { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
  { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
  { key = "Paste", mods = "NONE", action = act.CopyTo("Clipboard") },
  -- Clear scrollback.
  { key = "k", mods = "CTRL", action = act.ClearScrollback("ScrollbackAndViewport") },
  { key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackAndViewport") },
  { key = "K", mods = "CTRL", action = keys.ClearScrollbackAndViewportAndRedraw() },
  { key = "K", mods = "SHIFT|CTRL", action = keys.ClearScrollbackAndViewportAndRedraw() },
  { key = "K", mods = "SUPER", action = keys.ClearScrollbackAndViewportAndRedraw() },
  { key = "K", mods = "SHIFT|SUPER", action = keys.ClearScrollbackAndViewportAndRedraw() },
  { key = "k", mods = "SHIFT|CTRL", action = keys.ClearScrollbackAndViewportAndRedraw() },
  { key = "k", mods = "SHIFT|SUPER", action = keys.ClearScrollbackAndViewportAndRedraw() },
  -- Quick select mode.
  { key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
  -- Character selection.
  { key = "E", mods = "CTRL", action = act.CharSelect },
  { key = "E", mods = "SHIFT|CTRL", action = act.CharSelect },
  { key = "E", mods = "SUPER", action = act.CharSelect },
  { key = "E", mods = "SHIFT|SUPER", action = act.CharSelect },
  { key = "e", mods = "SHIFT|CTRL", action = act.CharSelect },
  { key = "e", mods = "SHIFT|SUPER", action = act.CharSelect },
  -- Copy mode.
  { key = "X", mods = "CTRL", action = act.ActivateCopyMode },
  { key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
  { key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
  -- Command palette.
  { key = "P", mods = "CTRL", action = act.ActivateCommandPalette },
  { key = "P", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
  { key = "P", mods = "SUPER", action = act.ActivateCommandPalette },
  { key = "P", mods = "SHIFT|SUPER", action = act.ActivateCommandPalette },
  { key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
  { key = "p", mods = "SHIFT|SUPER", action = act.ActivateCommandPalette },
  -- Search.
  { key = "F", mods = "CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "F", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "f", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
  -- Increase font size.
  { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
  { key = "=", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
  { key = "=", mods = "SUPER", action = act.IncreaseFontSize },
  { key = "+", mods = "CTRL", action = act.IncreaseFontSize },
  { key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
  -- Decrease font size.
  { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
  { key = "-", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
  { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
  { key = "_", mods = "CTRL", action = act.DecreaseFontSize },
  { key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
  -- Reset font size.
  { key = "0", mods = "CTRL", action = act.ResetFontSize },
  { key = "0", mods = "SHIFT|CTRL", action = act.ResetFontSize },
  { key = "0", mods = "SUPER", action = act.ResetFontSize },
  { key = ")", mods = "CTRL", action = act.ResetFontSize },
  { key = ")", mods = "SHIFT|CTRL", action = act.ResetFontSize },
  -- Toggle full screen.
  { key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
  -- Minimize window.
  { key = "M", mods = "CTRL", action = act.Hide },
  { key = "M", mods = "SHIFT|CTRL", action = act.Hide },
  { key = "m", mods = "SHIFT|CTRL", action = act.Hide },
  { key = "m", mods = "SUPER", action = act.Hide },
  -- Previous tab.
  { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
  { key = "LeftArrow", mods = "SUPER", action = act.ActivateTabRelative(-1) },
  -- Next tab.
  { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
  { key = "RightArrow", mods = "SUPER", action = act.ActivateTabRelative(1) },
  -- Resize pane.
  { key = "H", mods = "LEADER", action = keys.AdjustPaneSize({ "Left", 5 }) },
  { key = "H", mods = "LEADER|SHIFT", action = keys.AdjustPaneSize({ "Left", 5 }) },
  { key = "h", mods = "LEADER|SHIFT", action = keys.AdjustPaneSize({ "Left", 5 }) },
  { key = "J", mods = "LEADER", action = keys.AdjustPaneSize({ "Down", 5 }) },
  { key = "J", mods = "LEADER|SHIFT", action = keys.AdjustPaneSize({ "Down", 5 }) },
  { key = "j", mods = "LEADER|SHIFT", action = keys.AdjustPaneSize({ "Down", 5 }) },
  { key = "K", mods = "LEADER", action = keys.AdjustPaneSize({ "Up", 5 }) },
  { key = "K", mods = "LEADER|SHIFT", action = keys.AdjustPaneSize({ "Up", 5 }) },
  { key = "k", mods = "LEADER|SHIFT", action = keys.AdjustPaneSize({ "Up", 5 }) },
  { key = "L", mods = "LEADER", action = keys.AdjustPaneSize({ "Right", 5 }) },
  { key = "L", mods = "LEADER|SHIFT", action = keys.AdjustPaneSize({ "Right", 5 }) },
  { key = "l", mods = "LEADER|SHIFT", action = keys.AdjustPaneSize({ "Right", 5 }) },
  -- Select pane.
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  -- Toggle pane zoom.
  { key = "Z", mods = "CTRL", action = act.TogglePaneZoomState },
  { key = "Z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
  { key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
  -- Edit configuration.
  { key = ",", mods = "SUPER", action = keys.EditConfigFile() },
  -- Show debug overlay.
  { key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
  { key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
  { key = "L", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
}
-- Custom key tables.
config.key_tables = {
  activate_pane = {
    { key = "h", mods = "NONE", action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = "NONE", action = act.ActivatePaneDirection("Right") },
    { key = "k", mods = "NONE", action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = "NONE", action = act.ActivatePaneDirection("Down") },
    { key = "Escape", mods = "NONE", action = "PopKeyTable" },
  },
  resize_pane = {
    { key = "H", mods = "NONE", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "H", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "h", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "J", mods = "NONE", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "J", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "j", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "K", mods = "NONE", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "K", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "k", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "L", mods = "NONE", action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = "L", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = "l", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = "Escape", mods = "NONE", action = "PopKeyTable" },
  },
}
-- Custom mouse bindings.
config.mouse_bindings = {
  -- Don't open hyperlinks with click, just select text.
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("ClipboardAndPrimarySelection"),
  },
  -- Open hyperlinks if holding SHIFT|CTRL or SUPER.
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "SHIFT|CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = act.OpenLinkAtMouseCursor,
  },
  -- https://wezfurlong.org/wezterm/config/mouse.html#gotcha-on-binding-an-up-event-only
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "SHIFT|CTRL",
    action = act.Nop,
  },
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = act.Nop,
  },
}

return config
