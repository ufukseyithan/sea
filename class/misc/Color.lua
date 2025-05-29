local Color = class()

function Color:constructor(red, green, blue)
    self.red = red
    self.green = green
    self.blue = blue
end

function Color:__tostring()
	return string.format("%03d%03d%03d", self.red, self.green, self.blue)
end

function Color:__call()
	return self.red, self.green, self.blue
end

-------------------------
--        CONST        --
-------------------------

Color.white = Color.new(255, 255, 255)
Color.red = Color.new(255, 0, 0)
Color.green = Color.new(0, 255, 0)
Color.blue = Color.new(0, 0, 255)
Color.magenta = Color.new(255, 0, 255)
Color.cyan = Color.new(0, 255, 255)
Color.yellow = Color.new(255, 255, 0)
Color.black = Color.new(0, 0, 0)
Color.purple = Color.new(128, 0, 128)
Color.gray = Color.new(128, 128, 128)
Color.orange = Color.new(255, 128, 0)
Color.brown = Color.new(128, 64, 0)
Color.default = Color.new(255, 220, 0)

-------------------------
--        INIT         --
-------------------------

return Color