-- Pull in the wezterm API
-- stylua: ignore start
local wezterm = require("wezterm")
local selector = require("config-selector")
local appearance = require("appearance")
local projects = require("projects")

-- This will hold the configuration.
local config   = wezterm.config_builder()

-- My dynamic configuration selectors
local fonts    = selector.new({ title = "Font Selector",          subdir = "fonts" })
local inactive = selector.new({ title = "Inactive Pane Selector", subdir = "inactivepanes" })
local leading  = selector.new({ title = "Font Leading Selector",  subdir = "leadings" })
local schemes  = selector.new({ title = "Color Scheme Selector",  subdir = "colorschemes" })
local sizes    = selector.new({ title = "Font Size Selector",     subdir = "sizes" })
local opacity  = selector.new({ title = "Opacity Selector",       subdir = "opacity" })

-- New Opacity cycling and dimming when unfocussed
local OPACITIES = { 1.0, 0.90, 0.80, 0.70, 0.60, 0.50 }
local DEFAULT_OPACITY = 0.97            -- opacity used at startup
local FOCUSED_HSB   = { brightness = 0.8, saturation = 1.0 }
local UNFOCUSED_HSB = { brightness = 0.4, saturation = 0.4 }

-- Keep track of the current opacity from cycling
local current_opacity = DEFAULT_OPACITY

-- Detect platform
local is_windows = wezterm.target_triple:find("windows") ~= nil
local home = wezterm.home_dir

-- Default tab names
local TAB_NAME_ICON   = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
-- Default tab icons
local TAB_NUMBER_ICON = {'󰎤', '󰎧', '󰎪', '󰎭', '󰎱', '󰎳', '󰎶', '󰎹', '󰎼', '󰎡' }
-- Default zoomed tab icons
local TAB_ZOOMED_ICON = {'󰼏', '󰼐', '󰼑', '󰼒', '󰼓', '󰼔', '󰼕', '󰼖', '󰼗', '󰼎' }
-- .. utf8.char(0x1f30a) -- ocean wave       󰠗  󱜺  .
local LEADER_ICON = "  "
if is_windows then
	LEADER_ICON = "  "
end
-- local TAB_NAME_ICON   = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
-- local TAB_NAME_ICON   = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
-- local TAB_NAME_ICON   = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
-- local TAB_NAME_ICON   = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
-- local TAB_NAME_ICON   = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
-- local TAB_NAME_ICON   = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
-- local TAB_NAME_ICON   = {'󰖳 ❯', '󰖳 ❯', '󰖳 ❯', '󰖳 ❯', '󰖳 ❯', '󰖳 ❯', '󰖳 ❯', '󰖳 ❯', '󰖳 ❯' }
-- local TAB_NAME_ICON   = {' ❯', ' ❯', ' ❯', ' ❯', ' ❯', ' ❯', ' ❯', ' ❯', ' ❯' }
-- local magnify_icon = ' '
-- local magnify_icon = '󰍉 '
-- local magnify_icon = '󱉶 '
-- local magnify_icon = ' 󰛭 '
-- local magnify_icon = '🔎'
--               .
--       󰣚  󰣭                                      󰖳  .
-- local TAB_NUMBER_ICON = {'❶', '❷', '❸', '❹', '❺', '❻', '❼', '❽', '❾' }
-- local TAB_NUMBER_ICON = {'①', '②', '③', '④', '⑤', '⑥', '⑦', '⑧', '⑨' }
-- local TAB_NUMBER_ICON = {'⓵', '⓶', '⓷', '⓸', '⓹', '⓺', '⓻', '⓼', '⓽' }
-- Windows = '', '󰣇', '' , '󰀵' ,

-- stylua: ignore end

