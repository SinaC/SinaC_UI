-- Ripped from Jasje_Auctionator_Skin by Jasje

local T, C, L = unpack(Tukui)

if not C.general.auctionatorreskin then return end
if not IsAddOnLoaded("Auctionator") then return end

--Skinning Auctionator
local AuctionSkin = CreateFrame("Frame")
AuctionSkin:RegisterEvent("ADDON_LOADED")
AuctionSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
	--if not IsAddOnLoaded("Auctionator") then return end

	if addon == "Blizzard_AuctionUI" then
		T.SkinDropDownBox(Atr_Duration)
		T.SkinDropDownBox(Atr_DropDownSL)

		T.SkinButton(Atr_Search_Button, true)
		T.SkinButton(Atr_Back_Button, true)
		T.SkinButton(Atr_Buy1_Button, true)
		T.SkinButton(Atr_Adv_Search_Button, true)
		T.SkinButton(Atr_FullScanButton, true)
		T.SkinButton(Auctionator1Button, true)
		T.SkinButton(Atr_ListTabsTab1, true)
		T.SkinButton(Atr_ListTabsTab2, true)
		T.SkinButton(Atr_ListTabsTab3, true)
		T.SkinButton(Atr_CreateAuctionButton, true)
		T.SkinButton(Atr_RemFromSListButton, true)
		T.SkinButton(Atr_AddToSListButton, true)
		T.SkinButton(Atr_SrchSListButton, true)
		T.SkinButton(Atr_MngSListsButton, true)
		T.SkinButton(Atr_NewSListButton, true)
		T.SkinButton(Atr_CheckActiveButton, true)
		T.SkinButton(AuctionatorCloseButton, true)
		T.SkinButton(Atr_CancelSelectionButton, true)
		T.SkinButton(Atr_FullScanStartButton, true)
		T.SkinButton(Atr_FullScanDone, true)
		T.SkinButton(Atr_CheckActives_Yes_Button, true)
		T.SkinButton(Atr_CheckActives_No_Button, true)
		T.SkinButton(Atr_Adv_Search_ResetBut, true)
		T.SkinButton(Atr_Adv_Search_OKBut, true)
		T.SkinButton(Atr_Adv_Search_CancelBut, true)
		T.SkinButton(Atr_Buy_Confirm_OKBut, true)
		T.SkinButton(Atr_Buy_Confirm_CancelBut, true)
		T.SkinButton(Atr_SaveThisList_Button, true)
		T.SkinButton(Atr_RecommendItem_Tex, true)
		T.SkinButton(Atr_SellControls_Tex, true)

		T.SkinEditBox(Atr_StartingPriceGold)
		T.SkinEditBox(Atr_StartingPriceSilver)
		T.SkinEditBox(Atr_StartingPriceCopper)
		T.SkinEditBox(Atr_StackPriceGold)
		T.SkinEditBox(Atr_StackPriceSilver)
		T.SkinEditBox(Atr_StackPriceCopper)
		T.SkinEditBox(Atr_ItemPriceGold)
		T.SkinEditBox(Atr_ItemPriceSilver)
		T.SkinEditBox(Atr_ItemPriceCopper)
		T.SkinEditBox(Atr_Batch_NumAuctions)
		T.SkinEditBox(Atr_Batch_Stacksize)
		T.SkinEditBox(Atr_Search_Box)
		T.SkinEditBox(Atr_AS_Searchtext)
		T.SkinEditBox(Atr_AS_Minlevel)
		T.SkinEditBox(Atr_AS_Maxlevel)
		T.SkinEditBox(Atr_AS_MinItemlevel)
		T.SkinEditBox(Atr_AS_MaxItemlevel)
		T.SkinScrollBar(AuctionatorScrollFrameScrollBar)
		T.SkinScrollBar(Atr_Hlist_ScrollFrameScrollBar)

		Atr_FullScanResults:StripTextures()
		Atr_FullScanResults:SetTemplate("Transparent")
		Atr_Adv_Search_Dialog:StripTextures()
		Atr_Adv_Search_Dialog:SetTemplate("Transparent")
		Atr_FullScanFrame:StripTextures()
		Atr_FullScanFrame:SetTemplate("Transparent")
		Atr_HeadingsBar:StripTextures()
        Atr_HeadingsBar:SetTemplate("Default")
		Atr_HeadingsBar:Height(246)
		Atr_Error_Frame:StripTextures()
		Atr_Error_Frame:SetTemplate("Transparent")
		Atr_Hlist:StripTextures()
        Atr_Hlist:SetTemplate("Default")
		Atr_Hlist:Width(196)
		Atr_Hlist:ClearAllPoints()
		Atr_Hlist:Point("TOPLEFT", -195, -75)
		Atr_Buy_Confirm_Frame:StripTextures()
		Atr_Buy_Confirm_Frame:SetTemplate("Default")
		Atr_CheckActives_Frame:StripTextures()
		Atr_CheckActives_Frame:SetTemplate("Default")

		-- resize some buttons to fit
		Atr_SrchSListButton:Width(196)
		Atr_MngSListsButton:Width(196)
		Atr_NewSListButton:Width(196)
		Atr_CheckActiveButton:Width(196)
		
		Atr_CreateAuctionButton:Width(165)
		Atr_CreateAuctionButton:ClearAllPoints()
		Atr_CreateAuctionButton:Point("CENTER", 14, -20)

		Atr_DropDownSL:Width(224)
		Atr_DropDownSL:ClearAllPoints()
		Atr_DropDownSL:Point("TOP", Atr_Hlist, -6, 25)

		Atr_Col1_Heading:ClearAllPoints()
		Atr_Col1_Heading:Point("TOPLEFT", Atr_HeadingsBar, 40, -32)

		Atr_Col3_Heading:ClearAllPoints()
		Atr_Col3_Heading:Point("RIGHT", Atr_Col1_Heading, 105, 1)

		Atr_Col4_Heading:ClearAllPoints()
		Atr_Col4_Heading:Point("RIGHT", Atr_Col3_Heading, 310, 0)

		for i = 1, 6 do
			T.SkinTab(_G["AuctionFrameTab"..i])
		end

		-- Button Positions
		AuctionatorCloseButton:ClearAllPoints()
		AuctionatorCloseButton:Point("BOTTOMLEFT", Atr_Main_Panel, "BOTTOMRIGHT", -17, 10)
		Atr_Buy1_Button:Point("RIGHT", AuctionatorCloseButton, "LEFT", -5, 0)
		Atr_CancelSelectionButton:Point("RIGHT", Atr_Buy1_Button, "LEFT", -5, 0)
	end

	-- option frames
	Atr_BasicOptionsFrame:StripTextures()
	Atr_BasicOptionsFrame:SetTemplate("Default")
	T.SkinCheckBox(AuctionatorOption_Enable_Alt_CB)
	T.SkinCheckBox(AuctionatorOption_Open_All_Bags_CB)
	T.SkinCheckBox(AuctionatorOption_Show_StartingPrice_CB)
	T.SkinCheckBox(Atr_RB_N)
	T.SkinCheckBox(Atr_RB_M)
	T.SkinCheckBox(Atr_RB_S)
	T.SkinCheckBox(Atr_RB_L)

	Atr_TooltipsOptionsFrame:StripTextures()
	Atr_TooltipsOptionsFrame:SetTemplate("Default")
	T.SkinCheckBox(ATR_tipsVendorOpt_CB)
	T.SkinCheckBox(ATR_tipsAuctionOpt_CB)
	T.SkinCheckBox(ATR_tipsDisenchantOpt_CB)

	Atr_UCConfigFrame:StripTextures()
	Atr_UCConfigFrame:SetTemplate("Default")
	T.SkinButton(Atr_UCConfigFrame_Reset)
	T.SkinEditBox(Atr_Starting_Discount)

	T.SkinEditBox(UC_5000000_MoneyInputGold)
	T.SkinEditBox(UC_5000000_MoneyInputSilver)
	T.SkinEditBox(UC_5000000_MoneyInputCopper)
	T.SkinEditBox(UC_1000000_MoneyInputGold)
	T.SkinEditBox(UC_1000000_MoneyInputSilver)
	T.SkinEditBox(UC_1000000_MoneyInputCopper)
	T.SkinEditBox(UC_200000_MoneyInputGold)
	T.SkinEditBox(UC_200000_MoneyInputSilver)
	T.SkinEditBox(UC_200000_MoneyInputCopper)
	T.SkinEditBox(UC_50000_MoneyInputGold)
	T.SkinEditBox(UC_50000_MoneyInputSilver)
	T.SkinEditBox(UC_50000_MoneyInputCopper)
	T.SkinEditBox(UC_10000_MoneyInputGold)
	T.SkinEditBox(UC_10000_MoneyInputSilver)
	T.SkinEditBox(UC_10000_MoneyInputCopper)
	T.SkinEditBox(UC_2000_MoneyInputGold)
	T.SkinEditBox(UC_2000_MoneyInputSilver)
	T.SkinEditBox(UC_2000_MoneyInputCopper)
	T.SkinEditBox(UC_500_MoneyInputGold)
	T.SkinEditBox(UC_500_MoneyInputSilver)
	T.SkinEditBox(UC_500_MoneyInputCopper)

	Atr_StackingOptionsFrame:StripTextures()
	Atr_StackingOptionsFrame:SetTemplate("Default")  
	Atr_Stacking_List:StripTextures()
	Atr_Stacking_List:SetTemplate("Default")

	T.SkinButton(Atr_StackingOptionsFrame_Edit)
	T.SkinButton(Atr_StackingOptionsFrame_New)

	Atr_ScanningOptionsFrame:StripTextures()
	Atr_ScanningOptionsFrame:SetTemplate("Default")  

	T.SkinCheckBox(Atr_ScanOpts_MaxHistAge)

	AuctionatorResetsFrame:StripTextures()
	AuctionatorResetsFrame:SetTemplate("Default") 

	Atr_ShpList_Options_Frame:StripTextures()
	Atr_ShpList_Options_Frame:SetTemplate("Default")
	Atr_ShpList_Frame:StripTextures()
	Atr_ShpList_Frame:SetTemplate("Default")  

	T.SkinButton(Atr_ShpList_DeleteButton)
	T.SkinButton(Atr_ShpList_EditButton)
	T.SkinButton(Atr_ShpList_RenameButton)
	T.SkinButton(Atr_ShpList_ExportButton)
	T.SkinButton(Atr_ShpList_ImportButton) -- there are 2 buttons called like this, need to find a fix

	AuctionatorDescriptionFrame:StripTextures()
	AuctionatorDescriptionFrame:SetTemplate("Default")

	Atr_ShpList_Edit_Frame:StripTextures()
	Atr_ShpList_Edit_Frame:SetTemplate("Default")

	T.SkinButton(Atr_ShpList_ImportSaveBut)
	T.SkinButton(Atr_ShpList_SelectAllBut)
	T.SkinButton(Atr_ShpList_SaveBut)
	Atr_ShpList_Edit_FrameScrollFrameScrollBar:StripTextures()
	T.SkinScrollBar(Atr_ShpList_Edit_FrameScrollFrameScrollBar)

	T.SkinDropDownBox(AuctionatorOption_Deftab)
	T.SkinDropDownBox(Atr_tipsShiftDD)
	T.SkinDropDownBox(Atr_deDetailsDD)
	T.SkinDropDownBox(Atr_scanLevelDD)

	Atr_ConfirmClear_Frame:StripTextures()
	Atr_ConfirmClear_Frame:SetTemplate("Default")

	T.SkinButton(Atr_ClearConfirm_Cancel)

	Atr_MemorizeFrame:StripTextures()
	Atr_MemorizeFrame:SetTemplate("Default")

	T.SkinButton(Atr_Mem_Forget)
	T.SkinButton( Atr_Mem_Cancel)
	T.SkinDropDownBox(Atr_Mem_DD_numStacks)
	T.SkinCheckBox(Atr_Mem_EB_stackSize)

	if addon == "Blizzard_TradeSkillUI" then
		T.SkinButton(Auctionator_Search, true)
	end
end)