sea.tile = {}
sea.Tile = class()

function sea.Tile:constructor(x, y)
    self.x = x
    self.y = y
end

-------------------------
--       GETTERS       --
-------------------------

function sea.Tile:getFrameAttribute()
	return tile(self.x, self.y, "frame")
end

function sea.Tile:getPropertyIDAttribute()
	return tile(self.x, self.y, "property")
end

function sea.Tile:getWalkableAttribute()
	return tile(self.x, self.y, "walkable")
end

function sea.Tile:getEntityAttribute()
	return tile(self.x, self.y, "entity")
end

function sea.Tile:getHasCustomFrameAttribute()
	return tile(self.x, self.y, "hascustomframe")
end

function sea.Tile:getOriginalFrameAttribute()
	return tile(self.x, self.y, "originalframe")
end

function sea.Tile:getRotationAttribute()
	return tile(self.x, self.y, "rot")
end

function sea.Tile:getBlendAttribute()
	return tile(self.x, self.y, "blend")
end

function sea.Tile:getColorAttribute()
	return tile(self.x, self.y, "color")
end

function sea.Tile:getBrightnessAttribute()
	return tile(self.x, self.y, "brightness")
end

function sea.Tile:getWallAttribute()
    return tile(self.x, self.y, "wall")
end

function sea.Tile:getObstacleAttribute()
    return tile(self.x, self.y, "obstacle")
end

function sea.Tile:getDeadlyAttribute()
    return tile(self.x, self.y, "deadly")
end

-------------------------
--       SETTERS       --
-------------------------

function sea.Tile:setFrameAttribute(frame)
	parse("settile", self.x, self.y, frame)
end
