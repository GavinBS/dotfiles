return function(platform, config)
	if platform.is_win then
		config.default_prog = { "powershell.exe", "-NoLogo" }
		config.launch_menu = {
			{
				label = "Windows PowerShell",
				args = { "powershell.exe", "-NoLogo" },
			},
			{
				label = "CMD",
				args = { "cmd.exe" },
			},
			{
				label = "PowerShell 7",
				args = { "pwsh.exe" },
			},
		}
	elseif platform.is_mac then
		config.default_prog = { "/bin/zsh", "-l" }
		config.launch_menu = {
			{
				label = "Zsh",
				args = { "/bin/zsh", "-l" },
			},
			{
				label = "Bash",
				args = { "/bin/bash", "-l" },
			},
		}
	elseif platform.is_linux then
		config.default_prog = { "/bin/zsh", "-l" }
		config.launch_menu = {
			{
				label = "Zsh",
				args = { "/bin/zsh", "-l" },
			},
			{
				label = "Bash",
				args = { "/bin/bash", "-l" },
			},
		}
	end
end
