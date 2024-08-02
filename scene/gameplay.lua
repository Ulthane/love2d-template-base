local Square = require("game/square")

local Gameplay = {}


function Gameplay:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.p1 = Square:new(250, 250, 50)
    instance.p2 = Square:new(750, 250,100)

    return instance
end

function Gameplay:load()
end

function Gameplay:unload()
end

function Gameplay:update(dt)
    self.p1:update(dt)
    self.p1:distance(self.p2.x, self.p2.y)
end

function Gameplay:draw()
    love.graphics.print("GAMEPLAY", 10, 10)
    self.p1:draw()
    self.p2:draw()
end


return Gameplay