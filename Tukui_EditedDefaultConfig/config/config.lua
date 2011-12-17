local C = {}

C["general"] = {
	["blizzardreskin"] = true,							-- reskin all Blizzard frames
	["dbmreskin"] = true,								-- reskin dbm
	["dxereskin"] = false,								-- reskin dxe
	["omenreskin"] = true,								-- reskin omen
	["recountreskin"] = true,							-- reskin recount
	["skadareskin"] = false,							-- reskin skada
	["tinydpsreskin"] = false,							-- reskin tinydps
	["auctionatorreskin"] = true,						-- reskin auctionator [NEW]
	["skilletreskin"] = true,							-- reskin skillet [NEW]
}

C["unitframes"] = {
	["gridonly"] = false,								-- enable grid only mode for all healer mode raid layout.
	["gridhealthvertical"] = false,						-- enable vertical grow on health bar for grid mode.
	["showplayerinparty"] = true,						-- show my player frame in party
	["showsolo"] = true, 								-- show raid frame even if not in a party or a raid [NEW]
	["unicolor"] = false,								-- enable unicolor theme
	["aggro"] = true,									-- show aggro on all raids layouts
	["showsymbols"] = true,								-- show symbol
	["showrange"] = true,								-- show range opacity on raidframes
	["showsmooth"] = true,								-- enable smooth bar
	["healcomm"] = true,								-- enable healprediction support
}

C["datatext"] = {
	["fps_ms"] = 9,										-- show fps and ms on panels
	["system"] = 5,										-- show total memory and others systems infos on panels
	["gold"] = 6,										-- show your current gold on panels
	["wowtime"] = 8,									-- show time on panels
	["guild"] = 1,										-- show number on guildmate connected on panels
	["dur"] = 2,										-- show your equipment durability on panels.
	["friends"] = 3,									-- show number of friends connected.
	["power"] = 7,										-- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["currency"] = 4,									-- show your tracked currency on panels
}

C["nameplate"] = {
	["enable"] = true,									-- enable nice skinned nameplates that fit into tukui
	["combat"] = false,									-- only show enemy nameplates in-combat.
	["showlevel"] = true,								-- show enemy level [NEW]
	["enhancethreat"] = true,							-- threat features based on if your a tank or not
	["showhealth"] = false,								-- show health text on nameplate
	["width"] = 105,									-- nameplate width [NEW]
	["goodcolor"] = {75/255, 175/255, 76/255},			-- good threat color (tank shows this with threat, everyone else without)
	["badcolor"] = {0.78, 0.25, 0.25},					-- bad threat color (opposite of above)
	["goodtransitioncolor"] = {218/255, 197/255, 92/255},	-- threat color when gaining threat [NEW]
	["badtransitioncolor"] = {240/255, 154/255, 17/255},-- threat color when losing threat [NEW]
	["trackauras"] = true,								-- track players debuffs only (debuff list derived from classtimer spell list) -- new
	["trackccauras"] = true,							-- track all CC debuffs -- new
}

C["merchant"] = {
	["guildrepair"] = true								-- use guild funds for autorepair
}

C["chat"] = {
	["background"] = true
}

-- make it public
TukuiEditedDefaultConfig = C