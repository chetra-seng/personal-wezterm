local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Checking OS
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- Set default domain to wsl
	config.default_domain = "WSL:Ubuntu"
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	-- Set background blur if the OS is macOS
	config.macos_window_background_blur = 5
end

-- Custom config
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.9

-- Get builtin color_scheme
local tokyo_night = wezterm.color.get_builtin_schemes()["Tokyo Night"]
tokyo_night.background = "black"

-- Create new reference color_scheme to custom color_scheme
config.color_schemes = {
	["My Tokyo Night"] = tokyo_night,
}

-- Set color_scheme to new custom color_scheme
config.color_scheme = "My Tokyo Night"

-- Other customization
config.font = wezterm.font({
	family = "FiraCode Nerd Font",
	weight = "Regular",
	harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
})
config.font_size = 16.0
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.window_decorations = "RESIZE"

-- Leader key config
config.keys = {}

-- Config CTRL-c and CTRL-v
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "|",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
}

config.enable_kitty_graphics = true

return config
