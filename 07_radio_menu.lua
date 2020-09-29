local function addSpawnMenu()

	--timer.scheduleFunction(addSpawnMenu, nil, timer.getTime() + 10)
	
	--dumper(mist.DBs.unitsById)
	env.info((type(mist.DBs.unitsById)))
	
	for unitId,unit in pairs(mist.DBs.unitsById) do
	
		--local unit = mist.DBs.unitsById[i]
		
		if unit and unit.coalition == 'blue' then
			env.info((string.format("Unit %d %s -- Group %d %s", unit.unitId, unit.unitName, unit.groupId, unit.groupName)))			
			groupId = unit.groupId
			
			-- Radio Top Level Menu
			local SpawnMenu			= missionCommands.addSubMenuForGroup(groupId,"Spawn",nil)

			-- Second Level: Categories
			local TankerMenu 		= missionCommands.addSubMenuForGroup(groupId,"Tankers",SpawnMenu)
			local ArmorMenu 		= missionCommands.addSubMenuForGroup(groupId,"Armor",SpawnMenu)
			local InfantryMenu		= missionCommands.addSubMenuForGroup(groupId,"Infantry",SpawnMenu)
			local AirDefenceMenu	= missionCommands.addSubMenuForGroup(groupId,"Air Defenses",SpawnMenu)
			local ModernFighterMenu = missionCommands.addSubMenuForGroup(groupId,"Modern Fighters",SpawnMenu)
			local WarBirdMenu		= missionCommands.addSubMenuForGroup(groupId,"Warbirds",SpawnMenu)
			local HelicopterMenu	= missionCommands.addSubMenuForGroup(groupId,"Helicopters",SpawnMenu)
			local BoatsMenu			= missionCommands.addSubMenuForGroup(groupId,"Boats",SpawnMenu)

			-- Third Level: Groups
			for key in pairs(spawnable.tankers) 	do missionCommands.addCommandForGroup(groupId, key, TankerMenu,  			
				function() spawnTanker({unit=unitId, group=spawnable.tankers[key], category='air', action='clone'}) end) end	
			for key in pairs(spawnable.armor) 		do missionCommands.addCommandForGroup(groupId, key, ArmorMenu,  			
				function() spawnUnit({unit=unitId, group=spawnable.armor[key], category='land', action='clone'}) end) end
			for key in pairs(spawnable.infantry)	do missionCommands.addCommandForGroup(groupId, key, InfantryMenu,  		
				function() spawnUnit({unit=unitId, group=spawnable.infantry[key], category='land', action='clone'}) end) end
			for key in pairs(spawnable.airdefences) do missionCommands.addCommandForGroup(groupId, key, AirDefenceMenu,  	
				function() spawnUnit({unit=unitId, group=spawnable.airdefences[key], category='land', action='clone'}) end) end
			for key in pairs(spawnable.fighters) 	do missionCommands.addCommandForGroup(groupId, key, ModernFighterMenu,  	
				function() spawnUnit({unit=unitId, group=spawnable.fighters[key], category='air', action='clone'}) end) end
			for key in pairs(spawnable.warbirds) 	do missionCommands.addCommandForGroup(groupId, key, WarBirdMenu,  		
				function() spawnUnit({unit=unitId, group=spawnable.warbirds[key], category='air', action='clone'}) end) end
			for key in pairs(spawnable.helicopters)	do missionCommands.addCommandForGroup(groupId, key, HelicopterMenu,  	
				function() spawnUnit({unit=unitId, group=spawnable.helicopters[key], category='air', action='clone'}) end) end
			for key in pairs(spawnable.boats)		do missionCommands.addCommandForGroup(groupId, key, BoatsMenu,  			
				function() spawnUnit({unit=unitId, group=spawnable.boats[key], category='water', action='clone'}) end) end
				

		end
	end
end

addSpawnMenu()