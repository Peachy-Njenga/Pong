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

        love.window.setTitle("Pong!")
        
        _G.player1 = Paddle(5, 10, 2, 15)
        _G.player2 = Paddle(VIRTUAL_WIDTH-5, 10, 2,15)

        _G.ball = Ball(VIRTUAL_WIDTH/2 + 5, VIRTUAL_HEIGHT/2 - 2, 4, 4)
        
        gameState = 'Start'
end

_G.player1Score = 0
_G.player2Score = 0

function love.update(dt)

    if gameState == 'play' then
    
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x -4

            if ball.dy < 0 then
                ball.dy = -math.random(10,150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        --screen boundary collision
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= VIRTUAL_HEIGHT -4 then
            ball.y = VIRTUAL_HEIGHT -4
            ball.dy = -ball.dy
        end
    end

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

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 -30, VIRTUAL_HEIGHT/2 -50)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 +30, VIRTUAL_HEIGHT/2 -50)

    player1:render()
    player2:render()

    ball:render()

    displayFPS()

    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
    
end
