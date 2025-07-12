local SnakeGame = require("snake_game")
local snakeGame = SnakeGame:new()

local state = {}

function state:new()
    local newState = {}
    setmetatable(newState, {__index = self})
    return newState
end

-- Update function for the game loop
function state:update(dt)
    snakeGame:update(dt)  -- Call SnakeGame's update
end

-- Draw function to display the game state
function state:draw()
    snakeGame:draw()  -- Call SnakeGame's draw
end

-- Change the direction of the snake
function state:changeDirection(dx, dy)
    snakeGame:changeDirection(dx, dy)
end

-- Pause the game
function state:togglePause()
    snakeGame:togglePause()  -- Calls SnakeGame's togglePause function
end

-- Restart the game
function state:restart()
    -- Reset the SnakeGame instance by creating a new one
    snakeGame = SnakeGame:new()  -- Reset to a fresh game instance
end

return state
