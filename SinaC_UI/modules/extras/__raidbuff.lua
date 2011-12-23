local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui)
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local print = Private.print
local error = Private.error

if true then
	print("Raid buff not yet implemented")
	return
end -- TODO

if C.raidbuff.enable ~= true then return end

if IsAddOnLoaded("Tukui_RaidbuffPlus") then
	print("Tukui_RaidbuffPlus addon found, desactivating built-in raid buff")
	return
end
if IsAddOnLoaded("Tukui_RaidBuffReminder") then
	print("Tukui_RaidBuffReminder addon found, desactivating built-in raid buff")
	return
end

-- Settings
local position = {"TOP", UIParent, "TOP", 0, -3}
local frameSize = 164
local buttonSize = (frameSize - 13) / 7

local specialBuffs = {
	80398 -- Dark Intent
}
local flaskBuffs = {
	94160, --"Flask of Flowing Water"
	79469, --"Flask of Steelskin"
	79470, --"Flask of the Draconic Mind"
	79471, --"Flask of the Winds
	79472, --"Flask of Titanic Strength"
	79638, --"Flask of Enhancement-STR"
	79639, --"Flask of Enhancement-AGI"
	79640, --"Flask of Enhancement-INT"
	92679, --Flask of battle
}
local battleElixirBuffs = {
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
}
local guardianElixirBuffs = {
	79480, --Armor
	79631, --Resistance+90
}
local foodBuffs = {
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
}

local spell3Buffs, spell4Buffs, spell5Buffs, spell6Buffs
--Setup Caster Buffs
local function SetCasterOnlyBuffs()
	spell3Buffs = { --Total Stats
		1126, -- "Mark of the wild"
		90363, --"Embrace of the Shale Spider"
		20217, --"Greater Blessing of Kings",
	}
	spell4Buffs = { --Total Stamina
		469, -- Commanding
		6307, -- Blood Pact
		90364, -- Qiraji Fortitude
		72590, -- Drums of fortitude
		21562, -- Fortitude
	}
	spell5Buffs = { --Total Mana
		61316, --"Dalaran Brilliance"
		1459, --"Arcane Brilliance"
	}
	spell6Buffs = { --Mana Regen
		5675, --"Mana Spring Totem"
		19740, --"Blessing of Might"
	}
end

--Setup everyone else's buffs
local function SetBuffs()
	spell3Buffs = { --Total Stats
		1126, -- "Mark of the wild"
		90363, --"Embrace of the Shale Spider"
		20217, --"Greater Blessing of Kings",
	}
	spell4Buffs = { --Total Stamina
		469, -- Commanding
		6307, -- Blood Pact
		90364, -- Qiraji Fortitude
		72590, -- Drums of fortitude
		21562, -- Fortitude
	}
	spell5Buffs = { --Total Mana
		61316, --"Dalaran Brilliance"
		1459, --"Arcane Brilliance"
	}
	spell6Buffs = { --Total AP
		30808, --"Unleashed Rage"
		53138, --Abom Might
		19506, --Trushot
		19740, --"Blessing of Might"
	}
end

-- Check Player's Role
local RoleUpdater = CreateFrame("Frame")
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:SetScript("OnEvent", function() Role = T.CheckRole() end)

-- Buttons
local FlaskButton
local FoodButton
local Spell3Button
local Spell4Button
local Spell5Button
local Spell6Button
local SpecialButton

local function SetFrameIcon(frame, buffList, firstAsDefault)
	if buffList then
		for _, buff in pairs(buffList) do
			local spellName, _, spellIcon = GetSpellInfo(buff)
			if UnitAura("player", spellName) then
				frame.texture:SetTexture(spellIcon)
				frame:SetAlpha(1)
				return true
			end
		end
		if firstAsDefault and buffList[1] then
			local spellIcon = select(3, GetSpellInfo(buffList[1]))
			frame.texture:SetTexture(spellIcon)
		end
	end
	frame:SetAlpha(0.2)
	return false
end

-- we need to check if you have two different elixirs if your not flasked, before we say your not flasked
local function CheckElixir()
	local battleElixired = SetFrameIcon(FlaskButton, battleElixirBuffs, false)
	local guardianElixired = SetFrameIcon(FlaskButton, guardianElixirBuffs, false)

	if guardianElixired == true and battleElixired == true then
		FlaskButton:SetAlpha(1)
	else
		FlaskButton:SetAlpha(0.2)
	end
