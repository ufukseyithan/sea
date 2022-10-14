sea.player = {}
local Player = class()

function Player:constructor(id)
	self.id = id

	self.notifications = {}
	self.hints = {}
	self.currentMenu = {}
	self.ui = sea.UI.new(self)

	for name, v in pairs(sea.config.player.variable) do
		if not self[name] then
			self[name] = v[1]
		end
	end

	self.stat = {}
	for name, v in pairs(sea.config.player.stat) do
		self.stat[name] = v[1]
	end

	self.preference = {}
	for name, v in pairs(sea.config.player.preference) do
		if not self.preference[name] then
			self.preference[name] = v[1]
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

			self:notify("Your data has been loaded.", "Data")
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
		mergeData("preference")
		mergeData("control")

		for k, v in pairs(sea.config.player.variable) do
			if v[2] then
				data[k] = self[k]
			end
		end

		table.save(data, sea.path.data..self.steamID..".lua")

		self:notify("Your data has been saved.", "Data")
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

function Player:message(text, color, tag, tagColor)
	return sea.message(self.id, text, color, tag, tagColor)
end

function Player:notify(text, tag)
	table.insert(self.notifications, self:message(text, sea.Color.white, tag))
end

function Player:hint(text)
	table.insert(self.hints, self:message(text, sea.Color.white, "Hint"))
end

function Player:alert(text, color, tag, tagColor)
	self:message(text.."@C", color, tag, tagColor)
end

function Player:crucialAlert(text)
	self:alert(text, sea.getColor("error", "system"))
end

function Player:consoleMessage(text, color, tag, tagColor)
	sea.consoleMessage(self.id, text, color, tag, tagColor)
end

function Player:displayMenu(menu, page)
	page = page or 1

	menu:show(self, page)

	self.currentMenu = {menu, page}
end

function Player:viewsMenu()
	return self.currentMenu[1] and true or false
end

function Player:isEnemyTo(player)
	if self.team == 0 or player.team == 0 then -- Checks if either one of the players is a spectator
		return false
	end

	return sea.game.mode == 1 and true or (self.team ~= player.team)
end

function Player:isVIP()
	return player(self.id, "team") == 3 and true or false
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
	local loaded, spare = playerammo(self.id, itemID)

	return not loaded and false or {loaded, spare}
end

function Player:getCurrentAmmo()
	return self:getAmmo(self.weapon)
end

function Player:setName(name, hide)
	parse("setname", self.id, name, hide and 1)
end

function Player:setAmmo(itemID, loaded, spare)
	parse("setammo", self.id, itemID, loaded, spare)
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

function Player:stripAll()
	self:strip(0)
end

-------------------------
--        CONST        --
-------------------------

function Player.create(id, object)
	if sea.player[id] then
		sea.error("Attempted to create player that already exists (ID: "..id..")")
		return false
	end

	sea.player[id] = object or Player.new(id)

	sea.success("Created player (ID: "..id..")")

	return sea.player[id]
end

function Player.remove(id)
	if not sea.player[id] then
		sea.error("Attempted to remove non-existent player (ID: "..id..")")
		return false
	end 

	sea.player[id] = nil

	sea.success("Removed player (ID: "..id..")")

	return true
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

function Player.messageAll(text, color, tag, tagColor)
	return sea.message(0, text, color, tag, tagColor)
end

function Player.alertAll(text, color, tag, tagColor)
	Player.messageAll(text.."@C", color, tag, tagColor)
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
	if sea.game.mode == 1 then
		return 3
	end

	local team = player(self.id, "team")

	team = team == 3 and 2 or team

	return team
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

function Player:getTileAttribute()
	return sea.tile[self.tileX][self.tileY]
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

function Player:getItemAttribute()
	return sea.itemType[self.weapon]
end

function Player:getNightvisionAttribute()
	return player(self.id, "nightvision")
end

function Player:getDefuseKitAttribute()
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

function Player:getMaxHealthAttribute()
	return player(self.id, "maxhealth")
end

function Player:getRConAttribute()
	return player(self.id, "rcon")
end

function Player:getAiFlashAttribute()
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
	self:setPosition(value, self.y)
end

function Player:setYAttribute(value)
	self:setPosition(self.x, value)
end

function Player:setTileXAttribute(value)
	self:setPosition(tileToPixel(value), self.y)
end

function Player:setTileYAttribute(value)
	self:setPosition(self.x, tileToPixel(value))
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

function Player:setMaxHealthAttribute(value)
	parse("setmaxhealth", self.id, value)
end

-------------------------
--        INIT         --
-------------------------

return Player