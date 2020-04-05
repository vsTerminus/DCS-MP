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
end


-- Radio Menu

local TankerMenu = missionCommands.addSubMenu("Spawn Tanker",nil)
	missionCommands.addCommand("KC-130 (Basket)", TankerMenu, function() spawnTanker('Texaco 1-1') end)
	missionCommands.addCommand("KC-135 (Boom, Fast)", TankerMenu, function() spawnTanker('Shell 1-1') end)
	missionCommands.addCommand("KC-135 (Boom, Slow)", TankerMenu, function() spawnTanker('Shell 2-1') end)
	missionCommands.addCommand("S-3B (Basket)", TankerMenu, function() spawnTanker('Arco 1-1') end)

local FighterMenu = missionCommands.addSubMenu("Spawn AI Fighter",nil)
	missionCommands.addCommand("MiG-29A with Heaters", FighterMenu, function() trigger.action.setUserFlag(10, 1) end)


local loadMsg = {}
loadMsg.text = 'Radio Menus Loaded (r15)' 
loadMsg.displayTime = 5 
loadMsg.msgFor = {coa = {'all'}} 
mist.message.add(loadMsg)    