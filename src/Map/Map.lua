local Map = class()

function Map:constructor()
	self.tile = sea.tile
	self.entity = sea.entity

	self:generate()
end

function Map:generate()
    for x = 0, self.xSize - 1 do
        for y = 0, self.ySize - 1 do
            local tile = sea.Tile.new(x, y)

            table.insert2D(self.tile, x, y, tile)
        end
	end

	for _, e in pairs(entitylist()) do
		local entity = sea.Entity.new(e.x, e.y)
	
		table.insert2D(self.entity, e.x, e.y, entity)
	end
end

function Map:getTile(x, y)
    return self.tile[x][y]
end

function Map:getEntity(x, y)
    return self.entity[x][y]
end

-------------------------
--       GETTERS       --
-------------------------

function Map:getNameAttribute()
	return map("name")
end

function Map:getXSizeAttribute()
	return map("xsize")
end

function Map:getYSizeAttribute()
	return map("ysize")
end

function Map:getTilesetAttribute()
	return map("tileset")
end

function Map:getTileCountAttribute()
	return map("tilecount")
end

function Map:getBackgroundImageAttribute()
	return map("back_img")
end

function Map:getBackgroundScrollXAttribute()
	return map("back_scrollx")
end

function Map:getBackgroundScrollYAttribute()
	return map("back_scrolly")
end

function Map:getBackgroundScrollTileAttribute()
	return map("back_scrolltile")
end

function Map:getBackgroundRAttribute()
	return map("back_r")
end

function Map:getBackgroundGAttribute()
	return map("back_g")
end

function Map:getBackgroundBAttribute()
	return map("back_b")
end

function Map:getStormXAttribute()
	return map("storm_x")
end

function Map:getStormYAttribute()
	return map("storm_y")
end

function Map:getVipSpawnsAttribute()
	return map("mission_vips")
end

function Map:getHostagesAttribute()
	return map("mission_hostages")
end

function Map:getBombSpotsAttribute()
	return map("mission_bombspots")
end

function Map:getCtfFlagsAttribute()
	return map("mission_ctfflags")
end

function Map:getDomPointsAttribute()
	return map("mission_dompoints")
end

function Map:getNoBuyingAttribute()
	return map("nobuying")
end

function Map:getNoWeaponsAttribute()
	return map("noweapons")
end

function Map:getTeleportersAttribute()
	return map("teleporters")
end

function Map:getBotNodesAttribute()
	return map("botnodes")
end

return Map