return function(wezterm, platform, config)
	if platform.is_win then
		config.initial_cols = 120
		config.initial_rows = 35
		config.font_size = 17
	elseif platform.is_mac then
		config.initial_cols = 120
		config.initial_rows = 35
		config.font_size = 17
		config.macos_window_background_blur = 30
	elseif platform.is_linux then
		config.initial_cols = 120
		config.initial_rows = 35
		config.font_size = 17
	end

	config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" })

	config.color_scheme = "Dracula"
	config.colors = {
		tab_bar = {
			background = "#1a1b26",

			active_tab = {
				bg_color = "#cba6f7",
				fg_color = "#000000",
				intensity = "Bold",
				italic = false,
			},

			inactive_tab = {
				bg_color = "#1e1e2e",
				fg_color = "#cdd6f4",
			},

			inactive_tab_hover = {
				bg_color = "#313244",
				fg_color = "#ffffff",
				italic = true,
			},

			new_tab = {
				bg_color = "#181825",
				fg_color = "#a6adc8",
			},

			new_tab_hover = {
				bg_color = "#313244",
				fg_color = "#ffffff",
				italic = true,
			},
		},
	}
end
