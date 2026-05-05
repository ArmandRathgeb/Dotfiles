if rules then return end 
rules = {}

-- --
-- Window rules section
hl.window_rule({
    name = "supress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    match = { class = "scrcpy" },
    float = true,
})

hl.window_rule({
    match = { title = "MATLAB" },
    tile = true,
})


-- --
-- Workspace rules section
hl.workspace_rule({
    workspace="r[6-10]", monitor="DP-1" 
})
-- Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
hl.workspace_rule({
    workspace = "w[tv1]", gaps_out = 0, gaps_in = 0
})
-- workspace = f[1], gapsout:0, gapsin:0
-- windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
-- windowrule = rounding 0, floating:0, onworkspace:w[tv1]
-- windowrule = bordersize 0, floating:0, onworkspace:f[1]
-- windowrule = rounding 0, floating:0, onworkspace:f[1]


-- --
-- Layer rules section

hl.layer_rule({
    match = { class = "ashell*"},
    blur  = true,
})
hl.layer_rule({
    match = { class = "waybar*"},
    blur  = true,
})
hl.layer_rule({
    match = { class = "hyprpaper*"},
    blur  = false,
})

return rules
