sea.config = {}

sea.config.systemPrefix = "Sea Framework"

-- Do not remove the existing ones, you may add or change (not recommended)
sea.config.color = {
    system = {
        error = "255000000",
        warning = "255255100",
        info = "100255255",
        success = "100255100",

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

sea.config.player = {
    info = {
        ["Name"] = function(player) return player.name end,
        ["U.S.G.N."] = function(player) return player.usgn or "Not logged in" end,
        ["Steam"] = function(player) return player.steamName or "Not logged in" end
    },

    stat = { -- Get illuminated: http://www.cs2d.com/help.php?luacat=player&luacmd=player#cmd, http://www.cs2d.com/help.php?luacat=player&luacmd=stats#cmd & http://www.cs2d.com/help.php?luacat=player&luacmd=steamstats#cmd
        ["Time Played"] = {0, function(value) return value end},
        ["Kills"] = 0,
        ["Deaths"] = 0
    },

    variable = {

    },

    setting = {

    }
}

sea.config.server = {
    info = sea.createArticle("Server Info", "This server is powered via Sea Framework made by Masea."),

    news = {
        sea.createArticle("This Is an Example News Title", "This is an example news description. Let's see if it works!")
    },
    
    setting = {
        radar = true, 
        buying = true,
        suiciding = true,
        hud = 127,
    }, 

    bindings = {"escape", "mouse1", "mouse2"}
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

