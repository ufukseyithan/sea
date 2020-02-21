sea.projectile = {}
local Projectile = class()

--[[
    ***WARNING:*** Since CS2D does not have a hook or something like that where it would be possible to get the ID of the project that is needed
    to create a projectile class, this class is not yet usable. If CS2D gets a related update, this can have a use.
]]

function Projectile:constructor(listID, id)
    self.listID = id
    self.id = id
end

-------------------------
--        CONST        --
-------------------------

function Projectile.create(listID, id)
    if sea.projectile[id] then
		sea.error("Attempted to create projectile that already exists (ID: "..id..")")
		return
    end
    
	local projectile = Projectile.new(listID, id)

    table.insert2D(sea.projectile, listID, id, projectile)

	sea.info("Created projectile (ID: "..id.." for the list "..listID..")")

	return projectile
end

function Projectile.remove(listID, id)
    if sea.item[listID][id] then
        sea.item[listID][id] = nil

        sea.info("Removed projectile (ID: "..id.." from the list "..listID..")")
    else
        sea.error("Attempted to remove non-existent projectile (ID: "..id..")")
    end
end

--[[
    @mode (number) : can be either 0 (flying objects) or 1 (ground projectiles)
]]
function Projectile.getLastID(mode, listID)
    local projectileIDs = projectile(mode, listID, "table")
    return projectileIDs[#projectileIDs]
end

function Projectile.spawn(listID, itemTypeID, x, y, range, direction)
    parse("spawnprojectile", listID, itemTypeID, x, y, range, direction)

    return Projectile.create(listID, Projectile.getLastID(0, listID))
end

-------------------------
--       GETTERS       --
-------------------------

function Projectile:getExistsAttribute()
    return projectile(self.id, self.listID, "exists")
end

function Projectile:getItemTypeIDAttribute()
    return projectile(self.id, self.listID, "type")
end

function Projectile:getItemTypeAttribute()
    return sea.itemType[self.itemTypeID]
end

function Projectile:getXAttribute()
    return projectile(self.id, self.listID, "x")
end

function Projectile:getYAttribute()
    return projectile(self.id, self.listID, "y")
end

function Projectile:getDirectionAttribute()
    return projectile(self.id, self.listID, "dir")
end

function Projectile:getRotationAttribute()
    return projectile(self.id, self.listID, "rotation")
end

function Projectile:getFlyDistanceAttribute()
    return projectile(self.id, self.listID, "flydist")
end

function Projectile:getTimeAttribute()
    return projectile(self.id, self.listID, "time")
end

-------------------------
--        INIT         --
-------------------------

return Projectile