-- Déclaration de l'objet a retourner
local Menu = require("scene/menu")
local Gameplay = require("scene/gameplay")
-- local Pause = require("scene/pause")
local SceneManager = {}


function SceneManager:new()
    local instance = {}
    setmetatable(instance, {__index = SceneManager})

    -- instance.currentScene = Gameplay:new()
    instance.currentScene = Menu:new()

    return instance
end

-- SETTER
function SceneManager:setScene(scene)

    self.currentScene:unload()

    if scene == "Menu" then
        self.currentScene = Menu:new(self)
    elseif scene == "Gameplay" then 
        self.currentScene = Gameplay:new()
    elseif scene == "Pause" then 
        self.currentScene = Pause:new()
    end

    self.currentScene:load()

end

-- Fonction qui retourne le nom de la scène séléctionné
function SceneManager:getScene()
    return self.currentScene:getName()
end


return SceneManager