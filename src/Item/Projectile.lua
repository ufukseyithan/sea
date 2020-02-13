sea.projectile = {}
sea.Projectile = class()

--[[
    WARNING: Since CS2D does not have a hook or something like that where it would be possible to get the ID of the project that is needed
    to create a projectile class, this class is not yet usable. If CS2D gets a related update, this can have a use.
]]

function sea.Projectile:constructor(listID, id)
    self.listID = id
    self.id = id
end

-------------------------
--        CONST        --
-------------------------

function sea.Projectile.create(listID, id)
    if sea.projectile[id] then
		sea.error("Attempted to create projectile that already exists (ID: "..id..")")
		return
    end
    
	local projectile = sea.Projectile.new(listID, id)

    table.insert2D(sea.projectile, listID, id, projectile)

	sea.info("Created projectile (ID: "..id.." for the list "..listID..")")

	return projectile
end

function sea.Projectile.remove(listID, id)
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
function sea.Projectile.getLastID(mode, listID)
    local projectileIDs = projectile(mode, listID, "table")
    return projectileIDs[#projectileIDs]
end

function sea.Projectile.spawn(listID, itemTypeID, x, y, range, direction)
    parse("spawnprojectile", listID, itemTypeID, x, y, range, direction)

    return sea.Projectile.create(listID, sea.Projectile.getLastID(0, listID))
end

-------------------------
--       GETTERS       --
-------------------------

function sea.Projectile:getExistsAttribute()
    return projectile(self.id, self.listID, "exists")
end

function sea.Projectile:getItemTypeIDAttribute()
    return projectile(self.id, self.listID, "type")
end

function sea.Projectile:getItemTypeAttribute()
    return sea.itemType[self.itemTypeID]
end

function sea.Projectile:getXAttribute()
    return projectile(self.id, self.listID, "x")
end

function sea.Projectile:getYAttribute()
    return projectile(self.id, self.listID, "y")
end

function sea.Projectile:getDirectionAttribute()
    return projectile(self.id, self.listID, "dir")
end

function sea.Projectile:getRotationAttribute()
    return projectile(self.id, self.listID, "rotation")
end

function sea.Projectile:getFlyDistanceAttribute()
    return projectile(self.id, self.listID, "flydist")
end

function sea.Projectile:getTimeAttribute()
    return projectile(self.id, self.listID, "time")
end