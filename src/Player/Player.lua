local Player = class()

-- @TODO: Player get & set info

-- @TODO: Player get & set stat

-- @TODO: Player get & set setting

-- @TODO: Player get & set variable

-- @TODO: Player ammo

-- @TODO: Player weapons

function Player:constructor(id)
    self.id = id
end

function Player:kick(reason)
	parse("kick", self.id, reason)
end

function Player:banIP(duration, reason)
	parse("banip", self.ip, duration, reason)
end

function Player:banName(duration, reason)
	parse("banname", self.name, duration, reason)
end

function Player:banSteam(duration, reason)
	parse("bansteam", self.steamid, duration, reason)
end

function Player:banUSGN(duration, reason)
	parse("banusgn", self.usgn, duration, reason)
end

function Player:kill()
	parse("killplayer", self.id)
end

function Player:killBy(killer, weapon)
	parse("customkill", killer, weapon, self.id)
end

function Player:slap()
	parse("slap", self.id)
end

function Player:setPosition(x, y)
	parse("setpos", self.id, x, y)
end

function Player:spawn(x, y)
	parse("spawnplayer", self.id, x, y)
end

function Player:equip(itemID)
	parse("equip", self.id, itemID)
end

-- @TODO: equip and set weapon function

function Player:reroute(address)
	parse("reroute", self.id, address)
end

function Player:shake(power)
	parse("shake", self.id, power)
end

function Player:strip(weapon)
	parse("strip", self.id, weapon)
end

-------------------------
--        CONST        --
-------------------------

--[[
@TODO: Take these to somewhere else?

local function getPlayers(mode)
    local players = {}
    for _, id in pairs(player(0, mode)) do
        table.insert(players, id)
    end
    return players
end

function Player.get()
    return getPlayers("table")
end

function Player.getLiving()
    return getPlayers("tableliving")
end

function Player.getTerrorists()
    return getPlayers("team1")
end

function Player.getCounterTerrorists()
    return getPlayers("team2")
end

function Player.getLivingTerrorists()
    return getPlayers("team1living")
end

function Player.getLivingCounterTerrorists()
    return getPlayers("team2living")
end]]

-------------------------
--       GETTERS       --
-------------------------

function Player:getExistsAttribute()
	return player(self.id, "exists")
end

function Player:getNameAttribute()
	return player(self.id, "name")
end

function Player:getIpAttribute()
	return player(self.id, "ip")
end

function Player:getPortAttribute()
	return player(self.id, "port")
end

function Player:getUsgnAttribute()
	return player(self.id, "usgn")
end

function Player:getUsgnnameAttribute()
	return player(self.id, "Usgnname")
end

function Player:getSteamidAttribute()
	return player(self.id, "steamid")
end

function Player:getSteamnameAttribute()
	return player(self.id, "steamname")
end

function Player:getPingAttribute()
	return player(self.id, "ping")
end

function Player:getIdleAttribute()
	return player(self.id, "idle")
end

function Player:getBotAttribute()
	return player(self.id, "bot")
end

function Player:getTeamAttribute()
	return player(self.id, "team")
end

function Player:getLookAttribute()
	return player(self.id, "look")
end

function Player:getXAttribute()
	return player(self.id, "x")
end

function Player:getYAttribute()
	return player(self.id, "y")
end

function Player:getRotAttribute()
	return player(self.id, "rot")
end

function Player:getTilexAttribute()
	return player(self.id, "tilex")
end

function Player:getTileyAttribute()
	return player(self.id, "tiley")
end

function Player:getHealthAttribute()
	return player(self.id, "health")
end

function Player:getArmorAttribute()
	return player(self.id, "armor")
end

function Player:getMoneyAttribute()
	return player(self.id, "money")
end

function Player:getScoreAttribute()
	return player(self.id, "score")
end

function Player:getDeathsAttribute()
	return player(self.id, "deaths")
end

function Player:getTeamkillsAttribute()
	return player(self.id, "teamkills")
end

function Player:getHostagekillsAttribute()
	return player(self.id, "hostagekills")
end

function Player:getTeambuildingkillsAttribute()
	return player(self.id, "teambuildingkills")
end

function Player:getWeaponAttribute()
	return player(self.id, "weapontype")
end

function Player:getNightvisionAttribute()
	return player(self.id, "nightvision")
end

function Player:getDefusekitAttribute()
	return player(self.id, "defusekit")
end

function Player:getGasmaskAttribute()
	return player(self.id, "gasmask")
end

function Player:getBombAttribute()
	return player(self.id, "bomb")
end

function Player:getFlagAttribute()
	return player(self.id, "flag")
end

function Player:getReloadingAttribute()
	return player(self.id, "reloading")
end

function Player:getProcessAttribute()
	return player(self.id, "process")
end

function Player:getSpraynameAttribute()
	return player(self.id, "sprayname")
end

function Player:getSpraycolorAttribute()
	return player(self.id, "spraycolor")
end

function Player:getVotekickAttribute()
	return player(self.id, "votekick")
end

function Player:getVotemapAttribute()
	return player(self.id, "votemap")
end

function Player:getFavteamAttribute()
	return player(self.id, "favteam")
end

function Player:getSpectatingAttribute()
	return player(self.id, "spectating")
end

function Player:getSpeedmodAttribute()
	return player(self.id, "speedmod")
end

function Player:getMaxhealthAttribute()
	return player(self.id, "maxhealth")
end

function Player:getRconAttribute()
	return player(self.id, "rcon")
end

function Player:getAi_flashAttribute()
	return player(self.id, "ai_flash")
end

function Player:getScreenwAttribute()
	return player(self.id, "screenw")
end

function Player:getScreenhAttribute()
	return player(self.id, "screenh")
end

function Player:getMousexAttribute()
	return player(self.id, "mousex")
end

function Player:getMouseyAttribute()
	return player(self.id, "mousey")
end

function Player:getMousemapxAttribute()
	return player(self.id, "mousemapx")
end

function Player:getMousemapyAttribute()
	return player(self.id, "mousemapy")
end

-------------------------
--       SETTERS       --
-------------------------

function Player:setNameAttribute(value)
	setname(self.id, value, 1)
end

function Player:setName2Attribute(value) -- server message while changing
	setname(self.id, value, 0)
end

function Player:setTeamAttribute(value)
	if value == 1 then
		maket(self.id)
	elseif value == 2 then
		makect(self.id)
	else
		makespec(self.id)
	end
end

function Player:setXAttribute(value)
	setpos(self.id, value, self.y)
end

function Player:setYAttribute(value)
	setpos(self.id, self.x, value)
end

function Player:setTilexAttribute(value)
	setpos(self.id, tileToPixel(value), self.y)
end

function Player:setTileyAttribute(value)
	setpos(self.id, self.x, tileToPixel(value))
end

function Player:setHealthAttribute(value)
	sethealth(self.id, value)
end

function Player:setArmorAttribute(value)
	setarmor(self.id, value)
end

function Player:setMoneyAttribute(value)
	setmoney(self.id, value)
end

function Player:setScoreAttribute(value)
	setscore(self.id, value)
end

function Player:setDeathsAttribute(value)
	setdeaths(self.id, value)
end

function Player:setWeaponAttribute(value)
	setweapon(self.id, value)
end

function Player:setSpeedmodAttribute(value)
	speedmod(self.id, value)
end

function Player:setMaxhealthAttribute(value)
	setmaxhealth(self.id, value)
end

return Player