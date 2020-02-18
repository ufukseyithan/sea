local Style = class()

function Style:constructor(properties)
    properties = properties or {}
end

-------------------------
--       GETTERS       --
-------------------------

-- Color
-- Text size
-- Scale = {x, y}
-- Background = {color, opacity}
-- align
-- Vertical Align

function Style.getOpacityAttribute()
    return properties.opacity or 1
end

-------------------------
--       SETTERS       --
-------------------------

-- ???

-------------------------
--        INIT         --
-------------------------

return Style