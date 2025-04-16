--- === WindowManager ===
---
--- Adds hotkeys to move and resize windows.

local obj = {}
obj.__index = obj

--- WindowManager.sizes
--- Variable
--- The sizes that the window can have. They are expressed as dividend of the entire screen's size.
--- For example `{2, 3, 3/2}` means that it can be 1/2, 1/3 and 2/3 of the total screen's size.
obj.sizes = { 2, 3, 3 / 2 }

--- WindowManager.fullScreenSizes
--- Variable
--- The sizes that the window can have in full-screen. They are expressed as dividend of the entire
--- screen's size. For example `{1, 4/3, 2}` means that it can be 1/1 (hence full screen), 3/4 and
--  1/2 of the total screen's size
obj.fullScreenSizes = { 1, 4 / 3, 2 }

--- WindowManager.GRID
--- Variable
--- The screen's size. It will be used to call `hs.grid.setGrid()` on initialization.
obj.GRID = { w = 24, h = 24 }

obj._pressed = {
  up = false,
  down = false,
  left = false,
  right = false,
}

function obj:_nextStep(dimension, offset, callback)
  -- Exit if no window is focused.
  if not hs.window.focusedWindow() then
    return
  end

  -- Determine axes based on the specified dimension.
  local axis = dimension == "w" and "x" or "y"
  local oppositeDimension = dimension == "w" and "h" or "w"
  local oppositeAxis = dimension == "w" and "y" or "x"

  -- Get the current window and its properties.
  local win = hs.window.frontmostWindow()
  local screen = win:screen()
  local cell = hs.grid.get(win, screen)

  -- Find the next appropriate size.
  local nextSize = self.sizes[1]
  for i = 1, #self.sizes do
    local currentSize = self.sizes[i]
    local isDimensionMatch = cell[dimension] == self.GRID[dimension] / currentSize
    local positionValue = cell[axis] + (offset and cell[dimension] or 0)
    local targetValue = offset and self.GRID[dimension] or 0

    if isDimensionMatch and positionValue == targetValue then
      nextSize = self.sizes[(i % #self.sizes) + 1]
      break
    end
  end

  -- Apply the callback to update cell dimensions.
  callback(cell, nextSize)

  -- Ensure the window fills the opposite dimension if partially off-screen.
  local isPartiallyOffscreen = cell[oppositeAxis] ~= 0
    and cell[oppositeAxis] + cell[oppositeDimension] ~= self.GRID[oppositeDimension]

  if isPartiallyOffscreen then
    cell[oppositeDimension] = self.GRID[oppositeDimension]
    cell[oppositeAxis] = 0
  end

  -- Apply the new cell dimensions to the window.
  hs.grid.set(win, cell, screen)
end

function obj:_nextFullScreenStep()
  -- Exit if no window is focused.
  if not hs.window.focusedWindow() then
    return
  end

  -- Get the current window and its properties.
  local win = hs.window.frontmostWindow()
  local screen = win:screen()
  local cell = hs.grid.get(win, screen)

  -- Find the next appropriate fullscreen size.
  local nextSize = self.fullScreenSizes[1]
  for i = 1, #self.fullScreenSizes do
    local currentSize = self.fullScreenSizes[i]
    local centerX = (self.GRID.w - self.GRID.w / currentSize) / 2
    local centerY = (self.GRID.h - self.GRID.h / currentSize) / 2
    local isWidthMatch = cell.w == self.GRID.w / currentSize
    local isHeightMatch = cell.h == self.GRID.h / currentSize
    local isXCentered = cell.x == centerX
    local isYCentered = cell.y == centerY

    if isWidthMatch and isHeightMatch and isXCentered and isYCentered then
      nextSize = self.fullScreenSizes[(i % #self.fullScreenSizes) + 1]
      break
    end
  end

  -- Calculate new centered cell dimensions.
  cell.w = self.GRID.w / nextSize
  cell.h = self.GRID.h / nextSize
  cell.x = (self.GRID.w - cell.w) / 2
  cell.y = (self.GRID.h - cell.h) / 2

  -- Apply the new cell dimensions to the window.
  hs.grid.set(win, cell, screen)
end

function obj:_moveScreenStep(direction)
  -- Exit if no window is focused.
  if not hs.window.focusedWindow() then
    return
  end

  -- Get the current window and its screen.
  local win = hs.window.frontmostWindow()
  local screen = win:screen()

  -- Move the window to the next/previous screen, preserving relative position.
  win:move(win:frame():toUnitRect(screen:frame()), screen[direction](screen), true, 0)
end

function obj:_fullDimension(dimension)
  -- Exit if no window is focused.
  if not hs.window.focusedWindow() then
    return
  end

  -- Get the current window and its properties.
  local win = hs.window.frontmostWindow()
  local screen = win:screen()
  local cell = hs.grid.get(win, screen)

  -- Fill the specified dimension while maintaining position in the other.
  cell[dimension] = self.GRID[dimension]
  cell[dimension == "w" and "x" or "y"] = 0

  -- Apply the new cell dimensions to the window.
  hs.grid.set(win, cell, screen)
end

--- WindowManager:bindHotkeys()
--- Method
--- Binds hotkeys for WindowManager
---
--- Parameters:
---  * mapping - A table containing hotkey details for the following items:
---   * up - Hotkey for the up action
---   * right - Hotkey for the right action
---   * down - Hotkey for the down action
---   * left - Hotkey for the left action
---   * fullscreen - Hotkey for the full-screen action
---   * nextscreen - Hotkey for the multi monitor next screen action
---   * prevscreen - Hotkey for the multi monitor previous screen action
---
--- A configuration example can be:
--- ```
--- local hyper = { "alt", "shift", "ctrl", "cmd" }
--- spoon.WindowManager:bindHotkeys({
---   up = { hyper, "up" },
---   right = { hyper, "right" },
---   down = { hyper, "down" },
---   left = { hyper, "left" },
---   fullscreen = { hyper, "f" },
---   nextscreen = { hyper, "n" },
---   prevscreen = { hyper, "p" },
--- })
--- ```
function obj:bindHotkeys(mapping)
  -- Up key bindings.
  hs.hotkey.bindSpec(mapping.up, function()
    self._pressed.up = true
    if self._pressed.down then
      -- If down is also pressed, expand to full height.
      self:_fullDimension("h")
    else
      -- Otherwise, position at top with next height.
      self:_nextStep("h", false, function(cell, nextSize)
        cell.y = 0
        cell.h = self.GRID.h / nextSize
      end)
    end
  end, function()
    self._pressed.up = false
  end)

  -- Right key bindings.
  hs.hotkey.bindSpec(mapping.right, function()
    self._pressed.right = true
    if self._pressed.left then
      -- If left is also pressed, expand to full width.
      self:_fullDimension("w")
    else
      -- Otherwise, position at right with next width.
      self:_nextStep("w", true, function(cell, nextSize)
        cell.x = self.GRID.w - self.GRID.w / nextSize
        cell.w = self.GRID.w / nextSize
      end)
    end
  end, function()
    self._pressed.right = false
  end)

  -- Down key bindings.
  hs.hotkey.bindSpec(mapping.down, function()
    self._pressed.down = true
    if self._pressed.up then
      -- If up is also pressed, expand to full height.
      self:_fullDimension("h")
    else
      -- Otherwise, position at bottom with next height.
      self:_nextStep("h", true, function(cell, nextSize)
        cell.y = self.GRID.h - self.GRID.h / nextSize
        cell.h = self.GRID.h / nextSize
      end)
    end
  end, function()
    self._pressed.down = false
  end)

  -- Left key bindings.
  hs.hotkey.bindSpec(mapping.left, function()
    self._pressed.left = true
    if self._pressed.right then
      -- If right is also pressed, expand to full width.
      self:_fullDimension("w")
    else
      -- Otherwise, position at left with next width.
      self:_nextStep("w", false, function(cell, nextSize)
        cell.x = 0
        cell.w = self.GRID.w / nextSize
      end)
    end
  end, function()
    self._pressed.left = false
  end)

  -- Fullscreen key binding.
  hs.hotkey.bindSpec(mapping.fullscreen, function()
    self:_nextFullScreenStep()
  end)

  -- Next screen key binding.
  hs.hotkey.bindSpec(mapping.nextscreen, function()
    self:_moveScreenStep("next")
  end)

  -- Previous screen key binding.
  hs.hotkey.bindSpec(mapping.prevscreen, function()
    self:_moveScreenStep("previous")
  end)
end

function obj:init()
  hs.grid.setGrid(obj.GRID.w .. "x" .. obj.GRID.h)
end

return obj
