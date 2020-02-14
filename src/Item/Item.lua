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

function Item:setPosition(x, y)
    local temp = {self.typeID, x, y, self.ammoIn, self.ammo}
    self:destroy()
    Item.spawn(unpack(temp))
end

-------------------------
--        CONST        --
-------------------------

function Item.create(id)
	if sea.item[id] then
		sea.error("Attempted to create item that already exists (ID: "..id..")")
		return
	end

	local item = Item.new(id)

	sea.item[id] = item

	sea.info("Created item (ID: "..id..")")

	return item
end

function Item.remove(id)
	if sea.item[id] then
		sea.item[id] = nil

		sea.info("Removed item (ID: "..id..")")
	else
		sea.error("Attempted to remove non-existent item (ID: "..id..")")
	end
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

function Item.spawn(typeID, x, y, ammoIn, ammo)
	parse("spawnitem", typeID, x, y, ammoIn, ammo)

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

function Item.getAt(x, y)
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

function Item:getAmmoAttribute()
	return item(self.id, "ammo")
end

function Item:getAmmoInAttribute()
	return item(self.id, "ammoin")
end

function Item:getModeAttribute()
	return item(self.id, "mode")
end

function Item:getXAttribute()
	return item(self.id, "x")
end

function Item:getYAttribute()
	return item(self.id, "y")
end

function Item:getDroppedAttribute()
	return item(self.id, "dropped")
end

function Item:getDroptimerAttribute()
	return item(self.id, "droptimer")
end

-------------------------
--       SETTERS       --
-------------------------

function Item:setAmmoInAttribute(value)
	setammo(self.id, 0, value, self.ammo)
end

function Item:setAmmoAttribute(value)
	setammo(self.id, 0, self.ammoIn, value)
end

function Item:setXAttribute(value)
	self:setPosition(value, self.y)
end

function Item:setYAttribute(value)
	self:setPosition(self.x, value)
end

-------------------------
--        INIT         --
-------------------------

return Item