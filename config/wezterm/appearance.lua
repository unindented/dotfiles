local wezterm = require("wezterm")

local module = {}

function module.is_light()
  return wezterm.gui and wezterm.gui.get_appearance():find("Light")
end

return module
