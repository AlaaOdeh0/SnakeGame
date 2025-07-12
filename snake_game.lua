local SnakeGame = {}
SnakeGame.__index = SnakeGame

local Events = require("events")
local HighScore = require("highscore")

function SnakeGame:new()
    local game = {
        snake = {
            {x = 10, y = 10}
        },
        direction = {x = 1, y = 0},
        food = {x = 15, y = 15},
        score = 0,
        highScore = HighScore:load(),
        gameOver = false,
        timer = 0,
        moveInterval = 0.15,
        isPaused = false
    }
    return setmetatable(game, SnakeGame)
end

function SnakeGame:update(dt)
    if self.gameOver or self.isPaused then return end

    self.timer = self.timer + dt
    if self.timer >= self.moveInterval then
        self.timer = 0
        local head = self.snake[1]
        local newHead = {
            x = head.x + self.direction.x,
            y = head.y + self.direction.y
        }

        -- Check collision with self
        for i = 2, #self.snake do
            if self.snake[i].x == newHead.x and self.snake[i].y == newHead.y then
                self.gameOver = true
                return
            end
        end

        -- Check collision with wall
        if newHead.x < 0 or newHead.y < 0 or newHead.x >= 40 or newHead.y >= 30 then
            self.gameOver = true
            if self.score > self.highScore then
                HighScore:save(self.score)
                self.highScore = self.score
            end
            return
        end

        table.insert(self.snake, 1, newHead)

        -- Food eaten
        if newHead.x == self.food.x and newHead.y == self.food.y then
            self.score = self.score + 1
            Events:emit("food_eaten", {score = self.score})
            self:spawnFood()

            -- Increase speed over time
            if self.moveInterval > 0.05 then
                self.moveInterval = self.moveInterval - 0.005
            end
        else
            table.remove(self.snake)
        end
    end
end

function SnakeGame:draw()
    -- Draw snake
    for _, segment in ipairs(self.snake) do
        love.graphics.rectangle("fill", segment.x * 20, segment.y * 20, 18, 18)
    end

    -- Draw food
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.food.x * 20, self.food.y * 20, 18, 18)
    love.graphics.setColor(1, 1, 1)

    -- Display score
    love.graphics.print("Score: " .. self.score, 10, 10)
    love.graphics.print("High Score: " .. self.highScore, 10, 30)

    -- Game over message
    if self.gameOver then
        love.graphics.printf("Game Over! Press R to restart", 0, 200, love.graphics.getWidth(), "center")
    end

    -- Pause message
    if self.isPaused then
        love.graphics.printf("PAUSED", 0, 180, love.graphics.getWidth(), "center")
    end
end

function SnakeGame:changeDirection(dx, dy)
    -- Prevent reversing direction
    if self.direction.x + dx ~= 0 or self.direction.y + dy ~= 0 then
        self.direction = {x = dx, y = dy}
    end
end

function SnakeGame:spawnFood()
    self.food = {
        x = math.random(0, 39),
        y = math.random(0, 29)
    }
end

function SnakeGame:togglePause()
    self.isPaused = not self.isPaused
end

function SnakeGame:restart()
    local newGame = SnakeGame:new()
    for k, v in pairs(newGame) do
        self[k] = v
    end
end

return SnakeGame
