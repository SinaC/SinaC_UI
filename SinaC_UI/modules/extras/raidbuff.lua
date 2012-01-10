-- Based on Tukui_RaidbuffPlus by Epicgrim

local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui)
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local print = Private.print
local error = Private.error

-- if true then
	-- print("Raid buff not yet implemented")
	-- return
-- end -- TODO

if C.extras.raidbuff ~= true then return end
if not T.RaidBuffs then return end

if IsAddOnLoaded("Tukui_RaidbuffPlus") then
	print("Tukui_RaidbuffPlus addon found, desactivating built-in raid buff monitor")
	return
end
if IsAddOnLoaded("Tukui_RaidBuffReminder") then
	print("Tukui_RaidBuffReminder addon found, desactivating built-in raid buff monitor")
	return
end

-- Settings
local position = {"TOP", UIParent, "TOP", 0, -3}
local frameSize = 164
local buttonSize = (frameSize - 13) / 7

local FlaskFrame, FoodFrame, Spell3Frame, Spell4Frame, Spell5Frame, Spell6Frame, SpecialBuffFrame
local Spell3Buffs, Spell4Buffs, Spell5Buffs, Spell6Buffs

--Setup Caster Buffs
local function SetCasterOnlyBuffs()
	Spell3Buffs = T.RaidBuffs.casterOnly.spell3
	Spell4Buffs = T.RaidBuffs.casterOnly.spell4
	Spell5Buffs = T.RaidBuffs.casterOnly.spell5
	Spell6Buffs = T.RaidBuffs.casterOnly.spell6
end

--Setup everyone else's buffs
local function SetBuffs()
	Spell3Buffs = T.RaidBuffs.nonCaster.spell3
	Spell4Buffs = T.RaidBuffs.nonCaster.spell4
	Spell5Buffs = T.RaidBuffs.nonCaster.spell5
	Spell6Buffs = T.RaidBuffs.nonCaster.spell6
end


-- Check Player's Role
local RoleUpdater = CreateFrame("Frame")
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:SetScript("OnEvent", function()
	local role = T.CheckRole()
	--If We're a caster we may want to see different buffs
	if role == "Caster" then 
		SetCasterOnlyBuffs() 
	else
		SetBuffs()
	end
 end)

-- we need to check if you have two different elixirs if your not flasked, before we say your not flasked
local function CheckElixir(unit)
	local battleElixired = false
	local guardianElixired = false
	if T.RaidBuffs.battleElixir then
		for _, battleElixirBuff in pairs(T.RaidBuffs.battleElixir) do
			local spellName, _, spellIcon = GetSpellInfo(battleElixirBuff)
			if UnitAura("player", spellName) then
				FlaskFrame.t:SetTexture(spellIcon)
				battleElixired = true
				break
			else
				battleElixired = false
			end
		end
	end

	if T.RaidBuffs.guardianElixir then
		for _, guardianElixirBuff in pairs(T.RaidBuffs.guardianElixir) do
			local spellName, _, spellIcon = GetSpellInfo(guardianElixirBuff)
			if UnitAura("player", spellName) then
				guardianElixired = true
				if not battleElixired then
					FlaskFrame.t:SetTexture(spellIcon)
				end
				break
			else
				guardianElixired = false
			end
		end
	end

	if guardianElixired == true and battleElixired == true then
		FlaskFrame:SetAlpha(1)
		return
	else
		FlaskFrame:SetAlpha(0.2)
	end
end

local function SetIcon(buffList, frame)
	local found = false
	if not buffList then return found end
	frame.t:SetTexture(select(3, GetSpellInfo(buffList[1])))
	frame:SetAlpha(0.2)
	for i, buff in pairs(buffList) do
		local spellName, _, spellIcon = GetSpellInfo(buff)
		if UnitAura("player", spellName) then
			frame:SetAlpha(1)
			frame.t:SetTexture(spellIcon)
			found = true
			break
		end
	end
	return found
end

--Main Script
local function RaidBuffReminderOnAuraChange(self, event, arg1, unit)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance = IsInInstance()
		if inInstance then
			self:Show()
		else
			self:Hide()
		end
	end
	if event == "UNIT_AURA" and arg1 ~= "player" then 
		return
	end

	if SetIcon(T.RaidBuffs.flask, FlaskFrame) == false then
		CheckElixir()
	end
	SetIcon(T.RaidBuffs.food, FoodFrame)
	SetIcon(Spell3Buffs, Spell3Frame)
	SetIcon(Spell4Buffs, Spell4Frame)
	SetIcon(Spell5Buffs, Spell5Frame)
	SetIcon(Spell6Buffs, Spell6Frame)
	SetIcon(T.RaidBuffs.special, SpecialBuffFrame)
end

