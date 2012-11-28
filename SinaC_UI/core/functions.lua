local T, C, L = unpack(Tukui)

-- Add datatext 9
local saved_T_DataTextPosition = T.DataTextPosition -- save original function
T.DataTextPosition = function(p, obj)
	saved_T_DataTextPosition(p, obj) -- call original function

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

T.GetRole = function() -- Ripped from Elv
	local spec = GetSpecialization()
	if type(T.ClassRole[T.myclass]) == "string" then
		return T.ClassRole[T.myclass]
	elseif spec then
		return T.ClassRole[T.myclass][spec]
	end
	return "Melee"
end

T.CreateMover = function(name, width, height, anchor, text)
	local mover = CreateFrame("Button", name, UIParent)
	mover:SetTemplate()
	mover:SetBackdropBorderColor(1, 0, 0, 1)
	mover:SetFrameStrata("HIGH")
	mover:SetMovable(true)
	mover:Size(width, height)
	mover:Point(unpack(anchor))

	mover.text = T.SetFontString(mover, C["media"]["uffont"], 12)
	mover.text:SetPoint("CENTER")
	mover.text:SetText(text)
	mover.text.Show = function() mover:Show() end
	mover.text.Hide = function() mover:Hide() end
	mover:Hide()

	tinsert(T.AllowFrameMoving, mover)

	return mover
end