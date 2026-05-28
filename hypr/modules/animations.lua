--------------------
---- ANIMATIONS ----
--------------------
hl.config({
    animations = {
        enabled = true,
    }
})

-- Custom Beziers & Springs
hl.curve("workspace_overshoot", { type = "bezier", points = { {0.34, 1.3}, {0.64, 1} } })
hl.curve("window_smooth",       { type = "spring", mass = 1, stiffness = 85, dampening = 15 })
hl.curve("border_flow",         { type = "bezier", points = { {0.25, 1}, {0.5, 1} } })
hl.curve("linear",              { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("rofi_blast",          { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

-- Workspaces
hl.animation({ leaf = "workspaces",    enabled = true, speed = 5.0, bezier = "workspace_overshoot", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 5.0, bezier = "workspace_overshoot", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5.0, bezier = "workspace_overshoot", style = "slide" })

-- Windows
hl.animation({ leaf = "windows",       enabled = true, speed = 5.2, spring = "window_smooth" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.8, spring = "window_smooth", style = "popin 85%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 3.8, bezier = "linear",        style = "popin 85%" })

-- Borders
hl.animation({ leaf = "border",        enabled = true, speed = 6.0, bezier = "border_flow" })

-- Layers
hl.animation({ leaf = "layers",        enabled = true, speed = 1.8, bezier = "rofi_blast" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 1.8, bezier = "rofi_blast", style = "popin 0%" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5, bezier = "linear",     style = "popin 0%" })

-- Global Fade fallbacks
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 2.0, bezier = "linear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 2.0, bezier = "linear" })
