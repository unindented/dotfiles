hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local hyper = { "alt", "shift", "ctrl", "cmd" }
local meh = { "alt", "shift", "ctrl" }

hs.loadSpoon("QuickLaunch")
spoon.QuickLaunch:bindHotkeys({
  ["Visual Studio Code"] = { hyper, "c" },
  ["Emacs"] = { hyper, "e" },
  ["Finder"] = { hyper, "f" },
  ["Safari"] = { hyper, "s" },
  ["Ghostty"] = { hyper, "t" },
  ["Zotero"] = { hyper, "z" },
})

hs.grid.setMargins(8 .. "," .. 8)
hs.window.animationDuration = 0

hs.loadSpoon("WindowManager")
spoon.WindowManager:bindHotkeys({
  up = { meh, "up" },
  right = { meh, "right" },
  down = { meh, "down" },
  left = { meh, "left" },
  fullscreen = { meh, "f" },
  nextscreen = { meh, "n" },
  prevscreen = { meh, "p" },
})
