sea.Game = class()

-------------------------
--       GETTERS       --
-------------------------

function sea.Game:getCheckUSGNLoginAttribute()
    return game("sv_checkusgnlogin")
end

function sea.Game:getDaylightTimeAttribute()
    return game("sv_daylighttime")
end

function sea.Game:getForceLightAttribute()
    return game("sv_forcelight")
end

function sea.Game:getFowAttribute()
    return game("sv_fow")
end

function sea.Game:getFriendlyFireAttribute()
    return game("sv_friendlyfire")
end

function sea.Game:getGameModeAttribute()
    return game("sv_gamemode")
end

function sea.Game:getHostPortAttribute()
    return game("sv_hostport")
end

function sea.Game:getLanAttribute()
    return game("sv_lan")
end

function sea.Game:getMapAttribute()
    return game("sv_map")
end

function sea.Game:getMapTransferAttribute()
    return game("sv_maptransfer")
end

function sea.Game:getMaxPlayersAttribute()
    return game("sv_maxplayers")
end

function sea.Game:getNameAttribute()
    return game("sv_name")
end

function sea.Game:getOffScreenDamageAttribute()
    return game("sv_offscreendamage")
end

function sea.Game:getPasswordAttribute()
    return game("sv_password")
end

function sea.Game:getRconAttribute()
    return game("sv_rcon")
end

function sea.Game:getRconUsersAttribute()
    return game("sv_rconusers")
end

function sea.Game:getSpecModeAttribute()
    return game("sv_specmode")
end

function sea.Game:getSprayTransferAttribute()
    return game("sv_spraytransfer")
end

function sea.Game:getUsgnOnlyAttribute()
    return game("sv_usgnonly")
end

function sea.Game:getAntispeederAttribute()
    return game("mp_antispeeder")
end

function sea.Game:getAutoGameModeAttribute()
    return game("mp_autogamemode")
end

function sea.Game:getAutoTeamBalanceAttribute()
    return game("mp_autogamemode")
end

function sea.Game:getBuyMenuAttribute()
    return game("mp_buymenu")
end

function sea.Game:getBuyTimeAttribute()
    return game("mp_buytime")
end

function sea.Game:getC4TimerAttribute()
    return game("mp_c4timer")
end

function sea.Game:getConnectionLimitAttribute()
    return game("mp_connectionlimit")
end

function sea.Game:getCurtailedExplosionsAttribute()
    return game("mp_curtailedexplosions")
end

function sea.Game:getDamageFactorAttribute()
    return game("mp_damagefactor")
end

function sea.Game:getDeathDropAttribute()
    return game("mp_deathdrop")
end

function sea.Game:getDeatmatchSpawnMoneyAttribute()
    return game("mp_dmspawnmoney")
end

function sea.Game:getDropGrenadesAttribute()
    return game("mp_dropgrenades")
end

function sea.Game:getFlashlightAttribute()
    return game("mp_flashlight")
end

function sea.Game:getFloodProtAttribute()
    return game("mp_floodprot")
end

function sea.Game:getFloodProtIgnoreTimeAttribute()
    return game("mp_floodprotignoretime")
end

function sea.Game:getFreezeTimeAttribute()
	return game("mp_freezetime")
end

function sea.Game:getGrenadeRebuyAttribute()
	return game("mp_grenaderebuy")
end

function sea.Game:getHostagePenaltyAttribute()
	 return game("mp_hostagepenalty")
end

function sea.Game:getHoverTextAttribute()
	 return game("mp_hovertext")
end

function sea.Game:getHudAttribute()
	return game("mp_hud")
end

function sea.Game:getHudScaleAttribute()
	return game("mp_hudscale")
end

function sea.Game:getIdleActionAttribute()
	return game("mp_idleaction")
end

function sea.Game:getIdleKickAttribute()
	return game("mp_idlekick")
end

function sea.Game:getIdleTimeAttribute()
	return game("mp_idletime")
end

function sea.Game:getInfiniteAmmoAttribute()
	return game("mp_infammo")
end

function sea.Game:getKevlarAttribute()
	return game("mp_kevlar")
end

function sea.Game:getKickPerCentAttribute()
	return game("mp_kickpercent")
end

function sea.Game:getKillBuildingMoneyAttribute()
	return game("mp_killbuildingmoney")
end

function sea.Game:getKillBuildingsAttribute()
	return game("mp_killbuildings")
end

function sea.Game:getKillInfoAttribute()
	return game("mp_killinfo")
end

function sea.Game:getKillTeamBuildingsAttribute()
	return game("mp_killteambuildings")
