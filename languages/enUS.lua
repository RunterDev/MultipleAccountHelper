local ADDON, _ = ...

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON, "enUS", false)
if not L then return end

-- Friendlist Panel
L["TAB_TITLE"] = "Multi-account"
L["ACTUALIZE"] = "Refresh"
L["MASS_INVITE"] = "Mass invitation"
L["INVITE"] = "Invite character"
L["OFFLINE"] = "Offline"
L["UNKNOWN"] = "Unknown"

-- Error messages
L["ERROR_BNET_DOWN"] = "MultipleAccountHelper : Unable to synchronize characters due to an internal Battle.net issue"
