--local spawnable = require("spawnable_spawnable.lua")
-- requires spawnable_units.lua
-- requires mark_listener.lua

local defaultSound = "tsctra00.wav"

local function dumper(var)

	for k,v in pairs(var) do
		env.info((k))
		if type(v) == 'table' then dumper(v) else env.info((k)) end
	end

end

local function spawnUnit(args)

	local group = args.group
	local action = args.action -- Accepted actions are clone, teleport, respawn

	-- If we have a markpoint, we can spawn units there instead of ME coords.
	if ( markPoint.x ) then
		-- Get the correct altitude
		local leadPos = mist.getLeadPos(group.name);
		env.info((markPoint.y))
		markPoint.y = leadPos.y;
		env.info((markPoint.y))
		
		-- Move the group to the right x/z coords
		local spawnVars = {}
		spawnVars.groupName = group.name
		spawnVars.action = action
		spawnVars.point = markPoint
		spawnVars.route = mist.getGroupRoute(group.name, true)
		dumper(spawnVars.route)
		
		newGroup = mist.teleportToPoint(spawnVars)
		
		-- Drop smoke in the middle of the group
		avgPoint = mist.getAvgGroupPos(newGroup.name)
		trigger.action.smoke({x=avgPoint.x, y=avgPoint.y, z=avgPoint.z}, trigger.smokeColor.Red)
	
	else -- If no mark point defined (yet), just respawn the group at ME coords.
		mist.respawnGroup(group.name, true)	
	end
	
	-- Tell the user exactly what spawned
	local msg = {}
	msg.text = group.description
	msg.displayTime = 15
	msg.msgFor = {coa = {'all'}}
	if ( group.sound ) then msg.sound = group.sound else msg.sound = defaultSound end
	mist.message.add(msg)
	
end

-- Note: Re-do this so that it can build the radio menu structure 100% dynamically based on the units table structure.
-- Then we can add categories without having to update this list also.

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
for key in pairs(spawnable.tankers) 	do missionCommands.addCommand(key, TankerMenu, 			function() spawnUnit({group=spawnable.tankers[key], action='respawn'}) end) end
for key in pairs(spawnable.armor) 		do missionCommands.addCommand(key, ArmorMenu,  			function() spawnUnit({group=spawnable.armor[key], action='clone'}) end) end
for key in pairs(spawnable.infantry)	do missionCommands.addCommand(key, InfantryMenu,  		function() spawnUnit({group=spawnable.infantry[key], action='clone'}) end) end
for key in pairs(spawnable.airdefences) do missionCommands.addCommand(key, AirDefenceMenu,  	function() spawnUnit({group=spawnable.airdefences[key], action='clone'}) end) end
for key in pairs(spawnable.fighters) 	do missionCommands.addCommand(key, ModernFighterMenu,  	function() spawnUnit({group=spawnable.fighters[key], action='clone'}) end) end
for key in pairs(spawnable.warbirds) 	do missionCommands.addCommand(key, WarBirdMenu,  		function() spawnUnit({group=spawnable.warbirds[key], action='clone'}) end) end
for key in pairs(spawnable.helicopters)	do missionCommands.addCommand(key, HelicopterMenu,  	function() spawnUnit({group=spawnable.helicopters[key], action='clone'}) end) end
for key in pairs(spawnable.boats)		do missionCommands.addCommand(key, BoatsMenu,  			function() spawnUnit({group=spawnable.boats[key], action='clone'}) end) end
