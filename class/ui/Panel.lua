local Panel = class(sea.Element)

function Panel:constructor(ui, imagePath, x, y, style) 
    local image = sea.Image.create(imagePath, x, y, 2, ui.player)

    self.image = image
    self.imagePath = imagePath -- This needs to be saved for later use when recreating UI images upon round start

    self:super(ui, x, y, image.width, image.height, style)
end

function Panel:show()
    self.hidden = false

    self:update()
end

function Panel:hide()
    self.image.alpha = 0

    self.hidden = true
end

function Panel:updatePath(path)
    self.image.path = path
    self.imagePath = path

    self:update()
end

function Panel:setPosition(x, y)
    self.x = x
    self.y = y

    self:update()
end

function Panel:update()
    self.image.frame = self.style.frame

    self.image.alpha = self.hidden and 0 or self.style.opacity

    self.image.blendMode = self.style.blend

    self.image.color = self.style.color

    local scale = self.style.scale
    self.image:scale(scale.x, scale.y)

    self.image:setPosition(self.x, self.y)

    -- Background
end

function Panel:destroy()
    self.image:destroy()
end

-------------------------
--        INIT         --
-------------------------

return Panel