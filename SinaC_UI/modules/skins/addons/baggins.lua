if not Baggins then return end
if not Tukui then return end

local Baggins = Baggins
local T, C, L = unpack(Tukui)

local tukuiSkin = {
	BagLeftPadding = 10,
	BagRightPadding = 10,
	BagTopPadding = 32,
	BagBottomPadding = 10,
	TitlePadding = 32+48,
	SectionTitleHeight = 13,

	EmptySlotTexture = false,

	-- BagFrameBackdrop = 
	-- -- {
		-- -- bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		-- -- edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		-- -- tile = true, tileSize = 16, edgeSize = 16,
		-- -- insets = { left = 5, right = 5, top = 5, bottom = 5 }
	-- -- },
	-- {
		-- bgFile = C.media.blank, 
		-- edgeFile = C.media.blank, 
		-- tile = false, tileSize = 0, edgeSize = T.mult,
	-- },

	NormalBagColor = "black",
	BankBagColor = "blue",
}

function tukuiSkin:SkinBag(frame)
--print("SkinBag")
	--frame:SetBackdrop(self.BagFrameBackdrop)
	frame:SetTemplate()

	frame.closebutton:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,0)
	T.SkinCloseButton(frame.closebutton)

	frame.compressbutton:ClearAllPoints();
	frame.compressbutton:SetPoint("TOPRIGHT", frame.closebutton, "TOPLEFT", -4, -2)

	frame.title:SetVertexColor(1,1,1,1)
	frame.title:ClearAllPoints()
	-- double anchoring is required to resize bag properly
	frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
	frame.title:SetPoint("RIGHT", frame.closebutton, "LEFT", 0, 0)
	frame.title:SetHeight(12)
	frame.title:SetJustifyH("LEFT")
end

function tukuiSkin:SkinSection(frame)
--print("SkinSection")
	frame.title:SetVertexColor(1,1,1,1)
	frame.title:SetText("")
	frame.title:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
	frame.title:SetHeight(13)
end

function tukuiSkin:SkinItem(frame)
--print("SkinItem")
	frame:SkinIconButton(frame)
end

function tukuiSkin:SetBankVisual(frame, isBank)
	local color = self.core.colors[self.NormalBagColor]
	if isBank then
		color = self.core.colors[self.BankBagColor]
	end
	frame:SetBackdropColor(color.r, color.g, color.b)
end

Baggins:RegisterSkin("Tukui", tukuiSkin)
Baggins.db.profile.skin = "Tukui"