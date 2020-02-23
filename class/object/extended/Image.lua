local Image = class(sea.Object)

function Image:constructor(path, x, y, mode, player)
	local id = image(path, x, y, mode, player and player.id)

	self.id = id

	sea.Object.create(id, self)
end

function Image:destroy()
	freeimage(self.id)

	sea.Object.remove(self.id)
end

function Image:scale(x, y)
	imagescale(self.id, x, y)
end

function Image:hitZone(mode, xOffset, yOffset, width, height)
	imagehitzone(self.id, mode, xOffset, yOffset, width, height)
end

function Image:tweenAlpha(time, alpha)
	tween_alpha(self.id, time, alpha)
end

function Image:tweenAnimate(speed, mode)
	tween_animate(self.id, speed, mode)
end

function Image:tweenColor(time, color)
	tween_color(self.id, time, color.red, color.green, color.blue)
end

function Image:tweenFrame(time, frame)
	tween_frame(self.id, time, frame)
end

function Image:tweenMove(time, x, y, rotation)
	tween_move(self.id, time, x, y, rotation)
end

function Image:tweenRotate(time, rotation)
	tween_rotate(self.id, time, rotation)
end

function Image:tweenRotateConstantly(speed)
	tween_rotateconstantly(self.id, speed)
end

function Image:tweenScale(time, x, y)
	tween_scale(self.id, time, x, y)
end

-------------------------
--       GETTERS       --
-------------------------

function Image:getXAttribute()
	return imageparam(self.id, "x")
end

function Image:getYAttribute()
	return imageparam(self.id, "y")
end

function Image:getRotationAttribute()
	return imageparam(self.id, "rot")
end

function Image:getAlphaAttribute()
	return imageparam(self.id, "alpha")
end

function Image:getPathAttribute()
	return imageparam(self.id, "path")
end

function Image:getFrameAttribute()
	return imageparam(self.id, "frame")
end

function Image:getWidthAttribute()
	return imageparam(self.id, "width")
end

function Image:getHeightAttribute()
	return imageparam(self.id, "height")
end

function Image:getFrameCountAttribute()
	return imageparam(self.id, "framecount")
end

-------------------------
--       SETTERS       --
-------------------------

function Image:setAlphaAttribute(value)
	imagealpha(self.id, value)
end

function Image:setBlendModeAttribute(value)
	imageblend(self.id, value)
end

function Image:setColorAttribute(value)
	imagecolor(self.id, value.red, value.green, value.blue)
end

function Image:setFrameAttribute(value)
	imageframe(self.id, value)
end

function Image:setXAttribute(value)
	imagepos(self.id, value, self.y, self.rotation)
end

function Image:setYAttribute(value)
	imagepos(self.id, self.x, value, self.rotation)
end

function Image:setRotationAttribute(value)
	imagepos(self.id, self.x, self.y, value)
end

-------------------------
--        INIT         --
-------------------------

return Image