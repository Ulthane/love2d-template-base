local Entity = {}

function Entity:new(x, y)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.x = x
    instance.y = y
    instance.vx = 1
    instance.vy = 1
    instance.rotate = 0
    instance.img = {}
    instance.frame = 1
    instance.currentFrame = 1
    instance.maxFrame = 1
    instance.animateSpeed = 15

    return instance
end

function Entity:move(dt)

end

function Entity:animate(dt)
    self.frame = self.frame + self.animateSpeed * dt

    if self.frame > self.maxFrame then
        self.frame = 1
    end

    self.rotate = self.rotate + 1 * dt

    if self.rotate > 360 then
        self.rotate = 0
    end
end

-- SETTER
function Entity:setMaxFrame(value)
    self.maxFrame = value
end

return Entity