--- === QuickLaunch ===
---
--- Adds hotkeys to launch apps.

local obj = {}
obj.__index = obj

--- QuickLaunch:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for QuickLaunch
---
--- Parameters:
---  * mapping - A table containing hotkey modifier/key details for each app to launch
---
--- A configuration example can be:
--- ```
--- local hyper = { "alt", "shift", "ctrl", "cmd" }
--- spoon.QuickLaunch:bindHotkeys({
---   ["Finder"] = { hyper, "f" },
---   ["Safari"] = { hyper, "s" },
---   ["Ghostty"] = { hyper, "t" },
--- })
--- ```
function obj:bindHotkeys(mapping)
  for app, key in pairs(mapping) do
    hs.hotkey.bindSpec(key, hs.fnutils.partial(hs.application.launchOrFocus, app))
  end
end

return obj
