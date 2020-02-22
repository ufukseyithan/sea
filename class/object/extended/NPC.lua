local NPC = class(sea.Object)

function NPC:constructor(type, x, y, rotation)
    self.id = sea.Object.spawn(30, x, y, rotation, 0, 0, type).id
end

-------------------------
--        INIT         --
-------------------------

return NPC