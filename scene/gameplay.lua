local Gameplay = {}


function Gameplay:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.lightX  = 200
    instance.lightY = 150
    instance.lightRadius = 10
    instance.auraRadius = 50
    instance.lightIntensity = 1

    return instance
end

function Gameplay:load()
end

function Gameplay:unload()
end

function Gameplay:update(dt)
        -- Ajuster l'intensité de la lumière avec les touches Haut et Bas
        if love.keyboard.isDown("up") then
            self.lightIntensity = math.min(self.lightIntensity + 0.01, 1)
        elseif love.keyboard.isDown("down") then
            self.lightIntensity = math.max(self.lightIntensity - 0.01, 0)
        end
end

function Gameplay:draw()
    -- love.graphics.print("GAMEPLAY", 10, 10)

        -- Dessiner l'aura autour du point lumineux
        for i = 1, self.auraRadius, 2 do
            local alpha = self.lightIntensity * (1 - (i / self.auraRadius))
            love.graphics.setColor(1, 1, 1, alpha)
            love.graphics.circle("fill", self.lightX, self.lightY, self.lightRadius + i)
        end
        
        -- Dessiner le point lumineux
        love.graphics.setColor(1, 1, 1, self.lightIntensity)
        love.graphics.circle("fill", self.lightX, self.lightY, self.lightRadius)
    
        -- Réinitialiser la couleur pour les autres dessins
        love.graphics.setColor(1, 1, 1, 1)
        
        -- Afficher l'intensité actuelle pour le débogage
        love.graphics.print("Intensité de la lumière : " .. string.format("%.2f", self.lightIntensity), 10, 10)
end


return Gameplay