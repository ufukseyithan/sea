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

    for k in pairs(tbl) do
        table.insert(keys, k)
    end

    return keys
end

function table.count(tbl)
    local count = 0

    for _ in pairs(tbl) do
        count = count + 1
    end

    return count
end

function table.contains(tab, value)
    for _, v in pairs(tab) do
        if table.equal(v, value) then
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

function table.reverse(tbl)
    local reversed = {}
    for i = #tbl, 1, -1 do
        table.insert(reversed, tbl[i])
    end
    return reversed
end

function table.print(tbl, indent, key)
    indent = indent or 0
    local spacing = string.rep("  ", indent)

    if type(tbl) ~= "table" then
        print(spacing .. tostring(tbl))
        return
    end

    if not key then
        print(spacing .. "{")
    else
        print(spacing .. (key and (key.." = ") or "") .. " {")
    end
    
    for k, v in pairs(tbl) do
        local key = tostring(k)
       
        if type(v) == "table" then
            table.print(v, indent + 2, key)
        else
            print(string.rep("  ", indent + 2) .. key .. " = " .. tostring(v))
        end
    end

    print(spacing .. "}")
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

function table.shuffle(tbl)
	local n = #tbl
	while n > 2 do
		local k = math.random(n)
		tbl[n], tbl[k] = tbl[k], tbl[n]
		n = n - 1
	end
	return tbl
end

function table.equal(tbl, tbl2)
	if type(tbl) ~= "table" and type(tbl2) ~= "table" then
		return tbl == tbl2
	end
	for k, v in pairs(tbl) do
		if v ~= tbl2[k] then
			return false
		end
	end
	return true
end

function table.toString( tbl )
	local result, done = {}, {}
	for k, v in ipairs( tbl ) do
		if k ~= 'tmp' then
			table.insert( result, table.valToString(v) )
			done[ k ] = true
		end
	end
	for k, v in pairs( tbl ) do
		if not done[ k ] then
			table.insert( result, 
				table.keyToString(k) .. "=" .. table.valToString(v))
		end
	end
	return "{" .. table.concat(result, ", ") .. "}"
end

function table.valToString(v)
	if "string" == type(v) then
		v = string.gsub(v, "\n", "\\n" )
		if string.match( string.gsub(v, "[^'\"]", ""), '^"+$' ) then
			return "'" .. v .. "'"
		end
		return '"' .. string.gsub(v, '"', '\\"' ) .. '"'
	else
		return "table" == type(v) and table.toString(v) or tostring(v)
	end
end

function table.keyToString(k)
	if "string" == type(k) and string.match(k, "^[_%a][_%a%d]*$") then
		return k
	else
		return "[" .. table.valToString(k) .. "]"
	end
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