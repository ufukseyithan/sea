sea.config = {}

sea.config.serverName = "CS2D Server"

sea.config.systemPrefix = "Sea Framework"

-- Do not remove the existing ones, you may add or change (not recommended)
sea.config.color = {
    system = {
        error = "255000000",
        warning = "255255100",
        info = "100255255",
        success = "100255100",

        default = "255255255"
    },
    
    player = {
        spec = "255220000",
		ct = "050150255",
		t = "255025000",
		tdm = "000255000"
    },

    custom = {}
}

-- News will be displayed in the main menu
sea.config.news = {
    {
        title = "-10% Discount to SMGs",
        content = "-10% Discount to SMGs until this Monday, make sure to buy a few of them to keep them for hard times. You dig?"
    }
}