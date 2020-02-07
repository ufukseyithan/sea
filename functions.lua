function sea.getColor(name, category)
    return category and sea.config.color[category][name] or sea.config.color.custom[name]
end

function sea.createText(text, color, prefix, prefixColor)
    local prefix = prefix and "©"..(prefixColor or sea.getColor("default", "system"))..prefix.." " or "" 
    return prefix.."©"..(color or sea.getColor("default", "system"))..text
end

function sea.createSystemText(text, color, prefix, prefixColor)
    return sea.createText(text, color, sea.config.systemPrefix..(prefix and (" "..prefix) or ""), prefixColor)
end

function sea.print(text)
    print(text)
end

function sea.systemPrint(type, text)
    sea.print(sea.createSystemText(text, nil, "["..type:upperFirst().."]", sea.getColor(type, "system")))
end

function sea.error(text)
    sea.systemPrint("error", text)
end

function sea.warning(text)
    sea.systemPrint("warning", text)
end

function sea.info(text)
    sea.systemPrint("info", text)
end

function sea.success(text)
    sea.systemPrint("success", text)
end

function sea.message(id, text)
    if not id or id == 0 then
        msg(text)
    else
        msg2(id, text)
    end
end

function sea.consoleMessage(id, text)
    if not id or id == 0 then
        parse("cmsg", text)
    else
        parse("cmsg", text, id)
    end
end

function sea.createArticle(title, content, imagePath)
    return {
        title = title,
        content = content,
        imagePath = imagePath
    }
end

function sea.loadScript(path)
    if path:sub(-4) ~= ".lua" then
        path = path..".lua"
    end

    if not io.exists(path) then
        sea.error("The script "..path.." cannot be loaded, it does not exist.")
        return false
    end

    dofile(path)

    sea.info("Loaded script: "..path)

    return true
end

function sea.addTransferFile(path, response, update)
	if not io.exists(path) then
		sea.error("The file "..path.." cannot be added as a transfer file, it does not exist.")
		return false
    end
    
    if io.isDirectory(path) then
        sea.error("The file "..path.." cannot be added as a transfer file, it is a directory.")
		return false
    end

    local hasUnsupportedFormat
    for _, format in pairs(sea.config.supportedTransferFileFormats) do
        if path:find(format) then
            hasUnsupportedFormat = true
        end
    end

    if not hasUnsupportedFormat then
        sea.error("The file "..path.." cannot be added as a transfer file, its format is not supported.")
        return false
    end

    local file = io.open(path)
    local fileSizeInKB = math.round(file:seek("end") / 1024, 2)
    if fileSizeInKB >= 250 then
        sea.warning("The size of the file "..path.." is "..fileSizeInKB.." KB, some players may not be able to download it.")
    end
    file:close()

    table.insert(sea.transferFiles, path)
    
    if response then
        sea.success("Added transfer file: "..path)
    end

    if update then
        sea.updateServerTransferList()
    end

	return true
end

function sea.updateServerTransferList(response)
    local serverTransferListPath = sea.path.sys.."servertransfer.lst"

    io.toTable(serverTransferListPath, sea.transferFiles)
    
    local addedFiles = 0
    local file = io.open(serverTransferListPath, "w+") or io.tmpfile()
	for k, v in pairs(sea.transferFiles) do
		file:write(v.."\n")
		
		if response then
			sea.success("The file "..v.." has been added to the server transfer list.")
        end
        
        addedFiles = addedFiles + 1
	end
    file:close()
    
    sea.transferFiles = table.removeDuplicates(sea.transferFiles)

    if addedFiles > 0 then
		sea.info("The server transfer list has been updated. You may need to restart the server in order to get use of it.")
	end
end

function sea.initApp(directory)
    local app
    
    local mainPath = directory.."main.lua"
    if not io.exists(mainPath) then
        sea.error("The app directory "..directory.." cannot be loaded, it does not include main.lua.")
        return false
    end

    app = dofile(mainPath)

    if not app.namespace then
        sea.error("The app directory "..directory.." cannot be loaded, namespace is not defined.")
        return false
    end

    if app.disabled then
        sea.info("The app "..app.name.." is not loaded as it is disabled.")
        return false
    end

    if sea.app[app.namespace] then
        sea.error("The app with the namespace "..app.namespace.." cannot be loaded, it already exists.")
        return false
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

    local configPath, successfulConfig = directory.."config.lua", 0
    if io.exists(configPath) then
        local config = dofile(configPath)

        for category, content in pairs(config) do
            switch (category) {
                color = function()
                    for name, color in pairs(content) do
                        if sea.addColor(name, color) then
                            successfulConfig = successfulConfig + 1
                        end
                    end
                end,
                game = function()
                    for name, value in pairs(content) do
                        sea.setGameOption(name, value)
                    end
                end,
                player = function()
                    for k, v in pairs(content) do
                        switch(k) {
                            info = function()
                                for name, func in pairs(v) do
                                    if sea.addPlayerInfo(name, func) then
                                        successfulConfig = successfulConfig + 1
                                    end
                                end
                            end,
                            stat = function()
                                for name, v in pairs(v) do
                                    if sea.addPlayerStat(name, v[1], v[2]) then
                                        successfulConfig = successfulConfig + 1
                                    end
                                end
                            end,
                            variable = function()
                                for name, v in pairs(v) do
                                    if sea.addPlayerVariable(name, v[1], v[2]) then
                                        successfulConfig = successfulConfig + 1
                                    end
                                end
                            end,
                            method = function()
                                for name, func in pairs(v) do
                                    if sea.addPlayerMethod(name, func) then
                                        successfulConfig = successfulConfig + 1
                                    end
                                end
                            end,
                            setting = function()
                                for name, v in pairs(v) do
                                    if sea.addPlayerSetting(name, v[1], v[2]) then 
                                        successfulConfig = successfulConfig + 1
                                    end
                                end
                            end,
                            control = function()
                                for name, v in pairs(v) do
                                    if sea.addPlayerControl(name, v[1], v[2]) then
                                        successfulConfig = successfulConfig + 1
                                    end
                                end
                            end
                        }
                    end
                end,
                server = function()
                    for k, v in pairs(content) do
                        switch (k) {
                            info = function()
                                sea.setServerInfo(v)
    
                                successfulConfig = successfulConfig + 1
                            end,
                            news = function()
                                for _, article in pairs(v) do
                                    sea.addServerNews(article)
        
                                    successfulConfig = successfulConfig + 1
                                end
                            end,
                            setting = function()
                                for setting, value in pairs(v) do
                                    if sea.setServerSetting(setting, value) then
                                        successfulConfig = successfulConfig + 1
                                    end
                                end
                            end
                        }
                    end
                end,
                mainMenuTabs = function()
                    for name, buttons in pairs(content) do
                        if sea.addMainMenuTab(name, buttons) then
                            successfulConfig = successfulConfig + 1
                        end
                    end
                end
            }
        end

        app.config, app.path.config = config, configPath
    end

    _G[app.namespace] = {}
    local loadedScripts = 0
    if app.scripts then
        for _, path in ipairs(app.scripts) do
            if sea.loadScript(directory..path) then
                loadedScripts = loadedScripts + 1
            end
        end
    end  
    sea[app.namespace] = _G[app.namespace]
    _G[app.namespace] = nil

    sea.app[app.namespace] = app 

    local version = app.version and " v"..app.version or ""
    local author = app.author and " by "..app.author or ""
    sea.success("Initialized app: "..app.name..version..author.." (namespace: "..app.namespace..", "..transferFiles.." transfer files, "..successfulConfig.." successful configurations, "..loadedScripts.." loaded scripts)")

    return true
