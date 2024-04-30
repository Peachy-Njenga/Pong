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
    _G.largeFont = love.graphics.newFont('font.ttf', 15)
    _G.scoreFont = love.graphics.newFont('font.ttf', 30)
    love.graphics.setFont(smallFont)

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }


    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            fullscreen = false,
            resizable = true,
            vsync = true
        }
    )

    love.window.setTitle("Pong!")

    servingPlayer = 1

    _G.player1 = Paddle(5, 10, 2, 15)
    _G.Computer = Paddle(VIRTUAL_WIDTH - 5, 10, 2, 15)

    _G.ball = Ball(VIRTUAL_WIDTH / 2 + 5, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'Start'
end

_G.player1Score = 0
_G.ComputerScore = 0

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if gameState == 'serve' then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
    elseif gameState == 'play' then
        --collision with player paddles
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5
            
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds.paddle_hit:play()
        end

        if ball:collides(Computer) then
            ball.dx = -ball.dx * 1.03
            ball.x = Computer.x - 4

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds.paddle_hit:play()
        end

        --screen boundary collision
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
            sounds.wall_hit:play()
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
            sounds.wall_hit:play()
        end
    end


    --Scoring update
    if ball.x < 0 then
        _G.servingPlayer = 1
        ComputerScore = ComputerScore + 1
        ball:reset()

        if ComputerScore == 10 then
            winningPlayer = 2
            gameState = 'done'
        else
            gameState = 'serve'
        end

        sounds.score:play()
    end

    if ball.x > VIRTUAL_WIDTH then
        _G.servingPlayer = 2
        player1Score = player1Score + 1
        ball:reset()

        if player1Score == 10 then
            winningPlayer = 1
            gameState = 'done'
        else
            gameState = 'serve'
        end

        sounds.score:play()
    end

    --player 1 movement
    if love.keyboard.isDown('up') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    --computer's movement
    -- if love.keyboard.isDown('up') then
    --     Computer.dy = -PADDLE_SPEED
    -- elseif love.keyboard.isDown('down') then
    --     Computer.dy = PADDLE_SPEED
    -- else
    --     Computer.dy = 0
    -- end
        Computer.dy = ball.dy
        Computer.y = ball.y

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    Computer:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'Start' then
            gameState = 'serve'
        elseif
            gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            --restarting the game.
            gameState = 'serve'

            --reseting everything
            ball:reset()
            player1Score = 0
            ComputerScore = 0

            --select serving player
            if winningPlayer == 1 then
                gameState = 'play'
            else
                servingPlayer = 1
            end
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(0.5, 0, 0, 1)

    love.graphics.setFont(smallFont)

    displayScore()

    if gameState == 'Start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf("Welkie to Pong!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to start playing!", 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s turn to serve", 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        --nothing is printed
    elseif gameState == 'done' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins! He is the true Sigma', 0, 120, VIRTUAL_WIDTH,
            'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf("Press 'Enter' to restart", 0, 150, VIRTUAL_WIDTH, 'center')
    end


    player1:render()
    Computer:render()

    ball:render()

    displayFPS()

    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255 / 255, 0, 255 / 255)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 30, VIRTUAL_HEIGHT / 2 - 50)
    love.graphics.print(tostring(ComputerScore), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 2 - 50)
end
