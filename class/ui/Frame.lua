local Frame = class(sea.Element)

function Frame:constructor(ui, x, y, imagePath, style, width, height) 
    self.element = {}

    if width then
        self.selfMeasured = true
    end

    local image = imagePath and sea.Image.create(imagePath, x, y, 2, ui.player) or nil

    if image then
        self.image = image
        self.imagePath = imagePath -- This needs to be saved for later use when recreating UI images upon round start
    end

    self:super(ui, x, y, width or image and image.width, height or image and image.height, style)
end

function Frame:show()
    for _, element in pairs(self.element) do
        if not element.hidden then
            element:show()
        end
    end

    self.hidden = false

    self:update()
end

function Frame:createElement(object)
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

    return element[id]
end

function Frame:createText(text, x, y, style)
    return self:createElement(sea.Text.new(self.ui, text, x, y, style))
end

function Frame:createFrame(x, y, imagePath, style, width, height)
    return self:createElement(sea.Frame.new(self.ui, x, y, imagePath, style, width, height))
end

function Frame:hide()
    for _, element in pairs(self.element) do
        element:hide()
    end

    if self.image then
        self.image.alpha = 0
    end

    self.hidden = true
end

function Frame:updatePath(path, selfMeasured)
    if not self.image then
        return 
    end

    self.image.path = path
    self.imagePath = path

    if not selfMeasured then
        self.width, self.height = self.image.width, self.image.height
        self.selfMeasured = false
    end

    self:update()
end

function Frame:setPosition(x, y, moveElements)
    if moveElements then
        local dx = x - self.x
        local dy = y - self.y

        for _, element in pairs(self.element) do
            element:setPosition(element.x + dx, element.y + dy, true)
        end
    end

    self.super.setPosition(self, x, y)
end

function Frame:update()
    if self.image then
        self.image.frame = self.style.frame

        self.image.alpha = self.hidden and 0 or self.style.opacity

        self.image.blendMode = self.style.blend

        self.image.color = self.style.color

        local scale = self.style.scale
        self.image:scale(scale.x, scale.y)

        self.image:setPosition(self.x, self.y)
    end

    -- Background
end

function Frame:destroy()
    for _, element in pairs(self.element) do
        element:destroy()
    end

    if self.image then
        self.image:destroy()
    end
end

-------------------------
--        INIT         --
-------------------------

return Frame