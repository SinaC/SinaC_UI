-- Based on ElvUI_Skillet_Skin by Camealion

local T, C, L = unpack(Tukui)

if not C.general.skilletreskin then return end
if not IsAddOnLoaded("Skillet") then return end

local Skillet = _G.Skillet
if not Skillet then return end

local function Desaturate(f, point)
	if not f then return end
	for i = 1, f:GetNumRegions(), 1 do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetDesaturated(1)
			if region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Corner" then
				region:Kill()
			end
		end
	end
	if point then
		f:Point("TOPRIGHT", point, "TOPRIGHT", 2, 2)
	end
end

--[[
function SetModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[t.myclass]
	self:SetBackdropColor(color.r*.15, color.g*.15, color.b*.15)
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

function SetOriginalBackdrop(self)
	-- if C["general"].classcolortheme == true then
		-- local color = RAID_CLASS_COLORS[T.myclass]
		-- self:SetBackdropBorderColor(color.r, color.g, color.b)
	-- else
	self:SetTemplate("Default")
	--	end
end
--]]

local function SkinButton(ButtonOrSpellID)
	if not ButtonOrSpellID then return end
	local button
	if type(ButtonOrSpellID) == "number" then
		local player = UnitName("player")
		local buttonName = "SkilletFrameTradeButton-"..player.."-"..tostring(ButtonOrSpellID)
		button = _G[buttonName]
	else
		button = ButtonOrSpellID
	end
	if button then
		local texture = button:GetNormalTexture()
		if not texture then
			texture = _G[button:GetName().."Icon"]
		end
		if texture then
			button:SetTemplate("Default", true)
			texture:SetDrawLayer("OVERLAY") -- Make sure we can see the Icons.
			texture:ClearAllPoints()
			texture:Point("TOPLEFT", 2, -2)
			texture:Point("BOTTOMRIGHT", -2, 2)
			texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			button:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
			-- button:SetHighlightTexture(nil)
			-- button:HookScript("OnEnter", SetModifiedBackdrop)
			-- button:HookScript("OnLeave", SetOriginalBackdrop)
		end
	end
end

local function SkinGuildRecipes(ButtonOrSpellID)
	if not ButtonOrSpellID then return end
	local button
	if type(ButtonOrSpellID) == "number" then
		local buttonName = "SkilletFrameTradeButton-Guild Recipes-"..tostring(ButtonOrSpellID)
		button = _G[buttonName]
	else
		button = ButtonOrSpellID
	end
	if button then
		local texture = button:GetNormalTexture()
		if not texture then
			texture = _G[button:GetName().."Icon"]
			button:ClearAllPoints()
			button:SetPoint("BOTTOMLEFT", SkilletRankFrame, "TOPLEFT", 0, 3) --Adjust position.
		end
		if texture then
			button:SetTemplate("Default", true)
			texture:SetDrawLayer('OVERLAY') -- Make sure we can see the Icons.
			texture:ClearAllPoints()
			texture:Point("TOPLEFT", 2, -2)
			texture:Point("BOTTOMRIGHT", -2, 2)
			texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			button:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
			-- button:SetHighlightTexture(nil)
			-- button:HookScript("OnEnter", SetModifiedBackdrop)
			-- button:HookScript("OnLeave", SetOriginalBackdrop)
		end
	end  
end

local function SkinIcon(self)
	SkinButton(SkilletDoBasic_Campfire)
	SkinButton(SkilletDoProspecting)
	SkinButton(SkilletDoDisenchant)
	SkinButton(SkilletDoMilling)

	SkinButton(2259) -- Alchemy
	SkinButton(2018) -- Blacksmithing
	SkinButton(7411) -- Enchanting
	SkinButton(4036) -- Engineering
	SkinButton(45357) -- Inscription
	SkinButton(25229) -- Jewelcrafting
	SkinButton(2108) -- Leatherworking
	SkinButton(2656) -- Smelting
	SkinButton(3908) -- Tailoring
	SkinButton(2550) -- Cooking
	SkinButton(3273) -- Firstaid
	SkinButton(53428) -- Runeforging

