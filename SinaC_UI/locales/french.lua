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
	TukuiConfigUILocalization.nameplatewidth = "Largeur des barres d'infos"
	TukuiConfigUILocalization.nameplateheight = "Hauteur des barres d'infos"
	TukuiConfigUILocalization.nameplategoodscale = "Echelle de menace faible"
	TukuiConfigUILocalization.nameplatebadscale = "Echelle de menace forte"
	TukuiConfigUILocalization.nameplatecbheight = "Hauteur de la barre de lancement de sort"
	TukuiConfigUILocalization.merchantguildrepair = "R\195\169pare automatiquement avec l'argent de la guilde"
	TukuiConfigUILocalization.generalauctionatorreskin = "Reskin Auctionator"
	TukuiConfigUILocalization.generalskilletreskin = "Reskin Skillet"
	TukuiConfigUILocalization.unitframeslowthreshold = "Avertissement out-of-mana"
	TukuiConfigUILocalization.unitframesraidalphaoor = "Transparence des unit\195\169s quand hors de port\195\169e"
end