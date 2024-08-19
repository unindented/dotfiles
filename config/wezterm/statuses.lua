local wezterm = require("wezterm")

local module = {}

local function get_key_table_segment(window, color_scheme)
  local segments = {}
  local key_table = window:active_key_table()
  if key_table then
    table.insert(segments, {
      color = color_scheme.ansi[8],
      letter = "K",
      text = key_table,
    })
  end
  return segments
end

local function get_workspace_segment(window, color_scheme)
  local segments = {}
  local workspace = window:active_workspace()
  table.insert(segments, {
    color = color_scheme.ansi[3],
    letter = "W",
    text = workspace,
  })
  return segments
end

local function get_battery_segments(window, color_scheme)
  local segments = {}
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(segments, {
      color = color_scheme.ansi[7],
      letter = "B",
      text = string.format("%.0f%%", b.state_of_charge * 100),
    })
  end
  return segments
end

local function get_date_time_segment(window, color_scheme)
  local segments = {}
  table.insert(segments, {
    color = color_scheme.ansi[5],
    letter = "D",
    text = wezterm.strftime("%Y-%m-%d %H:%M"),
  })
  return segments
end

function module.update_right_status(window, pane)
  local color_scheme = window:effective_config().resolved_palette

  local key_table = get_key_table_segment(window, color_scheme)
  local workspace = get_workspace_segment(window, color_scheme)
  local battery = get_battery_segments(window, color_scheme)
  local date_time = get_date_time_segment(window, color_scheme)

  local segments = {}
  table.move(key_table, 1, #key_table, #segments + 1, segments)
  table.move(workspace, 1, #workspace, #segments + 1, segments)
  table.move(battery, 1, #battery, #segments + 1, segments)
  table.move(date_time, 1, #date_time, #segments + 1, segments)

  local letter_bg = color_scheme.foreground
  local letter_fg = color_scheme.background
  local text_bg = color_scheme.background
  local text_fg = color_scheme.foreground

  local elements = {}

  for i, segment in ipairs(segments) do
    table.insert(
      elements,
      { Background = { Color = segment.color or letter_bg } }
    )
    table.insert(elements, { Foreground = { Color = letter_fg } })
    table.insert(elements, { Text = " " .. segment.letter .. " " })
    table.insert(elements, { Background = { Color = text_bg } })
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Text = " " .. segment.text .. " " })
  end

  window:set_right_status(wezterm.format(elements))
end

return module
