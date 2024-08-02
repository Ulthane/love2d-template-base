local Entity = require("game/entity")

local Square = Entity:new()

function Square:new(x, y, size)
    local instance = Entity:new(x, y, 300, 300)
    setmetatable(instance, self)
    self.__index = self

    instance.size = size or 50

    return instance
end

function Square:update(dt)
 if love.keyboard.isDown(KeyboardManager.keymapping.right) then
    self.x = self.x + self.vx * dt
 end
end

function Square:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

return Square