end

--Main Script
local function RaidBuffReminderAuraChange(self, event, arg1)
	if event == "UNIT_AURA" and arg1 ~= "player" then 
		return
	end

	--If We're a caster we may want to see different buffs
	if Role == "Caster" then 
		SetCasterOnlyBuffs() 
	else
		SetBuffs()
	end

	--Start checking buffs to see if we can find a match from the list
	local flasked = SetFrameIcon(FlaskButton, flaskBuffs, false)
	if not flasked then
		CheckElixir()
	end

	SetFrameIcon(FoodButton, foodBuffs, true)
	SetFrameIcon(Spell3Button, spell3Buffs, true)
	SetFrameIcon(Spell4Button, spell4Buffs, true)
	SetFrameIcon(Spell5Button, spell5Buffs, true)
	SetFrameIcon(Spell6Button, spell6Buffs, true)
	SetFrameIcon(SpecialButton, specialBuffs, true)
end

--Create the Main bar
local RaidBuffReminder = CreateFrame("Frame", nil, UIParent)
RaidBuffReminder:CreatePanel("Default", frameSize, buttonSize + 4, "TOP", UIParent, "TOP", 0, -3)
RaidBuffReminder:Point(unpack(position))
RaidBuffReminder:SetFrameLevel(Minimap:GetFrameLevel() + 2)
RaidBuffReminder:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RaidBuffReminder:RegisterEvent("UNIT_INVENTORY_CHANGED")
RaidBuffReminder:RegisterEvent("UNIT_AURA")
RaidBuffReminder:RegisterEvent("PLAYER_REGEN_ENABLED")
RaidBuffReminder:RegisterEvent("PLAYER_REGEN_DISABLED")
RaidBuffReminder:RegisterEvent("PLAYER_ENTERING_WORLD")
RaidBuffReminder:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RaidBuffReminder:RegisterEvent("CHARACTER_POINTS_CHANGED")
RaidBuffReminder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
RaidBuffReminder:SetScript("OnEvent", RaidBuffReminderAuraChange)

--Function to create buttons
local function CreateButton(button, parent, relativeTo, firstbutton)
	local button = CreateFrame("Frame", nil, parent)
	if firstbutton == true then
		button:CreatePanel("Default", buttonSize, buttonSize, "LEFT", relativeTo, "LEFT", 2, 0)
	else
		button:CreatePanel("Default", buttonSize, buttonSize, "LEFT", relativeTo, "RIGHT", 1, 0)
	end
	button:SetFrameLevel(parent:GetFrameLevel() + 2)

	button.texture = button:CreateTexture(nil, "OVERLAY")
	button.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.texture:Point("TOPLEFT", 2, -2)
	button.texture:Point("BOTTOMRIGHT", -2, 2)
	return button
end

--Create Buttons
FlaskButton = CreateButton(RaidBuffReminder, RaidBuffReminder, true)
FoodButton = CreateButton(FlaskButton, RaidBuffReminder, false)
Spell3Button = CreateButton(FoodButton, RaidBuffReminder, false)
Spell4Button = CreateButton(Spell3Button, RaidBuffReminder, false)
Spell5Button = CreateButton(Spell4Button, RaidBuffReminder, false)
Spell6Button = CreateButton(Spell5Button, RaidBuffReminder, false)
SpecialButton = CreateButton(Spell6Button, RaidBuffReminder, false)

