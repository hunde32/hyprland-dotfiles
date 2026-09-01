--------------------------
---- LAYER EXCEPTIONS ----
--------------------------
hl.layer_rule({
	name = "waybar-blur",
	match = { namespace = "waybar" },
	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	name = "swaync-blur-effects-second",
	match = { namespace = "swaync-control-center" },
	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	name = "swaync-blur-effects-first",
	match = { namespace = "swaync-notification-window" },
	blur = true,
	ignore_alpha = 0.5,
})
----------------------
---- WINDOW RULES ----
----------------------
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "force-nested-hyprland-size",
	match = {
		class = "aquamarine", -- Or match the class of your nested window title/process
	},
	size = "1920 1080",
	fullscreen = true,
})
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})
