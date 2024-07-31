-- PANEL
-- Un panel permet d'avoir une zone ou l'ont va ajouter des élément de type texte, bouton, etc..
local Panel = {}

function Panel:new(x, y, w, h, state)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.x = x
    instance.y = y
    instance.w = w
    instance.h = h
    instance.img = nil
    instance.visible = state

    return instance
end

-- Méthode de mise à jour de l'élément
function Panel:update(dt)
    -- print("Update Not implemented")
end

-- Méthode d'affichage de l'élément
function Panel:draw()
    love.graphics.setColor(1, 1, 1)

    if self.img == nil then 
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    else
        love.graphics.draw(self.img, self.x, self.y)
    end
end

-- SETTER
-- Méthode qui permet de définir une image
function Panel:setImg(img)
    self.img = love.graphics.newImage(img)
    self.w = self.img:getWidth()
    self.h = self.img:getHeight()
end

-- Méthode qui permet de définir si l'élément sera visible ou non
function Panel:setVisible(state)
    self.visible = state
end



return Panel