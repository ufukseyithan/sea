sea.item = {}
local Item = class()

--[[
	Where items could spawn:
	- Server start (done!)
	- Round start (startround hook) (done!)
	- Play drop (drop hook) (done!)
	- Item projectile? (Check item_projectile hook)

	Where items could be removed:
	- Player collect (collect hook) (done!)
	- Fade out (itemfadeout hook) (done!)
	- Round start (startround hook) (done!)
]]

function Item:constructor(id)
    self.id = id
end

function Item:destroy()
	parse("removeitem", self.id)
	Item.remove(self.id)
end

function Item:setPosition(tileX, tileY)
    local temp = {self.typeID, tileX, tileY, self.loadedAmmo, self.spareAmmo}
    self:destroy()
    Item.spawn(unpack(temp))
end

-------------------------
--        CONST        --
-------------------------

function Item.create(id, object)
	if sea.item[id] then
		sea.error("Attempted to create item that already exists (ID: "..id..")")
		return false
	end

	sea.item[id] = object or Item.new(id)

	sea.success("Created item (ID: "..id..")")

	return sea.item[id]
end

function Item.remove(id)
	if not sea.item[id] then
		sea.error("Attempted to remove non-existent item (ID: "..id..")")
		return false
	end

	sea.item[id] = nil

	sea.success("Removed item (ID: "..id..")")

	return true
end

function Item.generate()
	for _, id in pairs(item(0, "table")) do
		Item.create(id)
	end
end

function Item.getLastID()
    local itemIDs = item(0, "table")
    return itemIDs[#itemIDs]
end

function Item.spawn(typeID, tileX, tileY, loadedAmmo, spareAmmo)
	parse("spawnitem", typeID, tileX, tileY, loadedAmmo, spareAmmo)

	return Item.create(Item.getLastID())
end

function Item.get()
	local items = {}

    for _, id in pairs(item(0, "table")) do
        table.insert(items, sea.item[id])
    end

    return items
end

--[[
	@param radius (number) Radius in tiles. 
]]
function Item.getCloseToPlayer(player, radius)
	local items = {}

	for _, id in pairs(closeitems(player.id, radius)) do
		table.insert(items, sea.item[id])
	end

	return items
end

-------------------------
--       GETTERS       --
-------------------------

function Item:getExistsAttribute()
    return item(self.id, "exists")
end

function Item:getNameAttribute()
	return item(self.id, "name")
end

function Item:getTypeIDAttribute()
	return item(self.id, "type")
end

function Item:getTypeAttribute()
    return sea.itemType[self.typeID]
end

function Item:getPlayerAttribute()
	return sea.player[item(self.id, "player")]
end

function Item:getSpareAmmoAttribute()
	return item(self.id, "ammo")
end

function Item:getLoadedAmmoAttribute()
	return item(self.id, "ammoin")
end

function Item:getModeAttribute()
	return item(self.id, "mode")
end

function Item:getTileXAttribute()
	return item(self.id, "x")
end

function Item:getTileYAttribute()
	return item(self.id, "y")
end

function Item:getXAttribute()
	return tileToPixel(self.tileX)
end

function Item:getYAttribute()
	return tileToPixel(self.tileY)
end

function Item:getDroppedAttribute()
	return item(self.id, "dropped")
end

function Item:getDropTimerAttribute()
	return item(self.id, "droptimer")
end

-------------------------
--       SETTERS       --
-------------------------

function Item:setLoadedAmmoAttribute(value)
	setammo(self.id, 0, value, self.spareAmmo)
end

function Item:setSpareAmmoAttribute(value)
	setammo(self.id, 0, self.loadedAmmo, value)
end

function Item:setTileXAttribute(value)
	self:setPosition(value, self.tileY)
end

function Item:setTileYAttribute(value)
	self:setPosition(self.tileX, value)
end

function Item:setXAttribute(value)
	self:setPosition(pixelToTile(value), self.tileY)
end

function Item:setYAttribute(value)
	self:setPosition(self.tileX, pixelToTile(value))
end

-------------------------
--        INIT         --
-------------------------

return Item