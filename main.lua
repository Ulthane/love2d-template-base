-- Import
SceneManager = require('engine/scene_manager'):new()
KeyboardManager = require('engine/keyboard_manager'):new()

-- Fonction de chargement avant jeu
function love.load()
    KeyboardManager:init()
    SceneManager.currentScene:load()
end

-- Fonction de mise a jour des données du jeu (60x/s)
function love.update(dt)
    SceneManager.currentScene:update(dt)
end

-- Fonction d'affichage du jeu (60x/s)
function love.draw()
    SceneManager.currentScene:draw()
end

-- Fonction de détection des touches
function love.keypressed(key)
end