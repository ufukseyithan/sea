local Style = class()

function Style:constructor(properties)
    self.properties = properties or {}
end

-------------------------
--       GETTERS       --
-------------------------

function Style:getColorAttribute()
    return self.properties.color or sea.Color.white
end

function Style:getTextSizeAttribute()
    return self.properties.textSize or 13
end

function Style:getOpacityAttribute()
    return self.properties.opacity or 1
end

function Style:getScaleAttribute()
    return self.properties.scale or {x = 1, y = 1}
end

function Style:getAlignAttribute()
    return self.properties.align or 0
end

function Style:getVerticalAlignAttribute()
    return self.properties.verticalAlign or 0
end

function Style:getFrameAttribute()
    return self.properties.frame or 0
end

function Style:getBackgroundAttribute()
    return self.properties.background
end

-------------------------
--       SETTERS       --
-------------------------

function Style:setColorAttribute(value)
    self.properties.color = value
end

function Style:setTextSizeAttribute(value)
    self.properties.textSize = value
end

function Style:setOpacityAttribute(value)
    self.properties.opacity = value
end

function Style:setScaleAttribute(value)
    self.properties.scale = value
end

function Style:setAlignAttribute(value)
    self.properties.align = value
end

function Style:setVerticalAlignAttribute(value)
    self.properties.verticalAlign = value
end

function Style:setFrameAttribute(value)
    self.properties.frame = value
end


function Style:setBackgroundAttribute(value)
    self.properties.background = value
end

-------------------------
--        INIT         --
-------------------------

return Style