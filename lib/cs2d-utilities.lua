function tileToPixel(x)
    return x * 32 + 16
end

function pixeltoTile(x)
    return math.floor(x / 32)
end

function getDistance(x1, y1, x2, y2)
	return(math.sqrt ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)))
end

function getDirection(x1, y1, x2, y2)
    local direction = -math.round(math.deg(math.atan2(x1 - x2, y1 - y2)))
    if direction < 0 then direction = direction + 360 end
    return direction
end

function lengthdirX(direction, length)
	return math.cos(math.rad(direction - 90)) * length
end

function lengthdirY(direction, length)
	return math.sin(math.rad(direction - 90)) * length
end

function isInside(x, y, x1, y1, x2, y2)
    return ((x >= x1) and (y >= y1) and (x <= x2) and (y <= y2))
end

local _parse = parse
function parse(...)
    local args = {...}
    local command = ''
    for _, v in pairs(args) do
        command = command .. '\"' .. v .. '\" '
    end
    _parse(command)
end