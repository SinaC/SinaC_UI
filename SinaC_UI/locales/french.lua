local T, C, L = unpack(Tukui)

if T.client == "frFR" then
	L.merchant_guildrepaircost = "Tous les objets ont \195\169t\195\169 r\195\169par\195\169s par la guilde pour"

	-- ConfigUI
	if not TukuiConfigUILocalization then return end
	TukuiConfigUILocalization.unitframesshowsolo = "Afficher en mode solo"
	TukuiConfigUILocalization.nameplategoodtransitioncolor = "Couleur de gain de menace"
	TukuiConfigUILocalization.nameplatebadtransitioncolor = "Couleur de perte de menace"
	TukuiConfigUILocalization.nameplatetrackauras = "Afficher les debuffs"
	TukuiConfigUILocalization.nameplatetrackccauras = "Afficher les sorts de controles"
	TukuiConfigUILocalization.nameplateshowlevel = "Afficher le niveau"
	TukuiConfigUILocalization.nameplatewidth = "Largeur des barres d'infos"
	TukuiConfigUILocalization.nameplateheight = "Hauteur des barres d'infos"
	TukuiConfigUILocalization.nameplategoodscale = "Echelle de menace faible"
	TukuiConfigUILocalization.nameplatebadscale = "Echelle de menace forte"
	TukuiConfigUILocalization.nameplatecbheight = "Hauteur de la barre de lancement de sort"
	TukuiConfigUILocalization.merchantguildrepair = "R\195\169parer automatiquement avec l'argent de la guilde"
	TukuiConfigUILocalization.generalauctionatorreskin = "Reskin Auctionator"
	TukuiConfigUILocalization.generalskilletreskin = "Reskin Skillet"
	TukuiConfigUILocalization.unitframeslowthreshold = "Avertissement out-of-mana"
	TukuiConfigUILocalization.unitframesraidalphaoor = "Transparence des unit\195\169s quand hors de port\195\169e"
	TukuiConfigUILocalization.spechelper = "Spec helper"
	TukuiConfigUILocalization.spechelperenable = "Activer l'aide au changement de sp\195\169cialisation et \195\169quipements"
	TukuiConfigUILocalization.spechelperhovercolor = "Couleur de survol de la souris"
	TukuiConfigUILocalization.spechelperpanelcolor = "Couleur du texte pour les sp\195\169cialisation"
	TukuiConfigUILocalization.spechelperspecswitchcastbar = "Afficher une barre de sort lors d'un changement de sp\195\169cialisation"
	TukuiConfigUILocalization.spechelperenablegear = "Activer l'affichage des \195\169quipements"
	TukuiConfigUILocalization.spechelpermaxsets = "Nombre maximum d'\195\169quipements affich\195\169s"
	TukuiConfigUILocalization.spechelperautogearswap = "Activer le changement automatique d'\195\169quipement lors d'un changement de sp\195\169cialisation"
	TukuiConfigUILocalization.spechelpersetprimary = "Num\195\169ro de l'\195\169quipement pour la sp\195\169cialisation principale"
	TukuiConfigUILocalization.spechelpersetsecondary = "Num\195\169ro de l'\195\169quipement pour la sp\195\169cialisation secondaire"
	TukuiConfigUILocalization.raidbuff = "Am\195\169liorations du raid"
	TukuiConfigUILocalization.raidbuffenable = "Activer le gestionnaire d'am\195\169liorations du raid"
	TukuiConfigUILocalization.notifications = "Notifications"
	TukuiConfigUILocalization.notificationsselfbuffs = "Activer l'alerte pour les am\195\169liorations"
	TukuiConfigUILocalization.notificationsweapons = "Activer l'alerte pour les am\195\169liorations d'armes"
end