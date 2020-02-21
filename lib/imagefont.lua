imageFont = { fontTable = {} }

-- /// Misc Func /// --
function imageFont.linesFromFile(file)
	if not io.exists(file) then
		return({})
	end
	local lines = {}
	for line in io.lines(file) do 
		lines[#lines + 1] = line
	end
	return(lines)
end

-- /// Image Font Functions /// --
function imageFont.Load(file)
	local lines = imageFont.linesFromFile(file)
	local textSize = 0
	for k,v in pairs(lines) do
		if string.find(v, "textsize") then
			textSize = tonumber(v:split("=")[2])
			if (textSize == nil) then
				textSize = 13
			end
			if (imageFont.fontTable[textSize] == nil) then
				imageFont.fontTable[textSize] = {}
			end
		else
			local char = string.sub(v, 1, 1	)
			local size = string.sub(v, 3)
			imageFont.fontTable[textSize][char] = size
		end
	end
end

function charwidth(char, textSize)
	if (textSize == nil) then
		textSize = 13
	end
	if (imageFont.fontTable[textSize] ~= nil) then
		if (imageFont.fontTable[textSize][char] ~= nil) then
			return(imageFont.fontTable[textSize][char])
		end	
	end
	return(0)
end

function textwidth(text, textSize)
	if (textSize == nil) then
		textSize = 13
	end
	local len = 0
	for i = 1, string.len(text) do
		len = len + charwidth(string.sub(text, i, i), textSize)
	end
	return(len)
end

local function getLocalPath()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

imageFont.Load(getLocalPath().."font.dat")