sea.player = {}
sea.Player = class()

-- @TODO: Player get & set info

-- @TODO: Player get & set stat

-- @TODO: Player get & set setting

-- @TODO: Player get & set variable

function sea.Player:constructor(id)
    self.id = id
end

function sea.Player:kick(reason)
	parse("kick", self.id, reason)
end

function sea.Player:banIP(duration, reason)
	parse("banip", self.ip, duration, reason)
end

function sea.Player:banName(duration, reason)
	parse("banname", self.name, duration, reason)
end

function sea.Player:banSteam(duration, reason)
	parse("bansteam", self.steamid, duration, reason)
end

function sea.Player:banUSGN(duration, reason)
	parse("banusgn", self.usgn, duration, reason)
end

function sea.Player:kill()
	parse("killplayer", self.id)
end

function sea.Player:killBy(killer, weapon)
	parse("customkill", killer, weapon, self.id)
end

function sea.Player:slap()
	parse("slap", self.id)
end

function sea.Player:setPosition(x, y)
	parse("setpos", self.id, x, y)
end

function sea.Player:spawn(x, y)
	parse("spawnplayer", self.id, x, y)
end

function sea.Player:equip(weapon)
	parse("equip", self.id, weapon)
end

function sea.Player:equipAndSet(weapon)
	self:equip(weapon)
	self.weapon = weapon
end

function sea.Player:reroute(address)
	parse("reroute", self.id, address)
end

function sea.Player:shake(power)
	parse("shake", self.id, power)
end

function sea.Player:strip(weapon)
	parse("strip", self.id, weapon)
end

function sea.Player:getWeapons()
	-- @TODO: This should return itemType objects instead
	return playerweapons(self.id)
end

function sea.Player:hasWeapon(weapon)
	for _, id in pairs(playerweapons(self.id)) do
		if id == weapon then
			return true
		end
	end

	return false
end

function sea.Player:getAmmo(weapon)
	local ammoIn, ammo = playerammo(self.id, weapon)

	return {
		["in"] = ammoIn,
		spare = ammo
	}
end

-------------------------
--        CONST        --
-------------------------

local function getPlayers(mode, specific)
	local players = {}
	
	for _, id in pairs(player(0, mode)) do
		if specific then
			if table.contains(specific, id) then
				table.insert(players, sea.player[id])
			end
		else
			table.insert(players, sea.player[id])
		end
	end
	
    return players
end

function sea.Player.get(specific)
    return getPlayers("table", specific)
end

function sea.Player.getLiving(specific)
    return getPlayers("tableliving", specific)
end

function sea.Player.getTerrorists(specific)
    return getPlayers("team1", specific)
end

function sea.Player.getCounterTerrorists(specific)
    return getPlayers("team2", specific)
end

function sea.Player.getLivingTerrorists(specific)
    return getPlayers("team1living", specific)
end

function sea.Player.getLivingCounterTerrorists(specific)
    return getPlayers("team2living", specific)
end

-------------------------
--       GETTERS       --
-------------------------

function sea.Player:getExistsAttribute()
	return player(self.id, "exists")
end

function sea.Player:getNameAttribute()
	return player(self.id, "name")
end

function sea.Player:getIpAttribute()
	return player(self.id, "ip")
end

function sea.Player:getPortAttribute()
	return player(self.id, "port")
end

function sea.Player:getUsgnAttribute()
	return player(self.id, "usgn")
end

function sea.Player:getUsgnNameAttribute()
	return player(self.id, "usgnname")
end

function sea.Player:getSteamIDAttribute()
	return player(self.id, "steamid")
end

function sea.Player:getSteamNameAttribute()
	return player(self.id, "steamname")
end

function sea.Player:getPingAttribute()
	return player(self.id, "ping")
end

function sea.Player:getIdleAttribute()
	return player(self.id, "idle")
end

function sea.Player:getBotAttribute()
	return player(self.id, "bot")
end

function sea.Player:getTeamAttribute()
	return player(self.id, "team")
end

function sea.Player:getLookAttribute()
	return player(self.id, "look")
end

function sea.Player:getXAttribute()
	return player(self.id, "x")
end

function sea.Player:getYAttribute()
	return player(self.id, "y")
end

function sea.Player:getRotationAttribute()
	return player(self.id, "rot")
end

function sea.Player:getTileXAttribute()
	return player(self.id, "tilex")
end

function sea.Player:getTileYAttribute()
	return player(self.id, "tiley")
end

