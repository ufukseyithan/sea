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
    kill = {}
}

parse("debuglua", 0)


parse("debuglua", 1)

-- Change default addhook function