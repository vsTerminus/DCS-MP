do

	local function onLanding(event)            
		if event.id == world.event.S_EVENT_LAND then                    
			local u = event.initiator               
			local c = u:getCoalition() -- 2 == blue
			local n = event.place:getName()
			
			if c == 2 and n == 'Bandar-e-Jask airfield' then
				trigger.action.setUserFlag(100, 1) -- Victory trigger
			end	 
			
			trigger.action.setUserFlag(200, 1) -- Grunt Birthday Party trigger
		end    
	end

	mist.addEventHandler(onLanding)    

end