-- Adding in ALL RAID BUFFS
local AllBuffs = {
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

local function LabelType(buffType) -- TODO: localization
	if buffType == "melee10" then
		return "10% Melee Attack Speed"
	elseif buffType == "crit5" then
		return "5% Crit"
	elseif buffType == "ap10" then
		return "10% Attack Power"
	elseif buffType == "spellhaste" then
		return "5% Spell Haste"
	elseif buffType == "sp10" then
		return "10% Spell Power"
	elseif buffType == "sp6" then
		return "6% Spell Power"
	elseif buffType == "dmg3" then
		return "3% Damage"
	elseif buffType == "base5" then
		return "5% All Base Stats"
	elseif buffType == "str_agi" then
		return "Strength and Agility"
	elseif buffType == "stam" then
		return "Stamina"
	elseif buffType == "mana" then
		return "Maximum Mana"
	elseif buffType == "armor" then
		return "Armor"
	elseif buffType == "pushback" then
		return "Spell Pushback"
	elseif buffType == "mp5" then
		return "Mana Per 5s"
	else
		return "ERROR"
	end
end

-------------------------
-- Buff Check Functions
-------------------------
local BigButtons = {}
local MiniButtons = {}

local function RaidBuffSummaryAuraChange(self, event, arg1)
	for key, value in pairs(AllBuffs) do
		for i, v in ipairs(value) do
			local name = key.."mini"..i
			local miniButton = MiniButtons[name]
			local spellName = select(1, GetSpellInfo(v))
			miniButton.spell = v
			if UnitAura("player", spellName) then
				miniButton:SetAlpha(1)
			else
				miniButton:SetAlpha(0.2)
			end
		end

		local name = key.."Frame"
		local bigButton = BigButtons[name]
		for _, v in ipairs(value) do
			local spellName, _, spellIcon = GetSpellInfo(v)
			bigButton.spell = v
			if UnitAura("player", spellName) then
				bigButton:SetAlpha(1)
				-- _G[key.."Frame"].texture:SetDesaturated(nil)
				bigButton.texture:SetTexture(spellIcon)
				break
			else
				bigButton:SetAlpha(0.2)
				-- _G[key.."Frame"].texture:SetDesaturated(1)
				bigButton.texture:SetTexture(spellIcon)
			end
		end
	end
end

local RaidBuffSummary = CreateFrame("Frame", nil, UIParent)
RaidBuffSummary:CreatePanel("Default", 435, 425, "TOP", RaidBuffReminder, "BOTTOM", 0, -3)
RaidBuffSummary:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RaidBuffSummary:RegisterEvent("UNIT_INVENTORY_CHANGED")
RaidBuffSummary:RegisterEvent("UNIT_AURA")
RaidBuffSummary:RegisterEvent("PLAYER_REGEN_ENABLED")
RaidBuffSummary:RegisterEvent("PLAYER_REGEN_DISABLED")
RaidBuffSummary:RegisterEvent("PLAYER_ENTERING_WORLD")
RaidBuffSummary:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RaidBuffSummary:RegisterEvent("CHARACTER_POINTS_CHANGED")
RaidBuffSummary:RegisterEvent("ZONE_CHANGED_NEW_AREA")
RaidBuffSummary:SetScript("OnEvent", RaidBuffSummaryAuraChange)

--DERP BLIZZ, cant make good spell id's
local strFormat = "spell:%s"
local BadTotems = {
	[8076] = 8075,
	[8972] = 8071,
	[5677] = 5675,
}
local function SetupTooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)
	if BadTotems[self.spell] then
		GameTooltip:SetHyperlink(format(strFormat, BadTotems[self.spell]))
	else
		GameTooltip:SetHyperlink(format(strFormat, self.spell))
	end
	GameTooltip:Show()
end

