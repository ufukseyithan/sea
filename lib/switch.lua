Default, Nil = {}, function () end -- for uniqueness
function switch (i)
    return setmetatable({ i }, {
        __call = function (t, cases)
            local item = #t == 0 and Nil or t[1]
            return (cases[item] or cases[Default] or Nil)(item)
        end
    })
end

--[[
    Usage: 
    
    switch(case) {
        [1] = function () print"number 1!" end,
        [2] = math.sin,
        [false] = function (a) return function (b) return (a or b) and not (a and b) end end,
        Default = function (x) print"Look, Mom, I can differentiate types!" end, -- ["Default"] ;)
        [Default] = print,
        [Nil] = function () print"I must've left it in my other jeans." end,
    }
]]