local T, C, L = unpack(Tukui)

if T.client == "frFR" then
	L.merchant_guildrepaircost = "Tous les objets ont \195\169t\195\169 r\195\169par\195\169s par la guilde pour"

	-- ConfigUI
	if not TukuiConfigUILocalization then return end
	TukuiConfigUILocalization.unitframesshowsolo = "Affiche en mode solo"
	TukuiConfigUILocalization.nameplategoodtransitioncolor = "Couleur de gain de menace"
	TukuiConfigUILocalization.nameplatebadtransitioncolor = "Couleur de perte de menace"
	TukuiConfigUILocalization.nameplatetrackauras = "Affiche les debuffs"
	TukuiConfigUILocalization.nameplatetrackccauras = "Affiche les sorts de controles"
	TukuiConfigUILocalization.nameplateshowlevel = "Affiche le niveau"
	TukuiConfigUILocalization.merchantguildrepair = "R\195\169pare automatiquement avec l'argent de la guilde"
end