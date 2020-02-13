sea.item = {}
sea.Item = class()

--[[
	Where items could spawn:
	- Server start (done!)
	- Round start (startround hook) (done!)
	- Play drop (drop hook) (done!)
	- Item projectile? (Check item_projectile hook)

	Where items could be removed:
	- Player collect (collect hook) (done!)
	- Fade out (itemfadeout hook)
	- Round start (startround hook) (done!)

	It would be a good idea to completely clear sea.item when fresh round starts
]]

function sea.Item:constructor(id)
    self.id = id
end

function sea.Item:destroy()
	parse("removeitem", self.id)
	sea.Item.remove(self.id)
end

function sea.Item:setPosition(x, y)
    local temp = {self.typeID, x, y, self.ammoIn, self.ammo}
    self:destroy()
    sea.Item.spawn(unpack(temp))
end

-------------------------
--        CONST        --
-------------------------

function sea.Item.create(id)
	if sea.item[id] then
		sea.error("Attempted to create item that already exists (ID: "..id..")")
		return
	end

	local item = sea.Item.new(id)

	sea.item[id] = item

	sea.info("Created item (ID: "..id..")")

	return item
end

function sea.Item.remove(id)
	if sea.item[id] then
		sea.item[id] = nil

		sea.info("Removed item (ID: "..id..")")
	else
		sea.error("Attempted to remove non-existent item (ID: "..id..")")
	end
end

function sea.Item.generate()
	for _, id in pairs(item(0, "table")) do
		sea.Item.create(id)
	end
end

function sea.Item.getLastID()
    local itemIDs = item(0, "table")
    return itemIDs[#itemIDs]
end

function sea.Item.spawn(typeID, x, y, ammoIn, ammo)
	parse("spawnitem", typeID, x, y, ammoIn, ammo)

	return sea.Item.create(sea.Item.getLastID())
end

function sea.Item.get()
	local items = {}

    for _, id in pairs(item(0, "table")) do
        table.insert(items, sea.item[id])
    end

    return items
end

--[[
	@param radius (number) Radius in tiles. 
]]
function sea.Item.getCloseToPlayer(player, radius)
	local items = {}

	for _, id in pairs(closeitems(player.id, radius)) do
		table.insert(items, sea.item[id])
	end

	return items
end

function sea.Item.getAt(x, y)
	local items = {}

	for _, item in pairs(sea.item) do
		if item.x == x and item.y == y then
			table.insert(items, item)
		end
    end

    return items
end

-------------------------
--       GETTERS       --
-------------------------

function sea.Item:getExistsAttribute()
    return item(self.id, "exists")
end

function sea.Item:getNameAttribute()
	return item(self.id, "name")
end

function sea.Item:getTypeIDAttribute()
	return item(self.id, "type")
end

function sea.Item:getTypeAttribute()
    return sea.itemType[self.typeID]
end

function sea.Item:getPlayerAttribute()
	return sea.player[item(self.id, "player")]
end

function sea.Item:getAmmoAttribute()
	return item(self.id, "ammo")
end

function sea.Item:getAmmoInAttribute()
	return item(self.id, "ammoin")
end

function sea.Item:getModeAttribute()
	return item(self.id, "mode")
end

function sea.Item:getXAttribute()
	return item(self.id, "x")
end

function sea.Item:getYAttribute()
	return item(self.id, "y")
end

function sea.Item:getDroppedAttribute()
	return item(self.id, "dropped")
end

function sea.Item:getDroptimerAttribute()
	return item(self.id, "droptimer")
end

-------------------------
--       SETTERS       --
-------------------------

function sea.Item:setAmmoInAttribute(value)
	setammo(self.id, 0, value, self.ammo)
end

function sea.Item:setAmmoAttribute(value)
	setammo(self.id, 0, self.ammoIn, value)
end

function sea.Item:setXAttribute(value)
	self:setPosition(value, self.y)
end

function sea.Item:setYAttribute(value)
	self:setPosition(self.x, value)
end