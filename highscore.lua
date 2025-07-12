-- Modern Lua Feature: Originally used <close> (Lua 5.4) for automatic file closing,
-- but LOVE2D uses LuaJIT, so we manually close files instead.

local HighScore = {}

function HighScore:save(score)
    local file = io.open("highscore.txt", "w")
    if file then
        file:write(tostring(score))
        file:close() -- manually close file
    end
end

function HighScore:load()
    local file = io.open("highscore.txt", "r")
    if file then
        local content = file:read("*a")
        file:close() -- manually close file
        return tonumber(content) or 0
    end
    return 0
end

return HighScore
