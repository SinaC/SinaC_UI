-- Ripped from Tukui_BuffsNotice by Tukz

local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui)
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local print = Private.print

if not C.notifications.selfbuffs then return end

if IsAddOnLoaded("Tukui_BuffsNotice") then
	print("Tukui_BuffsNotice addon found, desactivating built-in self buff check")
	return
end

local buffs = T.remindbuffs[T.myclass]
if not buffs then return end

local sound

local function BuffsOnEvent(self, event, arg1)
	if event == "PLAYER_LOGIN" or event == "LEARNED_SPELL_IN_TAB" then
		for _, buff in pairs(buffs) do
			local name, _, icon = GetSpellInfo(buff)
			local usable, nomana = IsUsableSpell(name)
			if usable or nomana then
				self.icon:SetTexture(icon)
				break
			end
		end
		if not self.icon:GetTexture() and event == "PLAYER_LOGIN" then
			self:UnregisterAllEvents()
			self:RegisterEvent("LEARNED_SPELL_IN_TAB")
			return
		elseif self.icon:GetTexture() and event == "LEARNED_SPELL_IN_TAB" then
			self:UnregisterAllEvents()
			self:RegisterEvent("UNIT_AURA")
			self:RegisterEvent("PLAYER_LOGIN")
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
			self:RegisterEvent("PLAYER_REGEN_DISABLED")
		end
	end

	if UnitAffectingCombat("player") and not UnitInVehicle("player") then
		for _, buff in pairs(buffs) do
			local name = GetSpellInfo(buff)
			if name and UnitBuff("player", name) then
				self:Hide()
				sound = true
				return
			end
		end
		self:Show()
		if sound == true then
			PlaySoundFile(C["media"].warning)
			sound = false
		end
	else
		self:Hide()
		sound = true
	end
end

local frame = CreateFrame("Frame", "TukuiBuffsWarningFrame", UIParent)
frame:CreatePanel("Default", 40, 40, "CENTER", UIParent, "CENTER", 0, 280)
frame.icon = frame:CreateTexture(nil, "OVERLAY")
frame.icon:SetPoint("CENTER")
frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
frame.icon:Size(36)
frame:Hide()

frame:RegisterEvent("UNIT_AURA")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("UNIT_ENTERING_VEHICLE")
frame:RegisterEvent("UNIT_ENTERED_VEHICLE")
frame:RegisterEvent("UNIT_EXITING_VEHICLE")
frame:RegisterEvent("UNIT_EXITED_VEHICLE")

frame:SetScript("OnEvent", BuffsOnEvent)