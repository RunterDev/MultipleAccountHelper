MultipleAccountHelper.FriendlistPanel = LibStub("AceAddon-3.0"):NewAddon("MultipleAccountHelper.FriendlistPanel")

-- Create the tab in the contact panel to access the MAH panel
local function CreateTab()
    local tab = LibStub('SecureTabs-2.0'):Add(FriendsFrame)
    tab:SetText(L["TAB_TITLE"])
    tab.frame = MAHFriendlistPanel
end

-- Updates the view of a character panel, if connected or not
-- @param frame (Frame)
local function UpdateCharacterFrameConnectionStatus(frame)
    local accountInfo = C_BattleNet.GetGameAccountInfoByGUID(frame.characterGUID:GetText())

    if accountInfo ~= nil then
        -- Retrieving the character location in the world
        local place = L["UNKNOWN"]
        
        if accountInfo.areaName ~= nil then
            place = accountInfo.areaName
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

-- Reorganize characters in the list to show connected first, ordered by alphabetic order
function MultipleAccountHelper.FriendlistPanel.OrganizeCharacters()
    local orderedFrames = {}
    local disconnectedChars = {}

    -- Order connected first
    table.foreach(MAHAccountsListPanel.characterFrames, function (key, value)
        if MultipleAccountHelper.Utils.IsPlayerConnected(value.characterGUID:GetText()) then
            table.insert(orderedFrames, value)
        else
            table.insert(disconnectedChars, value)
        end
    end)

    table.sort(orderedFrames, function (a, b)
        return a.characterName:GetText() < b.characterName:GetText()
    end)

    table.sort(disconnectedChars, function (a, b)
        return a.characterName:GetText() < b.characterName:GetText()
    end)

    table.foreach(disconnectedChars, function (key, value)
        table.insert(orderedFrames, table.getn(orderedFrames)+1, value)
    end)

    MAHAccountsListPanel.characterFrames = orderedFrames

    local index = 0
    table.foreach(orderedFrames, function (key, value)
        value:SetPoint("TOPLEFT", MAHAccountsListPanel, "TOPLEFT", 0, -value:GetHeight() * index)
        index = index + 1
    end)
end

-- Returns the frame of one character if it exists, create it otherwise
-- @param name (string)
-- @param realm (string)
-- @param guid (string)
-- @return (Frame)
local function FindOrCreateCharacterFrameByName(name, realm, guid)
    if C_AccountInfo.IsGUIDRelatedToLocalAccount(guid) then
        return
    end

    for i = 1, table.getn(MAHAccountsListPanel.characterFrames), 1 do
        if MAHAccountsListPanel.characterFrames[i].characterName:GetText() == name and MultipleAccountHelper.Utils.TrimParenthesis(MAHAccountsListPanel.characterFrames[i].characterRealm:GetText()) == realm then
            return MAHAccountsListPanel.characterFrames[i]
        end
    end
    
    local frame = CreateFrame('Frame', nil, MAHAccountsListPanel, 'MAHAccountListElementTemplate')

    frame:SetPoint("TOPLEFT", 0, -frame:GetHeight() * table.getn(MAHAccountsListPanel.characterFrames))
    frame.characterName:SetText(name)
    frame.characterGUID:SetText(guid)
    frame.characterRealm:SetText('(' .. realm .. ')')
    frame.inviteButton.tooltipText:SetText(L["INVITE"])
    frame.inviteButton:SetScript('OnClick', function (data)
        MultipleAccountHelper.Utils.InvitePlayer(data:GetParent().characterName:GetText(), data:GetParent().characterRealm:GetText())
    end)

    table.insert(MAHAccountsListPanel.characterFrames, frame)

    return frame
end

-- Updates the view of one character in the list
-- @param name (string)
-- @param realm (string)
-- @param guid (string)
function MultipleAccountHelper.FriendlistPanel.UpdateOneCharacterPanelView(name, realm, guid)
    UpdateCharacterFrameConnectionStatus(FindOrCreateCharacterFrameByName(name, realm, guid))
end

-- Updates the view of all the characters in the list, and orders them
function MultipleAccountHelper.FriendlistPanel.UpdateCharactersPanelView()
    local characters = MultipleAccountHelper.DB.GetAllCharacters()

    if MAHAccountsListPanel.characterFrames == nil then
        MAHAccountsListPanel.characterFrames = {}
    end

    for i = 1, table.getn(characters), 1 do
        MultipleAccountHelper.FriendlistPanel.UpdateOneCharacterPanelView(characters[i].name, characters[i].realm, characters[i].guid)
    end

    MultipleAccountHelper.FriendlistPanel.OrganizeCharacters()
    MAHAccountsListPanel:SetHeight(42 * table.getn(MAHAccountsListPanel.characterFrames))
end

-- Initialize the panel
function MultipleAccountHelper.FriendlistPanel.Initialize()
    CreateTab()

    MAHFriendlistPanel:SetTitle(L["TAB_TITLE"])
    MAHFriendlistPanel:SetPortraitToAsset(GetSpellTexture(359542))
    MAHFriendlistPanel.refreshButton.tooltipText:SetText(L["ACTUALIZE"])
    MAHFriendlistPanel.massInviteButton.tooltipText:SetText(L["MASS_INVITE"])

    MAHFriendlistPanel:SetScript('OnShow', MultipleAccountHelper.FriendlistPanel.UpdateCharactersPanelView)
    MAHFriendlistPanel.refreshButton:SetScript('OnClick', MultipleAccountHelper.FriendlistPanel.UpdateCharactersPanelView)
    MAHFriendlistPanel.massInviteButton:SetScript('OnClick', MultipleAccountHelper.Utils.MassInvitePlayers)
    
    MultipleAccountHelper.FriendlistPanel.UpdateCharactersPanelView()
end