sea.objectType = {}
local ObjectType = class()

function ObjectType:constructor(id)
    self.id = id
end

-------------------------
--       GETTERS       --
-------------------------

function ObjectType:getNameAttribute()
	return objecttype(self.id, "name")
end

function ObjectType:getInternalnameAttribute()
	return objecttype(self.id, "internalname")
end

function ObjectType:getTypeAttribute()
	return objecttype(self.id, "type")
end

function ObjectType:getPriceAttribute()
	return objecttype(self.id, "price")
end

function ObjectType:getHealthAttribute()
	return objecttype(self.id, "health")
end

function ObjectType:getKillmoneyAttribute()
	return objecttype(self.id, "killmoney")
end

function ObjectType:getLimitAttribute()
	return objecttype(self.id, "limit")
end

function ObjectType:getUpgradepointsAttribute()
	return objecttype(self.id, "upgradepoints")
end

function ObjectType:getUpgradepriceAttribute()
	return objecttype(self.id, "upgradeprice")
end

function ObjectType:getUpgradetoAttribute()
	return objecttype(self.id, "upgradeto")
end

-------------------------
--       SETTERS       --
-------------------------

function ObjectType:setHealthAttribute(value)
	parse("mp_building_health", self.name, value)
end

function ObjectType:setPriceAttribute(value)
	parse("mp_building_price", self.name, value)
end

function ObjectType:setLimitAttribute(value)
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
    sea.objectType[typeID] = ObjectType.new(typeID)
end

return ObjectType