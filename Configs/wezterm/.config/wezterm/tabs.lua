local wezterm = require("wezterm")

local module = {}

local function current_working_dir(tab)
  local dir = tab.active_pane.current_working_dir
  if not dir then
    return nil
  end

  local path = dir.path

  -- Replace home directory with `~`.
  local home = os.getenv("HOME")
  if home and path:sub(1, #home) == home then
    path = "~" .. path:sub(#home + 1)
  end

  -- Split the path into components.
  local components = {}
  for component in string.gmatch(path, "[^/]+") do
    table.insert(components, component)
  end

  -- Shorten each component except the last to one character.
  for i = 1, #components - 1 do
    components[i] = components[i]:sub(1, 1)
  end

  -- Join the components back into a single string.
  return table.concat(components, "/")
end

local function tab_title(tab)
  local title = tab.tab_title
  if #title > 0 then
    return title
  end
  return tab.active_pane.title
end

function module.format_tab_title(tab, tabs, panes, config, hover, max_width)
  local is_active = tab.is_active

  local has_unseen_output = false
  for _, pane in ipairs(tab.panes) do
    if pane.has_unseen_output then
      has_unseen_output = true
      break
    end
  end

  local color_scheme = config.resolved_palette

  local text_bg = color_scheme.background
  local text_fg = color_scheme.foreground
  local text_hover_bg = color_scheme.tab_bar.new_tab.bg_color
  local text_hover_fg = text_fg
  local index_bg = color_scheme.ansi[5]
  local index_fg = text_bg
  local index_unseen_bg = color_scheme.ansi[4]
  local index_unseen_fg = index_fg
  local index_active_bg = color_scheme.tab_bar.active_tab.bg_color
  local index_active_fg = color_scheme.tab_bar.active_tab.fg_color

  if has_unseen_output then
    index_bg = index_unseen_bg
    index_fg = index_unseen_fg
  elseif is_active then
    index_bg = index_active_bg
    index_fg = index_active_fg
    text_bg = text_hover_bg
    text_fg = text_hover_fg
  end
  if hover then
    text_bg = text_hover_bg
    text_fg = text_hover_fg
  end

  local dir = current_working_dir(tab)
  local title = tab_title(tab)
  local text = wezterm.truncate_right(dir or title, max_width - 5)

  return {
    { Background = { Color = index_bg } },
    { Foreground = { Color = index_fg } },
    { Text = " " .. tab.tab_index .. " " },
    { Background = { Color = text_bg } },
    { Foreground = { Color = text_fg } },
    { Text = " " .. text .. " " },
  }
end

return module
