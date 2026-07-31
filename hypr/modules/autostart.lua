-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
	hl.exec_cmd(
		"waybar & awww-daemon & swaync & wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store"
	)
end)
-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- XDG Desktop Portal (Crucial for screen sharing and file pickers)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Toolkit Backends (Forces apps to use Wayland natively)
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- Qt Applications (Fixes scaling, removes ugly borders, enables themes)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1.2")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1.2")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct") -- Or qt6ct depending on your installed theming tool

-- Cursor Sizes
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
