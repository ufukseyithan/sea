sea.player = {}
sea.Player = class()

function sea.Player:constructor(id)
    self.id = id

	for name, v in pairs(sea.config.player.variable) do
		if not self[name] then
			self[name] = v[1]
		end
	end

	self.stat = {}
	for name, v in pairs(sea.config.player.stat) do
		self.stat[name] = v[1]
	end

	self.option = {}
	for name, v in pairs(sea.config.player.option) do
		if not self.option[name] then
			self.option[name] = v[1]
		end
	end

	self.control = {}
	for name, v in pairs(sea.config.player.control) do
		if not self.control[name] then
			self.control[name] = v[1]
		end
	end
end

function sea.Player:destroy()
	sea.Player.remove(self.id)
end

function sea.Player:loadData()
	if self.steamID ~= "0" then
		local data = table.load(sea.path.data..self.steamID..".lua")

		if data then
			table.merge(self, data, true)

			self:notification(sea.createText("Your data has been loaded."))
		end
	end
end

function sea.Player:saveData()
	if self.steamID ~= "0" then
		local data = {}

		local function mergeData(k)
			data[k] = {}
			table.merge(data[k], self[k])
		end

		mergeData("stat")
		mergeData("option")
		mergeData("control")

		for k, v in pairs(sea.config.player.variable) do
			if v[2] then
				data[k] = self[k]
			end
		end

		table.save(data, sea.path.data..self.steamID..".lua")

		self:notification(sea.createText("Your data has been saved."))
	end
end

--[[
	@TODO: 
	This gotta be updated once an update for addbind is released, see: http://www.unrealsoftware.de/forum_posts.php?post=327522&start=3100#post426954
	Until then this needs a workaround
]]
function sea.Player:reassignControl(name, key)
	if not addbind(key) then
		return false
	end

	self.control[name] = key
	
	return true
end

function sea.Player:getInfo(name, ...)
	return sea.config.player.info[name](self, ...)
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
	parse("bansteam", self.steamID, duration, reason)
end

function sea.Player:banUSGN(duration, reason)
	parse("banusgn", self.usgn, duration, reason)
end

function sea.Player:kill()
	parse("killplayer", self.id)
end

function sea.Player:killBy(killer, itemID)
	parse("customkill", killer, itemID, self.id)
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

function sea.Player:equip(itemID)
	parse("equip", self.id, itemID)
end

function sea.Player:equipAndSet(itemID)
	self:equip(itemID)
	self.weapon = itemID
end

function sea.Player:reroute(address)
	parse("reroute", self.id, address)
end

function sea.Player:shake(power)
	parse("shake", self.id, power)
end

function sea.Player:strip(itemID)
	parse("strip", self.id, itemID)
end

function sea.Player:stripKnife()
	self:strip(50)
end

function sea.Player:message(text)
	sea.message(self.id, text)
end

function sea.Player:notification(text)
	sea.message(self.id, text)

	table.insert(self.notifications, text)
end

function sea.Player:help(text)
	sea.message(self.id, text)

	table.insert(self.help, text)
end

function sea.Player:consoleMessage(text)
	sea.consoleMessage(self.id, text)
end

function sea.Player:getItems()
	local itemTypes = {}

	for _, id in pairs(playerweapons(self.id)) do
		table.insert(itemTypes, sea.itemType[id])
	end

	return itemTypes
end

--[[
	@param radius (number) Radius in tiles. 
]]
function sea.Player:getCloseItems(radius)
	return sea.Item.getCloseToPlayer(self, radius)
end

function sea.Player:hasItem(itemID)
	for _, id in pairs(playerweapons(self.id)) do
		if id == itemID then
			return true
		end
	end

	return false
end

function sea.Player:getAmmo(itemID)
	local ammoIn, ammo = playerammo(self.id, itemID)

	return {
		["in"] = ammoIn,
		spare = ammo
	}
end

-------------------------
--        CONST        --
-------------------------

function sea.Player.create(id)
	if sea.player[id] then
		sea.error("Attempted to create player that already exists (ID: "..id..")")
		return
	end

	local player = sea.Player.new(id)

	sea.player[id] = player

	sea.info("Created player (ID: "..id..")")

	return player
end

function sea.Player.remove(id)
	if sea.player[id] then
		sea.player[id] = nil

		sea.info("Removed player (ID: "..id..")")
	else
		sea.error("Attempted to remove non-existent player (ID: "..id..")")
	end
end

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

function sea.Player.getAtRadius(x, y, radius, team)
	local players = {}
	
	for _, id in pairs(closeplayers(x, y, radius, team)) do
		table.insert(players, sea.player[id])
	end
	
    return players
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
	return math.round(player(self.id, "x"), 2)
end

function sea.Player:getYAttribute()
	return math.round(player(self.id, "y"), 2)
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