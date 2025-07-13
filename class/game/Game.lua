local Game = class()

function Game:load()
    for k, v in pairs(sea.config.game.data) do
        self[k] = v
    end

    local data = table.load(self.savePath)
    
    if data then
        table.merge(self, data)

        sea.success("Game data has been loaded.")    
    end

    sea.emit("gameLoaded")
end

function Game:save()
    sea.emit('gameSaved')

    local data = {}

    for k, v in pairs(sea.config.game.data) do
        data[k] = self[k]
    end

    if not table.isEmpty(data) then
        table.save(data, self.savePath)

        sea.success("Game data has been saved.")
    end
end

-------------------------
--        CONST        --
-------------------------

Game.savePath = sea.path.data.."game.lua"

-------------------------
--       GETTERS       --
-------------------------

function Game:getCheckUSGNLoginAttribute()
    return game("sv_checkusgnlogin")
end

function Game:getDaylightTimeAttribute()
    return game("sv_daylighttime")
end

function Game:getForceLightAttribute()
    return game("sv_forcelight")
end

function Game:getFowAttribute()
    return game("sv_fow")
end

function Game:getFriendlyFireAttribute()
    return game("sv_friendlyfire")
end

function Game:getModeAttribute()
    return game("sv_gamemode")
end

function Game:getHostPortAttribute()
    return game("sv_hostport")
end

function Game:getLanAttribute()
    return game("sv_lan")
end

function Game:getMapAttribute()
    return game("sv_map")
end

function Game:getMapTransferAttribute()
    return game("sv_maptransfer")
end

function Game:getMaxPlayersAttribute()
    return game("sv_maxplayers")
end

function Game:getNameAttribute()
    return game("sv_name")
end

function Game:getOffScreenDamageAttribute()
    return game("sv_offscreendamage")
end

function Game:getPasswordAttribute()
    return game("sv_password")
end

function Game:getRconAttribute()
    return game("sv_rcon")
end

function Game:getRconUsersAttribute()
    return game("sv_rconusers")
end

function Game:getSpectatingModeAttribute()
    return game("sv_specmode")
end

function Game:getSprayTransferAttribute()
    return game("sv_spraytransfer")
end

function Game:getUsgnOnlyAttribute()
    return game("sv_usgnonly")
end

function Game:getAntispeederAttribute()
    return game("mp_antispeeder")
end

function Game:getAutoModeAttribute()
    return game("mp_autogamemode")
end

function Game:getAutoTeamBalanceAttribute()
    return game("mp_autoteambalance")
end

function Game:getBuyMenuAttribute()
    return game("mp_buymenu")
end

function Game:getBuyTimeAttribute()
    return game("mp_buytime")
end

function Game:getC4TimerAttribute()
    return game("mp_c4timer")
end

function Game:getConnectionLimitAttribute()
    return game("mp_connectionlimit")
end

function Game:getCurtailedExplosionsAttribute()
    return game("mp_curtailedexplosions")
end

function Game:getDamageFactorAttribute()
    return game("mp_damagefactor")
end

function Game:getDeathDropAttribute()
    return game("mp_deathdrop")
end

function Game:getDeatmatchSpawnMoneyAttribute()
    return game("mp_dmspawnmoney")
end

function Game:getDropGrenadesAttribute()
    return game("mp_dropgrenades")
end

function Game:getFlashlightAttribute()
    return game("mp_flashlight")
end

function Game:getFloodProtAttribute()
    return game("mp_floodprot")
end

function Game:getFloodProtIgnoreTimeAttribute()
    return game("mp_floodprotignoretime")
end

function Game:getFreezeTimeAttribute()
	return game("mp_freezetime")
end

function Game:getGrenadeRebuyAttribute()
	return game("mp_grenaderebuy")
end

function Game:getHostagePenaltyAttribute()
	 return game("mp_hostagepenalty")
end

function Game:getHoverTextAttribute()
	 return game("mp_hovertext")
end

function Game:getHudAttribute()
	return game("mp_hud")
end

function Game:getHudScaleAttribute()
	return game("mp_hudscale")
end

function Game:getIdleActionAttribute()
	return game("mp_idleaction")
end

function Game:getIdleKickAttribute()
	return game("mp_idlekick")
end

function Game:getIdleTimeAttribute()
	return game("mp_idletime")
end

function Game:getInfiniteAmmoAttribute()
	return game("mp_infammo")
