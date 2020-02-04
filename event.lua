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
    log = {true},
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
    projectile_impact = {"player", "itemType", true, true, true, "projectile"},
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

function sea.addEvent(name, func, priority)
    if not table.contains(table.getKeys(hooks), name) then
        sea.error("Attempted to add event with the invalid name \""..name.."\"")
        return false
    end

    local event = sea.event[name]

    event = event or {}

    table.insert(event, {
        func = func,
        priority = priority or 0
    })

    return true
end

function sea.callEvent(name, ...)
    if not table.contains(table.getKeys(hooks), name) then
        sea.error("Attempted to call event with the invalid name \""..name.."\"")
        return false
    end
    
    -- @TODO Sort the event table according to the priorities and then use ipairs
end

sea.hook = {}

--parse("debuglua", 0)

for name, params in pairs(hooks) do
    sea.hook[name] = function(...)
        local args = {...}

        if name == "join" then
            sea.Player.create(args[1])
        end

        for i = 1, #args do
            if type(params[i]) == "string" and args[i] > 0 then
                args[i] = sea[params[i]][args[i]]
            end
        end

        if name == "leave" then
            args[1]:destroy()
        elseif name == "buy" and sea.config.game.buy == false then
            args[1]:notify("error", "Buying is not allowed.")

            return 1
        elseif name == "suicide" and sea.config.game.suicide == false then
            args[1]:notify("error", "Suiciding is not allowed.")

            return 1
        elseif name == "say" and sea.config.game.customChat then
            sea.message(0, sea.createText(sea.config.game.customChat(args[1], args[2])))
            
            return 1
        end

        return sea.callEvent(name, unpack(args))
    end
    addhook(name, "sea.hook."..name)
end

--parse("debuglua", 1)

-- Change default addhook function
function addhook()
    sea.error("addhook is not valid, use sea.addEvent instead.")
end