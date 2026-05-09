local Frame = class(sea.Element)

function Frame:constructor(ui, x, y, imagePath, style, width, height) 
    self.children = {}

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
    for _, child in pairs(self.children) do
        if not child.hidden then
            child:show()
        end
    end

    self.hidden = false

    self:update()
end

function Frame:addChild(child)
    local children = self.children
    local id = #children + 1

    child.parent = self

    children[id] = child

    if self.hidden then
        child:hide()
    end

    local temp = child.destroy
    function child:destroy()
        temp(child)

        children[id] = nil
        child.parent = nil
    end

    return children[id]
end

function Frame:removeChild(object)
    for i, child in ipairs(self.children) do
        if child == object then
            object.parent = nil
            table.remove(self.children, i)
            break
        end
    end
end

function Frame:hide()
    for _, child in pairs(self.children) do
        child:hide()
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

function Frame:setPosition(x, y, moveChildren)
    if moveChildren then
        local dx = x - self.x
        local dy = y - self.y

        for _, child in pairs(self.children) do
            child:setPosition(element.x + dx, element.y + dy, true)
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
    for _, child in pairs(self.children) do
        child:destroy()
    end

    if self.image then
        self.image:destroy()
    end
end

-------------------------
--        INIT         --
-------------------------

return Frame
