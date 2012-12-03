-- Based on Tukui_RaidbuffPlus by Epicgrim

-- TODO:
--	left click on bigButton cast spell
--	button to check buff on everyone in the raid (check only food&elixir)
--	flask+elixir (one flask or 2 elixirs)
--	mover

local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui)
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local print = Private.print

if C.raidbuff.enable ~= true then return end
if not T.RaidBuffs then return end

if IsAddOnLoaded("Tukui_RaidBuffs") then
	print("Tukui_RaidBuffs addon found, desactivating built-in raid buff monitor")
	return
end

if IsAddOnLoaded("Tukui_RaidbuffPlus") then
	print("Tukui_RaidbuffPlus addon found, desactivating built-in raid buff monitor")
	return
end
if IsAddOnLoaded("Tukui_RaidBuffReminder") then
	print("Tukui_RaidBuffReminder addon found, desactivating built-in raid buff monitor")
	return
end

if IsAddOnLoaded("RaidBuffsChecker") then
	print("RaidBuffsChecker addon found, desactivating built-in raid buff monitor")
	return
end

-- Settings
local personalCount = 7 -- we're lucky CasterIndex and NonCasterIndex have the same size
local position = {"TOP", UIParent, "TOP", 0, -3}
local buttonSpacing = 2
local buttonSize = 20
local frameSize = (buttonSize * personalCount) + buttonSpacing * (personalCount+1) -- spacing - button - spacing - button - ... - button - spacing
local smallButtonSize = 20
local bigButtonSize = smallButtonSize * 2
local bigButtonSpacing = 14

-- Personal bar
local CasterIndex = {
	[1] = T.RaidBuffs.Stats,
	[2] = T.RaidBuffs.Stamina,
	[3] = T.RaidBuffs.SpellPower,
	[4] = T.RaidBuffs.SpellHaste,
	[5] = T.RaidBuffs.CriticalStrike,
	[6] = T.RaidBuffs.Mastery,
	[7] = T.RaidBuffs.Food
}

local NonCasterIndex = {
	[1] = T.RaidBuffs.Stats,
	[2] = T.RaidBuffs.Stamina,
	[3] = T.RaidBuffs.AttackPower,
	[4] = T.RaidBuffs.AttackSpeed,
	[5] = T.RaidBuffs.CriticalStrike,
	[6] = T.RaidBuffs.Mastery,
	[7] = T.RaidBuffs.Food
}

-- Raid bar
local RaidIndex = {
	[1] = T.RaidBuffs.Stats,
	[2] = T.RaidBuffs.Stamina,
	[3] = T.RaidBuffs.AttackPower,
	[4] = T.RaidBuffs.AttackSpeed,
	[5] = T.RaidBuffs.SpellPower,
	[6] = T.RaidBuffs.SpellHaste,
	[7] = T.RaidBuffs.CriticalStrike,
	[8] = T.RaidBuffs.Mastery
}

-- If unit is affected by a spell from spellList, return spell name, spell icon, return false, default icon otherwise
local function GetIcon(unit, spellList)
	local index = 1
	for spellID in pairs(spellList) do
		if spellID ~= "default" and spellID ~= "name" then
			local spellName, _, spellIcon = GetSpellInfo(spellID)
			assert(spellName, "Incorrect spellID: "..spellID)
			if UnitAura(unit, spellName) then
				return index, spellName, spellIcon, spellID -- found
			end
			index = index+1
		end
	end
	local defaultSpellID = spellList["default"]
	local defaultIcon = select(3, GetSpellInfo(defaultSpellID))
	return 0, "", defaultIcon, defaultSpellID -- not found
end

-----------------------------
-- Personal
-----------------------------
-- Personal index management
local PersonalIndex = NonCasterIndex
local PersonalIndexHandler = CreateFrame("Frame")
PersonalIndexHandler:RegisterEvent("PLAYER_ENTERING_WORLD")
PersonalIndexHandler:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")
PersonalIndexHandler:SetScript("OnEvent", function()
	local role = T.GetRole() -- Caster, Melee, Tank
--print("Role:"..tostring(role))
	if role == "Caster" then
		PersonalIndex = CasterIndex
	else
		PersonalIndex = NonCasterIndex
	end
end)

