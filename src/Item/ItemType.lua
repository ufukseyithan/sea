sea.itemType = {}
sea.ItemType = class()

function sea.ItemType:constructor(id)
    self.id = id
end

function sea.ItemType:getNameAttribute()
	return itemtype(self.id, "name")
end

function sea.ItemType:getDamageAttribute()
	return itemtype(self.id, "dmg")
end

function sea.ItemType:getDamageZoom1Attribute()
	return itemtype(self.id, "dmg_z1")
end

function sea.ItemType:getDamageZoom2Attribute()
	return itemtype(self.id, "dmg_z2")
end

function sea.ItemType:getRateAttribute()
	return itemtype(self.id, "rate")
end

function sea.ItemType:getReloadAttribute()
	return itemtype(self.id, "reload")
end

function sea.ItemType:getAmmoAttribute()
	return itemtype(self.id, "ammo")
end

function sea.ItemType:getAmmoInAttribute()
	return itemtype(self.id, "ammoin")
end

function sea.ItemType:getPriceAttribute()
	return itemtype(self.id, "price")
end

function sea.ItemType:getRangeAttribute()
	return itemtype(self.id, "range")
end

function sea.ItemType:getDispersionAttribute()
	return itemtype(self.id, "dispersion")
end

function sea.ItemType:getSlotAttribute()
	return itemtype(self.id, "slot")
end

function sea.ItemType:getRecoilAttribute()
	return itemtype(self.id, "recoil")
end

-------------------------
--        INIT         --
-------------------------

local typeIDs = {
    1, 2, 3, 4, 5, 6, 10, 11, 20, 21, 22, 23, 24, 30, 31, 32, 33, 34, 35,
    36, 37, 38, 39, 40, 41, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56,
    57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
    75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91
}

for _, typeID in pairs(typeIDs) do
    sea.itemType[typeID] = sea.ItemType.new(typeID)
end