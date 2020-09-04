-- Tankers

local tankers = {
	['Texaco 1-1'] = {
		where = 'Southeast of Damascus',
		hdg = 'Northwest (300)',
		speed = '255 KIAS',
		distance = '90 nm',
		dest = 'Beirut',
		group = 'Texaco 1',
		comms = '130.000MHz AM',
		tcn = '30X',
		alt = '15,000 ft',
		plane = 'KC-130 (Basket)',
	},
	['Texaco 2-1'] = {
		where = 'Southeast of Damascus',
		hdg = 'Northwest (300)',
		speed = '270 KIAS',
		distance = '90 nm',
		dest = 'Beirut',
		group = 'Texaco 2',
		comms = '131.000MHz AM',
		tcn = '31X',
		alt = '25,000 ft',
		plane = 'KC-135MPRS (Basket)',
	},
	['Texaco 3-1'] = {
		where = 'Southeast of Damascus',
		hdg = 'Northwest (300)',
		speed = '270 KIAS',
		distance = '90 nm',
		dest = 'Beirut',
		group = 'Texaco 3',
		comms = '132.000MHz AM',
		tcn = '32',
		alt = '25,000 ft',
		plane = 'S-3B (Basket)',
	},
	['Shell 1-1'] = {
		where = 'Southeast of Damascus',
		hdg = 'Northwest (300)',
		speed = '270 KIAS',
		distance = '90 nm',
		dest = 'Beirut',
		group = 'Shell 1',
		comms = '133.000MHz AM',
		tcn = '33X',
		alt = '25,000 ft',
		plane = 'KC-135 (Boom)',
	},
	['Shell 2-1'] = {
		where = 'Southeast of Damascus',
		hdg = 'Northwest (300)',
		speed = '220 KIAS',
		distance = '90 nm',
		dest = 'Beirut',
		group = 'Shell 2',
		comms = '134.000MHz AM',
		tcn = '34X',
		alt = '10,000 ft',
		plane = 'KC-135 (Boom)',
	},
}

local function spawnTanker(name)
	local tanker = tankers[name]
	local spawnMsg = {}
	
	spawnMsg.text = string.format('%s has spawned %s\nHeading %s towards %s\nTrack Distance: %s\n\nType: %s\nComms: %s\nTACAN: %s\nSpeed: %s\nAltitude: %s', name, tanker.where, tanker.hdg, tanker.dest, tanker.distance, tanker.plane, tanker.comms, tanker.tcn, tanker.speed, tanker.alt)
	spawnMsg.displayTime = 30 
	spawnMsg.msgFor = {coa = {'all'}} 
	mist.message.add(spawnMsg)  

	mist.respawnGroup(tanker.group, true)	
	trigger.action.outSound("l10n/DEFAULT/Can I Take Your Order.ogg")
end


-- Fighters

local fighters = {
	['MiG-29-BVR-Guns-1'] = {
		group = 'MiG-29-BVR-Guns-1',
		alt = '25,000 ft',
		plane = 'MiG-29A x1 Guns Only',
		where = 'King Hussein Air College',
	},
	['MiG-29-WVR-Guns-1'] = {
		group = 'MiG-29-WVR-Guns-1',
		alt = '25,000 ft',
		plane = 'MiG-29A x1 Guns Only',
		where = 'Khalkhalah',
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
	missionCommands.addCommand("KC-130 255kts@15000", TankerMenu, function() spawnTanker('Texaco 1-1') end)
	missionCommands.addCommand("KC-135MPRS 270kts@25000", TankerMenu, function() spawnTanker('Texaco 2-1') end)
	missionCommands.addCommand("S-3B 270kts@25000", TankerMenu, function() spawnTanker('Texaco 3-1') end)
	
	missionCommands.addCommand("KC-135 270kts@25000", TankerMenu, function() spawnTanker('Shell 1-1') end)
	missionCommands.addCommand("KC-135 220kts@10000", TankerMenu, function() spawnTanker('Shell 2-1') end)

local FighterMenu = missionCommands.addSubMenu("Spawn AI Fighter",nil)
	local BVRMenu = missionCommands.addSubMenu("Spawn BVR Opponent",FighterMenu)
		missionCommands.addCommand("MiG-29A x1 Guns Only", BVRMenu, function() spawnFighter('MiG-29-BVR-Guns-1') end)
	local WVRMenu = missionCommands.addSubMenu("Spawn WVR Opponent",FighterMenu)
		missionCommands.addCommand("MiG-29A x1 Guns Only", WVRMenu, function() spawnFighter('MiG-29-WVR-Guns-1') end)
		


local loadMsg = {}
loadMsg.text = 'Radio Menus Loaded (r01)' 
loadMsg.displayTime = 5 
loadMsg.msgFor = {coa = {'all'}} 
mist.message.add(loadMsg)    