local Serializer = require("engine/serializer")

local KeyboardManager = {}

function KeyboardManager:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    
    instance.file = "key.lua"
    instance.keymapping = {
        left = "q",
        top = "z",
        right = "d",
        bottom = "s"
    }

    return instance
end

function KeyboardManager:init()
    print("file path : " ..love.filesystem.getSaveDirectory())

    if not love.filesystem.getInfo(self.file) then
        self:saveFile(self.keymapping)
    else 
        self:loadingFile()
    end
end

function KeyboardManager:saveFile(data)
    success, message = love.filesystem.write(self.file, "return " .. Serializer.Serialize(data))

    if success then
        print("file key.lua saved")
        self:loadingFile()
    end
end

function KeyboardManager:loadingFile()
    self.keymapping = Serializer.Deserialize(self.file)
    print("file key.lua loaded.")
end

return KeyboardManager