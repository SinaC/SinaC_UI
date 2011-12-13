-- Automatically disable profanityFilter
local T, C, L = unpack(Tukui)

local frame = CreateFrame("FRAME", "DisableProfanityFilter")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
	local isOnline = BNConnected()
	if isOnline then
		BNSetMatureLanguageFilter(false)
	end
	SetCVar("profanityFilter", 0)

	print("SinaC UI: profanity filter is now disabled.") 
end)