-- Stop this FPS Killer
	local icon = _G["SkilletHideUncraftableRecipes"]
	icon:SetScript("OnUpdate", nil)

	SkinButton(SkilletHideUncraftableRecipes)
	SkinButton(SkilletRecipeDifficultyButton)
	SkinButton(SkilletExpandAllButton)
	SkinButton(SkilletCollapseAllButton)

	SkinButton(SkilletShowOptionsButton)
	SkilletShowOptionsButton:SetHeight(16)
	SkilletShowOptionsButton:SetWidth(12)
	SkilletShowOptionsButton:SetPoint("RIGHT", SkilletFrameCloseButton, "LEFT", 3, 0)

	if not SkilletShowOptionsButton.text then
		SkilletShowOptionsButton.text = SkilletShowOptionsButton:CreateFontString(nil, "OVERLAY")
		SkilletShowOptionsButton.text:SetFont(C["media"]["font"], 12, "OUTLINE")
		SkilletShowOptionsButton.text:SetText(" ?")
		SkilletShowOptionsButton.text:SetTextColor(1, 0, 0)	
		SkilletShowOptionsButton.text:SetJustifyH("CENTER")
		SkilletShowOptionsButton.text:SetPoint("CENTER", SkilletShowOptionsButton, "CENTER")
	end
end

local function SkinShopping(self)
-- Shopping List
	SkilletShoppingList:StripTextures()
	SkilletShoppingList:SetTemplate("Transparent")
	SkilletShoppingListParent:StripTextures()
	SkilletShoppingListParent:SetTemplate("Default")
	T.SkinCloseButton(SkilletShoppingListCloseButton)
	T.SkinCheckBox(SkilletShowQueuesFromAllAlts)
	T.SkinScrollBar(SkilletShoppingListListScrollBar)
end

local function SkinPluginButtons(self)
-- Only found 2 buttons so far.
	if SkilletPluginDropdown1 then
		T.SkinButton(_G["SkilletPluginDropdown1"])
	end
	if SkilletPluginDropdown2 then
		T.SkinButton(_G["SkilletPluginDropdown2"])
	end
end

