local ADDON_NAME, MAH = ...

MultipleAccountHelper.Core = LibStub("AceAddon-3.0"):NewAddon("MultipleAccountHelper.Core")

-- Function for scanning the group and return characters of the same battle.net account, but from different game account
function MultipleAccountHelper.Core.ScanGroup()
    if not IsInGroup() then
        return
    end

    local countGroupMembers = GetNumGroupMembers()
    local partyType = 'raid'

    -- If the party is a raid, the count method will be different
    if not IsInRaid() then
        countGroupMembers = countGroupMembers - 1
        partyType = 'party'
    end
    
    -- If battleTag is null, then battle.net is down, so we can't synchronize
    local presenceID, ownBtag = BNGetInfo()
    if ownBtag == nil then
        DEFAULT_CHAT_FRAME:AddMessage(L["ERROR_BNET_DOWN"], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
        return
    end

    for i = 1, countGroupMembers, 1 do
        local memberGUID = UnitGUID(partyType .. i)

        if memberGUID ~= nil then
            local memberAccountInfo = C_BattleNet.GetAccountInfoByGUID(memberGUID)
            
            -- If on different accounts but on the same bnet
            if memberAccountInfo ~= nil and (not C_AccountInfo.IsGUIDRelatedToLocalAccount(memberGUID)) and (memberAccountInfo.battleTag == ownBtag) then
                local memberName = memberAccountInfo.gameAccountInfo.characterName
                local memberRealm = memberAccountInfo.gameAccountInfo.realmName

                if memberRealm == nil then
                    memberRealm = GetRealmName()
                end

                MultipleAccountHelper.DB.SaveCharacter(memberName, memberRealm, memberGUID)
                MultipleAccountHelper.DB.SaveAccount(memberAccountInfo.gameAccountInfo.gameAccountID)
            end
        end
    end
end

function MultipleAccountHelper.Core.Initialize()
    local AceEvent = LibStub('AceEvent-3.0')

    -- Scan group each time the group is modified
    AceEvent:RegisterEvent('GROUP_ROSTER_UPDATE', MultipleAccountHelper.Core.ScanGroup)

    -- Accept automatically the invitation when player is a registered character
    AceEvent:RegisterEvent('PARTY_INVITE_REQUEST', function (event, name, isTank, isHealer, isNativeRealm, allowMultipleRoles, questSessionActive, inviterGUID)
        local accountInfo = C_BattleNet.GetGameAccountInfoByGUID(inviterGUID)

        if accountInfo ~= nil and MultipleAccountHelper.DB.CharacterExists(accountInfo.characterName, accountInfo.realmName, inviterGUID) then
            AcceptGroup()
        end
    end)
end
