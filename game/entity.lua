local Entity = {}

function Entity:new(x, y, vx, vy)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.x = x or 0
    instance.y = y or 0
    instance.vx = vx or 15
    instance.vy = vy or 15
    instance.rotate = 0
    instance.img = {}
    instance.frame = 1
    instance.currentFrame = 1
    instance.maxFrame = 1
    instance.animateSpeed = 15
    instance.size = 100

    return instance
end

function Entity:move(dt)

end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function Entity:distance(x, y)
    print(math.dist(self.x, self.y, x, y) < self.size / 2) 
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