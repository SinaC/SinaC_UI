local ADDON_NAME, ns = ...

local T, C, L = unpack(Tukui)
local H = unpack(HealiumCore)

if not H or not C["unitframes"].enable == true then
	ns.HealiumEnabled = false
	return
end
ns.HealiumEnabled = true

-- TODO
-- for i = 1, 4 do
	-- local pet = _G["oUF_TukuiPartyPet"..i]
	-- if pet then
		-- pet:Kill() -- pet:Disable
	-- end
-- end

--------------------------------------------------------------
-- Edit Unit Raid Frames here!
--------------------------------------------------------------
-- -- 1 second delay before edited skin apply (can probably be a lower because 1 second is really too long, 0.1 or 0.2 should be the best, setting it to 1 was just for testing, CANNOT BE 0)
-- local delay = 1 

function T.PostUpdateRaidUnit(frame, unit, header)
	local health = frame.Health
	local power = frame.Power
	local panel = frame.panel
	local debuffs = frame.Debuffs
	local raidDebuffs = frame.RaidDebuffs
	local weakenedSoul = frame.WeakenedSoul
	local auraWatch = frame.AuraWatch

	-- for layout-specifics, here we edit only 1 layout at time
	if header == "TukuiRaidHealer15" then
		frame.DebuffHighlightAlpha = 1
		frame.DebuffHighlightBackdrop = true
		--frame.DebuffHighlightFilter = false -- depends on Healium settings
		--frame.SetBackdropColor = T.dummy
		debuffs:Kill()

		if weakenedSoul then weakenedSoul:Kill() end

		H:RegisterFrame(frame, "TukuiHealiumNormal")
	elseif header == "TukuiRaidHealerGrid" then
		health:ClearAllPoints()
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:Height(27*T.raidscale)

		health.value:Kill()
		health.PostUpdate = T.Dummy

		power:Width(3*T.raidscale)
		power:Height(27*T.raidscale)
		power:ClearAllPoints()
		power:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 1)
		power:SetStatusBarTexture(normTex)
		power:SetOrientation("VERTICAL")
		power:SetFrameLevel(9)

		panel:Kill()

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

		frame.DebuffHighlightAlpha = nil
		frame.DebuffHighlightBackdrop = nil
		frame.DebuffHighlightFilter = nil

		if auraWatch then auraWatch:Kill() end
		if raidDebuffs then raidDebuffs:Kill() end
		if weakenedSoul then weakenedSoul:Kill() end

		H:RegisterFrame(frame, "TukuiHealiumGrid")
	end
end

local function EditUnitAttributes(layout)
	local header = _G[layout]
	local healmax15 = layout:match("Healer15")
	local grid = layout:match("HealerGrid")

	if healmax15 then
		if C["unitframes"].gridonly ~= true then
			RegisterAttributeDriver(header, "state-visiblity", "custom [@raid26, exists] hide;show")
			header:SetAttribute("showSolo", C["unitframes"].showsolo or true)
			header:SetAttribute("initial-width", C["healium"]["unitframes"].width)
			header:SetAttribute("initial-height", C["healium"]["unitframes"].height)
		end
	elseif grid then
		if C["unitframes"].gridonly ~= true then
			RegisterAttributeDriver(header, "state-visiblity", "custom [@raid26, exists] show;hide")
		else
			RegisterAttributeDriver(header, "state-visiblity", "raid,party,solo")
		end
		local point = C.unitframes.gridvertical and "TOP" or "LEFT"
		local columnAnchorPoint = C.unitframes.gridvertical and "LEFT" or "TOP"
		-- TODO
		header:SetAttribute("showSolo", C["unitframes"].showsolo or true)
		header:SetAttribute("initial-width", 90)
		header:SetAttribute("initial-height", 90)
		header:SetAttribute("xOffset", T.Scale(1))
		header:SetAttribute("yOffset", T.Scale(-1))
		header:SetAttribute("unitsPerColumn", 5)
		header:SetAttribute("columnSpacing", T.Scale(3))
		header:SetAttribute("columnAnchorPoint", columnAnchorPoint)
		header:SetAttribute("point", point)
	end
