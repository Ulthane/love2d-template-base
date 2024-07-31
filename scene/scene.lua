--[[
    SCENE
    Class template qui permettra au Class enfant d'hériter des paramètres globaux
    - new => créer la Class
    - load => chargement de la scène (1*)
    - unload => permet de reset en mémoire la scène
    - update => mise à jour de la scène (60*)
    - draw => affichage de la scène (60*)
]]--

local Scene = {}


function Scene:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    return instance
end

function Scene:load()
    fontKenvectorFuture24 = love.graphics.newFont("assets/fonts/kenvector_future_thin.ttf", 24)
    fontKenvectorFuture16 = love.graphics.newFont("assets/fonts/kenvector_future_thin.ttf", 16)
end

function Scene:unload()
end

function Scene:update(dt)
end

function Scene:draw()
end


return Scene