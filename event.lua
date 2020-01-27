sea.event = {}

-- Add the missing ones as needed
local hooks = {
    always = {},
    assist = {"player", "player", "player"},
    attack = {"player"},
    attack2 = {"player", 2},
    bombdefuse = {"player"},
    bombexplode = {"player", 2, 3},
    bombplant = {"player", 2, 3},
    ["break"] = {1, 2, "playerOr0"},
    build = {"player", "objectType", 3, 4, 5, "object"}, -- TODO: check if object_id is same everytime
    buildattempt = {"player", "objectType", 3, 4, 5},
    buy = {"player", "itemType"},
    clientdata = {"player", 2, 3, 4},
    clientsetting = {"player", 2, 3, 4},
    collect = {"player", "item", 6},
    connect = {"player"},
    die = {"player", "player", "itemType", 4, 5, "objectOr0"},
    dominate = {"player", 3, 4},
    drop = {"player", "item", 7, 8},
    endround = {1},
    flagcapture = {"player", 3, 4},
    flagtake = {"player", 3, 4},
    flashlight = {"player", 2},
    hit = {"player", "player", "itemType", 4, 5, 6, "objectOr0"},
    hitzone = {"image", "player", "objectOr0", "itemType", 5, 6, 7},
    hostagerescue = {"player", 2, 3},
    httpdata = {1, 2, 3},
    join = {"player"},
    key = {"player", 2, 3},
    kill = {"player", "player", "itemType", 4, 5, "objectOr0", "playerOr0"},
    leave = {"player", 2},
    log = {1},
    mapchange = {1},
    menu = {"player", 2, 3},
    minute = {},
    move = {"player", 2, 3, 4},
    movetile = {"player", 2, 3},
    ms100 = {},
    name = {"player", 2, 3, 4},
    objectdamage = {"object", 2, "playerOr0"},
    objectkill = {"object", "playerOr0"},
    objectupgrade = {"object", "player", 3, 4},
    parse = {1},
    projectile = {"player", "itemType", 3, 4},
    projectile_impact = {"player", "itemType", 3, 4, 5, 6}, -- What is projectile id? (#6)
    radio = {"player", 2},
    rcon = {1, "playerOr0", 3, 4},
    reload = {"player", 2},
    say = {"player", 2},
    sayteam = {"player", 2},
    second = {},
    select = {"player", "itemType", 3},
    serveraction = {"player", 2},
    shieldhit = {"player", "playerOr0", "itemTypeOrSourceType"--[[check this]], 4, 5, 6},
    shutdown = {},
    spawn = {"player"},
    specswitch = {"player", "player"},
    spray = {"player"},
    startround = {1},
    startround_prespawn = {1},
    suicide = {}, -- Its parameters section was empty in cs2d.com/help, it probably has player id as the first parameter
    team = {"player", 2, 3},
    trigger = {1, 2},
    triggerentity = {1, 2},
    turretscan = {"object", 2, 3, 4},
    use = {"player", 2, 3, 4, 5},
    usebutton = {"player", 2, 3},
    vipescape = {"player", 2, 3},
    vote = {"player", 2, 3},
    walkover = {"player", "item", "itemType", 4, 5, 6}
}

parse("debuglua", 0)


parse("debuglua", 1)

-- Change default addhook function