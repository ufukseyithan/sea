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
    text = sea.createText(prefix and "["..prefix.."] " or "", prefixColor)..sea.createText(text, color)
    
    if not player then
        msg(text)
    else
        msg2(tonumber(player), text)
    end
end

sea.loadApp = function(directory)
    local app
    
    local mainPath = directory.."main.lua"
    if not io.exists(mainPath) then
        sea.error("The app directory \""..directory.."\" cannot be loaded, it does not include \"main.lua\".")
        return false
    end

    app = dofile(mainPath)

    if not app.name then
        sea.error("The app directory \""..directory.."\" cannot be loaded, it does not have a name.")
        return false
    end

    if app.disabled then
        sea.info("The app "..app.name.." is not loaded as it is disabled.")
        return false
    end

    for k, v in pairs(sea.app) do
        if v.name == app.name then
            sea.error("The app "..app.name.." cannot be loaded, it already exists.")
            return false
        end
    end

    local transferFiles = 0
    for pathName, appCustomPath in pairs(app.path) do
        if pathName == "gfx" or pathName == "sfx" then
            for _, filePath in pairs(io.getFilePaths(appCustomPath, true)) do
                sea.addTransferFile(filePath)

                transferFiles = transferFiles + 1
            end
        end
    end

    local configPath, successConfig = directory.."config.lua", 0
    if io.exists(configPath) then
        local config = dofile(configPath)

        for category, content in pairs(config) do
            if category == "color" then
                for name, color in pairs(content) do
                    if sea.addCustomColor(name, color) then
                        successConfig = successConfig + 1
                    end
                end
            elseif category == "player" then
                for k, v in pairs(content) do
                    if k == "info" then
                        for name, func in pairs(v) do
                            if sea.addPlayerInfo(name, func) then
                                successConfig = successConfig + 1
                            end
                        end
                    elseif k == "stat" then
                        for name, v in pairs(v) do
                            if sea.addPlayerStat(name, type(v) == "table" and v[1] or v, v[2]) then
                                successConfig = successConfig + 1
                            end
                        end
                    elseif k == "variable" then
                        for name, v in pairs(v) do
                            if sea.addPlayerVariable(name, type(v) == "table" and v[1] or v, v[2]) then
                                successConfig = successConfig + 1
                            end
                        end
                    elseif k == "setting" then
                        -- @TODO
                    end
                end
            elseif category == "server" then
                for k, v in pairs(content) do
                    if k == "info" then
                        sea.setServerInfo(v)

                        successConfig = successConfig + 1
                    elseif k == "news" then
                        for _, article in pairs(v) do
                            sea.addServerNews(article)

                            successConfig = successConfig + 1
                        end
                    elseif k == "setting" then
                        for setting, value in pairs(v) do
                            if sea.setServerSetting(setting, value) then
                                successConfig = successConfig + 1
                            end
                        end
                    elseif k == "bindings" then
                        for _, key in pairs(v) do
                            if sea.addServerBinding(key) then
                                successConfig = successConfig + 1
                            end
                        end
                    end
                end
            elseif category == "mainMenuTabs" then
                for name, buttons in pairs(content) do
                    if sea.addMainMenuTab(name, buttons) then
                        successConfig = successConfig + 1
                    end
                end
            end
        end

        app.config, app.path.config = config, configPath
    end

    local loadedScripts = 0
    if app.scripts then
        for _, path in ipairs(app.scripts) do
            if sea.loadScript(directory..path) then
                loadedScripts = loadedScripts + 1
            end
        end
    end  

    table.insert(sea.app, app) 

    sea.success("Loaded app: "..app.name.." v"..app.version.." by "..app.author.." ("..transferFiles.." transfer files, "..successConfig.." successful configurations, "..loadedScripts.." loaded scripts)")

    return true
end

sea.loadScript = function(path)
    if path:sub(-4) ~= ".lua" then
        path = path..".lua"
    end

    if not io.exists(path) then
        sea.error("The script \""..path.."\" cannot be loaded, it does not exist.")
        return false
    end

    dofile(path)

    sea.info("Loaded script: \""..path.."\"")

    return true
end

sea.addTransferFile = function(path, response)
	if not io.exists(path) then
		sea.error("The file \""..path.."\" cannot be added as a transfer file, it does not exist.")
		return false
    end
    
    if io.isDirectory(path) then
        sea.error("The file \""..path.."\" cannot be added as a transfer file, it is a directory.")
		return false
    end

    local hasUnsupportedFormat
    for _, format in pairs(sea.config.supportedTransferFileFormats) do
        if path:find(format) then
            hasUnsupportedFormat = true
        end
    end

    if not hasUnsupportedFormat then
        sea.error("The file \""..path.."\" cannot be added as a transfer file, its format is not supported.")
        return false
    end

    local file = io.open(path)
    local fileSizeInKB = math.round(file:seek("end") / 1024, 2)
    if fileSizeInKB >= 250 then
        sea.warning("The size of the file \""..path.."\" is "..fileSizeInKB.." KB, some players may not be able to download it.")
    end
    file:close()

    table.insert(sea.transferFiles, path)
    
    if response then
        sea.success("Added transfer file: \""..path.."\"")
    end

	return true
end

sea.updateServerTransferList = function(response)
    local serverTransferListPath = sea.path.sys.."servertransfer.lst"

    io.toTable(serverTransferListPath, sea.transferFiles)
    
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
    
    sea.transferFiles = table.removeDuplicates(sea.transferFiles)

    if addedFiles > 0 then
		sea.info("The server transfer list has been updated. You may need to restart the server in order to get use of it.")
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

    sea.info("Added player stat: \""..name.."\" (default value: "..defaultValue..(customDisplay and ", has custom display" or "")..")")

    return true
end

sea.addPlayerVariable = function(name, defaultValue, isData)
    local playerVariable = sea.config.player.variable

    if playerVariable[name] then
        sea.error("The player variable \""..name.."\" cannot be added, it already exists.")
        return false
    end

    playerVariable[name] = not isData and defaultValue or {defaultValue, isData}

    sea.info("Added player variable: \""..name.."\" (default value: "..defaultValue..(isData and ", data" or "")..")")

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
        -- @TODO: Find a better error message
        sea.error("The server setting \""..setting.."\" cannot be set, it does not exist.")
        return false
    end

    serverSetting[setting] = value

    sea.info("Set server setting: \""..setting.."\" = "..tostring(value))

    return true
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
    local mainMenuTabs = sea.config.mainMenuTabs

    if mainMenuTabs[name] then
        sea.error("The main menu tab \""..name.."\" cannot be added, it already exist.")
        return false
    end
    
    mainMenuTabs[name] = buttons

    sea.info("Added main menu tab: \""..name.."\"")

    return true
end