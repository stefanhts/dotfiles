-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

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
    -- Cycle Tabs
    {
        key = 'h', mods = 'ALT', action = act.ActivateTabRelative(-1)
    },
    {
        key = 'l', mods = 'ALT', action = act.ActivateTabRelative(1)
    },
    -- Switch to the default workspace
    {
        key = 'W',
        mods = 'CTRL|SHIFT',
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
    {
        key = 'h',
        mods = 'CTRL',
        action = act.ShowLauncherArgs {
            flags = 'FUZZY|WORKSPACES'
        }
    },
    -- Switch to a monitoring workspace, which will have `top` launched into it
    {
        key = 'u',
        mods = 'CTRL|SHIFT',
        action = act.SwitchToWorkspace {
            name = 'github-status',
            spawn = {
                args = { 'top' },
            },
        },
    },
    { key = 'l', mods = 'CTRL',       action = wezterm.action.ShowLauncher },
    -- Create a new workspace with a random name and switch to it
    { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
    { key = 'l', mods = 'CTRL|SHIFT', action = act.SwitchWorkspaceRelative(1) },
    { key = 'h', mods = 'CTRL|SHIFT', action = act.SwitchWorkspaceRelative(-1) },
}

wezterm.on('gui-startup', function(cmd)
    local args = {}
    if cmd then
        args = cmd.args
    end

    local project_dir = wezterm.home_dir .. '/Work/repos/'
    local tab, build_pane, window = mux.spawn_window {
        workspace = 'coding',
        cwd = project_dir,
        args = args,
    }
    local editor_pane = build_pane:split {
        direction = 'Left',
        size = 0.6,
        cwd = project_dir,
    }
    build_pane:send_text 'nvim .\n'

    local notes_dir = wezterm.home_dir .. '/Work/notes'
    local tab, pane, window = mux.spawn_window {
        cwd = notes_dir,
        workspace = 'notes',
    }
    pane:send_text 'nvim . \n'
    mux.set_active_workspace 'coding'
end)


-- and finally, return the configuration to wezterm
return config
