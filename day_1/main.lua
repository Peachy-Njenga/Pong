_G.push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 700

VIRTUAL_WIDTH = 300
VIRTUAL_HEIGHT = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
   
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

    love.graphics.clear(0.5, 0, 0, 1) --RGBA : red, green, blue, alpha. alpha is the opacity. these nmbers should all range from 0 to 1. use colour picker and divide numbers by 255
    love.graphics.printf("Welkie to Pong!",
                         0,
                         15,
                         VIRTUAL_WIDTH,
                         'center')

    push:apply('end')
end

