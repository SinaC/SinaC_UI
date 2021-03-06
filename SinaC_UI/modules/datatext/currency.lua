-- Based on ElvUI_ImprovedCurrency written by Mirach (US-Mal'Ganis)
-- TODO: update doesn't work, it's overridden by Tukui/Modules/Datatext/Currency.lua

local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local error = Private.error

--------------------------------------------------------------------
 -- CURRENCY
--------------------------------------------------------------------
if not C["datatext"].currency or C["datatext"].currency <= 0 then return end

local Text = TukuiStatCurrencyText
local Stat = TukuiStatCurrency
if not Text or not Stat then
	error("Tukui currency datatext not found.")
	return
end

---------------------------------------------
-- update
---------------------------------------------
local function update()
	local _text = Stat.Color2.."---".."|r"
	for i = 1, MAX_WATCHED_TOKENS do
		local name, count = GetBackpackCurrencyInfo(i)
		if name and count then
			if(i ~= 1) then _text = _text .. " " else _text = "" end
			local words = { strsplit(" ", name) }
			if T.client == "frFR" then
				-- special case for french, split using - and remove '
--print(tostring(name)..":"..tostring(count))
				for _, word in ipairs(words) do
					local tokens = { strsplit("-", word) }
					for _, token in ipairs(tokens) do
						local first = string.sub(token, 1, 1)
						local second = string.sub(token, 2, 2)
--print(tostring(token).."  "..tostring(first).."  "..tostring(second).."  "..tostring(_text))
						if second == "'" then -- d'  l'
							_text = _text .. Stat.Color1.. string.upper(string.sub(word, 3, 3)).."|r"
						elseif first ~= "d" then -- de  des
							_text = _text .. Stat.Color1..string.upper(first).."|r"
						end
					end
				end
			else
				for _, word in ipairs(words) do
					_text = _text .. Stat.Color1.. string.upper(string.sub(word, 1, 1)).."|r"
				end
			end
			_text = _text .. Stat.Color1..": |r" .. Stat.Color2..count.."|r"
		end
	end
--print("==>"..tostring(_text))
	Text:SetText(_text)
end

---------------------------------------------
-- OnEnter
---------------------------------------------
-- http://www.wowhead.com/currencies
local CurrencyID = {61, 81, 241, 361, 384, 385, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 416, 515, 614, 615}
local PvPCurrency = {390, 392}
local CurrencyDict = nil

local SPACER = "       "
local VERBOSE_LEFT_COLOR1 = {r=0.5, g=0.5, b=0.85}
local VERBOSE_RIGHT_COLOR1 = {r=0.5, g=0.5, b=0.85}
local VERBOSE_LEFT_COLOR2 = {r=0.5, g=0.5, b=0.6}
local VERBOSE_RIGHT_COLOR2 = {r=0.5, g=0.5, b=0.6}

local HONOR_POINT_CURRENCY = 392
local JUSTICE_POINT_CURRENCY = 395
local VALOR_POINT_CURRENCY = 396

local VALOR_TIER1_LFG_ID = 301 -- /FrameXML/LFDFrame.lua

local showUnused = false
local showIcons = true

local function CreateCurrencyDictionary()
	CurrencyDict = {}
	for k, v in pairs(CurrencyID) do
		curr = {}
		curr["name"], curr["count"], curr["texture"], curr["4"], curr["weeklyMax"], curr["totalMax"], curr["7"] = GetCurrencyInfo(v)
		if curr["weeklyMax"] and curr["weeklyMax"] >= 10000 then 
			curr["weeklyMax"] = curr["weeklyMax"] / 100
		end
		if curr["totalMax"] and curr["totalMax"] >= 10000 then 
			curr["totalMax"] = curr["totalMax"] / 100
		end
		curr["id"] = v
		if v == VALOR_POINT_CURRENCY then -- valor pt
			curr["lfdID"] = VALOR_TIER1_LFG_ID
		end
		CurrencyDict[curr["name"]] = curr
	end
end

local function IsPvPCurrency(curr)
	for k, v in pairs(PvPCurrency) do
		if v == curr["id"] then
			return true
		end
	end
	return false
end

local function FormatPvP(cli, curr, lines)
	local lcolorR, lcolorG, lcolorB = VERBOSE_LEFT_COLOR1.r, VERBOSE_LEFT_COLOR1.g, VERBOSE_LEFT_COLOR1.b
	local rcolorR, rcolorG, rcolorB = VERBOSE_RIGHT_COLOR1.r, VERBOSE_RIGHT_COLOR1.g, VERBOSE_RIGHT_COLOR1.b

	local lcolorR2, lcolorG2, lcolorB2 = VERBOSE_LEFT_COLOR2.r, VERBOSE_LEFT_COLOR2.g, VERBOSE_LEFT_COLOR2.b
	local rcolorR2, rcolorG2, rcolorB2 = VERBOSE_RIGHT_COLOR2.r, VERBOSE_RIGHT_COLOR2.g, VERBOSE_RIGHT_COLOR2.b

	if curr["id"] == HONOR_POINT_CURRENCY then  -- Honor point
		local line2 = {}
		line2["left"] = SPACER..FROM_ALL_SOURCES
		line2["right"] =  tostring(cli["count"]).."/"..tostring(curr["totalMax"])
		line2["lr"], line2["lg"], line2["lb"] = lcolorR, lcolorG, lcolorB
		line2["rr"], line2["rg"], line2["rb"] = rcolorR, rcolorG, rcolorB
		tinsert(lines, line2)
		return
	end

	local capbar = {}
	capbar["pointsThisWeek"], capbar["maxPointsThisWeek"], capbar["tier2Quantity"], capbar["tier2Limit"], capbar["tier1Quantity"], capbar["tier1Limit"] = GetPVPRewards()
	if not capbar["maxPointsThisWeek"] then return end

	local line2 = {}
	line2["left"] = SPACER..FROM_ALL_SOURCES
	line2["right"] =  format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["pointsThisWeek"], capbar["maxPointsThisWeek"])
		line2["lr"], line2["lg"], line2["lb"] = lcolorR, lcolorG, lcolorB
		line2["rr"], line2["rg"], line2["rb"] = rcolorR, rcolorG, rcolorB
	tinsert(lines, line2)

	local line3 = {}
	line3["left"] = SPACER.." -"..FROM_RATEDBG
	line3["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["tier2Quantity"], capbar["tier2Limit"])
        line3["lr"], line3["lg"], line3["lb"] = lcolorR2, lcolorG2, lcolorB2
        line3["rr"], line3["rg"], line3["rb"] = rcolorR2, rcolorG2, rcolorB2
	tinsert(lines, line3)

	local line4 = {}
	line4["left"] = SPACER.." -"..FROM_ARENA
	line4["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["tier1Quantity"], capbar["tier1Limit"])
		line4["lr"], line4["lg"], line4["lb"] = lcolorR, lcolorG, lcolorB
		line4["rr"], line4["rg"], line4["rb"] = rcolorR, rcolorG, rcolorB
	tinsert(lines, line4)
end

local function FormatGeneral(cli, curr, lines)
	local lcolorR, lcolorG, lcolorB = VERBOSE_LEFT_COLOR1.r, VERBOSE_LEFT_COLOR1.g, VERBOSE_LEFT_COLOR1.b
	local rcolorR, rcolorG, rcolorB = VERBOSE_RIGHT_COLOR1.r, VERBOSE_RIGHT_COLOR1.g, VERBOSE_RIGHT_COLOR1.b

	local lcolorR2, lcolorG2, lcolorB2 = VERBOSE_LEFT_COLOR2.r, VERBOSE_LEFT_COLOR2.g, VERBOSE_LEFT_COLOR2.b
	local rcolorR2, rcolorG2, rcolorB2 = VERBOSE_RIGHT_COLOR2.r, VERBOSE_RIGHT_COLOR2.g, VERBOSE_RIGHT_COLOR2.b

	if curr["id"] == JUSTICE_POINT_CURRENCY then  -- Justice point
		local line2 = {}
		line2["left"] = SPACER..FROM_ALL_SOURCES
		line2["right"] =  tostring(cli["count"]).."/"..tostring(curr["totalMax"])
		line2["lr"], line2["lg"], line2["lb"] = lcolorR, lcolorG, lcolorB
		line2["rr"], line2["rg"], line2["rb"] = rcolorR, rcolorG, rcolorB
		tinsert(lines, line2)
		return
	end

	if not curr["lfdID"] then return end

	-- Get the point info
	local capbar = {}
	capbar["currencyID"], capbar["tier1DungeonID"], capbar["tier1Quantity"], capbar["tier1Limit"], capbar["overallQuantity"], capbar["overallLimit"], capbar["periodPurseQuantity"], capbar["periodPurseLimit"] = GetLFGDungeonRewardCapBarInfo(curr["lfdID"]);
	if not capbar["currencyID"] then return end
        
	local tier1Name = GetLFGDungeonInfo(capbar["tier1DungeonID"])

	local line2 = {}
	line2["left"] = SPACER..FROM_ALL_SOURCES
	line2["right"] =  format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["periodPurseQuantity"], capbar["periodPurseLimit"])
	line2["lr"], line2["lg"], line2["lb"] = lcolorR, lcolorG, lcolorB
	line2["rr"], line2["rg"], line2["rb"] = rcolorR, rcolorG, rcolorB
	tinsert(lines, line2)

	local line3 = {}
	line3["left"] = SPACER.." -"..FROM_RAID
	line3["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["periodPurseQuantity"] - capbar["overallQuantity"], capbar["periodPurseLimit"])
	line3["lr"], line3["lg"], line3["lb"] = lcolorR2, lcolorG2, lcolorB2
	line3["rr"], line3["rg"], line3["rb"] = rcolorR2, rcolorG2, rcolorB2
	tinsert(lines, line3)

	local line4 = {}
	line4["left"] = SPACER.." -"..FROM_DUNGEON_FINDER_SOURCES
	line4["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["overallQuantity"], capbar["overallLimit"])
	line4["lr"], line4["lg"], line4["lb"] = lcolorR, lcolorG, lcolorB
	line4["rr"], line4["rg"], line4["rb"] = rcolorR, rcolorG, rcolorB
	tinsert(lines, line4)

	local line5 = {}
	line5["left"] = SPACER.."   -"..FROM_TROLLPOCALYPSE
	line5["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["overallQuantity"] - capbar["tier1Quantity"], capbar["overallLimit"])
	line5["lr"], line5["lg"], line5["lb"] = lcolorR2, lcolorG2, lcolorB2
	line5["rr"], line5["rg"], line5["rb"] = rcolorR2, rcolorG2, rcolorB2
	tinsert(lines, line5)

	local line6 = {}
	line6["left"] = SPACER.."   -"..format(FROM_A_DUNGEON, tier1Name)
	line6["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["tier1Quantity"], capbar["tier1Limit"])
	line6["lr"], line6["lg"], line6["lb"] = lcolorR, lcolorG, lcolorB
	line6["rr"], line6["rg"], line6["rb"] = rcolorR, rcolorG, rcolorB
	tinsert(lines, line6)
end

local function FormatCurrency(cli)
	local lines = {}
	local line1 = {}

	line1["left"] = "|cffFFFFFF"..cli["name"]
	line1["right"] = cli["count"]
	line1["addTex"] = true
	tinsert(lines, line1)

	if not CurrencyDict then
		-- Create the currency dictionary
		CreateCurrencyDictionary()
	end

	local curr = CurrencyDict[cli["name"]]
	if not curr then
		return lines
	end

	if IsPvPCurrency(curr) == true then
		FormatPvP(cli, curr, lines)
	else
		FormatGeneral(cli, curr, lines)
	end

	return lines
end

local function OnEnter(self)
	local anchor, yoff = T.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(self, anchor, 0, yoff)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, T.mult)
	GameTooltip:ClearLines()

	for i = 1, GetCurrencyListSize(), 1 do
		local cli = {}
		cli["name"], cli["isHeader"], cli["isExpanded"], cli["isUnused"], cli["isWatched"], cli["count"], cli["texture"], cli["max"], cli["weeklyLimit"], cli["currentWeeklyAmt"] = GetCurrencyListInfo(i)
		if showUnused == true then
			cli["isUnused"] = false
		end
		if cli["isHeader"] == true and cli["isUnused"] == false then
			if i > 1 then GameTooltip:AddLine(" ") end
			GameTooltip:AddLine(cli["name"])
		elseif cli["isUnused"] == false then
			local lines = FormatCurrency(cli)
			for k, v in ipairs(lines) do
				GameTooltip:AddDoubleLine(v["left"], v["right"], v["lr"], v["lg"], v["lb"], v["rr"], v["rg"], v["rb"])
				if v["addTex"] and showIcons == true then
					GameTooltip:AddTexture(cli["texture"])
				end
			end
		end
	end

	GameTooltip:Show()
end

---------------------------------------------
-- Handlers
---------------------------------------------
Stat:SetScript("OnEnter", OnEnter)
Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
hooksecurefunc("BackpackTokenFrame_Update", update)