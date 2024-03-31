local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Checking OS
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- Set default domain to wsl
	config.default_domain = "WSL:Ubuntu"
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	-- Set background blur if the OS is macOS
	config.macos_window_background_blur = 20
end

-- Custom config
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.6

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
config.font = wezterm.font("MesloLGS NF", { weight = "Regular" })
config.font_size = 14.0
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
local act = wezterm.action
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- copy to clipboard
	{ key = "c", mods = "CTRL|CMD", action = act.CopyTo("ClipboardAndPrimarySelection") },
	-- paste from the clipboard
	{ key = "v", mods = "CTRL|CMD", action = act.PasteFrom("Clipboard") },

	-- paste from the primary selection
	{ key = "v", mods = "CTRL|CMD", action = act.PasteFrom("PrimarySelection") },

	-- Just make macOS behaves a bit like Linux
	{
		key = "b",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x1bb" }),
	},
	{
		key = "f",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x1bf" }),
	},

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

return config
