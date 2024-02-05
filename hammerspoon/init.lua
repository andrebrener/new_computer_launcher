-- To use the dev version, download master from git and then run `sh rebuild.sh`
-- following:
-- https://github.com/Hammerspoon/hammerspoon/blob/master/CONTRIBUTING.md#making-frequent-local-rebuilds-more-convenient

-- Preamble {{{

-- Modifier shortcuts
local cmd_ctrl = {"ctrl", "cmd"}

-- Reload (auto) hotkey script
hs.hotkey.bind(cmd_ctrl, "a", function()
  hs.reload()
  hs.alert("Hammerspoon config was reloaded.")
end)

-- Don't perform animations when resizing
hs.window.animationDuration = 0

-- Get list of screens and refresh that list whenever screens are plugged or
-- unplugged i.e initiate watcher
local screens = hs.screen.allScreens()
local screenwatcher = hs.screen.watcher.new(function()
                                                screens = hs.screen.allScreens()
                                            end)
screenwatcher:start()

-- }}}
-- Window handling {{{

-- Resize window for chunk of screen (this deprecates Spectable)
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function resize_win(x, y, w, h)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w * x)
	f.y = max.y + (max.h * y)
	f.w = max.w * w
	f.h = max.h * h
	win:setFrame(f)
end
hs.hotkey.bind({"shift"}, "left", function()
                resize_win(0,0,0.5,1) end) -- left
hs.hotkey.bind({"shift"}, "right", function()
                resize_win(0.5,0,0.5,1) end) -- right
hs.hotkey.bind({"shift"}, "up", function()
                resize_win(0,0,1,1) end) -- full
hs.hotkey.bind(cmd_ctrl, "1", function()
                resize_win(0,0,0.5,0.5) end) -- Top left quarter
hs.hotkey.bind(cmd_ctrl, "2", function()
                resize_win(0,0.5,0.5,0.5) end) -- Bottom left quarter
hs.hotkey.bind(cmd_ctrl, "3", function()
                resize_win(0.5,0,0.5,0.5) end) -- Top right quarter
hs.hotkey.bind(cmd_ctrl, "4", function()
                resize_win(0.5,0.5,0.5,0.5) end) -- Bottom right quarter
hs.hotkey.bind(cmd_ctrl, "5", function()
                resize_win(0.25,0.25,0.5,0.5) end) -- Center

-- Change window width (setting the grid first)
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 10
hs.grid.GRIDHEIGHT = 2
hs.hotkey.bind(cmd_ctrl, "-", function()
    hs.grid.resizeWindowThinner(hs.window.focusedWindow())
end)
hs.hotkey.bind(cmd_ctrl, "=", function()
    hs.grid.resizeWindowWider(hs.window.focusedWindow())
end)

-- Expose (show thumbnails of open windows with a hint)
hs.expose.ui.otherSpacesStripWidth = 0  -- I don't use other spaces
hs.expose.ui.highlightThumbnailStrokeWidth = 5
hs.expose.ui.textSize = 30
hs.expose.ui.nonVisibleStripWidth = 0.2
hs.expose.ui.nonVisibleStripBackgroundColor = {0.08, 0.08, 0.08}
expose = hs.expose.new()
hs.hotkey.bind(cmd_ctrl, "j", function() expose:toggleShow() end)

-- Window switcher (deprecates Hyperswitch)
hs.window.switcher.ui.showSelectedThumbnail = false
hs.window.switcher.ui.showTitles = false
hs.window.switcher.ui.textSize = 12
hs.window.switcher.ui.thumbnailSize = 180
hs.window.switcher.ui.backgroundColor = {0.2, 0.2, 0.2, 0.3} -- Greyish
hs.window.switcher.ui.titleBackgroundColor = {0, 0, 0, 0} -- Transparent
hs.window.switcher.ui.textColor = {0, 0, 0} -- Black
-- TODO: Show switcher on active screen
-- TODO: fix text paddling
switcher = hs.window.switcher.new(
                hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})
hs.hotkey.bind("alt", "tab", function() switcher:next() end)

-- }}}

-- Run or activate app {{{


hs.hotkey.bind(cmd_ctrl, "m", function()
                hs.application.launchOrFocus("Spotify") end)

hs.hotkey.bind(cmd_ctrl, "n", function()
    hs.application.launchOrFocus("Notion") end)

hs.hotkey.bind(cmd_ctrl, "a", function()
    hs.application.launchOrFocus("Arc") end)

hs.hotkey.bind(cmd_ctrl, "s", function()
                hs.application.launchOrFocus("Slack") end)

hs.hotkey.bind(cmd_ctrl, "t", function()
    hs.application.launchOrFocus("Telegram") end)

hs.hotkey.bind(cmd_ctrl, "c", function()
                hs.application.launchOrFocus("Google Chrome") end)

hs.hotkey.bind(cmd_ctrl, "v", function()
    hs.application.launchOrFocus("Visual Studio Code") end)

hs.hotkey.bind(cmd_ctrl, "w", function()
    hs.application.launchOrFocus("Whatsapp") end)

-- }}}

-- Move the mouse with the keyboard (requires vimouse.lua script)
local vimouse = require('vimouse')
vimouse({'shift', 'cmd'}, 'h')