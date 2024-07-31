local Panel = require('GUI/panel')
local Text = require('GUI/text')

local Button = {}


function Button:new(x, y, w, h, text, font, state)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.x = x 
    instance.y = y
    instance.w = w
    instance.h = h
    instance.visible = state
    instance.text = text
    instance.font = font
    instance.label = Text:new(x, y, w, h, text, font, "center", "center", true)
    instance.isHover = false
    instance.isPressed = false
    instance.oldButtonState = false
    instance.img = {
        default = nil,
        hover = nil,
        pressed = nil,
        w = nil,
        h = nil
    }
    instance.lstEvents = {}
    instance.sliceParam = {}
    instance.sliceQuad = {}
    instance.sliceMode = false

    return instance
end

function Button:setSlice(percentage)
    -- Parametre du slice 9
    local percentage = percentage or 33

    self.sliceMode = true

    self.sliceParam.topLeft = {
        x = 0,
        y = 0,
        w = (self.img.w * percentage) / 100,
        h = (self.img.h * percentage) / 100
    }

    self.sliceParam.top = {
        x = (self.img.w * percentage) / 100,
        y = 0,
        w = 1,
        h = (self.img.h * percentage) / 100
    }

    self.sliceParam.topRight = {
        x = self.img.w - ((self.img.w * percentage) / 100),
        y = 0,
        w = (self.img.w * percentage) / 100,
        h = (self.img.h * percentage) / 100
    }

    self.sliceParam.right = {
        x = self.img.w - ((self.img.w * percentage) / 100),
        y = (self.img.h * percentage) / 100,
        w = (self.img.w * percentage) / 100,
        h = 1
    }

    self.sliceParam.bottomRight = {
        x = self.img.w - ((self.img.w * percentage) / 100),
        y = self.img.h - (self.img.h * percentage) / 100,
        w = (self.img.w * percentage) / 100,
        h = (self.img.h * percentage) / 100
    }

    self.sliceParam.bottom = {
        x = (self.img.w * percentage) / 100,
        y = self.img.h - (self.img.h * percentage) / 100,
        w = 1,
        h = (self.img.w * percentage) / 100
    }

    self.sliceParam.bottomLeft = {
        x = 0,
        y = self.img.h - (self.img.h * percentage) / 100,
        w = (self.img.w * percentage) / 100,
        h = (self.img.h * percentage) / 100
    }

    self.sliceParam.left = {
        x = 0,
        y = (self.img.h * percentage) / 100,
        w = (self.img.w * percentage) / 100,
        h = 1
    }

    self.sliceParam.center = {
        x = (self.img.w * percentage) / 100,
        y = (self.img.h * percentage) / 100,
        w = 1,
        h = 1
    }

    for k, v in pairs(self.sliceParam) do
        self.sliceQuad[k] = love.graphics.newQuad(v.x, v.y, v.w, v.h, self.img.default)
    end
end

-- Méthode pour ajouter un evenement
function Button:setEvent(ftype, func)
    self.lstEvents[ftype] = func
end

-- Méthode pour ajouter une image
function Button:setImg(default, hover, pressed)
    self.img.default = love.graphics.newImage(default)
    self.img.hover = love.graphics.newImage(hover)
    self.img.pressed = love.graphics.newImage(pressed)

    self.img.w = self.img.default:getWidth()
    self.img.h = self.img.default:getHeight()
end


-- Méthode d'update du bouton
function Button:update(dt)
    local mx, my = love.mouse.getPosition()

    if mx > self.x and mx < self.x + self.w and
    my > self.y and my < self.y + self.h then
        if self.isHover == false then
            self.isHover = true
        end
    else
        if self.isHover == true then
            self.isHover = false
        end
    end

    if self.isHover and love.mouse.isDown(1) and self.isPressed == false and self.oldButtonState == false then
            self.isPressed = true
            -- if self.lstEvents["click_yes"] then
            --     self.lstEvents["click_yes"]("BEGIN")
            -- end

            if self.lstEvents["quit"] then
                self.lstEvents["quit"]()
            end

            if self.lstEvents["newgame"] then
                self.lstEvents["newgame"]()
            end
    else
        if self.isPressed == true and love.mouse.isDown(1) == false then
            self.isPressed = false
            -- if self.lstEvents["click_yes"] then
            --     self.lstEvents["click_yes"]("END")
            -- end
        end
    end

    self.oldButtonState = love.mouse.isDown(1)
