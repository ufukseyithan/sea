sea = {}

sea.version = "0.0.1a"

sea.path = {
    gfx = "gfx/sea-framework/",
    sfx = "sfx/sea-framework/",
    sys = "sys/"
}

sea.app = {}
sea.transferFiles = {}

-- Loading lib
function table.mergeValues(tbl, tbl2)
    for k, v in pairs(tbl2) do 
        table.insert(tbl, v)
    end
end

-- This can be removed if io.isdir gets updated
function io.isDirectory(path)
    path = (path:sub(-1) == "/" or path:sub(-1) == "\\") and path:sub(1, -2) or path
    return io.isdir(path)
end

function io.getPaths(directory)
    local paths = {}

    for file in io.enumdir(directory) do
        if file ~= '.' and file ~= '..' then
            path = directory..file
            path = io.isDirectory(path) and path.."/" or path
 
            table.insert(paths, path)
        end
    end

    return paths
end

function io.getFilePaths(directory, deep)
    local filePaths = {}

    for _, path in pairs(io.getPaths(directory)) do
        if deep and io.isDirectory(path) then
            table.mergeValues(filePaths, io.getFilePaths(path, deep))
        else 
            table.insert(filePaths, path)
        end
    end

    return filePaths
end

function io.getDirectoryPaths(directory, deep)
    local directoryPaths = {}

    for _, path in pairs(io.getPaths(directory)) do
        if io.isDirectory(path) then
            table.insert(directoryPaths, path)

            if deep then
                table.mergeValues(directoryPaths, io.getDirectoryPaths(path, deep))
            end
        end
    end

    return directoryPaths
end

function dofileDirectory(directory, deep)
    for _, filePath in pairs(io.getFilePaths(directory, deep)) do
        if filePath:sub(-4) == ".lua" then
            dofile(filePath)
        end
    end
end

local function getLocalPath()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

sea.path.lua = getLocalPath()

print("[Sea Framework] Loading library...")
sea.path.lib = sea.path.lua.."lib/"
dofileDirectory(sea.path.lib)
print("[Sea Framework] Library has been loaded.")

-- Loading core
print("[Sea Framework] Loading core scripts...")
dofile(sea.path.lua.."functions.lua")
sea.path.config = sea.path.lua.."config.lua"
dofile(sea.path.config)
dofile(sea.path.lua.."event.lua")
sea.success("Core scripts have been loaded.")

-- Loading apps
sea.info("Checking apps...")

sea.path.app = sea.path.lua.."app/"
local appDirectoryPaths = io.getDirectoryPaths(sea.path.app)

if not table.isEmpty(appDirectoryPaths) then
    for _, appDirectoryPath in pairs(appDirectoryPaths) do
        local app

        sea.info("Found app directory: \""..appDirectoryPath.."\", attempting to load...")

        local appPath = appDirectoryPath
        
        local mainScriptPath = appPath.."main.lua"
        if io.exists(mainScriptPath) then
            app = dofile(mainScriptPath)

            -- @TODO: Check if an app with the same name already exits, if so skip it

            local transferFiles = 0
            for pathName, appCustomPath in pairs(app.path) do
                if pathName == "gfx" or pathName == "sfx" then
                    for _, filePath in pairs(io.getFilePaths(appCustomPath, true)) do
                        sea.addTransferFile(filePath)

                        transferFiles = transferFiles + 1
                    end
                end
            end

            local configPath, successConfig, totalConfig = appPath.."config.lua", 0, 0
            if io.exists(configPath) then
                local config = dofile(configPath)

                for category, content in pairs(config) do
                    if category == "color" then
                        for name, color in pairs(content) do
                            sea.addCustomColor(name, color)
                        end
                    elseif category == "player" then
                        for k, v in pairs(content) do
                            if k == "info" then
                                for name, func in pairs(v) do
                                    sea.addPlayerInfo(name, func)
                                end
                            elseif k == "stat" then
                                for name, v in pairs(v) do
                                    sea.addPlayerStat(name, type(v) == "table" and v[1] or v, v[2])
                                end
                            elseif k == "variable" then
                                for name, defaultValue in pairs(v) do
                                    sea.addPlayerVariable(name, defaultValue)
                                end
                            elseif k == "setting" then
                                -- @TODO
                            end
                        end
                    elseif category == "server" then
                        for k, v in pairs(content) do
                            if k == "info" then
                                sea.setServerInfo(v)
                            elseif k == "news" then
                                for _, article in pairs(v) do
                                    sea.addServerNews(article)
                                end
                            elseif k == "setting" then
                                for setting, value in pairs(v) do
                                    sea.setServerSetting(setting, value)
                                end
                            elseif k == "bindings" then
                                for _, key in pairs(v) do
                                    sea.addServerBinding (key)
                                end
                            end
                        end
                    elseif category == "mainMenuTabs" then

                    end
                end

                app.config, app.path.config = config, configPath
            end 

            table.insert(sea.app, app) 

            sea.success("Loaded app: "..app.name.." (v"..app.version..") by "..app.author.." ("..successConfig.."/"..totalConfig.." configurations, "..transferFiles.." transfer files)")
        else
            sea.warning("The app directory \""..appDirectoryPath.."\" does not include \"main.lua\", skipping it...")
        end
    end

    sea.info("Loaded "..#sea.app.."/"..#appDirectoryPaths.." app directories in total.")
    sea.info("Type \"!show_app_info <app_name>\" in console to see the details of an app.")
else
    sea.info("No app directories has been found to load.")
end

sea.produceTransferFile()

-- @TODO: Add system generated bindings (see if it is possible to hide console prints though) (players can also set their bindings too)

-- @TODO: Set server settings according to config

sea.success("Sea Framework v"..sea.version.." has been loaded and is ready to use!")