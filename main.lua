sea = {}

sea.version = "0.0.1a"

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

function dofileDirectory(directory, formats, deep)
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

print("[Sea] Loading core scripts...")
dofile(sea.path.lua.."functions.lua")
sea.path.config = sea.path.lua.."config.lua"
dofile(sea.path.config)
dofile(sea.path.lua.."event.lua")

--[[
    This function is for tables that contain objects (for example: sea.Player.get(), sea.Item.get())

    @TODO: A better name is kinda needed in here
]]
function allObjectsMetaTable(tbl)
    return setmetatable(tbl, {
		__index = function(tbl, key)
			for k, v in pairs(tbl) do
				return v[key]
			end
		end,	
		__newindex = function(tbl, key, value)
			for k, v in pairs(tbl) do
				v[key] = value
			end
		end
	})
end

--[[
    sea.game
    sea.Game

    sea.item
    sea.Item
    sea.itemType
    sea.ItemType
    sea.projectile
    sea.Projectile

    sea.entity
    sea.Entity
    sea.map
    sea.Map
    sea.tile
    sea.Tile

    sea.image
    sea.Image
    sea.object
    sea.Object
    sea.objectType
    sea.ObjectType

    sea.player
    sea.Player
]]

sea.path.src = sea.path.lua.."src/"
dofileDirectory(sea.path.src, ".lua", true)
sea.success("Core scripts have been loaded.")

sea.map = sea.Map:new()
sea.game = sea.Game:new()

-------------------------
--         APPS        --
-------------------------

sea.info("Checking app directories...")
sea.path.app = sea.path.lua.."app/"
local appDirectoryPaths = io.getDirectoryPaths(sea.path.app)

if not table.isEmpty(appDirectoryPaths) then
    for _, appDirectoryPath in pairs(appDirectoryPaths) do
        sea.info("Found app directory: \""..appDirectoryPath.."\", attempting to initialize...")

        sea.initApp(appDirectoryPath)
    end

    sea.info("Initialized "..table.count(sea.app).."/"..table.count(appDirectoryPaths).." app directories in total.")
    sea.info("Type \"app info <app name>\" in console to see the details of an app.")
else
    sea.info("No app directories have been found to initialize.")
end

-------------------------
--         INIT        --
-------------------------

sea.updateServerTransferList()

-- Adding custom player methods
for name, func in pairs(sea.config.player.method) do
    sea.Player[name] = func
end

-- Adding default control key bindings
for _, v in pairs(sea.config.player.control) do
    addbind(v[1])
end

sea.success("Sea Framework v"..sea.version.." has been loaded and is ready to use!")