sea.projectile = {}
local Projectile = class()

--[[
    ***WARNING:*** Since CS2D does not have a hook or something like that where it would be possible to get the ID of the project that is needed
    to create a projectile class, this class is not yet usable. If CS2D gets a related update, this can have a use.
]]

function Projectile:constructor(playerID, id)
    self.playerID = playerID
    self.id = id
end

-------------------------
--        CONST        --
-------------------------

function Projectile.create(playerID, id)
    sea.projectile[playerID] = sea.projectile[playerID] or {}

    if sea.projectile[playerID][id] then
		sea.error("Attempted to create projectile that already exists (ID: "..id..")")
		return false
    end

	local projectile = Projectile.new(playerID, id)

    table.insert2D(sea.projectile, playerID, id, projectile)

	sea.success("Created projectile (ID: "..id.." for the player "..playerID..")")

	return projectile
end

function Projectile.remove(playerID, id)
    if not sea.projectile[playerID] or not sea.projectile[playerID][id] then
		sea.error("Attempted to remove non-existent projectile (ID: "..id..")")
		return false
    end

    sea.projectile[playerID][id] = nil

    sea.success("Removed projectile (ID: "..id.." from the list "..playerID..")")
        
    return true
end

--[[
    @playerID (number) : player ID (0 for all players)
    @return (number) : returns the first available projectile ID starting from 1
]]
function Projectile.getAvailableID(playerID)
    local usedIDs = {}

    -- Check both flying and on-ground projectiles, since the ID is shared between them
    for m = 0, 1 do
        local projectiles = projectilelist(m, playerID or 0)
        for _, p in pairs(projectiles) do
            usedIDs[p.id] = true
        end
    end

    local availableID = 1
    while usedIDs[availableID] do
        availableID = availableID + 1
    end

    return availableID
end

function Projectile.spawn(playerID, itemTypeID, x, y, range, direction)
    local availableID = Projectile.getAvailableID(playerID)

    parse("spawnprojectile", playerID, itemTypeID, x, y, range, direction)

    return Projectile.create(playerID, availableID)
end

-------------------------
--       GETTERS       --
-------------------------

function Projectile:getExistsAttribute()
    return projectile(self.id, self.playerID, "exists")
end

function Projectile:getItemTypeIDAttribute()
    return projectile(self.id, self.playerID, "type")
end

function Projectile:getItemTypeAttribute()
    return sea.itemType[self.itemTypeID]
end

function Projectile:getXAttribute()
    return projectile(self.id, self.playerID, "x")
end

function Projectile:getYAttribute()
    return projectile(self.id, self.playerID, "y")
end

function Projectile:getDirectionAttribute()
    return projectile(self.id, self.playerID, "dir")
end

function Projectile:getRotationAttribute()
    return projectile(self.id, self.playerID, "rotation")
end

function Projectile:getFlyDistanceAttribute()
    return projectile(self.id, self.playerID, "flydist")
end

function Projectile:getTimeAttribute()
    return projectile(self.id, self.playerID, "time")
end

-------------------------
--        INIT         --
-------------------------

return Projectile
