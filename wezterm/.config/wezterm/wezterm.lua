local wezterm = require("wezterm")
local platform = require("platform")(wezterm)
local config = wezterm.config_builder()

require("options")(wezterm, config)
require("ui")(wezterm, platform, config)
require("keys")(wezterm, config)
require("launch")(platform, config)

return config