local function CreateBuffArea(buffType, relativeTo, column)
	local bigButtonName = buffType.."Frame"
	local bigButton = CreateFrame("Frame", nil, RaidBuffSummary)
	if column == 1 then
		bigButton:CreatePanel("Default", 40, 40, "TOPLEFT", relativeTo, "TOPLEFT", 14, -14)
	elseif column == 2 then
		bigButton:CreatePanel("Default", 40, 40, "TOPLEFT", relativeTo, "TOPLEFT", 250, -14)
	else
		bigButton:CreatePanel("Default", 40, 40, "TOPLEFT", relativeTo, "BOTTOMLEFT", 0, -16)
	end
	bigButton.texture = bigButton:CreateTexture(nil, "OVERLAY")
	bigButton.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	bigButton.texture:Point("TOPLEFT", 2, -2)
	bigButton.texture:Point("BOTTOMRIGHT", -2, 2)

	bigButton.text = bigButton:CreateFontString(nil, "OVERLAY")
	bigButton.text:SetPoint("TOPLEFT", bigButton, "TOPRIGHT", 3, -1)
	bigButton.text:SetFont(C.media.font, 16)
	bigButton.text:SetText(LabelType(buffType)) -- TODO: localization

	bigButton:EnableMouse(true)
	bigButton:SetScript("OnEnter", SetupTooltip)
	bigButton:SetScript("OnLeave", GameTooltip_Hide)

	BigButtons[bigButtonName] = bigButton

	local previous = nil
	for i, v in pairs(AllBuffs[buffType]) do
		local spellIcon = select(3, GetSpellInfo(v))
		local miniButtonName = buffType.."mini"..i
		local miniButton = CreateFrame("Frame", nil, RaidBuffSummary)
		if i == 1 then
			miniButton:CreatePanel("Default", 20, 20, "BOTTOMLEFT", bigButton, "BOTTOMRIGHT", 3, 0)
		else
			miniButton:CreatePanel("Default", 20, 20, "LEFT", previous, "RIGHT", 3, 0)
		end
		miniButton.texture = miniButton:CreateTexture(nil, "OVERLAY")
		miniButton.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		miniButton.texture:Point("TOPLEFT", 2, -2)
		miniButton.texture:Point("BOTTOMRIGHT", -2, 2)
		miniButton.texture:SetTexture(spellIcon)

		miniButton:EnableMouse(true)
		miniButton:SetScript("OnEnter", SetupTooltip)
		miniButton:SetScript("OnLeave", GameTooltip_Hide)

		MiniButtons[miniButtonName] = miniButton
		previous = miniButton
	end
end

--ORDER MATTERS!
local Melee10Frame = CreateBuffArea("melee10", RaidBuffSummary, 1)
local Crit5Frame = CreateBuffArea("crit5", Melee10Frame)
local AP10Frame = CreateBuffArea("ap10", Crit5Frame)
local SpellHasteFrame = CreateBuffArea("spellhaste", AP10Frame)
local SP10Frame = CreateBuffArea("sp10", SpellHasteFrame)
local SP6Frame = CreateBuffArea("sp6", SP10Frame)
local Dmg3Frame = CreateBuffArea("dmg3", SP6Frame)
local Base5Frame = CreateBuffArea("base5", RaidBuffSummary, 2)
local StrAgiFrame = CreateBuffArea("str_agi", Base5Frame)
local StamFrame = CreateBuffArea("stam", StrAgiFrame)
local ManaFrame = CreateBuffArea("mana", StamFrame)
local ArmorFrame = CreateBuffArea("armor", ManaFrame)
local PushbackFrame = CreateBuffArea("pushback", ArmorFrame)
local MP5Frame = CreateBuffArea("mp5", PushbackFrame)

RaidBuffSummary:Hide()

local RaidBuffToggle = CreateFrame("Frame", nil, RaidBuffReminder)
RaidBuffToggle:CreatePanel("Default", RaidBuffReminder:GetWidth(), 18, "TOP", RaidBuffReminder, "BOTTOM", 0, -1)
RaidBuffToggle.text = RaidBuffToggle:CreateFontString(nil, "OVERLAY")
RaidBuffToggle.text:SetPoint("CENTER")
RaidBuffToggle.text:SetFont(C.media.font, 12)
RaidBuffToggle.text:SetText("View All Raid Buffs") -- TODO: localization
RaidBuffToggle:SetAlpha(0)
RaidBuffToggle:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
RaidBuffToggle:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
RaidBuffToggle:SetScript("OnMouseDown", function()
	if RaidBuffSummary:IsShown() then
		RaidBuffSummary:Hide()
		RaidBuffToggle:ClearAllPoints()
		RaidBuffToggle:Point("TOP", RaidBuffReminder, "BOTTOM", 0, -1)
		RaidBuffToggle.text:SetText("View All Raid Buffs") -- TODO: localization
		RaidBuffToggle:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
		RaidBuffToggle:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
	else
		RaidBuffSummary:Show()
		RaidBuffToggle:ClearAllPoints()
		RaidBuffToggle:Point("BOTTOM", RaidBuffSummary, "BOTTOM", 0, 5)
		RaidBuffToggle.text:SetText("Minimize All Raid Buffs") -- TODO: localization
		RaidBuffToggle:SetScript("OnEnter", nil)
		RaidBuffToggle:SetScript("OnLeave", nil)
	end
end)