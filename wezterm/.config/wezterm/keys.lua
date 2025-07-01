return function(wezterm, config)
	config.keys = {
		{
			key = "n",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ShowLauncher,
		},
	}
end
