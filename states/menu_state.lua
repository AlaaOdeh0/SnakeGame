local menu = {}

function menu:update(dt)
end

function menu:draw()
    love.graphics.printf("SNAKE GAME", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Press Enter to Start", 0, 250, love.graphics.getWidth(), "center")
end

return menu
