-- GUI
-- La GUI est un groupe qui permet d'afficher toutes sortent d'éléments
local GUI = {}


-- Fonction qui va créer un groupe d'élément pour une interface
function GUI:new()
    local instance = {}
    setmetatable(instance, {__index = GUI})

    instance.elements = {}

    return instance
end

-- Méthode qui permet d'ajouter un élément dans l'instance GUI
function GUI:addElement(el)
    table.insert(self.elements, el)
end

-- -- Méthode qui permet de rendre un élément visible ou non
-- function GUI:setVisible(el, state)
--     self.elements[el].visible = state
-- end

-- Méthode d'update des éléments du groupe
function GUI:update(dt)
    for k, v in pairs(self.elements) do 
        v:update(dt)
    end
end

-- Méthode d'affichage pour les éléments du groupe
function GUI:draw()
    love.graphics.push()

    for k, v in pairs(self.elements) do
        if v.visible then
            v:draw()
        end
    end

    love.graphics.pop()
end


return GUI