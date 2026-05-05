local variables = require('hyprland.variables')

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "0x0",
    scale = 1.0,
})


hl.on("hyprland.start", function() 
    hl.exec_cmd("uwsm app qs")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("avizo-service")
end)

hl.on("monitor.added", function(m)
end)

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 15,

        border_size = 2,

        col = {
            active_border = {
                colors = { "rgb(0e0834)", "rgb(a277ff)", angle=45 },
            },
            inactive_border = "rgba(595959aa)"
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = variables.layout,
    },

    decoration = {
        rounding = 4,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = .95,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        -- https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 3,
            passes = 1,

            vibrancy = 0.1696,
        }
    },
    animations = {
        enabled = true --yes, please :)
    },
})

animations = require('hyprland.animations')

rules = require('hyprland.rules')


hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "inherit",
    },
    scrolling = {

    }
})


hl.config({ 
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = false,
        font_family = "JetBrainsMono Nerd Font",
    },
    debug = {
        disable_logs = false,
    },
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },
    }, 
    binds = {
        workspace_back_and_forth = true 
    },
})

plugins = require('hyprland.plugins')

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
--hl.gesture({
--    fingers = 3,
--    direction = "vertical",
--    action = "dispatcher",
--    arg = "hyprexpo:expo,toggle"
--})
hl.gesture({
    fingers = 4,
    direction = "vertical",
    action = "special",
    arg = "magic",
})
hl.gesture({
    fingers = 2, 
    direction = "pinchout", 
    action = "cursorZoom",
    arg = "2.0",
    arg2 = "mult" 
})
hl.gesture({
    fingers = 2, 
    direction = "pinchin", 
    action = "cursorZoom",
    arg = "-2.0",
    arg2 = "mult" 
})

local mainMod = variables.mainMod
local win     = variables.win

hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(variables.terminal))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float("toggle"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(variables.menu))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({internal = 2, client = 2, action = "toggle" }))

hl.bind(mainMod .. " + left", hl.dsp.focus({direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({direction = "down" }))

hl.bind(mainMod .. " + SHIFT + up", hl.dsp.focus({workspace = "e+1"}))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.focus({workspace = "e-1"}))

if variables.layout == "master" then
    hl.bind(mainMod .. " + SHIFT + left", hl.dsp.layout("swapnext"))
    hl.bind(mainMod .. " + SHIFT + right", hl.dsp.layout("swapprev"))
elseif variables.layout == "scrolling" then
    hl.bind(mainMod .. " + SHIFT + left", hl.dsp.layout("swapcol l"))
    hl.bind(mainMod .. " + SHIFT + right", hl.dsp.layout("swapcol r"))
    hl.bind(mainMod .. " + SHIFT + F", hl.dsp.layout("fit active"))
    hl.bind(mainMod .. " + SHIFT + space", hl.dsp.layout("fit visible"))
end

for i = 1,10 do
    local key = i % 10
    hl.bind(mainMod .. " + " ..key, hl.dsp.focus({workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({workspace = i}))
    -- hl.bind(mainMod .. " + SUPER + " .. key, xtd.bringallfrom({workspace = i}))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1"}))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true})

hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"))
--hl.bind("switch:on:Lid Switch", function()
--    hl.monitor({ output = "eDP-1", disabled = true })
--end)
--hl.bind("switch:off:Lid Siwtch", function()
 --   hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })
--end)


hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volumectl -u up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volumectl -u down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("volumectl toggle-mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("volumectl -m toggle-mute"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("lightctl up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("lightctl down"), { locked = true, repeating = true })

hl.bind(mainMod .. " + XF86MonBrightnessUp", hl.dsp.exec_cmd("lightctl set $(brightnessctl -m m)"))
hl.bind(mainMod .. " + XF86MonBrightnessDown", hl.dsp.exec_cmd("lightctl set 1"))

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("XF86Display", hl.dsp.exec_cmd("nwg-displays"))
hl.bind("XF86WLAN", hl.dsp.exec_cmd("$HOME/.config/hypr/network.sh"))
hl.bind("XF86Tools", hl.dsp.exec_cmd(variables.terminal .. " -e nvim $HOME/.config/hypr/hyprland.lua"))

hl.bind(mainMod .. " + XF86Display", hl.dsp.dpms("toggle"), { locked = true})
hl.bind(win .. " + XF86Display", function()
    hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "0x0",
        scale = 1 
    })
end)

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function() 
    hl.bind("right", hl.dsp.window.resize({x = 10, y = 0, relative = true}), {repeating = true})
    hl.bind("left", hl.dsp.window.resize({x = -10, y = 0, relative = true}), {repeating = true})
    hl.bind("up", hl.dsp.window.resize({x = 0, y = -10, relative = true}), {repeating = true})
    hl.bind("down", hl.dsp.window.resize({x = 0, y = 10, relative = true}), {repeating = true})

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
end)


