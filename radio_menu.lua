local TankerMenu = missionCommands.addSubMenu("Spawn Tanker",nil)
	missionCommands.addCommand("KC-130 (Basket)", TankerMenu, function() trigger.action.setUserFlag(20, 1) end)
	missionCommands.addCommand("KC-135 (Boom, Fast)", TankerMenu, function() trigger.action.setUserFlag(21, 1) end)
	missionCommands.addCommand("KC-135 (Boom, Slow)", TankerMenu, function() trigger.action.setUserFlag(23, 1) end)
	missionCommands.addCommand("S-3B (Basket)", TankerMenu, function() trigger.action.setUserFlag(22, 1) end)

local FighterMenu = missionCommands.addSubMenu("Spawn AI Fighter",nil)
	missionCommands.addCommand("MiG-29A with Heaters", FighterMenu, function() trigger.action.setUserFlag(10, 1) end)
	
	
local msg = {}
msg.text = 'Radio Menus Loaded (r06)' 
msg.displayTime = 5 
msg.msgFor = {coa = {'all'}} 
mist.message.add(msg)    