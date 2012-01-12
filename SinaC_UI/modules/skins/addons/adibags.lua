-- AdiBags bugs:
--  open bags, make a search, click on escape, re-open bags, search filter is still activated but not written in search box
-- Skin bug:
--  scale problem

-- ORIGINAL CREDITS TO:
-- Habarg - https://github.com/omega/wow-tukui-skin-adibags
-- Chebyshev - http://www.tukui.org/forums/topic.php?id=4964

--if true then return end

local T, C, L = unpack(Tukui)

if not C.general.adibagsreskin then return end
if not IsAddOnLoaded("AdiBags") then return end

local addon = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

if not addon then return end

addon.BACKDROP = {
	bgFile = C.media.blank,
	edgeFile = C.media.blank,
	tile = false,
	tileSize = 0,
	edgeSize = T.mult,
	insets = {
		left = -T.mult,
		right = -T.mult,
		top = -T.mult,
		bottom = -T.mult,
	},
}
addon.db.profile.backgroundColors.Backpack = C.media.backdropcolor
addon.db.profile.backgroundColors.Bank = C.media.backdropcolor
addon.db.profile.scale = 1

local buttonProto = addon:GetClass("ItemButton").prototype
local stackProto = addon:GetClass("StackButton").prototype
local containerProto = addon:GetClass("Container").prototype
--local bagButtonProto = addon:GetClass("BagSlotButton").prototype

local ITEM_SIZE = addon.ITEM_SIZE--31
-- addon.ITEM_SPACING = 4
-- addon.SECTION_SPACING = addon.ITEM_SIZE / 3 + addon.ITEM_SPACING
-- addon.BAG_INSET = 8
-- addon.TOP_PADDING = 32

function stackProto:OnCreate()
	self:SetWidth(T.Scale(ITEM_SIZE))
	self:SetHeight(T.Scale(ITEM_SIZE))
	self.slots = {}
	self:SetScript('OnShow', self.OnShow)
	self:SetScript('OnHide', self.OnHide)
	self.GetCountHook = function()
		return self.count
	end
end

local function reSkinItem(f)
	f:SetHeight(T.Scale(ITEM_SIZE))
	f:SetWidth(T.Scale(ITEM_SIZE))

	f:SetBackdrop(addon.BACKDROP)

	f:SetBackdropColor(0,0,0,1)
	f:SetNormalTexture("")
	f.skinned = true
	-- f:SetBackdropBorderColor(0,0,0,0)
	-- print(f, f:GetWidth() .. "x" ..f:GetHeight(), f:GetParent():GetName())
	if f.section then
		f.section.Header:SetFont(C.media.font, 12)
	end
	-- print(f:GetPoint("TOPLEFT"));
	-- print(f:GetRect());
end

function buttonProto:Update()
	if not self:CanUpdate() then return end
	local icon = self.IconTexture

	if not self.skinned then reSkinItem(self) end

	icon:ClearAllPoints()
	icon:SetTexCoord(.08, .92, .08, .92)
	-- icon:SetPoint("TOPLEFT", self, TukuiDB.Scale(2), TukuiDB.Scale(-2))
	-- icon:SetPoint("BOTTOMRIGHT", self, TukuiDB.Scale(-2), TukuiDB.Scale(2))
	icon:SetWidth(T.Scale(ITEM_SIZE) - T.mult * T.Scale(2))
	icon:SetHeight(T.Scale(ITEM_SIZE) - T.mult * T.Scale(2))

	icon:SetPoint("CENTER", self, "CENTER", 0, 0)
	if self.texture then
		icon:SetTexture(self.texture)
	else
		icon:SetTexture(0.3, 0.3, 0.3, 1);
	end
	-- icon:Hide()
	local tag = (not self.itemId or addon.db.profile.showBagType) and addon:GetFamilyTag(self.bagFamily)
	if tag then
		self.Stock:SetText(tag)
		self.Stock:Show()
	else
		self.Stock:Hide()
	end
	self:UpdateCount()
	self:UpdateBorder()
	self:UpdateCooldown()
	self:UpdateLock()
	addon:SendMessage('AdiBags_UpdateButton', self)
end

function buttonProto:UpdateBorder(isolatedEvent)
	if self.hasItem then
		local r, g, b, a = 1, 1, 1, 1
		local isQuestItem, questId, isActive = GetContainerItemQuestInfo(self.bag, self.slot)
		if addon.db.profile.questIndicator and (questId and not isActive) then
			r,g,b = 1.0, 0.3, 0.3
		elseif addon.db.profile.questIndicator and (questId or isQuestItem) then
			r,g,b = 1.0, 0.3, 0.3
		elseif addon.db.profile.qualityHighlight then
			local _, _, quality = GetItemInfo(self.itemId)
			if quality and quality >= ITEM_QUALITY_UNCOMMON then
				r, g, b = GetItemQualityColor(quality)
			elseif quality == ITEM_QUALITY_POOR and addon.db.profile.dimJunk then
				r,g,b = 0.5, 0.5, 0.5
			end
		end

		self:SetBackdropBorderColor(r,g,b,a)

		if isolatedEvent then
			addon:SendMessage('AdiBags_UpdateBorder', self)
		end
		return
	end
	self.IconQuestTexture:Hide()
	if isolatedEvent then
		addon:SendMessage('AdiBags_UpdateBorder', self)
	end
end

local _containerProto_OnCreate = containerProto.OnCreate -- save original function
function containerProto:OnCreate(name, bagIds, isBank)
	-- call original function
	_containerProto_OnCreate(self, name, bagIds, isBank)
	-- skin search box
	local searchBoxFrame = _G[self:GetName().."SearchBox"]
	if searchBoxFrame then T.SkinEditBox(searchBoxFrame) end
	-- skin close button
	T.SkinCloseButton(self.CloseButton)
	-- skin bagSlotButton
	for _, widget in ipairs(self.HeaderLeftRegion.widgets) do
		local button = widget.widget
		if button.SetNormalTexture then
			local texture = button:GetNormalTexture()
			if texture then
				button:SetTemplate("Default", true)
				texture:SetDrawLayer("OVERLAY") -- Make sure we can see the Icons.
				texture:ClearAllPoints()
				texture:Point("TOPLEFT", 2, -2)
				texture:Point("BOTTOMRIGHT", -2, 2)
				texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
				button:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
			end
		end
	end
end

-- Skin bag slots
local _CreateBagSlotPanel = addon.CreateBagSlotPanel -- save original function
function addon:CreateBagSlotPanel(container, name, bags, isBank)
	-- call original function
	local bagSlotPanel = _CreateBagSlotPanel(self, container, name, bags, isBank)
	for _, button in ipairs(bagSlotPanel.buttons) do
		local texture = _G[button:GetName().."IconTexture"]
		if texture then
			button:SetTemplate("Default", true)
			texture:SetDrawLayer("OVERLAY") -- Make sure we can see the Icons.
			texture:ClearAllPoints()
			texture:Point("TOPLEFT", 2, -2)
			texture:Point("BOTTOMRIGHT", -2, 2)
			texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		end
		button:SetNormalTexture(nil)
		button:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
	end
	return bagSlotPanel
end

