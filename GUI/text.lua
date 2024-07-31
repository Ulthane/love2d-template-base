-- TEXT
-- Class qui retourne un élément texte

local Text = {}


function Text:new(x, y ,w, h, text, font, hAlign, vAlign, state)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.x = x
    instance.y = y
    instance.w = w
    instance.h = h
    instance.font = font
    instance.text = text
    instance.textW = instance.font:getWidth(text)
    instance.textH = instance.font:getHeight(text)
    instance.hAlign = hAlign
    instance.vAlign = vAlign
    instance.visible = state
    instance.color = {
        red = 1,
        green = 1,
        blue = 1,
        alpha = 1
    }

    return instance
end

-- Méthode de mise à jour du texte
function Text:update(dt)
    -- print("Update Not implemented")
end

-- Méthode d'affichage du texte
function Text:draw()
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue, self.color.alpha)
    love.graphics.setFont(self.font)
    
    local x = self.x
    local y = self.y 
    
    if self.hAlign == "center" then
        x = x + ((self.w - self.textW) / 2)
    end
    
    if self.vAlign == "center" then
        y = y + ((self.h - self.textH) / 2)
    end
    
    love.graphics.print(self.text, x, y)
end

-- SETTER
-- Méthode qui permet de changer la couleur du texte
function Text:setColor(red, green, blue, alpha)
    self.color.red = red or 1
    self.color.green = green or 1
    self.color.blue = blue or 1
    self.color.alpha = alpha or 1
end

-- Méthode qui permet de setter la visibilité du texte
function Text:setVisible(state)
    self.visible = state
end

return Text