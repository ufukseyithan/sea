Default, Nil = {}, function () end -- for uniqueness
function switch (i)
    return setmetatable({ i }, {
        __call = function (t, cases)
            local item = #t == 0 and Nil or t[1]
            return (cases[item] or cases[Default] or Nil)(item)
        end
    })
end
