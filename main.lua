sea = {}

sea.VERSION = "0.1"

sea.DIR = "sys/lua/sea-framework/"

function dofileDir(dir, deep)
    for _, v in io.enumdir(dir) do
        if not v then
            v = _
        end
        if v:sub(-4) == '.lua' then
            dofile(dir .. v)
        elseif deep and v:sub(1, 1) ~= '.' then
            dofileDir(dir .. v .. '/', deep)
        end
    end
end

sea.config = dofile(sea.DIR.."config.lua")

dofileDir(sea.DIR.."lib/")

dofile(sea.DIR.."functions.lua")

sea.event = dofile(sea.DIR.."event.lua")

sea.info("Sea Framework v"..sea.VERSION.." is successfully loaded!")