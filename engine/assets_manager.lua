local AssetsManager = {}

function AssetsManager.loadSprite(sprite, number)
    local assets = {}

    for i=0, number do
        if i < 10 then
            i = "00"..i
        elseif i > 9 and i < 100 then
            i = "0"..i
        end

        table.insert(assets, love.graphics.newImage(sprite.."__"..i..".png"))
    end

    return assets
end

return AssetsManager