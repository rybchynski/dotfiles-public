-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "ayu"
-- config.color_scheme = "nord"
-- config.color_scheme = "Solarized Dark - Patched"
-- config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Palenight (Gogh)"

-- config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font = wezterm.font("Monaspace Krypton")
config.font_size = 12

-- Tabs:
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.9

config.animation_fps = 1

-- prevent check for a new update.
config.check_for_updates = false

-- Custom keymaps:
config.keys = {
	{
		key = "i",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "o",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

-- and finally, return the configuration to wezterm
return config