--Create the Main bar
local raidBuffReminder = CreateFrame("Frame", "TukuiRaidBuffReminderFrame", UIParent)
raidBuffReminder:CreatePanel("Default", frameSize, buttonSize + 4, unpack(position))
raidBuffReminder:SetFrameLevel(Minimap:GetFrameLevel() + 2)
raidBuffReminder:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
raidBuffReminder:RegisterEvent("UNIT_INVENTORY_CHANGED")
raidBuffReminder:RegisterEvent("UNIT_AURA")
raidBuffReminder:RegisterEvent("PLAYER_REGEN_ENABLED")
raidBuffReminder:RegisterEvent("PLAYER_REGEN_DISABLED")
raidBuffReminder:RegisterEvent("PLAYER_ENTERING_WORLD")
raidBuffReminder:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
raidBuffReminder:RegisterEvent("CHARACTER_POINTS_CHANGED")
raidBuffReminder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
raidBuffReminder:SetScript("OnEvent", RaidBuffReminderOnAuraChange)


--Function to create buttons
local function CreateButton(relativeTo)
	local button = CreateFrame("Frame", nil, raidBuffReminder)
	if not relativeTo then
		button:CreatePanel("Default", buttonSize, buttonSize, "LEFT", raidBuffReminder, "LEFT", 2, 0)
	else
		button:CreatePanel("Default", buttonSize, buttonSize, "LEFT", relativeTo, "RIGHT", 1, 0)
	end
	button:SetFrameLevel(raidBuffReminder:GetFrameLevel() + 2)

	button.t = button:CreateTexture(nil, "OVERLAY")
	button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.t:Point("TOPLEFT", 2, -2)
	button.t:Point("BOTTOMRIGHT", -2, 2)
	return button
end

--Create Buttons
do
	FlaskFrame = CreateButton()
	FoodFrame = CreateButton(FlaskFrame)
	Spell3Frame = CreateButton(FoodFrame)
	Spell4Frame = CreateButton(Spell3Frame)
	Spell5Frame = CreateButton(Spell4Frame)
	Spell6Frame = CreateButton(Spell5Frame)
	SpecialBuffFrame = CreateButton(Spell6Frame)
end

-----------------------------------------------------------------------------------------------
-- Adding in ALL RAID BUFFS

local BigButtons = {}
local LittleButtons = {}

local function LabelType(buffType)
	local key = "raidbuff_" .. buffType
	local value = L[key]
	if not value then value = "ERROR" end
	return value
end
-------------------------
-- Buff Check Functions
-------------------------
local function RaidBuffSummaryOnAuraChange(self, event, arg1, unit)
	for key, value in pairs(T.RaidBuffs.allBuffs) do
		for i, v in ipairs(value) do
			local spellname = select(1, GetSpellInfo(v))
			local littleButtonName = key.."mini"..i
			local littleButton = LittleButtons[littleButtonName]
			littleButton.spell = v
			if UnitAura("player", spellname) then
				littleButton:SetAlpha(1)
			else
				littleButton:SetAlpha(0.2)
			end
		end

		for i, v in ipairs(value) do
			local spellname = select(1, GetSpellInfo(v))
			local bigButtonName = key.."Frame"
			local bigButton = BigButtons[bigButtonName]
			bigButton.spell = v
			if UnitAura("player", spellname) then
				bigButton:SetAlpha(1)
				-- bigButton.t:SetDesaturated(nil)
				bigButton.t:SetTexture(select(3, GetSpellInfo(v)))
				break
			else
				bigButton:SetAlpha(0.2)
				-- bigButton.t:SetDesaturated(1)
				bigButton.t:SetTexture(select(3, GetSpellInfo(v)))
			end
		end
	end
end

local raidBuffSummary = CreateFrame("Frame", "TukuiRaidBuffSummaryFrame", UIParent)
raidBuffSummary:CreatePanel("Default", 435, 425, "TOP", raidBuffReminder, "BOTTOM", 0, -3)
raidBuffSummary:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
raidBuffSummary:RegisterEvent("UNIT_INVENTORY_CHANGED")
raidBuffSummary:RegisterEvent("UNIT_AURA")
raidBuffSummary:RegisterEvent("PLAYER_REGEN_ENABLED")
raidBuffSummary:RegisterEvent("PLAYER_REGEN_DISABLED")
raidBuffSummary:RegisterEvent("PLAYER_ENTERING_WORLD")
raidBuffSummary:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
raidBuffSummary:RegisterEvent("CHARACTER_POINTS_CHANGED")
raidBuffSummary:RegisterEvent("ZONE_CHANGED_NEW_AREA")
raidBuffSummary:SetScript("OnEvent", RaidBuffSummaryOnAuraChange)
raidBuffSummary:Hide()

--DERP BLIZZ, cant make good spell id's
local str = "spell:%s"
local BadTotems = {
	[8076] = 8075,
	[8972] = 8071,
	[5677] = 5675,
}
local function SetupTooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)

	if BadTotems[self.spell] then
		GameTooltip:SetHyperlink(format(str, BadTotems[self.spell]))
	else
		GameTooltip:SetHyperlink(format(str, self.spell))
	end

	GameTooltip:Show()
end

