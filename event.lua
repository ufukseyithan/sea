local event = {}

-- ADD THE MISING ONES
local hooks = {
    server = {
        "always", "break", "endround", "hitzone", "log", "mapchange", "minute", "ms100", "objectdamage", "objectkill", "objectupgrade",
        "parse", "projectile", "rcon", "second", "shutdown", "startround", "startround_prespawn", "trigger", "triggerentity"
    },

    player = {
        "attack", "attack2", "bombdefuse", "bombexplode", "bombplant", "build", "buildattempt", "buy", "clientdata", "collect", "die", "dominate",
        "drop", "flagcapture", "flagtake", "flashlight", "hit", "hostagerescue", "join", "kill", "leave", "menu", "move", "movetile", "name", "radio",
        "reload", "say", "sayteam", "select", "serveraction", "shieldhit", "spawn", "specswitch", "spray", "suicide", "team", "use", "usebutton",
        "vipescape", "vote", "walkover", "key"
    }
}

-- Nil the addhook so it can't be added

return event