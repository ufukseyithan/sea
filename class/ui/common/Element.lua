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

--[[function Element:getCenterPosition()
    return self.x, self.y
end

function Element:getCenterTopPosition()
    return self.width / 2, 0
end

function Element:getCenterBottomPosition()
    return self.width / 2, self.height
end

function Element:getCenterLeftPosition()
    return 0, self.height / 2
end

function Element:getCenterRightPosition()
    return self.width, self.height / 2
end

function Element:getTopLeftPosition()
    return self.width + self.margin, self.height + self.margin 
end

function Element:getTopRightPosition()
    return self.width - self.margin, self.height + self.margin 
end

function Element:getBottomLeftPosition()
    return self.width + self.margin, self.height - self.margin 
end

function Element:getBottomRightPosition()
    return self.width - self.margin, self.height - self.margin 
end]]

-------------------------
--        INIT         --
-------------------------

return Element