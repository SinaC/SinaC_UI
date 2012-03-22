local C = {}

C["general"] = {
	["blizzardreskin"] = true,							-- reskin all Blizzard frames
	["dbmreskin"] = true,								-- reskin dbm
	["omenreskin"] = true,								-- reskin omen
	["recountreskin"] = true,							-- reskin recount
	["auctionatorreskin"] = true,						-- reskin auctionator [NEW]
	["skilletreskin"] = true,							-- reskin skillet [NEW]
	["adibagsreskin"] = true,							-- reskin adibags [NEW]
	["debug"] = 1000,									-- debug minimum display level [NEW]
}

C["actionbar"] = {
	["totemflyoutbelow"] = true,						-- totem flyout are displayed below totem bar instead of above
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
	["width"] = 105,									-- width [NEW]
	["height"] = 12,									-- height [NEW]
	["cbheight"] = 5,									-- castbar height [NEW]
	["goodscale"] = 1,									-- good scale [NEW]
	["badscale"] = 1,									-- bad scale [NEW]
	["goodcolor"] = {75/255, 175/255, 76/255},			-- good threat color (tank shows this with threat, everyone else without)
	["badcolor"] = {0.78, 0.25, 0.25},					-- bad threat color (opposite of above)
	["goodtransitioncolor"] = {218/255, 197/255, 92/255},	-- threat color when gaining threat [NEW]
	["badtransitioncolor"] = {240/255, 154/255, 17/255},-- threat color when losing threat [NEW]
	["trackauras"] = true,								-- track players debuffs only (debuff list derived from classtimer spell list) [NEW]
	["trackccauras"] = true,							-- track all CC debuffs [NEW]
}

C["merchant"] = {
	["guildrepair"] = true								-- use guild funds for autorepair [NEW]
}

C["bags"] = {
	["enable"] = false,									-- enable an all in one bag mod that fit tukui perfectly
}

C["chat"] = {
	["background"] = true
}

C["spechelper"] = { --[NEW]
	["enable"] = true,									-- enable tool for easy spec/gear switch
	["hovercolor"] = {.4, .4, .4},						-- backdrop border color when mouse hovering frame
	["panelcolor"] = {.4, .4, .4},						-- spec panel text color
	["specswitchcastbar"] = false,						-- display a castbar when switching spec
	["enablegear"] = true,								-- enable set/gear switch
	["maxsets"] = 10,									-- maximum number of set displayed
	["autogearswap"] = false,							-- automatically switch gear when switching spec
	["setprimary"] = 1,									-- this is the gear set that gets equiped with your primary spec if autogearswap is enabled
	["setsecondary"] = 2								-- this is the gear set that gets equiped with your secondary spec if autogearswap is enabled
}

C["extras"] = { --[NEW]
	["raidbuff"] = true,								-- enable raid buff reminder
	["offensivedispel"] = true,							-- enable raid buff reminder
}

C["notifications"] = { -- [NEW]
	["selfbuffs"] = true,								-- notifications for self-buffs
	["weapons"] = true									-- notifications for weapon-buffs
}

C["raidhealium"] = { -- [NEW]
	["showpets"] = false,								-- display pets
	["gridhealthheight"] = 27,							-- health height in grid mode
	["gridbuttonbyrow"] = 5,							-- number of button in a row in grid mode
	["gridbuttonsize"] = 20,							-- button size in grid mode
	["gridbuffsize"] = 20,								-- buff size in grid mode
	["griddebuffsize"] = 20,							-- debuff size in grid mode
}

-- make it public
TukuiEditedDefaultConfig = C