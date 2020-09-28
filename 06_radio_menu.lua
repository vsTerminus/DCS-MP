--local spawnable = require("spawnable_spawnable.lua")
-- requires spawnable_units.lua
-- requires mark_listener.lua

local defaultSound = "tsctra00.wav"

local function dumper(var, indent)
	
	if not indent then indent = 0 end

	if indent == 0 then env.info(("Dumper Start")) end
	
	local pad = ""
	for i=0,indent do
		pad = string.format("%s  ", pad)
	end
	
	for k,v in pairs(var) do
		if ( type(v) == 'table' ) then 
			env.info((string.format("%s'%s' = {", pad, k)))
			dumper(v, indent+1) 
			env.info((string.format("%s}", pad)))
		elseif type(v) == 'function' then
			env.info((string.format("%s'%s' = function'", pad, k)))
		elseif type(v) == 'nil' then
			env.info((string.format("%s'%s' = nil", k, pad)))
		elseif type(v) == 'boolean' then
			local bool = 'false'
			if v then bool = 'true' end
			env.info((string.format("%s'%s' = %s", pad, k, bool)))
		elseif type(v) == 'string' or type(v) == 'number' then
			env.info((string.format("%s'%s' = '%s'", pad, k, v)))
		else
			env.info((string.format("%s'%s' = Unknown Type: %s", pad, k, type(v))))
		end
	end
	
	if indent == 0 then env.info(("Dumper End")) end

end

local function spawnUnit(args)

	local group = args.group
	local action = args.action -- Accepted actions are clone, teleport, respawn
	local cat = args.category -- Accepted categories are land, water, air

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
		if args.route then spawnVars.route = args.route else spawnVars.route = mist.getGroupRoute(group.name, true) end
		--dumper(spawnVars.route)
		
		newGroup = mist.teleportToPoint(spawnVars)
		
		-- Need to only drop smoke for ground units, or it breaks things.
		if ( cat ~= 'air' ) then
			-- Drop smoke in the middle of the group
			avgPoint = mist.getAvgGroupPos(newGroup.name)
			trigger.action.smoke({x=avgPoint.x, y=avgPoint.y, z=avgPoint.z}, trigger.smokeColor.Red)
		end
	
	else -- If no mark point defined (yet), just respawn the group at ME coords.
		mist.respawnGroup(group.name, true)	
	end
	
	-- Tell the user exactly what spawned
	local msg = {}
	msg.text = string.format('Spawned: %s', group.description)
	msg.displayTime = 20
	msg.msgFor = {coa = {'all'}}
	if ( group.sound ) then msg.sound = group.sound else msg.sound = defaultSound end
	mist.message.add(msg)
	
end

-- calls spawnUnit after it makes some changes to the group's route.
local function spawnTanker(args)
	if markPoint.x then
		local oldRoute = mist.getGroupRoute(args.group.name, true)
		local newRoute = oldRoute
		
		-- Start at mark point
		newRoute[1].x = markPoint.x
		newRoute[1].y = markPoint.z
		
		-- Go 90nm North
		newRoute[2].x = markPoint.x + 166680
		newRoute[2].y = markPoint.z
		
		-- Pass the new route to spawnUnit
		args.route = newRoute
	end
	
	spawnUnit(args)
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
for key in pairs(spawnable.tankers) 	do missionCommands.addCommand(key, TankerMenu, 			function() spawnTanker({group=spawnable.tankers[key], category='air', action='respawn'}) end) end
for key in pairs(spawnable.armor) 		do missionCommands.addCommand(key, ArmorMenu,  			function() spawnUnit({group=spawnable.armor[key], category='land', action='clone'}) end) end
for key in pairs(spawnable.infantry)	do missionCommands.addCommand(key, InfantryMenu,  		function() spawnUnit({group=spawnable.infantry[key], category='land', action='clone'}) end) end
for key in pairs(spawnable.airdefences) do missionCommands.addCommand(key, AirDefenceMenu,  	function() spawnUnit({group=spawnable.airdefences[key], category='land', action='clone'}) end) end
for key in pairs(spawnable.fighters) 	do missionCommands.addCommand(key, ModernFighterMenu,  	function() spawnUnit({group=spawnable.fighters[key], category='air', action='clone'}) end) end
for key in pairs(spawnable.warbirds) 	do missionCommands.addCommand(key, WarBirdMenu,  		function() spawnUnit({group=spawnable.warbirds[key], category='air', action='clone'}) end) end
for key in pairs(spawnable.helicopters)	do missionCommands.addCommand(key, HelicopterMenu,  	function() spawnUnit({group=spawnable.helicopters[key], category='air', action='clone'}) end) end
for key in pairs(spawnable.boats)		do missionCommands.addCommand(key, BoatsMenu,  			function() spawnUnit({group=spawnable.boats[key], category='water', action='clone'}) end) end
