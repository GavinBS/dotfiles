local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("options")(config)
require("ui")(wezterm, config)
require("keys")(wezterm, config)

return config
