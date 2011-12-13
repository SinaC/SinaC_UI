-------------------------------------------------------
-- Popup when detecting old version
-------------------------------------------------------
local ADDON_NAME, ns = ...
if not ns.HealiumEnabled then return end

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