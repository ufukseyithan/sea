sea.objectType = {}
sea.ObjectType = class()

function sea.ObjectType:constructor(id)
    self.id = id
end

-------------------------
--       GETTERS       --
-------------------------

function sea.ObjectType:getNameAttribute()
	return objecttype(self.id, "name")
end

function sea.ObjectType:getInternalnameAttribute()
	return objecttype(self.id, "internalname")
end

function sea.ObjectType:getTypeAttribute()
	return objecttype(self.id, "type")
end

function sea.ObjectType:getPriceAttribute()
	return objecttype(self.id, "price")
end

function sea.ObjectType:getHealthAttribute()
	return objecttype(self.id, "health")
end

function sea.ObjectType:getKillmoneyAttribute()
	return objecttype(self.id, "killmoney")
end

function sea.ObjectType:getLimitAttribute()
	return objecttype(self.id, "limit")
end

function sea.ObjectType:getUpgradepointsAttribute()
	return objecttype(self.id, "upgradepoints")
end

function sea.ObjectType:getUpgradepriceAttribute()
	return objecttype(self.id, "upgradeprice")
end

function sea.ObjectType:getUpgradetoAttribute()
	return objecttype(self.id, "upgradeto")
end

-------------------------
--       SETTERS       --
-------------------------

function sea.ObjectType:setHealthAttribute(value)
	parse("mp_building_health", self.name, value)
end

function sea.ObjectType:setPriceAttribute(value)
	parse("mp_building_price", self.name, value)
end

function sea.ObjectType:setLimitAttribute(value)
	parse("mp_building_limit", self.name, value)
end

-------------------------
--        INIT         --
-------------------------

local typeIDs = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
    20, 21, 22, 23, 
    30,
    40
}

for _, typeID in pairs(typeIDs) do
    sea.objectType[typeID] = sea.ObjectType.new(typeID)
end