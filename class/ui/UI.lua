local UI = class()

function UI:constructor(player)
    self.player = player
    
    self.hudText = {}
    self.margin = sea.config.ui.margin

    local screenWidth, screenHeight = player.screenWidth, player.screenHeight
    self.frame = sea.Frame.new(self, screenWidth / 2, screenHeight / 2, nil, nil, screenWidth, screenHeight)
end

function UI:requestHUDTextID()
	return #self.hudText + 1
end

function UI:createText(text, x, y, style)
    return self.frame:createText(text, x, y, style)
end

function UI:createFrame(x, y, imagePath, style, width, height)
    return self.frame:createFrame(x, y, imagePath, style, width, height)
end

function UI:show()
    self.frame:show()

    self.hidden = false
end

function UI:hide()
    self.frame:hide()

    self.hidden = true
end

function UI:update()

end

function UI:destroy()
    self.frame:destroy()
end

-------------------------
--        INIT         --
-------------------------

return UI