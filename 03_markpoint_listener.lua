markPoint = {}

function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end



local function onMark(event)    
	env.info(("onMark Fired"))
	if ( event.id == world.event.S_EVENT_MARK_ADDED ) then
		env.info(("onMark MARK_ADDED"))
		trigger.action.outSound("l10n/DEFAULT/TGoYes01.wav")
	end
	if ( event.id == world.event.S_EVENT_MARK_REMOVED ) then
		env.info(("onMark MARK_REMOVED"))
		--env.info((string.format("Event: %s", print_r(event))))
		if ( event.pos ) then
			for k,v in pairs(event.pos)	do
				env.info((k.x))
				env.info((k.y))
				env.info((k.z))
			end
			markPoint = event.pos
			
			local markMsg = {}
			markMsg.text = string.format('MarkPoint Coordinates Recorded: %s, %s', event.pos.x, event.pos.y) 
			markMsg.displayTime = 10
			markMsg.msgFor = {coa = {'all'}} 
			mist.message.add(markMsg)
			
			trigger.action.outSound("l10n/DEFAULT/TGoYes03.wav")
		end		
	end    
end


mist.addEventHandler(onMark)   

local loadMsg = {}
loadMsg.text = '03 - MarkPoint Listener Loaded' 
loadMsg.displayTime = 5
loadMsg.msgFor = {coa = {'all'}} 
mist.message.add(loadMsg)