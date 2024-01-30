_G.push = require 'Pong.day_22.push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 700

VIRTUAL_WIDTH = 300
VIRTUAL_HEIGHT = 200

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
--[[
    this imports the font from the .ttf file in the smae directory. 
    import the font and assign it to a global variable then set the font 
]]
    _G.smallFont = love.graphics.newFont('font.ttf', 10)

    _G.scoreFont = love.graphics.newFont('font.ttf', 30)

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

_G.player1Score = 0
_G.player2Score = 0

_G.player1pad = 10
_G.player2pad = VIRTUAL_HEIGHT - 10

function love.update(dt)
    --player 1 mov't
    if love.keyboard.isDown('w') then
        player1pad = player1pad + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1pad = player1pad + PADDLE_SPEED *dt
    end
    --player 2 movt 

    if love.keyboard.isDown('up') then
        player2pad = player2pad + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2pad = player2pad + PADDLE_SPEED *dt
    end
end


function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(0.5, 0, 0, 1) --RGBA : red, green, blue, alpha. alpha is the opacity. these nmbers should all range from 0 to 1. use colour  picker an ddivide numbers by 255

    love.graphics.setFont(smallFont)
    love.graphics.printf("Welkie to Pong!",
                         0,
                         15,
                         VIRTUAL_WIDTH,
                         'center')
    
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 -30, VIRTUAL_HEIGHT/2 -50)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 +30, VIRTUAL_HEIGHT/2 -50)
--[[
    drawing the paddles and the ball for the game. Position them according to the virtual box. note above: the position of the welkin messag ealso changed
]]
    love.graphics.rectangle('fill',5, player1pad ,2,15)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 5, player2pad, 2, 15)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 + 5, VIRTUAL_HEIGHT/2 - 2, 4, 4)

    push:apply('end')
end
