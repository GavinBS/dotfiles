return function(wezterm)
	local triple = wezterm.target_triple

	local is_win = string.find(triple, "windows") ~= nil
	local is_linux = string.find(triple, "linux") ~= nil
	local is_mac = string.find(triple, "apple") ~= nil
	local os

	if is_win then
		os = "windows"
	elseif is_linux then
		os = "linux"
	elseif is_mac then
		os = "mac"
	else
		error("Unknown platform")
	end

	return {
		os = os,
		is_win = is_win,
		is_linux = is_linux,
		is_mac = is_mac,
	}
end