end

function Game:getKevlarAttribute()
	return game("mp_kevlar")
end

function Game:getKickPerCentAttribute()
	return game("mp_kickpercent")
end

function Game:getKillBuildingMoneyAttribute()
	return game("mp_killbuildingmoney")
end

function Game:getKillBuildingsAttribute()
	return game("mp_killbuildings")
end

function Game:getKillInfoAttribute()
	return game("mp_killinfo")
end

function Game:getKillTeamBuildingsAttribute()
	return game("mp_killteambuildings")
end

function Game:getLagCompensationAttribute()
	return game("mp_lagcompensation")
end

function Game:getLagCompensationDivisorAttribute()
	return game("mp_lagcompensationdivisor")
end

function Game:getLocalRConOutputAttribute()
	return game("mp_localrconoutput")
end

function Game:getLuaMapAttribute()
	return game("mp_luamap")
end

function Game:getLuaServerAttribute()
	return game("mp_luaserver")
end

function Game:getMapGoalScoreAttribute()
	return game("mp_mapgoalscore")
end

function Game:getMapVoteRatioAttribute()
	return game("mp_mapvoteratio")
end

function Game:getMaxClientsIPAttribute()
	return game("mp_maxclientsip")
end

function Game:getMaxRConFailsAttribute()
	return game("mp_maxrconfails")
end

function Game:getNatHolePunchingAttribute()
	return game("mp_natholepunching")
end

function Game:getPingLimitAttribute()
	return game("mp_pinglimit")
end

function Game:getPostSpawnAttribute()
	return game("mp_postspawn")
end

function Game:getRadarAttribute()
	return game("mp_radar")
end

function Game:getRandomSpawnAttribute()
	return game("mp_randomspawn")
end

function Game:getRecoilAttribute()
	return game("mp_recoil")
end

function Game:getReservationsAttribute()
	return game("mp_reservations")
end

function Game:getRespawnDelayAttribute()
	return game("mp_respawndelay")
end

function Game:getRoundLimitAttribute()
	return game("mp_roundlimit")
end

function Game:getRoundTimeAttribute()
	return game("mp_roundtime")
end

function Game:getShotWeakeningAttribute()
	return game("mp_shotweakening")
end

function Game:getSmokeBlockAttribute()
	return game("mp_smokeblock")
end

function Game:getStartMoneyAttribute()
	return game("mp_startmoney")
end

function Game:getSupplyItemsAttribute()
	return game("mp_supply_items")
end

function Game:getTeamkillPenaltyAttribute()
	return game("mp_teamkillpenalty")
end

function Game:getTeleportReloadAttribute()
	return game("mp_teleportreload")
end

function Game:getTempBanTimeAttribute()
	return game("mp_tempbantime")
end

function Game:getTimeLimitAttribute()
	return game("mp_timelimit")
end

function Game:getTkPunishAttribute()
	return game("mp_tkpunish")
end

function Game:getTraceAttribute()
	return game("mp_trace")
end

function Game:getTurretDamageAttribute()
	return game("mp_turretdamage")
end

function Game:getUnbuildableAttribute()
	return game("mp_unbuildable")
end

function Game:getUnbuyableAttribute()
	return game("mp_unbuyable")
end

function Game:getVulnerableHostagesAttribute()
	return game("mp_vulnerablehostages")
end

function Game:getWinLimitAttribute()
	return game("mp_winlimit")
end

function Game:getZombieDamageAttribute()
	return game("mp_zombiedmg")
end

function Game:getZombieKillEquipAttribute()
	return game("mp_zombiekillequip")
end

function Game:getZombieKillScoreAttribute()
	return game("mp_zombiekillscore")
end

function Game:getZombieRecoverAttribute()
	return game("mp_zombierecover")
end

function Game:getZombieSpeedAttribute()
	return game("mp_zombiespeedmod")
end

function Game:getVersionAttribute()
	return game("version")
end

function Game:getDedicatedAttribute()
	return game("dedicated")
end

function Game:getPhaseAttribute()
	return game("phase")
end

function Game:getRoundAttribute()
	return game("round")
end

function Game:getTScoreAttribute()
	return game("score_t")
end

function Game:getCtScoreAttribute()
	return game("score_ct")
end

function Game:getTWinRowAttribute()
	return game("winrow_t")
end

function Game:getCtWinRowAttribute()
	return game("winrow_ct")
