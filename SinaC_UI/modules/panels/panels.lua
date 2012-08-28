local T, C, L = unpack(Tukui)

-- Add a panel above minimap
if TukuiMinimap then
	local minimapstatstop = CreateFrame("Frame", "TukuiMinimapStatsTop", TukuiMinimap)
	--minimapstatstop:CreatePanel("Default", TukuiMinimap:GetWidth(), 19, "BOTTOM", TukuiMinimap, "TOP", 0, 2)
	minimapstatstop:SetTemplate()
	minimapstatstop:Size(TukuiMinimap:GetWidth(), 19)
	minimapstatstop:Point("BOTTOM", TukuiMinimap, "TOP", 0, 2)
end