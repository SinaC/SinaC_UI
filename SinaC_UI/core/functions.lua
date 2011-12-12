local T, C, L = unpack(Tukui)

-- Add datatext 9
local saved_T_PP = T.PP -- save original function
T.PP = function(p, obj)
	saved_T_PP(p, obj) -- call original function

	local maptop = TukuiMinimapStatsTop
	if TukuiMinimap and maptop then
		if p == 9 then
			obj:SetParent(maptop)
			obj:SetHeight(maptop:GetHeight())
			obj:SetPoint("TOP", maptop)
			obj:SetPoint("BOTTOM", maptop)
		end
	end
end