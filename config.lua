local config = {}

config.printPrefix = "Sea Framework"

-- Do not remove the existing ones, you may add or change (not recommended)
config.color = {
    system = {
        error = "255000000",
        warning = "255255100",
        info = "100255255",

        default = "255255255"
    },
    
    player = {
        spec = "255220000",
		ct = "050150255",
		t = "255025000",
		tdm = "000255000"
    }
}

return config