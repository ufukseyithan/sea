local UI = class()

function UI:constructor(player)
    self.player = player

    self.text = {}
    self.panel = {}
end

function UI:requestElementID(elementType)
    return #self[elementType] + 1
end

-------------------------
--        INIT         --
-------------------------

return UI