**Warning:** This repository may not have the common structure most repositories have. Meaning it would be rational not to treat this repository in a typical way.

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

### Game Setting


### Player
#### *info*
`sea.config.player.info` contains the information that the player can see in their main menu. The key of the entry should be the name of the info, and the value should be a function (has player object parameter) returning how and what it displays in the menu.
```lua
["Progress"] = function(player) return "Your rank is "..player.rank end
```
#### *stat*
`sea.config.player.stat`, as you can tell, are the statistics of the player which can be seen in their main menu just like the information. The key of the entry should be the name of the statistic, and the value should be a table containing the default value (start value) and optionally a function (has stat's value parameter) that returns how it is displayed.
```lua
["Money Spent"] = {0, function(value) return value.."$" end}
```
#### *variable*
`sea.config.player.variable` are the custom variables of the player, anything that would not make sense to into other categories should be inserted here. For instance, inventory, rank, XP and such. The key of the entry should be the variable name and the value should be a table containing the default value (start value) and optionally a boolean value which if it is true, it will be treated as a data to be saved every minute and when the player leaves the server. The player variables will be included in the player objects, so you can get them using `player.rank` for example.
```lua
rank = {1, true}
```
#### *preference*
`sea.config.player.preference` contains the preferences that the player can change as they wish using the main menu. The key of the entry should be the name of the preference, and the value should be a table containing the default value and the options in a table that are available to the player. The option table has to contain the default value, meaning the default value has to be one of the options in the option table.
```lua
["Passive Mode"] = {"On", {"On", "Off"}}
```
#### *control*
`sea.config.player.control` contains the controls which trigger events when the player presses and releases the specified key binding. Controls can be configured in order their default key bindings not to be changed later on by players using the main menu. The key of the entry should be the name of the control (later to be used like "onPressControlName" as an event), and the value should be a table containing the default key binding and optionally a boolean value which if it is true, the player can change the key binding as they wish in-game.
```lua
["Fire"] = {"mouse1", true}
```
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

## Functions
This framework contains lots of functions, from familiar ones to completely new ones that would assist you in nearly every usual scenario. 

### Library Functions
These are the most common functions, the ones that you must have probably encountered and even used before. While some of them are only extensions to the `string`, `table` and `io` Lua libraries, the others consist of "utility functions" such as `getDirection()`, `deepcopy()`, `getDistance()`, and even an improved version of `parse()`, you name it.

### General Functions
These are the ones Sea Framework provides. They are included in the namespace `sea`. You may not use these directly in your apps and scripts, generally the system uses them for its own usage.

## Classes
This framework contains numerous classes to make OOP possible. All of them are in the namespace `sea`.

### Data
#### ItemType
#### ObjectType

### Entity
#### Item
#### Player
#### Object
#### Image
#### Projectile (not used)

### UI Related
#### UI
#### Menu
#### Element
#### Panel
#### Text

### Other
#### Map
#### Game

### Misc
#### Color



