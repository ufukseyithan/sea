local Vector = class()

function Vector:constructor(x, y)
    self.x = x or 0
    self.y = y or 0
end

function Vector:__call()
	return self.x, self.y
end

function Vector:toPixel()
    self.x, self.y = tileToPixel(self.x, self.y)
end

function Vector:toTile()
    self.x, self.y = pixelToTile(self.x, self.y)
end

function Vector:distance(other)
    return getDistance(self.x, self.y, other.x, other.y)
end

function Vector:angle(other)
    return getDirection(self.x, self.y, other.x, other.y)
end

function Vector:extendX(angle, length)
    self.x = self.x + extendX(angle, length)
end

function Vector:extendY(angle, length)
    self.y = self.y + extendY(angle, length)
end

function Vector:extendPosition(angle, length)
    self:extendX(angle, length)
    self:extendY(angle, length)
end

function Vector:isInside(vector1, vector2)
    return isInside(self.x, self.y, vector1(), vector2())
end

-------------------------
--        CONST        --
-------------------------

Vector.left = Vector(-1, 0)
Vector.right = Vector(1, 0)
Vector.up = Vector(0, -1)
Vector.down = Vector(0, 1)

-------------------------
--        INIT         --
-------------------------

return Vector