end

function sea.Game:getLagCompensationAttribute()
	return game("mp_lagcompensation")
end

function sea.Game:getLagCompensationDivisorAttribute()
	return game("mp_lagcompensationdivisor")
end

function sea.Game:getLocalRConOutputAttribute()
	return game("mp_localrconoutput")
end

function sea.Game:getLuaMapAttribute()
	return game("mp_luamap")
end

function sea.Game:getLuaServerAttribute()
	return game("mp_luaserver")
end

function sea.Game:getMapGoalScoreAttribute()
	return game("mp_mapgoalscore")
end

function sea.Game:getMapVoteRatioAttribute()
	return game("mp_mapvoteratio")
end

function sea.Game:getMaxClientsIPAttribute()
	return game("mp_maxclientsip")
end

function sea.Game:getMaxRConFailsAttribute()
	return game("mp_maxrconfails")
end

function sea.Game:getNatHolePunchingAttribute()
	return game("mp_natholepunching")
end

function sea.Game:getPingLimitAttribute()
	return game("mp_pinglimit")
end

function sea.Game:getPostSpawnAttribute()
	return game("mp_postspawn")
end

function sea.Game:getRadarAttribute()
	return game("mp_radar")
end

function sea.Game:getRandomSpawnAttribute()
	return game("mp_randomspawn")
end

function sea.Game:getRecoilAttribute()
	return game("mp_recoil")
end

function sea.Game:getReservationsAttribute()
	return game("mp_reservations")
end

function sea.Game:getRespawnDelayAttribute()
	return game("mp_respawndelay")
end

function sea.Game:getRoundLimitAttribute()
	return game("mp_roundlimit")
end

function sea.Game:getRoundTimeAttribute()
	return game("mp_roundtime")
end

function sea.Game:getShotWeakeningAttribute()
	return game("mp_shotweakening")
end

function sea.Game:getSmokeBlockAttribute()
	return game("mp_smokeblock")
end

function sea.Game:getStartMoneyAttribute()
	return game("mp_startmoney")
end

function sea.Game:getSupplyItemsAttribute()
	return game("mp_supply_items")
end

function sea.Game:getTeamkillPenaltyAttribute()
	return game("mp_teamkillpenalty")
end

function sea.Game:getTeleportReloadAttribute()
	return game("mp_teleportreload")
end

function sea.Game:getTempBanTimeAttribute()
	return game("mp_tempbantime")
end

function sea.Game:getTimeLimitAttribute()
	return game("mp_timelimit")
end

function sea.Game:getTkPunishAttribute()
	return game("mp_tkpunish")
end

function sea.Game:getTraceAttribute()
	return game("mp_trace")
end

function sea.Game:getTurretDamageAttribute()
	return game("mp_turretdamage")
end

function sea.Game:getUnbuildableAttribute()
	return game("mp_unbuildable")
end

function sea.Game:getUnbuyableAttribute()
	return game("mp_unbuyable")
end

function sea.Game:getVulnerableHostagesAttribute()
	return game("mp_vulnerablehostages")
end

function sea.Game:getWinLimitAttribute()
	return game("mp_winlimit")
end

function sea.Game:getZombieDamageAttribute()
	return game("mp_zombiedmg")
end

function sea.Game:getZombieKillEquipAttribute()
	return game("mp_zombiekillequip")
end

function sea.Game:getZombieKillScoreAttribute()
	return game("mp_zombiekillscore")
end

function sea.Game:getZombieRecoverAttribute()
	return game("mp_zombierecover")
end

function sea.Game:getZombieSpeedAttribute()
	return game("mp_zombiespeedmod")
end

function sea.Game:getVersionAttribute()
	return game("version")
end

function sea.Game:getDedicatedAttribute()
	return game("dedicated")
end

function sea.Game:getPhaseAttribute()
	return game("phase")
end

function sea.Game:getRoundAttribute()
	return game("round")
end

function sea.Game:getTScoreAttribute()
	return game("score_t")
end

function sea.Game:getCtScoreAttribute()
	return game("score_ct")
end

function sea.Game:getTWinRowAttribute()
	return game("winrow_t")
end

function sea.Game:getCtWinRowAttribute()
	return game("winrow_ct")
end

function sea.Game:getNextMapAttribute()
	return game("nextmap")
end

function sea.Game:getPortAttribute()
	return game("port")
end

function sea.Game:getBombPlantedAttribute()
	return game("bombplanted")
end

function sea.Game:getSysFolderAttribute()
	return game("sysfolder")
