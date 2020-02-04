sea.item = {}
sea.Item = class()

--[[
	Where items could spawn:
	- Server start
	- Round start (startround hook)
	- Play drop (drop hook)
	- Spawnitem command
	- Item projectile? (Check item_projectile hook)

	Where items could be removed:
	- Player collect (collect hook)
	- Fade out (itemfadeout hook)
	- Round start (startround hook)

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

function sea.Item.getLastID()
    local itemIDs = item(0, "table")
    return itemIDs[#itemIDs]
end

function sea.Item.spawn(typeID, x, y, ammoIn, ammo)
	parse("spawnitem", typeID, x, y, ammoIn, ammo)

	local id = sea.Item.getLastID()
	local item = sea.Item.new(id)

	sea.item[id] = item

	return item
end

-- Removes from the list
function sea.Item.remove(id)
	sea.item[id] = nil
end

function sea.Item.get()
	local items = {}

    for _, item in pairs(sea.item) do
        table.insert(items, item)
    end

    return allObjectsMetaTable(items)
end

--[[
	@param radius (number) Radius in tiles. 
]]
function sea.Item.getCloseToPlayer(player, radius)
	local items = {}

	for _, id in pairs(closeitems(player.id, radius)) do
		table.insert(items, sea.item[id])
	end

	return allObjectsMetaTable(items)
end

function sea.Item.getAt(x, y)
	local items = {}

	for _, item in pairs(sea.item) do
		if item.x == x and item.y == y then
			table.insert(items, item)
		end
    end

    return allObjectsMetaTable(items)
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
	self:setPos(value, self.y)
end

function sea.Item:setYAttribute(value)
	self:setPos(self.x, value)
end