-- fonts:select(config, "Hasklug")
-- fonts:select(config, "Hasklug")
-- config.font = wezterm.font("Iosevka Custom")
-- config.font = wezterm.font("Monocraft Nerd Font")
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("FiraCode Nerd Font Ret")
-- config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = true })
-- config.font = wezterm.font("Hasklug Nerd Font Mono")
-- config.font = wezterm.font("JetBrains Mono Regular")
-- config.font = wezterm.font("Hasklig")
-- config.font = wezterm.font("Monoid Retina")
-- config.font = wezterm.font("InputMonoNarrow")
-- config.font = wezterm.font("mononoki Regular")
-- config.font = wezterm.font("Iosevka")
-- config.font = wezterm.font("M+ 1m")
-- config.font = wezterm.font("Hack Regular")
config.cell_width = 1
config.line_height = 1
config.font_size = 20.0 -- Or use font defined size!

-- config.font = wezterm.font_with_fallback({
-- 	"Victor Mono", "Consolas"
-- })

-- schemes:select(config, "Catppuccin Mocha")
if appearance.is_dark() then
	-- config.color_scheme = "Brewer (dark) (terminal.sexy)"
	-- config.color_scheme = "Tokyo Night"
	config.color_scheme = "Catppuccin Mocha"
else
	config.color_scheme = "Brewer (light) (terminal.sexy)"
	-- config.color_scheme = "Tokyo Night Day"
end

-- config.window_background_image = "C:\\Users\\mr_ji\\.config\\wezterm\\wallpaper\\wall.jpg"
-- local wallpaper = is_windows and "C:\\Users\\mr_ji\\.config\\wezterm\\wallpaper\\wall.jpg" or "/home/dallas/.config/wezterm/wallpaper/wall.jpg"
-- local wallpaper = home .. "/.config/wezterm/wallpaper/wall.jpg"
local wallpaper = home .. "/.config/wezterm/wallpaper/wall2.jpg"
-- Fix Windows path slashes
if package.config:sub(1, 1) == "\\" then
	wallpaper = wallpaper:gsub("/", "\\")
end

config.window_background_image = wallpaper

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
config.use_resize_increments = false
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false

-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.window_decorations = "NONE|RESIZE"
-- config.window_frame = { font = wezterm.font({ family = "JetBrains Mono", weight = "ExtraBold" }), font_size = 12, }
config.window_frame =
	{ font = wezterm.font({ family = "Iosevka Custom", weight = "Regular" }), active_titlebar_bg = "#0c0b0f" }

config.mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
}
config.window_background_opacity = current_opacity
-- config.window_close_confirmation = "AlwaysPrompt"
config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}
config.prefer_egl = true

-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = true

-- config.inactive_pane_hsb = {
-- 	saturation = 0.0,
-- 	brightness = 1.0,
-- }

-- config.front_end = "OpenGL"
-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus and gpus[1] or nil
config.front_end = "WebGpu"

config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

local user = os.getenv("USER") or os.getenv("USERNAME") or os.getenv("LOGNAME")
if user == "mr_ji" then
	-- initialDirectory = "D:\\MyDocuments"
	-- config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-wd", "D:\\MyDocuments", "-NoLogo" }
	config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-wd", "D:\\MyDocuments", "-NoLogo" }
elseif user == "USRVA36" then
	config.default_prog = { "pwsh.exe", "-wd", "D:\\Datos\\CodigoFuente", "-NoLogo" }
else
	-- config.default_prog = { "pwsh.exe" }
	-- config.default_prog = { "/bin/fish", "-wd", initialDirectory, "-NoLogo" }
end

