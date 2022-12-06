local Menu = class()

--local function - function and function() or name

function Menu:constructor(name, mode)
    self.name = name
    self.mode = mode
    self.buttons = {}
end

function Menu:addButton(name, func, description)
    table.insert(self.buttons, {
        name = name,
        func = func,
        description = description
    })
end

function Menu:addGap()
    table.insert(self.buttons, false)
end

function Menu:show(player, page)
    page = page or 1

    self.totalPage = math.ceil(table.count(self.buttons) / 9)

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

    local pageLabel = ""
    if self.totalPage > 1 then
        pageLabel = " ("..page.." of "..self.totalPage..")"
    end

    menu(player.id, self.name..pageLabel..mode..","..table.concat(buttons, ","))
end

function Menu:interact(player, index)
    if index == 0 then
        player.currentMenu = {}
        return
    end

    local button = self.buttons[((player.currentMenu[2] - 1) * 9) + index]
    
    if button then
        if type(button.func) == "table" then
            player:displayMenu(button.func)
        else
            if button.func(player) == true then
                player:displayMenu(player.currentMenu[1])
            end
        end
    end
end

-------------------------
--        CONST        --
-------------------------

function Menu.construct(structure, parent) 
    local menu = Menu.new(structure.name, "big")

    for _, button in ipairs(type(structure.content) == "function" and structure.content() or structure.content) do
        if button.structure then
            menu:addButton(button.name, Menu.construct(button.structure, menu), button.description or ">")
        else
            menu:addButton(button.name, button.func, button.description)
        end
    end

    if parent then
        menu.name = parent.name.." / "..menu.name

        menu:addButton("Back", function(player)
            player:displayMenu(parent) 
        end, "<")
    end

    return menu
end

-------------------------
--        INIT         --
-------------------------

return Menu