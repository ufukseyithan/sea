sea.object = {}
sea.Object = class()

--[[
	Where items could spawn:
	- Server start
	- Round start (startround hook)
    - Build
    - Image
    - Portal gun

	Where items could be removed:
	- Object kill (objectkill hook)
    - Round start (startround hook) ?
    - Freeimage

	It would be a good idea to completely clear sea.item when fresh round starts
]]

function sea.Object:constructor(id)
    self.id = id
end

function sea.Object:destroy()
	parse("killobject", self.id)
	sea.Object.remove(self.id)
end

-------------------------
--        CONST        --
-------------------------

function sea.Object.getLastID()
    local objectIDs = object(0, "table")
    return objectIDs[#objectIDs]
end

function sea.Object.spawn(typeID, tileX, tileY, rotation, mode, team, pid)
	parse("spawnobject", typeID, tileX, tileY, rotation, mode, team, pid)

	local id = sea.Object.getLastID()
	local object = sea.Object.new(id)

	sea.object[id] = object

	return object
end

function sea.Object.remove(id)
	sea.object[id] = nil
end

function sea.Object.get()
	local objects = {}

    for _, id in pairs(object(0, "table")) do
        table.insert(objects, sea.object[id])
    end

    return objects
end

function sea.Object.getAt(x, y, typeID)
	local objects = {}
	
	for _, id in pairs(objectat(x, y, typeID)) do
		table.insert(objects, sea.object[id])
	end
	
    return objects
end

function sea.Object.getAtRadius(x, y, radius, typeID)
	local objects = {}
	
	for _, id in pairs(closeobjects(x, y, radius, typeID)) do
		table.insert(objects, sea.object[id])
	end
	
    return objects
end

-------------------------
--       GETTERS       --
-------------------------

function sea.Object:getExistsAttribute()
	return object(self.id, "exists")
end

function sea.Object:getTypenameAttribute()
	return object(self.id, "typename")
end

function sea.Object:getTypeIdAttribute()
	return object(self.id, "type")
end

function sea.Object:getHealthAttribute()
	return object(self.id, "health")
end

function sea.Object:getModeAttribute()
	return object(self.id, "mode")
end

function sea.Object:getTeamAttribute()
	return object(self.id, "team")
end

function sea.Object:getPlayerIdAttribute()
	return object(self.id, "id")
end

function sea.Object:getUserIdAttribute()
    return object(self.id, "player")
end

function sea.Object:getXAttribute()
	return object(self.id, "x")
end

function sea.Object:getYAttribute()
	return object(self.id, "y")
end

function sea.Object:getRotAttribute()
	return object(self.id, "rot")
end

function sea.Object:getTilexAttribute()
	return object(self.id, "tilex")
end

function sea.Object:getTileyAttribute()
	return object(self.id, "tiley")
end

function sea.Object:getCountdownAttribute()
	return object(self.id, "countdown")
end

function sea.Object:getRootrotAttribute()
	return object(self.id, "rootrot")
end

function sea.Object:getIdleAttribute()
	return object(self.id, "idle")
end

function sea.Object:getRotvarAttribute()
	return object(self.id, "rotvar")
end

function sea.Object:getTargetAttribute()
	return object(self.id, "target")
end

function sea.Object:getUpgradeAttribute()
	return object(self.id, "upgrade")
end

function sea.Object:getEntityAttribute()
	return object(self.id, "entity")
end

function sea.Object:getEntityxAttribute()
	return object(self.id, "entityx")
end

function sea.Object:getEntityyAttribute()
	return object(self.id, "entityy")
end

-------------------------
--       SETTERS       --
-------------------------

function sea.Object:setXAttribute(value)
	self:setPos(value, self.y)
end

function sea.Object:setYAttribute(value)
	self:setPos(self.x, value)
end

function sea.Object:setTilexAttribute(value)
	self:setPos(value, self.tiley)
end

function sea.Object:setTileyAttribute(value)
	self:setPos(self.tilex, value)
end

