-------------------------------------------------------
-- Popup when detecting old version
-------------------------------------------------------
local ADDON_NAME, ns = ...
local SinaCUI = ns.SinaCUI
if not SinaCUI.HealiumEnabled then return end

local Private = SinaCUI.Private
local print = Private.print
local error = Private.error

local T, C, L = unpack(Tukui)

StaticPopupDialogs["SINACUIDISABLE_OLDVERSION"] = {
	text = L.healium_DISABLE_OLDVERSION,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept =
		function()
			DisableAddOn("Healium_Tukui")
			DisableAddOn("Healium_oUF")
			DisableAddOn("Healium_Tukui_SlashHandler")
			ReloadUI()
		end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}