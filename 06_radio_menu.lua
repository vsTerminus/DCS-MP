--local spawnable = require("spawnable_spawnable.lua")
-- requires spawnable_units.lua
-- requires mark_listener.lua

local defaultSound = "l10n/DEFAULT/tsctra00.wav"

local function spawnUnit(group)
	if ( markPoint ) then
		if ( group.sound ) then trigger.action.outSound(string.format("l10n/DEFAULT/%s", group.sound))
		else trigger.action.outSound(defaultSound) end
		
		local spawnVars = {}
		spawnVars.groupName = group.name
		spawnVars.action = 'clone'
		spawnVars.point = markPoint
		mist.teleportToPoint(spawnVars)
		
		local spawnMsg = {}
		spawnMsg.txt = string.format("Spawned at your mark point: %s", group.description);
		spawnMsg.displayTime = 15
		spawnMsg.msgFor = {coa = {'all'}}
		mist.message.add(spawnMsg)
	else
		local failMsg = {}
		failMsg.txt = "Please create and delete a markpoint on the F10 map, then try again."
		failMsg.displayTime = 10
		failMsg.msgFor = {coa = {'all'}}
		mist.message.add(failMsg)
		trigger.action.outSound(string.format("l10n/DEFAULT/taderr01.wav"))
	end
end

-- Radio Top Level Menu
local SpawnMenu			= missionCommands.addSubMenu("Spawn",nil)

-- Second Level: Categories
local TankerMenu 		= missionCommands.addSubMenu("Tankers",SpawnMenu)
local ArmorMenu 		= missionCommands.addSubMenu("Armor",SpawnMenu)
local InfantryMenu		= missionCommands.addSubMenu("Infantry",SpawnMenu)
local AirDefenceMenu	= missionCommands.addSubMenu("Air Defenses",SpawnMenu)
local ModernFighterMenu = missionCommands.addSubMenu("Modern Fighters",SpawnMenu)
local WarBirdMenu		= missionCommands.addSubMenu("Warbirds",SpawnMenu)
local HelicopterMenu	= missionCommands.addSubMenu("Helicopters",SpawnMenu)

-- Third Level: Groups
for key in pairs(spawnable.tankers) 	do missionCommands.addCommand(key, TankerMenu, 			function() spawnUnit(spawnable.tankers[key]) end) end
for key in pairs(spawnable.armor) 		do missionCommands.addCommand(key, ArmorMenu,  			function() spawnUnit(spawnable.armor[key]) end) end
for key in pairs(spawnable.infantry)	do missionCommands.addCommand(key, InfantryMenu,  		function() spawnUnit(spawnable.infantry[key]) end) end
for key in pairs(spawnable.airdefences) do missionCommands.addCommand(key, AirDefenceMenu,  	function() spawnUnit(spawnable.airdefences[key]) end) end
for key in pairs(spawnable.fighters) 	do missionCommands.addCommand(key, ModernFighterMenu,  	function() spawnUnit(spawnable.fighters[key]) end) end
for key in pairs(spawnable.warbirds) 	do missionCommands.addCommand(key, WarBirdMenu,  		function() spawnUnit(spawnable.warbirds[key]) end) end
for key in pairs(spawnable.helicopters)	do missionCommands.addCommand(key, HelicopterMenu,  	function() spawnUnit(spawnable.helicopters[key]) end) end

local loadMsg = {}
loadMsg.text = "06 - Radio Menus Loaded"
loadMsg.displayTime = 30
loadMsg.msgFor = {coa = {'all'}} 
mist.message.add(loadMsg)