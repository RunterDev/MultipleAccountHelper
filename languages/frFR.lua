local ADDON, _ = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "frFR", false)
if not L then return end

-- Global strings
L["ADDON_FULL_NAME"] = "Multiple Account Helper"
L["ADDON_DESCRIPTION"] = "Facilite la gestion du multicompte local"

-- Friendlist Panel
L["TAB_TITLE"] = "Multi-compte"
L["SETTINGS"] = "Paramètres"
L["ACTUALIZE"] = "Actualiser"

-- Settings
L["SYNCHRONIZATION_CATEGORY_TITLE"] = "Synchronisation des comptes"
L["START_SYNCHRONIZATION"] = "Rechercher de nouveaux comptes"
L["ABOUT"] = "À propos"
L["SYNCHRONIZATION_COUNT"] = "0/7 comptes synchronisés"