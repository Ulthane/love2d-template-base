local Events = {}

-- Fonction qui lance la partie
function Events.onNewGame()
    SceneManager:setScene("Gameplay")
end

-- Fonction pour quitter le jeu
function Events.onQuit()
    love.event.quit(0)
end

return Events