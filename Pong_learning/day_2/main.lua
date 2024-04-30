_G.push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 700

VIRTUAL_WIDTH = 300
VIRTUAL_HEIGHT = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
--[[
    this imports the font from the .ttf file in the smae directory. 
    import the font and assign it to a global variable then set the font 
]]
    _G.smallFont = love.graphics.newFont('font.ttf', 10)

    love.graphics.setFont(smallFont)

    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            fullscreen = false,
            resizable = false,
            vsync = true
        }
    )
end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(0.5, 0, 0, 1) --RGBA : red, green, blue, alpha. alpha is the opacity. these nmbers should all range from 0 to 1. use colou picker an ddivide numbers by 255
    love.graphics.printf("Welkie to Pong!",
                         0,
                         15,
                         VIRTUAL_WIDTH,
                         'center')
    
--[[
    drawing the paddles and the ball for the game. Position them according to the virtual box. note above: the position of the welkin messag ealso changed
]]
    love.graphics.rectangle('fill',5,50 ,2,15)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 5, VIRTUAL_HEIGHT - 50, 2, 15)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - 2, VIRTUAL_HEIGHT/2 - 2, 4, 4)

    push:apply('end')
end