end

-- Méthode d'affichage du bouton
function Button:draw()
    love.graphics.setColor(1, 1, 1, 1)

    -- SI le bouton est presser
    if self.isPressed then
        if self.img.pressed == nil and not self.sliceMode then
            love.graphics.setColor(1, 1, 1, .5)
            love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        elseif self.img.pressed ~= nil and self.sliceMode then
            self:drawSlice(self.img.pressed)
        else
            love.graphics.draw(self.img.pressed, self.x, self.y)
        end
    -- SI le bouton est survolé
    elseif self.isHover then
        if self.img.hover == nil and not self.sliceMode then
            love.graphics.rectangle("line", self.x + 2, self.y + 2, self.w - 4, self.h - 4)
        elseif self.img.default ~= nil and self.sliceMode then
            self:drawSlice(self.img.default)
        else
            love.graphics.draw(self.img.hover, self.x, self.y)
        end
    -- SINON DEFAULT
    else
        if self.img.default ~= nil and not self.sliceMode then
            love.graphics.draw(self.img.default, self.x, self.y)
        elseif self.img.default ~= nil and self.sliceMode then
            love.graphics.setColor(1, 1, 1, .5)
            self:drawSlice(self.img.default)
        else
            love.graphics.setColor(1, 1, 1, .5)
            love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
        end
    end
    

    self.label:draw()
end


function Button:drawSlice(img)
    local topX = self.x + self.sliceParam.top.x
    local rigthY = self.y + self.sliceParam.topRight.h
    local bottomX = topX
    local leftY = rigthY
    local centerX = topX
    local width = self.w - (self.sliceParam.topLeft.w * 2)
    local height = self.h - (self.sliceParam.topRight.h * 2)

    -- TOPLEFT
    love.graphics.draw(img, self.sliceQuad.topLeft, self.x, self.y)
    
    -- TOP
    for i=1, width do
        love.graphics.draw(img, self.sliceQuad.top, topX, self.y)
        topX = topX + 1
    end
    
    -- TOP RIGHT
    love.graphics.draw(img, self.sliceQuad.topRight, self.x + self.sliceParam.topLeft.w + width, self.y)
    
    -- RIGHT
    for i=1, height do
        love.graphics.draw(img, self.sliceQuad.right, topX, rigthY)
        rigthY = rigthY + 1
    end
    
    -- BOTTOM RIGHT
    love.graphics.draw(img, self.sliceQuad.bottomRight, self.x + self.sliceParam.topLeft.w + width, self.y + self.sliceParam.topRight.h + height)
    
    -- BOTTOM
    for i=1, width do
        love.graphics.draw(img, self.sliceQuad.bottom, bottomX, self.y + self.h - self.sliceParam.bottom.h)
        bottomX = bottomX + 1
    end

    -- BOTTOM LEFT
    love.graphics.draw(img, self.sliceQuad.bottomLeft, self.x, self.y + self.h - self.sliceParam.bottom.h)

    -- LEFT
    for c=1, height do
        love.graphics.draw(img, self.sliceQuad.left, self.x, leftY)
        leftY = leftY + 1
    end

    -- CENTER
    for c=1, width do
        local centerY = self.y + self.sliceParam.center.y
        love.graphics.draw(img, self.sliceQuad.center, centerX, centerY)
        for l=1, height - 1 do
            love.graphics.draw(img, self.sliceQuad.center, centerX, centerY + 1)
            centerY = centerY + 1
        end
        centerX = centerX + 1
    end
end


return Button