-- Personal buff checker
local PersonalBuff = CreateFrame("Frame", "TukuiRaidBuffPersonalFrame", TukuiPetBattleHider)
PersonalBuff:SetTemplate()
PersonalBuff:Size(frameSize, buttonSize + 4)
PersonalBuff:Point(unpack(position))
PersonalBuff:SetFrameLevel(Minimap:GetFrameLevel() + 2)
-- Create 6 button frames
PersonalBuff.Buttons = {}
for i = 1, personalCount do
	local button = CreateFrame("Frame", nil, PersonalBuff)
	button:SetTemplate()
	button:Size(buttonSize, buttonSize)
	if i == 1 then
		button:Point("LEFT", PersonalBuff, "LEFT", buttonSpacing, 0)
	else
		button:Point("LEFT", PersonalBuff.Buttons[i-1], "RIGHT", buttonSpacing, 0)
	end
	button:SetFrameLevel(PersonalBuff:GetFrameLevel() + 2)

	button.texture = button:CreateTexture(nil, "OVERLAY")
	button.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.texture:Point("TOPLEFT", 2, -2)
	button.texture:Point("BOTTOMRIGHT", -2, 2)

	tinsert(PersonalBuff.Buttons, button)
end

-- Update buff only when shown, update needed and timeout elapsed
PersonalBuff.lastUpdate = GetTime()
local function PersonalBuffUpdate(self, elapsed)
	local current = GetTime()
	if (self.needUpdate and current - self.lastUpdate > 1) or current - self.lastUpdate > 10 then -- no need to be hyper reactive + at least every 10 seconds (just in case we missed something)
		for i = 1, personalCount do
			local button = self.Buttons[i]
			local index, spellName, icon, spellID = GetIcon("player", PersonalIndex[i])
			button.texture:SetTexture(icon)
			if 0 ~= index then
				button.texture:SetAlpha(1.0)
			else
				button.texture:SetAlpha(0.2)
			end
		end
		self.needUpdate = false
		self.lastUpdate = GetTime()
	end
end

PersonalBuff:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")
PersonalBuff:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
PersonalBuff:RegisterUnitEvent("UNIT_AURA", "player")
PersonalBuff:RegisterEvent("PLAYER_REGEN_ENABLED")
PersonalBuff:RegisterEvent("PLAYER_REGEN_DISABLED")
PersonalBuff:RegisterEvent("PLAYER_ENTERING_WORLD")
PersonalBuff:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
PersonalBuff:RegisterEvent("CHARACTER_POINTS_CHANGED")
PersonalBuff:RegisterEvent("ZONE_CHANGED_NEW_AREA")
PersonalBuff:SetScript("OnEvent", function(self)
	if not C.raidbuff.instanceonly then
		self:Show()
	else
		local inInstance = IsInInstance()
		if inInstance then
			self:Show()
		else
			self:Hide()
		end
	end
	self.needUpdate = true
end)
PersonalBuff:SetScript("OnShow", function(self)
	self.needUpdate = true
	self:SetScript("OnUpdate", PersonalBuffUpdate)
end)
PersonalBuff:SetScript("OnHide", function(self)
	self:SetScript("OnUpdate", nil)
end)
PersonalBuff:Hide() -- starts hidden

-----------------------------
-- Raid
-----------------------------
-- Raid frame
--    Left                                                                                           RIGHT
--   --------                                                                                       -------- 
--  |   BIG  | Name                                                                           Name |   BIG  |
--  | BUTTON | ------- -------- -------  --------      ------- -------- -------- -------- -------- | BUTTON | 
--  |    1   | SMALL1 | SMALL2 | SMALL3 | SMALL4 |    | SMALL5 | SMALL4 | SMALL3 | SMALL2 | SMALL1 |    2   |
--   -------- -------- -------- -------- --------      -------- -------- -------- -------- -------- --------
local RaidBuff = CreateFrame("Frame", "TukuiRaidBuffFrame", PersonalBuff)
RaidBuff:SetTemplate()
RaidBuff:Size(440, 250) -- TODO: placeholder, real size will be computed later
RaidBuff:Point("TOP", PersonalBuff, "BOTTOM", 0, -1)
RaidBuff:Hide()
-- -- get maximum number of entry in spell list
-- local maxInSpellList = 1
-- for i = 1, #RaidIndex do
	-- local spellList = RaidIndex[i]
	-- local count = 0 -- grrrr, no API to get number of entries in table
	-- for _, _ in pairs(spellList) do count = count + 1 end
	-- if count > maxInSpellList then maxInSpellList = count end
