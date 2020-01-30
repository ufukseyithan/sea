sea.entity = {}
sea.Entity = class()

function sea.Entity:constructor(x, y)
    self.x = x
    self.y = y
end

function sea.Entity:trigger()
    if self.name then
        parse("trigger", self.name)
    else
        parse("triggerposition", self.x, self.y)
    end
end

function sea.Entity:getExistsAttribute()
    return entity(self.x, self.y, "exists")
end

function sea.Entity:getTypeNameAttribute()
    return entity(self.x, self.y, "typename")
end

function sea.Entity:getTypeIDAttribute()
    return entity(self.x, self.y, "type")
end

function sea.Entity:getNameFieldAttribute()
    return entity(self.x, self.y, "name")
end

function sea.Entity:getTriggerFieldAttribute()
    return entity(self.x, self.y, "trigger")
end

function sea.Entity:getStateAttribute()
    return entity(self.x, self.y, "state")
end

function sea.Entity:getInt0Attribute()
    return entity(self.x, self.y, "int0")
end

function sea.Entity:getStr0Attribute()
    return entity(self.x, self.y, "str0")
end

function sea.Entity:getAistateAttribute()
    return entity(self.x, self.y, "aistate")
end

-------------------------
--        INIT         --
-------------------------

for _, e in pairs(entitylist()) do
    local entity = sea.Entity.new(e.x, e.y)

    table.insert2D(sea.entity, e.x, e.y, entity)
end