local ADDON, _ = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "frFR", false)
if not L then return end

-- Friendlist Panel
L["TAB_TITLE"] = "Multi-compte"
L["ACTUALIZE"] = "Actualiser"
L["MASS_INVITE"] = "Invitation de masse"
L["INVITE"] = "Inviter le personnage"
L["OFFLINE"] = "Hors ligne"
L["UNKNOWN"] = "Inconnu"

-- Error messages
L["ERROR_BNET_DOWN"] = "MultipleAccountHelper : Impossible de synchroniser les personnages à cause d'un problème interne de Battle.net"
