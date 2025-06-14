return function(wezterm, config)
	config.keys = {
		{
			key = "n",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	}
end
