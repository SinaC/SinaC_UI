local T, C, L = unpack(Tukui)

---------------------------------------------------
-- SINACUI API START HERE
---------------------------------------------------
--[[
local function CreatePanel2(f, t, w, h, a1, p, a2, x, y)
	local backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
	local backdropa = 1
	local borderr, borderg, borderb
	if t == "ClassColor" or t == "Class Color" or t == "Class" then
		local c = T.UnitColor.class[T.myclass]
		borderr, borderg, borderb = c[1], c[2], c[3]
	else
		if t == "Transparent" then backdropa = 0.8 end
		borderr, borderg, borderb = unpack(C["media"].bordercolor)
	end

	f:SetFrameLevel(1)
	f:Height(h)
	f:Width(w)
	f:SetFrameStrata("BACKGROUND")
	if a1 then f:Point(a1, p, a2, x, y) end
	f:SetBackdrop({
		bgFile = C["media"].blank, 
		edgeFile = C["media"].blank, 
		tile = false, tileSize = 0, edgeSize = T.mult, 
		insets = {left = -T.mult + inset + inset, right = -T.mult + inset + inset, top = -T.mult + inset + inset, bottom = -T.mult + inset + inset}
	})

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end
--]]

--[[
local function FontTemplate(fs, font, fontSize, fontStyle)
	fs.font = font
	fs.fontSize = fontSize
	fs.fontStyle = fontStyle

	if not font then font = C["media"].font end
	if not fontSize then fontSize = 10 end

	fs:SetFont(font, fontSize, fontStyle)
	fs:SetShadowColor(0, 0, 0, 0.4)
	fs:SetShadowOffset((T.mult or 1), -(T.mult or 1))
end
--]]
---------------------------------------------------
-- MERGE TUKUI API WITH WOW API
---------------------------------------------------
--[[
local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.FontTemplate then mt.FontTemplate = FontTemplate end
	if not object.CreatePanel2 then mt.CreatePanel2 = CreatePanel2 end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end
--]]