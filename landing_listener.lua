local function onLanding(event)            
	if event.id == world.event.S_EVENT_LAND then                    
		local unit = event.initiator               
		local coalition = unit:getCoalition() -- 2 == blue
		local place = nil
		local category = nil
		
		if unit.place then 
			place = unit.place 
			category = place.category
		end
		
		if coalition == 2 and category == 4 and place:getName() == 'Bandar-e-Jask airfield' then
			trigger.action.setUserFlag(100, 1) -- Victory trigger
		end	 
		
		trigger.action.setUserFlag(200, 1) -- Grunt Birthday Party trigger
	end    
end

mist.addEventHandler(onLanding)   

local msg = {}
msg.text = 'Landing Listener Loaded' 
msg.displayTime = 1 
msg.msgFor = {coa = {'all'}} 
mist.message.add(msg)    