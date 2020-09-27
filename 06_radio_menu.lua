--local spawnable = require("spawnable_spawnable.lua")
-- requires spawnable_units.lua
-- requires mark_listener.lua

local defaultSound = "l10n/DEFAULT/tsctra00.wav"

local function spawnUnit(group, teleport)
	if ( markPoint and teleport ) then
		if ( group.sound ) then trigger.action.outSound(string.format("l10n/DEFAULT/%s", group.sound))
		else trigger.action.outSound(defaultSound) end
		
		-- Get the correct altitude
		local leadPos = mist.getLeadPos(group.name);
		env.info((markPoint.y))
		markPoint.y = leadPos.y;
		env.info((markPoint.y))
		
		-- Move the group to the right x/z coords
		local spawnVars = {}
		spawnVars.groupName = group.name
		spawnVars.action = 'clone'
		spawnVars.point = markPoint
		spawnVars.route = mist.getGroupRoute(group.name, 'task')
		
		newGroup = mist.teleportToPoint(spawnVars)
		
		-- Drop smoke in the middle of the group
		avgPoint = mist.getAvgGroupPos(newGroup.name)
		trigger.action.smoke({x=avgPoint.x, y=avgPoint.y, z=avgPoint.z}, trigger.smokeColor.Red)
		
		local spawnMsg = {}
		spawnMsg.txt = string.format("Spawned at your mark point: %s", group.description);
		spawnMsg.displayTime = 15
		spawnMsg.msgFor = {coa = {'all'}}
		mist.message.add(spawnMsg)
	
	-- Consider: Instead of this, can we adjust the route to make it relative?
	-- Compare the coords of the original route's first point with the coords of the mark point.
	-- Adjust X and Z for all points along the route by the same offset.
	else
		if ( group.sound ) then trigger.action.outSound(string.format("l10n/DEFAULT/%s", group.sound))
		else trigger.action.outSound(defaultSound) end
		mist.cloneGroup(group.name, true)	
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
local BoatsMenu			= missionCommands.addSubMenu("Boats",SpawnMenu)

-- Third Level: Groups
for key in pairs(spawnable.tankers) 	do missionCommands.addCommand(key, TankerMenu, 			function() spawnUnit(spawnable.tankers[key], false) end) end
for key in pairs(spawnable.armor) 		do missionCommands.addCommand(key, ArmorMenu,  			function() spawnUnit(spawnable.armor[key], true) end) end
for key in pairs(spawnable.infantry)	do missionCommands.addCommand(key, InfantryMenu,  		function() spawnUnit(spawnable.infantry[key], true) end) end
for key in pairs(spawnable.airdefences) do missionCommands.addCommand(key, AirDefenceMenu,  	function() spawnUnit(spawnable.airdefences[key], true) end) end
for key in pairs(spawnable.fighters) 	do missionCommands.addCommand(key, ModernFighterMenu,  	function() spawnUnit(spawnable.fighters[key], true) end) end
for key in pairs(spawnable.warbirds) 	do missionCommands.addCommand(key, WarBirdMenu,  		function() spawnUnit(spawnable.warbirds[key], true) end) end
for key in pairs(spawnable.helicopters)	do missionCommands.addCommand(key, HelicopterMenu,  	function() spawnUnit(spawnable.helicopters[key], true) end) end
for key in pairs(spawnable.boats)		do missionCommands.addCommand(key, BoatsMenu,  			function() spawnUnit(spawnable.boats[key], true) end) end

local loadMsg = {}
loadMsg.text = "06 - Radio Menus Loaded"
loadMsg.displayTime = 30
loadMsg.msgFor = {coa = {'all'}} 
mist.message.add(loadMsg)