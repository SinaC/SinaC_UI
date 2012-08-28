local T, C, L = unpack(Tukui)

-- Mapping between datatext name and datatext frame name
local dt = {
	armor = "Armor",
	guild = "Guild",
	friends = "Friends",
	avd = "Avoidance",
	wowtime = "Time",
	gold = "Gold",
	fps_ms = "FPS",
	system = "System",
	bags = "Bags",
	dur = "Durability",
	hps_text = "Heal",
	dps_text = "Damage",
	power = "Power",
	haste = "Haste",
	crit = "Crit",
	currency = "Currency",
	hit = "Hit",
	mastery = "Mastery",
	micromenu = "MicroMenu",
	regen = "Regen",
	talent = "Talent",
	calltoarms = "CallToArms",
}

-- Reposition datatext
for option, stat in pairs(dt) do
	local t = "TukuiStat"
	local frame = _G[t..stat]
	local text = _G[t..stat.."Text"]

	if frame then
		for opt, result in pairs(C.datatext) do
			if opt == option then
				T.DataTextPosition(result, text)
			end
		end
	end
end