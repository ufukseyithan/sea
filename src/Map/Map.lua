sea.Map = class()

function sea.Map:constructor()
	self.tile = sea.tile
	self.entity = sea.entity

	self:generateTiles()
end

function sea.Map:generateTiles()
    for x = 0, self.xSize - 1 do
        for y = 0, self.ySize - 1 do
            local tile = sea.Tile.new(x, y)

            table.insert2D(self.tile, x, y, tile)
        end
    end
end

function sea.Map:getTile(x, y)
    return self.tile[x][y]
end

function sea.Map:getEntity(x, y)
    return self.entity[x][y]
end

-------------------------
--       GETTERS       --
-------------------------

function sea.Map:getNameAttribute()
	return map("name")
end

function sea.Map:getXSizeAttribute()
	return map("xsize")
end

function sea.Map:getYSizeAttribute()
	return map("ysize")
end

function sea.Map:getTilesetAttribute()
	return map("tileset")
end

function sea.Map:getTileCountAttribute()
	return map("tilecount")
end

function sea.Map:getBackgroundImageAttribute()
	return map("back_img")
end

function sea.Map:getBackgroundScrollXAttribute()
	return map("back_scrollx")
end

function sea.Map:getBackgroundScrollYAttribute()
	return map("back_scrolly")
end

function sea.Map:getBackgroundScrollTileAttribute()
	return map("back_scrolltile")
end

function sea.Map:getBackgroundRAttribute()
	return map("back_r")
end

function sea.Map:getBackgroundGAttribute()
	return map("back_g")
end

function sea.Map:getBackgroundBAttribute()
	return map("back_b")
end

function sea.Map:getStormXAttribute()
	return map("storm_x")
end

function sea.Map:getStormYAttribute()
	return map("storm_y")
end

function sea.Map:getVipSpawnsAttribute()
	return map("mission_vips")
end

function sea.Map:getHostagesAttribute()
	return map("mission_hostages")
end

function sea.Map:getBombSpotsAttribute()
	return map("mission_bombspots")
end

function sea.Map:getCtfFlagsAttribute()
	return map("mission_ctfflags")
end

function sea.Map:getDomPointsAttribute()
	return map("mission_dompoints")
end

function sea.Map:getNoBuyingAttribute()
	return map("nobuying")
end

function sea.Map:getNoWeaponsAttribute()
	return map("noweapons")
end

function sea.Map:getTeleportersAttribute()
	return map("teleporters")
end

function sea.Map:getBotNodesAttribute()
	return map("botnodes")
end