end

--------------------------------------------------------------
-- Stop Editing!
--------------------------------------------------------------

-- import the framework
local oUF = oUFTukui or oUF

local function InitScript()
	local children
	local heal = IsAddOnLoaded("Tukui_Raid_Healing")
	local dps = IsAddOnLoaded("Tukui_Raid")

	-- don't need to load, because we will reload anyway after user select their layout
	if heal and dps then return end

	-- local function UpdateRaidUnitSize(frame, header)
		-- frame:SetSize(header:GetAttribute("initial-width"), header:GetAttribute("initial-height"))
	-- end

	-- local GetActiveHeader = function()
		-- local players = (GetNumPartyMembers() + 1)

		-- if UnitInRaid("player") then
			-- players = GetNumRaidMembers()
		-- end

		-- if heal then
			-- if C["unitframes"].gridonly then
				-- return TukuiRaidHealerGrid
			-- else
				-- if players <= 15 then
					-- return TukuiRaidHealer15
				-- else
					-- return TukuiRaidHealerGrid
				-- end
			-- end
		-- elseif dps then
			-- if players <= 25 then
				-- return TukuiRaid25
			-- elseif players > 25 then
				-- return TukuiRaid40
			-- end
		-- end
	-- end

	-- local function Update(frame, header, event)
		-- if (frame and frame.unit) then
			-- local isEdited = frame.isEdited

			-- -- we need to update size of every raid frames if already in raid when we enter world (or /rl)
			-- if event == "PLAYER_ENTERING_WORLD" then
				-- UpdateRaidUnitSize(frame, header)
			-- end
			
			-- -- we check for "isEdited" here because we don't want to edit every frame
			-- -- every time a member join the raid else it will cause high cpu usage
			-- -- and could cause screen freezing
			-- if not frame.isEdited then
				-- EditUnitFrame(frame, header)
				-- frame.isEdited = true
			-- end
		-- end
	-- end

	-- local function Skin(header, event)
		-- children = {header:GetChildren()}

		-- for _, frame in pairs(children) do
			-- Update(frame, header, event)
		-- end	
	-- end

	-- local StyleRaidFrames = function(self, event)
		-- local header = GetActiveHeader()
		-- -- make sure we... catch them all! (I feel pikachu inside me)
		-- -- we add a delay to make sure latest created unit is catched.
		-- T.Delay(delay, function() Skin(header, event) end)
	-- end

	-- init, here we modify the initial Config.
	local function SpawnHeader(name, layout, visibility, ...)
		EditUnitAttributes(layout)
	end

	-- this is the function oUF framework use to create and set attributes to headers
	hooksecurefunc(oUF, "SpawnHeader", SpawnHeader)

	-- local style = CreateFrame("Frame")
	-- style:RegisterEvent("PLAYER_ENTERING_WORLD")
	-- style:RegisterEvent("PARTY_MEMBERS_CHANGED")
	-- style:RegisterEvent("RAID_ROSTER_UPDATE")
	-- style:SetScript("OnEvent", StyleRaidFrames)
end

local script = CreateFrame("Frame")
script:RegisterEvent("ADDON_LOADED")
script:SetScript("OnEvent", function(self, event, addon)
	if addon == "Tukui_Raid_Healing" then
		InitScript()
	elseif addon == ADDON_NAME then
		-- Initialize Healium
		H:Initialize(C["healium"])
		-- Display version
		local libVersion = GetAddOnMetadata("Healium_Core", "Version")
		if libVersion then
			print(string.format(L.healium_GREETING_VERSION, tostring(libVersion)))
		else
			print(L.healium_GREETING_VERSIONUNKNOWN)
		end
		print(L.healium_GREETING_OPTIONS)
	end
end)