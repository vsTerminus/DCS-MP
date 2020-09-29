--local spawnable = require("spawnable_spawnable.lua")
-- requires spawnable_units.lua
-- requires mark_listener.lua

local defaultSound = "tsctra00.wav"

function spawnUnit(args)

	local unitId = args.unit
	local group = args.group
	local action = args.action -- Accepted actions are clone, teleport, respawn
	local cat = args.category -- Accepted categories are land, water, air

	-- If we have a markpoint, we can spawn units there instead of ME coords.
	if ( markPoint.x ) then
		
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
function spawnTanker(args)
	if markPoint.x then
		local oldRoute = mist.getGroupRoute(args.group.name, true)
		local newRoute = oldRoute
		
		-- Start at client's position, but 2km ahead.
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