end

-------------------------
--       SETTERS       --
-------------------------

function sea.Game:setCheckUSGNLoginAttribute(value)
    parse("sv_checkusgnlogin", value)
end

function sea.Game:setDaylightTimeAttribute(value)
    parse("sv_daylighttime", value)
end

function sea.Game:setForceLightAttribute(value)
    parse("sv_forcelight", value)
end

function sea.Game:setFowAttribute(value)
    parse("sv_fow", value)
end

function sea.Game:setFriendlyFireAttribute(value)
    parse("sv_friendlyfire", value)
end

function sea.Game:setGameModeAttribute(value)
    parse("sv_gm", value)
end

function sea.Game:setHostPortAttribute(value)
    parse("sv_hostport", value)
end

function sea.Game:setLanAttribute(value)
    parse("sv_lan", value)
end

function sea.Game:setMapAttribute(value)
    parse("sv_map", value)
end

function sea.Game:setMapTransferAttribute(value)
    parse("sv_maptransfer", value)
end

function sea.Game:setMaxPlayersAttribute(value)
    parse("sv_maxplayers", value)
end

function sea.Game:setNameAttribute(value)
    parse("sv_name", value)
end

function sea.Game:setOffScreenDamageAttribute(value)
    parse("sv_offscreendamage", value)
end

function sea.Game:setPasswordAttribute(value)
    parse("sv_password", value)
end

function sea.Game:setRconAttribute(value)
    parse("sv_rcon", value)
end

function sea.Game:setRconUsersAttribute(value)
    parse("sv_rconusers", value)
end

function sea.Game:setSpecModeAttribute(value)
    parse("sv_specmode", value)
end

function sea.Game:setSprayTransferAttribute(value)
    parse("sv_spraytransfer", value)
end

function sea.Game:setUsgnOnlyAttribute(value)
    parse("sv_usgnonly", value)
end

function sea.Game:setAntispeederAttribute(value)
    parse("mp_antispeeder", value)
end

function sea.Game:setAutoGameModeAttribute(value)
    parse("mp_autogamemode", value)
end

function sea.Game:setAutoTeamBalanceAttribute(value)
    parse("mp_autoteambalance", value)
end

function sea.Game:setBuyMenuAttribute(value)
    parse("mp_buymenu", value)
end

function sea.Game:setBuyTimeAttribute(value)
    parse("mp_buytime", value)
end

function sea.Game:setC4TimerAttribute(value)
    parse("mp_c4timer", value)
end

function sea.Game:setConnectionLimitAttribute(value)
    parse("mp_connectionlimit", value)
end

function sea.Game:setCurtailedExplosionsAttribute(value)
    parse("mp_curtailedexplosions", value)
end

function sea.Game:setDamageFactorAttribute(value)
    parse("mp_damagefactor", value)
end

function sea.Game:setDeathDropAttribute(value)
    parse("mp_deathdrop", value)
end

function sea.Game:setDeatmatchSpawnMoneyAttribute(value)
    parse("mp_dmspawnmoney", value)
end

function sea.Game:setDropGrenadesAttribute(value)
    parse("mp_dropgrenades", value)
end

function sea.Game:setFlaslightAttribute(value)
    parse("mp_flashlight", value)
end

function sea.Game:setFloodProtAttribute(value)
    parse("mp_floodprot", value)
end

function sea.Game:setFloodProtIgnoreTimeAttribute(value)
    parse("mp_floodprotignoretime", value)
end

function sea.Game:setFreezeTimeAttribute(value)
    parse("mp_freezetime", value)
end

function sea.Game:setGrenadeRebuyAttribute(value)
    parse("mp_grenaderebuy", value)
end

function sea.Game:setHostagePenaltyAttribute(value)
    parse("mp_hostagepenalty", value)
end

function sea.Game:setHoverTextAttribute(value)
    parse("mp_hovertext", value)
end

function sea.Game:setHudAttribute(value)
    parse("mp_hud", value)
end

function sea.Game:setHudScaleAttribute(value)
    parse("mp_hudscale", value)
end

function sea.Game:setIdleActionAttribute(value)
    parse("mp_idleaction", value)
end

function sea.Game:setIdleKickAttribute(value)
    parse("mp_idlekick", value)
end

function sea.Game:setIdleTimeAttribute(value)
    parse("mp_idletime", value)
end

function sea.Game:setInfiniteAmmoAttribute(value)
    parse("mp_infammo", value)
end

function sea.Game:setKevlarAttribute(value)
    parse("mp_kevlar", value)
end

