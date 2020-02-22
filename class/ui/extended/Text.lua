local Text = class(sea.Element)

function Text:constructor(ui, text, x, y, style)
    local textID = ui:requestHUDTextID()

    self.text = text
    self.textID = textID

    ui.hudText[textID] = self

    self:super(ui, x, y, textwidth(text), nil, style)
end

function Text:setText(text)
    self.text = text
    self.width = textwidth(text)

    self:update()
end

function Text:hide()
    if not self.hidden then
        parse("hudtxtalphafade", self.ui.player.id, self.textID, 1, 0)

        self.hidden = true
    end
end

function Text:update()
    self.height = self.style.textSize

    if self.hidden then return end

    parse("hudtxt2", self.ui.player.id, self.textID, self.text, self.x, self.y, self.style.align, self.style.verticalAlign, self.style.textSize)

    parse("hudtxtalphafade", self.ui.player.id, self.textID, 1, self.style.opacity)

    -- Background
end

function Text:destroy()
    parse("hudtxt2", self.ui.player.id, self.textID)

    self.ui.hudText[self.textID] = nil
end

-------------------------
--        INIT         --
-------------------------

return Text