---@diagnostic disable: discard-returns
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

function string:toPascalCase(delimiter)
    local tab = {}
    self:gsub("([^".. delimiter.."]+)", function(c)
        table.insert(tab, c:upperFirst())
    end)
    return table.concat(tab)
end

function string.camelCaseToUnderscore(str)
    -- Made by ChatGPT
    local underscoreStr = str:gsub("(%u)", function(c) return "_" .. c:lower() end)
    underscoreStr = underscoreStr:gsub("__", "_")
    return underscoreStr
end

function string.underscoreToPascalCase(str)
    local tab = {}
    str:gsub('([^_]+)', function (c)
        table.insert(tab, c:upperFirst())
    end)
    return table.concat(tab)
end

function string.camelCaseToPascalCase(str)
    return str:upperFirst()
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

function math.clamp(num, min, max)
    return math.max(min, math.min(max, num))
end

-- Table
function table.getKeys(tbl)
    local keys = {}

    for k, v in pairs(tbl) do
        table.insert(keys, k)
    end

    return keys
end

function table.count(tbl)
    local count = 0

    for k, v in pairs(tbl) do
        count = count + 1
    end

    return count
end

function table.contains(tab, value)
    for _, v in pairs(tab) do
        if (v == value) then
            return true
        end
    end

    return false
end

function table.getKeyOf(tab, value)
    for k, v in pairs(tab) do
        if (v == value) then
            return k
        end
    end

    return false
end

function table.removeDuplicates(tbl)
	local hash = {}
	local res = {}

	for _, v in ipairs(tbl) do
	   if (not hash[v]) then
	       res[#res + 1] = v -- you could print here instead of saving to result table if you wanted
	       hash[v] = true
	   end
	end

	return res
end

function table.merge(tbl, tbl2, override)
    for k, v in pairs(tbl2) do 
        if type(v) == "table" and tbl[k] then
            table.merge(tbl[k], v, override)
        else
            tbl[k] = override and (tbl[k] or v) or v
        end
    end
end

function table.removeValue(tbl, value)
    for k, v in pairs(tbl) do
        if v == value then
            table.remove(tbl, k)
            return true
        end
    end

    return false
end

function table.insert2D(tbl, x, y, value)
    tbl[x] = tbl[x] or {}
    tbl[x][y] = value
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

function io.toTable(file, tbl)
    if not tbl then
        return
    end
    
    local file = io.open(file, "r");
    
    for line in file:lines() do
        table.insert(tbl, line);
    end
end