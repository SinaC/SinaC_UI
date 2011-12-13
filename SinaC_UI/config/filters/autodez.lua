local T, C, L = unpack(Tukui) -- Import Functions/Constants, Config, Locales

local function ItemName(itemID)
	return select(1, GetItemInfo(itemID))
end

T.AutoGreedList = {
	ItemName(43102), -- Frozen Orb
	ItemName(52078), -- Chaos orb
	ItemName(33865), -- Hex sticks/Charms
	ItemName(33930), -- Hex sticks/Charms
	ItemName(33931), -- Hex sticks/Charms
	ItemName(33932), -- Hex sticks/Charms
	ItemName(33933), -- Hex sticks/Charms
}

T.AutoPassList = {
	ItemName(43102), -- Frozen Orb
	ItemName(52078), -- Chaos orb
	ItemName(52499), -- JC Trinkets
	ItemName(52501), -- JC Trinkets
	ItemName(52502), -- JC Trinkets
	ItemName(52503), -- JC Trinkets
	ItemName(32897), -- Illidary Marks
}