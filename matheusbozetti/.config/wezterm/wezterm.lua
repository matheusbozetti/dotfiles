local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "rose-pine"
config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback({
	{ family = "Hasklug Nerd Font", scale = 1.26 },
})
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false

return config
