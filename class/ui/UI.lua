local UI = class()

function UI:constructor(player)
    self.player = player
    self.element = {}
    self.hudText = {}
    self.hidden = false
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
        element:show()
    end

    self.hidden = false
end

function UI:destroy()
    for _, element in pairs(self.element) do
        element:destroy()
    end
end

-------------------------
--        INIT         --
-------------------------

return UI