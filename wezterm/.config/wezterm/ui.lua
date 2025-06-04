return function(wezterm, config)
	config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" })
	config.font_size = 17

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
