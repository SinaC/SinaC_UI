--http://www.tukui.org/forums/topic.php?id=16333

local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales

if true then return end

if C["actionbar"].enable ~= true then return end
if C["actionbar"].totemflyoutbelow ~= true then return end

if T.myclass == "SHAMAN" then
	-- Horizontal bar, open below instead of above
	if MultiCastActionBarFrame then
--[[
		local function StyleTotemFlyout(flyout)
			local last = nil
			for _, button in ipairs(flyout.buttons) do
				if not InCombatLockdown() then
					button:ClearAllPoints()
					button:Point("TOP", last, "BOTTOM", 0, -T.buttonspacing)
				end
				if button:IsVisible() then last = button end
			end
			flyout.buttons[1]:ClearAllPoints()
			flyout.buttons[1]:SetPoint("BOTTOM", flyout, "BOTTOM")

			local close = MultiCastFlyoutFrameCloseButton
			close:ClearAllPoints()
			close:Point("TOPLEFT", last, "BOTTOMLEFT", 0, -T.buttonspacing)
			close:Point("TOPRIGHT", last, "BOTTOMRIGHT", 0, -T.buttonspacing)

			flyout:ClearAllPoints()
			flyout:Point("BOTTOM", flyout.parent, "BOTTOM", 0, -(T.buttonspacing+flyout.parent:GetHeight())) -- I'm lazy I know
		end
		hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout", function(self) StyleTotemFlyout(self) end)
--]]
		local function StyleTotemOpenButton(button, parent)
			button:ClearAllPoints()
			button:Point("TOPLEFT", parent, "BOTTOMLEFT", 0, 3)
			button:Point("TOPRIGHT", parent, "BOTTOMRIGHT", 0, 3)
		end
		hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show", function(button, _, parent) StyleTotemOpenButton(button, parent) end)
	end
end
--[[
if T.myclass == "SHAMAN" then
	if MultiCastActionBarFrame then
	-- VERTICAL TOTEM BAR
	-- MultiCastRecallSpellButton cannot be moved :/
		--panel
		local TukuiTotemBar = CreateFrame("Frame", "TukuiTotemBar", UIParent)
		TukuiTotemBar:SetWidth(TukuiShiftBar:GetWidth())
		TukuiTotemBar:SetHeight(TukuiShiftBar:GetHeight())
		--TukuiTotemBar:SetPoint("BOTTOMLEFT", TukuiShiftBar, "BOTTOMLEFT", 0, 0)
		TukuiTotemBar:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		TukuiTotemBar:SetMovable(false)
		TukuiTotemBar:Show()

		-- TODO: Tukz why did you remove SetPoint on MultiCastRecallSpellButton in BarTotem.lua
		-- MultiCastRecallSpellButton:SetParent(TukuiTotemBar)
		-- MultiCastRecallSpellButton:ClearAllPoints()
		-- MultiCastRecallSpellButton:SetPoint("BOTTOM", TukuiTotemBar, "TOP", 0, T.buttonspacing)

		MultiCastSummonSpellButton:SetParent(TukuiTotemBar)
		MultiCastSummonSpellButton:ClearAllPoints()
		MultiCastSummonSpellButton:SetPoint("BOTTOM", TukuiTotemBar, "BOTTOM", 0, T.buttonspacing)

		for i=1, 4 do
			_G["MultiCastSlotButton"..i]:SetParent(TukuiTotemBar)
		end
		MultiCastSlotButton1:ClearAllPoints()
		MultiCastSlotButton1:SetPoint("BOTTOM", MultiCastSummonSpellButton, "TOP", 0, T.buttonspacing)
		for i=2, 4 do
			local b = _G["MultiCastSlotButton"..i]
			local b2 = _G["MultiCastSlotButton"..i-1]
			b:ClearAllPoints()
			b:SetPoint("BOTTOM", b2, "TOP", 0, T.buttonspacing)
		end
		for i=1, 4 do
			local b = _G["MultiCastSlotButton"..i]
			b.SetParent = T.dummy
			b.SetPoint = T.dummy
		end

		--style
		local function StyleTotemFlyout(flyout)
			local last = nil
			for _,button in ipairs(flyout.buttons) do
				if not InCombatLockdown() then
					button:Size(T.buttonsize)
					button:ClearAllPoints()
					button:Point("RIGHT",last,"LEFT", -T.buttonspacing, 0)
				end
				if button:IsVisible() then last = button end
			end
			flyout.buttons[1]:ClearAllPoints()
			flyout.buttons[1]:SetPoint("BOTTOM",flyout,"BOTTOM")
			local close = MultiCastFlyoutFrameCloseButton
			close:ClearAllPoints()
			close:Point("TOPRIGHT",last,"TOPLEFT", -T.buttonspacing, 0)
			close:Point("BOTTOMRIGHT",last,"BOTTOMLEFT", -T.buttonspacing, 0)
			close:Height(T.buttonsize)
			close:Width(8)
			flyout:ClearAllPoints()
			flyout:Point("BOTTOMRIGHT",flyout.parent,"BOTTOMLEFT", -(T.buttonspacing + 1), 0)
		end
		hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout",function(self) StyleTotemFlyout(self) end)

		local function StyleTotemOpenButton(button, parent)
			button:ClearAllPoints()
			button:Point("TOPRIGHT", parent, "TOPLEFT", 0, 0)
			button:Point("BOTTOMRIGHT", parent, "BOTTOMLEFT", 0, 0)
			if button.visibleBut then
				button.visibleBut:Height(button:GetWidth())
				button.visibleBut:Width(8)
			end
		end
		hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show",function(button,_, parent) StyleTotemOpenButton(button, parent) end)

		local function StyleTotemSlotButton(button, index)
			if not InCombatLockdown() then button:Size(T.buttonsize) end
		end
		hooksecurefunc("MultiCastSlotButton_Update",function(self, slot) StyleTotemSlotButton(self,tonumber(string.match(self:GetName(),"MultiCastSlotButton(%d)"))) end)

		local function StyleTotemSpellButton(button, index)
			if not InCombatLockdown() then button:Size(T.buttonsize) end
		end
		hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) StyleTotemSpellButton(self,0) end)
		hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) StyleTotemSpellButton(self,5) end)
	end
end
--]]
