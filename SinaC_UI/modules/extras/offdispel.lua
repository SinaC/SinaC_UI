-- Display buff to dispel/purge/steal
local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui)
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

-- TODO
-- display more than one buff
-- autoshine actionbar button

if C.extras.offensivedispel ~= true then return end

if not T.OffensiveDispels[T.myclass] then return end

local DispelSpellID = T.OffensiveDispels[T.myclass].spellID
local DispelTypes = T.OffensiveDispels[T.myclass].types
local IsDispelSpellKnown = false
local ActionButton = nil

--print("Offensive dispel check activated")

local ListBuffs = {} -- GC-friendly
local function CheckAuras(self)
--print("CheckAuras")
	--
	if not IsDispelSpellKnown == true then return end
	--
	if UnitInVehicle("player") then return end
	if UnitInVehicle("target") then return end
	--
	if not UnitCanAttack("player", "target") then return end
	--
	local buffCount = 0
	for i = 1, MAX_TARGET_BUFFS, 1 do
		local name, _, icon, count, type, _, _, _, stealable, _, spellID = UnitAura("target", i, "HELPFUL")
		if not name then break end
		local found = false
		for _, dispelType in pairs(DispelTypes) do
			if (dispelType == "STEALABLE" and stealable) or (dispelType == "ENRAGE" and (T.EnrageList and T.EnrageList[name] == true)) or dispelType == type then
				found = true
				break
			end
		end
		if found then
			buffCount = buffCount + 1
			if not ListBuffs[buffCount] then ListBuffs[buffCount] = {} end
			ListBuffs[buffCount].spellName = name
			ListBuffs[buffCount].icon = icon
			ListBuffs[buffCount].count = count
			ListBuffs[buffCount].spellID = spellID
		end
	end
	if buffCount > 0 then
		--local message = table.concat(ListBuffs, "\n")
		-- local message = ""
		-- for i = 1, buffCount, 1 do
			-- message = message .. tostring(ListBuffs[i].spellName)
		-- end
		-- print("Offensive Dispel: "..message)
		local icon = ListBuffs[1].icon -- TODO: more than one buff displayed
		self.icon:SetTexture(icon)
		self:Show()
	else
		self:Hide()
	end
end

local function FindActionButton()
	local spellName = GetSpellInfo(DispelSpellID)
	for i = 1, 144, 1 do
		if HasAction(i) then
			local type, id = GetActionInfo(i)
			if type == "spell" then
				local actionButtonSpellName = GetSpellInfo(id)
				if actionButtonSpellName == spellName then
					--ActionButtonIndex = i
					-- TODO: how to get button related to this action ?
					break
				end
			end
		end
	end
end

local frame = CreateFrame("FRAME", "TukuiOffensiveDispelFrame")
frame:CreatePanel("Default", 40, 40, "CENTER", UIParent, "CENTER", 0, 300)
frame.icon = frame:CreateTexture(nil, "OVERLAY")
frame.icon:SetPoint("CENTER")
frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
frame.icon:Size(36)
frame:Hide()

frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, arg1)
	if event == "PLAYER_LOGIN" or event == "LEARNED_SPELL_IN_TAB" then
		-- check if dispel spell if known
		local spellName = GetSpellInfo(DispelSpellID)
		if spellName then
			local skillType, globalSpellID = GetSpellBookItemInfo(spellName)
			if skillType == "SPELL" then
				IsDispelSpellKnown = true
			end
		end
		if IsDispelSpellKnown then
			-- Get action button
			FindActionButton()
			self:UnregisterEvent("LEARNED_SPELL_IN_TAB")
			self:UnregisterEvent("PLAYER_LOGIN")
			self:RegisterEvent("PLAYER_TARGET_CHANGED")
			self:RegisterEvent("UNIT_AURA")
			self:RegisterEvent("UNIT_ENTERED_VEHICLE")
			self:RegisterEvent("UNIT_EXITED_VEHICLE")
		else
			self:UnregisterEvent("PLAYER_LOGIN")
			self:RegisterEvent("LEARNED_SPELL_IN_TAB")
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		CheckAuras(self)
	elseif event == "UNIT_AURA" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" then
		if arg1 ~= "target" then return end
		CheckAuras(self)
	end
end)