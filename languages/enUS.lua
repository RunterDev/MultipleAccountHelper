local ADDON, _ = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "enUS", false)
if not L then return end

-- Global strings
L["ADDON_FULL_NAME"] = "Multiple Account Helper"
L["ADDON_DESCRIPTION"] = "Makes multiple local accounts management easier"

-- Friendlist Panel
L["TAB_TITLE"] = "Multi-account"
L["SETTINGS"] = "Settings"
L["ACTUALIZE"] = "Refresh"

-- Settings
L["SYNCHRONIZATION_CATEGORY_TITLE"] = "Accounts synchronisation"
L["START_SYNCHRONIZATION"] = "Scan for new accounts"
L["ABOUT"] = "About"
L["SYNCHRONIZATION_COUNT"] = "0/7 accounts synchronized"
