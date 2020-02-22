local UI = class()

function UI:constructor(player)
    self.player = player
    self.width, self.height = player.screenWidth, player.screenHeight
    self.margin = sea.config.ui.margin
    self.hidden = false

    self.element = {}
    self.hudText = {}
end

function UI:requestHUDTextID()
	return #self.hudText + 1
end

function UI:createElement(object)
    local element = self.element
    local id = #element + 1

    element[id] = object

    if self.hidden then
        object:hide()
    end

    local temp = object.destroy
    function object:destroy()
        temp(object)

        element[id] = nil
    end

    return object
end

function UI:createText(text, x, y, style)
    return self:createElement(sea.Text.new(self, text, x, y, style))
end

function UI:createPanel(imagePath, x, y, style)
    return self:createElement(sea.Panel.new(self, imagePath, x, y, style))
end

function UI:hide()
    for _, element in pairs(self.element) do
        element:hide()
    end

    self.hidden = true
end

function UI:show()
    for _, element in pairs(self.element) do
        if not element.hidden then
            element:show()
        end
    end

    self.hidden = false
end

function UI:update()

end

function UI:destroy()
    for _, element in pairs(self.element) do
        element:destroy()
    end
end

function UI:getCenterPosition()
    return self.width / 2, self.height / 2
end

function UI:getCenterTopPosition()
    return self.width / 2, 0
end

function UI:getCenterBottomPosition()
    return self.width / 2, self.height
end

function UI:getCenterLeftPosition()
    return 0, self.height / 2
end

function UI:getCenterRightPosition()
    return self.width, self.height / 2
end

function UI:getTopLeftPosition()
    return self.width + self.margin, self.height + self.margin 
end

function UI:getTopRightPosition()
    return self.width - self.margin, self.height + self.margin 
end

function UI:getBottomLeftPosition()
    return self.width + self.margin, self.height - self.margin 
end

function UI:getBottomRightPosition()
    return self.width - self.margin, self.height - self.margin 
end

-------------------------
--        INIT         --
-------------------------

return UI