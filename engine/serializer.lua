local Serializer = {}

function Serializer.Serialize(data)
    local serializedTable = "{\n"

    for k, v in pairs(data) do
        serializedTable = serializedTable .. k .. " = '" .. v .."',\n"
    end

    serializedTable = serializedTable .. "}"

    return serializedTable
end

function Serializer.Deserialize(file)
    local data = {}
    local chunk = love.filesystem.load(file)
    local key = chunk()
    
    for k, v in pairs(key) do
        data[k] = v
    end

    return data
end

return Serializer