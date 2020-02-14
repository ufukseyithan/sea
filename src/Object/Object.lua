sea.object = {}
local Object = class()

--[[
	Where items could spawn:
	- Server start (done!)
	- Round start (startround hook) (done!)
    - Build (done!)
    - Image (done!)
    - Portal gun

	Where items could be removed:
	- Object kill (objectkill hook) (done!)
    - Round start (startround hook) (done!)
	- Freeimage (done!)
	- Portal gun
]]

function Object:constructor(id)
    self.id = id
end

function Object:destroy()
	-- No need to remove the object from sea.object because killobject command automatically triggers the objectkill hook
	parse("killobject", self.id)
end

-------------------------
--        CONST        --
-------------------------

function Object.create(id)
	if sea.object[id] then
		sea.error("Attempted to create object that already exists (ID: "..id..")")
		return
	end

	local object = Object.new(id)

	sea.object[id] = object

	sea.info("Created object (ID: "..id..")")

	return object
end

function Object.remove(id)
	if sea.object[id] then
		sea.object[id] = nil

		sea.info("Removed object (ID: "..id..")")
	else
		sea.error("Attempted to remove non-existent object (ID: "..id..")")
	end
end

function Object.generate()
	for _, id in pairs(object(0, "table")) do
		Object.create(id)
	end
end

function Object.getLastID()
    local objectIDs = object(0, "table")
    return objectIDs[#objectIDs]
end

function Object.spawn(typeID, tileX, tileY, rotation, mode, team, pid)
	parse("spawnobject", typeID, tileX, tileY, rotation, mode, team, pid)

	return Object.create(Object.getLastID())
end

function Object.get()
	local objects = {}

    for _, id in pairs(object(0, "table")) do
        table.insert(objects, sea.object[id])
    end

    return objects
end

function Object.getAt(x, y, typeID)
	local objects = {}
	
	for _, id in pairs(objectat(x, y, typeID)) do
		table.insert(objects, sea.object[id])
	end
	
    return objects
end

function Object.getAtRadius(x, y, radius, typeID)
	local objects = {}
	
	for _, id in pairs(closeobjects(x, y, radius, typeID)) do
		table.insert(objects, sea.object[id])
	end
	
    return objects
end

-------------------------
--       GETTERS       --
-------------------------

function Object:getExistsAttribute()
	return object(self.id, "exists")
end

function Object:getTypeNameAttribute()
	return object(self.id, "typename")
end

function Object:getTypeIDAttribute()
	return object(self.id, "type")
end

function Object:getHealthAttribute()
	return object(self.id, "health")
end

function Object:getModeAttribute()
	return object(self.id, "mode")
end

function Object:getTeamAttribute()
	return object(self.id, "team")
end

function Object:getPlayerIDAttribute()
    return object(self.id, "player")
end

function Object:getXAttribute()
	return object(self.id, "x")
end

function Object:getYAttribute()
	return object(self.id, "y")
end

function Object:getRotationAttribute()
	return object(self.id, "rot")
end

function Object:getTileXAttribute()
	return object(self.id, "tilex")
end

function Object:getTileYAttribute()
	return object(self.id, "tiley")
end

function Object:getCountdownAttribute()
	return object(self.id, "countdown")
end

function Object:getRootRotationAttribute()
	return object(self.id, "rootrot")
end

function Object:getIdleAttribute()
	return object(self.id, "idle")
end

function Object:getRotationVariableAttribute()
	return object(self.id, "rotvar")
end

function Object:getTargetAttribute()
	return object(self.id, "target")
end

function Object:getUpgradeAttribute()
	return object(self.id, "upgrade")
end

function Object:getEntityAttribute()
	return object(self.id, "entity")
end

function Object:getEntityXAttribute()
	return object(self.id, "entityx")
end

function Object:getEntityYAttribute()
	return object(self.id, "entityy")
end

-------------------------
--       SETTERS       --
-------------------------

--[[function Object:setXAttribute(value)
	self:setPosition(value, self.y)
end

function Object:setYAttribute(value)
	self:setPosition(self.x, value)
end

function Object:setTileXAttribute(value)
	self:setPosition(value, self.tiley)
end

function Object:setTileYAttribute(value)
	self:setPosition(self.tilex, value)
end]]

return Object