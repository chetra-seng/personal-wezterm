local wezterm = require 'wezterm'
local config =  wezterm.config_builder()

-- Checking OS
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    -- Set default domain to wsl
    config.default_domain = 'WSL:Ubuntu'
end

-- Custom config
config.window_close_confirmation = 'NeverPrompt'
config.window_background_opacity = 0.6

-- Get builtin color_scheme
local tokyo_night = wezterm.color.get_builtin_schemes()['Tokyo Night']
tokyo_night.background = 'black';

-- Create new reference color_scheme to custom color_scheme
config.color_schemes = {
    ['My Tokyo Night'] = tokyo_night
}

-- Set color_scheme to new custom color_scheme
config.color_scheme = 'My Tokyo Night'

-- Config CTRL-c and CTRL-v
local act = wezterm.action
config.keys = {
    -- paste from the clipboard
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },

    -- paste from the primary selection
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
}

return config