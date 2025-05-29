function tileToPixel(x, y)
    if y then
        return tileToPixel(x), tileToPixel(y)
    else
        return x * 32 + 16
    end
end

function pixelToTile(x, y)
    if y then
        return pixelToTile(x), pixelToTile(y)
    else
        return math.floor(x / 32)
    end
end

function getDistance(x1, y1, x2, y2)
	return(math.sqrt ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)))
end

function getDirection(x1, y1, x2, y2)
    local direction = -math.round(math.deg(math.atan2(x1 - x2, y1 - y2)))
    if direction < 0 then direction = direction + 360 end
    return direction
end

function extendX(direction, length)
	return math.cos(math.rad(direction - 90)) * length
end

function extendY(direction, length)
	return math.sin(math.rad(direction - 90)) * length
end

function extendPosition(x, y, direction, length)
    return x + extendX(direction, length), y + extendY(direction, length)
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

function deepcopy(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

function secondsToHMS(seconds)
    -- Calculate the number of hours, minutes, and seconds
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    seconds = seconds % 60
  
    -- Return the result as a formatted string
    return string.format("%2dh %02dm %02ds", hours, minutes, seconds)
  end