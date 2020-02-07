sea.config = {}

-- The prefix used for console outputs
sea.config.systemPrefix = "[Sea]"

-- These formats are the only ones that the server transfer list supports, meaning you may remove the existing ones as you wish but not add new ones
sea.config.supportedTransferFileFormats = {".bmp", ".jpg", ".jpeg", ".png", ".wav", ".ogg"}

-- Do not touch these, use sea.addColor function instead
sea.config.color = {
    system = {
        error = "255025054",
        warning = "255155000",
        info = "155255255",
        success = "155255155",

        default = "255255255"
    },
    
    player = {
        spec = "255220000",
		ct = "050150255",
		t = "255025000",
		tdm = "000255000"
    },

    custom = {}
}

--[[
    customChat (function): a function (parameters: player, text) that returns text, textColor, prefix, prefixColor (last three are optional) 
]]
sea.config.game = {}

sea.config.player = {
    info = {
        ["Name"] = function(player) return player.name end,
        ["U.S.G.N."] = function(player) return player.usgn or "Not logged in" end,
        ["Steam"] = function(player) return player.steamname or "Not logged in" end,
        ["Position"] = function(player) return player.tileX.." | "..player.tileY.." ("..player.x.." | "..player.y..")" end
    },

    stat = { -- Get illuminated: http://www.cs2d.com/help.php?luacat=player&luacmd=player#cmd, http://www.cs2d.com/help.php?luacat=player&luacmd=stats#cmd & http://www.cs2d.com/help.php?luacat=player&luacmd=steamstats#cmd
        ["Time Played"] = {0, function(value) return value end},
        ["Kills"] = {0},
        ["Deaths"] = {0}
    },

    variable = {},

    method = {},

    -- @TODO: Settings should also have descriptions, see the config.lua of citylife
    setting = {},

    control = {
        escape = {"escape"},
        leftmouse = {"mouse1"},
        rightmouse = {"mouse2"},
        mousescrollup = {"mwheelup"},
        mousescrolldown = {"mwheeldown"}
    }
}

sea.config.server = {
    info = sea.createArticle("Server Info", "This server is powered via Sea Framework made by Masea."),

    news = {
        sea.createArticle("This Is an Example News Title", "This is an example news description. Let's see if it works!")
    },
    
    setting = {}
}

sea.config.ui = {
    soundPath = {
        click = "",
        hover = ""
    }
}

sea.config.mainMenuTabs = {
    ["MAP"] = {
        
    },
    ["BRIEF"] = { -- Notifications, helps

    },
    ["PLAYER"] = { -- Info, stats

    },
    ["SERVER"] = { -- Server info, news, administration stuff for admins

    },
    ["SETTINGS"] = { -- Controls and maybe some other preferences

    }
}