function sea.Player:getHealthAttribute()
	return player(self.id, "health")
end

function sea.Player:getArmorAttribute()
	return player(self.id, "armor")
end

function sea.Player:getMoneyAttribute()
	return player(self.id, "money")
end

function sea.Player:getScoreAttribute()
	return player(self.id, "score")
end

function sea.Player:getDeathsAttribute()
	return player(self.id, "deaths")
end

function sea.Player:getTeamKillsAttribute()
	return player(self.id, "teamkills")
end

function sea.Player:getHostageKillsAttribute()
	return player(self.id, "hostagekills")
end

function sea.Player:getTeamBuildingKillsAttribute()
	return player(self.id, "teambuildingkills")
end

function sea.Player:getWeaponAttribute()
	return player(self.id, "weapontype")
end

function sea.Player:getNightvisionAttribute()
	return player(self.id, "nightvision")
end

function sea.Player:getDefusekitAttribute()
	return player(self.id, "defusekit")
end

function sea.Player:getGasmaskAttribute()
	return player(self.id, "gasmask")
end

function sea.Player:getBombAttribute()
	return player(self.id, "bomb")
end

function sea.Player:getFlagAttribute()
	return player(self.id, "flag")
end

function sea.Player:getReloadingAttribute()
	return player(self.id, "reloading")
end

function sea.Player:getProcessAttribute()
	return player(self.id, "process")
end

function sea.Player:getSprayNameAttribute()
	return player(self.id, "sprayname")
end

function sea.Player:getSprayColorAttribute()
	return player(self.id, "spraycolor")
end

function sea.Player:getVoteKickAttribute()
	return player(self.id, "votekick")
end

function sea.Player:getVoteMapAttribute()
	return player(self.id, "votemap")
end

function sea.Player:getFavteamAttribute()
	return player(self.id, "favteam")
end

function sea.Player:getSpectatingAttribute()
	return player(self.id, "spectating")
end

function sea.Player:getSpeedAttribute()
	return player(self.id, "speedmod")
end

function sea.Player:getMaxhealthAttribute()
	return player(self.id, "maxhealth")
end

function sea.Player:getRconAttribute()
	return player(self.id, "rcon")
end

function sea.Player:getAi_flashAttribute()
	return player(self.id, "ai_flash")
end

function sea.Player:getScreenWidthAttribute()
	return player(self.id, "screenw")
end

function sea.Player:getScreenHeightAttribute()
	return player(self.id, "screenh")
end

function sea.Player:getMouseXAttribute()
	return player(self.id, "mousex")
end

function sea.Player:getMouseYAttribute()
	return player(self.id, "mousey")
end

function sea.Player:getMouseMapXAttribute()
	return player(self.id, "mousemapx")
end

function sea.Player:getMouseMapYAttribute()
	return player(self.id, "mousemapy")
end

-------------------------
--       SETTERS       --
-------------------------

function sea.Player:setNameAttribute(value)
	parse("setname", self.id, value, 1)
end

function sea.Player:setName2Attribute(value) -- server message while changing
	parse("setname", self.id, value, 0)
end

function sea.Player:setTeamAttribute(value)
	if value == 1 then
		parse("maket", self.id)
	elseif value == 2 then
		parse("makect", self.id)
	else
		parse("makespec", self.id)
	end
end

function sea.Player:setXAttribute(value)
	parse("setpos", self.id, value, self.y)
end

function sea.Player:setYAttribute(value)
	parse("setpos", self.id, self.x, value)
end

function sea.Player:setTileXAttribute(value)
	parse("setpos", self.id, tileToPixel(value), self.y)
end

function sea.Player:setTileYAttribute(value)
	parse("setpos", self.id, self.x, tileToPixel(value))
end

function sea.Player:setHealthAttribute(value)
	parse("sethealth", self.id, value)
end

function sea.Player:setArmorAttribute(value)
	parse("setarmor", self.id, value)
end

function sea.Player:setMoneyAttribute(value)
	parse("setmoney", self.id, value)
end

function sea.Player:setScoreAttribute(value)
	parse("setscore", self.id, value)
end

function sea.Player:setDeathsAttribute(value)
	parse("setdeaths", self.id, value)
end

function sea.Player:setWeaponAttribute(value)
	parse("setweapon", self.id, value)
end

function sea.Player:setSpeedAttribute(value)
	parse("speedmod", self.id, value)
end

function sea.Player:setMaxhealthAttribute(value)
	parse("setmaxhealth", self.id, value)
end