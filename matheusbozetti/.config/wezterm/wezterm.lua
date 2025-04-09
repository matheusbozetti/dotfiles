local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config = {
	color_scheme = "rose-pine",
	macos_window_background_blur = 50,

	status_update_interval = 1000,
	use_fancy_tab_bar = false,
	automatically_reload_config = true,
	enable_tab_bar = true,
	tab_bar_at_bottom = false,

	window_close_confirmation = "NeverPrompt",
	-- window_decorations = "RESIZE",
	window_background_opacity = 0.80,
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
	font = wezterm.font_with_fallback({
		{ family = "Hasklug Nerd Font", scale = 1.28 },
		{ family = "Zed Mono", scale = 1.30 },
	}),
}

return config
