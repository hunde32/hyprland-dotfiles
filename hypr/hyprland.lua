-- Add package path context if executing from custom runner environments
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/hypr/?.lua"

----------------------------------------------------
-- Modular Hyprland Wrapper Orchestration
----------------------------------------------------

require("modules.autostart")
require("modules.settings")
require("modules.keybinds")
require("modules.animations")
require("modules.rules")

hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})
