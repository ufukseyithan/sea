-- Core
sea.getColor = function(name, category)
    return category and sea.config.color[category][name] or sea.config.color.custom[name]
end

sea.createText =  function(text, color)
    return "\169"..(color or sea.getColor("default", "system"))..text
end

-- @TODO: Create paragraph

sea.createArticle = function(title, content, imagePath)
    return {
        title = title,
        content = content,
        imagePath = imagePath
    }
end

sea.createConsoleText = function(text, color, prefix, prefixColor)
    return sea.createText("["..sea.config.systemPrefix.."] "..(prefix and "["..prefix.."] " or ""), prefixColor)..sea.createText(text, color)
end

sea.print = function(text, color, prefix, prefixColor)
    print(sea.createConsoleText(text, color, prefix, prefixColor))
end

sea.systemPrint = function(text, type)
    sea.print(text, nil, type:upperFirst(), sea.getColor(type, "system"))
end

sea.error = function(text)
    sea.systemPrint(text, "error")
end

sea.warning = function(text)
    sea.systemPrint(text, "warning")
end

sea.info = function(text)
    sea.systemPrint(text, "info")
end

sea.success = function(text)
    sea.systemPrint(text, "success")
end

sea.message = function(player, text, color, prefix, prefixColor)
    text = sea.createText(prefix and "["..prefix.."] " or "", prefixColor)..sea.createColorText(text, color)
    
    if not player then
        msg(text)
    else
        msg2(player.id, text)
    end
end

sea.notification = function(player, title, text)
    sea.message(player, text, nil, title)
end

sea.help = function(player, text)
    sea.message(player, text)
end

-- Utilities
sea.addTransferFile = function(path, response)
	if not io.exists(path) then
		sea.error("The file \""..path.."\" cannot be added as a transfer file, it does not exist.")
		return false
    end
    
    if io.isDirectory(path) then
        sea.error("The file \""..path.."\" cannot be added as a transfer file, it is a directory.")
		return false
    end

    -- @TODO: Check the formats supported by servertransfer.lst (It is written in servertransfer.lst when you download a fresh CS2D copy)

    -- @TODO: Check if the file is bigger than 250Kb, if so throw a warning

    table.insert(sea.transferFiles, path)
    
    if response then
        sea.success("Added transfer file: \""..path.."\"")
    end

	return true
end

sea.produceTransferFile = function(response)
    local serverTransferListPath = sea.path.sys.."servertransfer.lst"

    io.toTable(serverTransferListPath, sea.transferFiles)

    sea.transferFiles = table.removeDuplicates(sea.transferFiles)

    local addedFiles = 0
    local file = io.open(serverTransferListPath, "w+") or io.tmpfile()
	for k, v in pairs(sea.transferFiles) do
		file:write(v.."\n")
		
		if response then
			sea.success("The file \""..v.."\" has been added to the server transfer list.")
        end
        
        addedFiles = addedFiles + 1
	end
	file:close()

    if addedFiles > 0 then
        -- @TODO: Write a better info
		sea.info("The server transfer list has been updated with "..addedFiles.." lines. You may need to restart the server.")
	end
end

sea.addCustomColor = function(name, color)
    local customColor = sea.config.color.custom

    if customColor[name] then
        sea.error("The custom color \""..name.."\" cannot be added, it already exists.")
        return false
    end

    customColor[name] = color

    sea.info("Added custom color: "..sea.createText("\""..name.."\"", color))

    return true
end

sea.addPlayerInfo = function(name, func)
    local playerInfo = sea.config.player.info

    if playerInfo[name] then
        sea.error("The player info \""..name.."\" cannot be added, it already exists.")
        return false
    end

    playerInfo[name] = func

    sea.info("Added player info: \""..name.."\"")

    return true
end

sea.addPlayerStat = function(name, defaultValue, customDisplay)
    local playerStat = sea.config.player.stat

    if playerStat[name] then
        sea.error("The player variable \""..name.."\" cannot be added, it already exists.")
        return false
    end

    playerStat[name] = not customDisplay and defaultValue or {defaultValue, customDisplay}

    sea.info("Added player stat: \""..name.."\"")

    return true
end

sea.addPlayerVariable = function(name, defaultValue)
    local playerVariable = sea.config.player.variable

    if playerVariable[name] then
        sea.error("The player variable \""..name.."\" cannot be added, it already exists.")
        return false
    end

    playerVariable[name] = defaultValue

    sea.info("Added player variable: \""..name.."\" ("..defaultValue..")")

    return true
end

sea.addPlayerSetting = function()

end

sea.setServerInfo = function(article)
    local serverInfo = sea.config.server.info

    serverInfo = article

    sea.info("Set server info: \""..article.title.."\"")
end

sea.addServerNews = function(article)
    local serverNews = sea.config.server.news

    table.insert(serverNews, article)

    sea.info("Added server news: \""..article.title.."\"")
end

sea.setServerSetting = function(setting, value)
    local serverSetting  = sea.config.server.setting

    if not serverSetting[setting] then
        sea.error("The server setting \""..setting.."\" cannot be set, it does not exist.")
        return false
    end

    serverSetting[setting] = value

    sea.info("Set server setting: \""..setting.."\" = "..tostring(value))
end

sea.addServerBinding = function(key)
    local serverBindings = sea.config.server.bindings

    if table.contains(serverBindings, key) then
        sea.error("The server binding \""..key.."\" cannot be added, it already exist.")
        return false
    end

    table.insert(serverBindings, key)

    sea.info("Added server news: \""..article.title.."\"")

    return true
end

sea.addMainMenuTab = function(name, buttons)

end