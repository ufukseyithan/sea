function sea.getColor(name, category)
    local colorConfig = sea.config.color

    return category and colorConfig[category][name] or colorConfig.custom[name]
end

function sea.getTeamColor(team)
    return sea.getColor(team, "team")
end

function sea.createColoredText(text, color)
    color = color or sea.getColor("default", "system")

    return "©"..tostring(color)..text
end

function sea.createEventName(action, name)
    return "on"..action:upperFirst()..name:upperFirst()
end

function sea.createControlEventName(name)
    sea.event[sea.createEventName("press", name:toPascalCase(" "))] = {} 
    sea.event[sea.createEventName("release", name:toPascalCase(" "))] = {} 
end

function sea.print(type, text)
    if not sea.config.debug then 
        return
    end

    print(sea.Message.new(text, sea.Color.white, sea.config.printTagPrefix.." "..type:upperFirst(), sea.getColor(type, "system")))
end

function sea.error(text)
    sea.print("error", text)
end

function sea.warning(text)
    sea.print("warning", text)
end

function sea.info(text)
    sea.print("info", text)
end

function sea.success(text)
    sea.print("success", text)
end

function sea.message(id, text, color, tag, tagColor)
    local text = tostring(sea.Message.new(text, color, tag, tagColor))

    if not id or id == 0 then
        msg(text)
    else
        msg2(id, text)
    end

    return text
end

function sea.playSound(id, path, x, y)
    if x then
        parse("sv_soundpos", path, x, y, id)
    else
        if not id or id == 0 then
            parse("sv_sound2", id, path)
        else
            parse("sv_sound", path)
        end
    end
end

function sea.consoleMessage(id, text, color, tag, tagColor)
    local text = tostring(sea.Message.new(text, color, tag, tagColor))

    if not id or id == 0 then
        parse("cmsg", text)
    else
        parse("cmsg", text, id)
    end

    return text
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
        sea.error("The script \""..path.."\" cannot be loaded, it does not exist.")
        return false
    end

    dofile(path)

    sea.success("Loaded script: \""..path.."\"")

    return true
end

function sea.addTransferFile(path, response, update)
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

    -- Getting the size of the file
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

    if update then
        sea.updateServerTransferList()
    end

	return true
end

function sea.updateServerTransferList(response)
    local serverTransferListPath = sea.path.sys.."servertransfer.lst"
    local transferFiles = sea.transferFiles

    io.toTable(serverTransferListPath, sea.transferFiles)

    sea.transferFiles = table.removeDuplicates(sea.transferFiles)

    -- Remove files that do not exist
    for k, v in pairs(sea.transferFiles) do
        if not io.exists(v) then
            -- Do not use table.remove() here
            sea.transferFiles[k] = nil
        end
    end
    
    local addedFiles = 0
    local file = io.open(serverTransferListPath, "w+") or io.tmpfile()
	for k, v in pairs(sea.transferFiles) do
		file:write(v.."\n")
		
        addedFiles = addedFiles + 1

        if response then
			sea.info("The file \""..v.."\" has been added to the server transfer list.")
        end
	end
    file:close()

    if addedFiles > 0 then
		sea.warning("The server transfer list has been updated with "..addedFiles.." entries. You may need to restart the server in order to get use of it.")
	end
end

