sea.event = {}

local hooks = {
    always = {},
    assist = {"player", "player", "player"},
    attack = {"player"},
    attack2 = {"player", true},
    bombdefuse = {"player"},
    bombexplode = {"player", true, true},
    bombplant = {"player", true, true},
    ["break"] = {true, true, "player"},
    build = {"player", "objectType", true, true, true, "object"},
    buildattempt = {"player", "objectType", true, true, true},
    buy = {"player", "itemType"},
    clientdata = {"player", true, true, true},
    clientsetting = {"player", true, true, true},
    collect = {"player", "item", true},
    connect = {"player"},
    die = {"player", "player", "itemType", true, true, "object"},
    dominate = {"player", true, true},
    drop = {"player", "item", true, true},
    endround = {true},
    flagcapture = {"player", true, true},
    flagtake = {"player", true, true},
    flashlight = {"player", true},
    hit = {"player", "player", "itemType", true, true, true, "object"},
    hitzone = {"image", "player", "objec", "itemType", true, true, true},
    hostagerescue = {"player", true, true},
    httpdata = {true, true, true},
    itemfadeout = {"item", "itemType", true, true},
    join = {"player"},
    key = {"player", true, true},
    kill = {"player", "player", "itemType", true, true, "object", "player"},
    leave = {"player", true},
    --log = {true},
    mapchange = {true},
    menu = {"player", true, true},
    minute = {},
    move = {"player", true, true, true},
    movetile = {"player", true, true},
    ms100 = {},
    name = {"player", true, true, true},
    objectdamage = {"object", true, "player"},
    objectkill = {"object", "player"},
    objectupgrade = {"object", "player", true, true},
    parse = {true},
    projectile = {"player", "itemType", true, true},
    projectile_impact = {"player", "itemType", true, true, true, true},
    radio = {"player", true},
    rcon = {true, "player", true, true},
    reload = {"player", true},
    say = {"player", true},
    sayteam = {"player", true},
    second = {},
    select = {"player", "itemType", true},
    serveraction = {"player", true},
    shieldhit = {"player", "player", "itemType", true, true, true},
    shutdown = {},
    spawn = {"player"},
    specswitch = {"player", "player"},
    spray = {"player"},
    startround = {true},
    startround_prespawn = {true},
    suicide = {"player"},
    team = {"player", true, true},
    trigger = {true, true},
    triggerentity = {true, true},
    turretscan = {"object", true, true, true},
    use = {"player", true, true, true, true},
    usebutton = {"player", true, true},
    vipescape = {"player", true, true},
    vote = {"player", true, true},
    walkover = {"player", "item", "itemType", true, true, true}
}

local function createName(action, name)
    return "on"..action:upperFirst()..name:upperFirst()
end

function sea.addEvent(name, func, priority)
    if not sea.event[name] then
        sea.error("Attempted to add event with the invalid name \""..name.."\"")
        return false
    end

    table.insert(sea.event[name], {
        func = func,
        priority = priority or 0
    })

    -- @TODO: Maybe a better info?
    sea.info("Tied function to the event \""..name.."\"")

    return true
end

function sea.callEvent(name, ...)
    if not sea.event[name] then
        sea.error("Attempted to call event with the invalid name \""..name.."\"")
        return
    end
    
    local returnValue

    for _, v in spairs(sea.event[name], function(tbl, a, b) return tbl[b].priority < tbl[a].priority end) do
        returnValue = v.func(...)
    end

    return returnValue or false
end

-- Adding player control events
for name, key in pairs(sea.config.player.control) do
    sea.event[createName("press", name)] = {} 
    sea.event[createName("release", name)] = {} 
end

sea.hook = {}

for name, params in pairs(hooks) do
    sea.event[createName("hook", name)] = {}
    sea.hook[name] = function(...)
        local args = {...}

        if name == "join" then
            sea.Player.create(args[1]):loadData()
        elseif name == "objectkill" then
            sea.Object.remove(args[1])
        elseif name == "build" then
            sea.Object.create(args[6])
        elseif name == "collect" then
            sea.Item.remove(args[2])
        elseif name == "drop" then
            sea.Item.create(args[2])
        elseif name == "itemfadeout" then
            sea.Item.remove(args[2])
        elseif name == "startround_prespawn" then
            -- Clearing object and item tables and regenerating them as they are removed at each round start
            for id in pairs(sea.object) do
                sea.Object.remove(id)
            end
            sea.Object.generate()

            for id in pairs(sea.item) do
                sea.Item.remove(id)
            end
            sea.Item.generate()
        elseif name == "second" then
            for k, v in pairs(sea.Player.get()) do
                v.stat["Time Played"] = v.stat["Time Played"] + 1
            end
        elseif name == "minute" then
            for k, v in pairs(sea.Player.get()) do
                v:saveData()
            end
        end

        for i = 1, #args do
            if type(params[i]) == "string" and args[i] > 0 then
                args[i] = sea[params[i]][args[i]]
            end
        end

        if name == "leave" then
            args[1]:saveData()

            args[1]:destroy()
        elseif name == "key" then
            for k, v in pairs(args[1].control) do
                if v == args[2] then                  
                    return sea.callEvent(createName(args[3] == 1 and "press" or "release", k), args[1])
                end
            end
        elseif name == "die" then
            args[1].stat["Deaths"] = args[1].stat["Deaths"] + 1
        elseif name == "kill" then
            args[1].stat["Kills"] = args[1].stat["Kills"] + 1
        end

        return sea.callEvent(createName("hook", name), unpack(args))
    end
    addhook(name, "sea.hook."..name)
end

function addhook()
    sea.error("addhook is not valid, use sea.addEvent instead.")
end