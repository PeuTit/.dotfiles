local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font_size = 10.0

config.automatically_reload_config = true

return config
