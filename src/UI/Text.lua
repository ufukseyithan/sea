local Text = class(sea.Element)

function Text:constructor(player, text, x, y, style)  
    local id = Text.requestID(player)

    self.id = id
    self.text = text

    self:super(player, x, y, style)

    player.hudTexts[id] = self
end

function Text:update()
    parse("hudtxt2", self.player.id, self.id, self.text, self.x, self.y, self.style.align, self.style.verticalAlign, self.style.textSize)

    -- Color
    -- Opacity
end

function Text:remove()
    parse("hudtxt2", self.player.id, self.id)
    self.player.hudTexts[self.id] = nil
end

-------------------------
--        CONST        --
-------------------------

function Text.requestID(player)
    return #player.hudTexts + 1
end

-------------------------
--        INIT         --
-------------------------

return Text