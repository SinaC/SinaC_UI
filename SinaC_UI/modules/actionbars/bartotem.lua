local T, C, L = unpack(Tukui)
-- Import: T - functions, constants, variables; C - config; L - locales

if true then return end -- TODO

if C["actionbar"].enable ~= true then return end

if T.myclass == "SHAMAN" then
	if MultiCastActionBarFrame then
		--panel
		local TukuiTotemBar = CreateFrame("Frame", "TukuiTotemBar", UIParent)
		TukuiTotemBar:SetWidth(TukuiBarTotem:GetWidth())
		TukuiTotemBar:SetHeight(TukuiBarTotem:GetHeight())
		TukuiTotemBar:SetPoint("BOTTOMLEFT", TukuiBarTotem, "BOTTOMLEFT", 0, 0)
		TukuiTotemBar:SetMovable(false)
		TukuiTotemBar:Show()

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
		hooksecurefunc("MultiCastSlotButton_Update",function(self, slot) StyleTotemSlotButton(self,tonumber( string.match(self:GetName(),"MultiCastSlotButton(%d)"))) end)		

		local function StyleTotemSpellButton(button, index)
			if not InCombatLockdown() then button:Size(T.buttonsize) end
		end
		hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) StyleTotemSpellButton(self,0) end)
		hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) StyleTotemSpellButton(self,5) end)
	end
end
