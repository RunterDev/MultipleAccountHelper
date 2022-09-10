local ADDON_NAME, MAH = ...

MultipleAccountHelper.Utils = LibStub("AceAddon-3.0"):NewAddon("MultipleAccountHelper.Utils")

-- Removes parenthesis around text
function MultipleAccountHelper.Utils.TrimParenthesis(text)
    text = text:gsub('%(', '')
    return text:gsub('%)', '')
end

-- Format player name to return usable Name-Realm
function MultipleAccountHelper.Utils.FormatPlayerName(name, realm)
    return Ambiguate(name .. '-' .. MultipleAccountHelper.Utils.TrimParenthesis(realm), 'all')
end

-- Invites player
function MultipleAccountHelper.Utils.InvitePlayer(name, realm)
    C_PartyInfo.InviteUnit(MultipleAccountHelper.Utils.FormatPlayerName(name, realm))
end

-- Check if player is connected
function MultipleAccountHelper.Utils.IsPlayerConnected(guid)
    return C_BattleNet.GetGameAccountInfoByGUID(guid) ~= nil
end

-- Mass invite all registered characters
function MultipleAccountHelper.Utils.MassInvitePlayers()
    table.foreach(MultipleAccountHelper.DB.GetAllCharacters(), function (key, characterTable)
        if MultipleAccountHelper.Utils.IsPlayerConnected(characterTable.guid) then
            MultipleAccountHelper.Utils.InvitePlayer(characterTable.name, characterTable.realm)
        end
    end)
end
