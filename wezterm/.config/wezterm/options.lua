return function(wezterm, config)
	config.automatically_reload_config = true
	config.enable_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = true
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false

	config.window_close_confirmation = "NeverPrompt"

	config.window_decorations = "RESIZE"
	config.window_background_opacity = 0.95

	config.mouse_bindings = {
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.StartWindowDrag,
		},
	}
end
