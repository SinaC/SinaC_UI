-- Automatically disable profanityFilter
local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui)
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local print = Private.print

if GetCVar("profanityFilter") == "0" then return end

local frame = CreateFrame("FRAME", "TukuiDisableProfanityFilterFrame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	local isOnline = BNConnected()
	if isOnline then
		BNSetMatureLanguageFilter(false)
	end
	SetCVar("profanityFilter", 0)
	print("Profanity filter is now disabled.") 
end)