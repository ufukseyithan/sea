local Menu = class()

function Menu:constructor(name, mode)
    self.name = name
    self.mode = mode
    self.buttons = {}
end

function Menu:addButton(name, func, description)
    description = description or (type(func) == "table" and ">")

    table.insert(self.buttons, {
        name = name,
        func = func,
        description = description
    })
end

function Menu:interact(player, index)
    local button = self.buttons[index]
    
    if button then
        if type(button.func) == "table" then
            button.func:show(player)
        else
            button.func(player)
        end
    end
end

function Menu:show(player, page)
    page = page or 1

    local totalPage = math.ceil(table.count(self.buttons) / 9)

    local buttons = {}
    for i = 1, 9 do
        local button = self.buttons[((page - 1) * 9) + i]

        local name, description = "", ""

        if button then
            local disabled = not button.func and true or false

            if button.name then
                name = type(button.name) == "function" and button.name(player) or button.name
            end

            if button.description then
                description = type(button.description) == "function" and button.description(player) or button.description
            end

            if disabled then
                name, description = "("..name, description..")"
            end
        end

        table.insert(buttons, name.."|"..description)
    end

    local mode = ""
    if self.mode == "big" then
        mode = "@b"
    elseif self.mode == "invisible" then
        mode = "@i"
    end

    menu(player.id, self.name.." ("..page.." of "..totalPage..")"..mode..","..table.concat(buttons, ","))
end

return Menu