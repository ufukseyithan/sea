local Element = class()

function Element:constructor(ui, x, y, width, height, style)
    self.ui = ui
    self.x, self.y = x, y
    self.width, self.height = width or 0, height or 0
    self.style = style or sea.Style.new()
    self.hidden = false

    self:update()
end

--[[function Element:__newindex(key, value)
    if key == "style" then
        self:update()
    end
end]]

function Element:setPosition(x, y)
    self.x = x
    self.y = y

    self:update()
end

function Element:setStyle(style)
    self.style = style

    self:update()
end

function Element:show()
    if self.hidden then
        self.hidden = false

        self:update()
    end
end

-------------------------
--        INIT         --
-------------------------

return Element