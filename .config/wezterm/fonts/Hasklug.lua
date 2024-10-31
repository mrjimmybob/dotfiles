local wezterm = require("wezterm")
local M = {}
local name = "Hasklug"

M.init = function()
  return name
end

M.activate = function(config)
  config.font = wezterm.font("Hasklug Nerd Font Mono")
  config.font_size = 16.0
  config.line_height = 0.9
  config.harfbuzz_features = {}
  config.font_rules = {}
end

return M