-- end
-- tooltip
local function SetTooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:ClearLines()
	GameTooltip:SetSpellByID(self.spellID)
	GameTooltip:Show()
end
-- create big & small buttons
local raidBuffWidth = 0
local raidBuffHeight = 0
RaidBuff.BigButtons = {}
for i = 1, #RaidIndex do
	local spellList = RaidIndex[i]
	-- big button
	local bigButton = CreateFrame("Frame", nil, RaidBuff)
	bigButton:SetTemplate()
	bigButton:Size(bigButtonSize, bigButtonSize)
	if i == 1 then -- left
		bigButton:Point("TOPLEFT", RaidBuff, "TOPLEFT", bigButtonSpacing, -bigButtonSpacing)
	elseif i == 2 then -- right
		bigButton:Point("TOPRIGHT", RaidBuff, "TOPRIGHT", -bigButtonSpacing, -bigButtonSpacing)
	elseif 1 == (i%2) then -- left
		bigButton:Point("TOPLEFT", RaidBuff.BigButtons[i-2], "BOTTOMLEFT", 0, -bigButtonSpacing)
	else -- right
		bigButton:Point("TOPRIGHT", RaidBuff.BigButtons[i-2], "BOTTOMRIGHT", 0, -bigButtonSpacing)
	end

	bigButton.texture = bigButton:CreateTexture(nil, "OVERLAY")
	bigButton.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	bigButton.texture:Point("TOPLEFT", 2, -2)
	bigButton.texture:Point("BOTTOMRIGHT", -2, 2)

	-- virtual row with name
	bigButton.text = bigButton:CreateFontString(nil, "OVERLAY")
	if 1 == (i%2) then -- left
		bigButton.text:SetPoint("TOPLEFT", bigButton, "TOPRIGHT", 3, -1)
	else -- right
		bigButton.text:SetPoint("TOPRIGHT", bigButton, "TOPLEFT", -3, -1)
	end
	bigButton.text:SetFont(C.media.font, 16)
	bigButton.text:SetText(spellList["name"])

	-- tooltip
	bigButton:SetScript("OnEnter", SetTooltip)
	bigButton:SetScript("OnLeave", GameTooltip_Hide)

	tinsert(RaidBuff.BigButtons, bigButton)

	-- small buttons
	bigButton.SmallButtons = {}
	local j = 1
	for spellID in pairs(spellList) do
		if spellID ~= "default" and spellID ~= "name" then
			local smallButton = CreateFrame("Frame", nil, bigButton)
			smallButton:SetTemplate()
			smallButton:Size(smallButtonSize, smallButtonSize)
			-- 1 virtual row with name and one row with buttons
			if 1 == (i%2) then -- left
				if 1 == j then
					smallButton:Point("BOTTOMLEFT", bigButton, "BOTTOMRIGHT", buttonSpacing, 0)
				else
					smallButton:Point("LEFT", bigButton.SmallButtons[j-1], "RIGHT", buttonSpacing, 0)
				end
			else -- right
				if 1 == j then
					smallButton:Point("BOTTOMRIGHT", bigButton, "BOTTOMLEFT", -buttonSpacing, 0)
				else
					smallButton:Point("RIGHT", bigButton.SmallButtons[j-1], "LEFT", -buttonSpacing, 0)
				end

			end
			smallButton.spellID = spellID
			-- texture
			local spellName, _, spellIcon = GetSpellInfo(spellID)
			assert(spellName, "Incorrect spellID: "..spellID)
			smallButton.texture = smallButton:CreateTexture(nil, "OVERLAY")
			smallButton.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			smallButton.texture:Point("TOPLEFT", 2, -2)
			smallButton.texture:Point("BOTTOMRIGHT", -2, 2)
			smallButton.texture:SetTexture(spellIcon)
			smallButton.texture:SetAlpha(0.2)

			-- tooltip
			smallButton:SetScript("OnEnter", SetTooltip)
			smallButton:SetScript("OnLeave", GameTooltip_Hide)

			tinsert(bigButton.SmallButtons, smallButton)
			j = j + 1
		end
	end
end

