local T, C, L = unpack(Tukui) -- Import Functions/Constants, Config, Locales

T.ClassRole = { -- Ripped from ElvUI
	["PALADIN"] = {
		[1] = "Caster",
		[2] = "Tank",
		[3] = "Melee",
	},
	["PRIEST"] = "Caster",
	["WARLOCK"] = "Caster",
	["WARRIOR"] = {
		[1] = "Melee",
		[2] = "Melee",
		[3] = "Tank",
	},
	["HUNTER"] = "Melee",
	["SHAMAN"] = {
		[1] = "Caster",
		[2] = "Melee",
		[3] = "Caster",
	},
	["ROGUE"] = "Melee",
	["MAGE"] = "Caster",
	["DEATHKNIGHT"] = {
		[1] = "Tank",
		[2] = "Melee",
		[3] = "Melee",
	},
	["DRUID"] = {
		[1] = "Caster",
		[2] = "Melee",
		[3] = "Tank",
		[4] = "Caster"
	},
	["MONK"] = {
		[1] = "Tank",
		[2] = "Caster",
		[3] = "Melee",
	},
}