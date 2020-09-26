-- This file just contains the array of unit groups that can be spawned via the radio menu.
-- The idea is just to keep the clutter down in the radio menu file, which will contain all of the actual code and logic.

-- You must create groups matching the names found below. Ideally the description field should accurately describe the group's composition.
-- Location isn't important, as spawning will be done via map mark points.

-- For all entries below,
-- 		The array key is what will appear in the F10 menu (Keep it short!)
--		'name' must match the group name in the DCS Mission Editor
--		'description' is a string of text that will be displayed when the group spawns
--		'sound' is OPTIONAL, and should be the filename of the sound you want to play when the group spawns.

-- For sounds you must include the sound file in the mission somehow or it won't be able to play.
-- The easiest way to do this is to make a new trigger which does "SOUND TO COUNTRY" on mission start.
-- You can simply send each sound file to a country like Abkhazia and it will be included in the .miz file for use by scripting as well.

-- The array is broken up into categories. Each category can have a max of TEN spawnable groups.
-- If you exceed ten you'll need to make another category and update the radio menu lua as well.

spawnable = {}

-- "Armor" category
spawnable.armor = {
	['4x BTR-80s'] = {
		name = 'BTR-1',
		description = '4x APX BTR-80s',
		sound = 'tvurdy00.wav',
	},
}

-- "Air Defences" category
spawnable.airdefences = {
	['SA-6 SAM Site'] = {
		name = 'KUB-1',
		description = 'SA-6 Site with 3 Launchers and 1 Radar',
		sound = 'tvkpss01.wav',
	},
}

-- "Modern Fighters" category
spawnable.fighters = {
	['2x MiG-29A IR'] = {
		name = 'MIG-1',
		description = 'Two MiG-29As armed with IR Missiles',
	},
	['2x MiG-29A Guns'] = {
		name = 'MIG-2',
		description = 'Two MiG-29As armed with guns',
	},
}

-- "Warbird" category
spawnable.warbirds = {
	['2x Fw 190-D9'] = {
		name = 'D9-1',
		description = 'Two Fw 190-D9s',
	},
}

-- "Infantry" category
spawnable.infantry = {
	['10x Assorted Infantry'] = {
		name = 'Infantry-1',
		description = 'Ten Assorted Russian Infantry',
	},
}

-- "Helicopters" category
spawnable.helicopters = {
	['Mi-24V'] = {
		name = 'Hind-1',
		description = 'An Mi-24V Hind Attack Helicopter',
	},
}

-- "Tankers" category
spawnable.tankers = {
	['KC-130 Basket'] = {
		name = 'Texaco 1',
		description = 'KC-130 (Basket) Tanker, 255KIAS at 15,000ft. Contact on 130.0, TCN 30X',
	},
	['KC-135MPRS Basket'] = {
		name = 'Texaco 2',
		description = 'KC-135MPRS (Basket) Tanker, 270KIAS at 25,000ft. Contact on 131.0, TCN 31X',
	},
	['S-3B Basket'] = {
		name = 'Texaco 3',
		description = 'S-3B (Basket) Tanker, 270KIAS at 25,000ft. Contact on 132.0, TCN 32X',
	},
	['KC-135 Boom (Fast)'] = {
		name = 'Shell 1',
		description = 'KC-135 (Boom) Tanker, 270KIAS at 25,000ft. Contact on 133.0, TCN 33X',
	},
	['KC-135 Boom (Slow)'] = {
		name = 'Shell 2',
		description = 'KC-135 (Boom) Tanker, 220KIAS at 10,000ft. Contact on 134.0, TCN 34X',
	},
}

local loadMsg = {}
loadMsg.text = '05 - Spanwable Units Loaded' 
loadMsg.displayTime = 5 
loadMsg.msgFor = {coa = {'all'}} 
mist.message.add(loadMsg)