config.initial_cols = 110
config.initial_rows = 28

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
-- keymaps
-- stylua: ignore
config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to be potentially recognized and handled by the tab
	{ key = "m", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },

	{ key = '{', mods = 'SHIFT|CTRL', action = wezterm.action.RotatePanes 'CounterClockwise', },
	{ key = '}', mods = 'SHIFT|CTRL', action = wezterm.action.RotatePanes 'Clockwise' },
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Prev") },
	{ key = "]", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Next") },

	-- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane mode until we cancel that mode.
	{ key = "r", mods = "LEADER", action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
	-- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane mode until we press some other key
	-- or until 1 second (1000ms) of time elapses
	{ key = "a", mods = "LEADER", action = wezterm.action.ActivateKeyTable({ name = "activate_pane", timeout_milliseconds = 1000 }), },

	{ key = "r", mods = "SHIFT|CTRL|ALT", action = wezterm.action.ReloadConfiguration },
	{ key = "l", mods = "SHIFT|CTRL|ALT", action = wezterm.action.ShowDebugOverlay },
	{ key = "f", mods = "LEADER", action = wezterm.action.ToggleFullScreen },
	{ key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "/", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
	{ key = "v", mods = "LEADER", action = wezterm.action.SplitPane({ direction = "Right", size = { Percent = 50 } }), },
	{ key = "s", mods = "LEADER", action = wezterm.action.PaneSelect },
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	{ key = "n", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = 'n', mods = 'SHIFT|CTRL', action = wezterm.action.SpawnWindow },
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "w", mods = "LEADER", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	-- paste from the clipboard
	{ key = "V", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	-- paste from the primary selection
	-- { key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'PrimarySelection' },

	-- These work by default:
	{ key = '=', mods = 'SHIFT|CTRL', action = 'IncreaseFontSize' },
	{ key = '-', mods = 'SHIFT|CTRL', action = 'DecreaseFontSize' },
	-- { key = "=", mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent "kaz-inc-font-size" },
	-- { key = "-", mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent "kaz-dec-font-size" },
	-- { key = 'd', mods = 'SHIFT|CTRL', action = wezterm.action.ResetFontSize },
	{ key = 'd', mods = 'SHIFT|CTRL', action = wezterm.action.ResetFontAndWindowSize, },

	-- Theme Cycler
	--{ key = "t", mods = "SHIFT|CTRL", action = wezterm.action_callback(themeCycler) },
	{ key = "t", mods = "LEADER", action = wezterm.action.EmitEvent "cycleTheme" },

	-- Or choose theme from selector
	{ key = "t", mods = "SHIFT|CTRL", action = schemes:selector_action() },

	-- Toggle opacity
	{ key = "o", mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent "cycleOpacity" },
	{ key = ">", mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent "increaseOpacity" },
	{ key = "<", mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent "decreaseOpacity" },
	-- { key = "o", mods = "SHIFT|CTRL", action = wezterm.action_callback(toggleOpacity) },
	-- Or choose opacity from selector
	{ key = "o", mods = "LEADER", action = opacity:selector_action() },

	-- Toggle fonts
	{ key = "f", mods = "SHIFT|CTRL", action = fonts:selector_action() },
	{ key = "i", mods = "SHIFT|CTRL", action = inactive:selector_action() },
	{ key = "l", mods = "SHIFT|CTRL", action = leading:selector_action() },
	{ key = "s", mods = "SHIFT|CTRL", action = sizes:selector_action() },
	{ key = 'w', mods = 'SHIFT|CTRL', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },	},

	-- Prompt for tab name
	{
		key = 'e',
		mods = 'LEADER',
		action = wezterm.action.PromptInputLine {
			description = 'Enter new name for tab',
			-- initial_value = 'My Tab Name',
			action = wezterm.action_callback(function(window, pane, line)
				if not line then return end
				local t_index = window:active_tab():tab_id()+1
				wezterm.log_info("Change tab (" .. t_index .. ") name to: ".. line)
				if #line > 0 then
					TAB_NAME_ICON[t_index] = line
				else
					TAB_NAME_ICON[t_index] = ''
				end
				-- window:active_tab():set_title(TAB_NAME_ICON[window:active_tab():tab_id()-1])
				-- window:get_title(), window:set_title("something"), tab:get_title(), tab:set_title("something")
			end),
		},
	},

	-- Interactively picking a name and creating a new workspace
	{
		key = 'u',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.PromptInputLine {
			description = wezterm.format {
				{ Attribute = { Intensity = 'Bold' } },
				{ Foreground = { AnsiColor = 'Fuchsia' } },
				{ Text = 'Enter name for new workspace' },
			},
			action = wezterm.action_callback(function(window, pane, line)
			-- line will be `nil` if they hit escape without entering anything
			-- An empty string if they just hit enter or the actual line of text they wrote
			if line then
				window:perform_action(wezterm.action.SwitchToWorkspace { name = line, }, pane)
			end
		end),
		},
	},

	-- Present in to our project picker
	{ key = 'p', mods = 'LEADER', action = projects.choose_project(), },

	-- Present a list of existing workspaces
	{ key = 'l', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }, },
}

config.key_tables = {
	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,we made the
	-- activation one_shot=false. We therefore need to define a key
	-- assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},

	-- Defines the keys that are active in our activate-pane mode.
	-- 'activate_pane' here corresponds to the name="activate_pane" in
	-- the key assignments above.
	activate_pane = {
		{ key = "LeftArrow", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "RightArrow", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "UpArrow", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "DownArrow", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	},
}

-- For example, changing the color scheme:
--config.color_scheme = "Cloud (terminal.sexy)"
config.colors = {
	background = "#0c0b0f", -- dark purple
	cursor_border = "#bea3c7",
	cursor_bg = "#bea3c7",
	selection_fg = "#281733",

	tab_bar = {
		background = "#0c0b0f",
		active_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#bea3c7",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#f8f2f5",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		new_tab = {
			-- bg_color = "rgba(59, 34, 76, 50%)",
			bg_color = "#0c0b0f",
			fg_color = "white",
		},
	},
}

