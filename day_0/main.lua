
_G.love = require("love")
--[[
    setting the dimensions of the window, both thw width and the height
]]
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 700

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
---@diagnostic disable-next-line: duplicate-set-field
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
    })
end

--[[
    Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    love.graphics.printf(
        'Welkie to Pong!',          -- text to render
        0,                      -- starting X (0 since we're going to center it based on width)
        WINDOW_HEIGHT / 2 - 6,  -- starting Y (halfway down the screen)
        WINDOW_WIDTH,           -- number of pixels to center within (the entire screen here)
        'center')               -- alignment mode, can be 'center', 'left', or 'right'
end
