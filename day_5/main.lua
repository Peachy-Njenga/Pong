--the ball update
_G.push = require 'push'

Class = require 'class'

require 'paddle'
require 'ball'

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

--retouch on randomseed 
    math.randomseed(os.time())

        _G.smallFont = love.graphics.newFont('font.ttf', 10)

        -- _G.scoreFont = love.graphics.newFont('font.ttf', 30)

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
        
        player1 = Paddle(5, 10, 2, 15)
        player2 = Paddle(VIRTUAL_WIDTH-5, 10, 2,15)

        ball = Ball(VIRTUAL_WIDTH/2 + 5, VIRTUAL_HEIGHT/2 - 2, 4, 4)
        
        gameState = 'Start'
end

function love.update(dt)
    --player 1 movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    --player 2 movement 
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()

    elseif key == 'enter' or key =='return' then
        if gameState == 'Start' then
            gameState = 'play'
        else 
            gameState = 'Start'

            ball:reset()
        end
    end    
end

function love.draw()
    push:apply('start')

    love.graphics.clear(0.5, 0, 0, 1)

    love.graphics.setFont(smallFont)

    if gameState == 'Start' then
        love.graphics.printf("Welkie to Pong, Start state!!",
        0,
        15,
        VIRTUAL_WIDTH,
        'center')

    else
        love.graphics.printf("Welkie to Pong, Play State!!",
        0,
        15,
        VIRTUAL_WIDTH,
        'center')
    
    end

    player1:render()
    player2:render()

    ball:render()

    push:apply('end')
end
