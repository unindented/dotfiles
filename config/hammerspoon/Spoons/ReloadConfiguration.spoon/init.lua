--- === ReloadConfiguration ===
---
--- Adds a hotkey to reload your configuration, and a pathwatcher to automatically reload on
--- changes.

local obj = {}
obj.__index = obj

--- ReloadConfiguration.watch_paths
--- Variable
--- List of directories to watch for changes, defaults to `hs.configdir`.
obj.watch_paths = { hs.configdir }

--- ReloadConfiguration:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for ReloadConfiguration
---
--- Parameters:
---  * mapping - A table containing hotkey modifier/key details for the following items:
---   * reloadConfiguration - This will cause the configuration to be reloaded
function obj:bindHotkeys(mapping)
  local def = { reloadConfiguration = hs.fnutils.partial(hs.reload, self) }
  hs.spoons.bindHotkeysToSpec(def, mapping)
end

--- ReloadConfiguration:start()
--- Method
--- Start ReloadConfiguration
---
--- Parameters:
---  * None
function obj:start()
  self.watchers = {}
  for _, dir in pairs(self.watch_paths) do
    self.watchers[dir] = hs.pathwatcher.new(dir, hs.reload):start()
  end
  return self
end

return obj
