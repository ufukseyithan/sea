sea = {}

sea.version = "0.0.1a"

sea.path = {
    gfx = "gfx/sea-framework/",
    sfx = "sfx/sea-framework/"
}

-- Loading lib
function table.merge(table, table2)
    for k, v in pairs(table) do 
        table2[k] = v 
    end
end

io.isDirectory = io.isdir

function io.getFiles(path, deep)
    local files = {}

    for file in io.enumdir(path) do
        if file ~= '.' and file ~= '..' then
            if deep and io.isDirectory(file) then
                table.merge(files, io.getFiles(path, deep))
            else 
                table.insert(files, file)
            end
        end
    end

    return files
end

function dofileDirectory(directory, deep)
    if io.isDirectory(directory) then return end

    for _, file in pairs(io.getFiles(directory, deep)) do
        if file:sub(-4) == ".lua" then
            dofile(directory..file)
        end
    end
end

local function getLocalPath()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

sea.path.lua = getLocalPath()

sea.path.lib = sea.path.lua.."lib/"
dofileDirectory(sea.path.lib)

-- Loading core
sea.path.config = sea.path.lua.."config.lua"
dofile(sea.path.config)
dofile(sea.path.lua.."functions.lua")
dofile(sea.path.lua.."event.lua")

sea.success("Core is loaded.")

-- Loading apps
sea.app = {}

sea.info("Checking apps...")

sea.path.app = sea.path.lua.."app/"
local appDirectories = io.getFiles(sea.path.app)

if not table.isEmpty(appDirectories) then
    for _, appDirectory in pairs(appDirectories) do
        local app

        sea.info("Found app directory: \""..appDirectory.."\", attempting to load...")

        local appPath = sea.path.app..appDirectory.."/"
        
        local mainScriptPath = appPath.."main.lua"
        if io.exists(mainScriptPath) then
            print(mainScriptPath)
            app = dofile(mainScriptPath)

            local configPath = appPath.."config.lua"
            if io.exists(configPath) then
                app.config = dofile(configPath)
            end 

            table.insert(sea.app, app) 

            sea.success("Loaded app: "..app.name.." (v"..app.version..") by "..app.author..".")
        else
            sea.warning("App directory \""..appDirectory.."\" does not have \"main.lua\", skipping it...")
        end
    end

    sea.info("Loaded "..#sea.app.."/"..#appDirectories.." app directories in total.")
else
    sea.info("No app directories found to load.")
end

-- @TODO: Set server settings according to config

sea.success("Sea Framework v"..sea.version.." is loaded and ready to use!")