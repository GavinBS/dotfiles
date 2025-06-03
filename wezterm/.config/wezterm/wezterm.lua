local wezterm = require("wezterm")
local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,

	window_close_confirmation = "NeverPrompt",

	window_decorations = "RESIZE",
	window_background_opacity = 0.99,
	macos_window_background_blur = 20,

	initial_cols = 125,
	initial_rows = 30,

	font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
	font_size = 17,

	color_scheme = "Dracula",
}

return config
