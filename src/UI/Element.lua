local Element = class()

function Element:constructor(player, x, y, style)
    self.player = player
    self.x = x
    self.y = y
    self.style = style or sea.Style.new()

    self:update()
end

--[[function Element:__newindex(key, value)
    if key == "style" then
        self:update()
    end
end]]

function Element:setStyle(style)
    self.style = style

    self:update()
end

function Element:setPosition(x, y)
    self.x = x
    self.y = y

    self:update()
end

-------------------------
--        INIT         --
-------------------------

return Element