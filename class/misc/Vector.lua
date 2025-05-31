local Vector = class()

function Vector:constructor(x, y)
    if type(x) == 'table' then
        self.x, self.y = x.x or x[1] or 0, x.y or x[2] or 0
    end

    self.x, self.y = x or 0, y or 0
end

function Vector:__call()
	return self.x, self.y
end

function Vector:__serialize()
	return {self()}
end

function Vector:__eq(other)
	return self.x == other.x and self.y == other.y
end

function Vector:toPixel()
    return Vector.new(tileToPixel(self()))
end

function Vector:toTile(ref)
    return Vector.new(pixelToTile(self()))
end

function Vector:distance(other)
    return getDistance(self.x, self.y, other.x, other.y)
end

function Vector:angle(other)
    return getDirection(self.x, self.y, other.x, other.y)
end

function Vector:extendPosition(angle, length)
    return Vector.new(extendPosition(self.x, self.y, angle, length))
end

function Vector:isInside(vector1, vector2)
    return isInside(self.x, self.y, vector1(), vector2())
end

-------------------------
--        CONST        --
-------------------------

Vector.left = Vector.new(-1, 0)
Vector.right = Vector.new(1, 0)
Vector.up = Vector.new(0, -1)
Vector.down = Vector.new(0, 1)

-------------------------
--        INIT         --
-------------------------

return Vector