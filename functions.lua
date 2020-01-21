-- Core
sea.getColor = function(name, category)
    return category and sea.config.color[category][name] or sea.config.color.custom[name]
end

sea.createColorText =  function(color)
    return "\169"..(color or sea.getColor("default", "system"))
end

sea.print = function(text, color, prefix, prefixColor)
    print(sea.createColorText(prefixColor).."["..sea.config.systemPrefix.."] "..(prefix and "["..prefix.."] " or "")..sea.createColorText(color)..text)
end

sea.systemPrint = function(text, status)
    sea.print(text, nil, status:upperFirst(), sea.getColor(status, "system"))
end

sea.error = function(text)
    sea.systemPrint(text, "error")
end

sea.warning = function(text)
    sea.systemPrint(text, "warning")
end

sea.info = function(text)
    sea.systemPrint(text, "info")
end

sea.success = function(text)
    sea.systemPrint(text, "success")
end

sea.message = function(player, text, color, prefix, prefixColor)
    text = sea.createColorText(prefixColor)..(prefix and "["..prefix.."] " or "")..sea.createColorText(color)..text
    
    if not player then
        msg(text)
    else
        msg2(player.id, text)
    end
end

sea.notification = function(player, title, text)
    sea.message(player, text, nil, title)
end

sea.help = function(player, text)
    sea.message(player, text)
end

-- Utilities
sea.addCustomColor = function(name, color)
    local customColors = sea.config.color.custom

    if customColors[name] then
        sea.error("\""..name.."\" custom color could not be added, it already exists.")
        return false
    end

    customColors[name] = color

    sea.info("Custom color added: "..sea.createColorText(color).."\""..name.."\"")

    return true
end