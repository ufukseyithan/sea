sea.config = {}

-- The prefix used for console outputs
sea.config.systemPrefix = "[Sea]"

-- These formats are the only ones that the server transfer list supports, meaning you may remove the existing ones as you wish but not add new ones
sea.config.supportedTransferFileFormats = {".bmp", ".jpg", ".jpeg", ".png", ".wav", ".ogg"}

sea.config.welcomeMessage = true

-- Do not touch these, use sea.addColor function instead
sea.config.color = {
    system = {
        error = sea.Color.new(255, 25, 54),
        warning = sea.Color.new(255, 155, 54),
        info = sea.Color.new(155, 255, 255),
        success = sea.Color.new(155, 255, 155),

        default = sea.Color.white
    },
    
    team = {
        [0] = sea.Color.new(255, 220, 0),
        [1] = sea.Color.new(255, 25, 0),
        [2] = sea.Color.new(50, 150, 255),
	    [3] = sea.Color.new(0, 255, 0)
    },

    custom = {}
}

sea.config.player = {
    info = {
        ["Name"] = function(player) return player.name end,
        ["U.S.G.N."] = function(player) return player.usgn or "Not logged in" end,
        ["Steam"] = function(player) return player.steamID ~= "0" and player.steamName or "Not logged in" end,
        ["Position"] = function(player) return player.tileX.." | "..player.tileY.." ("..player.x.." | "..player.y..")" end
    },

    stat = { -- Get illuminated: http://www.cs2d.com/help.php?luacat=player&luacmd=player#cmd, http://www.cs2d.com/help.php?luacat=player&luacmd=stats#cmd & http://www.cs2d.com/help.php?luacat=player&luacmd=steamstats#cmd
        ["Time Played"] = {0, function(value) return value.." (in seconds)" end},
        ["Kills"] = {0},
        ["Deaths"] = {0}
    },

    variable = {},

    method = {},

    preference = {},

    control = {
        ["Escape"] = {"escape"},
        ["Left Mouse"] = {"mouse1"},
        ["Right Mouse"] = {"mouse2"},
        ["Mouse Scroll Up"] = {"mwheelup"},
        ["Mouse Scroll Down"] = {"mwheeldown"}
    }
}

sea.config.server = {
    info = sea.createArticle("Server Info", "This server is powered via Sea Framework made by Masea."),

    news = {
        sea.createArticle("This Is an Example News Title", "This is an example news description. Let's see if it works!")
    },
    
    setting = {
        
    }
}

sea.config.ui = {
    soundPath = {
        click = "",
        hover = ""
    }
}

sea.config.mainMenuStructure = {
    name = "Main Menu",
    content = {
        {
            name = "Brief",
            structure = {
                name = "Brief",
                content = {
                    {
                        name = "Notifications",
                        func = function(player)
                            if not table.isEmpty(player.notifications) then
                                player:message(sea.createText("The notifications of the current session have been sent to your console."))
                
                                for _, notification in ipairs(player.notifications) do
                                    player:consoleMessage(notification)
                                end
                            else
                                player:alert("No available notifications found")
                            end
                        end,
                        description = "View the notifications you have received in this session"
                    },
                    {
                        name = "Hints",
                        func = function(player)
                            if not table.isEmpty(player.hints) then
                                player:message(sea.createText("The hints of the current session have been sent to your console."))
                
                                for _, hint in ipairs(player.hints) do
                                    player:consoleMessage(hint)
                                end
                            else
                                player:alert("No available hints found")
                            end
                        end,
                        description = "View the hints you have received in this session"
                    }
                }
            }
        },
        {
            name = "Player",
            structure = {
                name = "Player",
                content = {
                    {
                        name = "Information",
                        structure = {
                            name = "Information",
                            content = function()
                                local buttons = {}

                                for name in pairs(sea.config.player.info) do
                                    table.insert(buttons, {
                                        name = name,
                                        description = function(player) return player:getInfo(name) end
                                    })
                                end

                                return buttons
                            end
                        }
                    },
                    {
                        name = "Statistics",
                        structure = {
                            name = "Statistics",
                            content = function()
                                local buttons = {}

                                for name, v in pairs(sea.config.player.stat) do
                                    table.insert(buttons, {
                                        name = name,
                                        description = function(player)
                                            local value = player.stat[name]
                                            return v[2] and v[2](value) or value 
                                        end
                                    })
                                end

                                return buttons
                            end
                        }
                    }
                }
            }
        },
        {
            name = "Settings",
            structure = {
                name = "Settings",
                content = {
                    {
                        name = "Controls",
                        structure = {
                            name = "Controls",
                            content = function()
                                local buttons = {}

                                for name, v in pairs(sea.config.player.control) do
                                    if v[2] then
                                        table.insert(buttons, {
                                            name = name,
                                            func = function(player)
                                                -- @TODO
                                            end,
                                            description = function(player) return player.control[name] end
                                        })
                                    end
                                end

                                return buttons
                            end
                        }
                    },
                    {
                        name = "Preferences",
                        structure = {
                            name = "Preferences",
                            content = function()
                                local buttons = {}

                                for name, v in pairs(sea.config.player.preference) do
                                    table.insert(buttons, {
                                        name = function(player) return name.." ["..player.preference[name].."]" end, 
                                        func = function(player)
                                            local preferences = v[2]
                                            local current = table.getKeyOf(v[2], player.preference[name])
                        
                                            current = current + 1
                                            if current > table.count(preferences) then
                                                current = 1
                                            end
                        
                                            player.preference[name] = preferences[current]
                        
                                            return true
                                        end, 
                                        description = v[3]
                                    })
                                end

                                return buttons
                            end
                        }
                    }
                }
            }
        },
        {
            name = "Server"
        }
    }
}
