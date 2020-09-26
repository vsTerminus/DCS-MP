-- Tankers

local tankers = {
	['Texaco 1-1'] = {
		hdg = '288',
		speed = '275 KCAS',
		dest = 'Lavan Island',
		group = 'Texaco 1-1',
		comms = '131.000MHz AM',
		tcn = '1X',
		alt = '12,000 ft',
		plane = 'KC-130 (Basket)',
		where = '15nm SouthEast of Kish Intl',
	},
	['Shell 1-1'] = {
		hdg = '288',
		speed = '275 KCAS',
		dest = 'Lavan Island',
		group = 'Shell 1-1',
		comms = '132.000MHz AM',
		tcn = '2X',
		alt = '16,000 ft',
		plane = 'KC-135 (Boom)',
		where = '15nm SouthEast of Kish Intl',
	},
	['Shell 2-1'] = {
		hdg = '288',
		speed = '225 KCAS',
		dest = 'Lavan Island',
		group = 'Shell 2-1',
		comms = '134.000MHz AM',
		tcn = '4X',
		alt = '8,000 ft',
		plane = 'KC-135 (Boom)',
		where = '15nm SouthEast of Kish Intl',
	},
	['Arco 1-1'] = {
		hdg = '288',
		speed = '275 KCAS',
		dest = 'Lavan Island',
		group = 'Arco 1-1',
		comms = '133.000MHz AM',
		tcn = '3X',
		alt = '14,000 ft',
		plane = 'S3-B (Basket)',
		where = '15nm SouthEast of Kish Intl',
	},
}

local function spawnTanker(name)
	local tanker = tankers[name]
	local spawnMsg = {}
	
	spawnMsg.text = string.format('%s has spawned %s\nHeading %s towards %s\n\nType: %s\nComms: %s\nTACAN: %s\nSpeed: %s\nAltitude: %s', name, tanker.where, tanker.hdg, tanker.dest, tanker.plane, tanker.comms, tanker.tcn, tanker.speed, tanker.alt)
	spawnMsg.displayTime = 30 
	spawnMsg.msgFor = {coa = {'all'}} 
	mist.message.add(spawnMsg)  

	mist.respawnGroup(tanker.group, true)	
	trigger.action.outSound("l10n/DEFAULT/Can I Take Your Order.ogg")
end


-- Fighters

local fighters = {
	['MiG-29-Guns-Single'] = {
		group = 'MiG-29-Guns-Single',
		alt = '10,000 ft',
		plane = 'MiG-29A x1 with Guns',
		where = 'over Siri Island',
	},
	['MiG-29-Guns'] = {
		group = 'MiG-29-Guns',
		alt = '10,000 ft',
		plane = 'MiG-29A x2 with Guns',
		where = 'over Siri Island',
	},
	['MiG-29-Heaters-Single'] = {
		group = 'MiG-29-Heaters-Single',
		alt = '10,000 ft',
		plane = 'MiG-29A x1 with Heaters',
		where = 'over Siri Island',
	},
	['MiG-29-Heaters'] = {
		group = 'MiG-29-Heaters',
		alt = '10,000 ft',
		plane = 'MiG-29A x2 with Heaters',
		where = 'over Siri Island',
	},
	['MiG-15-Guns-Single'] = {
		group = 'MiG-15-Guns-Single',
		alt = '10,000 ft',
		plane = 'MiG-15bis x1 with Guns',
		where = 'over Siri Island',
	},
	['MiG-15-Guns'] = {
		group = 'MiG-15-Guns',
		alt = '10,000 ft',
		plane = 'MiG-15bis x2 with Guns',
		where = 'over Siri Island',
	},
	['Fw-190-Guns-Single'] = {
		group = 'Fw-190-Guns-Single',
		alt = '10,000 ft',
		plane = 'Fw-190 x1 with Guns',
		where = 'over Siri Island',
	},
	['Fw-190-Guns'] = {
		group = 'Fw-190-Guns',
		alt = '10,000 ft',
		plane = 'Fw-190 x2 with Guns',
		where = 'over Siri Island',
	},
}

local function spawnFighter(name)
	local fighter = fighters[name]
	local spawnMsg = {}
	
	spawnMsg.text = string.format('Spawned AI Dogfight Opponent\n\nConfiguration: %s\nLocation: %s\nAltitude: %s', fighter.plane, fighter.where, fighter.alt)
	spawnMsg.displayTime = 15
	spawnMsg.msgFor = {coa = {'all'}} 
	mist.message.add(spawnMsg)  

	mist.respawnGroup(fighter.group, true)	
	trigger.action.outSound("l10n/DEFAULT/Battlecruiser Operational.ogg")
end




-- Radio Menu

local TankerMenu = missionCommands.addSubMenu("Spawn Tanker",nil)
	missionCommands.addCommand("KC-130 (Basket)", TankerMenu, function() spawnTanker('Texaco 1-1') end)
	missionCommands.addCommand("KC-135 (Boom, Fast)", TankerMenu, function() spawnTanker('Shell 1-1') end)
	missionCommands.addCommand("KC-135 (Boom, Slow)", TankerMenu, function() spawnTanker('Shell 2-1') end)
	missionCommands.addCommand("S-3B (Basket)", TankerMenu, function() spawnTanker('Arco 1-1') end)

local FighterMenu = missionCommands.addSubMenu("Spawn AI Fighter",nil)
	local MiG29Menu = missionCommands.addSubMenu("Mig-29A",FighterMenu)
		missionCommands.addCommand("MiG-29A x1 with Guns", MiG29Menu, function() spawnFighter('MiG-29-Guns-Single') end)
		missionCommands.addCommand("MiG-29A x2 with Guns", MiG29Menu, function() spawnFighter('MiG-29-Guns') end)
		missionCommands.addCommand("MiG-29A x1 with Heaters", MiG29Menu, function() spawnFighter('MiG-29-Heaters-Single') end)
		missionCommands.addCommand("MiG-29A x2 with Heaters", MiG29Menu, function() spawnFighter('MiG-29-Heaters') end)
	local MiG15Menu = missionCommands.addSubMenu("MiG-15bis",FighterMenu)
		missionCommands.addCommand("MiG-15 x1 with Guns", MiG15Menu, function() spawnFighter('MiG-15-Guns-Single') end)
		missionCommands.addCommand("MiG-15 x2 with Guns", MiG15Menu, function() spawnFighter('MiG-15-Guns') end)
	local Fw190Menu = missionCommands.addSubMenu("Fw-190",FighterMenu)
		missionCommands.addCommand("Fw-190 x1 with Guns", Fw190Menu, function() spawnFighter('Fw-190-Guns-Single') end)
		missionCommands.addCommand("Fw-190 x2 with Guns", Fw190Menu, function() spawnFighter('Fw-190-Guns') end)
		


local loadMsg = {}
loadMsg.text = 'Radio Menus Loaded (r18)' 
loadMsg.displayTime = 5 
loadMsg.msgFor = {coa = {'all'}} 
mist.message.add(loadMsg)    