sea.tile = {}
local Tile = class()

function Tile:constructor(x, y)
    self.x = x
    self.y = y
end

-------------------------
--       GETTERS       --
-------------------------

function Tile:getFrameAttribute()
	return tile(self.x, self.y, "frame")
end

function Tile:getPropertyIDAttribute()
	return tile(self.x, self.y, "property")
end

function Tile:getWalkableAttribute()
	return tile(self.x, self.y, "walkable")
end

function Tile:getEntityAttribute()
	return tile(self.x, self.y, "entity")
end

function Tile:getHasCustomFrameAttribute()
	return tile(self.x, self.y, "hascustomframe")
end

function Tile:getOriginalFrameAttribute()
	return tile(self.x, self.y, "originalframe")
end

function Tile:getRotationAttribute()
	return tile(self.x, self.y, "rot")
end

function Tile:getBlendAttribute()
	return tile(self.x, self.y, "blend")
end

function Tile:getColorAttribute()
	return tile(self.x, self.y, "color")
end

function Tile:getBrightnessAttribute()
	return tile(self.x, self.y, "brightness")
end

function Tile:getWallAttribute()
    return tile(self.x, self.y, "wall")
end

function Tile:getObstacleAttribute()
    return tile(self.x, self.y, "obstacle")
end

function Tile:getDeadlyAttribute()
    return tile(self.x, self.y, "deadly")
end

-------------------------
--       SETTERS       --
-------------------------

function Tile:setFrameAttribute(frame)
	parse("settile", self.x, self.y, frame)
end

return Tile