end

-------------------------
--     CONFIG FUNCS    --
-------------------------

function sea.setGameOption(name, value)
    local gameOption = sea.config.game

    local temp = gameOption[name]

    gameOption[name] = value

    sea.info("Set game option: "..name)

    if temp then
        sea.warning("The game option "..name.." was already set, setting it to a new value may occur conflicts among apps.")
    end
end

function sea.addColor(name, color)
    local customColor = sea.config.color.custom

    if customColor[name] then
        sea.error("The color "..name.." cannot be added, it already exists.")
        return false
    end

    customColor[name] = color

    sea.info("Added color: "..sea.createText(name, color))

    return true
end

function sea.addPlayerInfo(name, func)
    local playerInfo = sea.config.player.info

    if playerInfo[name] then
        sea.error("The player info "..name.." cannot be added, it already exists.")
        return false
    end

    playerInfo[name] = func

    sea.info("Added player info: "..name)

    return true
end

function sea.addPlayerStat(name, defaultValue, customDisplay)
    local playerStat = sea.config.player.stat

    if playerStat[name] then
        sea.error("The player variable "..name.." cannot be added, it already exists.")
        return false
    end

    playerStat[name] = {defaultValue, customDisplay}

    sea.info("Added player stat: "..name.." (default value: "..defaultValue..(customDisplay and ", has custom display" or "")..")")

    return true
end

function sea.addPlayerVariable(name, defaultValue, isData)
    local playerVariable = sea.config.player.variable

    if playerVariable[name] then
        sea.error("The player variable "..name.." cannot be added, it already exists.")
        return false
    end

    playerVariable[name] = {defaultValue, isData}

    sea.info("Added player variable: "..name.." (default value: "..defaultValue..(isData and ", data" or "")..")")

    return true
end

function sea.addPlayerMethod(name, func)
    local playerMethod = sea.config.player.method

    if playerMethod[name] then
        sea.error("The player method "..name.." cannot be added, it already exists.")
        return false
    end

    playerMethod[name] = func

    sea.info("Added player method: "..name)

    return true
end

function sea.addPlayerSetting(name, defaultValue, values)
    local playerSetting = sea.config.player.setting

    if playerSetting[name] then
        sea.error("The player setting "..name.." cannot be added, it already exists.")
        return false
    end

    playerSetting[name] = {defaultValue, values}

    sea.info("Added player setting: "..name.." (default value: "..defaultValue..", has "..table.count(values).." different values)")

    return true
end

function sea.addPlayerControl(name, defaultKey, isReassignable)
    local playerControl = sea.config.player.control

    if playerControl[name] then
        sea.error("The player control "..name.." cannot be added, it already exists.")
        return false
    end

    playerControl[name] = {defaultKey, isReassignable}

    sea.info("Added player control: "..name.." "..isReassignable and "(reassignable)" or "")

    return true
end

function sea.setServerInfo(article)
    local serverInfo = sea.config.server.info

    serverInfo = article

    sea.info("Set server info: "..article.title)
end

function sea.addServerNews(article)
    local serverNews = sea.config.server.news

    table.insert(serverNews, article)

    sea.info("Added server news: "..article.title)
end

function sea.setServerSetting(setting, value)
    local serverSetting  = sea.config.server.setting

    serverSetting[setting] = value

    sea.game[setting] = value

    sea.info("Set server setting: "..setting.." to "..tostring(value))

    return true
end

function sea.addMainMenuTab(name, buttons)
    local mainMenuTabs = sea.config.mainMenuTabs

    if mainMenuTabs[name] then
        sea.error("The main menu tab "..name.." cannot be added, it already exist.")
        return false
    end
    
    mainMenuTabs[name] = buttons

    sea.info("Added main menu tab: "..name)

    return true
end