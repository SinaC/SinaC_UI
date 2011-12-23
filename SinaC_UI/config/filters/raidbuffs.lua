local T, C, L = unpack(Tukui)

T.RaidBuffs = {
	special = {
		80398 -- Dark Intent
	},
	flask = {
		94160, --"Flask of Flowing Water"
		79469, --"Flask of Steelskin"
		79470, --"Flask of the Draconic Mind"
		79471, --"Flask of the Winds
		79472, --"Flask of Titanic Strength"
		79638, --"Flask of Enhancement-STR"
		79639, --"Flask of Enhancement-AGI"
		79640, --"Flask of Enhancement-INT"
		92679, --Flask of battle
	},
	battleElixir = {
		--Scrolls
		89343, --Agility
		63308, --Armor 
		89347, --Int
		89342, --Spirit
		63306, --Stam
		89346, --Strength

		--Elixirs
		79481, --Hit
		79632, --Haste
		79477, --Crit
		79635, --Mastery
		79474, --Expertise
		79468, --Spirit
	},
	guardianElixir = {
		79480, --Armor
		79631, --Resistance+90
	},
	food = {
		87545, --90 STR
		87546, --90 AGI
		87547, --90 INT
		87548, --90 SPI
		87549, --90 MAST
		87550, --90 HIT
		87551, --90 CRIT
		87552, --90 HASTE
		87554, --90 DODGE
		87555, --90 PARRY
		87635, --90 EXP
		87556, --60 STR
		87557, --60 AGI
		87558, --60 INT
		87559, --60 SPI
		87560, --60 MAST
		87561, --60 HIT
		87562, --60 CRIT
		87563, --60 HASTE
		87564, --60 DODGE
		87634, --60 EXP
		87554, --Seafood Feast
	},
	casterOnly = {
		spell3 = { --Total Stats
		1126, -- "Mark of the wild"
		90363, --"Embrace of the Shale Spider"
		20217, --"Greater Blessing of Kings",
		},
		spell4 = { --Total Stamina
			469, -- Commanding
			6307, -- Blood Pact
			90364, -- Qiraji Fortitude
			72590, -- Drums of fortitude
			21562, -- Fortitude
		},
		spell5 = { --Total Mana
			61316, --"Dalaran Brilliance"
			1459, --"Arcane Brilliance"
		},
		spell6 = { --Mana Regen
			5675, --"Mana Spring Totem"
			19740, --"Blessing of Might"
		}
	},
	nonCaster = {
		spell3 = { --Total Stats
			1126, -- "Mark of the wild"
			90363, --"Embrace of the Shale Spider"
			20217, --"Greater Blessing of Kings",
		},
		spell4 = { --Total Stamina
			469, -- Commanding
			6307, -- Blood Pact
			90364, -- Qiraji Fortitude
			72590, -- Drums of fortitude
			21562, -- Fortitude
		},
		spell5 = { --Total Mana
			61316, --"Dalaran Brilliance"
			1459, --"Arcane Brilliance"
		},
		spell6 = { --Total AP
			19740, --"Blessing of Might" placing it twice because i like the icon better :D code will stop after this one is read, we want this first 
			30808, --"Unleashed Rage"
			53138, --Abom Might
			19506, --Trushot
			19740, --"Blessing of Might"
		}
	},
	--
	allBuffs = {
		["melee10"] = {
			8512,						-- Windfury
			55610,						-- Imp Icy Talons
			53290,						-- Hunting Party
		},

		["crit5"] = {
			17007,						-- Leader of the Pack
			51470,						-- Ele Oath
			51701,						-- Honor Amoung Thieves
			29801,						-- Rampage
		},

		["ap10"] = {
			30808,						-- Unleashed Rage
			19506,						-- Trueshot Aura
			53138,						-- Abomination's Might
			19740,						-- Blessing of Might
		},

		["spellhaste"] = {
			24907,						-- Moonkin Form
			49868,						-- Shadow Form
			3738,						-- Wrath of Air
		},

		["sp10"] = {
			47236,						-- Demonic Pact
			77746,						-- Totemic Wrath
		},

		["sp6"] = {
			8227,						-- Flametongue
			1459,						-- AI
		},

		["dmg3"] = {
			82930,						-- Arcane Tactics
			34460,						-- Ferocious Insperation
			31876,						-- Communion
		},

		["base5"] = {
			1126,						-- Mark
			20217,						-- Kings
		},

		["str_agi"] = {
			8076,						-- Strength of earth
			57330,						-- Horn of Winter
			6673,						-- Battle Shout
		},

		["stam"] = {
			21562,						-- Fort
			6307,						-- Imp
			469,						-- Commanding
		},

		["mana"] = {
			1459,						-- AI
			54424,						-- Fel
		},

		["armor"] = {
			8072,						-- stoneskin
			465,						-- devotion aura
		},

		-- make this a check list
		-- local resist = {
			-- Ele Resist Totem	--fire, frost nature
			-- Aspect of the wild	--nature
			-- Resistance Aura		--fire, frost, shadow
			-- Kings				-- All
			-- Shadow Protection	-- Shadow, Stacks with kings
			-- Mark				-- All
		-- }

		["pushback"] = {
			19746,						-- Conc aura
			87717,						-- Totem of Tranq
		},

		["mp5"] = {
			54424,						-- Fel
			5677,						-- Mana Spring
			19740,						-- Blessing of Might
		},

		--replenishment
		-- local manaregen = {
			-- Vampiric Touch
			-- Enduring Winter
			-- soul leach
			-- Revitalize
			-- Communion
		-- }
	}
}