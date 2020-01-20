sea.getColor = function(category, name)
    return sea.config.color[category][name]
end

sea.createColorText =  function(color)
    return "\169"..(color or sea.getColor("system", "default"))
end

sea.print = function(text, color, prefix, prefixColor)
    print(sea.createColorText(prefixColor).."["..sea.config.printPrefix.."] "..(prefix and "["..prefix.."] " or "")..sea.createColorText(color)..text)
end

sea.error = function(text)
    sea.print(text, nil, "Error", sea.getColor("system", "error"))
end

sea.warning = function(text)
    sea.print(text, nil, "Warning", sea.getColor("system", "warning"))
end

sea.info = function(text)
    sea.print(text, nil, "Info", sea.getColor("system", "info"))
end

sea.message = function(id, text, color, prefix, prefixColor)
    text = sea.createColorText(prefixColor)..(prefix and "["..prefix.."] " or "")..sea.createColorText(color)..text
    
    if id == 0 then
        msg(text)
    else
        msg2(id, text)
    end
end
