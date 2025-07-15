sea = {}

sea.version = "1.0.0"

sea.path = {
    gfx = "gfx/sea-framework/",
    sfx = "sfx/sea-framework/",
    sys = "sys/"
}

sea.app = {}
sea.transferFiles = {}

-------------------------
--         LIB         --
-------------------------

function table.mergeValues(tbl, tbl2)
    for k, v in pairs(tbl2) do 
        table.insert(tbl, v)
    end
end

function io.isDirectory(path)
    -- This can be removed if io.isdir gets updated
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

function dofileDirectory(directory, formats, deep)
    formats = formats or ".lua"

    for _, filePath in pairs(io.getFilePaths(directory, deep)) do
        if type(formats) == "table" then
            for _, format in pairs(formats) do
                if filePath:sub(-4) == format then
                    dofile(filePath)
                end
            end
        elseif filePath:sub(-4) == formats then
            dofile(filePath)
        end
    end
end

local function getLocalPath()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

sea.path.lua = getLocalPath()

print("[Sea] Loading library...")

sea.path.lib = sea.path.lua.."lib/"
dofileDirectory(sea.path.lib, ".lua")

print("[Sea] Library has been loaded.")

-------------------------
--         CORE        --
-------------------------

print("[Sea] Loading core...")

sea.path.data = sea.path.lua.."data/"

require(sea.path.lua.."functions")

sea.path.class = sea.path.lua.."class/"
sea.initClassDirectory(sea.path.class)

sea.path.config = sea.path.lua.."config.lua"
dofile(sea.path.config)

require(sea.path.lua.."event")

sea.success("Core has been loaded.")

-------------------------
--         INIT        --
-------------------------

sea.game = sea.Game.new()
sea.map = sea.Map.new()

sea.Item.generate()
sea.Object.generate()

sea.info("Checking app directories...")

sea.path.app = sea.path.lua.."app/"
local appDirectoryPaths = io.getDirectoryPaths(sea.path.app)
if not table.isEmpty(appDirectoryPaths) then
    -- @TODO: Priorities for loading apps?..
    for _, appDirectoryPath in pairs(appDirectoryPaths) do
        sea.info("Found app directory: \""..appDirectoryPath.."\", attempting to initialize...")

        sea.initApp(appDirectoryPath)
    end

    sea.info("Initialized "..table.count(sea.app).."/"..table.count(appDirectoryPaths).." app directories in total.")
else
    sea.info("No app directories have been found to initialize.")
end

sea.info("Putting the final touches...")

-- Add sea-framework gfx and sfx to the server transfer list
for pathName, appCustomPath in pairs(sea.path) do
    if pathName == "gfx" or pathName == "sfx" then
        for _, filePath in pairs(io.getFilePaths(appCustomPath, true)) do
            sea.addTransferFile(filePath)
        end
    end
end

sea.updateServerTransferList()

sea.game:load()

-- Adding default control key bindings
for _, v in pairs(sea.config.player.control) do
    addbind(v[1])
end

-- Creating main menu
sea.mainMenu = sea.Menu.construct(sea.config.mainMenuStructure)

sea.listen("keyMouseScrollUpPressed", function(player)
    if player:viewsMenu() then
        if player.currentMenu[2] > 1 then 
            player:displayMenu(player.currentMenu[1], player.currentMenu[2] - 1)
        end
    end
end, -100)

sea.listen("keyMouseScrollDownPressed", function(player)
    if player:viewsMenu() then
        if player.currentMenu[2] < player.currentMenu[1].totalPage then
            player:displayMenu(player.currentMenu[1], player.currentMenu[2] + 1)
        end
    end
end, -100)

sea.success("Sea v"..sea.version.." is up and running!")