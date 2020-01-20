local loaded = not (not utf8) -- Is the library being loaded again?

utf8 = {}

local shift_6  = 2^6
local shift_12 = 2^12
local shift_18 = 2^18

local function utf8charbytes (s, i)
	-- argument defaults
	i = i or 1

	-- argument checking
	if type(s) ~= "string" then
		error("bad argument #1 to 'utf8charbytes' (string expected, got ".. type(s).. ")")
	end
	if type(i) ~= "number" then
		error("bad argument #2 to 'utf8charbytes' (number expected, got ".. type(i).. ")")
	end

	local c = string.byte(s, i)

	-- determine bytes needed for character, based on RFC 3629
	-- validate byte 1
	if c > 0 and c <= 127 then
		-- UTF8-1
		return 1

	elseif c >= 194 and c <= 223 then
		-- UTF8-2
		local c2 = string.byte(s, i + 1)

		if not c2 then
			error("UTF-8 string terminated early")
		end

		-- validate byte 2
		if c2 < 128 or c2 > 191 then
			error("Invalid UTF-8 character")
		end

		return 2

	elseif c >= 224 and c <= 239 then
		-- UTF8-3
		local c2 = string.byte(s, i + 1)
		local c3 = string.byte(s, i + 2)

		if not c2 or not c3 then
			error("UTF-8 string terminated early")
		end

		-- validate byte 2
		if c == 224 and (c2 < 160 or c2 > 191) then
			error("Invalid UTF-8 character")
		elseif c == 237 and (c2 < 128 or c2 > 159) then
			error("Invalid UTF-8 character")
		elseif c2 < 128 or c2 > 191 then
			error("Invalid UTF-8 character")
		end

		-- validate byte 3
		if c3 < 128 or c3 > 191 then
			error("Invalid UTF-8 character")
		end

		return 3

	elseif c >= 240 and c <= 244 then
		-- UTF8-4
		local c2 = string.byte(s, i + 1)
		local c3 = string.byte(s, i + 2)
		local c4 = string.byte(s, i + 3)

		if not c2 or not c3 or not c4 then
			error("UTF-8 string terminated early")
		end

		-- validate byte 2
		if c == 240 and (c2 < 144 or c2 > 191) then
			error("Invalid UTF-8 character")
		elseif c == 244 and (c2 < 128 or c2 > 143) then
			error("Invalid UTF-8 character")
		elseif c2 < 128 or c2 > 191 then
			error("Invalid UTF-8 character")
		end

		-- validate byte 3
		if c3 < 128 or c3 > 191 then
			error("Invalid UTF-8 character")
		end

		-- validate byte 4
		if c4 < 128 or c4 > 191 then
			error("Invalid UTF-8 character")
		end

		return 4

	else
		error("Invalid UTF-8 character")
	end
end

local function utf8len (s)
	-- argument checking
	if type(s) ~= "string" then
		--for k,v in pairs(s) do print('"',tostring(k),'"',tostring(v),'"') end
		error("bad argument #1 to 'utf8len' (string expected, got ".. type(s).. ")", 2)
	end

	local pos = 1
	local bytes = #s
	local length = 0

	while pos <= bytes do
		length = length + 1
		pos = pos + utf8charbytes(s, pos)
	end

	return length
end

local function utf8sub (s, i, j)
	-- argument defaults
	j = j or -1

	local pos = 1
	local bytes = #s
	local length = 0

	-- only set l if i or j is negative
	local l = (i >= 0 and j >= 0) or utf8len(s)
	local startChar = (i >= 0) and i or l + i + 1
	local endChar   = (j >= 0) and j or l + j + 1

	-- can't have start before end!
	if startChar > endChar then
		return ""
	end

	-- byte offsets to pass to string.sub
	local startByte,endByte = 1,bytes

	while pos <= bytes do
		length = length + 1

		if length == startChar then
			startByte = pos
		end

		pos = pos + utf8charbytes(s, pos)

		if length == endChar then
			endByte = pos - 1
			break
		end
	end

	if startChar > length then startByte = bytes+1   end
	if endChar   < 1      then endByte   = 0         end

	return string.sub(s, startByte, endByte)
