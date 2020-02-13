-- @TODO: Inherit from the Object class
sea.Image = class()

function sea.Image:constructor(path, x, y, mode)
    self.id = image(path, x, y, mode)

	sea.Object.create(self.id)
end

function sea.Image:destroy()
	freeimage(self.id)

	sea.Object.remove(self.id)
end

function sea.Image:scale(x, y)
	imagescale(self.id, x, y)
end

function sea.Image:hitZone(mode, xOffset, yOffset, width, height)
	imagehitzone(self.id, mode, xOffset, yOffset, width, height)
end

-- @TODO: Maybe a better tween functioning? First consider how would you like to use tween functions in code

function sea.Image:tweenAlpha(time, alpha)
	tween_alpha(self.id, time, alpha)
end

function sea.Image:tweenAnimate(speed, mode)
	tween_animate(self.id, speed, mode)
end

function sea.Image:tweenColor(time, r, g, b)
	tween_color(self.id, time, r, g, b)
end

function sea.Image:tweenFrame(time, frame)
	tween_frame(self.id, time, frame)
end

function sea.Image:tweenMove(time, x, y, rotation)
	tween_move(self.id, time, x, y, rotation)
end

function sea.Image:tweenRotate(time, rotation)
	tween_rotate(self.id, time, rotation)
end

function sea.Image:tweenRotateConstantly(speed)
	tween_rotateconstantly(self.id, speed)
end

function sea.Image:tweenScale(time, x, y)
	tween_scale(self.id, time, x, y)
end

-------------------------
--       GETTERS       --
-------------------------

function sea.Image:getXAttribute()
	return imageparam(self.id, "x")
end

function sea.Image:getYAttribute()
	return imageparam(self.id, "y")
end

function sea.Image:getRotationAttribute()
	return imageparam(self.id, "rot")
end

function sea.Image:getAlphaAttribute()
	return imageparam(self.id, "alpha")
end

function sea.Image:getPathAttribute()
	return imageparam(self.id, "path")
end

function sea.Image:getFrameAttribute()
	return imageparam(self.id, "frame")
end

function sea.Image:getWidthAttribute()
	return imageparam(self.id, "width")
end

function sea.Image:getHeightAttribute()
	return imageparam(self.id, "height")
end

function sea.Image:getFrameCountAttribute()
	return imageparam(self.id, "framecount")
end

-------------------------
--       SETTERS       --
-------------------------

function sea.Image:setAlphaAttribute(value)
	imagealpha(self.id, value)
end

function sea.Image:setBlendModeAttribute(value)
	imageblend(self.id, value)
end

function sea.Image:setColorAttribute(value)
	imagecolor(self.id, value[1], value[2], value[3])
end

function sea.Image:setFrameAttribute(value)
	imageframe(self.id, value)
end

function sea.Image:setXAttribute(value)
	imagepos(self.id, value, self.y, self.rotation)
end

function sea.Image:setYAttribute(value)
	imagepos(self.id, self.x, value, self.rotation)
end

function sea.Image:setRotationAttribute(value)
	imagepos(self.id, self.x, self.y, value)
end