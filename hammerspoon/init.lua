-- Don't perform animations when resizing
hs.window.animationDuration = 0

-- Window handling {{{

-- Resize window for chunk of screen
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

-- }}}

-- Run or activate app {{{

local cmd_ctrl = {"ctrl", "cmd"}

hs.hotkey.bind(cmd_ctrl, "a", function()
    hs.application.launchOrFocus("Arc") end)

hs.hotkey.bind(cmd_ctrl, "c", function()
    hs.application.launchOrFocus("Claude") end)

hs.hotkey.bind(cmd_ctrl, "l", function()
    hs.application.launchOrFocus("Linear") end)

hs.hotkey.bind(cmd_ctrl, "m", function()
    hs.application.launchOrFocus("Spotify") end)

hs.hotkey.bind(cmd_ctrl, "n", function()
    hs.application.launchOrFocus("Notion") end)

hs.hotkey.bind(cmd_ctrl, "s", function()
    hs.application.launchOrFocus("Slack") end)

hs.hotkey.bind(cmd_ctrl, "t", function()
    hs.application.launchOrFocus("Telegram") end)

hs.hotkey.bind(cmd_ctrl, "v", function()
    hs.application.launchOrFocus("Visual Studio Code") end)

hs.hotkey.bind(cmd_ctrl, "w", function()
    hs.application.launchOrFocus("Whatsapp") end)

-- }}}
