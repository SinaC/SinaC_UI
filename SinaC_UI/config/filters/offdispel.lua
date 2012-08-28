local T, C, L = unpack(Tukui) -- Import Functions/Constants, Config, Locales

local function SpellName(id)
	return select(1, GetSpellInfo(id))
end

T.OffensiveDispels = {
	["MAGE"] = {
		spellID = 30449, -- Spellsteal
		types = { "STEALABLE" } -- Check UnitBuff stealable return value
	},
	["SHAMAN"] = {
		spellID = 370, -- Purge
		types = {"Magic"}
	},
	["PRIEST"] = {
		spellID = 527, -- Dispel Magic
		types = {"Magic"}
	},
	["HUNTER"] = {
		spellID = 19801, -- Tranquilizing shot
		types = {"Magic", "ENRAGE"}
	},
	["DRUID"] = {
		spellID = 2908, -- Soothe
		types = {"ENRAGE"} -- Use enrage list
	},
	["ROGUE"] = {
		spellID = 5938, -- Shiv
		types = {"ENRAGE"}
	}
}

T.EnrageList = {
	-- [SpellName(49016)] = true, -- Unholy Frenzy
	-- [SpellName(76691)] = true, -- Vengeance
	-- [SpellName(5229)] = true, -- Enrage
	-- [SpellName(52610)] = true, -- Savage Roar
	-- [SpellName(48391)] = true, -- Owlkin Frenzy
	-- [SpellName(18499)] = true, -- Berserker Rage
	-- [SpellName(57519)] = true, -- Wrecking Crew
	-- [SpellName(12292)] = true, -- Death Wish
	-- [SpellName(29594)] = true, -- Bastion of Defense
}