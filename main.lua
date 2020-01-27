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

print("[Sea Framework] Loading library...")
sea.path.lib = sea.path.lua.."lib/"
dofileDirectory(sea.path.lib, ".lua")
print("[Sea Framework] Library has been loaded.")

-- Loading core
print("[Sea Framework] Loading core scripts...")
dofile(sea.path.lua.."functions.lua")
sea.path.config = sea.path.lua.."config.lua"
dofile(sea.path.config)
dofile(sea.path.lua.."event.lua")
sea.success("Core scripts have been loaded.")

-- Loading apps
sea.info("Checking app directories...")
sea.path.app = sea.path.lua.."app/"
local appDirectoryPaths = io.getDirectoryPaths(sea.path.app)

if not table.isEmpty(appDirectoryPaths) then
    for _, appDirectoryPath in pairs(appDirectoryPaths) do
        sea.info("Found app directory: \""..appDirectoryPath.."\", attempting to initialize...")

        sea.initApp(appDirectoryPath)
    end

    sea.info("Loaded "..#sea.app.."/"..#appDirectoryPaths.." app directories in total.")
    sea.info("Type \"!app_info <app_name>\" in console to see the details of an app.")
else
    sea.info("No app directories have been found to load.")
end

sea.updateServerTransferList()

-- @TODO: Add system generated bindings (see if it is possible to hide console prints though) (players can also set their bindings too)

-- @TODO: Set server settings according to config

sea.success("Sea Framework v"..sea.version.." has been loaded and is ready to use!")