local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales

if C["loot"].autogreed == true then
	local frame = _G["TukuiAutoGreed"]
	if frame then
		frame:SetScript("OnEvent", function(self, event, id)
			local name = select(2, GetLootRollItemInfo(id))
			-- autogreed
			for _, itemName in ipairs(T.AutoGreedList) do
				if (name == itemName) then
					RollOnLoot(id, 2)
					return
				end
			end
			if T.level ~= MAX_PLAYER_LEVEL then return end
			if(id and select(4, GetLootRollItemInfo(id))==2 and not (select(5, GetLootRollItemInfo(id)))) then
				if RollOnLoot(id, 3) then
					RollOnLoot(id, 3)
				else
					RollOnLoot(id, 2)
				end
			end
		end)
	else
		print("SinaC UI: cannot replace Tukui autogreed/autodez")
		return
	end
end