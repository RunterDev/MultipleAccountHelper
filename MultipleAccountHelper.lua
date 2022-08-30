local ADDON_NAME, MAH = ...
local MultipleAccountHelper = LibStub("AceAddon-3.0"):NewAddon(MAH, ADDON_NAME, "AceConsole-3.0")

local connectedCharacters = {};

local function RegisterEvents()
    local AceEvent = LibStub("AceEvent-3.0");
    local AceComm = LibStub("AceComm-3.0");

    AceEvent:RegisterEvent("PLAYER_LOGOUT", function ()
        
    end)

    AceEvent:RegisterEvent("PLAYER_LOGOUT", function ()
        
    end)
end

function MultipleAccountHelper:OnInitialize()
    local AceConsole = LibStub("AceConsole-3.0");

    AceConsole:RegisterChatCommand("mah", function ()
        MAH:ToogleSettingsPanel()
    end)
end

function MultipleAccountHelper:OnEnable()
    RegisterEvents()
    self:CreateSettingsPanel()
    self:CreateFriendlistPanel()
end