function sea.Game:setKickPerCentAttribute(value)
    parse("mp_kickpercent", value)
end

function sea.Game:setKillBuildingMoneyAttribute(value)
    parse("mp_killbuildingmoney", value)
end

function sea.Game:setKillBuildingsAttribute(value)
    parse("mp_killbuildings", value)
end

function sea.Game:setKillInfoAttribute(value)
    parse("mp_killinfo", value)
end

function sea.Game:setKillTeamBuildingsAttribute(value)
    parse("mp_killteambuildings", value)
end

function sea.Game:setLagCompensationAttribute(value)
    parse("mp_lagcompensation", value)
end

function sea.Game:setLagCompensationDivisorAttribute(value)
    parse("mp_lagcompensationdivisor", value)
end

function sea.Game:setLocalRConOutputAttribute(value)
    parse("mp_localrconoutput", value)
end

function sea.Game:setLuaMapAttribute(value)
    parse("mp_luamap", value)
end

function sea.Game:setLuaServerAttribute(value)
    parse("mp_luaserver", value)
end

function sea.Game:setMapGoalScoreAttribute(value)
    parse("mp_mapgoalscore", value)
end

function sea.Game:setMapVoteRatioAttribute(value)
    parse("mp_mapvoteratio", value)
end

function sea.Game:setMaxClientsIPAttribute(value)
    parse("mp_maxclientsip", value)
end

function sea.Game:setMaxRConFailsAttribute(value)
    parsed("mp_maxrconfails", value)
end

function sea.Game:setNatHolePunchingAttribute(value)
    parse("mp_natholepunching", value)
end

function sea.Game:setPingLimitAttribute(value)
    parse("mp_pinglimit", value)
end

function sea.Game:setPostSpawnAttribute(value)
    parse("mp_postspawn", value)
end

function sea.Game:setRadarAttribute(value)
    parse("mp_radar", value)
end

function sea.Game:setRandomSpawnAttribute(value)
    parse("mp_randomspawn", value)
end

function sea.Game:setRecoilAttribute(value)
    parse("mp_recoil", value)
end

function sea.Game:setReservationsAttribute(value)
    parse("mp_reservations", value)
end

function sea.Game:setRespawnDelayAttribute(value)
    parse("mp_respawndelay", value)
end

function sea.Game:setRoundLimitAttribute(value)
    parse("mp_roundlimit", value)
end

function sea.Game:setRoundTimeAttribute(value)
    parse("mp_roundtime", value)
end

function sea.Game:setShotWeakeningAttribute(value)
    parse("mp_shotweakening", value)
end

function sea.Game:setSmokeBlockAttribute(value)
    parse("mp_smokeblock", value)
end

function sea.Game:setStartMoneyAttribute(value)
    parse("mp_startmoney", value)
end

function sea.Game:setSupplyItemsAttribute(value)
    parse("mp_supply_items", value)
end

function sea.Game:setTeamkillPenaltyAttribute(value)
    parse("mp_teamkillpenalty", value)
end

function sea.Game:setTeleportReloadAttribute(value)
    parse("mp_teleportreload", value)
end

function sea.Game:setTempBanTimeAttribute(value)
    parse("mp_tempbantime", value)
end

function sea.Game:setTimeLimitAttribute(value)
    parse("mp_timelimit", value)
end

function sea.Game:setTkPunishAttribute(value)
    parse("mp_tkpunish", value)
end

function sea.Game:setTraceAttribute(value)
    parse("mp_trace", value)
end

function sea.Game:setTurretDamageAttribute(value)
    parse("mp_turretdamage", value)
end

function sea.Game:setUnbuildableAttribute(value)
    parse("mp_unbuildable", value)
end

function sea.Game:setUnbuyableAttribute(value)
    parse("mp_unbuyable", value)
end

function sea.Game:setVulnerableHostagesAttribute(value)
    parse("mp_vulnerablehostages", value)
end

function sea.Game:setWinLimitAttribute(value)
    parse("mp_winlimit", value)
end

function sea.Game:setZombieDamageAttribute(value)
    parse("mp_zombiedmg", value)
end

function sea.Game:setZombieKillEquipAttribute(value)
    parse("mp_zombiekillequip", value)
end

function sea.Game:setZombieKillScoreAttribute(value)
    parse("mp_zombiekillscore", value)
end

function sea.Game:setZombieRecoverAttribute(value)
    parse("mp_zombierecover", value)
end

function sea.Game:setZombieSpeedAttribute(value)
    parse("mp_zombiespeedmod", value)
end