local function CreateBuffArea(buffType, relativeTo, column)
	local bigButtonName = buffType.."Frame"
	local bigButton = CreateFrame("Frame", nil, raidBuffSummary)
	if column == 1 then
		bigButton:CreatePanel("Default", 40, 40, "TOPLEFT", raidBuffSummary, "TOPLEFT", 14, -14)
	elseif column == 2 then
		bigButton:CreatePanel("Default", 40, 40, "TOPLEFT", raidBuffSummary, "TOPLEFT", 250, -14)
	else
		bigButton:CreatePanel("Default", 40, 40, "TOPLEFT", relativeTo, "BOTTOMLEFT", 0, -16)
	end
	bigButton.t = bigButton:CreateTexture(nil, "OVERLAY")
	bigButton.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	bigButton.t:Point("TOPLEFT", 2, -2)
	bigButton.t:Point("BOTTOMRIGHT", -2, 2)

	bigButton.text = bigButton:CreateFontString(nil, "OVERLAY")
	bigButton.text:SetPoint("TOPLEFT", bigButton, "TOPRIGHT", 3, -1)
	bigButton.text:SetFont(C.media.font, 16)
	bigButton.text:SetText(LabelType(buffType))

	bigButton:EnableMouse(true)
	bigButton:SetScript("OnEnter", SetupTooltip)
	bigButton:SetScript("OnLeave", GameTooltip_Hide)

	BigButtons[bigButtonName] = bigButton

	local previous = nil
	for i, v in pairs(T.RaidBuffs.allBuffs[buffType]) do
		local littleButtonName = buffType.."mini"..i
		local littleButton = CreateFrame("Frame", nil, raidBuffSummary)
		if i == 1 then
			littleButton:CreatePanel("Default", 20, 20, "BOTTOMLEFT", bigButton, "BOTTOMRIGHT", 3, 0)
		else
			littleButton:CreatePanel("Default", 20, 20, "LEFT", previous, "RIGHT", 3, 0)
		end
		littleButton.t = littleButton:CreateTexture(nil, "OVERLAY")
		littleButton.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		littleButton.t:Point("TOPLEFT", 2, -2)
		littleButton.t:Point("BOTTOMRIGHT", -2, 2)
		littleButton.t:SetTexture(select(3, GetSpellInfo(v)))

		littleButton:EnableMouse(true)
		littleButton:SetScript("OnEnter", SetupTooltip)
		littleButton:SetScript("OnLeave", GameTooltip_Hide)

		LittleButtons[littleButtonName] = littleButton
		previous = littleButton
	end

	return bigButton
end

--ORDER MATTERS!
local melee10Frame = CreateBuffArea("melee10", nil, 1)
local crit5Frame = CreateBuffArea("crit5", melee10Frame, nil)
local ap10Frame = CreateBuffArea("ap10", crit5Frame, nil)
local spellHasteFrame = CreateBuffArea("spellhaste", ap10Frame, nil)
local sp10Frame = CreateBuffArea("sp10", spellHasteFrame, nil)
local sp6Frame = CreateBuffArea("sp6", sp10Frame, nil)
local dmg3Frame = CreateBuffArea("dmg3", sp6Frame, nil)
local base5Frame = CreateBuffArea("base5", dmg3Frame, 2)
local strAgiFrame = CreateBuffArea("str_agi", base5Frame, nil)
local stamFrame = CreateBuffArea("stam", strAgiFrame, nil)
local manaFrame = CreateBuffArea("mana", stamFrame, nil)
local armorFrame = CreateBuffArea("armor", manaFrame, nil)
local pushbackFrame = CreateBuffArea("pushback", armorFrame, nil)
local mp3Frame = CreateBuffArea("mp5", pushbackFrame, nil)

local raidBuffToggle = CreateFrame("Frame", "TukuiRaidBuffToggleFrame", raidBuffReminder)
raidBuffToggle:CreatePanel("Default", raidBuffReminder:GetWidth(), 18, "TOP", raidBuffReminder, "BOTTOM", 0, -1)
raidBuffToggle.text = raidBuffToggle:CreateFontString(nil, "OVERLAY")
raidBuffToggle.text:SetPoint("CENTER")
raidBuffToggle.text:SetFont(C.media.font, 12)
raidBuffToggle.text:SetText(L.raidbuff_viewall)
raidBuffToggle:SetAlpha(0)

local function ToggleRaidBuffs()
	if raidBuffSummary:IsShown() then
		raidBuffSummary:Hide()
		raidBuffToggle:ClearAllPoints()
		raidBuffToggle:Point("TOP", raidBuffReminder, "BOTTOM", 0, -1)
		raidBuffToggle.text:SetText(L.raidbuff_viewall)
		raidBuffToggle:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
		raidBuffToggle:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
	else
		raidBuffSummary:Show()
		raidBuffToggle:ClearAllPoints()
		raidBuffToggle:Point("BOTTOM", raidBuffSummary, "BOTTOM", 0, 5)
		raidBuffToggle.text:SetText(L.raidbuff_minimizeall)
		raidBuffToggle:SetScript("OnEnter", nil)
		raidBuffToggle:SetScript("OnLeave", nil)
	end
end
raidBuffToggle:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
raidBuffToggle:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
raidBuffToggle:SetScript("OnMouseDown", ToggleRaidBuffs)