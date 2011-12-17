local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local print = Private.print
local error = Private.error

if not C["loot"].autogreed == true then return end

if not TukuiAutoGreed then
	error("Tukui autodez not found")
	return
end

TukuiAutoGreed:SetScript("OnEvent", function(self, event, id)
	local _, name, _, quality, bindOnPickUp = GetLootRollItemInfo(id)
	-- autogreed
	for _, itemName in ipairs(T.AutoGreedList) do
		if name == itemName then
			RollOnLoot(id, 2) -- Greed
			break
		end
	end
	-- autopass
	for _, itemName in ipairs(T.AutoPassList) do
		if name == itemName then
			RollOnLoot(id, 0) -- Pass
			break
		end
	end
	if T.level ~= MAX_PLAYER_LEVEL then return end
	-- autodez green if not bind on pickup and Bountiful Bags guild perks not known
	local bountifulBags = IsSpellKnown(83966) -- Guild perks: Bountiful Bags (no auto disenchant)
	if id and quality == 2 and not bindOnPickUp then
		if not bountifulBags and RollOnLoot(id, 3) then
			RollOnLoot(id, 3) -- Dez
		else
			RollOnLoot(id, 2) -- Greed
		end
	end
end)