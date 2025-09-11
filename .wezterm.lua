local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.on("toggle-colorscheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.color_scheme then
		overrides.color_scheme = "Builtin Solarized Light"
	else
		overrides.color_scheme = nil
	end
	window:set_config_overrides(overrides)
end)

config.color_scheme = "Solarized (dark) (terminal.sexy)"

config.keys = {
	{
		key = "C",
		mods = "CMD|SHIFT",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
	{
		key = "S",
		mods = "CMD|SHIFT",
		action = wezterm.action.Multiple({
			wezterm.action.EmitEvent("toggle-colorscheme"),
			-- Send OSC sequence to notify applications
			wezterm.action.SendString("\x1b]1337;Custom=id=colorscheme_changed\x07"),
		}),
	},
}

return config
