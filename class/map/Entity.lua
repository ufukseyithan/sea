sea.entity = {}
local Entity = class()

function Entity:constructor(x, y)
    self.x = x
    self.y = y
end

function Entity:trigger(name)
    if name and self.name then
        parse("trigger", self.name)
    else
        parse("triggerposition", self.x, self.y)
    end
end

-------------------------
--        CONST        --
-------------------------

function Entity.get(x, y)
    return sea.entity[x] and sea.entity[x][y]
end


-------------------------
--       GETTERS       --
-------------------------

function Entity:getExistsAttribute()
    return entity(self.x, self.y, "exists")
end

function Entity:getTypeNameAttribute()
    return entity(self.x, self.y, "typename")
end

function Entity:getTypeIDAttribute()
    return entity(self.x, self.y, "type")
end

function Entity:getNameFieldAttribute()
    return entity(self.x, self.y, "name")
end

function Entity:getTriggerFieldAttribute()
    return entity(self.x, self.y, "trigger")
end

function Entity:getStateAttribute()
    return entity(self.x, self.y, "state")
end

function Entity:getInt0Attribute()
    return entity(self.x, self.y, "int0")
end

function Entity:getStr0Attribute()
    return entity(self.x, self.y, "str0")
end

function Entity:getAistateAttribute()
    return entity(self.x, self.y, "aistate")
end

-------------------------
--        INIT         --
-------------------------

return Entity