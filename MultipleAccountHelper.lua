ADDON_NAME, MAH = ...

L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
MultipleAccountHelper = LibStub("AceAddon-3.0"):NewAddon(MAH, ADDON_NAME, "AceEvent-3.0", "AceConsole-3.0")

function MultipleAccountHelper:OnInitialize()
    -- Core elements
    MultipleAccountHelper.DB.Initialize()

    -- UI elements
    MultipleAccountHelper.FriendlistPanel.Initialize()
end

function MultipleAccountHelper:OnEnable()
end