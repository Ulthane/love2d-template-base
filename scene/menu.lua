--[[
    SCENE
    Class qui créer le menu du jeu
    - new => créer la Class
    - load => chargement de la scène (1*)
    - unload => permet de reset en mémoire la scène
    - update => mise à jour de la scène (60*)
    - draw => affichage de la scène (60*)
    - getName => retourne le nom de la scène
]]--

local Scene = require('scene/scene')
local GUI = require('GUI/GUI')
local Panel = require('GUI/panel')
local Text = require('GUI/text')
local Button = require('GUI/button')
local Events = require('events/events')
local KeyboardManager = require('engine/keyboard_manager')


-- CLASS MENU
local Menu = {}


function Menu:new(sceneManager)
    local instance = {}
    setmetatable(instance, {__index = Menu})
    
    instance.sceneManager = sceneManager
    instance.name = "Menu"
    instance.GUI = GUI:new()

    return instance
end

function Menu:load()

    -- Précharge la scène par défaut pour hériter de ses paramètres
    Scene.load(self)

    -- Création du panel central pour le menu
    local title = Text:new(love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() / 2 - 75, 200, 220, "Menu", fontKenvectorFuture24, "center", "nocenter", true)
    local btnNewGame = Button:new(love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() / 2 - 20, 200, 40, "Nouvelle partie", fontKenvectorFuture16, true)
    local btnOptions = Button:new(love.graphics.getWidth() / 2 - 100, (love.graphics.getHeight() / 2 - 20) + 50, 200, 40, "Paramètres", fontKenvectorFuture16, true)
    local btnQuit = Button:new(love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() / 2 - 20 + (50 * 2), 200, 40, "Quitter", fontKenvectorFuture16, true)

    title:setColor(1, 1, 1, 1)

    btnNewGame:setEvent("newgame", Events.onNewGame)
    btnQuit:setEvent("quit", Events.onQuit)

    -- SLICING BTN
    btnNewGame:setImg("assets/GUI/panel-border.png", "assets/GUI/panel-border.png", "assets/GUI/panel-transparent-center.png")
    btnOptions:setImg("assets/GUI/panel-border.png", "assets/GUI/panel-border.png", "assets/GUI/panel-transparent-center.png")
    btnQuit:setImg("assets/GUI/panel-border.png", "assets/GUI/panel-border.png", "assets/GUI/panel-transparent-center.png")
    btnNewGame:setSlice()
    btnOptions:setSlice()
    btnQuit:setSlice()

    self.GUI:addElement(title)
    self.GUI:addElement(btnNewGame)
    self.GUI:addElement(btnOptions)
    self.GUI:addElement(btnQuit)

    print("Menu loaded")
end

function Menu:unload()
    self.GUI = nil
end

function Menu:update(dt)
    self.GUI:update(dt)
end

function Menu:draw()
    self.GUI:draw()
end

-- GETTER
function Menu:getName()
    return self.name
end

return Menu