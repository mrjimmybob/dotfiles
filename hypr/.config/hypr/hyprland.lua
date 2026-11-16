-- Hyprland 0.57.1 migration of dallas's previous hyprland.conf
-- Original file remains unchanged. Review this file before replacing hyprland.lua.
-- Based on the Hyprland 0.57 Lua API.

-- MONITOR: retain the exact DP-2 mode, position and scaling from the old config.
hl.monitor({
	output = "DP-3",
	mode = "3840x2160@59.997002",
	position = "0x0",
	scale = 1.0,
})
-- Any other connected display uses its preferred mode.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- ENVIRONMENT
hl.env("XCURSOR_SIZE", "34")

-- INPUT, APPEARANCE AND LAYOUT
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "intl",
		kb_model = "",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",
		follow_mouse = 1,
		touchpad = { natural_scroll = false },
		sensitivity = 0,
	},
	general = {
		gaps_in = 10,
		gaps_out = 20,
		border_size = 2,
		col = {
			active_border = {
				colors = { "rgba(98971aee)", "rgba(d79921ee)" },
				angle = 45,
			},
			inactive_border = "rgba(a89984aa)",
		},
		layout = "dwindle",
	},
	decoration = {
		rounding = 20,
		blur = { enabled = true, size = 3, passes = 1 },
	},
	animations = { enabled = true },
	dwindle = { preserve_split = true },
})

-- ANIMATIONS: same curve, speeds and effects as before.
hl.curve("myBezier", {
	type = "bezier",
	points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "default" })

-- APPLICATIONS AND SESSION CONTROLS
hl.bind("SUPER + G", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + code:36", hl.dsp.exec_cmd("kitty")) -- original Super+Enter
hl.bind("SUPER + X", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + H", hl.dsp.exec_cmd("pcmanfm"))
hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + C", hl.dsp.reload_config())
hl.bind("SUPER + D", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind("SUPER + S", hl.dsp.window.pseudo())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + A", hl.dsp.exec_cmd("wlogout -p layer-shell"))
hl.bind("SUPER + Space", hl.dsp.exec_cmd("nwg-drawer"))

-- GROUPS
-- Original Super+G and Super+Tab conflicted with other shortcuts.
-- Preserve both functions by moving grouping to Super+Shift+G and
-- group navigation to Super+Alt+Tab / Super+Alt+Shift+Tab.
hl.bind("SUPER + SHIFT + G", hl.dsp.group.toggle())
hl.bind("SUPER + ALT + Tab", hl.dsp.group.next())
hl.bind("SUPER + ALT + SHIFT + Tab", hl.dsp.group.prev())

-- WORKSPACE CYCLING
hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("ALT + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind("SUPER + CTRL + Right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + CTRL + Left", hl.dsp.focus({ workspace = "m-1" }))
hl.bind("SUPER + Tab", hl.dsp.window.cycle_next())
hl.bind("SUPER + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- WINDOW FOCUS AND SWAP
for key, direction in pairs({ Left = "l", Right = "r", Up = "u", Down = "d" }) do
	hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = direction }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = direction }))
end
for key, direction in pairs({ H = "l", L = "r", K = "u", J = "d" }) do
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = direction }))
end

-- QWERTY WORKSPACES (1-10), WINDOW MOVES AND WALLPAPERS
-- Same keys and image names as the old configuration.
local workspace_keys = { "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P" }
for i, key in ipairs(workspace_keys) do
	local ws = tostring(i)
	local image = (i == 10) and "0.png" or (ws .. ".png")

	hl.bind("SUPER + " .. key, function()
		hl.dispatch(hl.dsp.focus({ workspace = ws }))
		hl.exec_cmd('hyprctl hyprpaper wallpaper "DP-3,$HOME/.config/hypr/walls/' .. image .. '"')
	end)
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws, follow = true }))
	hl.bind("SUPER + CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws, follow = false }))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- SCREENSHOTS
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grim"))
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)"'))

-- AUTOSTART: runs on the NEXT Hyprland session start, not on config reload.
hl.on("hyprland.start", function()
	-- Noctalia may not be installed yet due to the Qt version conflict.
	hl.exec_cmd("noctalia")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("/usr/libexec/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("$HOME/.config/hypr/scripts/hypr-watch.sh")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("dunst")
end)

-- NOT YET MIGRATED: source = ./dms/cursor.conf
-- The legacy .conf cannot be imported via Lua's require().
-- Convert the contents of dms/cursor.conf separately if still needed.
