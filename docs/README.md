**Warning:** This repository may not have the common structure most repositories have. Meaning it would be rational not to treat this repository in a typical way. While the root contains the main code for the framework to initialize, `src` folder contains the classes.

## Installation
### Prerequisites
- [This .rar file](https://drive.google.com/file/d/1EMIctNNLyLCj5evG6EyggphmpHiX0gT3/view?usp=sharing) that contains necessarry assets to be extracted into the CS2D directory
- *stats* (located at Create Server > More Settings) to be set to 0

After performing the prerequisites above, put all the files in the repository into `sys/lua/sea-framework/` and done!

## Configuration
This part is kind of a big one. You can configure lots of things and not only small things.

First of all, while you can manually configure in `config.lua`, every app individually can touch these configurations with their own `config.lua` located in their directory.

### System related
`sea.config.systemPrefix` defines the prefix of the console outputs.

`sea.config.supportedTransferFileFormats` defines the formats which are supported in the process of adding new transfer files. These are, in default, the ones that CS2D supports, so it does not make sense to add new ones (or even remove the existing ones).

`sea.config.color.system` & `sea.config.color.team` are not recommended to be touched. You can fill `sea.config.color.custom` manually by yourself or with `sea.addColor`. When apps attempt to insert new colors as config, they will be inserted into `custom` table.

### Player
`sea.config.player.info` contains the information that the player can see in their main menu. The key of the entry should be the name of the info, and value should be a function (has player object parameter) returning how and what it displays in the menu.

`sea.config.player.stat`, as you can tell, are the statistics of the player which can be seen in their main menu just like the information. The key of the entry should be the name of the statistic, and value should be a table containing the default value (start value) and optionally a function (has stat's value parameter) that returns how it is displayed.

`sea.config.player.variable` are the custom variables of the player, anything that would not make sense to into other categories should be inserted here. For instance, inventory, level, XP and such. The key of the entry should be the variable name and the value should be a table containing the default value (start value) and optionally a boolean value which if it is true, it will be treated as a data to be saved every minute and when the player leaves the server. The player variables will be included in the player objects, so you can get them using `player.level` for example.

`sea.config.player.method` are the custom functions that are included in the player objects.

## Events
This framework replaces `addhook` function with `sea.addEvent` which is not only for hooks but also key controls. Meaning you do not need to use "key" hook.

`sea.addEvent` takes three parameters:
* Event name
* The function you want to tie to the event
* Priority

Event names might be different than you think. If you want to add a hook, you would basically go such as "onHookStartround", "onHookJoin", "onHookKill" and so on. Or, to tie a event to a key upon press; "onPressSpace", "onPressMyControl", or upon release; "onReleaseSpace", "onReleaseControlName". However, in order key controls to work, the player controls should be configured accordingly.

## Apps
### Creating app

#### Creating main.lua

#### Creating config.lua
