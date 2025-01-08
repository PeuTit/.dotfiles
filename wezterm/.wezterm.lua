local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font_size = 11.0

local dark_theme = 'Londontube (dark) (terminal.sexy)'
local light_theme = 'Londontube (light) (terminal.sexy)'

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return dark_theme
  else
    return light_theme
  end
end

wezterm.on('window-config-reloaded', function(window)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

local font = wezterm.font_with_fallback({
  { family = 'Iosevka Term', weight = 'ExtraBold', stretch = 'Expanded', style = 'Normal' },
  'JetBrains Mono',
  'Apple Color Emoji'
})

config.font = font

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window {}
  window:gui_window():maximize()
end)

config.automatically_reload_config = true

return config
