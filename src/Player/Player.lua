sea.player = {}
local Player = class()

function Player:constructor(id)
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

function Player:destroy()
	Player.remove(self.id)
end

function Player:loadData()
	if self.steamID ~= "0" then
		local data = table.load(sea.path.data..self.steamID..".lua")

		if data then
			table.merge(self, data, true)

			self:notification(sea.createText("Your data has been loaded."))
		end
	end
end

function Player:saveData()
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
function Player:reassignControl(name, key)
	if not addbind(key) then
		return false
	end

	self.control[name] = key
	
	return true
end

function Player:getInfo(name, ...)
	return sea.config.player.info[name](self, ...)
end

function Player:displayMenu(menu, page)
	menu:show(self, page)

	self.menu = menu
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
	parse("bansteam", self.steamID, duration, reason)
end

function Player:banUSGN(duration, reason)
	parse("banusgn", self.usgn, duration, reason)
end

function Player:kill()
	parse("killplayer", self.id)
end

function Player:killBy(killer, itemID)
	parse("customkill", killer, itemID, self.id)
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

function Player:equipAndSet(itemID)
	self:equip(itemID)
	self.weapon = itemID
end

function Player:reroute(address)
	parse("reroute", self.id, address)
end

function Player:shake(power)
	parse("shake", self.id, power)
end

function Player:strip(itemID)
	parse("strip", self.id, itemID)
end

function Player:stripKnife()
	self:strip(50)
end

function Player:message(text)
	sea.message(self.id, text)
end

function Player:notification(text)
	sea.message(self.id, text)

	table.insert(self.notifications, text)
end

function Player:help(text)
	sea.message(self.id, text)

	table.insert(self.help, text)
end

function Player:consoleMessage(text)
	sea.consoleMessage(self.id, text)
end

function Player:getItems()
	local itemTypes = {}

	for _, id in pairs(playerweapons(self.id)) do
		table.insert(itemTypes, sea.itemType[id])
	end

	return itemTypes
end

--[[
	@param radius (number) Radius in tiles. 
]]
function Player:getCloseItems(radius)
	return sea.Item.getCloseToPlayer(self, radius)
end

function Player:hasItem(itemID)
	for _, id in pairs(playerweapons(self.id)) do
		if id == itemID then
			return true
		end
	end

	return false
end

function Player:getAmmo(itemID)
	local ammoIn, ammo = playerammo(self.id, itemID)

	return {
		["in"] = ammoIn,
		spare = ammo
	}
end

-------------------------
--        CONST        --
-------------------------

function Player.create(id)
	if sea.player[id] then
		sea.error("Attempted to create player that already exists (ID: "..id..")")
		return
	end

	local player = Player.new(id)

	sea.player[id] = player

	sea.info("Created player (ID: "..id..")")

	return player
end

function Player.remove(id)
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

function Player.get(specific)
    return getPlayers("table", specific)
end

function Player.getLiving(specific)
    return getPlayers("tableliving", specific)
end

function Player.getTerrorists(specific)
    return getPlayers("team1", specific)
end

function Player.getCounterTerrorists(specific)
    return getPlayers("team2", specific)
end

function Player.getLivingTerrorists(specific)
    return getPlayers("team1living", specific)
end

function Player.getLivingCounterTerrorists(specific)
    return getPlayers("team2living", specific)
end

function Player.getAtRadius(x, y, radius, team)
	local players = {}
	
	for _, id in pairs(closeplayers(x, y, radius, team)) do
		table.insert(players, sea.player[id])
	end
	
    return players
end

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

function Player:getUsgnNameAttribute()
	return player(self.id, "usgnname")
end

function Player:getSteamIDAttribute()
	return player(self.id, "steamid")
end

function Player:getSteamNameAttribute()
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
	return math.round(player(self.id, "x"), 2)
end

function Player:getYAttribute()
	return math.round(player(self.id, "y"), 2)
end

function Player:getRotationAttribute()
	return player(self.id, "rot")
end

function Player:getTileXAttribute()
	return player(self.id, "tilex")
end

function Player:getTileYAttribute()
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

function Player:getTeamKillsAttribute()
	return player(self.id, "teamkills")
end

function Player:getHostageKillsAttribute()
	return player(self.id, "hostagekills")
end

function Player:getTeamBuildingKillsAttribute()
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

function Player:getSprayNameAttribute()
	return player(self.id, "sprayname")
end

function Player:getSprayColorAttribute()
	return player(self.id, "spraycolor")
end

function Player:getVoteKickAttribute()
	return player(self.id, "votekick")
end

function Player:getVoteMapAttribute()
	return player(self.id, "votemap")
end

function Player:getFavteamAttribute()
	return player(self.id, "favteam")
end

function Player:getSpectatingAttribute()
	return player(self.id, "spectating")
end

function Player:getSpeedAttribute()
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

function Player:getScreenWidthAttribute()
	return player(self.id, "screenw")
end

function Player:getScreenHeightAttribute()
	return player(self.id, "screenh")
end

function Player:getMouseXAttribute()
	return player(self.id, "mousex")
end

function Player:getMouseYAttribute()
	return player(self.id, "mousey")
end

function Player:getMouseMapXAttribute()
	return player(self.id, "mousemapx")
end

function Player:getMouseMapYAttribute()
	return player(self.id, "mousemapy")
end

-------------------------
--       SETTERS       --
-------------------------

function Player:setNameAttribute(value)
	parse("setname", self.id, value, 1)
end

function Player:setName2Attribute(value) -- server message while changing
	parse("setname", self.id, value, 0)
end

function Player:setTeamAttribute(value)
	if value == 1 then
		parse("maket", self.id)
	elseif value == 2 then
		parse("makect", self.id)
	else
		parse("makespec", self.id)
	end
end

function Player:setXAttribute(value)
	parse("setpos", self.id, value, self.y)
end

function Player:setYAttribute(value)
	parse("setpos", self.id, self.x, value)
end

function Player:setTileXAttribute(value)
	parse("setpos", self.id, tileToPixel(value), self.y)
end

function Player:setTileYAttribute(value)
	parse("setpos", self.id, self.x, tileToPixel(value))
end

function Player:setHealthAttribute(value)
	parse("sethealth", self.id, value)
end

function Player:setArmorAttribute(value)
	parse("setarmor", self.id, value)
end

function Player:setMoneyAttribute(value)
	parse("setmoney", self.id, value)
end

function Player:setScoreAttribute(value)
	parse("setscore", self.id, value)
end

function Player:setDeathsAttribute(value)
	parse("setdeaths", self.id, value)
end

function Player:setWeaponAttribute(value)
	parse("setweapon", self.id, value)
end

function Player:setSpeedAttribute(value)
	parse("speedmod", self.id, value)
end

function Player:setMaxhealthAttribute(value)
	parse("setmaxhealth", self.id, value)
end

return Player