local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

return {
	-- color_scheme = "Solarized (dark) (terminal.sexy)",
	color_scheme = "Solarized Dark Higher Contrast",
	scrollback_lines = 3500,
	font_size = 12.0,
	-- font = wezterm.font("JetBrains Mono", { weight = "Light" }),
	font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Light" }),
	macos_window_background_blur = 30,

	line_height = 1.1,

	window_background_image = "/Users/dongilkim/Downloads/bg/pexels-iaia881-122588.jpg",
	window_background_image_hsb = {
		brightness = 0.02,
		hue = 1.0,
		saturation = 0.5,
	},
	-- window_padding = {
	-- 	left = 0,
	-- 	right = 0,
	-- 	top = 0,
	-- 	bottom = 0,
	-- },

	-- general options
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	adjust_window_size_when_changing_font_size = false,

	keys = {
		-- {
		-- 	key = "f",
		-- 	mods = "ALT",
		-- 	action = wezterm.action.ToggleFullScreen,
		-- },
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Right" } },
			mods = "CMD",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
