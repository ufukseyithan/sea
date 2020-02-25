local Message = class()

function Message:constructor(text, color, tag, tagColor)
    self.text = text
    self.color = color or sea.Color.white
    self.tag = tag
    self.tagColor = tagColor
end 

function Message:__tostring()
    local str = sea.createColoredText(self.text, self.color)

    if self.tag then
        str = sea.createColoredText("["..self.tag.."]", self.tagColor).." "..str
    end

	return str 
end

-------------------------
--        INIT         --
-------------------------

return Message