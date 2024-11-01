local wezterm = require("wezterm")
local M = {}
local name = "Operator Mono"

M.init = function()
  return name
end

M.activate = function(config)
  config.font = wezterm.font(name)
  config.font_size = 14.0
  config.line_height = 1.1
  config.harfbuzz_features = { "ss07", "ss08" }
  -- "ss16", -- stab-less 'r'
  -- config.harfbuzz_features = { "ss07=1", "ss08=1" }

  config.font_rules = {
    {
      intensity = "Bold",
      italic = false,
      font = wezterm.font("Operator Mono", { weight = "Bold" }),
    },
    {
      intensity = "Bold",
      italic = true,
      font = wezterm.font("Operator Mono", { weight = "Bold", style = "Italic" }),
    },
  }
end

return M