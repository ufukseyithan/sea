local Text = class(sea.Element)

function Text:constructor(ui, text, x, y, style) 
    self.type = "text"

    self:super(ui, x, y, style)

    self.text = text
    self.width = textwidth(text)
    self.height = self.style.textSize
end

function Text:update()
    parse("hudtxt2", self.ui.player.id, self.id, self.text, self.x, self.y, self.style.align, self.style.verticalAlign, self.style.textSize)

    -- @TODO: Are we sure to use text color just like this? Since we have sea.createText, it may make sense 
    -- to remove this colorfade and give the text a color value when creating, without style
    local color = self.style.color
    parse("hudtxtcolorfade", self.ui.player.id, self.id, 1, color.red, color.green, color.blue)

    parse("hudtxtalphafade", self.ui.player.id, self.id, 1, self.style.opacity)
end

function Text:destroy()
    parse("hudtxt2", self.player.id, self.id)
end

-------------------------
--        INIT         --
-------------------------

return Text