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
		description = '4x APC BTR-80s',
		sound = 'tvurdy00.wav', -- Alright, bring it on!
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
	['4x T72 MBTs'] = {
		name = 'T72-1',
		description = '4x T72 Main Battle Tanks',
		sound = 'ttardy00.wav', -- Ready to roll out!
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
}

-- "Air Defences" category
spawnable.airdefences = {
	['SA-6 SAM Site'] = {
		name = 'KUB-1',
		description = 'SA-6 Gainful (2k12 Куб) with 4 Launchers, 1 Straight Flush Radar, 1 P-19 EWR',
		sound = 'tvkpss01.wav', -- I have ways of blowing things up
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
	['4x ZU-23'] = {
		name = 'ZU-1',
		description = '4x ZU-23s in assorted configurations',
		sound = 'tfbwht00.wav', -- Fired up
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
	['SA-10 SAM Site'] = {
		name = 'Grumble-1',
		description = 'SA-10 Grumble (S-300) with a Command Post, Big Bird EWR, Clamshell TAR, Flap Lid TER, and 8 Launchers',
		sound = 'TAdUpd07.wav', -- Nuclear Missile Ready
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
}

-- "Modern Fighters" category
spawnable.fighters = {
	['2x MiG-29A IR'] = {
		name = 'MIG-1',
		description = 'Two MiG-29As armed with IR Missiles',
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
	['2x MiG-29A Guns'] = {
		name = 'MIG-2',
		description = 'Two MiG-29As armed with guns',
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
}

-- "Warbird" category
spawnable.warbirds = {
	['2x Fw 190-D9'] = {
		name = 'D9-1',
		description = 'Two Fw 190-D9s',
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
}

-- "Infantry" category
spawnable.infantry = {
	['10x Assorted Infantry'] = {
		name = 'Infantry-1',
		description = 'Ten Assorted Russian Infantry',
		sound = 'tmawht03.wav', -- Gimme somethin to shoot
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
}

-- "Helicopters" category
spawnable.helicopters = {
	['Mi-24V'] = {
		name = 'Hind-1',
		description = 'An Mi-24V Hind Attack Helicopter',
		sound = 'pcowht03.wav',	-- Let us attack
		smoke = false,
		relative = false,
		action = 'clone',
	},
}

-- "Boats" category
spawnable.boats = {
	['Kirov'] = {
		name = 'Kirov-1',
		description = 'CGN 1144.2 Pyotr Velikiy Kirov',
		sound = 'tbardy00.wav', -- Cattlebruiser Operational
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
	['Kuznetsov'] = {
		name = 'Kuznetsov-1',
		description = 'CV 1143.5 Admiral Kuznetsov (2017)',
		sound = 'pcaRdy00.wav', -- Carrier has arrived
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
	['4x Cargo Ships'] = {
		name = 'Cargo-1',
		description = '4x Unarmed Cargo Ships',
		sound = 'pprRdy00.wav',
		smoke = 'red',
		relative = false,
		action = 'clone',
	},
}

-- "Boats" friendly category
spawnable.fboats = {
	['CVN-73 George Washington'] = {
		name = 'CVN-73 George Washington 1',
		description = 'Friendly CVN-73 George Washington Super Carrier',
		sound = 'pcaRdy00.wav',
		smoke = false,
		relative = true,
		action = 'respawn',
	},
	['CV 1143.5 Admiral Kuznetsov'] = {
		name = 'Super Kuznetsov 1',
		description = 'CV 1143.5 Admiral Kuznetsov (2017) Super Carrier',
		sound = 'pcaRdy00.wav',
		smoke = false,
		relative = true,
		action = 'respawn',
	},
}

-- "Tankers" friendly category
spawnable.ftankers = {
	['Basket KC-130'] = {
		name = 'Texaco 1',
		description = 'KC-130 (Basket) Tanker, 255KIAS at 15,000ft. Contact on 130.0, TCN 30X',
		sound = 'Can I Take Your Order.ogg',
		smoke = false,
		relative = true,
		action = 'respawn',
	},
	['Basket KC-135MPRS '] = {
		name = 'Texaco 2',
		description = 'KC-135MPRS (Basket) Tanker, 270KIAS at 25,000ft. Contact on 131.0, TCN 31X',
		sound = 'Can I Take Your Order.ogg',
		smoke = false,
		relative = true,
		action = 'respawn',
	},
	['Basket S-3B '] = {
		name = 'Texaco 3',
		description = 'S-3B (Basket) Tanker, 270KIAS at 25,000ft. Contact on 132.0, TCN 32X',
		sound = 'Can I Take Your Order.ogg',
		smoke = false,
		relative = true,
		action = 'respawn',
	},
	['Boom KC-135 (Fast)'] = {
		name = 'Shell 1',
		description = 'KC-135 (Boom) Tanker, 270KIAS at 25,000ft. Contact on 133.0, TCN 33X',
		sound = 'Can I Take Your Order.ogg',
		smoke = false,
		relative = true,
		action = 'respawn',
	},
	['Boom KC-135 (Slow)'] = {
		name = 'Shell 2',
		description = 'KC-135 (Boom) Tanker, 220KIAS at 10,000ft. Contact on 134.0, TCN 34X',
		sound = 'Can I Take Your Order.ogg',
		smoke = false,
		relative = true,
		action = 'respawn',
	},
	['Basket Il-78M'] = {
		name = 'Texaco 4',
		description = 'Il-78M (Basket) Tanker, 270KIAS at 25,000ft. Contact on 135.0, No TCN',
		sound = 'tvkpss00.wav', -- This is very interesting, but stupid
		smoke = false,
		relative = true,
		action = 'respawn',
	},
}