-- Update buff only when shown, update needed and timeout elapsed
RaidBuff.lastUpdate = GetTime()
local function RaidBuffUpdate(self, elapsed)
	local current = GetTime()
	if (self.needUpdate and current - self.lastUpdate > 1) or current - self.lastUpdate > 10 then -- no need to be hyper reactive + at least every 10 seconds (just in case we missed something)
		for i = 1, #RaidIndex do
			local bigButton = self.BigButtons[i]
			local spellList = RaidIndex[i]
			local index, spellName, icon, spellID = GetIcon("player", spellList)
			bigButton.texture:SetTexture(icon)
			bigButton.spellID = spellID
			if 0 ~= index then
				bigButton.texture:SetAlpha(1.0)
			else
				bigButton.texture:SetAlpha(0.2)
			end
			local j = 1
			for spellID in pairs(spellList) do
				if spellID ~= "default" and spellID ~= "name" then
					local smallButton = bigButton.SmallButtons[j]
					if j == index then
						smallButton.texture:SetAlpha(1.0)
					else
						smallButton.texture:SetAlpha(0.2)
					end
					j = j + 1
				end
			end
		end
		self.needUpdate = false
		self.lastUpdate = GetTime()
	end
end

RaidBuff:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")
RaidBuff:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
RaidBuff:RegisterUnitEvent("UNIT_AURA", "player")
RaidBuff:RegisterEvent("PLAYER_REGEN_ENABLED")
RaidBuff:RegisterEvent("PLAYER_REGEN_DISABLED")
RaidBuff:RegisterEvent("PLAYER_ENTERING_WORLD")
RaidBuff:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RaidBuff:RegisterEvent("CHARACTER_POINTS_CHANGED")
RaidBuff:RegisterEvent("ZONE_CHANGED_NEW_AREA")
RaidBuff:SetScript("OnEvent", function(self)
	-- inform updater
	self.needUpdate = true
end)

-- Toggle button
local RaidBuffToggle = CreateFrame("Frame", "TukuiRaidBuffToggleFrame", PersonalBuff)
RaidBuffToggle:SetTemplate()
RaidBuffToggle:Size(PersonalBuff:GetWidth(), 18)
RaidBuffToggle:Point("TOP", PersonalBuff, "BOTTOM", 0, -1)
RaidBuffToggle.text = RaidBuffToggle:CreateFontString(nil, "OVERLAY")
RaidBuffToggle.text:SetPoint("CENTER")
RaidBuffToggle.text:SetFont(C.media.font, 12)
RaidBuffToggle.text:SetText(L.raidbuff_viewall)

local function ShowOnHover(activate)
	if activate then
		RaidBuffToggle:SetScript("OnEnter", function(self)
			self:SetAlpha(1)
		end)
		RaidBuffToggle:SetScript("OnLeave", function(self)
			self:SetAlpha(0)
		end)
	else
		RaidBuffToggle:SetScript("OnEnter", nil)
		RaidBuffToggle:SetScript("OnLeave", nil)
	end
end
RaidBuffToggle:SetScript("OnMouseDown", function(self)
	if RaidBuff:IsShown() then
		-- Hide raid buff and attach toggle to personal (default)
		RaidBuff:Hide()
		self:ClearAllPoints()
		self:Point("TOP", PersonalBuff, "BOTTOM", 0, -1)
		self.text:SetText(L.raidbuff_viewall)
		ShowOnHover(true)
		RaidBuff:SetScript("OnUpdate", nil)
	else
		-- Show raid buff and attach toggle to raid buff
		RaidBuff:Show()
		self:ClearAllPoints()
		self:Point("BOTTOM", RaidBuff, "BOTTOM", 0, 5)
		self.text:SetText(L.raidbuff_minimizeall)
		ShowOnHover(false)
		RaidBuff:SetScript("OnUpdate", RaidBuffUpdate)
	end
end)
RaidBuffToggle:SetAlpha(0) -- hidden by default
ShowOnHover(true) -- Show on hover by default

-----------------------------
-- Mover
-----------------------------
local mover = T.CreateMover(PersonalBuff:GetName().."_MOVER", PersonalBuff:GetWidth(), PersonalBuff:GetHeight(), position, L.raidbuff_move)
PersonalBuff:ClearAllPoints()
PersonalBuff:Point(unpack({ "TOPLEFT", mover, 0, 0 }))