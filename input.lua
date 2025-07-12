local Input = {}
Input.__index = Input

function Input:new()
    return setmetatable({commands = {}}, Input)
end

function Input:bind(key, command)
    self.commands[key] = command
end

function Input:handleKey(key)
    local command = self.commands[key]
    if command then command() end
end

return Input