end

function Game:getNextMapAttribute()
	return game("nextmap")
end

function Game:getPortAttribute()
	return game("port")
end

function Game:getBombPlantedAttribute()
	return game("bombplanted")
end

function Game:getSysFolderAttribute()
	return game("sysfolder")
end

-------------------------
--       SETTERS       --
-------------------------

function Game:setCheckUSGNLoginAttribute(value)
    parse("sv_checkusgnlogin", value)
end

function Game:setDaylightTimeAttribute(value)
    parse("sv_daylighttime", value)
end

function Game:setForceLightAttribute(value)
    parse("sv_forcelight", value)
end

function Game:setFowAttribute(value)
    parse("sv_fow", value)
end

function Game:setFriendlyFireAttribute(value)
    parse("sv_friendlyfire", value)
end

function Game:setModeAttribute(value)
    parse("sv_gm", value)
end

function Game:setHostPortAttribute(value)
    parse("sv_hostport", value)
end

function Game:setLanAttribute(value)
    parse("sv_lan", value)
end

function Game:setMapAttribute(value)
    parse("sv_map", value)
end

function Game:setMapTransferAttribute(value)
    parse("sv_maptransfer", value)
end

function Game:setMaxPlayersAttribute(value)
    parse("sv_maxplayers", value)
end

function Game:setNameAttribute(value)
    parse("sv_name", value)
end

function Game:setOffScreenDamageAttribute(value)
    parse("sv_offscreendamage", value)
end

function Game:setPasswordAttribute(value)
    parse("sv_password", value)
end

function Game:setRconAttribute(value)
    parse("sv_rcon", value)
end

function Game:setRconUsersAttribute(value)
    parse("sv_rconusers", value)
end

function Game:setSpecModeAttribute(value)
    parse("sv_specmode", value)
end

function Game:setSprayTransferAttribute(value)
    parse("sv_spraytransfer", value)
end

function Game:setUsgnOnlyAttribute(value)
    parse("sv_usgnonly", value)
end

function Game:setAntispeederAttribute(value)
    parse("mp_antispeeder", value)
end

function Game:setAutoModeAttribute(value)
    parse("mp_autogamemode", value)
end

function Game:setAutoTeamBalanceAttribute(value)
    parse("mp_autoteambalance", value)
end

function Game:setBuyMenuAttribute(value)
    parse("mp_buymenu", value)
end

function Game:setBuyTimeAttribute(value)
    parse("mp_buytime", value)
end

function Game:setC4TimerAttribute(value)
    parse("mp_c4timer", value)
end

function Game:setConnectionLimitAttribute(value)
    parse("mp_connectionlimit", value)
end

function Game:setCurtailedExplosionsAttribute(value)
    parse("mp_curtailedexplosions", value)
end

function Game:setDamageFactorAttribute(value)
    parse("mp_damagefactor", value)
end

function Game:setDeathDropAttribute(value)
    parse("mp_deathdrop", value)
end

function Game:setDeatmatchSpawnMoneyAttribute(value)
    parse("mp_dmspawnmoney", value)
end

function Game:setDropGrenadesAttribute(value)
    parse("mp_dropgrenades", value)
end

function Game:setFlashlightAttribute(value)
    parse("mp_flashlight", value)
end

function Game:setFloodProtAttribute(value)
    parse("mp_floodprot", value)
end

function Game:setFloodProtIgnoreTimeAttribute(value)
    parse("mp_floodprotignoretime", value)
end

function Game:setFreezeTimeAttribute(value)
    parse("mp_freezetime", value)
end

function Game:setGrenadeRebuyAttribute(value)
    parse("mp_grenaderebuy", value)
end

function Game:setHostagePenaltyAttribute(value)
    parse("mp_hostagepenalty", value)
end

function Game:setHoverTextAttribute(value)
    parse("mp_hovertext", value)
end

function Game:setHudAttribute(value)
    parse("mp_hud", value)
end

function Game:setHudScaleAttribute(value)
    parse("mp_hudscale", value)
end

function Game:setIdleActionAttribute(value)
    parse("mp_idleaction", value)
end

function Game:setIdleKickAttribute(value)
    parse("mp_idlekick", value)
end

function Game:setIdleTimeAttribute(value)
    parse("mp_idletime", value)
end

function Game:setInfiniteAmmoAttribute(value)
    parse("mp_infammo", value)
