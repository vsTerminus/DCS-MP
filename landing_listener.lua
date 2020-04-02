do

	local function onLanding(event)            
		if event.id == world.event.S_EVENT_LAND then                    
			local unit = event.initiator               
			local coalition = unit:getCoalition() -- 2 == blue
			local place = unit.place
			local category = place.category
			
			if coalition == 2 and category == 4 and place:getName() == 'Bandar-e-Jask airfield' then
				trigger.action.setUserFlag(100, 1) -- Victory trigger
			end	 
			
			trigger.action.setUserFlag(200, 1) -- Grunt Birthday Party trigger
		end    
	end

	mist.addEventHandler(onLanding)    

end