local GameState = require("gamestate")
local gameState = GameState:new()  -- Create an instance of GameState

function love.update(dt)
    gameState:update(dt)  -- Update the current state 
end

function love.draw()
    gameState:draw()  -- Draw the current state
end

function love.keypressed(key)
    -- Menu to playing state switch
    if gameState.current == "menu" and key == "return" then
        gameState:switch("playing")  -- Switch to playing state when Enter is pressed
    elseif gameState.current == "playing" then
        local game = gameState.states.playing  -- Access the game state
        -- Direction change
        if key == "up" then game:changeDirection(0, -1) end
        if key == "down" then game:changeDirection(0, 1) end
        if key == "left" then game:changeDirection(-1, 0) end
        if key == "right" then game:changeDirection(1, 0) end
        -- Toggle pause when 'P' is pressed
        if key == "p" then game:togglePause() end
        -- Restart the game if 'R' is pressed and the game is over
        if key == "r" and game.gameOver then game:restart() end
    end
end