end

function Game:setKevlarAttribute(value)
    parse("mp_kevlar", value)
end

function Game:setKickPerCentAttribute(value)
    parse("mp_kickpercent", value)
end

function Game:setKillBuildingMoneyAttribute(value)
    parse("mp_killbuildingmoney", value)
end

function Game:setKillBuildingsAttribute(value)
    parse("mp_killbuildings", value)
end

function Game:setKillInfoAttribute(value)
    parse("mp_killinfo", value)
end

function Game:setKillTeamBuildingsAttribute(value)
    parse("mp_killteambuildings", value)
end

function Game:setLagCompensationAttribute(value)
    parse("mp_lagcompensation", value)
end

function Game:setLagCompensationDivisorAttribute(value)
    parse("mp_lagcompensationdivisor", value)
end

function Game:setLocalRConOutputAttribute(value)
    parse("mp_localrconoutput", value)
end

function Game:setLuaMapAttribute(value)
    parse("mp_luamap", value)
end

function Game:setLuaServerAttribute(value)
    parse("mp_luaserver", value)
end

function Game:setMapGoalScoreAttribute(value)
    parse("mp_mapgoalscore", value)
end

function Game:setMapVoteRatioAttribute(value)
    parse("mp_mapvoteratio", value)
end

function Game:setMaxClientsIPAttribute(value)
    parse("mp_maxclientsip", value)
end

function Game:setMaxRConFailsAttribute(value)
    parse("mp_maxrconfails", value)
end

function Game:setNatHolePunchingAttribute(value)
    parse("mp_natholepunching", value)
end

function Game:setPingLimitAttribute(value)
    parse("mp_pinglimit", value)
end

function Game:setPostSpawnAttribute(value)
    parse("mp_postspawn", value)
end

function Game:setRadarAttribute(value)
    parse("mp_radar", value)
end

function Game:setRandomSpawnAttribute(value)
    parse("mp_randomspawn", value)
end

function Game:setRecoilAttribute(value)
    parse("mp_recoil", value)
end

function Game:setReservationsAttribute(value)
    parse("mp_reservations", value)
end

function Game:setRespawnDelayAttribute(value)
    parse("mp_respawndelay", value)
end

function Game:setRoundLimitAttribute(value)
    parse("mp_roundlimit", value)
end

function Game:setRoundTimeAttribute(value)
    parse("mp_roundtime", value)
end

function Game:setShotWeakeningAttribute(value)
    parse("mp_shotweakening", value)
end

function Game:setSmokeBlockAttribute(value)
    parse("mp_smokeblock", value)
end

function Game:setStartMoneyAttribute(value)
    parse("mp_startmoney", value)
end

function Game:setSupplyItemsAttribute(value)
    parse("mp_supply_items", value)
end

function Game:setTeamkillPenaltyAttribute(value)
    parse("mp_teamkillpenalty", value)
end

function Game:setTeleportReloadAttribute(value)
    parse("mp_teleportreload", value)
end

function Game:setTempBanTimeAttribute(value)
    parse("mp_tempbantime", value)
end

function Game:setTimeLimitAttribute(value)
    parse("mp_timelimit", value)
end

function Game:setTkPunishAttribute(value)
    parse("mp_tkpunish", value)
end

function Game:setTraceAttribute(value)
    parse("mp_trace", value)
end

function Game:setTurretDamageAttribute(value)
    parse("mp_turretdamage", value)
end

function Game:setUnbuildableAttribute(value)
    parse("mp_unbuildable", value)
end

function Game:setUnbuyableAttribute(value)
    parse("mp_unbuyable", value)
end

function Game:setVulnerableHostagesAttribute(value)
    parse("mp_vulnerablehostages", value)
end

function Game:setWinLimitAttribute(value)
    parse("mp_winlimit", value)
end

function Game:setZombieDamageAttribute(value)
    parse("mp_zombiedmg", value)
end

function Game:setZombieKillEquipAttribute(value)
    parse("mp_zombiekillequip", value)
end

function Game:setZombieKillScoreAttribute(value)
    parse("mp_zombiekillscore", value)
end

function Game:setZombieRecoverAttribute(value)
    parse("mp_zombierecover", value)
end

function Game:setZombieSpeedAttribute(value)
    parse("mp_zombiespeedmod", value)
end

-------------------------
--        INIT         --
-------------------------

return Game