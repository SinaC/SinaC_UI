local T, C, L = unpack(Tukui)

T.RaidBuffs = {
	-- http://www.wowhead.com/guide=1100
	["Stats"] = {
		[1126] = "DRUID",			-- Mark of The Wild
		[20217] = "PALADIN",		-- Blessing Of Kings
		[90363] = "HUNTER",			-- Embrace of the Shale Spider
		[117667] = "MONK",			-- Legacy of The Emperor
		["default"] = 20217,
		["name"] = L.raidbuff_stats
	},
	["Stamina"] = {
		[469] = "WARRIOR",			-- Commanding Shout
		[6307] = "WARLOCK",			-- Imp. Blood Pact
		[21562] = "PRIEST",			-- Power Word: Fortitude
		[90364] = "HUNTER",			-- Qiraji Fortitude
		["default"] = 21562,
		["name"] = L.raidbuff_stamina
	},
	["AttackPower"] = {
		[6673] = "WARRIOR",			-- Battle Shout
		[19506] = "HUNTER",			-- Trueshot Aura
		[57330] = "DEATHKNIGHT",	-- Horn of Winter
		["default"] = 57330,
		["name"] = L.raidbuff_attackpower
	},
	["SpellPower"] = {
		[1459] = "MAGE",			-- Arcane Brilliance
		[61316] = "MAGE",			-- Dalaran Brilliance
		[77747] = "SHAMAN",			-- Burning Wrath -- NOT DISPLAYED
		[109773] = "WARLOCK",		-- Dark Intent
		[126309] = "HUNTER",		-- Still Water
		["default"] = 1459,
		["name"] = L.raidbuff_spellpower
	},
	["AttackSpeed"] = {
		[30809] = "SHAMAN",			-- Unleashed Rage
		[55610] = "DEATHKNIGHT",	-- Unholy aura
		[113742] = "ROGUE",			-- Swiftblade"s Cunning
		[128432] = "HUNTER",		-- Cackling Howl
		[128433] = "HUNTER",		-- Serpent"s Swiftness
		["default"] = 55610,
		["name"] = L.raidbuff_attackspeed
	},
	["SpellHaste"] = {
		[15473] = "PRIEST",			-- Shadowform
		[24907] = "DRUID",			-- Moonkin Aura
		[49868] = "PRIEST",			-- Mind Quickening
		[51470] = "SHAMAN",			-- Elemental Oath
		["default"] = 49868,
		["name"] = L.raidbuff_spellhaste
	},
	["CriticalStrike"] = {
		[1459] = "MAGE",			-- Arcane Brilliance
		[24932] = "DRUID",			-- Leader of The Pact
		[24604] = "HUNTER",			-- Furious Howl
		[61316] = "MAGE",			-- Dalaran Brilliance
		[90309] = "HUNTER",			-- Terrifying Roar
		[97229] = "HUNTER",			-- Bellowing Roar
		[116781] = "MONK",			-- Legacy of the White Tiger
		[126309] = "HUNTER",		-- Still Water
		[126373] = "HUNTER",		-- Fearless Roar
		["default"] = 116781,
		["name"] = L.raidbuff_criticalstrike
	},
	["Mastery"] = {
		[19740] = "PALADIN",		-- Blessing of Might
		[93435] = "HUNTER",			-- Roar of Courage
		[128997] = "HUNTER",		-- Spirit Beast Blessing
		[116956] = "SHAMAN",		-- Grace of Air -- NOT DISPLAYED
		["default"] = 19740,
		["name"] = L.raidbuff_mastery
	},
	-- http://www.wowhead.com/items=0.3
	["Flask"] = {
		[105696] = "1000 STR",		-- Flask of Winter's Bite (76088)
		[105689] = "1000 AGI",		-- Flask of Spring Blossoms (76084)
		[105691] = "1000 INT",		-- Flask of the Warm Sun (76085)
		[105693] = "1000 SPI",		-- Flask of Falling Leaves (76086)
		[105694] = "1500 STA",		-- Flask of the Earth (76087)
		[105617] = "3420 STAT",		-- Alchemist's Flask (75525) Agility, Strength, or Intellect
		["default"] = 105617,
		["name"] = L.raidbuff_flask
	},
	-- http://www.wowhead.com/items=0.2
	["Elixir"] = {
		[105681] = "2250 AC",		-- Mantid Elixir (76075)
		[105682] = "750 CRIT",		-- Mad Hozen Elixir (76076)
		[105683] = "750 EXP",		-- Elixir of Weaponry (76077)
		[105684] = "750 HASTE",		-- Elixir of the Rapids (76078)
		[105685] = "750 SPI",		-- Elixir of Peace (76079)
		[105686] = "750 HIT",		-- Elixir of Perfection (76080)
		[105687] = "750 DODGE",		-- Elixir of Mirrors (76081)
		[105688] = "750 MAST",		-- Monk's Elixir (76083)
		["default"] = 105681,
		["name"] = L.raidbuff_elixir
	},
	-- http://www.wowhead.com/items=0.5
	["Food"] = {
		-- TODO: Banquet:
		--	Grill: 87226, 87228		STR 250+25
		--	Wok: 87230, 87232		AGI 250+25
		--	Brew: 87246, 87248		??? 250+25
		--	Oven: 87242, 87244		STA 250+25
		--	Steamer: 87238, 87240	SPI 250+25
		--	Pot: 87234, 87236		INT 250+25
		--	Pandaren: 74919, 75016	275 one stat
		--	Chao Cookies: 88586		275 one state

		[104272] = "300 STR",		-- Black Pepper Ribs and Shrimp (74646)
		[104271] = "275 STR",		-- Eternal Blossom Fish (74645)
		[104267] = "250 STR",		-- Charbroiled Tiger Steak (74642)

		[104275] = "300 AGI",		-- Sea Mist Rice Noodles (74648)
		[104274] = "275 AGI",		-- Valley Stir Fry (74647)
		[104273] = "250 AGI",		-- Sauteed Carrots (74643)

		[104277] = "300 INT",		-- Mogu Fish Stew (74650)
		[104276] = "275 INT",		-- Braised Turtle (74649)
		[104264] = "250 INT",		-- Swirling Mist Soup (74644)

		[104280] = "300 SPI",		-- Steamed Crab Surprise (74653)
		[104279] = "275 SPI",		 -- Fire Spirit Salmon (74652)
		[104278] = "250 SPI",		-- Shrimp Dumplings (74651)

		[104283] = "450 STA",		-- Chun Tian Spring Rolls (74656)
		[104282] = "415 STA",		-- Twin Fish Platter (74655)
		[104281] = "375 STA",		-- Wildfowl Roast (74654)

		[124219] = "300 MAST",		-- Pearl Milk Tea (81414)
		[124213] = "100 MAST",		-- Roasted Barley Tea (81406)
		[131828] = "100 MAST",		-- Mah's Warm Yak-Tail Stew (90457)

		[125113] = "300 HIT",		-- Spicy Salmon (86073)
		[125106] = "275 HIT",		-- Wildfowl Ginseng Soup (86070)
		[124221] = "200 HIT",		-- Skewered Peanut Chicken (81413)
		[124215] = "100 HIT",		-- Boiled Silkworm Pupa (81405)

		[125115] = "300 EXP",		-- Spicy Vegetable Chips (86074)
		[125108] = "275 EXP",		-- Rice Pudding (86069)

		[124220] = "200 DODGE",		-- Blanched Needle Mushrooms (81412)
		[124214] = "100 DODGE",		-- Dried Needle Mushrooms (81404)

		[125071] = "200 PARRY",		-- Peach Pie (81411)
		[125070] = "100 PARRY",		-- Dried Peaches (81403)

		[124218] = "200 CRIT",		-- Green Curry Fish (81410)
		[124212] = "100 CRIT",		-- Toasted Fish Jerky (81402)

		[124217] = "200 HASTE",		-- Tangy Yogurt (81409)
		[124211] = "100 HASTE",		-- Yak Cheese Curds (81401)

		[124216] = "200 EXP",		-- Red Bean Bun (81408)
		[124210] = "100 EXP",		-- Pounded Rice Cake (81400)

		["default"] = 104283,
		["name"] = "Food&Drinks"
	},
}
--[[
Buffs
=====
Attack Power:
 Warrior - Battle Shout
 Hunter - Trueshot Aura
 Death Knight - Horn of Winter

Crit Chance:
 Mage - Arcane Brilliance
 Druid(Feral, Guardian) - Leader of the Pack
 Hunter - Furious Howl
 Mage - Dalaran Brilliance
 Hunter - Terrifying Roar
 Monk(Windwalker) - Legacy of the White Tiger
 Hunter - Still Water

Mastery:
 Paladin - Blessing of Might
 Hunter - Roar of Courage
 Hunter - Spirit Beast Blessing
 Shaman - Grace of Air

Melee/Ranged Attack Speed:
 Shaman(Enhancement) - Unleashed Rage
 Death Knight(Frost, Unholy) - Unholy Aura
 Rogue - Swiftblade"s Cunning
 Hunter - Cackling Howl
 Hunter - Serpent"s Swiftness

Spell Haste:
 Druid(Balance) - Moonkin Form
 Priest(Shadow) - Shadowform
 Shaman(Elemental) - Elemental Oath

Spellpower:
 Mage - Arcane Brilliance
 Mage - Dalaran Brilliance
 Shaman - Burning Wrath
 Warlock - Dark Intent
 Hunter - Still Water

Stamina:
 Warrior - Commanding Shout
 Warlock-PET - Blood Pact
 Priest - Power Word: Fortitude
 Hunter - Qiraji Fortitude

Stats:
 Druid - Mark of the Wild
 Paladin - Blessing of Kings
 Hunter - Embrace of the Shale Spider
 Monk - Legacy of the Emperor
 
Raid-Haste-Cooldown:
 Mage - Time Warp
 Shaman - Bloodlust

Debuffs
=======
Magic Vulnerability:
 Rogue - Master Poisoner
 Warlock - Curse of the Elements

Mortal Wounds:
 Hunter - Widow Venom
 Rogue - Wound Poison
 Warrior(Arms) - Mortal Strike
 Warrior(Fury) - Wild Strike
 Warlock(Pet) - Mortal Cleave / Legion Strike

Physical Vulnerability:
 Death Knight(Frost) - Brittle Bones
 Death Knight(Unholy) - Ebon Plaguebringer
 Paladin(Retribution) - Judgments of the Bold
 Warrior(Arms,Fury) - Colossus Smash

Slowed Casting Speed:
 Death Knight - Necrotic Strike
 Mage(Arcane) - Slow
 Rogue - Mind-Numbing Poison
 Warlock - Curse of Enfeeblement

Weakened Armor:
 Druid - Faerie Fire
 Rogue - Expose Armor
 Warrior - Sunder Armor

Weakened Blows:
 Death Knight(Blood) - Scarlet Fever
 Druid(Feral,Guardian) - Thrash
 Monk(Brewmaster) - Keg Smash
 Paladin(Prot,Ret) - Hammer of the Righteous
 Warrior - Thunder Clap
--]]

