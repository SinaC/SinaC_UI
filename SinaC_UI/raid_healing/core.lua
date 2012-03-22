local ADDON_NAME, ns = ...
local SinaCUI = ns.SinaCUI
if not SinaCUI.HealiumEnabled then return end

local Private = SinaCUI.Private
local print = Private.print
local error = Private.error

local T, C, L = unpack(Tukui)
local H, HC, HL = unpack(HealiumCore)

local function HealiumInitCallback(frame)
	local style = frame:GetParent().style -- get frame style
	local health = frame.Health
	local power = frame.Power
	local panel = frame.panel
	local debuffs = frame.Debuffs
	local raidDebuffs = frame.RaidDebuffs
	local weakenedSoul = frame.WeakenedSoul
	local auraWatch = frame.AuraWatch

--print("HealiumInitCallback:"..frame:GetName().."  "..tostring(style))

	-- for layout-specifics, here we edit only 1 layout at time
	if style == "TukuiHealR01R15" then
--print("TukuiHealR01R15")
		frame.DebuffHighlightAlpha = 1
		frame.DebuffHighlightBackdrop = true
		--frame.DebuffHighlightFilter = false -- depends on Healium settings
		--frame.SetBackdropColor = T.dummy
		debuffs:Kill()

		if weakenedSoul then weakenedSoul:Kill() end

		H:RegisterFrame(frame, "TukuiHealiumNormal")
	elseif style == "TukuiHealR25R40" then
--print("TukuiHealR25R40")

		health:ClearAllPoints()
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:Height(27*T.raidscale)

		health.value:Kill()
		health.PostUpdate = T.Dummy
--[[
		power:ClearAllPoints()
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, 3)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, 3)
--]]
--[[
		power:ClearAllPoints()
		power:Width(3*T.raidscale)
		power:Height(27*T.raidscale)
		power:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 1)
		power:SetStatusBarTexture(normTex)
		power:SetOrientation("VERTICAL")
		power:SetFrameLevel(9)
--]]
		panel:Kill()

		local name = health:CreateFontString(nil, "OVERLAY")
		name:SetPoint("LEFT", health, 3, 0)
		name:SetFont(C["media"].uffont, 12*T.raidscale, "THINOUTLINE")
		frame:Tag(name, "[Tukui:nameshort]")
		frame.Name = name
--[[
		local leader = health:CreateTexture(nil, "OVERLAY")
		leader:Height(12*T.raidscale)
		leader:Width(12*T.raidscale)
		leader:SetPoint("TOPLEFT", 0, 6)
		frame.Leader = leader

		local LFDRole = health:CreateTexture(nil, "OVERLAY")
		LFDRole:Height(6*T.raidscale)
		LFDRole:Width(6*T.raidscale)
		LFDRole:Point("TOPRIGHT", -2, -2)
		LFDRole:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\lfdicons.blp")
		frame.LFDRole = LFDRole

		local MasterLooter = health:CreateTexture(nil, "OVERLAY")
		MasterLooter:Height(12*T.raidscale)
		MasterLooter:Width(12*T.raidscale)
		frame.MasterLooter = MasterLooter
		frame:RegisterEvent("PARTY_LEADER_CHANGED", T.MLAnchorUpdate)
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED", T.MLAnchorUpdate)
--]]
		frame.DebuffHighlightAlpha = 1
		frame.DebuffHighlightBackdrop = true
		--frame.DebuffHighlightFilter = nil

		if auraWatch then auraWatch:Kill() end
		if raidDebuffs then raidDebuffs:Kill() end
		if weakenedSoul then weakenedSoul:Kill() end

--print("Pre-RegisterFrame")
		H:RegisterFrame(frame, "TukuiHealiumGrid")
--print("Post-RegisterFrame")
	end
end

-- Import the framework
local oUF = oUFTukui or oUF

-- Avoid calling Tukui_Raid_Healing SpawnHeader -- TODO: only if Tukui_Raid_Healing
oUF:DisableFactory()

-- Delete MaxGroup handler
if TukuiRaidHealerGridMaxGroup then TukuiRaidHealerGridMaxGroup:Kill() end

-- Register init callback, will be called on each created unitframe
oUF:RegisterInitCallback(HealiumInitCallback)

-- same info as found in styles/grid.lua
local healthHeight = 27
local buttonSize = 20
local buttonByRow = 5
local buffSize = 20
local debuffSize = 20
local buttonCount = HC.general.maxButtonCount
local rowCount = math.ceil(buttonCount / buttonByRow)
--print("GRID: "..tostring(buttonCount).."  "..tostring(buttonByRow).."  "..tostring(rowCount))

local point = C.unitframes.gridvertical and "TOP" or "LEFT"
local columnAnchorPoint = C.unitframes.gridvertical and "LEFT" or "TOP"

if C["unitframes"].gridonly == true then
--if true then
	oUF:SetActiveStyle("TukuiHealR25R40")
	local raid = oUF:SpawnHeader("TukuiRaidHealerGrid", nil, "solo,raid,party",
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute('initial-width'))
			self:SetHeight(header:GetAttribute('initial-height'))
		]],
		"initial-width", T.Scale((buttonByRow*20)*T.raidscale), -- TODO: depends on button count and button size
		"initial-height", T.Scale((rowCount*20+27)*T.raidscale), -- TODO: depends on button count and button size
		"showParty", true,
		"showSolo", C["unitframes"].showsolo or true,
		"showPlayer", C["unitframes"].showplayerinparty or true, 
		"showRaid", true, 
		"xoffset", T.Scale(1), -- TODO
		"yoffset", T.Scale(-1), -- TODO
		"point", point,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"maxColumns", 8,
		"unitsPerColumn", 5,
		"columnSpacing", T.Scale(3),
		"columnAnchorPoint", columnAnchorPoint
	)
	raid:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 18, -250*T.raidscale)
else
	oUF:SetActiveStyle("TukuiHealR01R15")
	local raid = oUF:SpawnHeader("TukuiRaidHealer25", nil, "custom [@raid26,exists] hide;show", 
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute('initial-width'))
			self:SetHeight(header:GetAttribute('initial-height'))
		]],
		"initial-width", T.Scale(C["healium"]["unitframes"].width*T.raidscale),
		"initial-height", T.Scale(C["healium"]["unitframes"].height*T.raidscale),
		"showParty", true,
		"showSolo", C["unitframes"].showsolo or true,
		"showPlayer", C["unitframes"].showplayerinparty or true,
		"showRaid", true,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"yOffset", T.Scale(-4))
	raid:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 15, -300*T.raidscale)

	-- TODO: additional raid header for 25+
	oUF:SetActiveStyle("TukuiHealR25R40")
	local raidGrid = oUF:SpawnHeader("TukuiRaidHealerGrid", nil, "custom [@raid26,exists] show;hide",
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute('initial-width'))
			self:SetHeight(header:GetAttribute('initial-height'))
		]],
		"initial-width", T.Scale((buttonByRow*20)*T.raidscale), -- TODO: depends on button count and button size
		"initial-height", T.Scale((rowCount*20+27)*T.raidscale), -- TODO: depends on button count and button size
		"showParty", true,
		"showSolo", C["unitframes"].showsolo or true,
		"showPlayer", C["unitframes"].showplayerinparty or true, 
		"showRaid", true, 
		"xoffset", T.Scale(1), -- TODO
		"yoffset", T.Scale(-1), -- TODO
		"point", point,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"maxColumns", 8,
		"unitsPerColumn", 5,
		"columnSpacing", T.Scale(3),
		"columnAnchorPoint", columnAnchorPoint
	)
	raidGrid:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 18, -250*T.raidscale)
end