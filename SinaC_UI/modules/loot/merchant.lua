local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local error = Private.error

if not TukuiMerchant then
	error("Tukui merchant not found")
	return
end

local filter = {
	[6289]  = true, -- Raw Longjaw Mud Snapper
	[6291]  = true, -- Raw Brilliant Smallfish
	[6308]  = true, -- Raw Bristle Whisker Catfish
	[6309]  = true, -- 17 Pound Catfish
	[6310]  = true, -- 19 Pound Catfish
	[41808] = true, -- Bonescale Snapper
	[42336] = true, -- Bloodstone Band
	[42337] = true, -- Sun Rock Ring
	[43244] = true, -- Crystal Citrine Necklace
	[43571] = true, -- Sewer Carp
	[43572] = true, -- Magic Eater
}

TukuiMerchant:SetScript("OnEvent", function() -- Replace Tukui's script by mine
	if C["merchant"].sellgrays or C["merchant"].sellmisc then
		local c = 0
		for b = 0, 4 do
			for s = 1, GetContainerNumSlots(b) do
				local l, lid = GetContainerItemLink(b, s), GetContainerItemID(b, s)
				if l and lid then
					local p = select(11, GetItemInfo(l)) * select(2, GetContainerItemInfo(b, s))
					if C["merchant"].sellgrays and select(3, GetItemInfo(l)) == 0 and p > 0 then
						UseContainerItem(b, s)
						PickupMerchantItem()
						c = c+p
					end
					if C["merchant"].sellmisc and filter[lid] then
						UseContainerItem(b, s)
						PickupMerchantItem()
						c = c+p
					end
				end
			end
		end
		if c > 0 then
			local g, s, c = math.floor(c/10000) or 0, math.floor((c%10000)/100) or 0, c%100
			DEFAULT_CHAT_FRAME:AddMessage(L.merchant_trashsell.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".",255,255,0)
		end
	end
	if not IsShiftKeyDown() then
		if CanMerchantRepair() and C["merchant"].autorepair then
			local cost, possible = GetRepairAllCost()
			if cost > 0 then
				local guildRepairFlag = 0
				if C["merchant"].guildrepair and IsInGuild() and CanGuildBankRepair() then
					if cost <= GetGuildBankWithdrawMoney() then
						guildRepairFlag = 1
					end
				end
				if possible or guildRepairFlag then
					RepairAllItems(guildRepairFlag)
					local c = cost%100
					local s = math.floor((cost%10000)/100)
					local g = math.floor(cost/10000)
					if guildRepairFlag then
						DEFAULT_CHAT_FRAME:AddMessage(L.merchant_guildrepaircost.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".",255,255,0)
					else
						DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repaircost.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".",255,255,0)
					end
				else
					DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repairnomoney,255,0,0)
				end
			end
		end
	end
end)
