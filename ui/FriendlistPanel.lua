MultipleAccountHelper.FriendlistPanel = LibStub("AceAddon-3.0"):NewAddon("MultipleAccountHelper.FriendlistPanel")

local function TrimParenthesis(text)
    text = text:gsub('%(', '')
    return text:gsub('%)', '')
end

local function CreateTab()
    local tab = LibStub('SecureTabs-2.0'):Add(FriendsFrame)
    tab:SetText(L["TAB_TITLE"])
    tab.frame = MAHFriendlistPanel
end

local function UpdateCharacterFrameConnectionStatus(frame)
    if UnitIsConnected(MultipleAccountHelper.Core.FormatPlayerName(frame.characterName:GetText(), frame.characterRealm:GetText())) then
        -- Retrieving the character location in the world
        local guid = UnitGUID(MultipleAccountHelper.Core.FormatPlayerName(frame.characterName:GetText(), frame.characterRealm:GetText()))
        local place = L["UNKNOWN"]
        
        if guid ~= nil then
            if C_BattleNet.GetGameAccountInfoByGUID(guid).areaName ~= nil then
                place = C_BattleNet.GetGameAccountInfoByGUID(guid).areaName
            end
        end

        frame.connectedDot:SetTextColor(0.2, 0.8, 0.2, 1)
        frame.characterName:SetFontObject('GameFontHighlightLarge')
        frame.characterZone:SetText(place)
        frame.characterZone:SetFontObject('GameFontNormalSmall')
        frame.characterRealm:SetFontObject('GameFontNormalSmall')
        frame.inviteButton:Enable()
    else
        frame.connectedDot:SetTextColor(0.5, 0.5, 0.5, 1)
        frame.characterName:SetFontObject('GameFontDisableLarge')
        frame.characterZone:SetText(L["OFFLINE"])
        frame.characterZone:SetFontObject('GameFontDisableSmall')
        frame.characterRealm:SetFontObject('GameFontDisableSmall')
        frame.inviteButton:Disable()
    end
end

local function FindOrCreateCharacterFrameByName(name, realm)
    for i = 1, table.getn(MAHAccountsListPanel.characterFrames), 1 do
        if MAHAccountsListPanel.characterFrames[i].characterName:GetText() == name and TrimParenthesis(MAHAccountsListPanel.characterFrames[i].characterRealm:GetText()) == realm then
            UpdateCharacterFrameConnectionStatus(MAHAccountsListPanel.characterFrames[i])
            return MAHAccountsListPanel.characterFrames[i]
        end
    end

    local frame = CreateFrame('Frame', nil, MAHAccountsListPanel, 'MAHAccountListElementTemplate')

    frame:SetPoint("TOPLEFT", 0, -frame:GetHeight() * (table.getn(MAHAccountsListPanel.characterFrames)-1))
    frame.characterName:SetText(name)
    frame.characterRealm:SetText('(' .. realm .. ')')
    frame.inviteButton.tooltipText:SetText(L["INVITE"])
    frame.inviteButton:SetScript('OnClick', function (data)
        MultipleAccountHelper.Core.InvitePlayer(data:GetParent().characterName:GetText(), data:GetParent().characterRealm:GetText())
    end)

    UpdateCharacterFrameConnectionStatus(frame)

    table.insert(MAHAccountsListPanel.characterFrames, frame)

    MAHAccountsListPanel:SetHeight(42 * table.getn(MAHAccountsListPanel.characterFrames))

    return frame
end

function MultipleAccountHelper.FriendlistPanel.UpdateCharactersPanelView()
    local characters = MultipleAccountHelper.DB.GetAllCharacters()

    if MAHAccountsListPanel.characterFrames == nil then
        MAHAccountsListPanel.characterFrames = {}
    end

    for i = 1, table.getn(characters), 1 do
        FindOrCreateCharacterFrameByName(characters[i].name, characters[i].realm)
    end
end

function MultipleAccountHelper.FriendlistPanel.Initialize()
    CreateTab()

    MAHFriendlistPanel:SetTitle(L["TAB_TITLE"])
    MAHFriendlistPanel:SetPortraitToAsset(GetSpellTexture(359542))
    MAHFriendlistPanel.refreshButton.tooltipText:SetText(L["ACTUALIZE"])
    MAHFriendlistPanel.massInviteButton.tooltipText:SetText(L["MASS_INVITE"])

    MAHFriendlistPanel.refreshButton:SetScript('OnClick', MultipleAccountHelper.FriendlistPanel.UpdateCharactersPanelView)

    MultipleAccountHelper.FriendlistPanel.UpdateCharactersPanelView()
end