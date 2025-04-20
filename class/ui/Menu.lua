local Menu = class()

function Menu:constructor(name, mode)
    self.name = name
    self.mode = mode
    self.buttons = {}
    self.staticButton = {}
    self.closeButtonFunc = nil
end

function Menu:addButton(name, func, description, index)
    local button = {
        name = name,
        func = func,
        description = description
    }

    self.buttons[index and index or (#self.buttons + 1)] = button
end

function Menu:addBackButton(parent, index)
    self:addButton("Back", parent, "<", index)
end

function Menu:setStaticButton(index, name, func, description)
    if index < 1 or index > 9 then
        return
    end

    self.staticButton[index] = {
        name = name,
        func = func,
        description = description
    }
end

function Menu:setStaticBackButton(parent, index)
    self:setStaticButton(index or 9, "Back", parent, "<")
end

function Menu:addGap()
    table.insert(self.buttons, false)
end

function Menu:setStatiticGap(index)
    self.staticButton[index] = false
end

function Menu:show(player, page)
    page = page or 1

    local buttonsPerPage = self.buttonsPerPage

    self.totalPage = math.ceil(table.count(self.buttons) / buttonsPerPage)

    local function createButtonString(button)
        local name, description = "", ""

        if button then
            local disabled = not button.func

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

        return name.."|"..description
    end

    local buttons = {}

    -- Static buttons
    for i = 1, 9 do
        local button = self.staticButton[i]
        if button ~= nil then
            buttons[i] = createButtonString(button)
        end
    end

    -- Dynamic buttons
    for i = 1, buttonsPerPage do
        local button = self.buttons[((page - 1) * buttonsPerPage) + i]

        buttons[i] = createButtonString(button)
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
        if self.closeButtonFunc then
            self.closeButtonFunc(player)
        end

        player.currentMenu = {}
        return
    end

    local function interactWithButton(button)
        local func = button.func

        if type(func) == "table" then
            player:displayMenu(func)
        else
            local result = func(player)

            if result == true then
                player:displayMenu(player.currentMenu[1])
            elseif type(result) == "table" then
                player:displayMenu(result)
            else
                player.currentMenu = {}
            end
        end
    end

    local staticButton = self.staticButton[index]
    if staticButton then
        interactWithButton(staticButton)
        return
    end

    local button = self.buttons[((player.currentMenu[2] - 1) * self.buttonsPerPage) + index]
    if button then
        interactWithButton(button)
    end
end

-------------------------
--        CONST        --
-------------------------

function Menu.construct(structure, parent, player)
    local menu = Menu.new(structure.name, "big")

    for _, button in ipairs(type(structure.content) == "function" and structure.content(player) or structure.content) do
        if not button.name then
            menu:addGap()
        else
            local func = button.func
            local description = button.description
            
            if button.structure then
                func = function(player)
                    if button.func then
                        button.func(player)
                    end
                    
                    return Menu.construct(button.structure, menu, player)
                end
    
                if type(description) == "function" then
                    local temp = description
                    description = function(player) return temp(player).." >" end
                else
                    description = description and description.." >" or ">"
                end
            end
    
            menu:addButton(button.name, func, description)
        end
    end

    if parent then
        menu.name = parent.name.." / "..menu.name

        menu:setStaticBackButton(parent)
    end

    return menu
end

-------------------------
--     PROPERTIES     --
-------------------------

function Menu:buttonsPerPageProperty()
    return function(self)
        return 9 - table.count(self.staticButton)
    end
end

-------------------------
--        INIT         --
-------------------------

return Menu