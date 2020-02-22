local Panel = class(sea.Element)

function Panel:constructor(ui, imagePath, x, y, style) 
    local image = sea.Image.new(imagePath, x, y, 2, ui.player)

    self.image = image
    self.imagePath = imagePath -- This needs to be saved for later use when recreating UI images upon round start

    self:super(ui, x, y, image.width, image.height, style)
end

-- @TODO: Set image path

function Panel:hide()
    if not self.hidden then
        self.image.alpha = 0

        self.hidden = true
    end
end

function Panel:update()
    if not self.hidden then
        self.image.alpha = self.style.opacity
    end

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