local function SkilletFrameOnShow(self)
-- Strip Textures
	local StripAllTextures = {
		"SkilletFrame",
		"SkilletSkillListParent",
		"SkilletReagentParent",
		"SkilletQueueParent",
		"SkilletRecipeNotesFrame",
		"SkilletQueueManagementParent",
		"SkilletSkillTooltip",
		"SkilletStandalonQueue",
		"SkilletViewCraftersParent"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

-- Set Templates
	local SetTemplateD = { -- Default Texture
		"SkilletSkillListParent",
		"SkilletReagentParent",
		"SkilletQueueParent",
		"SkilletQueueManagementParent",
		"SkilletViewCraftersParent"
	}

	local SetTemplateT = { -- Transparent Texture
		"SkilletFrame",
		"SkilletRecipeNotesFrame",
		"SkilletSkillTooltip",
		"SkilletStandalonQueue",
	}

	for _, object in pairs(SetTemplateD) do
		_G[object]:SetTemplate("Default")
	end

	for _, object in pairs(SetTemplateT) do
		_G[object]:SetTemplate("Transparent")
	end

-- Skin Close Button
	T.SkinCloseButton(SkilletNotesCloseButton)

-- Move Positions
	SkilletSkillListParent:SetPoint("TOPLEFT", SkilletFrame, "TOPLEFT", 5, -100)
	SkilletRankFrame:SetPoint("TOPRIGHT", SkilletFrame, "TOPRIGHT", -12, -57)
	SkilletRankFrameRed:SetPoint("TOPRIGHT", SkilletFrame, "TOPRIGHT", -12, -70)
	SkilletRankFrameOrange:SetPoint("TOPRIGHT", SkilletFrame, "TOPRIGHT", -12, -70)
	SkilletRankFrameYellow:SetPoint("TOPRIGHT", SkilletFrame, "TOPRIGHT", -12, -70)
	SkilletRankFrameGreen:SetPoint("TOPRIGHT", SkilletFrame, "TOPRIGHT", -12, -70)
	SkilletRankFrameGray:SetPoint("TOPRIGHT", SkilletFrame, "TOPRIGHT", -12, -70)
	SkilletRecipeGroupDropdown:SetPoint("BOTTOMLEFT", SkilletSkillListParent, "TOPLEFT", 45, 43)
	SkilletRecipeGroupOperations:SetPoint("LEFT", SkilletRecipeGroupDropdownButton, "RIGHT", 4, 0)
	SkilletSortAscButton:SetPoint("LEFT", SkilletSortDropdownButton, "RIGHT", 4, 0)
	SkilletSortDescButton:SetPoint("LEFT", SkilletSortDropdownButton, "RIGHT", 4, 0)
	SkilletSearchFilterClear:SetPoint("LEFT", SkilletFilterBox, "RIGHT", -2, 0)
	SkilletQueueSaveButton:SetPoint("LEFT", SkilletQueueSaveEditBox, "RIGHT", 5, 0)
	SkilletQueueLoadButton:SetPoint("LEFT", SkilletQueueLoadDropdownButton, "RIGHT", 5, 0)
	SkilletQueueDeleteButton:SetPoint("LEFT", SkilletQueueLoadButton, "RIGHT", 2, 0)
	SkilletHideUncraftableRecipes:SetPoint("BOTTOMRIGHT", SkilletSkillListParent, "TOPRIGHT", -5, 5)
	SkilletFrameCloseButton:ClearAllPoints()
	SkilletFrameCloseButton:SetPoint("TOPRIGHT", SkilletFrame, "TOPRIGHT", 0, 0)
	SkilletTradeSkillLinkButton:SetPoint("RIGHT", SkilletShowOptionsButton, "LEFT", 0, 0)
	SkilletViewCraftersButton:SetPoint("RIGHT", SkilletQueueManagementButton, "LEFT", -5, 0)
-- Skin Tooltips
	SkilletTradeskillTooltip:StripTextures()
	SkilletTradeskillTooltip:SetTemplate("Default")
-- Scrollbar
	T.SkinScrollBar(SkilletQueueListScrollBar)
-- Queue Delete Buttons
	for i = 1, 3, 1 do
		local queDelete = _G["SkilletQueueButton"..i.."DeleteButton"]
		T.SkinButton(queDelete)
		queDelete:SetWidth(14)
		queDelete:SetHeight(14)
	end

-- Enchantrix ------------------------------------------------------------------------------------------------------------
	-- Frames
	if Enchantrix_BarkerOptions_Frame then
		Enchantrix_BarkerOptions_Frame:StripTextures()
		Enchantrix_BarkerOptions_Frame:SetTemplate("Default")
		Enchantrix_BarkerOptions_Frame:SetHeight(480)
	--Tabs
		for i=1,4 do 
			local tab = _G["Enchantrix_BarkerOptions_FrameTab"..i]
			T.SkinTab(tab)
		end
	-- Positions
		Enchantrix_BarkerOptions_FrameTab1:ClearAllPoints()
		Enchantrix_BarkerOptions_FrameTab1:SetPoint("TOPLEFT", Enchantrix_BarkerOptions_Frame, "BOTTOMLEFT", 11, 1)
		Enchantrix_BarkerOptions_CloseButton:SetPoint("TOPRIGHT", Enchantrix_BarkerOptions_Frame, "TOPRIGHT", -5, -2)
	-- Buttons
		T.SkinButton(Enchantrix_BarkerOptionsBark_Button)
		T.SkinButton(Enchantrix_BarkerOptionsReset_Button)
		T.SkinButton(Enchantrix_BarkerOptionsTest_Button)
	-- Close Button
		T.SkinCloseButton(Enchantrix_BarkerOptions_CloseButton)
	end
-- Enchantrix ------------------------------------------------------------------------------------------------------------
end

local function SkilletFrameOnUpdate(self, event, ...)
-- Move Positions.
	SkilletRecipeNotesButton:SetPoint("BOTTOMRIGHT", SkilletReagentParent, "TOPRIGHT", 0, 2)
	SkilletQueueManagementButton:SetPoint("RIGHT", SkilletRecipeNotesButton, "LEFT", -5, 0)
	SkilletItemCountInputBox:SetPoint("BOTTOM", SkilletCreateCountSlider, "TOP", 0, 2)

-- Move Trade Icons above rank frame.  Mostly stolen from Skillet itself! :)
	if SkilletDoBasic_Campfire then -- cooking = basic campfire
		SkilletDoBasic_Campfire:ClearAllPoints()
		SkilletDoBasic_Campfire:SetPoint("BOTTOMRIGHT", SkilletRankFrame, "TOPRIGHT", 0, 3)
	end
	if SkilletDoDisenchant then
		SkilletDoDisenchant:ClearAllPoints()-- enchanting = disenchant
		SkilletDoDisenchant:SetPoint("BOTTOMRIGHT", SkilletRankFrame, "TOPRIGHT", -26, 3)
	end
	if SkilletDoProspecting then -- jewelcrafting = prospecting
		SkilletDoProspecting:ClearAllPoints()
		SkilletDoProspecting:SetPoint("BOTTOMRIGHT", SkilletRankFrame, "TOPRIGHT", -52, 3)
	end
	if SkilletDoMilling then -- inscription = milling
		SkilletDoMilling:ClearAllPoints()
		SkilletDoMilling:SetPoint("BOTTOMRIGHT", SkilletRankFrame, "TOPRIGHT", -78, 3)
	end

	SkinGuildRecipes(2259) -- Alchemy
	SkinGuildRecipes(2018) -- Blacksmithing
	SkinGuildRecipes(7411) -- Enchanting
	SkinGuildRecipes(4036) -- Engineering
	SkinGuildRecipes(45357)-- Inscription
	SkinGuildRecipes(25229)-- Jewelcrafting
	SkinGuildRecipes(2108) -- Leatherworking
	SkinGuildRecipes(2656) -- Smelting
	SkinGuildRecipes(3908) -- Tailoring
	SkinGuildRecipes(53428)-- Runeforging
	SkinGuildRecipes(3273) -- Firstaid
	SkinGuildRecipes(2550) -- Cooking

	local player = UnitName("player")
	local icon = "SkilletFrameTradeButtons-"..player
	local template = "SkilletTradeButtonTemplate"
	local tradeSkillList = Skillet.tradeSkillList
	local nonLinkingTrade = { [2656] = true, [53428] = true }	-- smelting, runeforging
	local x = 0
	for i = 1, #tradeSkillList, 1 do
		local tradeID = Skillet.tradeSkillList[i]
		local ranks = Skillet:GetSkillRanks(player, tradeID)
		-- local tradeLink -- USELESS
		-- if Skillet.db.realm.linkDB[player] then
			-- tradeLink = Skillet.db.realm.linkDB[player][tradeID]
			-- if nonLinkingTrade[tradeID] then
				-- tradeLink = nil
			-- end
		-- end
		if ranks then
			local spellName, _, spellIcon = GetSpellInfo(tradeID)
			local buttonName = "SkilletFrameTradeButton-"..player.."-"..tradeID
			local button = _G[buttonName]
			if not button then
				button = CreateFrame("CheckButton", buttonName, nil, UIParent)--CreateFrame("CheckButton", buttonName, frame, "SkilletTradeButtonTemplate")
			end 
			button:ClearAllPoints()
			button:SetPoint("BOTTOMLEFT", SkilletRankFrame, "TOPLEFT", x, 3)
			x = x + button:GetWidth() + 1
		end
	end