--[[
TOOLS
=====

Combat Res:
 Death Knight - Raise Ally
 Druid - Rebirth
 Warlock - Soulstone

Buff Removal:
 Hunter - Tranquilizing Shot
 Mage - Spellsteal
 Priest - Dispel Magic
 Shaman - Purge
 Warlock-PET - Devour Magic
 Warrior(Protection) - Glyph of Shield Slam
 Death Knight(Glyph) - Glyph of Icy Touch

Curse Removal:
 Druid(Restoration) - Nature"s Cure
 Mage - Remove Curse
 Shaman - Cleanse Spirit

Enrage Removal:
 Druid - Soothe
 Hunter - Tranquilizing Shot
 Rogue - Shiv
Disease Removal:
 Monk - Detox
 Paladin - Cleanse
 Priest(Discipline,Holy) Purify

Magic Removal:
 Druid(Restoration) - Nature"s Cure
 Monk(Mistweaver) - Detox
 Paladin(Holy) - Cleanse
 Priest(Discipline,Holy) - Purify
 Shaman(Restoration) - Purify Spirit

Poison Removal:
 Druid(Restoration) - Nature"s Cure
 Monk - Detox
 Paladin - Cleanse
 --]]
--[[
local T, C, L = unpack(Tukui)

T.RaidBuffs = {
	special = {
		-- 80398 -- Dark Intent
	},
	flask = {
		-- 94160, --"Flask of Flowing Water"
		-- 79469, --"Flask of Steelskin"
		-- 79470, --"Flask of the Draconic Mind"
		-- 79471, --"Flask of the Winds
		-- 79472, --"Flask of Titanic Strength"
		-- 79638, --"Flask of Enhancement-STR"
		-- 79639, --"Flask of Enhancement-AGI"
		-- 79640, --"Flask of Enhancement-INT"
		-- 92679, --Flask of battle
	},
	battleElixir = {
		-- --Scrolls
		-- 89343, --Agility
		-- 63308, --Armor 
		-- 89347, --Int
		-- 89342, --Spirit
		-- 63306, --Stam
		-- 89346, --Strength

		-- --Elixirs
		-- 79481, --Hit
		-- 79632, --Haste
		-- 79477, --Crit
		-- 79635, --Mastery
		-- 79474, --Expertise
		-- 79468, --Spirit
	},
	guardianElixir = {
		-- 79480, --Armor
		-- 79631, --Resistance+90
	},
	food = {
		-- 87545, --90 STR
		-- 87546, --90 AGI
		-- 87547, --90 INT
		-- 87548, --90 SPI
		-- 87549, --90 MAST
		-- 87550, --90 HIT
		-- 87551, --90 CRIT
		-- 87552, --90 HASTE
		-- 87554, --90 DODGE
		-- 87555, --90 PARRY
		-- 87635, --90 EXP
		-- 87556, --60 STR
		-- 87557, --60 AGI
		-- 87558, --60 INT
		-- 87559, --60 SPI
		-- 87560, --60 MAST
		-- 87561, --60 HIT
		-- 87562, --60 CRIT
		-- 87563, --60 HASTE
		-- 87564, --60 DODGE
		-- 87634, --60 EXP
		-- 87554, --Seafood Feast
	},
	casterOnly = {
		spell3 = { --Total Stats
			-- 1126, -- Mark of the Wild
			-- 69378, -- Drums of Forgotten Kings
			-- 90363, -- Embrace of the Shale Spider
			-- 20217, -- Greater Blessing of Kings
		},
		spell4 = { --Total Stamina
			-- 469, -- Commanding
			-- 6307, -- Blood Pact
			-- 90364, -- Qiraji Fortitude
			-- 72590, -- Drums of fortitude
			-- 21562, -- Power Word: Fortitude
		},
		spell5 = { --Total Mana
			-- 61316, -- Dalaran Brilliance
			-- 54424, -- Fel Intelligence
			-- 1459, -- Arcane Brilliance
		},
		spell6 = { --Mana Regen
			-- 19740, -- Blessing of Might
			-- 54424, -- Fel Intelligence
			-- 5675, -- Mana Spring Totem
		}
	},
	nonCaster = {
		spell3 = { --Total Stat
			-- 1126, -- Mark of the Wild
			-- 69378, -- Drums of Forgotten Kings
			-- 90363, -- Embrace of the Shale Spider
			-- 20217, -- Greater Blessing of Kings
		},
		spell4 = { --Total Stamina
			-- 469, -- Commanding
			-- 6307, -- Blood Pact
			-- 90364, -- Qiraji Fortitude
			-- 72590, -- Drums of fortitude
			-- 21562, -- Power Word: Fortitude
		},
		spell5 = { --Total Mana
			-- 61316, -- Dalaran Brilliance
			-- 1459, -- Arcane Brilliance
		},
		spell6 = { --Total AP
			-- 19740, -- Blessing of Might placing it twice because i like the icon better :D code will stop after this one is read, we want this first 
			-- 30808, -- Unleashed Rage 
			-- 53138, -- Abom Might
			-- 19506, -- Trushot
			-- 19740, -- Blessing of Might
		}
	},
	--
	allBuffs = {
		["melee10"] = {
			-- 8512,						-- Windfury Totem
			-- 55610,						-- Improved Icy Talons
			-- 53290,						-- Hunting Party
		},

		["crit5"] = {
			-- 17007,						-- Leader of the Pack
			-- 51470,						-- Elemental Oath
			-- 51701,						-- Honor Among Thieves
			-- 29801,						-- Rampage
		},

		["ap10"] = {
			-- 30808,						-- Unleashed Rage
			-- 19506,						-- Trueshot Aura
			-- 53138,						-- Abomination"s Might
			-- 19740,						-- Blessing of Might
		},

		["spellhaste"] = {
			-- 24907,						-- Moonkin Aura
			-- 49868,						-- Mind Quickening
			-- 3738,						-- Wrath of Air Totem
		},

		["sp10"] = {
			-- 47236,						-- Demonic Pact
			-- 77746,						-- Totemic Wrath
		},

		["sp6"] = {
			-- 8227,						-- Flametongue Totem
			-- 1459,						-- Arcane Brillance
			-- 61316,						-- Dalaran Brilliance
		},

		["dmg3"] = {
			-- 82930,						-- Arcane Tactics
			-- 34460,						-- Ferocious Inspiration
			-- 31876,						-- Communion
		},

		["base5"] = {
			-- 1126,						-- Mark of the Wild
			-- 20217,						-- Blessing of Kings
		},

		["str_agi"] = {
			-- 8076,						-- Strength of earth
			-- 57330,						-- Horn of Winter
			-- 6673,						-- Battle Shout
		},

		["stam"] = {
			-- 21562,						-- Power Word: Fortitude
			-- 6307,						-- Blood Pact
			-- 469,						-- Commanding Shout
		},

		["mana"] = {
			-- 1459,						-- Arcane Brillance
			-- 54424,						-- Fel Intelligence
			-- 61316,						-- Dalaran Brilliance
		},

		["armor"] = {
			-- 8072,						-- stoneskin
			-- 465,						-- Devotion Aura
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
			-- 19746,						-- Conc aura
			-- 87717,						-- Totem of Tranq
		},

		["mp5"] = {
			-- 54424,						-- Fel
			-- 5677,						-- Mana Spring
			-- 19740,						-- Blessing of Might
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
--]]