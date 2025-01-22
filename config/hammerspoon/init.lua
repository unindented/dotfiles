hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local hyper = { "alt", "shift", "ctrl", "cmd" }

local function launchOrFocus(name)
  return function()
    hs.application.launchOrFocus(name)
  end
end

hs.hotkey.bind(hyper, "c", launchOrFocus("Visual Studio Code"))
hs.hotkey.bind(hyper, "e", launchOrFocus("Emacs"))
hs.hotkey.bind(hyper, "s", launchOrFocus("Safari"))
hs.hotkey.bind(hyper, "t", launchOrFocus("WezTerm"))
hs.hotkey.bind(hyper, "z", launchOrFocus("Zotero"))
