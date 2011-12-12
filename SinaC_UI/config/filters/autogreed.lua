local T, C, L = unpack(Tukui) -- Import Functions/Constants, Config, Locales

local function ItemName(itemID)
	return select(1, GetItemInfo(itemID))
end

T.AutoGreedList = {
	ItemName(43102), -- Frozen Orb
	ItemName(52078), -- Chaos orb
}