-- Extra Queue Delete Buttons
	if SkilletQueueButton13DeleteButton then
		for i = 1, 13, 1 do
			local queDelete = _G["SkilletQueueButton"..i.."DeleteButton"]
			T.SkinButton(queDelete)
			queDelete:SetWidth(14)
			queDelete:SetHeight(14)
		end
	end
end

local SkinSkillet = CreateFrame("Frame")
SkinSkillet:RegisterEvent("PLAYER_ENTERING_WORLD")
SkinSkillet:SetScript("OnEvent", function(self, event)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
-- Skin Buttons
	local buttons = {
		"SkilletQueueAllButton",
		"SkilletCreateAllButton",
		"SkilletQueueButton",
		"SkilletCreateButton",
		"SkilletQueueManagementButton",
		"SkilletPluginButton",
		"SkilletShoppingListButton",
		"SkilletEmptyQueueButton",
		"SkilletStartQueueButton",
		"SkilletQueueOnlyButton",
		"SkilletQueueLoadButton",
		"SkilletQueueDeleteButton",
		"SkilletQueueSaveButton",
		"SkilletRecipeNotesButton",
		"SkilletViewCraftersButton"
	}

	for _, button in pairs(buttons) do
		T.SkinButton(_G[button])
	end

-- Skin Close Button
	T.SkinCloseButton(SkilletFrameCloseButton)
	T.SkinCloseButton(SkilletStandalonQueueCloseButton)

-- Skin Dropdown Buttons
	T.SkinDropDownBox(SkilletRecipeGroupDropdown)
	T.SkinDropDownBox(SkilletSortDropdown)
	T.SkinDropDownBox(SkilletQueueLoadDropdown)

-- Filter Clear button
	Desaturate(SkilletSearchFilterClear)
	--Desaturate(SkilletShowOptionsButton)

-- Sort up Button
	SkilletSortAscButton:StripTextures()
	SkilletSortAscButton:SetTemplate("Default", true)
	if not SkilletSortAscButton.texture then
		SkilletSortAscButton.texture = SkilletSortAscButton:CreateTexture(nil, 'OVERLAY')
		SkilletSortAscButton.texture:Point("TOPLEFT", 2, -2)
		SkilletSortAscButton.texture:Point("BOTTOMRIGHT", -2, 2)
		SkilletSortAscButton.texture:SetTexture([[Interface\AddOns\Tukui\medias\textures\arrowup.tga]])
		SkilletSortAscButton.texture:SetVertexColor(unpack(C["media"].bordercolor))
	end
-- Sort down Button
	SkilletSortDescButton:StripTextures()
	SkilletSortDescButton:SetTemplate("Default", true)
	if not SkilletSortDescButton.texture then
		SkilletSortDescButton.texture = SkilletSortDescButton:CreateTexture(nil, 'OVERLAY')
		SkilletSortDescButton.texture:Point("TOPLEFT", 2, -2)
		SkilletSortDescButton.texture:Point("BOTTOMRIGHT", -2, 2)
		SkilletSortDescButton.texture:SetTexture([[Interface\AddOns\Tukui\medias\textures\arrowdown.tga]])
		SkilletSortDescButton.texture:SetVertexColor(unpack(C["media"].bordercolor))
	end

-- Skin Next/Previous Buttons
	T.SkinNextPrevButton(SkilletRecipeGroupOperations)

-- Skin Edit Box's
	T.SkinEditBox(SkilletItemCountInputBox)
	T.SkinEditBox(SkillButtonNameEdit)
	T.SkinEditBox(GroupButtonNameEdit)
	T.SkinEditBox(SkilletFilterBox)
	SkilletFilterBox:SetHeight(20)
	T.SkinEditBox(SkilletQueueSaveEditBox)

-- Rank Frame
	SkilletRankFrameBorder:StripTextures()
	SkilletRankFrame:StripTextures()
	SkilletRankFrame:CreateBackdrop("Default")
	SkilletRankFrame:SetStatusBarTexture(C["media"].normTex)
	SkilletRankFrame:SetHeight(10)

-- Skin Scrollbar
	T.SkinScrollBar(SkilletSkillListScrollBar, 5)

-- Do some stuff when SkilletFrame is shown.
	local SkilletOnload = _G["SkilletSkillListParent"]
	SkilletOnload:SetScript("OnShow", SkilletFrameOnShow)

-- Do some stuff when SkilletFrame is Updated.
	local SkilletOnUpdate = _G["SkilletSkillListParent"]
	SkilletOnUpdate:SetScript("OnUpdate", SkilletFrameOnUpdate)

-- Shopping List
	local Shopping = _G["SkilletShoppingList"]
	Shopping:SetScript("OnShow", SkinShopping)

-- Skin Icons
	local icon = _G["SkilletHideUncraftableRecipes"]
	icon:SetScript("OnUpdate", SkinIcon)

-- Plugin Buttons
	local plugin = _G["SkilletPluginButton"]
	plugin:SetScript("PostClick", SkinPluginButtons)
end)