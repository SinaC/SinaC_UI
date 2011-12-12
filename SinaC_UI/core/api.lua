local T, C, L = unpack(Tukui)

-- -- API stuff
-- local function FontTemplate(fs, font, fontSize, fontStyle)
	-- fs.font = font
	-- fs.fontSize = fontSize
	-- fs.fontStyle = fontStyle

	-- if not font then font = C["media"].font end
	-- if not fontSize then fontSize = 10 end

	-- fs:SetFont(font, fontSize, fontStyle)
	-- fs:SetShadowColor(0, 0, 0, 0.4)
	-- fs:SetShadowOffset((T.mult or 1), -(T.mult or 1))
-- end

-- local function addapi(object)
	-- local mt = getmetatable(object).__index
	-- if not object.FontTemplate then mt.FontTemplate = FontTemplate end
-- end

-- local handled = {["Frame"] = true}
-- local object = CreateFrame("Frame")
-- addapi(object)
-- addapi(object:CreateTexture())
-- addapi(object:CreateFontString())

-- object = EnumerateFrames()
-- while object do
	-- if not handled[object:GetObjectType()] then
		-- addapi(object)
		-- handled[object:GetObjectType()] = true
	-- end

	-- object = EnumerateFrames(object)
-- end