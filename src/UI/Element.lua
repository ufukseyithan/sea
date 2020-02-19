local Element = class()

function Element:constructor(ui, x, y, style)
    self.id = ui:requestElementID(self.type)
    self.ui = ui
    self.x = x
    self.y = y
    self.style = style or sea.Style.new()

    ui[self.type][self.id] = self

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

function Element:remove()
    self:destroy()
    self.ui[self.type][self.id] = nil 
end

-------------------------
--        INIT         --
-------------------------

return Element