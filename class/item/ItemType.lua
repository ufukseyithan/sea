sea.itemType = {}
local ItemType = class()

function ItemType:constructor(id)
    self.id = id
end

function ItemType:isArmor()
	local id = self.id
	
	if id == 57 or id == 58 then
		return true
	elseif id >= 79 and id <= 84 then
		return true
	end

	return false
end

function ItemType:toArmor()
	local id = self.id

	if id == 57 then
		return 65
	elseif id == 58 then 
		return 100
	elseif id >= 79 and id <= 84 then
		return 200 + (id - 78)
	end

	return 0
end

-------------------------
--       CONSTS        --
-------------------------

function ItemType.armorToItem(armor)
	if armor <= 65 then
		return sea.itemType[57]
	elseif armor <= 200 then
		return sea.itemType[58]
	else
		return sea.itemType[armor - 122]
	end
end

-------------------------
--       GETTERS       --
-------------------------

function ItemType:getNameAttribute()
	return itemtype(self.id, "name")
end

function ItemType:getDamageAttribute()
	return itemtype(self.id, "dmg")
end

function ItemType:getDamageZoom1Attribute()
	return itemtype(self.id, "dmg_z1")
end

function ItemType:getDamageZoom2Attribute()
	return itemtype(self.id, "dmg_z2")
end

function ItemType:getRateAttribute()
	return itemtype(self.id, "rate")
end

function ItemType:getReloadAttribute()
	return itemtype(self.id, "reload")
end

function ItemType:getAmmoAttribute()
	return itemtype(self.id, "ammo")
end

function ItemType:getAmmoInAttribute()
	return itemtype(self.id, "ammoin")
end

function ItemType:getPriceAttribute()
	return itemtype(self.id, "price")
end

function ItemType:getRangeAttribute()
	return itemtype(self.id, "range")
end

function ItemType:getDispersionAttribute()
	return itemtype(self.id, "dispersion")
end

function ItemType:getSlotAttribute()
	return itemtype(self.id, "slot")
end

function ItemType:getRecoilAttribute()
	return itemtype(self.id, "recoil")
end

function ItemType:getImagePathAttribute()
	local path = "gfx/weapons/"

    path = path..self.name:lower():gsub("%s+", ""):gsub("-", "")

    if io.exists(path.."_d.bmp") then
        path = path.."_d"
    end

    return path..".bmp"
end

-------------------------
--        INIT         --
-------------------------

local typeIDs = {
	-- Secondary
    1, 2, 3, 4, 5, 6, 
	
	-- Primary
	10, 11, 
	20, 21, 22, 23, 24, 
	30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 91,
	40, 41, 45, 46, 47, 48, 49, 88, 90,

	-- Melee
	50, 69, 74, 78, 85,

	-- Grenades
	51, 52, 53, 54, 72, 73, 75, 76, 86, 89, 77, 87,

	-- Equipment
	56, 59, 60, 61, 62,

	-- Armor
	57, 58, 79, 80, 81, 82, 83, 84,

	-- Misc
	55, 63, 64, 65, 66, 67, 68, 70, 71,
}

for _, typeID in pairs(typeIDs) do
    sea.itemType[typeID] = ItemType.new(typeID)
end

return ItemType