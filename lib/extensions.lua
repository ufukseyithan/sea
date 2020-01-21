-- String
function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields + 1] = c end)
    return fields
end

function string:upperFirst()
    return (self:gsub('^%l', string.upper))
end

function string:trim()
    return (self:gsub("^%s*(.-)%s*$", "%1"))
end

function string:toCamelCase(delimiter)
    local tab = {}
    self:gsub( '([^'.. delimiter..']+)', function (c)
        table.insert(tab, c:firstupper())
    end)
    return table.concat(tab)
end

function string.camelCaseToUnderscore(str)
    local tab = {}
    str:gsub( '%u?%l+', function (c)
        table.insert(tab, c:lower())
    end)
    return table.concat(tab, '_')
end

function string.underscoreToCamelCase(str)
    local tab = {}
    str:gsub( '([^_]+)', function (c)
        table.insert(tab, c:firstupper())
    end)
    return table.concat(tab)
end
 
-- Math

function math.round(num,base)
	if base == nil then
		return math.floor(num+0.5)
	else
        if base > 0 then
            base = math.pow(10,base)
        end
		return math.floor((num*base)+0.5)/base
	end
end

function math.lerp(a, b, t)
	return a + (b - a) * t
end

function math.average(...)
    local sum = 0
    local i = 0
    while (i < #arg) do
        i = i + 1
        sum = sum + arg[i]
    end
    return sum/#arg
end

-- Table

function table.contains(tab, value)
    for _, v in pairs(tab) do
        if (v == value) then
            return true
        end
    end

    return false
end

function table.isEmpty(tab)
    return next(tab) == nil
end

-- IO

function io.exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
       if code == 13 then
          -- Permission denied, but it exists
          return true
       end
    end
    return ok, err
end