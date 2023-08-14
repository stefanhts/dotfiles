-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.font = wezterm.font { family = 'Liga SFMono Nerd Font' }
config.font_size = 19

config.color_scheme = "Dracula (Official)"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)


config.keys = {
    -- ToggleFullScreen
    {
        key = 'n',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.ToggleFullScreen,
    },
    -- This will create a new split and run your default program inside it
    {
        key = "'",
        mods = 'CTRL',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = "s",
        mods = 'CTRL',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- Switch between panes
    {
        key = 'LeftArrow',
        mods = 'SHIFT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'RightArrow',
        mods = 'SHIFT',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'UpArrow',
        mods = 'SHIFT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'DownArrow',
        mods = 'SHIFT',
        action = act.ActivatePaneDirection 'Down',
    },
    -- Switch to the default workspace
    {
        key = 'y',
        mods = 'CTRL|SHIFT',
        action = act.SwitchToWorkspace {
            name = 'default',
        },
    },
    {
        key = '9',
        mods = 'CTRL',
        action = act.ShowLauncherArgs {
            flags = 'WORKSPACES'
        }
    },
    -- Switch to a monitoring workspace, which will have `top` launched into it
    {
        key = 'u',
        mods = 'CTRL|SHIFT',
        action = act.SwitchToWorkspace {
            name = 'monitoring',
            spawn = {
                args = { 'top' },
            },
        },
    },
    { key = 'l', mods = 'CTRL',       action = wezterm.action.ShowLauncher },
    -- Create a new workspace with a random name and switch to it
    { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
    -- Show the launcher in fuzzy selection mode and have it list all workspaces
    -- and allow activating one.
    {
        key = "h",
        mods = 'CTRL',
        action = act.ShowLauncherArgs {
            flags = 'WORKSPACES|DOMAINS',
        },
    },
}


-- and finally, return the configuration to wezterm
return config
