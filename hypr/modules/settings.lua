------------------
---- MONITORS ----
------------------
-- 1. Laptop Screen (Primary)
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60.056",
    position = "0x0",
    scale    = "1.2",
})

-- 2. Sony Projector (Mirroring)
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60.000",
    position = "0x0",
    scale    = "1",
    mirror   = "eDP-1",
})
---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-----------------------
---- DYNAMIC COLOR ----
-----------------------
local colors = { primary = "33ccff", secondary = "00ff99", surface = "595959" }
pcall(function()
    colors = require("colors")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 8,
        gaps_out = 18,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(" .. colors.primary .. "ee)", "rgba(" .. colors.secondary .. "ee)"}, angle = 45 },
            inactive_border = "rgba(" .. colors.surface .. "aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled           = true,
            size              = 8,
            passes            = 3,
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = false,
            vibrancy          = 0.2000,
            brightness        = 1.0,
            contrast          = 1.0,
        },
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})
