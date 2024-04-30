--the ball update
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

--retouch on randomseed 
    math.randomseed(os.time())

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
        
        _G.player1Score = 0
        _G.player2Score = 0
        
        _G.player1pad = 10
        _G.player2pad = VIRTUAL_HEIGHT - 10
        
        --ball position at start of the game
        _G.ballX = VIRTUAL_WIDTH/2 + 5
        _G.ballY = VIRTUAL_HEIGHT/2 - 2
        
        --Ball velocity at start of the game (find meaning of the D in DX and DY)
        _G.ballDX = math.random(2) == 1 and 100 or -100 
        -- _G.ballDX = math.random(-50, 50)
        _G.ballDY = math.random(-50, 50)
        
        gameState = 'Start'
end

function love.update(dt)
    --player 1 mov't and adding limits to the paddle movement 
    if love.keyboard.isDown('w') then
        player1pad = math.max(0, player1pad + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1pad = math.min(VIRTUAL_HEIGHT - 15, player1pad + PADDLE_SPEED *dt)
    end
    --player 2 movt and adding limits to the paddle.

    if love.keyboard.isDown('up') then
        player2pad = math.max(0, player2pad + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2pad = math.min(VIRTUAL_HEIGHT-15, player2pad + PADDLE_SPEED *dt)
    end

    if gameState == 'play' then 
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end


function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    elseif key == 'enter' or key == 'return' then   
        if gameState == 'Start' then
            gameState = 'play'
        else
            gameState = 'Start'

            ballX = VIRTUAL_WIDTH/2 + 5
            ballY = VIRTUAL_HEIGHT/2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50)
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(0.5, 0, 0, 1) --RGBA : red, green, blue, alpha. alpha is the opacity. these nmbers should all range from 0 to 1. use colour  picker an ddivide numbers by 255

    love.graphics.setFont(smallFont)
    if gameState == 'Start' then
        love.graphics.printf("Welkie to Pong!",
        0,
        15,
        VIRTUAL_WIDTH,
        'center')
    else
        love.graphics.printf("Play state Pong!",
        0,
        15,
        VIRTUAL_WIDTH,
        'center') 
        
    end
    -- love.graphics.setFont(scoreFont)
    -- love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 -30, VIRTUAL_HEIGHT/2 -50)
    -- love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 +30, VIRTUAL_HEIGHT/2 -50)
--[[
    drawing the paddles and the ball for the game. Position them according to the virtual box. note above: the position of the welkin messag ealso changed
]]
    love.graphics.rectangle('fill',5, player1pad ,2,15)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 5, player2pad, 2, 15)

    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    push:apply('end')
end
