local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

local function ActivateKeyTableWithTimeout(name, timeout)
  return act.ActivateKeyTable({
    name = name,
    one_shot = false,
    timeout_milliseconds = timeout,
  })
end

function module.ActivatePaneDirection(opts)
  return act.Multiple({
    act.ActivatePaneDirection(opts),
    ActivateKeyTableWithTimeout("activate_pane", 1000),
  })
end

function module.AdjustPaneSize(opts)
  return act.Multiple({
    act.AdjustPaneSize(opts),
    ActivateKeyTableWithTimeout("resize_pane", 1000),
  })
end

function module.ClearScrollbackAndViewportAndRedraw()
  return act.Multiple({
    act.ClearScrollback("ScrollbackAndViewport"),
    act.SendKey({ key = "l", mods = "CTRL" }),
  })
end

function module.EditConfigFile()
  return act.SpawnCommandInNewTab({
    cwd = wezterm.home_dir,
    args = { "vim", wezterm.config_file },
  })
end

return module
