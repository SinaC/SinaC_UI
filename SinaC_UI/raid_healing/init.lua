local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui)
local SinaCUI = ns.SinaCUI
local Private = SinaCUI.Private

local print = Private.print
local error = Private.error

if IsAddOnLoaded("Tukui_Healium") then
	print("Tukui_Healium found, disabling built-in heal raidframes.")
	SinaCUI.HealiumEnabled = false
	return
end

if not IsAddOnLoaded("Tukui_Raid_Healing") then
	print("Tukui_Raid_Healing not found, no healium integration.")
	SinaCUI.HealiumEnabled = false
	return
end

if IsAddOnLoaded("Tukui_Raid") then
	print("Tukui_Raid found, no healium integration.")
	SinaCUI.HealiumEnabled = false
	return
end

if not C["unitframes"].enable == true then
	print("unitframes disabled, no healium integration.")
	SinaCUI.HealiumEnabled = false
	return
end

if not HealiumCore then
	print("HealiumCore not found, no healium integration.")
	SinaCUI.HealiumEnabled = false
	return
end

SinaCUI.HealiumEnabled = true

-- -------------------------------------------------------
-- -- Hook Tukui slash commands
-- -------------------------------------------------------
-- local SlashCmdList_TUKUIHEAL_ = SlashCmdList.TUKUIHEAL -- save old function
-- function SlashCmdList:TUKUIHEAL()
	-- --print("oUF_Healium /heal hooked function")
	-- DisableAddOn("Tukui_Raid")
	-- DisableAddOn("Tukui_Raid_Healing")
	-- EnableAddOn("Healium_Core")
	-- EnableAddOn("Healium_Tukui")
	-- ReloadUI()
-- end

-- local SlashCmdList_TUKUIDPS_ = SlashCmdList.TUKUIDPS -- save old function
-- function SlashCmdList:TUKUIDPS()
	-- --print("oUF_Healium /dps hooked function")
	-- DisableAddOn("Tukui_Raid_Healing")
	-- DisableAddOn("Healium_Core")
	-- DisableAddOn("Healium_Tukui")
	-- EnableAddOn("Tukui_Raid")
	-- ReloadUI()
-- end