-- config.window_background_image = "C:/dev/misc/berk.png"
-- config.window_background_image_hsb = {
-- 	brightness = 0.1,
-- }

-- wezterm.on("gui-startup", function(cmd)
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	-- window:gui_window():maximize()
-- 	-- window:gui_window():set_position(0, 0)
-- end)

-- Event handlers

-- Show toast notification on configuration load:
-- wezterm.on('window-config-reloaded', function(window, pane)
-- 		window:toast_notification('wezterm', 'configuration reloaded!', nil, 4000)
-- end)

-- Cycle through builtin dark schemes in dark mode, and through light schemes in light mode

-- Theme cycling cache: builtin schemes don't change at runtime, so build the lists once.
local cached_dark_schemes = nil
local cached_light_schemes = nil

wezterm.on("cycleTheme", function(window, pane)
	-- Build dark/light scheme lists on first call and cache them.
	if not cached_dark_schemes then
		local allSchemes = wezterm.color.get_builtin_schemes()
		cached_dark_schemes = {}
		cached_light_schemes = {}
		for name, scheme in pairs(allSchemes) do
			if scheme.background then
				local bg = wezterm.color.parse(scheme.background)
				-- -@diagnostic disable-next-line: unused-local
				local h, s, l, a = bg:hsla()
				wezterm.log_info("s:" .. s .. ", a:" .. a .. ", h:" .. h)
				if l < 0.4 then
					table.insert(cached_dark_schemes, name)
				else
					table.insert(cached_light_schemes, name)
				end
			end
		end
	end

	local currentMode = wezterm.gui.get_appearance()
	local currentScheme = window:effective_config().color_scheme

	wezterm.log_info("Current Theme : " .. currentScheme)

	local schemesToSearch = currentMode:find("Dark") and cached_dark_schemes or cached_light_schemes

	for i = 1, #schemesToSearch, 1 do
		wezterm.log_info("Searching through " .. #schemesToSearch .. " schemes: " .. schemesToSearch[i])
		if schemesToSearch[i] == currentScheme then
			wezterm.log_info('Going to switch to theme: "' .. schemesToSearch[i + 1] .. '"')
			local overrides = window:get_config_overrides() or {}
			local next = schemesToSearch[i + 1] or schemesToSearch[1]
			overrides.color_scheme = next
			window:set_config_overrides(overrides)
			return
		end
	end
end)

-- Opacity: Cycle
wezterm.on("cycleOpacity", function(window)
	local overrides = window:get_config_overrides() or {}
	local next_opacity = DEFAULT_OPACITY

	for i, v in ipairs(OPACITIES) do
		if math.abs(v - current_opacity) < 0.001 then
			next_opacity = OPACITIES[i + 1] or OPACITIES[1]
			break
		end
	end

	current_opacity = next_opacity
	overrides.window_background_opacity = current_opacity

	-- Keep wallpaper brightness consistent with focus state
	if window:is_focused() then
		overrides.window_background_image_hsb = FOCUSED_HSB
	else
		overrides.window_background_image_hsb = UNFOCUSED_HSB
	end

	window:set_config_overrides(overrides)
end)

-- FOCUS-BASED WALLPAPER BRIGHTNESS
wezterm.on("window-focus-changed", function(window, pane)
	local overrides = window:get_config_overrides() or {}

	if window:is_focused() then
		overrides.window_background_image_hsb = FOCUSED_HSB
	else
		overrides.window_background_image_hsb = UNFOCUSED_HSB
	end

	-- Always preserve current opacity (startup or cycled)
	overrides.window_background_opacity = current_opacity

	window:set_config_overrides(overrides)
end)

-- Opacity: Increase
wezterm.on("increaseOpacity", function(window)
	local overrides = window:get_config_overrides() or {}
	overrides.window_background_opacity = (overrides.window_background_opacity or 0.9) + 0.1
	if overrides.window_background_opacity > 1.0 then
		overrides.window_background_opacity = 1.0
	end
	current_opacity = overrides.window_background_opacity
	window:set_config_overrides(overrides)
end)

-- Opacity: Decrease
wezterm.on("decreaseOpacity", function(window)
	local overrides = window:get_config_overrides() or {}
	overrides.window_background_opacity = (overrides.window_background_opacity or 0.9) - 0.1
	if overrides.window_background_opacity < 0 then
		overrides.window_background_opacity = 0
	end
	current_opacity = overrides.window_background_opacity
	window:set_config_overrides(overrides)
end)

-- Better increase font size
wezterm.on("kaz-inc-font-size", function(window)
	local size = window:effective_config().font_size + 1
	local overrides = window:get_config_overrides() or {}
	overrides.font_size = size
	window:set_config_overrides(overrides)
end)

-- Better decrease font size
wezterm.on("kaz-dec-font-size", function(window)
	local size = window:effective_config().font_size - 1
	local overrides = window:get_config_overrides() or {}
	overrides.font_size = size
	window:set_config_overrides(overrides)
end)

-- Pre-computed constant for format-tab-title (avoids per-call allocation)
local ACTIVE_TAB_COLOR = { Foreground = { Color = "#663A82" } }

-- Customize the tab title to show zoom icon when zoomed
wezterm.on("format-tab-title", function(tab)
	local attrs = {
		{ Foreground = { Color = "#777777" } },
	}
	if tab.is_active then
		table.insert(attrs, ACTIVE_TAB_COLOR)
	end
	local t_index = tab.tab_index + 1
	local t_num = TAB_NUMBER_ICON[t_index]
	local t_name = TAB_NAME_ICON[t_index]

	if tab.active_pane.is_zoomed then
		t_num = TAB_ZOOMED_ICON[t_index]
		table.insert(attrs, ACTIVE_TAB_COLOR)
	end

	-- wezterm.log_info("-----------------------")
	table.insert(attrs, {
		Text = " " .. t_num .. " " .. t_name,
	})
	return attrs
end)

-- Pre-computed constants for update-right-status (computed once at startup, not on every call)
local SOLID_LEFT_ARROW  = utf8.char(0xe0b2)
local STATUS_FOREGROUND = { Foreground = { Color = "Cyan" } }
local STATUS_TEXT_FG    = "#c0c0c0"
local STATUS_COLORS     = { "#3C1361", "#52307C", "#663A82", "#7C5295", "#B491C8" }

-- Hostname never changes; cache it once.
local cached_hostname = wezterm.hostname()

-- Battery info cache: wezterm.battery_info() is a system call; throttle to once per 30s.
local battery_cache = { cells = {}, last_time = 0 }
local BATTERY_CACHE_TTL = 30

-- Per-window cache to avoid redundant set_left_status / set_right_status API calls.
local window_status_cache = {}

-- Module-level push helper (avoids recreating a closure on every update-right-status call)
local function push_cell(elements, cell_no, text)
	table.insert(elements, { Foreground = { Color = STATUS_COLORS[cell_no] } })
	table.insert(elements, { Text = SOLID_LEFT_ARROW })
	table.insert(elements, { Foreground = { Color = STATUS_TEXT_FG } })
	table.insert(elements, { Background = { Color = STATUS_COLORS[cell_no] } })
	table.insert(elements, { Text = " " .. text .. " " })
end

wezterm.on("update-right-status", function(window, pane)
	local is_leader = window:leader_is_active()
	local win_id    = window:window_id()

	-- Initialize per-window cache on first sight of this window.
	if not window_status_cache[win_id] then
		window_status_cache[win_id] = { last_leader = nil, last_right = nil }
	end
	local cache = window_status_cache[win_id]

	-- Update left status only when leader state actually changes.
	if is_leader ~= cache.last_leader then
		cache.last_leader = is_leader
		window:set_left_status(wezterm.format({
			STATUS_FOREGROUND,
			{ Text = is_leader and LEADER_ICON or "" },
		}))
	end

	-- Each element holds the text for a cell in a "powerline" style << fade
	local cells = {}

	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		local cwd = ""
		local hostname = ""

		if type(cwd_uri) == "userdata" then
			-- Running on a newer version of wezterm and we have
			-- a URL object here, making this simple!

			cwd = cwd_uri.file_path
			hostname = cwd_uri.host or cached_hostname
		else
			-- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
			-- which doesn't have the Url object
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				-- and extract the cwd from the uri, decoding %-encoding
				cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end

		-- Remove the domain name portion of the hostname
		local dot = hostname:find("[.]")
		if dot then
			hostname = hostname:sub(1, dot - 1)
		end
		if hostname == "" then
			hostname = cached_hostname
		end

		table.insert(cells, cwd)
		table.insert(cells, hostname)
	end

	-- I like my date/time in this style: "Wed Mar 3 08:14"
	-- local date = wezterm.strftime("%a %b %-d %H:%M")
	local date = wezterm.strftime("%a %-d %b %H:%M")
	table.insert(cells, date)

	-- An entry for each battery, cached to avoid a system call every second.
	local now = os.time()
	if now - battery_cache.last_time >= BATTERY_CACHE_TTL then
		battery_cache.cells = {}
		for _, b in ipairs(wezterm.battery_info()) do
			table.insert(battery_cache.cells, string.format("%.0f%%", b.state_of_charge * 100))
		end
		battery_cache.last_time = now
	end
	for _, cell in ipairs(battery_cache.cells) do
		table.insert(cells, cell)
	end

	-- Build the formatted elements
	local elements = {}
	for i, text in ipairs(cells) do
		push_cell(elements, i, text)
	end

	-- Only call set_right_status when the rendered content actually changes.
	local right_status = wezterm.format(elements)
	if right_status ~= cache.last_right then
		cache.last_right = right_status
		window:set_right_status(right_status)
	end
end)

-- and finally, return the configuration to wezterm
return config