end

function utf8.codepoint(str, i, j, byte_pos)
	i = i or 1
	j = j or i

	if i > j then return end

	local ch,bytes

	if byte_pos then
		bytes = utf8charbytes(str,byte_pos)
		ch  = string.sub(str,byte_pos,byte_pos-1+bytes)
	else
		ch,byte_pos = utf8sub(str,i,i), 0
		bytes       = #ch
	end

	local unicode

	if bytes == 1 then unicode = string.byte(ch) end
	if bytes == 2 then
		local byte0,byte1 = string.byte(ch,1,2)
		local code0,code1 = byte0-0xC0,byte1-0x80
		unicode = code0*shift_6 + code1
	end
	if bytes == 3 then
		local byte0,byte1,byte2 = string.byte(ch,1,3)
		local code0,code1,code2 = byte0-0xE0,byte1-0x80,byte2-0x80
		unicode = code0*shift_12 + code1*shift_6 + code2
	end
	if bytes == 4 then
		local byte0,byte1,byte2,byte3 = string.byte(ch,1,4)
		local code0,code1,code2,code3 = byte0-0xF0,byte1-0x80,byte2-0x80,byte3-0x80
		unicode = code0*shift_18 + code1*shift_12 + code2*shift_6 + code3
	end

	return unicode,utf8.codepoint(str, i+1, j, byte_pos+bytes)
end

function utf8.encode(unicode)
    unicode = utf8.codepoint(unicode)
    if unicode <= 0x7F then
        return "x" .. string.format("%X", unicode)
    elseif (unicode <= 0x7FF) then
		local Byte0 = 0xC0 + math.floor(unicode / 0x40);
        local Byte1 = 0x80 + (unicode % 0x40);
        return "x" .. string.format("%X", Byte0) .. "x" .. string.format("%X", Byte1)
	elseif (unicode <= 0xFFFF) then
		local Byte0 = 0xE0 +  math.floor(unicode / 0x1000);
		local Byte1 = 0x80 + (math.floor(unicode / 0x40) % 0x40);
		local Byte2 = 0x80 + (unicode % 0x40);
        return "x" .. string.format("%X", Byte0) .. "x" .. string.format("%X", Byte1) .. "x" .. string.format("%X", Byte2)
    elseif (unicode <= 0x10FFFF) then
		local code = unicode
		local Byte3= 0x80 + (code % 0x40);
		code       = math.floor(code / 0x40)
		local Byte2= 0x80 + (code % 0x40);
		code       = math.floor(code / 0x40)
		local Byte1= 0x80 + (code % 0x40);
		code       = math.floor(code / 0x40)
		local Byte0= 0xF0 + code;

        return "x" .. string.format("%X", Byte0) .. "x" .. string.format("%X", Byte1) .. "x" .. string.format("%X", Byte2) .. "x" .. string.format("%X", Byte3)
	else
        error 'Unicode cannot be greater than U+10FFFF!'
    end
end

function utf8.convert(str)
    local u8 = "UTF-8:"
    for i = 1, utf8len(str) do
        u8 = u8 .. utf8.encode(utf8sub(str, i, i))
    end
    return u8
end

--[[if (not loaded) then
    print("\169108103235Lua: Loading UTF-8 wrapper")
    local _msg = msg
    function msg(txt)
        _msg(utf8.convert(txt))
    end

    local _msg2 = msg2
    function msg2(id, txt)
        _msg2(id, utf8.convert(txt))
    end

    local _print = print
    function print(...)
        local arg = {...}
        for i = 1, #arg do
            arg[i] = utf8.convert(tostring(arg[i]))
        end
        _print(unpack(arg))
    end

    local _parse = parse
    function parse(cmd, ...)
        _parse(utf8.convert(cmd), ...)
	end
end]]