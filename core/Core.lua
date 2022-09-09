local ADDON_NAME, MAH = ...

MultipleAccountHelper.Core = LibStub("AceAddon-3.0"):NewAddon("MultipleAccountHelper.Core")

local function TrimParenthesis(text)
    text = text:gsub('%(', '')
    return text:gsub('%)', '')
end

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
                local memberName, memberRealm = UnitFullName(partyType .. i)

                if memberRealm == nil then
                    memberRealm = GetRealmName()
                end

                MultipleAccountHelper.DB.SaveCharacter(memberName, memberRealm)
                MultipleAccountHelper.DB.SaveAccount(memberAccountInfo.gameAccountInfo.gameAccountID)
            end
        end
    end
end

function MultipleAccountHelper.Core.FormatPlayerName(name, realm)
    return Ambiguate(name .. '-' .. TrimParenthesis(realm), 'all')
end

function MultipleAccountHelper.Core.InvitePlayer(name, realm)
    C_PartyInfo.InviteUnit(MultipleAccountHelper.Core.FormatPlayerName(name, realm))
end