function sea.initApp(directory)
    local mainPath = directory.."main.lua"
    if not io.exists(mainPath) then
        sea.error("The app directory \""..directory.."\" cannot be initialized, it does not include main.lua.")
        return false
    end

    local app = dofile(mainPath)

    if not app.namespace then
        sea.error("The app directory \""..directory.."\" cannot be initialized, namespace is not defined in the main.lua.")
        return false
    end

    local isDisabled = app.disabled or directory:find(".disabled")
    if isDisabled then
        sea.warning("The app "..app.name.." is not initialized as it is disabled.")
        return false
    end

    if sea.app[app.namespace] then
        sea.error("The app with the namespace "..app.namespace.." cannot be initialized, it already exists.")
        return false
    end

    app.path = app.path or {}
    
    local transferFiles = 0
    for pathName, appCustomPath in pairs(app.path) do
        if pathName == "gfx" or pathName == "sfx" then
            for _, filePath in pairs(io.getFilePaths(appCustomPath, true)) do
                sea.addTransferFile(filePath)

                transferFiles = transferFiles + 1
            end
        end
    end

    _G[app.namespace] = {}

    local configPath, successfulConfig = directory.."config.lua", 0
    if io.exists(configPath) then
        local config = dofile(configPath)

        if config then
            for category, content in pairs(config) do
                switch (category) {
                    color = function()
                        for name, color in pairs(content) do
                            if sea.addColor(name, color) then
                                successfulConfig = successfulConfig + 1
                            end
                        end
                    end,
                    gameSetting = function()
                        for setting, value in pairs(content) do
                            sea.setGameSetting(setting, value)

                            successfulConfig = successfulConfig + 1
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
                                preference = function()
                                    for name, v in pairs(v) do
                                        if sea.addPlayerPreference(name, v[1], v[2], v[3]) then 
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
                                        sea.setServerSetting(setting, value)

                                        successfulConfig = successfulConfig + 1
                                    end
                                end
                            }
                        end
                    end,
                    mainMenuButtons = function()
                        for _, button in pairs(content) do
                            sea.addMainMenuButton(button)
                                
                            successfulConfig = successfulConfig + 1
                        end
                    end
                }
            end

            app.config = config
        end

        app.path.config = config
    end

    local loadedScripts = 0
    if app.scripts then
        for _, path in ipairs(app.scripts) do
            if sea.loadScript(directory..path) then
                loadedScripts = loadedScripts + 1
            end
        end
    end  
    sea[app.namespace] = _G[app.namespace]

    sea.app[app.namespace] = app 

    local version = app.version and " v"..app.version or ""
    local author = app.author and " by "..app.author or ""
    sea.success("Initialized app: "..app.name..version..author.." (namespace: "..app.namespace..", "..transferFiles.." transfer files, "..successfulConfig.." successful configurations, "..loadedScripts.." loaded scripts)")

    return true
end

-------------------------
--     CONFIG FUNCS    --
-------------------------

function sea.addColor(name, color)
    local customColor = sea.config.color.custom

    if customColor[name] then
        sea.error("The color "..name.." cannot be added, it already exists.")
        return false
    end

    customColor[name] = color

    sea.success("Added color: "..sea.createColoredText(name, color))

    return true
end

function sea.setGameSetting(setting, value)
    local gameSetting = sea.config.gameSetting

    gameSetting[setting] = value

    sea.info("Set game setting: "..setting.." to "..tostring(value))
end

function sea.addPlayerInfo(name, func)
    local playerInfo = sea.config.player.info

    if playerInfo[name] then
        sea.error("The player info "..name.." cannot be added, it already exists.")
        return false
    end

    playerInfo[name] = func

    sea.success("Added player info: "..name)

    return true
end

function sea.addPlayerStat(name, defaultValue, customDisplay)
    local playerStat = sea.config.player.stat

    if playerStat[name] then
        sea.error("The player variable "..name.." cannot be added, it already exists.")
        return false
    end

    playerStat[name] = {defaultValue, customDisplay}

    sea.success("Added player stat: "..name.." (default value: "..tostring(defaultValue)..(customDisplay and ", has custom display" or "")..")")

    return true
end

function sea.addPlayerVariable(name, defaultValue, data)
    local playerVariable = sea.config.player.variable

    if playerVariable[name] then
        sea.error("The player variable "..name.." cannot be added, it already exists.")
        return false
    end

    playerVariable[name] = {defaultValue, data}

    sea.success("Added player variable: "..name.." (default value: "..tostring(defaultValue)..(data and ", data" or "")..")")

    return true
end

function sea.addPlayerPreference(name, defaultValue, values, description)
    local playerPreference = sea.config.player.preference

    if playerPreference[name] then
        sea.error("The player preference "..name.." cannot be added, it already exists.")
        return false
    end

    playerPreference[name] = {defaultValue, values, description}

    sea.success("Added player preference: "..name.." (default value: "..tostring(defaultValue)..", has "..table.count(values).." different values)")

    return true
end

function sea.addPlayerControl(name, defaultKey, isReassignable)
    local playerControl = sea.config.player.control

    if playerControl[name] then
        sea.error("The player control "..name.." cannot be added, it already exists.")
        return false
    end

    playerControl[name] = {defaultKey, isReassignable}

    sea.createControlEventName(name)

    sea.success("Added player control: "..name.." "..(isReassignable and "(reassignable)" or ""))

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
end

function sea.addMainMenuButton(button)
    table.insert(sea.config.mainMenuStructure.content, {
        name = button.name,
        func = button.func,
        structure = button.structure,
        description = button.description
    })

    sea.info("Added main menu button: "..button.name)
end